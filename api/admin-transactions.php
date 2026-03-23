<?php
/**
 * Admin Transactions API
 * GET: Returns all transactions with pagination and filters (admin only)
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
$validTypes = ['purchase', 'spend', 'gift_sent', 'gift_received'];
if ($type && in_array($type, $validTypes)) {
    $conditions[] = "t.type = ?";
    $params[] = $type;
}

// User filter
$userId = $_GET['user_id'] ?? '';
if ($userId && is_numeric($userId)) {
    $conditions[] = "t.user_id = ?";
    $params[] = (int) $userId;
}

// Search
$search = trim($_GET['search'] ?? '');
if ($search) {
    $conditions[] = "(u.email LIKE ? OR t.description LIKE ? OR t.bkash_trx_id LIKE ?)";
    $params[] = "%$search%";
    $params[] = "%$search%";
    $params[] = "%$search%";
}

$where = implode(' AND ', $conditions);

// Total count
$stmt = $db->prepare("SELECT COUNT(*) as total FROM transactions t JOIN users u ON t.user_id = u.id WHERE $where");
$stmt->execute($params);
$total = (int) $stmt->fetch()['total'];

// Transactions
$stmt = $db->prepare(
    "SELECT t.*, u.email, u.display_name 
     FROM transactions t 
     JOIN users u ON t.user_id = u.id 
     WHERE $where 
     ORDER BY t.created_at DESC 
     LIMIT ? OFFSET ?"
);
$params[] = $limit;
$params[] = $offset;
$stmt->execute($params);
$transactions = $stmt->fetchAll();

echo json_encode([
    'transactions' => $transactions,
    'total' => $total,
    'page' => $page,
    'pages' => (int) ceil($total / $limit)
]);
