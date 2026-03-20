<?php
/**
 * bKash URL Checkout Integration
 * POST action=create  : Create a bKash payment → return bkashURL
 * GET  action=callback : Handle bKash success/failure/cancel callbacks
 */
require_once __DIR__ . '/../config.php';
require_once __DIR__ . '/../db.php';

// ─── bKash Token Grant ─────────────────────────────────────

function bkashGrantToken($forceRefresh = false)
{
    if (!$forceRefresh) {
        // Try to get cached token
        $cachedToken = getSetting('bkash_id_token');
        $cachedTime = (int) getSetting('bkash_token_created_at', 0);

        // If token exists and is less than 50 minutes old (3000 seconds), reuse it
        if ($cachedToken && (time() - $cachedTime) < 3000) {
            return ['id_token' => $cachedToken, 'cached' => true];
        }
    }

    $url = BKASH_BASE_URL . '/tokenized/checkout/token/grant';

    $payload = [
        'app_key' => BKASH_APP_KEY,
        'app_secret' => BKASH_APP_SECRET,
    ];

    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => json_encode($payload),
        CURLOPT_HTTPHEADER => [
            'Content-Type:application/json',
            'Accept:application/json',
            'username:' . BKASH_USERNAME,
            'password:' . BKASH_PASSWORD,
        ],
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_IPRESOLVE => CURL_IPRESOLVE_V4,
        CURLOPT_SSL_VERIFYHOST => false,
        CURLOPT_SSL_VERIFYPEER => false,
        CURLOPT_TIMEOUT => 30,
    ]);

    $response = curl_exec($ch);
    curl_close($ch);

    $result = json_decode($response, true);

    // Cache the new token if successful
    if (isset($result['id_token'])) {
        setSetting('bkash_id_token', $result['id_token']);
        setSetting('bkash_token_created_at', time());
    } else {
        // Log error details for debugging (Internal JSON error response will catch this)
        error_log("bKash Token Grant Failed: " . $response);
    }

    return $result;
}

// ─── Create Payment ────────────────────────────────────────

function bkashCreatePayment($idToken, $amount, $invoiceNumber)
{
    $url = BKASH_BASE_URL . '/tokenized/checkout/create';

    $payload = [
        'mode' => '0011',
        'payerReference' => $invoiceNumber,
        'callbackURL' => SITE_URL . '/api/bkash.php?action=callback',
        'amount' => (string) $amount,
        'currency' => 'BDT',
        'intent' => 'sale',
        'merchantInvoiceNumber' => $invoiceNumber,
    ];

    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => json_encode($payload),
        CURLOPT_HTTPHEADER => [
            'Content-Type:application/json',
            'Accept:application/json',
            'Authorization:' . trim($idToken),
            'X-APP-Key:' . trim(BKASH_APP_KEY),
        ],
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_IPRESOLVE => CURL_IPRESOLVE_V4,
        CURLOPT_SSL_VERIFYHOST => false,
        CURLOPT_SSL_VERIFYPEER => false,
        CURLOPT_TIMEOUT => 30,
    ]);

    $response = curl_exec($ch);
    curl_close($ch);

    return json_decode($response, true);
}

// ─── Execute Payment ───────────────────────────────────────

function bkashExecutePayment($idToken, $paymentID)
{
    $url = BKASH_BASE_URL . '/tokenized/checkout/execute';

    $payload = ['paymentID' => $paymentID];

    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => json_encode($payload),
        CURLOPT_HTTPHEADER => [
            'Content-Type:application/json',
            'Accept:application/json',
            'Authorization:' . trim($idToken),
            'X-APP-Key:' . trim(BKASH_APP_KEY),
        ],
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_IPRESOLVE => CURL_IPRESOLVE_V4,
        CURLOPT_SSL_VERIFYHOST => false,
        CURLOPT_SSL_VERIFYPEER => false,
        CURLOPT_TIMEOUT => 30,
    ]);

    $response = curl_exec($ch);
    curl_close($ch);

    return json_decode($response, true);
}

// ─── Route Handling ────────────────────────────────────────

$action = $_GET['action'] ?? $_POST['action'] ?? '';

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $action === 'create') {
    // Authenticated — user wants to buy credits
    header('Content-Type: application/json');
    require_once __DIR__ . '/../auth.php';
    $user = authenticateRequest();

    $input = json_decode(file_get_contents('php://input'), true);
    $credits = (int) ($input['credits'] ?? 0);

    if ($credits < 20 || $credits > 5000) {
        http_response_code(400);
        echo json_encode(['error' => 'Credits must be between 20 and 5000']);
        exit;
    }

    // Calculate BDT amount
    $bdtPerCredit = (float) getSetting('bdt_per_credit', '1');
    $amount = round($credits * $bdtPerCredit, 2);

    if ($amount < 1) {
        http_response_code(400);
        echo json_encode(['error' => 'Amount too low']);
        exit;
    }

    // Check for credentials
    if (empty(BKASH_APP_KEY) || empty(BKASH_APP_SECRET) || empty(BKASH_USERNAME) || empty(BKASH_PASSWORD)) {
        http_response_code(500);
        echo json_encode(['error' => 'bKash credentials not configured in database']);
        exit;
    }

    // Grant token
    $tokenResponse = bkashGrantToken();
    $bkashIdToken = $tokenResponse['id_token'] ?? null;

    if (!$bkashIdToken) {
        http_response_code(500);
        echo json_encode(['error' => 'Failed to get bKash token', 'details' => $tokenResponse]);
        exit;
    }

    // Create payment
    $invoiceNumber = 'GRK' . time() . rand(100, 999);
    $paymentResponse = bkashCreatePayment($bkashIdToken, $amount, $invoiceNumber);

    // If Unauthorized, token might be expired. Refresh and try once more.
    if (isset($paymentResponse['message']) && strtolower($paymentResponse['message']) === 'unauthorized') {
        $tokenResponse = bkashGrantToken(true);
        $bkashIdToken = $tokenResponse['id_token'] ?? null;
        if ($bkashIdToken) {
            $paymentResponse = bkashCreatePayment($bkashIdToken, $amount, $invoiceNumber);
        }
    }

    $bkashURL = $paymentResponse['bkashURL'] ?? null;
    $paymentID = $paymentResponse['paymentID'] ?? null;

    if (!$bkashURL || !$paymentID) {
        http_response_code(500);
        // Regenerate payload array for exact debug output
        $debugPayload = [
            'mode' => '0011',
            'payerReference' => $invoiceNumber,
            'callbackURL' => SITE_URL . '/api/bkash.php?action=callback',
            'amount' => (string) $amount,
            'currency' => 'BDT',
            'intent' => 'sale',
            'merchantInvoiceNumber' => $invoiceNumber,
        ];
        echo json_encode([
            'error' => 'Failed to create bKash payment',
            'details' => $paymentResponse,
            'debug_payload' => $debugPayload
        ], JSON_UNESCAPED_SLASHES);
        exit;
    }

    // Store pending payment
    $db = getDB();
    $stmt = $db->prepare(
        "INSERT INTO bkash_payments (user_id, payment_id, amount, credits, status) VALUES (?, ?, ?, ?, 'pending')"
    );
    $stmt->execute([$user['id'], $paymentID, $amount, $credits]);

    // Store bKash token in session for execute step
    session_start();
    $_SESSION['bkash_token'] = $bkashIdToken;
    $_SESSION['bkash_payment_id'] = $paymentID;

    echo json_encode([
        'success' => true,
        'bkashURL' => $bkashURL,
        'paymentID' => $paymentID,
    ]);
    exit;
}

if ($action === 'callback') {
    // bKash redirects here after payment
    $paymentID = $_GET['paymentID'] ?? '';
    $status = $_GET['status'] ?? '';

    $db = getDB();

    if ($status === 'success' && !empty($paymentID)) {
        // Execute payment
        session_start();
        $bkashIdToken = $_SESSION['bkash_token'] ?? null;

        if (!$bkashIdToken) {
            // Re-grant token if session lost
            $tokenResponse = bkashGrantToken();
            $bkashIdToken = $tokenResponse['id_token'] ?? null;
        }

        if ($bkashIdToken) {
            $execResult = bkashExecutePayment($bkashIdToken, $paymentID);

            // If Unauthorized, token might be expired. Force refresh and try once more.
            if (isset($execResult['message']) && strtolower($execResult['message']) === 'unauthorized') {
                $tokenResponse = bkashGrantToken(true);
                $bkashIdToken = $tokenResponse['id_token'] ?? null;
                if ($bkashIdToken) {
                    $execResult = bkashExecutePayment($bkashIdToken, $paymentID);
                }
            }

            if (($execResult['statusCode'] ?? '') === '0000' || ($execResult['transactionStatus'] ?? '') === 'Completed') {
                $trxID = $execResult['trxID'] ?? '';

                // Find the pending payment
                $stmt = $db->prepare("SELECT * FROM bkash_payments WHERE payment_id = ? AND status = 'pending'");
                $stmt->execute([$paymentID]);
                $payment = $stmt->fetch();

                if ($payment) {
                    $db->beginTransaction();

                    // Update payment status
                    $stmt = $db->prepare("UPDATE bkash_payments SET status = 'completed', trx_id = ? WHERE id = ?");
                    $stmt->execute([$trxID, $payment['id']]);

                    // Add credits to user
                    $stmt = $db->prepare("UPDATE users SET credits = credits + ? WHERE id = ?");
                    $stmt->execute([$payment['credits'], $payment['user_id']]);

                    // Record transaction
                    $stmt = $db->prepare(
                        "INSERT INTO transactions (user_id, type, amount, credits, description, bkash_trx_id) VALUES (?, 'purchase', ?, ?, ?, ?)"
                    );
                    $stmt->execute([
                        $payment['user_id'],
                        $payment['amount'],
                        $payment['credits'],
                        "Purchased {$payment['credits']} credits via bKash",
                        $trxID
                    ]);

                    $db->commit();
                }

                // Redirect back to site with success
                header('Location: ' . SITE_URL . '/?payment=success&credits=' . ($payment['credits'] ?? 0));
                exit;
            }
        }

        // Execute failed
        $stmt = $db->prepare("UPDATE bkash_payments SET status = 'failed' WHERE payment_id = ?");
        $stmt->execute([$paymentID]);

        header('Location: ' . SITE_URL . '/?payment=failed');
        exit;
    }

    // Payment cancelled or failed
    if (!empty($paymentID)) {
        $newStatus = ($status === 'cancel') ? 'cancelled' : 'failed';
        $stmt = $db->prepare("UPDATE bkash_payments SET status = ? WHERE payment_id = ?");
        $stmt->execute([$newStatus, $paymentID]);
    }

    header('Location: ' . SITE_URL . '/?payment=' . ($status === 'cancel' ? 'cancelled' : 'failed'));
    exit;
}

http_response_code(400);
header('Content-Type: application/json');
echo json_encode(['error' => 'Invalid action']);
