-- Grok Imagine AI Playground - Database Schema
-- Run this file to set up the database

CREATE DATABASE IF NOT EXISTS grok_playground CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE grok_playground;

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

-- Generations table
CREATE TABLE IF NOT EXISTS generations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    type ENUM('text_to_image', 'image_to_video', 'text_to_video') NOT NULL,
    prompt TEXT,
    input_url VARCHAR(1024) DEFAULT NULL,
    output_url VARCHAR(1024) DEFAULT NULL,
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
    ('text_to_image_cost', '5'),
    ('image_to_video_cost', '20'),
    ('text_to_video_cost', '25'),
    ('bdt_per_credit', '1'),
    ('site_name', 'Grok Imagine Playground')
ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value);
