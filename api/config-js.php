<?php
/**
 * Dynamic Firebase Configuration
 * Serves the Firebase config object using values from the database.
 */
header('Content-Type: application/javascript');
require_once __DIR__ . '/../db.php';

$settings = getAllSettings();

// Fallback values for safety (matching existing hardcoded ones)
$apiKey = $settings['firebase_api_key'] ?? 'AIzaSyBZn5av7P66y7VBpR2wgVb7DtOtnsfMYFA';
$authDomain = $settings['firebase_auth_domain'] ?? 'coursepool-488520.firebaseapp.com';
$projectId = $settings['firebase_project_id'] ?? 'coursepool-488520';
$storageBucket = $settings['firebase_storage_bucket'] ?? 'coursepool-488520.firebasestorage.app';
$messagingSenderId = $settings['firebase_messaging_sender_id'] ?? '1084097792660';
$appId = $settings['firebase_app_id'] ?? '1:1084097792660:web:da5979d939420326598281';
$measurementId = $settings['firebase_measurement_id'] ?? 'G-1FM4Z5WDPV';

?>
const firebaseConfig = {
    apiKey: "<?php echo addslashes($apiKey); ?>",
    authDomain: "<?php echo addslashes($authDomain); ?>",
    projectId: "<?php echo addslashes($projectId); ?>",
    storageBucket: "<?php echo addslashes($storageBucket); ?>",
    messagingSenderId: "<?php echo addslashes($messagingSenderId); ?>",
    appId: "<?php echo addslashes($appId); ?>",
    measurementId: "<?php echo addslashes($measurementId); ?>"
};

// Initialize Firebase
if (!firebase.apps.length) {
    firebase.initializeApp(firebaseConfig);
}
const auth = firebase.auth();
const storage = typeof firebase.storage === 'function' ? firebase.storage() : null;
const googleProvider = new firebase.auth.GoogleAuthProvider();
