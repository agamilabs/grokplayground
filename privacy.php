<?php
require_once 'config.php';
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Privacy Policy - Grok Playground</title>
    <link rel="icon" type="image/svg+xml" href="favicon.svg">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .content-page {
            max-width: 800px;
            margin: 0 auto;
            padding: 100px 24px 60px;
        }

        .content-card {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 40px;
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
        }

        .content-title {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 24px;
            background: linear-gradient(135deg, var(--accent-1), var(--accent-2));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .content-body h2 {
            font-size: 20px;
            font-weight: 600;
            margin: 32px 0 16px;
            color: var(--accent-3);
        }

        .content-body p {
            font-size: 15px;
            line-height: 1.7;
            color: var(--text-secondary);
            margin-bottom: 16px;
        }

        .content-body ul {
            margin-bottom: 20px;
            padding-left: 20px;
        }

        .content-body li {
            font-size: 15px;
            line-height: 1.7;
            color: var(--text-secondary);
            margin-bottom: 8px;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: var(--text-muted);
            text-decoration: none;
            font-size: 14px;
            margin-bottom: 24px;
            transition: color var(--transition);
        }

        .back-link:hover {
            color: var(--text-primary);
        }
    </style>
</head>

<body>
    <div class="bg-glow"></div>
    <div class="bg-glow-2"></div>
    <div class="bg-grid"></div>

    <header class="header">
        <div class="header-inner">
            <a href="/" class="logo">
                <img src="images/logo.svg" alt="Grok Playground Logo" class="logo-icon" width="28" height="28">
                <span>Grok Playground</span>
            </a>
            <nav class="header-nav">
                <a href="/" class="btn btn-ghost btn-sm">Back to Home</a>
            </nav>
        </div>
    </header>

    <main class="content-page">
        <a href="/" class="back-link">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M19 12H5M12 19l-7-7 7-7" />
            </svg>
            Back to Home
        </a>
        <div class="content-card">
            <h1 class="content-title">Privacy Policy</h1>
            <div class="content-body">
                <p>Last Updated: March 21, 2026</p>

                <p>Welcome to <strong>Grok Playground</strong>, a core product under the <strong>AI Solution
                        Bangladesh</strong> project by <strong>AGAMiLabs Ltd.</strong> We
                    are committed to protecting your privacy and ensuring that your personal information is handled in a
                    safe and responsible manner.</p>

                <h2>1. Information We Collect</h2>
                <p>To provide our AI-as-a-Service platform, we collect certain information when you use our website:</p>
                <ul>
                    <li><strong>Account Information:</strong> When you sign in using Google, we receive your email
                        address, name, and profile picture.</li>
                    <li><strong>Usage Data:</strong> We collect information about the prompts you enter and the AI
                        content generated (images, videos, audio).</li>
                    <li><strong>Payment Information:</strong> Payments are processed securely via bKash/EPS. We do not store
                        your wallet details or PIN. we only receive transaction IDs and status updates to credit your
                        account.</li>
                </ul>

                <h2>2. How We Use Your Information</h2>
                <p>We use the collected data for the following purposes:</p>
                <ul>
                    <li>To provide and maintain our AI generation services.</li>
                    <li>To manage your "AI Credits" and transaction history.</li>
                    <li>To improve our platform and user experience.</li>
                    <li>To provide customer support and respond to your inquiries.</li>
                </ul>

                <h2>3. Data Sharing and Disclosure</h2>
                <p>We do not sell your personal data. We share information only with trusted third-party providers
                    necessary for our service:</p>
                <ul>
                    <li><strong>AI Providers:</strong> Your prompts are sent to our AI partners (such as xAI or Fal.ai)
                        to generate content.</li>
                    <li><strong>Payment Gateways:</strong> Transaction details are shared with bKash/EPS to process your
                        credit purchases.</li>
                    <li><strong>Legal Requirements:</strong> We may disclose information if required by law or to
                        protect our rights.</li>
                </ul>

                <h2>4. Security</h2>
                <p>We implement industry-standard security measures to protect your information. However, no method of
                    transmission over the internet is 100% secure, and we cannot guarantee absolute security.</p>

                <h2>5. Your Choices</h2>
                <p>You can manage your account information through your Google Account settings. If you wish to delete
                    your history or account data on our platform, please contact us.</p>

                <h2>6. Contact Us</h2>
                <p>If you have any questions about this Privacy Policy, please contact us at:</p>
                <p><strong>AGAMiLabs Ltd.</strong><br>
                    Email: support@agamilabs.com</p>
            </div>
        </div>
    </main>

    <footer class="footer">
        <p>&copy; 2026 Grok Playground. Produced by AGAMiLabs Ltd. under the AI Solution Bangladesh project.</p>
    </footer>
</body>

</html>