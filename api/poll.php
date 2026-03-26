<?php
/**
 * Video Polling Endpoint
 * GET: api/poll.php?id={generation_id}
 */
header('Content-Type: application/json');
require_once __DIR__ . '/../auth.php';

$user = authenticateRequest();
$db = getDB();

// Support both POST (JSON) and GET
// If it's a POST, we strictly look at the JSON payload
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = json_decode(file_get_contents('php://input'), true);
    $generationId = $input['generation_id'] ?? $input['id'] ?? null;
    $requestId = $input['request_id'] ?? null;
} else {
    $generationId = $_GET['generation_id'] ?? $_GET['id'] ?? null;
    $requestId = $_GET['request_id'] ?? null;
}

if (!$generationId && !$requestId) {
    http_response_code(400);
    echo json_encode(['error' => 'Generation ID or Request ID is required in the payload']);
    exit;
}

// Get the generation record
if ($generationId) {
    $stmt = $db->prepare("SELECT * FROM generations WHERE id = ? AND user_id = ?");
    $stmt->execute([$generationId, $user['id']]);
} else {
    $stmt = $db->prepare("SELECT * FROM generations WHERE xai_request_id = ? AND user_id = ?");
    $stmt->execute([$requestId, $user['id']]);
}
$generation = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$generation) {
    http_response_code(404);
    echo json_encode(['error' => 'Generation not found']);
    exit;
}
$generationId = $generation['id'];

if ($generation['status'] !== 'processing') {
    // Already finished or failed
    echo json_encode([
        'id' => $generation['id'],
        'status' => $generation['status'],
        'output_url' => $generation['output_url']
    ]);
    exit;
}

// We need an xai_request_id to poll
$requestId = $generation['xai_request_id'];
if (!$requestId) {
    http_response_code(400);
    echo json_encode(['error' => 'No request ID associated with this generation']);
    exit;
}

// Poll xAI API
// For video generations, the status check endpoint is /v1/videos/{request_id}
$response = xaiRequest('GET', '/videos/' . $requestId);

if (isset($response['error'])) {
    $errorMsg = $response['error'];
    $httpCode = $response['http_code'] ?? 500;
    
    // If it's a 404, the request might be too new or expired
    if ($httpCode === 404) {
        // According to documentation, we stay in processing while it's not yet indexed
        echo json_encode(['status' => 'processing', 'info' => 'Task not yet available']);
        exit;
    }

    // For any other error (invalid_argument, etc.), mark as failed in DB
    $stmt = $db->prepare("UPDATE generations SET status = 'failed' WHERE id = ?");
    $stmt->execute([$generationId]);

    echo json_encode(['error' => $errorMsg, 'status' => 'failed']);
    exit;
}

$decoded = $response;
if (!$decoded) {
    echo json_encode(['status' => 'processing']);
    exit;
}

// Checking status (xAI uses lowercase: pending, done, failed, expired)
$status = strtolower($decoded['status'] ?? $decoded['state'] ?? 'pending');

if ($status === 'done' || $status === 'completed') {
    $outputUrl = $decoded['video']['url'] ?? $decoded['url'] ?? $decoded['video_url'] ?? null;

    if ($outputUrl) {
        $localFile = downloadToLocal($outputUrl);
        $finalUrl = $localFile ? $localFile['url'] : $outputUrl;
        $outputSize = $localFile ? $localFile['size'] : 0;

        $stmt = $db->prepare("UPDATE generations SET status = 'completed', output_url = ?, output_size = ? WHERE id = ?");
        $stmt->execute([$finalUrl, $outputSize, $generationId]);

        echo json_encode([
            'id' => $generationId,
            'status' => 'completed',
            'output_url' => $finalUrl,
            'output_size' => $outputSize
        ]);
        exit;
    }
}

// If failed or expired
if ($status === 'failed' || $status === 'expired' || $status === 'error') {
     $stmt = $db->prepare("UPDATE generations SET status = 'failed' WHERE id = ?");
     $stmt->execute([$generationId]);

     echo json_encode([
         'id' => $generationId,
         'status' => 'failed',
         'error' => $decoded['error']['message'] ?? "Generation $status"
     ]);
     exit;
}

// If pending (Still processing)
// We stay in 'processing' state
echo json_encode([
    'id' => $generationId,
    'status' => 'processing',
    'progress' => $decoded['progress'] ?? 0
]);
