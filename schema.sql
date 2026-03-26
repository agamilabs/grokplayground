-- Grok Imagine AI Playground - Database Schema
-- Run this file to set up the database

CREATE DATABASE IF NOT EXISTS `{{DB_NAME}}` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `{{DB_NAME}}`;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    firebase_uid VARCHAR(128) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL,
    display_name VARCHAR(255) DEFAULT '',
    photo_url VARCHAR(512) DEFAULT '',
    credits INT NOT NULL DEFAULT 0,
    is_admin TINYINT(1) NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_firebase_uid (firebase_uid),
    INDEX idx_email (email)
) ENGINE=InnoDB;

-- Transactions table
CREATE TABLE IF NOT EXISTS transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    type ENUM('purchase', 'spend', 'gift_sent', 'gift_received') NOT NULL,
    amount DECIMAL(10,2) DEFAULT 0.00,
    credits INT NOT NULL,
    description VARCHAR(500) DEFAULT '',
    bkash_trx_id VARCHAR(100) DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_type (type)
) ENGINE=InnoDB;

-- generations table
CREATE TABLE IF NOT EXISTS generations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    type ENUM('text_to_image', 'image_edit', 'image_to_video', 'text_to_video', 'text_to_audio') NOT NULL,
    prompt TEXT,
    input_url VARCHAR(1024) DEFAULT NULL,
    input_size INT DEFAULT 0,
    input_thumbnail VARCHAR(1024) DEFAULT NULL,
    output_url VARCHAR(1024) DEFAULT NULL,
    output_size INT DEFAULT 0,
    resolution VARCHAR(20) DEFAULT '480p',
    status ENUM('pending', 'processing', 'completed', 'failed') DEFAULT 'pending',
    xai_request_id VARCHAR(255) DEFAULT NULL,
    credits_used INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_status (status)
) ENGINE=InnoDB;

-- Admin settings table (key-value store)
CREATE TABLE IF NOT EXISTS admin_settings (
    setting_key VARCHAR(100) PRIMARY KEY,
    setting_value VARCHAR(500) NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- bKash payments table
CREATE TABLE IF NOT EXISTS bkash_payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    payment_id VARCHAR(100) NOT NULL,
    trx_id VARCHAR(100) DEFAULT NULL,
    amount DECIMAL(10,2) NOT NULL,
    credits INT NOT NULL,
    status ENUM('pending', 'completed', 'failed', 'cancelled') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_payment_id (payment_id)
) ENGINE=InnoDB;

-- Default admin settings
INSERT INTO admin_settings (setting_key, setting_value) VALUES
    ('bdt_per_usd', '145'),
    ('bdt_per_credit', '2'),
    ('text_to_image_cost', '0.04'),
    ('image_pro_cost', '0.14'),
    ('video_480p_cost', '0.10'),
    ('video_720p_cost', '0.18'),
    ('audio_per_1k_chars_cost', '0.0084'),
    ('site_name', 'Grok Playground'),
    ('xai_api_key', ''),
    ('xai_base_url', 'https://api.x.ai/v1'),
    ('firebase_project_id', ''),
    ('site_url', 'http://localhost/groksubscription'),
    ('bkash_app_key', ''),
    ('bkash_app_secret', ''),
    ('bkash_username', ''),
    ('bkash_password', ''),
    ('bkash_base_url', 'https://tokenized.sandbox.bka.sh/v1.2.0-beta'),
    ('global_markup', '1.5')
ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value);

-- Showcase categories table
CREATE TABLE IF NOT EXISTS showcase_categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Showcase items table
CREATE TABLE IF NOT EXISTS showcase_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT DEFAULT NULL,
    title VARCHAR(255) NOT NULL,
    prompt TEXT NOT NULL,
    description TEXT,
    type ENUM('text_to_image', 'image_edit', 'image_to_video', 'text_to_video', 'text_to_audio') NOT NULL,
    model_used VARCHAR(100),
    settings_json TEXT,
    output_url TEXT,
    votes INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES showcase_categories(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Showcase votes table
CREATE TABLE IF NOT EXISTS showcase_votes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    item_id INT NOT NULL,
    vote TINYINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY (user_id, item_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES showcase_items(id) ON DELETE CASCADE
) ENGINE=InnoDB;


