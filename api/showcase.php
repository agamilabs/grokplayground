<?php
/**
 * Showcase API (Public)
 * GET: List showcase items with filters/pagination
 * POST: Upvote/Downvote items
 */
header('Content-Type: application/json');
require_once __DIR__ . '/../auth.php';

$method = $_SERVER['REQUEST_METHOD'];
$db = getDB();

if ($method === 'GET') {
    $type = $_GET['type'] ?? '';
    $categoryId = (int) ($_GET['category_id'] ?? 0);
    $query = $_GET['q'] ?? '';
    $sort = $_GET['sort'] ?? 'newest'; // newest, top
    $page = max(1, (int) ($_GET['page'] ?? 1));
    $limit = max(1, min(100, (int) ($_GET['limit'] ?? 20)));
    $offset = ($page - 1) * $limit;

    $where = [];
    $params = [];

    if ($type) {
        $where[] = "type = ?";
        $params[] = $type;
    }
    if ($categoryId) {
        $where[] = "category_id = ?";
        $params[] = $categoryId;
    }
    if ($query) {
        $where[] = "(title LIKE ? OR prompt LIKE ? OR description LIKE ?)";
        $search = "%$query%";
        $params[] = $search;
        $params[] = $search;
        $params[] = $search;
    }

    $whereSql = count($where) > 0 ? "WHERE " . implode(" AND ", $where) : "";
    $orderSql = $sort === 'top' ? "ORDER BY votes DESC, created_at DESC" : "ORDER BY created_at DESC";

    // Count total
    $countStmt = $db->prepare("SELECT COUNT(*) FROM showcase_items $whereSql");
    $countStmt->execute($params);
    $totalItems = $countStmt->fetchColumn();
    $totalPages = ceil($totalItems / $limit);

    // Fetch items
    $user = getAuthenticatedUser();
    $userId = $user ? $user['id'] : 0;
    
    $stmt = $db->prepare("SELECT i.*, c.name as category_name, v.vote as user_vote
                          FROM showcase_items i 
                          LEFT JOIN showcase_categories c ON i.category_id = c.id
                          LEFT JOIN showcase_votes v ON (i.id = v.item_id AND v.user_id = ?)
                          $whereSql $orderSql LIMIT $limit OFFSET $offset");
    
    $fetchParams = array_merge([$userId], $params);
    $stmt->execute($fetchParams);
    $items = $stmt->fetchAll();

    echo json_encode([
        'success' => true,
        'items' => $items,
        'pagination' => [
            'current_page' => $page,
            'total_pages' => $totalPages,
            'total_items' => $totalItems
        ]
    ]);

} elseif ($method === 'POST') {
    $user = authenticateRequest();
    $data = json_decode(file_get_contents('php://input'), true);
    $itemId = (int) ($data['item_id'] ?? 0);
    $direction = (int) ($data['vote'] ?? 0); // 1 or -1

    if (!$itemId || !in_array($direction, [1, -1])) {
        http_response_code(400);
        echo json_encode(['error' => 'Invalid vote data']);
        exit;
    }

    try {
        $db->beginTransaction();

        // Check for existing vote
        $stmt = $db->prepare("SELECT vote FROM showcase_votes WHERE user_id = ? AND item_id = ?");
        $stmt->execute([$user['id'], $itemId]);
        $existing = $stmt->fetch();

        if ($existing) {
            if ($existing['vote'] == $direction) {
                // Remove vote if clicking same button
                $stmt = $db->prepare("DELETE FROM showcase_votes WHERE user_id = ? AND item_id = ?");
                $stmt->execute([$user['id'], $itemId]);
                $voteChange = -$direction;
            } else {
                // Change vote
                $stmt = $db->prepare("UPDATE showcase_votes SET vote = ? WHERE user_id = ? AND item_id = ?");
                $stmt->execute([$direction, $user['id'], $itemId]);
                $voteChange = $direction * 2;
            }
        } else {
            // New vote
            $stmt = $db->prepare("INSERT INTO showcase_votes (user_id, item_id, vote) VALUES (?, ?, ?)");
            $stmt->execute([$user['id'], $itemId, $direction]);
            $voteChange = $direction;
        }

        // Update total votes
        $stmt = $db->prepare("UPDATE showcase_items SET votes = votes + ? WHERE id = ?");
        $stmt->execute([$voteChange, $itemId]);

        $db->commit();
        
        // Return new vote count and current user's vote state
        $stmt = $db->prepare("SELECT votes FROM showcase_items WHERE id = ?");
        $stmt->execute([$itemId]);
        $newVotes = $stmt->fetchColumn();

        $stmt = $db->prepare("SELECT vote FROM showcase_votes WHERE user_id = ? AND item_id = ?");
        $stmt->execute([$user['id'], $itemId]);
        $currentVote = $stmt->fetchColumn() ?: 0;

        echo json_encode([
            'success' => true, 
            'new_votes' => $newVotes,
            'current_vote' => $currentVote
        ]);
    } catch (Exception $e) {
        $db->rollBack();
        http_response_code(500);
        echo json_encode(['error' => 'Voting failed: ' . $e->getMessage()]);
    }
}
