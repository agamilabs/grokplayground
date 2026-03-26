<?php
/**
 * Admin Stats API
 * GET: Returns summary statistics for the admin dashboard (admin only)
 */
header('Content-Type: application/json');
require_once __DIR__ . '/../auth.php';

$user = authenticateRequest();

// Admin check
if (!(int) $user['is_admin']) {
    http_response_code(403);
    echo json_encode(['error' => 'Admin access required']);
    exit;
}

$db = getDB();

try {
    // 1. Total Revenue (Completed bKash payments)
    $stmt = $db->query("SELECT SUM(amount) as total FROM bkash_payments WHERE status = 'completed'");
    $revenue = (float) ($stmt->fetch()['total'] ?? 0);

    // 2. Total Users
    $stmt = $db->query("SELECT COUNT(*) as total FROM users");
    $userCount = (int) $stmt->fetch()['total'];

    // 3. Generation Stats (Total, Success Rate)
    $stmt = $db->query("SELECT COUNT(*) as total, 
                               SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) as completed,
                               SUM(CASE WHEN status = 'failed' THEN 1 ELSE 0 END) as failed
                        FROM generations");
    $genStats = $stmt->fetch();
    $totalGens = (int) $genStats['total'];
    $completedGens = (int) $genStats['completed'];
    $failedGens = (int) $genStats['failed'];
    $successRate = $totalGens > 0 ? round(($completedGens / $totalGens) * 100, 1) : 0;

    // 4. Breakdown by type
    $stmt = $db->query("SELECT type, COUNT(*) as count FROM generations GROUP BY type");
    $typeBreakdown = $stmt->fetchAll(PDO::FETCH_KEY_PAIR);

    // 5. Total credits in circulation
    $stmt = $db->query("SELECT SUM(credits) as total FROM users");
    $totalCredits = (int) $stmt->fetch()['total'];

    // 6. Recent Revenue (Last 30 days)
    $stmt = $db->query("SELECT SUM(amount) as total FROM bkash_payments 
                        WHERE status = 'completed' AND created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)");
    $revenue30d = (float) ($stmt->fetch()['total'] ?? 0);

    // 7. Total Storage Used
    $stmt = $db->query("SELECT SUM(input_size + output_size) as total FROM generations");
    $totalStorage = (int) ($stmt->fetch()['total'] ?? 0);

    echo json_encode([
        'success' => true,
        'stats' => [
            'revenue' => [
                'total' => $revenue,
                'last_30d' => $revenue30d
            ],
            'users' => [
                'total' => $userCount
            ],
            'generations' => [
                'total' => $totalGens,
                'completed' => $completedGens,
                'failed' => $failedGens,
                'success_rate' => $successRate,
                'by_type' => $typeBreakdown
            ],
            'credits' => [
                'in_circulation' => $totalCredits
            ],
            'storage' => [
                'total' => $totalStorage
            ]
        ]
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Failed to fetch statistics: ' . $e->getMessage()]);
}
