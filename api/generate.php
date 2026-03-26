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
$prompt = trim(strip_tags($input['prompt'] ?? ''));
if (mb_strlen($prompt) > 4000) {
    http_response_code(400);
    echo json_encode(['error' => 'Prompt is too long (max 4000 characters)']);
    exit;
}
$imageData = $input['image'] ?? null;
$aspectRatio = $input['aspect_ratio'] ?? null;
$resolution = $input['resolution'] ?? null;
$duration = isset($input['duration']) ? (int) $input['duration'] : 5;
$model = $input['model'] ?? null;
$voice = $input['voice'] ?? 'eve';
$quality = $input['quality'] ?? 'standard';

// Validate type
$validTypes = ['text_to_image', 'image_edit', 'image_to_video', 'text_to_video', 'text_to_audio'];
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

if (($type === 'image_to_video' || $type === 'image_edit') && empty($imageData)) {
    http_response_code(400);
    echo json_encode(['error' => 'Image is required for ' . str_replace('_', '-', $type) . ' generation']);
    exit;
}

// Convert base64 to File URL if it's base64
if ($imageData && preg_match('/^data:image\/(\w+);base64,/', $imageData, $matches)) {
    $extension = $matches[1];
    if ($extension === 'jpeg') $extension = 'jpg';
    $base64String = substr($imageData, strpos($imageData, ',') + 1);
    
    $dir = __DIR__ . '/../uploads';
    if (!is_dir($dir)) {
        mkdir($dir, 0777, true);
    }
    
    // Save and optimize the image using GD
    $binaryData = base64_decode($base64String);
    $imgRes = imagecreatefromstring($binaryData);
    
    if ($imgRes) {
        // Resize if too large (max 2048px)
        $w = imagesx($imgRes);
        $h = imagesy($imgRes);
        $maxDim = 2048;
        if ($w > $maxDim || $h > $maxDim) {
            $ratio = $w / $h;
            if ($ratio > 1) {
                $newW = $maxDim;
                $newH = round($maxDim / $ratio);
            } else {
                $newH = $maxDim;
                $newW = round($maxDim * $ratio);
            }
            $resized = imagecreatetruecolor($newW, $newH);
            // Handle transparency for non-JPG sources if needed
            imagealphablending($resized, false);
            imagesavealpha($resized, true);
            imagecopyresampled($resized, $imgRes, 0, 0, 0, 0, $newW, $newH, $w, $h);
            imagedestroy($imgRes);
            $imgRes = $resized;
        }

        // Save as high-quality JPEG (perceptually lossless but much smaller)
        $filename = 'img_opt_' . time() . '_' . bin2hex(random_bytes(4)) . '.jpg';
        $filePath = $dir . '/' . $filename;
        imagejpeg($imgRes, $filePath, 85);
        imagedestroy($imgRes);
        $imageData = UPLOADS_URL . $filename;
    } else {
        // Fallback for non-standard formats
        $filename = 'img_' . time() . '_' . bin2hex(random_bytes(4)) . '.' . $extension;
        $filePath = $dir . '/' . $filename;
        file_put_contents($filePath, $binaryData);
        $imageData = UPLOADS_URL . $filename;
    }
}

// Basic Rate Limiting: Max 15 requests per minute per user
$stmt = $db->prepare("SELECT COUNT(*) FROM generations WHERE user_id = ? AND created_at > DATE_SUB(NOW(), INTERVAL 1 MINUTE)");
$stmt->execute([$user['id']]);
if ($stmt->fetchColumn() >= 15) {
    http_response_code(429);
    echo json_encode(['error' => 'Rate limit exceeded. Please wait a minute.']);
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
    // Deduct credits and save generation record BEFORE calling the API
    // This ensures a record always exists even if the API call fails
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

    // Store generation record with 'processing' status
    $stmt = $db->prepare(
        "INSERT INTO generations (user_id, type, prompt, input_url, status, credits_used) 
         VALUES (?, ?, ?, ?, ?, ?)"
    );
    $stmt->execute([
        $user['id'],
        $type,
        $prompt,
        $imageData,
        'processing',
        $creditCost
    ]);
    $generationId = $db->lastInsertId();

    $db->commit();

    // Now call xAI API (credits and record are already saved)
    if ($type === 'text_to_image') {
        $result = callImageGeneration($prompt, $aspectRatio, $resolution, $model);
    } elseif ($type === 'image_edit') {
        $result = callImageEdit($prompt, $imageData, $aspectRatio, $resolution, $model);
    } elseif ($type === 'text_to_audio') {
        $result = callAudioGeneration($prompt, $model, $voice, $quality);
    } elseif ($type === 'image_to_video' || $type === 'text_to_video') {
        $result = callVideoGeneration($type, $prompt, $imageData, $aspectRatio, $resolution, $duration, $model);
    } else {
        // Fallback or error for unhandled types, though validation should prevent this
        http_response_code(400);
        echo json_encode(['error' => 'Unhandled generation type: ' . $type]);
        exit;
    }

    if (isset($result['error'])) {
        // API failed — update generation record to 'failed' (record still exists for history)
        $stmt = $db->prepare("UPDATE generations SET status = 'failed' WHERE id = ?");
        $stmt->execute([$generationId]);

        http_response_code(500);
        echo json_encode([
            'error' => $result['error'],
            'generation_id' => (int) $generationId,
        ]);
        exit;
    }

    // API succeeded — update generation record with output
    $outputUrl = $result['url'] ?? null;
    $requestId = $result['request_id'] ?? null;
    $finalStatus = $outputUrl ? 'completed' : 'processing';

    $stmt = $db->prepare(
        "UPDATE generations SET status = ?, output_url = ?, xai_request_id = ? WHERE id = ?"
    );
    $stmt->execute([$finalStatus, $outputUrl, $requestId, $generationId]);

    // Return response
    $response = [
        'success' => true,
        'generation_id' => (int) $generationId,
        'type' => $type,
        'status' => $finalStatus,
        'credits_used' => $creditCost,
        'credits_remaining' => $user['credits'] - $creditCost,
    ];

    if ($finalStatus === 'completed') {
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

    if ($aspectRatio && $aspectRatio !== 'auto') {
        $payload['aspect_ratio'] = $aspectRatio;
    }

    if ($model === 'grok-imagine-image-pro' && $resolution) {
        $payload['resolution'] = $resolution;
    }

    $response = xaiRequest('POST', '/images/generations', $payload);

    if (isset($response['data'][0]['url'])) {
        return ['url' => $response['data'][0]['url']];
    }

    $error = $response['error']['message'] ?? json_encode($response);
    return ['error' => $error ?: 'Image generation failed'];
}

function callImageEdit($prompt, $imageData, $aspectRatio = null, $resolution = null, $model = null)
{
    $payload = [
        'model' => $model ?: 'grok-imagine-image',
        'prompt' => $prompt,
        'image' => [
            'url' => $imageData
        ],
        'response_format' => 'url',
    ];

    $isPro = ($model === 'grok-imagine-image-pro');
    if ($aspectRatio && $aspectRatio !== 'auto') {
        $payload['aspect_ratio'] = $aspectRatio;
    }
    if ($resolution) {
        $payload['resolution'] = $resolution;
    }

    $response = xaiRequest('POST', '/images/edits', $payload);

    if (isset($response['error'])) {
        return $response;
    }

    if (isset($response['data'][0]['url'])) {
        return ['url' => $response['data'][0]['url']];
    }

    if (isset($response['url'])) {
        return ['url' => $response['url']];
    }

    return ['error' => 'Unexpected API response format'];
}

function callVideoGeneration($type, $prompt, $imageData = null, $aspectRatio = null, $resolution = null, $duration = 5, $model = null)
{
    $payload = [
        'model' => $model ?: 'grok-imagine-video',
        'prompt' => $prompt,
        'duration' => (int)($duration ?: 5),
        'resolution' => $resolution ?: '480p',
    ];

    if ($aspectRatio && $aspectRatio !== 'auto') {
        $payload['aspect_ratio'] = $aspectRatio;
    }
    // If auto or not provided, we omit to let the API decide (matching input image or prompt)

    if ($imageData && $type === 'image_to_video') {
        $payload['image'] = ['url' => $imageData];
    }

    $response = xaiRequest('POST', '/videos/generations', $payload);

    if (isset($response['request_id'])) {
        return ['request_id' => $response['request_id']];
    }

    // Log unexpected response for debugging
    $logEntry = date('Y-m-d H:i:s') . " - callVideoGeneration unexpected response: " . json_encode($response) . "\n";
    file_put_contents(__DIR__ . '/../uploads/api_error.log', $logEntry, FILE_APPEND);

    $errorMsg = $response['error']['message'] ?? ('Video generation failed: ' . substr(json_encode($response), 0, 200));
    return ['error' => $errorMsg];
}


function callAudioGeneration($prompt, $model = null, $voice = 'eve', $quality = 'standard')
{
    $dir = __DIR__ . '/../uploads';
    if (!is_dir($dir)) {
        mkdir($dir, 0777, true);
    }

    // Caching logic: check if this exact audio already exists
    $cacheKey = md5($prompt . '|' . $voice . '|' . $quality);
    $cacheFile = $dir . '/cache_' . $cacheKey . '.mp3';

    if (file_exists($cacheFile)) {
        return ['url' => UPLOADS_URL . basename($cacheFile), 'cached' => true];
    }

    $payload = [
        'text' => $prompt,
        'voice_id' => $voice,
        'language' => 'en',
    ];

    // High Quality settings (44.1kHz / 192kbps)
    if ($quality === 'high') {
        $payload['output_format'] = [
            'codec' => 'mp3',
            'sample_rate' => 44100,
            'bit_rate' => 192000
        ];
    }

    $response = xaiRequest('POST', '/tts', $payload);

    if (isset($response['error'])) {
        return $response;
    }

    // Binary response handling
    if (is_string($response)) {
        file_put_contents($cacheFile, $response);
        return ['url' => UPLOADS_URL . basename($cacheFile)];
    }

    return ['error' => 'Unexpected API response format'];
}
?>
