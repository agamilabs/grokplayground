<?php
/**
 * Admin User Management API
 * GET:  List users with search and pagination (admin only)
 * POST: Perform actions on users (e.g. update_credits)
 */
header('Content-Type: application/json');
require_once __DIR__ . '/../auth.php';

$user = authenticateRequest();

// Admin check
if (!(int) $user['is_admin']) {
    http_response_code(403);
    echo json_encode(['error' => 'Admin access required']);
    exit;
}

$db = getDB();

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $page = max(1, (int) ($_GET['page'] ?? 1));
    $limit = min(50, max(1, (int) ($_GET['limit'] ?? 20)));
    $offset = ($page - 1) * $limit;
    $search = trim($_GET['search'] ?? '');

    $conditions = ["1=1"];
    $params = [];

    if ($search) {
        $conditions[] = "(email LIKE ? OR display_name LIKE ?)";
        $params[] = "%$search%";
        $params[] = "%$search%";
    }

    $where = implode(' AND ', $conditions);

    // Total count
    $stmt = $db->prepare("SELECT COUNT(*) as total FROM users WHERE $where");
    $stmt->execute($params);
    $total = (int) $stmt->fetch()['total'];

    // Users
    $stmt = $db->prepare("SELECT id, email, display_name, photo_url, credits, is_admin, created_at 
                          FROM users WHERE $where ORDER BY created_at DESC LIMIT ? OFFSET ?");
    $params[] = $limit;
    $params[] = $offset;
    $stmt->execute($params);
    $users = $stmt->fetchAll();

    echo json_encode([
        'users' => $users,
        'total' => $total,
        'page' => $page,
        'pages' => (int) ceil($total / $limit)
    ]);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = json_decode(file_get_contents('php://input'), true);
    $action = $input['action'] ?? '';

    if ($action === 'update_credits') {
        $targetUserId = (int) ($input['user_id'] ?? 0);
        $newCredits = (int) ($input['credits'] ?? 0);
        $reason = $input['reason'] ?? 'Admin adjustment';

        if (!$targetUserId) {
            http_response_code(400);
            echo json_encode(['error' => 'User ID is required']);
            exit;
        }

        // Get current credits for transaction log
        $stmt = $db->prepare("SELECT credits FROM users WHERE id = ?");
        $stmt->execute([$targetUserId]);
        $row = $stmt->fetch();
        if (!$row) {
            http_response_code(404);
            echo json_encode(['error' => 'User not found']);
            exit;
        }
        $currentCredits = $row['credits'];
        $diff = $newCredits - $currentCredits;

        $db->beginTransaction();
        try {
            $stmt = $db->prepare("UPDATE users SET credits = ? WHERE id = ?");
            $stmt->execute([$newCredits, $targetUserId]);

            // Record transaction
            $type = $diff >= 0 ? 'gift_received' : 'spend';
            $stmt = $db->prepare("INSERT INTO transactions (user_id, type, credits, description) VALUES (?, ?, ?, ?)");
            $stmt->execute([$targetUserId, $type, $diff, $reason]);

            $db->commit();
            echo json_encode(['success' => true, 'new_credits' => $newCredits]);
        } catch (Exception $e) {
            $db->rollBack();
            http_response_code(500);
            echo json_encode(['error' => $e->getMessage()]);
        }
        exit;
    }
}

http_response_code(405);
echo json_encode(['error' => 'Method not allowed']);
