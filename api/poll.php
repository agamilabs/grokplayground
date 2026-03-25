<?php
/**
 * Video Polling Endpoint
 * GET: api/poll.php?id={generation_id}
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

$generationId = $_GET['generation_id'] ?? $_GET['id'] ?? null;
if (!$generationId) {
    http_response_code(400);
    echo json_encode(['error' => 'Generation ID is required']);
    exit;
}

// Get the generation record
$stmt = $db->prepare("SELECT * FROM generations WHERE id = ? AND user_id = ?");
$stmt->execute([$generationId, $user['id']]);
$generation = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$generation) {
    http_response_code(404);
    echo json_encode(['error' => 'Generation not found']);
    exit;
}

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
$url = XAI_BASE_URL . '/videos/generations/' . $requestId;
$ch = curl_init($url);
curl_setopt_array($ch, [
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_SSL_VERIFYPEER => true,
    CURLOPT_HTTPHEADER => [
        'Content-Type: application/json',
        'Authorization: Bearer ' . XAI_API_KEY,
    ],
    CURLOPT_TIMEOUT => 30,
]);

$response = curl_exec($ch);
$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

if ($httpCode >= 400) {
    // Just return processing and log error, keeping it processing for now
    $decoded = json_decode($response, true);
    $errorMsg = $decoded['error']['message'] ?? "Polling error (HTTP $httpCode)";
    
    $logEntry = date('Y-m-d H:i:s') . " - poll.php HTTP $httpCode: $response\n";
    file_put_contents(__DIR__ . '/../uploads/api_error.log', $logEntry, FILE_APPEND);

    http_response_code(500);
    echo json_encode(['error' => $errorMsg, 'status' => 'processing']);
    exit;
}

$decoded = json_decode($response, true);
if (!$decoded) {
    echo json_encode(['status' => 'processing']);
    exit;
}

// Checking status
$status = strtolower($decoded['status'] ?? $decoded['state'] ?? 'pending');

if ($status === 'done' || $status === 'completed') {
    $outputUrl = $decoded['video']['url'] ?? $decoded['url'] ?? $decoded['video_url'] ?? null;

    if ($outputUrl) {
        $stmt = $db->prepare("UPDATE generations SET status = 'completed', output_url = ? WHERE id = ?");
        $stmt->execute([$outputUrl, $generationId]);

        echo json_encode([
            'id' => $generationId,
            'status' => 'completed',
            'output_url' => $outputUrl
        ]);
        exit;
    }
}

// If failed
if ($status === 'failed' || $status === 'expired' || $status === 'error') {
     $stmt = $db->prepare("UPDATE generations SET status = 'failed' WHERE id = ?");
     $stmt->execute([$generationId]);

     echo json_encode([
         'id' => $generationId,
         'status' => 'failed',
         'error' => $decoded['error']['message'] ?? 'Generation failed'
     ]);
     exit;
}

// Still processing
echo json_encode([
    'id' => $generationId,
    'status' => 'processing'
]);
