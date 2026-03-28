<?php
require_once 'config.php';
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Grok Playground</title>
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
            font-size: 16px;
            line-height: 1.8;
            color: var(--text-secondary);
            margin-bottom: 20px;
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

        .highlight {
            color: var(--accent-2);
            font-weight: 600;
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
            <h1 class="content-title">About Grok Playground</h1>
            <div class="content-body">
                <p><strong>Grok Playground</strong>, a core product under the <strong>AI Solution Bangladesh</strong>
                    project by <span class="highlight">AGAMiLabs Ltd.</span>,
                    is focused on developing a unified AI-as-a-Service (AIaaS) platform that provides users with access
                    to advanced AI capabilities, including text-to-image, text-to-video, image-to-video, and
                    text-to-audio generation.</p>

                <p>Unlike many existing platforms that depend on expensive subscription models, our solution adopts a
                    flexible <span class="highlight">pay-as-you-go approach</span>, allowing users to pay only for what
                    they use. To enable this, we integrate APIs from leading AI providers into a single, easy-to-use
                    platform.</p>

                <p>Users are billed through a system of <strong>"AI Credits"</strong> based on their usage, with the
                    ability to purchase between 20 and 5,000 credits per transaction. This model makes powerful AI tools
                    more accessible and affordable for a broader audience.</p>

                <p>As the platform initially targets customers in Bangladesh, partnering with a trusted payment gateway
                    like <span class="highlight">bKash</span>, <span class="highlight">EPS</span> is essential for smooth and reliable payment collection.
                    Integrating a widely used local payment solution will simplify the process of purchasing AI Credits,
                    improve user convenience, and help build trust within the local market.</p>
            </div>
        </div>
    </main>

    <footer class="footer">
        <p>&copy; 2026 Grok Playground. Produced by AGAMiLabs Ltd. under the AI Solution Bangladesh project.</p>
    </footer>
</body>

</html>