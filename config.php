<?php
/**
 * Central Configuration File
 * Update these values with your actual credentials
 */

// Database
define('DB_HOST', 'localhost');
define('DB_NAME', 'u164367160_grokplayground');
define('DB_USER', 'u164367160_grokplayground');
define('DB_PASS', 'Am~>DYOwRg4');

// xAI Grok Imagine API
define('XAI_API_KEY', 'xai-m3FP6IAfQo9l2VhjDfUv6V4vvhG6gLNQkKI4lucJSaxdWyEPnQRgmJe5SPV1Ln4QxUjVygpuxZ9janSK');
define('XAI_BASE_URL', 'https://api.x.ai/v1');

// Firebase (for server-side token verification)
define('FIREBASE_PROJECT_ID', 'coursepool-488520');

// bKash Checkout (URL-based)
define('BKASH_APP_KEY', 'YOUR_BKASH_APP_KEY');
define('BKASH_APP_SECRET', 'YOUR_BKASH_APP_SECRET');
define('BKASH_USERNAME', 'YOUR_BKASH_USERNAME');
define('BKASH_PASSWORD', 'YOUR_BKASH_PASSWORD');
// Sandbox: https://tokenized.sandbox.bka.sh/v1.2.0-beta
// Live:    https://tokenized.pay.bka.sh/v1.2.0-beta
define('BKASH_BASE_URL', 'https://tokenized.sandbox.bka.sh/v1.2.0-beta');

// Site URL (used for bKash callbacks)
define('SITE_URL', 'http://localhost/groksubscription');

// CORS
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}
