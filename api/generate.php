<?php
/**
 * Generation API Endpoint
 * POST: Create a new generation (text_to_image, image_to_video, text_to_video)
 */
header('Content-Type: application/json');
require_once __DIR__ . '/../auth.php';

$user = authenticateRequest();
$db = getDB();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
    exit;
}

$input = json_decode(file_get_contents('php://input'), true);
$type = $input['type'] ?? '';
$prompt = trim($input['prompt'] ?? '');
$imageData = $input['image'] ?? null;
$aspectRatio = $input['aspect_ratio'] ?? null;
$resolution = $input['resolution'] ?? null;
$duration = isset($input['duration']) ? (int) $input['duration'] : 5;
$model = $input['model'] ?? null;
$voice = $input['voice'] ?? 'alloy';

// Validate type
$validTypes = ['text_to_image', 'image_to_video', 'text_to_video', 'text_to_audio'];
if (!in_array($type, $validTypes)) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid generation type']);
    exit;
}

if (empty($prompt)) {
    http_response_code(400);
    echo json_encode(['error' => 'Prompt is required']);
    exit;
}

if ($type === 'image_to_video' && empty($imageData)) {
    http_response_code(400);
    echo json_encode(['error' => 'Image is required for image-to-video generation']);
    exit;
}

// Check credits
$creditCost = getCreditCost($type, $duration, strlen($prompt), $model);
if ($user['credits'] < $creditCost) {
    http_response_code(402);
    echo json_encode([
        'error' => 'Insufficient credits',
        'required' => $creditCost,
        'available' => $user['credits']
    ]);
    exit;
}

try {
    // Call xAI API based on type
    if ($type === 'text_to_image') {
        $result = callImageGeneration($prompt, $aspectRatio, $resolution, $model);
    } elseif ($type === 'text_to_audio') {
        $result = callAudioGeneration($prompt, $model, $voice);
    } else {
        $result = callVideoGeneration($type, $prompt, $imageData, $aspectRatio, $resolution, $duration, $model);
    }

    if (isset($result['error'])) {
        http_response_code(500);
        echo json_encode(['error' => $result['error']]);
        exit;
    }

    // Deduct credits
    $db->beginTransaction();

    $stmt = $db->prepare("UPDATE users SET credits = credits - ? WHERE id = ? AND credits >= ?");
    $stmt->execute([$creditCost, $user['id'], $creditCost]);

    if ($stmt->rowCount() === 0) {
        $db->rollBack();
        http_response_code(402);
        echo json_encode(['error' => 'Insufficient credits']);
        exit;
    }

    // Record transaction
    $stmt = $db->prepare(
        "INSERT INTO transactions (user_id, type, credits, description) VALUES (?, 'spend', ?, ?)"
    );
    $stmt->execute([$user['id'], -$creditCost, ucfirst(str_replace('_', ' ', $type)) . " generation"]);

    // Determine status and output
    $status = ($type === 'text_to_image') ? 'completed' : 'processing';
    $outputUrl = $result['url'] ?? null;
    $requestId = $result['request_id'] ?? null;

    // Store generation record
    $stmt = $db->prepare(
        "INSERT INTO generations (user_id, type, prompt, input_url, output_url, status, xai_request_id, credits_used) 
         VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
    );
    $stmt->execute([
        $user['id'],
        $type,
        $prompt,
        $imageData ? 'base64_upload' : null,
        $outputUrl,
        $status,
        $requestId,
        $creditCost
    ]);
    $generationId = $db->lastInsertId();

    $db->commit();

    // Return response
    $response = [
        'success' => true,
        'generation_id' => (int) $generationId,
        'type' => $type,
        'status' => $status,
        'credits_used' => $creditCost,
        'credits_remaining' => $user['credits'] - $creditCost,
    ];

    if ($status === 'completed') {
        $response['output_url'] = $outputUrl;
    } else {
        $response['request_id'] = $requestId;
    }

    echo json_encode($response);

} catch (Exception $e) {
    if ($db->inTransaction())
        $db->rollBack();
    http_response_code(500);
    echo json_encode(['error' => 'Generation failed: ' . $e->getMessage()]);
}

// ─── xAI API Calls ────────────────────────────────────────

function callImageGeneration($prompt, $aspectRatio = null, $resolution = null, $model = null)
{
    $payload = [
        'model' => $model ?: 'grok-imagine-image',
        'prompt' => $prompt,
        'n' => 1,
        'response_format' => 'url',
    ];

    if ($aspectRatio) {
        $payload['aspect_ratio'] = $aspectRatio;
    }
    if ($resolution) {
        $payload['resolution'] = $resolution;
    }

    $response = xaiRequest('POST', '/images/generations', $payload);

    if (isset($response['data'][0]['url'])) {
        return ['url' => $response['data'][0]['url']];
    }

    return ['error' => $response['error']['message'] ?? 'Image generation failed'];
}

function callVideoGeneration($type, $prompt, $imageData = null, $aspectRatio = null, $resolution = null, $duration = 5, $model = null)
{
    $payload = [
        'model' => $model ?: 'grok-imagine-video',
        'prompt' => $prompt,
        'duration' => $duration ?: 5,
        'aspect_ratio' => $aspectRatio ?: '16:9',
        'resolution' => $resolution ?: '720p',
    ];

    if ($imageData && $type === 'image_to_video') {
        $payload['image_url'] = $imageData;
    }

    $response = xaiRequest('POST', '/videos/generations', $payload);

    if (isset($response['request_id'])) {
        return ['request_id' => $response['request_id']];
    }

    return ['error' => $response['error']['message'] ?? 'Video generation failed'];
}


function callAudioGeneration($prompt, $model = null, $voice = 'eve')
{
    $payload = [
        'text' => $prompt,
        'voice_id' => $voice,
        'language' => 'en',
    ];

    $response = xaiRequest('POST', '/tts', $payload);

    if (isset($response['error'])) {
        return $response;
    }

    // Binary response handling
    if (is_string($response)) {
        $dir = __DIR__ . '/../uploads';
        if (!is_dir($dir)) {
            mkdir($dir, 0777, true);
        }
        $filename = 'audio_' . time() . '_' . uniqid() . '.mp3';
        file_put_contents($dir . '/' . $filename, $response);

        // Build absolute URL for the output
        $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? "https://" : "http://";
        $host = $_SERVER['HTTP_HOST'];
        $scriptPath = dirname($_SERVER['SCRIPT_NAME']); // e.g., /groksubscription/api
        $baseDir = dirname($scriptPath); // e.g., /groksubscription
        $baseUrl = $protocol . $host . $baseDir;

        return ['url' => rtrim($baseUrl, '/') . '/uploads/' . $filename];
    }

    return ['error' => 'Unexpected API response format'];
}

function xaiRequest($method, $endpoint, $payload = null)
{
    $url = XAI_BASE_URL . $endpoint;

    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_HTTPHEADER => [
            'Content-Type: application/json',
            'Authorization: Bearer ' . XAI_API_KEY,
        ],
        CURLOPT_TIMEOUT => 60,
    ]);

    if ($method === 'POST') {
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($payload));
    }

    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $contentType = curl_getinfo($ch, CURLINFO_CONTENT_TYPE);
    curl_close($ch);

    if ($httpCode >= 400) {
        $decoded = json_decode($response, true);
        $errorMessage = $decoded['error']['message'] ?? "API error (HTTP $httpCode)";

        // Add more context for 403/401 errors
        if ($httpCode === 403 || $httpCode === 401) {
            if (isset($decoded['detail'])) {
                $errorMessage .= ": " . $decoded['detail'];
            } elseif (!$decoded) {
                $errorMessage .= " (Verify API key and restricted endpoints)";
            }
        }

        return ['error' => ['message' => $errorMessage, 'http_code' => $httpCode, 'raw_response' => substr($response, 0, 500)]];
    }

    if (strpos($contentType, 'application/json') !== false) {
        return json_decode($response, true) ?: ['error' => ['message' => 'Empty API response']];
    }

    return $response; // Return raw data (for audio)
}
