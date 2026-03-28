<?php
require_once __DIR__ . '/../auth.php';

// Ensure user is authenticated
$user = authenticateRequest();
$db = getDB();

try {
    // Count of users referred by this user
    $stmt = $db->prepare("SELECT COUNT(*) as count FROM users WHERE referred_by = ?");
    $stmt->execute([$user['id']]);
    $count = $stmt->fetch()['count'];

    // Total credits earned from referral rewards
    $stmt = $db->prepare("SELECT SUM(credits) as earned FROM transactions WHERE user_id = ? AND type = 'referral_reward'");
    $stmt->execute([$user['id']]);
    $earned = $stmt->fetch()['earned'] ?: 0;

    echo json_encode([
        'count' => (int)$count, 
        'earned' => (int)$earned
    ]);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}
