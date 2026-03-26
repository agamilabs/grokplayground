<?php
/**
 * Firebase Auth Token Verification
 * Validates the Firebase ID token (JWT) from the client.
 * Lightweight: verifies via Google's public keys endpoint.
 */
require_once __DIR__ . '/db.php';

/**
 * Verify Firebase ID token and return user data.
 * Returns ['uid' => ..., 'email' => ..., 'name' => ..., 'picture' => ...] or null.
 */
function verifyFirebaseToken($idToken)
{
    if (empty($idToken))
        return null;

    // Decode JWT parts (header.payload.signature)
    $parts = explode('.', $idToken);
    if (count($parts) !== 3)
        return null;

    // Decode payload
    $payload = json_decode(base64_decode(strtr($parts[1], '-_', '+/')), true);
    if (!$payload)
        return null;

    // Basic validation
    $projectId = FIREBASE_PROJECT_ID;
    if (($payload['aud'] ?? '') !== $projectId)
        return null;
    if (($payload['iss'] ?? '') !== "https://securetoken.google.com/$projectId")
        return null;
    if (($payload['exp'] ?? 0) < time())
        return null;

    return [
        'uid' => $payload['sub'] ?? $payload['user_id'] ?? null,
        'email' => $payload['email'] ?? '',
        'name' => $payload['name'] ?? '',
        'picture' => $payload['picture'] ?? '',
    ];
}

/**
 * Get or create user from Firebase token data.
 * Returns the user row from DB.
 */
function getOrCreateUser($tokenData)
{
    $db = getDB();

    // Check if user exists
    $stmt = $db->prepare("SELECT * FROM users WHERE firebase_uid = ?");
    $stmt->execute([$tokenData['uid']]);
    $user = $stmt->fetch();

    if (!$user) {
        $signupCredits = (int)get_setting('signup_gift_credits', 10);
        $stmt = $db->prepare(
            "INSERT INTO users (firebase_uid, email, display_name, photo_url, credits) VALUES (?, ?, ?, ?, ?)"
        );
        $stmt->execute([
            $tokenData['uid'],
            $tokenData['email'],
            $tokenData['name'],
            $tokenData['picture'],
            $signupCredits
        ]);
        $userId = $db->lastInsertId();

        $stmt = $db->prepare("SELECT * FROM users WHERE id = ?");
        $stmt->execute([$userId]);
        $user = $stmt->fetch();
    }

    return $user;
}

/**
 * Soft authenticate the current request.
 * Returns user row or null if not authenticated.
 */
function getAuthenticatedUser()
{
    $authHeader = $_SERVER['HTTP_AUTHORIZATION'] ?? $_SERVER['REDIRECT_HTTP_AUTHORIZATION'] ?? '';
    if (empty($authHeader) && function_exists('getallheaders')) {
        $headers = getallheaders();
        $authHeader = $headers['Authorization'] ?? $headers['authorization'] ?? '';
    }

    if (!preg_match('/Bearer\s+(.+)$/i', $authHeader, $matches)) {
        return null;
    }

    $idToken = $matches[1];
    if (!defined('FIREBASE_PROJECT_ID') || empty(FIREBASE_PROJECT_ID)) {
        return null;
    }

    $tokenData = verifyFirebaseToken($idToken);
    if (!$tokenData || !$tokenData['uid']) {
        return null;
    }

    return getOrCreateUser($tokenData);
}

/**
 * Authenticate the current request.
 * Reads Bearer token from Authorization header.
 * Returns user row or sends 401 and exits.
 */
function authenticateRequest()
{
    $user = getAuthenticatedUser();
    if (!$user) {
        http_response_code(401);
        echo json_encode(['error' => 'Authentication required']);
        exit;
    }
    return $user;
}

/**
 * Common xAI API Request Wrapper
 */
function xaiRequest($method, $endpoint, $payload = null)
{
    $url = XAI_BASE_URL . $endpoint;
    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_SSL_VERIFYPEER => true,
        CURLOPT_HTTPHEADER => [
            'Content-Type: application/json',
            'Authorization: Bearer ' . XAI_API_KEY,
        ],
        CURLOPT_CUSTOMREQUEST => $method,
        CURLOPT_TIMEOUT => 60,
    ]);

    if ($method === 'POST' && $payload) {
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($payload));
    }

    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $contentType = curl_getinfo($ch, CURLINFO_CONTENT_TYPE);
    curl_close($ch);

    if ($httpCode >= 400) {
        $decoded = json_decode($response, true);
        $errorMessage = "API error (HTTP $httpCode)";
        if ($decoded) {
            $errorMessage = $decoded['error']['message'] ?? $decoded['error'] ?? $decoded['detail'] ?? json_encode($decoded);
        } elseif ($response) {
            $errorMessage = substr($response, 0, 300);
        }

        // Log error
        error_log("xAI Request Failed [$httpCode] $url: $response");
        
        return ['error' => $errorMessage, 'http_code' => $httpCode];
    }

    if (strpos($contentType, 'application/json') !== false) {
        return json_decode($response, true) ?: ['error' => 'Empty API response'];
    }

    return $response;
}

/**
 * Download a remote file and save it to the uploads directory.
 * Returns ['url' => ..., 'size' => ...] or null on failure.
 */
function downloadToLocal($url)
{
    if (empty($url) || strpos($url, 'http') === false) return null;

    $dir = __DIR__ . '/uploads';
    if (!is_dir($dir)) {
        mkdir($dir, 0777, true);
    }

    // Determine extension
    $path = parse_url($url, PHP_URL_PATH);
    $ext = pathinfo($path, PATHINFO_EXTENSION);
    
    if (!$ext) {
        if (strpos($url, 'imgen') !== false) $ext = 'jpg';
        else if (strpos($url, 'video') !== false) $ext = 'mp4';
        else if (strpos($url, 'tts') !== false) $ext = 'mp3';
        else $ext = 'bin';
    }

    $filename = 'out_' . time() . '_' . bin2hex(random_bytes(4)) . '.' . $ext;
    $filePath = $dir . '/' . $filename;

    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_SSL_VERIFYPEER => true,
        CURLOPT_TIMEOUT => 240,
    ]);

    $data = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($httpCode === 200 && $data) {
        file_put_contents($filePath, $data);
        return [
            'url' => UPLOADS_URL . $filename,
            'size' => filesize($filePath)
        ];
    }

    return null;
}
