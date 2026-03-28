<?php
require_once __DIR__ . '/db.php';

try {
    $db = getDB();
    
    // Check if column exists first to avoid error
    $check = $db->query("SHOW COLUMNS FROM users LIKE 'referred_by'")->fetch();
    if (!$check) {
        echo "Adding referred_by column to users table...\n";
        $db->exec("ALTER TABLE users ADD COLUMN referred_by INT NULL DEFAULT NULL AFTER credits");
        $db->exec("ALTER TABLE users ADD CONSTRAINT fk_referred_by FOREIGN KEY (referred_by) REFERENCES users(id) ON DELETE SET NULL");
        $db->exec("CREATE INDEX idx_referred_by ON users(referred_by)");
        echo "Column added.\n";
    } else {
        echo "referred_by column already exists.\n";
    }

    echo "Inserting default referral settings...\n";
    $stmt = $db->prepare("INSERT INTO admin_settings (setting_key, setting_value) VALUES (?, ?) ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)");
    
    $settings = [
        ['referral_reward_referrer', '10'],
        ['referral_reward_invitee', '5']
    ];

    foreach ($settings as $s) {
        $stmt->execute($s);
        echo "Setting {$s[0]} set to {$s[1]}.\n";
    }

    echo "Migration completed successfully.\n";

} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
