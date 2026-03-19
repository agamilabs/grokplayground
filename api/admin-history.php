<?php
/**
 * Admin History API - View all users' generation history
 * GET: Returns all generations with pagination and filters (admin only)
 *
 * Query params:
 *   page      (int)    - page number (default 1)
 *   limit     (int)    - items per page (default 20, max 50)
 *   type      (string) - filter by generation type
 *   date_from (string) - filter from date (YYYY-MM-DD)
 *   date_to   (string) - filter to date (YYYY-MM-DD)
 *   user_id   (int)    - filter by user ID
 *   search    (string) - search by user email or prompt
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

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
    exit;
}

$page = max(1, (int) ($_GET['page'] ?? 1));
$limit = min(50, max(1, (int) ($_GET['limit'] ?? 20)));
$offset = ($page - 1) * $limit;

$conditions = ["1=1"];
$params = [];

// Type filter
$type = $_GET['type'] ?? '';
$validTypes = ['text_to_image', 'image_to_video', 'text_to_video'];
if ($type && in_array($type, $validTypes)) {
    $conditions[] = "g.type = ?";
    $params[] = $type;
}

// Date filters
$dateFrom = $_GET['date_from'] ?? '';
if ($dateFrom && preg_match('/^\d{4}-\d{2}-\d{2}$/', $dateFrom)) {
    $conditions[] = "DATE(g.created_at) >= ?";
    $params[] = $dateFrom;
}

$dateTo = $_GET['date_to'] ?? '';
if ($dateTo && preg_match('/^\d{4}-\d{2}-\d{2}$/', $dateTo)) {
    $conditions[] = "DATE(g.created_at) <= ?";
    $params[] = $dateTo;
}

// User filter
$userId = $_GET['user_id'] ?? '';
if ($userId && is_numeric($userId)) {
    $conditions[] = "g.user_id = ?";
    $params[] = (int) $userId;
}

// Search
$search = trim($_GET['search'] ?? '');
if ($search) {
    $conditions[] = "(u.email LIKE ? OR g.prompt LIKE ?)";
    $params[] = "%$search%";
    $params[] = "%$search%";
}

$where = implode(' AND ', $conditions);

// Total count
$stmt = $db->prepare("SELECT COUNT(*) as total FROM generations g JOIN users u ON g.user_id = u.id WHERE $where");
$stmt->execute($params);
$total = (int) $stmt->fetch()['total'];

// Generations with user info
$stmt = $db->prepare(
    "SELECT g.id, g.type, g.prompt, g.output_url, g.status, g.credits_used, g.created_at,
            u.email, u.display_name, u.id as uid
     FROM generations g
     JOIN users u ON g.user_id = u.id
     WHERE $where
     ORDER BY g.created_at DESC
     LIMIT ? OFFSET ?"
);
$params[] = $limit;
$params[] = $offset;
$stmt->execute($params);
$generations = $stmt->fetchAll();

// Get list of users for filter dropdown
$users = $db->query("SELECT id, email, display_name FROM users ORDER BY email")->fetchAll();

echo json_encode([
    'generations' => $generations,
    'users' => $users,
    'total' => $total,
    'page' => $page,
    'pages' => (int) ceil($total / $limit),
]);
