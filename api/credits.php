<?php
/**
 * Credits API
 * GET:  Returns user credit balance + cost settings
 * POST action=gift: Gift credits to another user
 */
header('Content-Type: application/json');
require_once __DIR__ . '/../auth.php';

$user = authenticateRequest();
$db = getDB();

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Return balance + costs
    $settings = getAllSettings();

    echo json_encode([
        'credits' => (int) $user['credits'],
        'costs' => [
            'text_to_image' => getCreditCost('text_to_image'),
            'image_edit' => getCreditCost('image_edit'),
            'image_to_video' => getCreditCost('image_to_video'), // 5s default
            'text_to_video' => getCreditCost('text_to_video'), // 5s default
            'text_to_audio' => getCreditCost('text_to_audio', 5, 200), // ~200 chars estimation
        ],
        'bdt_per_credit' => (float) ($settings['bdt_per_credit'] ?? 2),
    ]);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = json_decode(file_get_contents('php://input'), true);
    $action = $input['action'] ?? '';

    if ($action === 'gift') {
        $recipientEmail = trim($input['email'] ?? '');
        $giftAmount = (int) ($input['credits'] ?? 0);

        if (empty($recipientEmail)) {
            http_response_code(400);
            echo json_encode(['error' => 'Recipient email is required']);
            exit;
        }

        if ($giftAmount < 1) {
            http_response_code(400);
            echo json_encode(['error' => 'Gift amount must be at least 1 credit']);
            exit;
        }

        if ($user['credits'] < $giftAmount) {
            http_response_code(402);
            echo json_encode(['error' => 'Insufficient credits']);
            exit;
        }

        // Prevent self-gifting
        if (strtolower($recipientEmail) === strtolower($user['email'])) {
            http_response_code(400);
            echo json_encode(['error' => 'Cannot gift credits to yourself']);
            exit;
        }

        // Find recipient
        $stmt = $db->prepare("SELECT * FROM users WHERE email = ?");
        $stmt->execute([$recipientEmail]);
        $recipient = $stmt->fetch();

        if (!$recipient) {
            http_response_code(404);
            echo json_encode(['error' => 'Recipient not found. They must have signed in at least once.']);
            exit;
        }

        $db->beginTransaction();

        try {
            // Deduct from sender
            $stmt = $db->prepare("UPDATE users SET credits = credits - ? WHERE id = ? AND credits >= ?");
            $stmt->execute([$giftAmount, $user['id'], $giftAmount]);

            if ($stmt->rowCount() === 0) {
                $db->rollBack();
                http_response_code(402);
                echo json_encode(['error' => 'Insufficient credits']);
                exit;
            }

            // Add to recipient
            $stmt = $db->prepare("UPDATE users SET credits = credits + ? WHERE id = ?");
            $stmt->execute([$giftAmount, $recipient['id']]);

            // Record transactions for both
            $stmt = $db->prepare(
                "INSERT INTO transactions (user_id, type, credits, description) VALUES (?, 'gift_sent', ?, ?)"
            );
            $stmt->execute([$user['id'], -$giftAmount, "Gifted $giftAmount credits to {$recipient['email']}"]);

            $stmt = $db->prepare(
                "INSERT INTO transactions (user_id, type, credits, description) VALUES (?, 'gift_received', ?, ?)"
            );
            $stmt->execute([$recipient['id'], $giftAmount, "Received $giftAmount credits from {$user['email']}"]);

            $db->commit();

            echo json_encode([
                'success' => true,
                'message' => "Gifted $giftAmount credits to $recipientEmail",
                'credits_remaining' => $user['credits'] - $giftAmount,
            ]);

        } catch (Exception $e) {
            $db->rollBack();
            http_response_code(500);
            echo json_encode(['error' => 'Gift failed']);
        }
        exit;
    }

    http_response_code(400);
    echo json_encode(['error' => 'Invalid action']);
    exit;
}

http_response_code(405);
echo json_encode(['error' => 'Method not allowed']);
