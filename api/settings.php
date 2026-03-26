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
    'video_480p_cost',
    'video_720p_cost',
    'video_1080p_cost',
    'audio_per_1k_chars_cost',
    'global_markup',
    'bdt_per_credit',
    'firebase_api_key',
    'firebase_auth_domain',
    'firebase_project_id',
    'firebase_storage_bucket',
    'firebase_messaging_sender_id',
    'firebase_app_id',
    'firebase_measurement_id',
    'site_name'
];

$publicSettings = [];
foreach ($publicKeys as $key) {
    if (isset($settings[$key])) {
        $publicSettings[$key] = $settings[$key];
    }
}

echo json_encode(['settings' => $publicSettings]);
