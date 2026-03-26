<?php
/**
 * Public Settings API
 * Returns non-sensitive settings for the landing page
 */
header('Content-Type: application/json');
require_once __DIR__ . '/../db.php';

$settings = getAllSettings();

// Filter for only public/non-sensitive keys
$publicKeys = [
    'bdt_per_usd',
    'text_to_image_cost',
    'image_pro_cost',
    'image_edit_cost',
    'video_per_sec_cost',
    'audio_per_1k_chars_cost',
    'bdt_per_credit',
    'site_name'
];

$publicSettings = [];
foreach ($publicKeys as $key) {
    if (isset($settings[$key])) {
        $publicSettings[$key] = $settings[$key];
    }
}

echo json_encode(['settings' => $publicSettings]);
