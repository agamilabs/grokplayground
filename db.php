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
            echo json_encode(['error' => 'Database connection failed']);
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
 * Get all admin settings as an associative array
 */
function getAllSettings()
{
    $db = getDB();
    $stmt = $db->query("SELECT setting_key, setting_value FROM admin_settings");
    return $stmt->fetchAll(PDO::FETCH_KEY_PAIR);
}

/**
 * Get credit cost for a generation type
 */
function getCreditCost($type)
{
    $map = [
        'text_to_image' => 'text_to_image_cost',
        'image_to_video' => 'image_to_video_cost',
        'text_to_video' => 'text_to_video_cost',
        'text_to_audio' => 'audio_per_1k_chars_cost',
    ];
    $key = $map[$type] ?? null;
    if (!$key)
        return 0;

    $cost = getSetting($key, 0.05);
    // Convert USD cost to Credits? 
    // Actually, in our current system, we seem to be treating cost as credits or doing a conversion elsewhere.
    // Based on previous discussions, BDT is credit, and we have USD rates.
    // Let's check how generate.php uses it.
    return (float) $cost;
}
