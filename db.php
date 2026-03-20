<?php
/**
 * Database Connection (PDO Singleton)
 */
require_once __DIR__ . '/config.php';

function getDB()
{
    static $pdo = null;
    if ($pdo === null) {
        try {
            $dsn = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8mb4";
            $pdo = new PDO($dsn, DB_USER, DB_PASS, [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES => false,
            ]);
        } catch (PDOException $e) {
            http_response_code(500);
            echo json_encode(['error' => 'Database connection failed for: ' . DB_NAME, 'details' => $e->getMessage()]);
            exit;
        }
    }
    return $pdo;
}

/**
 * Get an admin setting value (Wrapper for get_setting in config.php)
 */
function getSetting($key, $default = null)
{
    return get_setting($key, $default);
}

/**
 * Update or insert an admin setting
 */
function setSetting($key, $value)
{
    $db = getDB();
    $stmt = $db->prepare(
        "INSERT INTO admin_settings (setting_key, setting_value) VALUES (?, ?) 
         ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)"
    );
    $stmt->execute([$key, (string) $value]);
}

/**
 * Get all admin settings as an associative array
 */
function getAllSettings()
{
    $db = getDB();
    $stmt = $db->query("SELECT setting_key, setting_value FROM admin_settings");
    return $stmt->fetchAll(PDO::FETCH_KEY_PAIR);
}

/**
 * Get credit cost for a generation type matching frontend formula
 */
function getCreditCost($type, $duration = 5, $textLength = 0, $model = 'grok-imagine-image')
{
    $settings = getAllSettings();
    $bdtPerUsd = (float) ($settings['bdt_per_usd'] ?? 145);
    $bdtPerCredit = (float) ($settings['bdt_per_credit'] ?? 2);

    $costUsd = 0;

    if ($type === 'text_to_image') {
        $costUsd = $model === 'grok-imagine-image-pro' ? (float) ($settings['image_pro_cost'] ?? 0.14) : (float) ($settings['text_to_image_cost'] ?? 0.04);
    } elseif ($type === 'image_to_video' || $type === 'text_to_video') {
        $costUsd = $duration * (float) ($settings['video_per_sec_cost'] ?? 0.1);
    } elseif ($type === 'text_to_audio') {
        $costUsd = ($textLength / 1000) * (float) ($settings['audio_per_1k_chars_cost'] ?? 8.40);
        if ($textLength > 0 && $costUsd < 0.01)
            $costUsd = 0.01;
    }

    $credits = ceil(($costUsd * $bdtPerUsd) / $bdtPerCredit);
    return (int) $credits;
}
