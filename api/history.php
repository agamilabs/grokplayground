<?php
/**
 * Generation History API
 * GET: Returns the user's past generations (paginated, filterable)
 * 
 * Query params:
 *   page     (int)    - page number (default 1)
 *   limit    (int)    - items per page (default 20, max 50)
 *   type     (string) - filter by generation type (text_to_image, image_to_video, text_to_video)
 *   date_from (string) - filter from date (YYYY-MM-DD)
 *   date_to   (string) - filter to date (YYYY-MM-DD)
 */
header('Content-Type: application/json');
require_once __DIR__ . '/../auth.php';

$user = authenticateRequest();
$db = getDB();

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
    exit;
}

$page = max(1, (int) ($_GET['page'] ?? 1));
$limit = min(50, max(1, (int) ($_GET['limit'] ?? 20)));
// Support explicit offset for chat pagination
$offset = isset($_GET['offset']) ? (int) $_GET['offset'] : ($page - 1) * $limit;

// Build filter conditions
$conditions = ["user_id = ?"];
$params = [$user['id']];

// Type filter
$type = $_GET['type'] ?? '';
$validTypes = ['text_to_image', 'image_edit', 'image_to_video', 'text_to_video', 'text_to_audio'];
if ($type && in_array($type, $validTypes)) {
    if ($type === 'text_to_image') {
        // When filtering for images, show both original image and edits
        $conditions[] = "(type = 'text_to_image' OR type = 'image_edit')";
    } else {
        $conditions[] = "type = ?";
        $params[] = $type;
    }
}

// Date filters
$dateFrom = $_GET['date_from'] ?? '';
if ($dateFrom && preg_match('/^\d{4}-\d{2}-\d{2}$/', $dateFrom)) {
    $conditions[] = "DATE(created_at) >= ?";
    $params[] = $dateFrom;
}

$dateTo = $_GET['date_to'] ?? '';
if ($dateTo && preg_match('/^\d{4}-\d{2}-\d{2}$/', $dateTo)) {
    $conditions[] = "DATE(created_at) <= ?";
    $params[] = $dateTo;
}

$where = implode(' AND ', $conditions);

// Get total count
$stmt = $db->prepare("SELECT COUNT(*) as total FROM generations WHERE $where");
$stmt->execute($params);
$total = (int) $stmt->fetch()['total'];

// Get generations
$stmt = $db->prepare(
    "SELECT id, type, prompt, input_url, input_thumbnail, output_url, status, resolution, credits_used, created_at, xai_request_id 
     FROM generations WHERE $where ORDER BY created_at DESC LIMIT ? OFFSET ?"
);
$params[] = $limit;
$params[] = $offset;
$stmt->execute($params);
$generations = $stmt->fetchAll();

echo json_encode([
    'generations' => $generations,
    'total' => $total,
    'page' => $page,
    'pages' => (int) ceil($total / $limit),
    'filters' => [
        'type' => $type ?: null,
        'date_from' => $dateFrom ?: null,
        'date_to' => $dateTo ?: null,
    ],
]);
