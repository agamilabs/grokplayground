<?php
require_once __DIR__ . '/../auth.php';

// Ensure user is authenticated
$user = authenticateRequest();
$db = getDB();

try {
    // 1. Get referral statistics & info
    $stmt = $db->prepare("
        SELECT 
            referral_code,
            (SELECT COUNT(*) FROM users WHERE referred_by = ?) as total_referrals,
            COALESCE((SELECT SUM(credits) FROM transactions WHERE user_id = ? AND type = 'referral_reward'), 0) as total_earned
        FROM users WHERE id = ?
    ");
    $stmt->execute([$user['id'], $user['id'], $user['id']]);
    $stats = $stmt->fetch();

    echo json_encode([
        'success' => true,
        'referral_code' => $stats['referral_code'],
        'total_referrals' => (int)$stats['total_referrals'],
        'total_earned' => (int)$stats['total_earned']
    ]);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}
