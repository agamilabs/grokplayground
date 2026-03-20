<?php
require_once 'config.php';
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Terms and Conditions - Grok Playground</title>
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
            <h1 class="content-title">Terms and Conditions</h1>
            <div class="content-body">
                <p>Last Updated: March 21, 2026</p>

                <p>These Terms and Conditions govern your use of <strong>Grok Playground</strong>, a core product under
                    the <strong>AI Solution Bangladesh</strong> project by
                    <strong>AGAMiLabs Ltd.</strong> By accessing or using our platform, you agree to be bound by these
                    terms.
                </p>

                <h2>1. Acceptance of Terms</h2>
                <p>By creating an account or using our services, you confirm that you are at least 18 years old or have
                    parental consent, and that you have read and agree to these terms.</p>

                <h2>2. Service Description</h2>
                <p><strong>Grok Playground</strong> is a unified AI-as-a-Service (AIaaS) platform provided under the
                    <strong>AI Solution Bangladesh</strong> project. We integrate APIs from
                    leading AI providers to allow text-to-image, text-to-video, image-to-video, and text-to-audio
                    generation.</p>

                <h2>3. AI Credits & Pay-as-you-go Model</h2>
                <ul>
                    <li><strong>Flexible Model:</strong> Instead of monthly subscriptions, we offer a pay-as-you-go
                        approach.</li>
                    <li><strong>AI Credits:</strong> Users are charged in "AI Credits" based on usage. Credits can be
                        purchased in transactions ranging from 20 to 5,000 credits.</li>
                    <li><strong>Non-Refundable:</strong> Once purchased, AI Credits are non-refundable and cannot be
                        exchanged for cash, except as required by law.</li>
                    <li><strong>Credit Expiry:</strong> Credits do not expire as long as your account remains active.
                    </li>
                </ul>

                <h2>4. Payments via bKash</h2>
                <p>As we initially target Bangladeshi customers, we partner with <strong>bKash</strong> for seamless and
                    secure payment collection. You are responsible for ensuring your bKash account has sufficient funds
                    for credit purchases.</p>

                <h2>5. User Responsibilities & Prohibited Use</h2>
                <p>You agree not to use our platform to generate:</p>
                <ul>
                    <li>Illegal, harmful, or threatening content.</li>
                    <li>Pornographic or sexually explicit material.</li>
                    <li>Content that infringes on intellectual property rights.</li>
                    <li>Hate speech or discriminatory content.</li>
                </ul>
                <p>Violation of these rules may lead to immediate account suspension without refund.</p>

                <h2>6. Intellectual Property</h2>
                <p>You own the rights to the AI content you generate using our platform, subject to the terms of the
                    underlying AI model providers (e.g., xAI, Fal.ai).</p>

                <h2>7. Limitation of Liability</h2>
                <p><strong>Grok Playground</strong> is provided "as is." We do not guarantee that the generated content
                    will meet
                    your expectations or that the service will be uninterrupted. AGAMiLabs Ltd. is not liable for any
                    damages resulting from your use of the platform.</p>

                <h2>8. Changes to Terms</h2>
                <p>We reserves the right to update these terms at any time. Significant changes will be announced on our
                    website.</p>

                <h2>9. Governing Law</h2>
                <p>These terms are governed by the laws of Bangladesh. Any disputes shall be resolved in the courts of
                    Dhaka, Bangladesh.</p>

                <h2>10. Contact Information</h2>
                <p>For inquiries regarding these terms, please contact:<br>
                    <strong>AGAMiLabs Ltd.</strong><br>
                    Email: legal@agamilabs.com
                </p>
            </div>
        </div>
    </main>

    <footer class="footer">
        <p>&copy; 2026 Grok Playground. Produced by AGAMiLabs Ltd. under the AI Solution Bangladesh project.</p>
    </footer>
</body>

</html>