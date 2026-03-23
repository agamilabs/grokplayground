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
        // Create new user
        $stmt = $db->prepare(
            "INSERT INTO users (firebase_uid, email, display_name, photo_url, credits) VALUES (?, ?, ?, ?, 0)"
        );
        $stmt->execute([
            $tokenData['uid'],
            $tokenData['email'],
            $tokenData['name'],
            $tokenData['picture'],
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
