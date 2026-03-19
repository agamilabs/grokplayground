<?php
/**
 * Central Configuration File
 * Loads DB credentials from .env and other settings from Database
 */

// Simple .env loader
if (file_exists(__DIR__ . '/.env')) {
    $lines = file(__DIR__ . '/.env', FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    foreach ($lines as $line) {
        if (strpos(trim($line), '#') === 0)
            continue;
        list($name, $value) = explode('=', $line, 2);
        $_ENV[trim($name)] = trim($value);
        putenv(trim($line));
    }
}

// Database Credentials from .env
define('DB_HOST', getenv('DB_HOST') ?: 'localhost');
define('DB_NAME', getenv('DB_NAME') ?: '');
define('DB_USER', getenv('DB_USER') ?: 'root');
define('DB_PASS', getenv('DB_PASS') ?: '');

/**
 * Fetch a setting from the admin_settings table
 */
function get_setting($key, $default = null)
{
    static $settings = null;
    if ($settings === null) {
        try {
            $pdo = new PDO("mysql:host=" . DB_HOST . ";dbname=" . DB_NAME, DB_USER, DB_PASS);
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $stmt = $pdo->query("SELECT setting_key, setting_value FROM admin_settings");
            $settings = $stmt->fetchAll(PDO::FETCH_KEY_PAIR);
        } catch (Exception $e) {
            $settings = []; // Fail gracefully if DB not ready
        }
    }
    return $settings[$key] ?? $default;
}

// Define Constants from Database
define('XAI_API_KEY', get_setting('xai_api_key', ''));
define('XAI_BASE_URL', get_setting('xai_base_url', 'https://api.x.ai/v1'));
define('FIREBASE_PROJECT_ID', get_setting('firebase_project_id', ''));
define('SITE_URL', rtrim(get_setting('site_url', 'http://localhost/groksubscription'), '/'));

// bKash Credentials
define('BKASH_APP_KEY', get_setting('bkash_app_key', ''));
define('BKASH_APP_SECRET', get_setting('bkash_app_secret', ''));
define('BKASH_USERNAME', get_setting('bkash_username', ''));
define('BKASH_PASSWORD', get_setting('bkash_password', ''));
define('BKASH_BASE_URL', get_setting('bkash_base_url', 'https://tokenized.sandbox.bka.sh/v1.2.0-beta'));

// Error Reporting (Disable for production to avoid JSON corruption)
error_reporting(E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED);
ini_set('display_errors', 0);

// CORS Headers
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if (isset($_SERVER['REQUEST_METHOD']) && $_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}