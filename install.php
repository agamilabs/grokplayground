<?php
/**
 * Grok Imagine Playground — Installation Wizard
 * Detects existing setup, allows (re)install of database and config.
 */
session_start();

$baseDir = __DIR__;
$configFile = $baseDir . '/config.php';
$envFile = $baseDir . '/.env';
$schemaFile = $baseDir . '/schema.sql';

// Check existing installation
$isInstalled = false;
$dbConnected = false;
$tablesExist = false;
$envExists = file_exists($envFile);

// Load .env if it exists
if ($envExists) {
    $lines = file($envFile, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    foreach ($lines as $line) {
        if (strpos(trim($line), '#') === 0)
            continue;
        list($name, $value) = explode('=', $line, 2);
        putenv(trim($line));
    }
}

if ($envExists) {
    if (getenv('DB_HOST') && getenv('DB_NAME') && getenv('DB_USER')) {
        try {
            $pdo = new PDO("mysql:host=" . getenv('DB_HOST') . ";dbname=" . getenv('DB_NAME'), getenv('DB_USER'), getenv('DB_PASS'));
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $dbConnected = true;
            // Check if our tables exist
            $stmt = $pdo->query("SHOW TABLES LIKE 'users'");
            $tablesExist = $stmt->rowCount() > 0;
            $isInstalled = $tablesExist;
        } catch (Exception $e) {
            // Connection failed
        }
    }
}

$step = $_POST['step'] ?? ($_GET['step'] ?? 'check');
$error = '';
$success = '';

// Handle form submissions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if ($step === 'database') {
        $dbHost = trim($_POST['db_host'] ?? 'localhost');
        $dbName = trim($_POST['db_name'] ?? '');
        $dbUser = trim($_POST['db_user'] ?? 'root');
        $dbPass = $_POST['db_pass'] ?? '';

        if (empty($dbName)) {
            $error = 'Database name is required.';
            $step = 'database';
        } else {
            // Test connection
            try {
                $pdo = new PDO("mysql:host=$dbHost", $dbUser, $dbPass);
                $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

                // Create database if it doesn't exist
                $pdo->exec("CREATE DATABASE IF NOT EXISTS `$dbName` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
                $pdo->exec("USE `$dbName`");

                // Write .env
                $envContent = "DB_HOST=$dbHost\n";
                $envContent .= "DB_NAME=$dbName\n";
                $envContent .= "DB_USER=$dbUser\n";
                $envContent .= "DB_PASS=$dbPass\n";
                file_put_contents($envFile, $envContent);

                // Run schema
                if (file_exists($schemaFile)) {
                    $sql = file_get_contents($schemaFile);
                    $sql = str_replace('{{DB_NAME}}', $dbName, $sql);
                    $pdo->exec($sql);
                }

                $_SESSION['install_db'] = compact('dbHost', 'dbName', 'dbUser', 'dbPass');
                $step = 'config';
            } catch (Exception $e) {
                $error = 'Database error: ' . $e->getMessage();
                $step = 'database';
            }
        }
    } elseif ($step === 'import_schema') {
        // Just import schema using existing config
        if ($dbConnected && file_exists($schemaFile)) {
            try {
                $sql = file_get_contents($schemaFile);
                $sql = str_replace('{{DB_NAME}}', getenv('DB_NAME'), $sql);
                $pdo->exec($sql);
                $success = 'Schema imported successfully!';
                $tablesExist = true;
                $isInstalled = true;
                $step = 'done';
            } catch (Exception $e) {
                $error = 'Import error: ' . $e->getMessage();
                $step = 'check';
            }
        } else {
            $error = 'Database not connected or schema file missing.';
            $step = 'check';
        }
    } elseif ($step === 'config') {
        $db = $_SESSION['install_db'] ?? [];
        $xaiKey = trim($_POST['xai_key'] ?? '');
        $fbProjectId = trim($_POST['firebase_project_id'] ?? '');
        $siteUrl = trim($_POST['site_url'] ?? '');
        $bkashAppKey = trim($_POST['bkash_app_key'] ?? '');
        $bkashAppSecret = trim($_POST['bkash_app_secret'] ?? '');
        $bkashUsername = trim($_POST['bkash_username'] ?? '');
        $bkashPassword = trim($_POST['bkash_password'] ?? '');
        $bkashBaseUrl = trim($_POST['bkash_base_url'] ?? 'https://tokenized.sandbox.bka.sh/v1.2.0-beta');

        if (empty($xaiKey)) {
            $error = 'xAI API key is required.';
            $step = 'config';
        } else {
            // Store in Database instead of config.php
            try {
                $pdo = new PDO("mysql:host=" . getenv('DB_HOST') . ";dbname=" . getenv('DB_NAME'), getenv('DB_USER'), getenv('DB_PASS'));
                $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

                $settings = [
                    'xai_api_key' => $xaiKey,
                    'firebase_project_id' => $fbProjectId,
                    'site_url' => $siteUrl ?: 'http://localhost/groksubscription',
                    'bkash_app_key' => $bkashAppKey,
                    'bkash_app_secret' => $bkashAppSecret,
                    'bkash_username' => $bkashUsername,
                    'bkash_password' => $bkashPassword,
                    'bkash_base_url' => $bkashBaseUrl,
                ];

                $stmt = $pdo->prepare("INSERT INTO admin_settings (setting_key, setting_value) VALUES (?, ?) ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)");
                foreach ($settings as $key => $val) {
                    $stmt->execute([$key, $val]);
                }

                unset($_SESSION['install_db']);
                $step = 'done';
                $success = 'Installation completed successfully!';
            } catch (Exception $e) {
                $error = 'Could not save settings to database: ' . $e->getMessage();
                $step = 'config';
            }
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Install — Grok Imagine Playground</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .install-page {
            max-width: 560px;
            margin: 80px auto 40px;
            padding: 0 24px;
        }

        .install-card {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 32px;
        }

        .install-title {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 4px;
        }

        .install-desc {
            font-size: 14px;
            color: var(--text-muted);
            margin-bottom: 24px;
        }

        .install-steps {
            display: flex;
            gap: 8px;
            margin-bottom: 28px;
        }

        .install-step {
            flex: 1;
            height: 4px;
            border-radius: 2px;
            background: var(--border);
        }

        .install-step.done {
            background: var(--success);
        }

        .install-step.active {
            background: linear-gradient(135deg, var(--accent-1), var(--accent-2));
        }

        .field {
            margin-bottom: 16px;
        }

        .field label {
            font-size: 13px;
            font-weight: 500;
            color: var(--text-secondary);
            margin-bottom: 6px;
            display: block;
        }

        .field input,
        .field select {
            width: 100%;
            padding: 10px 14px;
            border-radius: var(--radius-sm);
            background: rgba(255, 255, 255, 0.04);
            border: 1px solid var(--border);
            color: var(--text-primary);
            font-family: var(--font);
            font-size: 14px;
        }

        .field input:focus,
        .field select:focus {
            outline: none;
            border-color: var(--border-focus);
        }

        .field .hint {
            font-size: 11px;
            color: var(--text-muted);
            margin-top: 4px;
        }

        .alert-error {
            background: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.3);
            border-radius: var(--radius-md);
            padding: 12px 16px;
            margin-bottom: 16px;
            font-size: 14px;
            color: var(--error);
        }

        .alert-success {
            background: rgba(34, 197, 94, 0.1);
            border: 1px solid rgba(34, 197, 94, 0.3);
            border-radius: var(--radius-md);
            padding: 12px 16px;
            margin-bottom: 16px;
            font-size: 14px;
            color: var(--success);
        }

        .status-card {
            background: var(--bg-glass);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 16px;
            margin-bottom: 20px;
        }

        .status-row {
            display: flex;
            justify-content: space-between;
            padding: 6px 0;
            font-size: 14px;
        }

        .status-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 6px;
        }

        .status-dot.green {
            background: var(--success);
        }

        .status-dot.red {
            background: var(--error);
        }

        .status-dot.yellow {
            background: var(--warning);
        }

        .install-actions {
            display: flex;
            gap: 12px;
            margin-top: 24px;
        }
    </style>
</head>

<body>
    <div class="install-page">
        <div class="install-card">
            <!-- Progress Steps -->
            <div class="install-steps">
                <div
                    class="install-step <?= in_array($step, ['database', 'config', 'done']) ? 'done' : ($step === 'check' ? 'active' : '') ?>">
                </div>
                <div
                    class="install-step <?= in_array($step, ['config', 'done']) ? 'done' : ($step === 'database' ? 'active' : '') ?>">
                </div>
                <div class="install-step <?= $step === 'done' ? 'done' : ($step === 'config' ? 'active' : '') ?>"></div>
            </div>

            <?php if ($error): ?>
                <div class="alert-error">
                    <?= htmlspecialchars($error) ?>
                </div>
            <?php endif; ?>
            <?php if ($success): ?>
                <div class="alert-success">
                    <?= htmlspecialchars($success) ?>
                </div>
            <?php endif; ?>

            <?php if ($step === 'check'): ?>
                <h1 class="install-title">Grok Imagine Setup</h1>
                <p class="install-desc">Check your system status and install or reinstall the application.</p>

                <div class="status-card">
                    <div class="status-row">
                        <span>PHP Version
                            <?= phpversion() ?>
                        </span>
                        <span><span
                                class="status-dot <?= version_compare(phpversion(), '7.4', '>=') ? 'green' : 'red' ?>"></span>
                            <?= version_compare(phpversion(), '7.4', '>=') ? 'OK' : 'Needs 7.4+' ?>
                        </span>
                    </div>
                    <div class="status-row">
                        <span>PDO MySQL Extension</span>
                        <span><span class="status-dot <?= extension_loaded('pdo_mysql') ? 'green' : 'red' ?>"></span>
                            <?= extension_loaded('pdo_mysql') ? 'OK' : 'Missing' ?>
                        </span>
                    </div>
                    <div class="status-row">
                        <span>cURL Extension</span>
                        <span><span class="status-dot <?= extension_loaded('curl') ? 'green' : 'red' ?>"></span>
                            <?= extension_loaded('curl') ? 'OK' : 'Missing' ?>
                        </span>
                    </div>
                    <div class="status-row">
                        <span>Config File</span>
                        <span><span class="status-dot <?= $configExists ? 'green' : 'yellow' ?>"></span>
                            <?= $configExists ? 'Found' : 'Not found' ?>
                        </span>
                    </div>
                    <div class="status-row">
                        <span>Database Connection</span>
                        <span><span
                                class="status-dot <?= $dbConnected ? 'green' : ($configExists ? 'red' : 'yellow') ?>"></span>
                            <?= $dbConnected ? 'Connected' : ($configExists ? 'Failed' : 'Not configured') ?>
                        </span>
                    </div>
                    <div class="status-row">
                        <span>Tables Created</span>
                        <span><span class="status-dot <?= $tablesExist ? 'green' : 'yellow' ?>"></span>
                            <?= $tablesExist ? 'Yes' : 'No' ?>
                        </span>
                    </div>
                </div>

                <?php if ($isInstalled): ?>
                    <p style="font-size:14px;color:var(--success);margin-bottom:12px;">✓ System is installed and running.</p>
                    <div class="install-actions">
                        <a href="/" class="btn btn-primary">Go to Playground</a>
                        <form method="POST" style="display:inline-block;">
                            <input type="hidden" name="step" value="database">
                            <button type="submit" class="btn btn-ghost">Reinstall</button>
                        </form>
                    </div>
                <?php else: ?>
                    <form method="POST">
                        <input type="hidden" name="step" value="database">
                        <button type="submit" class="btn btn-primary" style="width:100%;margin-bottom:12px;">Start Full
                            Installation</button>
                    </form>
                    <?php if ($dbConnected && !$tablesExist): ?>
                        <form method="POST">
                            <input type="hidden" name="step" value="import_schema">
                            <button type="submit" class="btn btn-ghost" style="width:100%;">Import Schema Only (to existing
                                DB)</button>
                        </form>
                    <?php endif; ?>
                <?php endif; ?>

            <?php elseif ($step === 'database'): ?>
                <h1 class="install-title">Database Setup</h1>
                <p class="install-desc">Enter your MySQL database credentials.</p>

                <form method="POST">
                    <input type="hidden" name="step" value="database">
                    <div class="field">
                        <label>Database Host</label>
                        <input type="text" name="db_host" value="<?= htmlspecialchars($_POST['db_host'] ?? 'localhost') ?>"
                            required>
                    </div>
                    <div class="field">
                        <label>Database Name</label>
                        <input type="text" name="db_name"
                            value="<?= htmlspecialchars($_POST['db_name'] ?? 'grok_imagine') ?>" required>
                        <div class="hint">Will be created if it doesn't exist</div>
                    </div>
                    <div class="field">
                        <label>Database User</label>
                        <input type="text" name="db_user" value="<?= htmlspecialchars($_POST['db_user'] ?? 'root') ?>"
                            required>
                    </div>
                    <div class="field">
                        <label>Database Password</label>
                        <input type="password" name="db_pass" value="">
                    </div>
                    <button type="submit" class="btn btn-primary" style="width:100%;">Set Up Database →</button>
                </form>

            <?php elseif ($step === 'config'): ?>
                <h1 class="install-title">API Configuration</h1>
                <p class="install-desc">Enter your API keys and service credentials.</p>

                <form method="POST">
                    <input type="hidden" name="step" value="config">
                    <div class="field">
                        <label>xAI API Key *</label>
                        <input type="text" name="xai_key" placeholder="xai-..." required>
                        <div class="hint">Get from <a href="https://console.x.ai" target="_blank"
                                style="color:var(--accent-3);">console.x.ai</a></div>
                    </div>
                    <div class="field">
                        <label>Firebase Project ID</label>
                        <input type="text" name="firebase_project_id" placeholder="my-project-12345">
                    </div>
                    <div class="field">
                        <label>Site URL</label>
                        <input type="text" name="site_url" placeholder="http://localhost/groksubscription"
                            value="<?= 'http://' . ($_SERVER['HTTP_HOST'] ?? 'localhost') . dirname($_SERVER['SCRIPT_NAME']) ?>">
                    </div>
                    <hr style="border-color:var(--border);margin:20px 0;">
                    <p style="font-size:13px;font-weight:600;color:var(--text-secondary);margin-bottom:12px;">bKash Payment
                        (Optional)</p>
                    <div class="field">
                        <label>bKash App Key</label>
                        <input type="text" name="bkash_app_key" placeholder="Optional">
                    </div>
                    <div class="field">
                        <label>bKash App Secret</label>
                        <input type="text" name="bkash_app_secret" placeholder="Optional">
                    </div>
                    <div class="field">
                        <label>bKash Username</label>
                        <input type="text" name="bkash_username" placeholder="Optional">
                    </div>
                    <div class="field">
                        <label>bKash Password</label>
                        <input type="password" name="bkash_password" placeholder="Optional">
                    </div>
                    <div class="field">
                        <label>bKash Base URL</label>
                        <input type="text" name="bkash_base_url" value="https://tokenized.sandbox.bka.sh/v1.2.0-beta">
                    </div>
                    <button type="submit" class="btn btn-primary" style="width:100%;">Save Configuration →</button>
                </form>

            <?php elseif ($step === 'done'): ?>
                <h1 class="install-title">🎉 All Set!</h1>
                <p class="install-desc">Your Grok Imagine Playground is ready. Don't forget to update <code
                        style="color:var(--accent-3);">js/firebase-config.js</code> with your Firebase credentials.</p>

                <div class="status-card">
                    <div class="status-row"><span>Database</span><span style="color:var(--success);">✓ Created</span></div>
                    <div class="status-row"><span>Config</span><span style="color:var(--success);">✓ Saved</span></div>
                    <div class="status-row"><span>Schema</span><span style="color:var(--success);">✓ Imported</span></div>
                </div>

                <p style="font-size:13px;color:var(--text-muted);margin-bottom:20px;">
                    <strong>Next:</strong> Set yourself as admin:<br>
                    <code
                        style="color:var(--accent-3);font-size:12px;">UPDATE users SET is_admin = 1 WHERE email = 'you@email.com';</code>
                </p>

                <a href="/" class="btn btn-primary" style="width:100%;justify-content:center;">Go to Playground →</a>
            <?php endif; ?>
        </div>
    </div>
</body>

</html>