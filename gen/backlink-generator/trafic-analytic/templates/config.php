<?php
// config.php - Konfigurasi terpusat untuk semua file
define('DB_HOST', 'localhost');
define('DB_USER', 'username');
define('DB_PASS', 'password');
define('DB_NAME', 'traffic_db');

// Konfigurasi keamanan
define('SITE_URL', 'https://yourdomain.com');
define('ADMIN_EMAIL', 'admin@yourdomain.com');

// Konfigurasi track
define('TRACK_CHANCE_PERCENT', 30); // Peluang generate backlink
define('SESSION_TIMEOUT', 1800); // 30 menit

// API Keys (simpan di environment atau database)
$api_keys = [
    'backlink_service' => 'YOUR_API_KEY',
];

// Error reporting (matikan di production)
error_reporting(E_ALL);
ini_set('display_errors', 0); // 0 di production, 1 di development
?>