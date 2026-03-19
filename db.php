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
 * Get an admin setting value
 */
function getSetting($key, $default = null)
{
    $db = getDB();
    $stmt = $db->prepare("SELECT setting_value FROM admin_settings WHERE setting_key = ?");
    $stmt->execute([$key]);
    $row = $stmt->fetch();
    return $row ? $row['setting_value'] : $default;
}

/**
 * Get all admin settings as an associative array
 */
function getAllSettings()
{
    $db = getDB();
    $stmt = $db->query("SELECT setting_key, setting_value FROM admin_settings");
    $settings = [];
    while ($row = $stmt->fetch()) {
        $settings[$row['setting_key']] = $row['setting_value'];
    }
    return $settings;
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
    ];
    $key = $map[$type] ?? null;
    if (!$key)
        return 0;
    return (int) getSetting($key, 5);
}
