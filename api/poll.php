<?php
/**
 * Video Polling Endpoint
 * GET: Check status of an async video generation
 * Params: request_id, generation_id
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

$requestId = $_GET['request_id'] ?? '';
$generationId = $_GET['generation_id'] ?? '';

if (empty($requestId) || empty($generationId)) {
    http_response_code(400);
    echo json_encode(['error' => 'request_id and generation_id are required']);
    exit;
}

// Verify this generation belongs to the user
$stmt = $db->prepare("SELECT * FROM generations WHERE id = ? AND user_id = ?");
$stmt->execute([$generationId, $user['id']]);
$generation = $stmt->fetch();

if (!$generation) {
    http_response_code(404);
    echo json_encode(['error' => 'Generation not found']);
    exit;
}

if ($generation['status'] === 'completed') {
    echo json_encode([
        'status' => 'completed',
        'output_url' => $generation['output_url'],
    ]);
    exit;
}

if ($generation['status'] === 'failed') {
    echo json_encode(['status' => 'failed']);
    exit;
}

// Poll xAI API
$url = XAI_BASE_URL . '/videos/' . urlencode($requestId);
$ch = curl_init($url);
curl_setopt_array($ch, [
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_HTTPHEADER => [
        'Authorization: Bearer ' . XAI_API_KEY,
    ],
    CURLOPT_TIMEOUT => 30,
]);

$response = curl_exec($ch);
$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

$data = json_decode($response, true);

if ($httpCode >= 400) {
    echo json_encode(['status' => 'processing', 'message' => 'Still generating...']);
    exit;
}

if ($apiStatus === 'completed' || $apiStatus === 'succeeded' || $apiStatus === 'done') {
    $videoUrl = $data['video']['url'] ?? $data['url'] ?? $data['video_url'] ?? $data['output']['url'] ?? null;

    if ($videoUrl) {
        // Update generation record
        $stmt = $db->prepare("UPDATE generations SET status = 'completed', output_url = ? WHERE id = ?");
        $stmt->execute([$videoUrl, $generationId]);

        echo json_encode([
            'status' => 'completed',
            'output_url' => $videoUrl,
        ]);
    } else {
        echo json_encode(['status' => 'processing', 'message' => 'Finalizing...']);
    }
} elseif ($apiStatus === 'failed') {
    $stmt = $db->prepare("UPDATE generations SET status = 'failed' WHERE id = ?");
    $stmt->execute([$generationId]);

    echo json_encode(['status' => 'failed', 'message' => 'Generation failed']);
} else {
    echo json_encode(['status' => 'processing', 'message' => 'Still generating...']);
}
