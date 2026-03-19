<?php
/**
 * Admin Settings API
 * GET:  Returns all admin settings (admin only)
 * POST: Update settings (admin only)
 */
header('Content-Type: application/json');
require_once __DIR__ . '/../auth.php';

$user = authenticateRequest();

// Check admin
if (!(int) $user['is_admin']) {
    http_response_code(403);
    echo json_encode(['error' => 'Admin access required']);
    exit;
}

$db = getDB();

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $settings = getAllSettings();
    echo json_encode(['settings' => $settings]);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = json_decode(file_get_contents('php://input'), true);
    $settings = $input['settings'] ?? [];

    // Allowlisted keys
    $allowedKeys = [
        'bdt_per_usd',
        'image_pro_cost',
        'video_per_sec_cost',
        'audio_per_1k_chars_cost',
        'bdt_per_credit',
        'site_name',
    ];

    $updated = 0;
    foreach ($settings as $key => $value) {
        if (!in_array($key, $allowedKeys))
            continue;

        $stmt = $db->prepare(
            "INSERT INTO admin_settings (setting_key, setting_value) VALUES (?, ?) 
             ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)"
        );
        $stmt->execute([$key, (string) $value]);
        $updated++;
    }

    echo json_encode([
        'success' => true,
        'updated' => $updated,
        'settings' => getAllSettings(),
    ]);
    exit;
}

http_response_code(405);
echo json_encode(['error' => 'Method not allowed']);
