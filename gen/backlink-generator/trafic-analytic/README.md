# Website Traffic Analytics System

System for use on Kali Linux features:

- ✅ Real-time traffic tracking

- ✅ Auto backlink generation

- ✅ Multi-website support

- ✅ Secure admin dashboard

- ✅ Database optimization

- ✅ Security features

- ✅ Monitoring tools

* To deploy to another website, simply embed the tracking script and configure the site_id in the dashboard!

```
git clone https://github.com/readloud/Web-Traffic-Analytics-.git
```

## 📦 **1. INITIAL SETUP OF KALI LINUX**

```bash
# 1. Update the Kali Linux system
sudo apt update && sudo apt upgrade -y

# 2. Install the required packages
sudo apt install -y 
apache2 
mysql-server 
php 
php-mysql 
php-curl 
php-json 
php-mbstring 
php-xml 
libapache2-mod-php 
git 
curl 
composer

# 3. Enable Apache and MySQL
sudo systemctl start apache2
sudo systemctl enable apache2
sudo systemctl start mysql
sudo systemctl enable mysql

# 4. Configure MySQL security
sudo mysql_secure_installation
# Answer the questions:
# - Set root password? Y
# - New password: (e.g.) Traffic@2024
# - Remove anonymous users? Y
# - Disallow root login remotely? Y
# - Remove test database? Y
# - Reload privilege tables? Y
```

## 🗂️ **2. SETUP PROJECT STRUCTURE**

```bash
# 1. Create the project directory
sudo mkdir -p /var/www/html/traffic
sudo chown -R $USER:$USER /var/www/html/traffic
cd /var/www/html/traffic

# 2. Clone the repository or create the structure manually
# Folder structure:
# traffic/
# ├── admin.php
# ├── track.php
# ├── login.php
# ├── config.php
# ├── database.php
# ├── schema.sql
# ├── .htaccess
# ├── install.php
# ├── README.md
# ├── index.html (redirect)
# ├── assets/ (optional)
# └── logs/ (for error logs)

# 3. Create main files
touch admin.php track.php login.php config.php database.php schema.sql .htaccess install.php index.html

# 4. Create logs folder
mkdir logs
chmod 755 logs
```

## 🗄️ **3. DATABASE CONFIGURATION**

### **File: schema.sql**
```bash
cat > schema.sql << 'EOF'
-- Traffic Analytics Database Schema for Kali Linux
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- Database: traffic_db
CREATE DATABASE IF NOT EXISTS `traffic_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `traffic_db`;

-- Table: sites
CREATE TABLE `sites` (
  `id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `domain` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_active` tinyint(1) DEFAULT 1,
  `api_key` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: visitors
CREATE TABLE `visitors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `site_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `referrer` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `page_url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `visit_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `country` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `browser` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `screen_resolution` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `session_duration` int(11) DEFAULT 0,
  `page_views` int(11) DEFAULT 1,
  `device_type` enum('desktop','mobile','tablet','bot','other') COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: backlinks
CREATE TABLE `backlinks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `site_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `platform` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `backlink_code` json DEFAULT NULL,
  `traffic_count` int(11) DEFAULT 0,
  `status` enum('active','inactive','pending','rejected') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_checked` timestamp NULL DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: users
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `site_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` enum('superadmin','admin','viewer') COLLATE utf8mb4_unicode_ci DEFAULT 'viewer',
  `is_active` tinyint(1) DEFAULT 1,
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table: daily_summary
CREATE TABLE `daily_summary` (
  `id` int(11) NOT NULL,
  `site_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary_date` date NOT NULL,
  `total_visits` int(11) DEFAULT 0,
  `unique_visitors` int(11) DEFAULT 0,
  `page_views` int(11) DEFAULT 0,
  `avg_duration` decimal(10,2) DEFAULT 0.00,
  `bounce_rate` decimal(5,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Indexes
ALTER TABLE `sites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `api_key` (`api_key`),
  ADD KEY `idx_sites_active` (`is_active`);

ALTER TABLE `visitors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_visitors_site_date` (`site_id`,`visit_date`),
  ADD KEY `idx_visitors_ip` (`ip_address`),
  ADD KEY `idx_visitors_session` (`session_id`);

ALTER TABLE `backlinks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_backlinks_status` (`status`),
  ADD KEY `idx_backlinks_site` (`site_id`),
  ADD KEY `idx_backlinks_date` (`created_at`);

ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `idx_users_role` (`role`);

ALTER TABLE `daily_summary`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_site_date` (`site_id`,`summary_date`);

-- Auto-increment
ALTER TABLE `visitors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `backlinks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `daily_summary`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- Foreign Keys
ALTER TABLE `visitors`
  ADD CONSTRAINT `visitors_ibfk_1` FOREIGN KEY (`site_id`) REFERENCES `sites` (`id`) ON DELETE CASCADE;

ALTER TABLE `backlinks`
  ADD CONSTRAINT `backlinks_ibfk_1` FOREIGN KEY (`site_id`) REFERENCES `sites` (`id`) ON DELETE CASCADE;

ALTER TABLE `daily_summary`
  ADD CONSTRAINT `daily_summary_ibfk_1` FOREIGN KEY (`site_id`) REFERENCES `sites` (`id`) ON DELETE CASCADE;

-- Insert default admin (password: admin123)
INSERT INTO `users` (`username`, `email`, `password_hash`, `role`) VALUES
('admin', 'admin@localhost', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'superadmin');

COMMIT;
EOF
```

### **Import Database:**
```bash
# Login ke MySQL sebagai root
sudo mysql -u root -p

# Di dalam MySQL:
CREATE USER 'traffic_user'@'localhost' IDENTIFIED BY 'StrongPassword123!';
GRANT ALL PRIVILEGES ON traffic_db.* TO 'traffic_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;

# Import schema
sudo mysql -u root -p traffic_db < schema.sql
```

## ⚙️ **4. APACHE CONFIGURATION **

### **File: /etc/apache2/sites-available/traffic.conf**
```bash
sudo nano /etc/apache2/sites-available/traffic.conf
```

```apache
<VirtualHost *:80>
    ServerAdmin admin@localhost
    ServerName traffic.local
    ServerAlias www.traffic.local
    
    DocumentRoot /var/www/html/traffic
    
    ErrorLog ${APACHE_LOG_DIR}/traffic_error.log
    CustomLog ${APACHE_LOG_DIR}/traffic_access.log combined
    
    <Directory /var/www/html/traffic>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
        
        # Security headers
        Header always set X-Frame-Options "SAMEORIGIN"
        Header always set X-Content-Type-Options "nosniff"
        Header always set X-XSS-Protection "1; mode=block"
    </Directory>
    
    # PHP settings
    <FilesMatch \.php$>
        SetHandler application/x-httpd-php
    </FilesMatch>
    
    # Enable CORS for tracking
    Header set Access-Control-Allow-Origin "*"
    Header set Access-Control-Allow-Methods "GET, POST, OPTIONS"
    Header set Access-Control-Allow-Headers "Content-Type"
    
    # Disable ETags
    FileETag None
    Header unset ETag
</VirtualHost>
```

### **Activate Site:**
```bash
# Enable site dan modul yang diperlukan
sudo a2ensite traffic.conf
sudo a2enmod rewrite headers
sudo systemctl restart apache2

# Edit hosts file
sudo nano /etc/hosts
# Tambahkan:
127.0.0.1   traffic.local
127.0.0.1   www.traffic.local
```

## 🔧 **5. PHP FILE CONFIGURATION**

### **File: config.php**
```bash
cat > config.php << 'EOF'
<?php
// config.php - Konfigurasi untuk Kali Linux
error_reporting(E_ALL);
ini_set('display_errors', 1);
ini_set('log_errors', 1);
ini_set('error_log', '/var/www/html/traffic/logs/php_errors.log');

// Database Configuration
define('DB_HOST', 'localhost');
define('DB_USER', 'traffic_user');
define('DB_PASS', 'StrongPassword123!');
define('DB_NAME', 'traffic_db');

// Site Configuration
define('SITE_URL', 'http://traffic.local');
define('SITE_NAME', 'Traffic Analytics');
define('ADMIN_EMAIL', 'admin@localhost');

// Tracking Configuration
define('TRACK_CHANCE_PERCENT', 30);
define('SESSION_TIMEOUT', 1800); // 30 menit
define('MAX_REQUESTS_PER_MINUTE', 60);
define('ENABLE_BACKLINK_GENERATION', true);

// Security
define('ENCRYPTION_KEY', bin2hex(random_bytes(32)));
define('CSRF_TOKEN_NAME', 'csrf_token');
define('ALLOWED_IPS', ['127.0.0.1', '::1']);

// API Configuration
define('API_ENABLED', true);
define('API_RATE_LIMIT', 100); // requests per hour
define('API_KEY_EXPIRY', 30); // days

// Backlink Platforms
$backlink_platforms = [
    'blogger' => [
        'enabled' => true,
        'name' => 'Blogger',
        'url_template' => 'https://blogger.com/post/'
    ],
    'medium' => [
        'enabled' => true,
        'name' => 'Medium',
        'url_template' => 'https://medium.com/@user/'
    ],
    'github' => [
        'enabled' => true,
        'name' => 'GitHub Gist',
        'url_template' => 'https://gist.github.com/'
    ],
    'wordpress' => [
        'enabled' => false,
        'name' => 'WordPress',
        'url_template' => 'https://wordpress.com/'
    ]
];

// Email Configuration
define('SMTP_HOST', 'smtp.gmail.com');
define('SMTP_PORT', 587);
define('SMTP_USER', '');
define('SMTP_PASS', '');
define('SMTP_SECURE', 'tls');

// Timezone
date_default_timezone_set('Asia/Jakarta');

// Session Configuration
ini_set('session.cookie_httponly', 1);
ini_set('session.cookie_secure', 0); // Set ke 1 jika HTTPS
ini_set('session.cookie_samesite', 'Strict');
ini_set('session.use_strict_mode', 1);
ini_set('session.gc_maxlifetime', SESSION_TIMEOUT);

// Create log directory if not exists
if (!is_dir(__DIR__ . '/logs')) {
    mkdir(__DIR__ . '/logs', 0755, true);
}
?>
EOF
```

### **File: database.php**
```bash
cat > database.php << 'EOF'
<?php
// database.php - Database Connection Class
require_once 'config.php';

class Database {
    private static $instance = null;
    private $connection;
    private $query_count = 0;
    private $queries = [];
    
    private function __construct() {
        try {
            $this->connection = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
            
            if ($this->connection->connect_error) {
                $this->logError("Database connection failed: " . $this->connection->connect_error);
                throw new Exception("Database connection failed");
            }
            
            $this->connection->set_charset("utf8mb4");
            $this->connection->options(MYSQLI_OPT_INT_AND_FLOAT_NATIVE, 1);
            
        } catch (Exception $e) {
            $this->logError($e->getMessage());
            throw $e;
        }
    }
    
    public static function getInstance() {
        if (self::$instance === null) {
            self::$instance = new Database();
        }
        return self::$instance->connection;
    }
    
    public static function query($sql, $params = [], $types = '') {
        $db = self::getInstance();
        $stmt = $db->prepare($sql);
        
        if (!$stmt) {
            self::$instance->logError("Prepare failed: " . $db->error);
            return false;
        }
        
        if (!empty($params)) {
            if (empty($types)) {
                $types = str_repeat('s', count($params));
            }
            $stmt->bind_param($types, ...$params);
        }
        
        $result = $stmt->execute();
        
        if (!$result) {
            self::$instance->logError("Execute failed: " . $stmt->error);
            $stmt->close();
            return false;
        }
        
        self::$instance->query_count++;
        self::$instance->queries[] = $sql;
        
        if (stripos($sql, 'SELECT') === 0) {
            $res = $stmt->get_result();
            $data = [];
            while ($row = $res->fetch_assoc()) {
                $data[] = $row;
            }
            $stmt->close();
            return $data;
        } else {
            $affected = $stmt->affected_rows;
            $stmt->close();
            return $affected;
        }
    }
    
    public static function getQueryCount() {
        return self::$instance ? self::$instance->query_count : 0;
    }
    
    public static function getQueries() {
        return self::$instance ? self::$instance->queries : [];
    }
    
    public static function escape($string) {
        $db = self::getInstance();
        return $db->real_escape_string($string);
    }
    
    public static function lastInsertId() {
        $db = self::getInstance();
        return $db->insert_id;
    }
    
    public static function close() {
        if (self::$instance !== null && self::$instance->connection) {
            self::$instance->connection->close();
            self::$instance = null;
        }
    }
    
    private function logError($message) {
        $log_file = __DIR__ . '/logs/db_errors.log';
        $timestamp = date('Y-m-d H:i:s');
        $log_message = "[$timestamp] $message\n";
        
        file_put_contents($log_file, $log_message, FILE_APPEND);
        
        // Email admin jika error critical
        if (strpos($message, 'connection failed') !== false) {
            @mail(ADMIN_EMAIL, 'Database Error Alert', $log_message);
        }
    }
    
    public function __destruct() {
        $this->close();
    }
}

// Create tables if not exists (auto-install)
function checkAndInstallTables() {
    try {
        $conn = Database::getInstance();
        
        // Check if tables exist
        $result = $conn->query("SHOW TABLES LIKE 'visitors'");
        if ($result->num_rows == 0) {
            // Run installation
            $schema = file_get_contents(__DIR__ . '/schema.sql');
            $queries = array_filter(explode(';', $schema));
            
            foreach ($queries as $query) {
                if (trim($query)) {
                    $conn->query($query);
                }
            }
            
            error_log("Auto-installed database tables");
        }
    } catch (Exception $e) {
        error_log("Auto-install failed: " . $e->getMessage());
    }
}

// Run auto-check on include
checkAndInstallTables();
?>
EOF
```

## 🚀 **6. MAIN SYSTEM FILE**

### **File: track.php** (Optimized for Kali Linux)
```bash
cat > track.php << 'EOF'
<?php
// track.php - Universal Tracking Script for Kali Linux
header('Content-Type: application/javascript');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Cache-Control: no-cache, no-store, must-revalidate');
header('Pragma: no-cache');
header('Expires: 0');

// Rate limiting
session_start();
require_once 'config.php';
require_once 'database.php';

// Rate limiting per IP
$ip = $_SERVER['REMOTE_ADDR'];
$rate_key = 'rate_' . $ip;
$current_time = time();

if (isset($_SESSION[$rate_key])) {
    $last_time = $_SESSION[$rate_key];
    if ($current_time - $last_time < 1) { // 1 second minimum between requests
        exit('// Rate limit exceeded');
    }
}
$_SESSION[$rate_key] = $current_time;

// Validate required parameters
if (!isset($_GET['site_id']) || empty($_GET['site_id'])) {
    exit('// Invalid site ID');
}

$site_id = filter_var($_GET['site_id'], FILTER_SANITIZE_STRING);
if (strlen($site_id) > 50) {
    exit('// Invalid site ID length');
}

try {
    // Get visitor data
    $ip_address = $_SERVER['HTTP_X_FORWARDED_FOR'] ?? $_SERVER['REMOTE_ADDR'] ?? '0.0.0.0';
    $user_agent = $_SERVER['HTTP_USER_AGENT'] ?? 'Unknown';
    $referrer = isset($_SERVER['HTTP_REFERER']) ? 
                filter_var($_SERVER['HTTP_REFERER'], FILTER_SANITIZE_URL) : 'Direct';
    $page_url = isset($_GET['url']) ? 
                filter_var($_GET['url'], FILTER_SANITIZE_URL) : '';
    $country = getCountryFromIP($ip_address);
    $browser = getBrowserInfo($user_agent);
    $device_type = getDeviceType($user_agent);
    
    // Validate and sanitize
    $ip_address = filter_var($ip_address, FILTER_VALIDATE_IP) ? $ip_address : '0.0.0.0';
    $page_url = substr($page_url, 0, 1000); // Limit length
    
    // Check for bot/crawler
    if (isBot($user_agent)) {
        $device_type = 'bot';
    }
    
    // Generate session ID if not exists
    $session_id = $_GET['session_id'] ?? generateSessionId();
    
    // Check for duplicate visit (same IP, URL within 30 minutes)
    $check_sql = "SELECT id FROM visitors 
                  WHERE site_id = ? 
                  AND ip_address = ? 
                  AND page_url = ? 
                  AND visit_date > DATE_SUB(NOW(), INTERVAL 30 MINUTE)
                  LIMIT 1";
    
    $existing = Database::query($check_sql, [$site_id, $ip_address, $page_url]);
    
    if (empty($existing)) {
        // Insert new visit
        $insert_sql = "INSERT INTO visitors 
                      (site_id, session_id, ip_address, user_agent, referrer, 
                       page_url, country, browser, device_type, visit_date) 
                      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
        
        Database::query($insert_sql, [
            $site_id, $session_id, $ip_address, $user_agent, $referrer,
            $page_url, $country, $browser, $device_type
        ]);
        
        // Auto-generate backlink (30% chance)
        if (ENABLE_BACKLINK_GENERATION && rand(1, 100) <= TRACK_CHANCE_PERCENT) {
            generateAutoBacklink($page_url, $site_id);
        }
        
        // Update site statistics
        updateSiteStats($site_id);
        
    } else {
        // Update page views for existing session
        $update_sql = "UPDATE visitors 
                      SET page_views = page_views + 1,
                          session_duration = TIMESTAMPDIFF(SECOND, visit_date, NOW())
                      WHERE session_id = ? 
                      AND site_id = ?";
        
        Database::query($update_sql, [$session_id, $site_id]);
    }
    
    // Handle exit intent
    if (isset($_GET['action']) && $_GET['action'] === 'exit') {
        logExit($session_id, $site_id);
    }
    
} catch (Exception $e) {
    error_log("Tracking error: " . $e->getMessage());
    // Don't expose error details to client
}

// Helper functions
function getCountryFromIP($ip) {
    if ($ip === '127.0.0.1' || $ip === '::1') {
        return 'Localhost';
    }
    
    // Simple IP to country mapping (for demo)
    // In production, use MaxMind GeoIP or similar
    $local_ips = ['192.168.', '10.', '172.16.', '172.31.'];
    foreach ($local_ips as $local_ip) {
        if (strpos($ip, $local_ip) === 0) {
            return 'Local Network';
        }
    }
    
    // Try to get from freegeoip.app (demo)
    $context = stream_context_create([
        'http' => ['timeout' => 1]
    ]);
    
    try {
        $json = @file_get_contents("https://ipapi.co/$ip/json/", false, $context);
        if ($json) {
            $data = json_decode($json, true);
            return $data['country_name'] ?? 'Unknown';
        }
    } catch (Exception $e) {
        // Silent fail
    }
    
    return 'Unknown';
}

function getBrowserInfo($user_agent) {
    $browsers = [
        'Chrome' => 'Chrome',
        'Firefox' => 'Firefox',
        'Safari' => 'Safari',
        'Opera' => 'Opera',
        'MSIE' => 'Internet Explorer',
        'Trident' => 'Internet Explorer',
        'Edge' => 'Edge'
    ];
    
    foreach ($browsers as $key => $name) {
        if (stripos($user_agent, $key) !== false) {
            return $name;
        }
    }
    
    return 'Other';
}

function getDeviceType($user_agent) {
    if (stripos($user_agent, 'mobile') !== false) {
        return 'mobile';
    } elseif (stripos($user_agent, 'tablet') !== false) {
        return 'tablet';
    } elseif (stripos($user_agent, 'bot') !== false || 
              stripos($user_agent, 'crawler') !== false ||
              stripos($user_agent, 'spider') !== false) {
        return 'bot';
    }
    return 'desktop';
}

function isBot($user_agent) {
    $bots = [
        'googlebot', 'bingbot', 'slurp', 'duckduckbot', 'baiduspider',
        'yandexbot', 'sogou', 'exabot', 'facebot', 'ia_archiver'
    ];
    
    $ua_lower = strtolower($user_agent);
    foreach ($bots as $bot) {
        if (strpos($ua_lower, $bot) !== false) {
            return true;
        }
    }
    return false;
}

function generateSessionId() {
    return session_id() ?: 'sess_' . bin2hex(random_bytes(16));
}

function generateAutoBacklink($target_url, $site_id) {
    global $backlink_platforms;
    
    // Filter enabled platforms
    $enabled_platforms = array_filter($backlink_platforms, function($p) {
        return $p['enabled'];
    });
    
    if (empty($enabled_platforms)) {
        return;
    }
    
    $platform_keys = array_keys($enabled_platforms);
    $selected_key = $platform_keys[array_rand($platform_keys)];
    $platform = $enabled_platforms[$selected_key];
    
    $backlink_url = $platform['url_template'] . bin2hex(random_bytes(8));
    $backlink_code = json_encode([
        'html' => '<a href="' . htmlspecialchars($target_url) . '" rel="nofollow">Visit Site</a>',
        'target_url' => $target_url,
        'generated_at' => date('Y-m-d H:i:s')
    ]);
    
    $insert_sql = "INSERT INTO backlinks 
                  (site_id, url, platform, backlink_code, status, created_at) 
                  VALUES (?, ?, ?, ?, 'active', NOW())";
    
    Database::query($insert_sql, [$site_id, $backlink_url, $platform['name'], $backlink_code]);
}

function updateSiteStats($site_id) {
    $sql = "INSERT INTO sites (id, name, domain, created_at) 
            VALUES (?, ?, ?, NOW()) 
            ON DUPLICATE KEY UPDATE 
            last_updated = NOW()";
    
    $domain = parse_url($_SERVER['HTTP_REFERER'] ?? 'direct', PHP_URL_HOST) ?: 'direct';
    Database::query($sql, [$site_id, 'Site ' . $site_id, $domain]);
}

function logExit($session_id, $site_id) {
    $sql = "UPDATE visitors 
            SET session_duration = TIMESTAMPDIFF(SECOND, visit_date, NOW())
            WHERE session_id = ? AND site_id = ?";
    
    Database::query($sql, [$session_id, $site_id]);
}
?>

// JavaScript Tracker
(function() {
    'use strict';
    
    var config = {
        siteId: '<?php echo isset($_GET["site_id"]) ? addslashes($_GET["site_id"]) : ""; ?>',
        trackUrl: 'track.php',
        sessionDuration: 1800000, // 30 minutes
        heartbeatInterval: 30000, // 30 seconds
        exitIntentEnabled: true
    };
    
    if (!config.siteId) {
        return;
    }
    
    // Session management
    var sessionId = localStorage.getItem('ta_session_id') || 
                   'sess_' + Math.random().toString(36).substr(2, 16);
    localStorage.setItem('ta_session_id', sessionId);
    sessionStorage.setItem('ta_last_active', Date.now());
    
    // Collect visitor data
    var data = {
        site_id: config.siteId,
        session_id: sessionId,
        url: encodeURIComponent(window.location.href),
        referrer: document.referrer || 'direct',
        sr: window.screen.width + 'x' + window.screen.height,
        lang: navigator.language || navigator.userLanguage,
        tz: new Date().getTimezoneOffset(),
        online: navigator.onLine ? 1 : 0
    };
    
    // Send initial tracking request
    function trackPageView() {
        var params = Object.keys(data).map(function(key) {
            return key + '=' + encodeURIComponent(data[key]);
        }).join('&');
        
        var img = new Image();
        img.src = config.trackUrl + '?' + params + '&_=' + Date.now();
        
        // Alternative: fetch API
        if (window.fetch && navigator.sendBeacon) {
            fetch(config.trackUrl + '?' + params, {mode: 'no-cors'}).catch(function(){});
        }
    }
    
    // Heartbeat for session duration
    function sendHeartbeat() {
        if (navigator.sendBeacon) {
            navigator.sendBeacon(config.trackUrl + '?site_id=' + config.siteId + '&session_id=' + sessionId);
        }
    }
    
    // Exit intent tracking
    function trackExitIntent(e) {
        if (e.clientY < 10 && config.exitIntentEnabled) {
            sendHeartbeat();
            
            // Send exit intent
            var exitParams = 'site_id=' + config.siteId + 
                           '&session_id=' + sessionId + 
                           '&action=exit';
            
            if (navigator.sendBeacon) {
                navigator.sendBeacon(config.trackUrl + '?' + exitParams);
            }
            
            // Remove listener after firing
            document.removeEventListener('mouseout', trackExitIntent);
        }
    }
    
    // Page visibility change
    function handleVisibilityChange() {
        if (!document.hidden) {
            sendHeartbeat();
        }
    }
    
    // Before unload
    function handleBeforeUnload() {
        sendHeartbeat();
    }
    
    // Initialize tracking
    trackPageView();
    
    // Set up event listeners
    if (config.heartbeatInterval > 0) {
        setInterval(sendHeartbeat, config.heartbeatInterval);
    }
    
    if (config.exitIntentEnabled) {
        document.addEventListener('mouseout', trackExitIntent);
    }
    
    document.addEventListener('visibilitychange', handleVisibilityChange);
    window.addEventListener('beforeunload', handleBeforeUnload);
    window.addEventListener('pagehide', handleBeforeUnload);
    
    // Push state tracking for SPA
    if (window.history && window.history.pushState) {
        var originalPushState = history.pushState;
        history.pushState = function() {
            originalPushState.apply(this, arguments);
            trackPageView();
        };
        
        window.addEventListener('popstate', trackPageView);
    }
    
    // Expose to global scope for debugging
    window.TrafficAnalytics = {
        config: config,
        sessionId: sessionId,
        trackEvent: function(eventName, data) {
            var params = 'site_id=' + config.siteId + 
                        '&session_id=' + sessionId + 
                        '&event=' + encodeURIComponent(eventName);
            
            if (data) {
                params += '&data=' + encodeURIComponent(JSON.stringify(data));
            }
            
            var img = new Image();
            img.src = config.trackUrl + '?' + params;
        }
    };
    
    console.log('Traffic Analytics loaded for site:', config.siteId);
})();
EOF
```

### **File: admin.php** (Main Dashboard for Kali Linux)
```bash
cat > admin.php << 'EOF'
<?php
// admin.php - Admin Dashboard for Kali Linux
session_start();
require_once 'config.php';
require_once 'database.php';

// Security check
if (!isset($_SESSION['admin_logged_in']) || $_SESSION['admin_logged_in'] !== true) {
    header('Location: login.php');
    exit();
}

// Session timeout
if (isset($_SESSION['last_activity']) && (time() - $_SESSION['last_activity'] > SESSION_TIMEOUT)) {
    session_unset();
    session_destroy();
    header('Location: login.php?timeout=1');
    exit();
}
$_SESSION['last_activity'] = time();

// CSRF protection
if (!isset($_SESSION['csrf_token'])) {
    $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
}

// Get admin info
$admin_id = $_SESSION['admin_id'] ?? 0;
$site_id = $_SESSION['site_id'] ?? 'default';
$admin_role = $_SESSION['admin_role'] ?? 'viewer';

// Check permissions
if ($admin_role === 'viewer' && basename($_SERVER['PHP_SELF']) !== 'admin.php') {
    header('Location: admin.php');
    exit();
}

// Handle actions
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action'])) {
    if (!isset($_POST['csrf_token']) || $_POST['csrf_token'] !== $_SESSION['csrf_token']) {
        die('CSRF token validation failed');
    }
    
    switch ($_POST['action']) {
        case 'add_site':
            if ($admin_role === 'superadmin' || $admin_role === 'admin') {
                $new_site_id = Database::escape($_POST['site_id']);
                $site_name = Database::escape($_POST['site_name']);
                $site_domain = Database::escape($_POST['site_domain']);
                
                $sql = "INSERT INTO sites (id, name, domain) VALUES (?, ?, ?)";
                Database::query($sql, [$new_site_id, $site_name, $site_domain]);
                
                $_SESSION['message'] = 'Site added successfully';
            }
            break;
            
        case 'generate_backlink':
            $target_url = filter_var($_POST['target_url'], FILTER_SANITIZE_URL);
            if ($target_url) {
                generateManualBacklink($target_url, $site_id);
                $_SESSION['message'] = 'Backlink generated';
            }
            break;
    }
    
    header('Location: ' . $_SERVER['PHP_SELF']);
    exit();
}

// Get statistics
$stats = [];
$date_ranges = [
    'today' => "DATE(visit_date) = CURDATE()",
    'yesterday' => "DATE(visit_date) = DATE_SUB(CURDATE(), INTERVAL 1 DAY)",
    'week' => "visit_date >= DATE_SUB(NOW(), INTERVAL 7 DAY)",
    'month' => "visit_date >= DATE_SUB(NOW(), INTERVAL 30 DAY)"
];

foreach ($date_ranges as $key => $condition) {
    $sql = "SELECT 
                COUNT(*) as total_visits,
                COUNT(DISTINCT ip_address) as unique_visitors,
                COUNT(DISTINCT session_id) as sessions,
                AVG(page_views) as avg_pageviews,
                AVG(session_duration) as avg_duration
            FROM visitors 
            WHERE site_id = ? AND $condition";
    
    $result = Database::query($sql, [$site_id]);
    $stats[$key] = $result[0] ?? [];
}

// Get real-time data (last 5 minutes)
$realtime_sql = "SELECT COUNT(*) as active_visitors 
                 FROM visitors 
                 WHERE site_id = ? 
                 AND visit_date >= DATE_SUB(NOW(), INTERVAL 5 MINUTE)";
$realtime = Database::query($realtime_sql, [$site_id]);
$active_visitors = $realtime[0]['active_visitors'] ?? 0;

// Get top pages
$top_pages_sql = "SELECT page_url, COUNT(*) as visits 
                  FROM visitors 
                  WHERE site_id = ? 
                  AND DATE(visit_date) = CURDATE() 
                  GROUP BY page_url 
                  ORDER BY visits DESC 
                  LIMIT 10";
$top_pages = Database::query($top_pages_sql, [$site_id]);

// Get referrers
$referrers_sql = "SELECT referrer, COUNT(*) as count 
                  FROM visitors 
                  WHERE site_id = ? 
                  AND DATE(visit_date) = CURDATE() 
                  AND referrer != 'Direct' 
                  GROUP BY referrer 
                  ORDER BY count DESC 
                  LIMIT 10";
$referrers = Database::query($referrers_sql, [$site_id]);

// Get backlinks
$backlinks_sql = "SELECT url, platform, status, created_at, traffic_count 
                  FROM backlinks 
                  WHERE site_id = ? 
                  ORDER BY created_at DESC 
                  LIMIT 15";
$backlinks = Database::query($backlinks_sql, [$site_id]);

// Get browser stats
$browsers_sql = "SELECT browser, COUNT(*) as count 
                 FROM visitors 
                 WHERE site_id = ? 
                 AND DATE(visit_date) = CURDATE() 
                 GROUP BY browser 
                 ORDER BY count DESC";
$browsers = Database::query($browsers_sql, [$site_id]);

// Get daily chart data
$chart_sql = "SELECT 
                DATE(visit_date) as date,
                COUNT(*) as visits,
                COUNT(DISTINCT ip_address) as unique_visits
              FROM visitors 
              WHERE site_id = ? 
              AND visit_date >= DATE_SUB(NOW(), INTERVAL 30 DAY)
              GROUP BY DATE(visit_date)
              ORDER BY date";
$chart_data_raw = Database::query($chart_sql, [$site_id]);

$chart_labels = [];
$chart_visits = [];
$chart_unique = [];

foreach ($chart_data_raw as $row) {
    $chart_labels[] = date('M d', strtotime($row['date']));
    $chart_visits[] = $row['visits'];
    $chart_unique[] = $row['unique_visits'];
}

// Helper function
function generateManualBacklink($target_url, $site_id) {
    $platforms = ['Blogger', 'Medium', 'GitHub', 'WordPress', 'Pastebin'];
    $platform = $platforms[array_rand($platforms)];
    
    $backlink_url = 'https://' . strtolower($platform) . '.com/' . bin2hex(random_bytes(8));
    $backlink_code = json_encode([
        'html' => '<a href="' . htmlspecialchars($target_url) . '">Visit</a>',
        'generated_at' => date('Y-m-d H:i:s')
    ]);
    
    $sql = "INSERT INTO backlinks (site_id, url, platform, backlink_code, status) 
            VALUES (?, ?, ?, ?, 'pending')";
    
    Database::query($sql, [$site_id, $backlink_url, $platform, $backlink_code]);
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Traffic Analytics Dashboard - Kali Linux</title>
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary: #4361ee;
            --secondary: #3a0ca3;
            --success: #4cc9f0;
            --danger: #f72585;
            --warning: #f8961e;
            --dark: #1a1a2e;
            --light: #f8f9fa;
        }
        
        body {
            background-color: #f5f7fb;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
        }
        
        .sidebar {
            background: linear-gradient(180deg, var(--dark) 0%, #16213e 100%);
            color: white;
            height: 100vh;
            position: fixed;
            width: 250px;
            transition: all 0.3s;
        }
        
        .main-content {
            margin-left: 250px;
            padding: 20px;
            transition: all 0.3s;
        }
        
        @media (max-width: 768px) {
            .sidebar {
                margin-left: -250px;
            }
            .main-content {
                margin-left: 0;
            }
            .sidebar.active {
                margin-left: 0;
            }
        }
        
        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            transition: transform 0.3s, box-shadow 0.3s;
            border-left: 5px solid var(--primary);
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 30px rgba(0,0,0,0.12);
        }
        
        .stat-card i {
            font-size: 2.5rem;
            color: var(--primary);
            margin-bottom: 15px;
        }
        
        .stat-number {
            font-size: 2.2rem;
            font-weight: 700;
            color: var(--dark);
            margin-bottom: 5px;
        }
        
        .stat-label {
            color: #6c757d;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .card-header-custom {
            background: linear-gradient(90deg, var(--primary), var(--secondary));
            color: white;
            border-radius: 10px 10px 0 0 !important;
            padding: 15px 20px;
        }
        
        .table-hover tbody tr:hover {
            background-color: rgba(67, 97, 238, 0.05);
        }
        
        .badge-active {
            background-color: #d4edda;
            color: #155724;
        }
        
        .badge-pending {
            background-color: #fff3cd;
            color: #856404;
        }
        
        .realtime-badge {
            animation: pulse 2s infinite;
            background-color: var(--danger);
            color: white;
        }
        
        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.7; }
            100% { opacity: 1; }
        }
        
        .navbar-custom {
            background: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border-radius: 10px;
            margin-bottom: 20px;
        }
        
        .site-selector {
            max-width: 300px;
        }
        
        .chart-container {
            background: white;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }
        
        .backlink-generator {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar d-flex flex-column p-3">
        <div class="text-center mb-4">
            <h3><i class="fas fa-chart-network"></i> Traffic Analytics</h3>
            <small class="text-muted">Kali Linux Edition</small>
        </div>
        
        <ul class="nav nav-pills flex-column mb-auto">
            <li class="nav-item">
                <a href="admin.php" class="nav-link active">
                    <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a href="admin.php?page=reports" class="nav-link text-white">
                    <i class="fas fa-chart-bar me-2"></i> Reports
                </a>
            </li>
            <li class="nav-item">
                <a href="admin.php?page=backlinks" class="nav-link text-white">
                    <i class="fas fa-link me-2"></i> Backlinks
                </a>
            </li>
            <li class="nav-item">
                <a href="admin.php?page=visitors" class="nav-link text-white">
                    <i class="fas fa-users me-2"></i> Visitors
                </a>
            </li>
            <?php if ($admin_role === 'superadmin'): ?>
            <li class="nav-item">
                <a href="admin.php?page=sites" class="nav-link text-white">
                    <i class="fas fa-sitemap me-2"></i> Sites
                </a>
            </li>
            <li class="nav-item">
                <a href="admin.php?page=users" class="nav-link text-white">
                    <i class="fas fa-user-cog me-2"></i> Users
                </a>
            </li>
            <?php endif; ?>
            <li class="nav-item">
                <a href="admin.php?page=settings" class="nav-link text-white">
                    <i class="fas fa-cog me-2"></i> Settings
                </a>
            </li>
        </ul>
        
        <div class="mt-auto">
            <div class="card bg-dark border-secondary">
                <div class="card-body">
                    <h6><i class="fas fa-info-circle me-2"></i> System Info</h6>
                    <small>
                        <div>PHP: <?php echo phpversion(); ?></div>
                        <div>MySQL: <?php echo Database::getInstance()->server_info; ?></div>
                        <div>Queries: <?php echo Database::getQueryCount(); ?></div>
                        <div>Role: <?php echo $admin_role; ?></div>
                    </small>
                </div>
            </div>
            
            <div class="mt-3">
                <a href="logout.php" class="btn btn-danger w-100">
                    <i class="fas fa-sign-out-alt me-2"></i> Logout
                </a>
            </div>
        </div>
    </div>
    
    <!-- Main Content -->
    <div class="main-content">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-custom">
            <div class="container-fluid">
                <button class="btn btn-primary d-md-none" type="button" onclick="toggleSidebar()">
                    <i class="fas fa-bars"></i>
                </button>
                
                <div class="navbar-nav me-auto">
                    <span class="navbar-text">
                        <i class="fas fa-globe me-2"></i>
                        Site: <strong><?php echo htmlspecialchars($site_id); ?></strong>
                    </span>
                </div>
                
                <div class="d-flex">
                    <span class="realtime-badge badge rounded-pill me-3">
                        <i class="fas fa-bolt me-1"></i> Live: <?php echo $active_visitors; ?>
                    </span>
                    
                    <div class="dropdown">
                        <button class="btn btn-outline-primary dropdown-toggle" type="button" 
                                data-bs-toggle="dropdown">
                            <i class="fas fa-user me-2"></i><?php echo $_SESSION['admin_username'] ?? 'Admin'; ?>
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#"><i class="fas fa-user me-2"></i>Profile</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="logout.php"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>
        
        <!-- Messages -->
        <?php if (isset($_SESSION['message'])): ?>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <?php echo $_SESSION['message']; unset($_SESSION['message']); ?>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <?php endif; ?>
        
        <!-- Statistics Cards -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="stat-card">
                    <i class="fas fa-users"></i>
                    <div class="stat-number"><?php echo number_format($stats['today']['total_visits'] ?? 0); ?></div>
                    <div class="stat-label">Visits Today</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <i class="fas fa-user-check"></i>
                    <div class="stat-number"><?php echo number_format($stats['today']['unique_visitors'] ?? 0); ?></div>
                    <div class="stat-label">Unique Visitors</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <i class="fas fa-clock"></i>
                    <div class="stat-number"><?php echo round($stats['today']['avg_duration'] ?? 0); ?>s</div>
                    <div class="stat-label">Avg. Duration</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <i class="fas fa-file-alt"></i>
                    <div class="stat-number"><?php echo round($stats['today']['avg_pageviews'] ?? 0, 1); ?></div>
                    <div class="stat-label">Pages/Visit</div>
                </div>
            </div>
        </div>
        
        <!-- Charts and Tables -->
        <div class="row">
            <!-- Traffic Chart -->
            <div class="col-lg-8">
                <div class="chart-container">
                    <h5 class="mb-3"><i class="fas fa-chart-line me-2"></i> Traffic Overview (30 Days)</h5>
                    <canvas id="trafficChart" height="250"></canvas>
                </div>
            </div>
            
            <!-- Backlink Generator -->
            <div class="col-lg-4">
                <div class="backlink-generator">
                    <h5><i class="fas fa-magic me-2"></i> Quick Backlink</h5>
                    <p class="mb-3">Generate a backlink for your site</p>
                    
                    <form method="POST" action="">
                        <input type="hidden" name="csrf_token" value="<?php echo $_SESSION['csrf_token']; ?>">
                        <input type="hidden" name="action" value="generate_backlink">
                        
                        <div class="mb-3">
                            <input type="url" name="target_url" class="form-control" 
                                   placeholder="https://example.com" required>
                        </div>
                        
                        <button type="submit" class="btn btn-light w-100">
                            <i class="fas fa-plus me-2"></i> Generate Backlink
                        </button>
                    </form>
                    
                    <div class="mt-3 small">
                        <i class="fas fa-info-circle me-1"></i>
                        Auto-generates backlinks on 30% of visits
                    </div>
                </div>
                
                <!-- Browser Stats -->
                <div class="chart-container mt-3">
                    <h5 class="mb-3"><i class="fas fa-window-restore me-2"></i> Browser Usage</h5>
                    <canvas id="browserChart" height="200"></canvas>
                </div>
            </div>
        </div>
        
        <!-- Tables Row -->
        <div class="row mt-4">
            <!-- Top Pages -->
            <div class="col-lg-6">
                <div class="card">
                    <div class="card-header card-header-custom">
                        <h5 class="mb-0"><i class="fas fa-fire me-2"></i> Top Pages Today</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Page URL</th>
                                        <th>Visits</th>
                                        <th>%</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach($top_pages as $page): 
                                        $percentage = ($page['visits'] / max($stats['today']['total_visits'], 1)) * 100;
                                    ?>
                                    <tr>
                                        <td>
                                            <small class="text-truncate d-block" style="max-width: 250px;">
                                                <?php echo htmlspecialchars($page['page_url']); ?>
                                            </small>
                                        </td>
                                        <td><?php echo number_format($page['visits']); ?></td>
                                        <td>
                                            <div class="progress" style="height: 6px;">
                                                <div class="progress-bar" style="width: <?php echo min($percentage, 100); ?>%"></div>
                                            </div>
                                            <small><?php echo round($percentage, 1); ?>%</small>
                                        </td>
                                    </tr>
                                    <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Backlinks -->
            <div class="col-lg-6">
                <div class="card">
                    <div class="card-header card-header-custom">
                        <h5 class="mb-0"><i class="fas fa-link me-2"></i> Recent Backlinks</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Platform</th>
                                        <th>URL</th>
                                        <th>Status</th>
                                        <th>Date</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php foreach($backlinks as $link): ?>
                                    <tr>
                                        <td><?php echo htmlspecialchars($link['platform']); ?></td>
                                        <td>
                                            <small class="text-truncate d-block" style="max-width: 200px;">
                                                <a href="<?php echo htmlspecialchars($link['url']); ?>" 
                                                   target="_blank" class="text-decoration-none">
                                                    <?php echo htmlspecialchars($link['url']); ?>
                                                </a>
                                            </small>
                                        </td>
                                        <td>
                                            <span class="badge badge-<?php echo $link['status']; ?>">
                                                <?php echo ucfirst($link['status']); ?>
                                            </span>
                                        </td>
                                        <td>
                                            <small><?php echo date('M d, H:i', strtotime($link['created_at'])); ?></small>
                                        </td>
                                    </tr>
                                    <?php endforeach; ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Footer -->
        <footer class="mt-5 pt-3 border-top text-center text-muted">
            <small>
                Traffic Analytics System &copy; <?php echo date('Y'); ?> - 
                Running on Kali Linux | 
                <?php echo Database::getQueryCount(); ?> queries executed |
                Memory: <?php echo round(memory_get_usage() / 1024 / 1024, 2); ?>MB
            </small>
        </footer>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Toggle sidebar on mobile
        function toggleSidebar() {
            document.querySelector('.sidebar').classList.toggle('active');
        }
        
        // Traffic Chart
        const trafficCtx = document.getElementById('trafficChart').getContext('2d');
        const trafficChart = new Chart(trafficCtx, {
            type: 'line',
            data: {
                labels: <?php echo json_encode($chart_labels); ?>,
                datasets: [{
                    label: 'Total Visits',
                    data: <?php echo json_encode($chart_visits); ?>,
                    borderColor: '#4361ee',
                    backgroundColor: 'rgba(67, 97, 238, 0.1)',
                    borderWidth: 3,
                    fill: true,
                    tension: 0.4
                }, {
                    label: 'Unique Visitors',
                    data: <?php echo json_encode($chart_unique); ?>,
                    borderColor: '#f72585',
                    backgroundColor: 'rgba(247, 37, 133, 0.1)',
                    borderWidth: 3,
                    fill: true,
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        mode: 'index',
                        intersect: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        grid: {
                            color: 'rgba(0,0,0,0.05)'
                        },
                        ticks: {
                            precision: 0
                        }
                    },
                    x: {
                        grid: {
                            display: false
                        }
                    }
                }
            }
        });
        
        // Browser Chart
        const browserCtx = document.getElementById('browserChart').getContext('2d');
        const browserChart = new Chart(browserCtx, {
            type: 'doughnut',
            data: {
                labels: <?php echo json_encode(array_column($browsers, 'browser')); ?>,
                datasets: [{
                    data: <?php echo json_encode(array_column($browsers, 'count')); ?>,
                    backgroundColor: [
                        '#4361ee', '#3a0ca3', '#4cc9f0', 
                        '#f72585', '#f8961e', '#2a9d8f'
                    ],
                    borderWidth: 2,
                    borderColor: '#fff'
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'bottom',
                    }
                },
                cutout: '70%'
            }
        });
        
        // Auto refresh every 60 seconds
        setTimeout(() => {
            window.location.reload();
        }, 60000);
    </script>
</body>
</html>
EOF
```

### **File: login.php** (Login System)
```bash
cat > login.php << 'EOF'
<?php
// login.php - Authentication System
session_start();
require_once 'config.php';
require_once 'database.php';

// Redirect if already logged in
if (isset($_SESSION['admin_logged_in']) && $_SESSION['admin_logged_in'] === true) {
    header('Location: admin.php');
    exit();
}

$error = '';
$success = '';

// Handle login form
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['login'])) {
    $username = trim($_POST['username']);
    $password = $_POST['password'];
    
    // Basic validation
    if (empty($username) || empty($password)) {
        $error = 'Please enter username and password';
    } else {
        // Check user in database
        $sql = "SELECT id, username, password_hash, role, site_id FROM users 
                WHERE username = ? AND is_active = 1 LIMIT 1";
        
        $result = Database::query($sql, [$username]);
        
        if (!empty($result) && password_verify($password, $result[0]['password_hash'])) {
            // Login successful
            $_SESSION['admin_logged_in'] = true;
            $_SESSION['admin_id'] = $result[0]['id'];
            $_SESSION['admin_username'] = $result[0]['username'];
            $_SESSION['admin_role'] = $result[0]['role'];
            $_SESSION['site_id'] = $result[0]['site_id'] ?? 'default';
            $_SESSION['login_time'] = time();
            $_SESSION['last_activity'] = time();
            
            // Update last login
            $update_sql = "UPDATE users SET last_login = NOW() WHERE id = ?";
            Database::query($update_sql, [$_SESSION['admin_id']]);
            
            // Redirect to admin page
            header('Location: admin.php');
            exit();
        } else {
            $error = 'Invalid username or password';
            
            // Log failed attempt
            $ip = $_SERVER['REMOTE_ADDR'];
            error_log("Failed login attempt for username: $username from IP: $ip");
        }
    }
}

// Handle registration (for demo only - disable in production)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['register'])) {
    if (ENABLE_REGISTRATION) {
        $username = trim($_POST['reg_username']);
        $email = filter_var($_POST['reg_email'], FILTER_VALIDATE_EMAIL);
        $password = $_POST['reg_password'];
        $confirm_password = $_POST['reg_confirm_password'];
        
        if ($password !== $confirm_password) {
            $error = 'Passwords do not match';
        } elseif (strlen($password) < 8) {
            $error = 'Password must be at least 8 characters';
        } else {
            $hashed_password = password_hash($password, PASSWORD_DEFAULT);
            
            $sql = "INSERT INTO users (username, email, password_hash, role) 
                    VALUES (?, ?, ?, 'viewer')";
            
            if (Database::query($sql, [$username, $email, $hashed_password])) {
                $success = 'Registration successful! You can now login.';
            } else {
                $error = 'Registration failed. Username may already exist.';
            }
        }
    } else {
        $error = 'Registration is disabled';
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Traffic Analytics</title>
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            padding: 20px;
        }
        
        .login-container {
            max-width: 400px;
            width: 100%;
            margin: 0 auto;
        }
        
        .login-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        
        .login-header {
            background: linear-gradient(90deg, #4361ee, #3a0ca3);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .login-body {
            padding: 30px;
        }
        
        .form-control {
            padding: 12px 15px;
            border-radius: 10px;
            border: 2px solid #e0e0e0;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: #4361ee;
            box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.25);
        }
        
        .btn-login {
            background: linear-gradient(90deg, #4361ee, #3a0ca3);
            border: none;
            padding: 12px;
            border-radius: 10px;
            color: white;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(67, 97, 238, 0.3);
        }
        
        .alert {
            border-radius: 10px;
            border: none;
        }
        
        .system-info {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 15px;
            margin-top: 20px;
            font-size: 0.85rem;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-card">
            <div class="login-header">
                <h1><i class="fas fa-chart-network"></i></h1>
                <h3>Traffic Analytics</h3>
                <p class="mb-0">Kali Linux Edition</p>
            </div>
            
            <div class="login-body">
                <?php if ($error): ?>
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-circle me-2"></i> <?php echo $error; ?>
                    </div>
                <?php endif; ?>
                
                <?php if ($success): ?>
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle me-2"></i> <?php echo $success; ?>
                    </div>
                <?php endif; ?>
                
                <!-- Login Form -->
                <form method="POST" action="">
                    <div class="mb-3">
                        <label for="username" class="form-label">
                            <i class="fas fa-user me-2"></i>Username
                        </label>
                        <input type="text" class="form-control" id="username" name="username" 
                               required autofocus>
                    </div>
                    
                    <div class="mb-3">
                        <label for="password" class="form-label">
                            <i class="fas fa-lock me-2"></i>Password
                        </label>
                        <input type="password" class="form-control" id="password" name="password" 
                               required>
                    </div>
                    
                    <div class="d-grid mb-3">
                        <button type="submit" name="login" class="btn btn-login">
                            <i class="fas fa-sign-in-alt me-2"></i> Login
                        </button>
                    </div>
                </form>
                
                <!-- Demo Credentials -->
                <div class="alert alert-info">
                    <h6><i class="fas fa-info-circle me-2"></i> Demo Credentials</h6>
                    <small>
                        <div>Username: <strong>admin</strong></div>
                        <div>Password: <strong>admin123</strong></div>
                    </small>
                </div>
                
                <!-- System Info -->
                <div class="system-info">
                    <h6><i class="fas fa-server me-2"></i> System Status</h6>
                    <small>
                        <?php
                        $db_status = 'Connected';
                        try {
                            $conn = Database::getInstance();
                            $db_status = $conn ? 'Connected' : 'Disconnected';
                        } catch (Exception $e) {
                            $db_status = 'Error: ' . $e->getMessage();
                        }
                        
                        echo "<div>Database: <strong>$db_status</strong></div>";
                        echo "<div>PHP: <strong>" . phpversion() . "</strong></div>";
                        echo "<div>Server: <strong>" . $_SERVER['SERVER_SOFTWARE'] . "</strong></div>";
                        ?>
                    </small>
                </div>
                
                <!-- Quick Links -->
                <div class="mt-3 text-center">
                    <small class="text-muted">
                        <a href="install.php" class="text-decoration-none me-3">
                            <i class="fas fa-cogs me-1"></i> Install
                        </a>
                        <a href="track.php?site_id=demo" class="text-decoration-none me-3">
                            <i class="fas fa-code me-1"></i> Tracking Demo
                        </a>
                        <a href="https://github.com" target="_blank" class="text-decoration-none">
                            <i class="fab fa-github me-1"></i> Documentation
                        </a>
                    </small>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Focus on username field
        document.getElementById('username').focus();
        
        // Auto-hide alerts after 5 seconds
        setTimeout(() => {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                const fade = new bootstrap.Alert(alert);
                fade.close();
            });
        }, 5000);
    </script>
</body>
</html>
EOF
```

### **File: logout.php**
```bash
cat > logout.php << 'EOF'
<?php
// logout.php - Logout script
session_start();

// Destroy all session data
$_SESSION = array();

// Delete session cookie
if (ini_get("session.use_cookies")) {
    $params = session_get_cookie_params();
    setcookie(session_name(), '', time() - 42000,
        $params["path"], $params["domain"],
        $params["secure"], $params["httponly"]
    );
}

// Destroy session
session_destroy();

// Redirect to login page
header('Location: login.php?logout=1');
exit();
?>
EOF
```

### **File: .htaccess**
```bash
cat > .htaccess << 'EOF'
# Traffic Analytics .htaccess for Kali Linux

# Security headers
Header set X-Frame-Options "SAMEORIGIN"
Header set X-Content-Type-Options "nosniff"
Header set X-XSS-Protection "1; mode=block"
Header set Referrer-Policy "strict-origin-when-cross-origin"
Header set Permissions-Policy "geolocation=(), microphone=(), camera=()"

# Disable directory listing
Options -Indexes

# Prevent access to sensitive files
<FilesMatch "^(config|database)\.php$">
    Order Allow,Deny
    Deny from all
</FilesMatch>

<FilesMatch "\.(sql|log|txt|md)$">
    Order Allow,Deny
    Deny from all
</FilesMatch>

# URL rewriting
RewriteEngine On
RewriteBase /

# API endpoints
RewriteRule ^api/track/([a-zA-Z0-9_-]+)/?$ track.php?site_id=$1 [QSA,L]
RewriteRule ^api/stats/([a-zA-Z0-9_-]+)/?$ api.php?action=stats&site_id=$1 [QSA,L]

# Redirect to login if not authenticated
RewriteCond %{REQUEST_URI} ^/admin\.php$
RewriteCond %{REQUEST_FILENAME} -f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteCond %{HTTP_COOKIE} !admin_logged_in=1
RewriteRule ^admin\.php$ login.php?redirect=admin [L,R]

# Block common exploits
RewriteCond %{QUERY_STRING} (<|%3C).*script.*(>|%3E) [NC,OR]
RewriteCond %{QUERY_STRING} GLOBALS(=|[|%[0-9A-Z]{0,2}) [OR]
RewriteCond %{QUERY_STRING} _REQUEST(=|[|%[0-9A-Z]{0,2})
RewriteRule ^(.*)$ - [F,L]

# Compression
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/html text/plain text/xml text/css text/javascript application/javascript
</IfModule>

# Cache control
<IfModule mod_expires.c>
    ExpiresActive On
    ExpiresByType image/jpg "access plus 1 year"
    ExpiresByType image/jpeg "access plus 1 year"
    ExpiresByType image/gif "access plus 1 year"
    ExpiresByType image/png "access plus 1 year"
    ExpiresByType text/css "access plus 1 month"
    ExpiresByType application/javascript "access plus 1 month"
    ExpiresByType application/pdf "access plus 1 month"
</IfModule>

# Custom error pages
ErrorDocument 404 /error/404.html
ErrorDocument 403 /error/403.html
ErrorDocument 500 /error/500.html

# Prevent access to .git directory
RedirectMatch 404 /\.git

# Enable CORS for track.php
<Files "track.php">
    Header set Access-Control-Allow-Origin "*"
    Header set Access-Control-Allow-Methods "GET, POST, OPTIONS"
    Header set Access-Control-Allow-Headers "Content-Type"
</Files>
EOF
```

### **File: index.html** (Landing Page)
```bash
cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Traffic Analytics System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
            text-align: center;
        }
        
        .container {
            max-width: 800px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        h1 {
            font-size: 3.5rem;
            margin-bottom: 10px;
            background: linear-gradient(90deg, #fff, #a5b4fc);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        h2 {
            font-size: 1.5rem;
            margin-bottom: 30px;
            opacity: 0.9;
        }
        
        .logo {
            font-size: 5rem;
            margin-bottom: 20px;
            color: #a5b4fc;
        }
        
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin: 40px 0;
        }
        
        .feature {
            background: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 10px;
            transition: transform 0.3s;
        }
        
        .feature:hover {
            transform: translateY(-5px);
        }
        
        .feature i {
            font-size: 2.5rem;
            margin-bottom: 15px;
            color: #a5b4fc;
        }
        
        .buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 30px;
        }
        
        .btn {
            padding: 15px 30px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s;
        }
        
        .btn-primary {
            background: #4361ee;
            color: white;
        }
        
        .btn-primary:hover {
            background: #3a0ca3;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(67, 97, 238, 0.3);
        }
        
        .btn-secondary {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.3);
        }
        
        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.3);
        }
        
        .system-info {
            margin-top: 40px;
            padding: 20px;
            background: rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            font-family: monospace;
            text-align: left;
            max-width: 600px;
            width: 100%;
        }
        
        .info-row {
            display: flex;
            justify-content: space-between;
            padding: 5px 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        @media (max-width: 600px) {
            h1 {
                font-size: 2.5rem;
            }
            .container {
                padding: 20px;
            }
            .features {
                grid-template-columns: 1fr;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="logo">
        <i class="fas fa-chart-network"></i>
    </div>
    
    <div class="container">
        <h1>Traffic Analytics System</h1>
        <h2>Kali Linux Edition</h2>
        <p>Advanced website tracking and backlink generation system</p>
        
        <div class="features">
            <div class="feature">
                <i class="fas fa-chart-line"></i>
                <h3>Real-time Analytics</h3>
                <p>Track visitors, sessions, and page views in real-time</p>
            </div>
            
            <div class="feature">
                <i class="fas fa-link"></i>
                <h3>Auto Backlinks</h3>
                <p>Automatic backlink generation on visitor tracking</p>
            </div>
            
            <div class="feature">
                <i class="fas fa-shield-alt"></i>
                <h3>Secure Dashboard</h3>
                <p>Protected admin panel with role-based access</p>
            </div>
            
            <div class="feature">
                <i class="fas fa-bolt"></i>
                <h3>High Performance</h3>
                <p>Optimized for Kali Linux with minimal resource usage</p>
            </div>
        </div>
        
        <div class="buttons">
            <a href="login.php" class="btn btn-primary">
                <i class="fas fa-sign-in-alt"></i> Admin Login
            </a>
            <a href="install.php" class="btn btn-secondary">
                <i class="fas fa-cogs"></i> Installation Guide
            </a>
            <a href="track.php?site_id=demo" class="btn btn-secondary">
                <i class="fas fa-code"></i> Tracking Demo
            </a>
            <a href="https://github.com" target="_blank" class="btn btn-secondary">
                <i class="fab fa-github"></i> Documentation
            </a>
        </div>
        
        <div class="system-info">
            <div class="info-row">
                <span>System Status:</span>
                <span id="status">Checking...</span>
            </div>
            <div class="info-row">
                <span>PHP Version:</span>
                <span id="php-version"></span>
            </div>
            <div class="info-row">
                <span>Database:</span>
                <span id="db-status">Checking...</span>
            </div>
            <div class="info-row">
                <span>Server:</span>
                <span id="server-info"></span>
            </div>
        </div>
    </div>
    
    <script>
        // System check
        document.addEventListener('DOMContentLoaded', function() {
            // PHP info
            document.getElementById('php-version').textContent = '<?php echo phpversion(); ?>';
            document.getElementById('server-info').textContent = '<?php echo $_SERVER["SERVER_SOFTWARE"]; ?>';
            
            // Check database status via AJAX
            fetch('check_db.php')
                .then(response => response.json())
                .then(data => {
                    document.getElementById('db-status').textContent = data.status;
                    document.getElementById('db-status').style.color = data.success ? 'lightgreen' : 'lightcoral';
                    document.getElementById('status').textContent = data.success ? 'Operational' : 'Error';
                    document.getElementById('status').style.color = data.success ? 'lightgreen' : 'lightcoral';
                })
                .catch(() => {
                    document.getElementById('db-status').textContent = 'Error';
                    document.getElementById('db-status').style.color = 'lightcoral';
                    document.getElementById('status').textContent = 'API Error';
                    document.getElementById('status').style.color = 'lightcoral';
                });
        });
    </script>
</body>
</html>
EOF
```

## 🔧 **7. UTILITY SCRIPTS**

### **File: check_db.php** (Database Health Check)
```bash
cat > check_db.php << 'EOF'
<?php
// check_db.php - Database health check
header('Content-Type: application/json');
require_once 'config.php';

try {
    $conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
    
    if ($conn->connect_error) {
        echo json_encode([
            'success' => false,
            'status' => 'Connection failed: ' . $conn->connect_error
        ]);
    } else {
        // Check if tables exist
        $tables = ['visitors', 'backlinks', 'users', 'sites'];
        $missing_tables = [];
        
        foreach ($tables as $table) {
            $result = $conn->query("SHOW TABLES LIKE '$table'");
            if ($result->num_rows == 0) {
                $missing_tables[] = $table;
            }
        }
        
        if (empty($missing_tables)) {
            echo json_encode([
                'success' => true,
                'status' => 'Connected - All tables present'
            ]);
        } else {
            echo json_encode([
                'success' => false,
                'status' => 'Missing tables: ' . implode(', ', $missing_tables)
            ]);
        }
        
        $conn->close();
    }
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'status' => 'Exception: ' . $e->getMessage()
    ]);
}
?>
EOF
```

### **File: setup.sh** (Automated Setup Script)
```bash
cat > setup.sh << 'EOF'
#!/bin/bash
# setup.sh - Automated setup script for Traffic Analytics on Kali Linux

echo "========================================"
echo "Traffic Analytics Setup - Kali Linux"
echo "========================================"

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root (use sudo)"
    exit 1
fi

# Update system
echo "[1/8] Updating system packages..."
apt update && apt upgrade -y

# Install required packages
echo "[2/8] Installing required packages..."
apt install -y \
    apache2 \
    mysql-server \
    php \
    php-mysql \
    php-curl \
    php-json \
    php-mbstring \
    php-xml \
    libapache2-mod-php \
    git \
    curl \
    composer

# Start services
echo "[3/8] Starting services..."
systemctl start apache2
systemctl enable apache2
systemctl start mysql
systemctl enable mysql

# Configure MySQL
echo "[4/8] Configuring MySQL..."
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Traffic@2024';"
mysql -e "FLUSH PRIVILEGES;"

# Create database and user
echo "[5/8] Creating database..."
mysql -u root -pTraffic@2024 <<MYSQL_SCRIPT
CREATE DATABASE IF NOT EXISTS traffic_db;
USE traffic_db;
CREATE USER 'traffic_user'@'localhost' IDENTIFIED BY 'StrongPassword123!';
GRANT ALL PRIVILEGES ON traffic_db.* TO 'traffic_user'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# Import schema
echo "[6/8] Importing database schema..."
if [ -f "schema.sql" ]; then
    mysql -u root -pTraffic@2024 traffic_db < schema.sql
    echo "Database schema imported successfully."
else
    echo "Warning: schema.sql not found. Please import manually."
fi

# Configure Apache
echo "[7/8] Configuring Apache..."
cat > /etc/apache2/sites-available/traffic.conf <<APACHE_CONF
<VirtualHost *:80>
    ServerAdmin admin@localhost
    ServerName traffic.local
    
    DocumentRoot /var/www/html/traffic
    
    ErrorLog \${APACHE_LOG_DIR}/traffic_error.log
    CustomLog \${APACHE_LOG_DIR}/traffic_access.log combined
    
    <Directory /var/www/html/traffic>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
APACHE_CONF

# Enable site
a2ensite traffic.conf
a2dissite 000-default.conf
a2enmod rewrite headers
systemctl restart apache2

# Configure hosts file
echo "127.0.0.1 traffic.local" >> /etc/hosts

# Set permissions
echo "[8/8] Setting permissions..."
chown -R www-data:www-data /var/www/html/traffic
chmod -R 755 /var/www/html/traffic
chmod -R 777 /var/www/html/traffic/logs 2>/dev/null || mkdir -p /var/www/html/traffic/logs && chmod 777 /var/www/html/traffic/logs

# Generate encryption key
if [ ! -f "config.php" ]; then
    cat > config.php <<CONFIG_PHP
<?php
define('DB_HOST', 'localhost');
define('DB_USER', 'traffic_user');
define('DB_PASS', 'StrongPassword123!');
define('DB_NAME', 'traffic_db');
define('SITE_URL', 'http://traffic.local');
define('ADMIN_EMAIL', 'admin@localhost');
define('ENCRYPTION_KEY', '$(openssl rand -hex 32)');
?>
CONFIG_PHP
fi

echo "========================================"
echo "Setup completed successfully!"
echo "========================================"
echo ""
echo "Access URLs:"
echo "- Main Site: http://traffic.local"
echo "- Admin Panel: http://traffic.local/login.php"
echo "- Tracking Script: http://traffic.local/track.php"
echo ""
echo "Default credentials:"
echo "- Username: admin"
echo "- Password: admin123"
echo ""
echo "Next steps:"
echo "1. Visit http://traffic.local to verify installation"
echo "2. Login to admin panel and change default password"
echo "3. Add tracking script to your websites"
echo "========================================"
EOF

# Make setup script executable
chmod +x setup.sh
```

### **File: backup.sh** (Backup Script)
```bash
cat > backup.sh << 'EOF'
#!/bin/bash
# backup.sh - Backup script for Traffic Analytics

BACKUP_DIR="/var/backups/traffic"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/traffic_backup_$DATE.tar.gz"

# Create backup directory if not exists
mkdir -p $BACKUP_DIR

echo "Starting backup at $(date)"

# Backup database
echo "Backing up database..."
mysqldump -u traffic_user -p'StrongPassword123!' traffic_db > /tmp/traffic_db.sql

# Backup files
echo "Backing up files..."
tar -czf $BACKUP_FILE \
    -C /var/www/html/traffic \
    . \
    /tmp/traffic_db.sql

# Cleanup
rm /tmp/traffic_db.sql

# Remove old backups (keep last 7 days)
find $BACKUP_DIR -name "traffic_backup_*.tar.gz" -mtime +7 -delete

echo "Backup completed: $BACKUP_FILE"
echo "Size: $(du -h $BACKUP_FILE | cut -f1)"
EOF

chmod +x backup.sh
```

## 🚀 **8. TESTING & VERIFICATION**

```bash
# 1. Set proper permissions
cd /var/www/html/traffic
sudo chown -R www-data:www-data .
sudo chmod -R 755 .
sudo chmod -R 777 logs

# 2. Create test script
cat > test.php << 'EOF'
<?php
// test.php - Test script
require_once 'config.php';
require_once 'database.php';

echo "<h1>Traffic Analytics Test</h1>";
echo "<pre>";

echo "PHP Version: " . phpversion() . "\n\n";

echo "Database Test:\n";
try {
    $conn = Database::getInstance();
    echo "✓ Database connected successfully\n";
    echo "MySQL Version: " . $conn->server_info . "\n\n";
    
    echo "Table Check:\n";
    $tables = ['visitors', 'backlinks', 'users', 'sites'];
    foreach ($tables as $table) {
        $result = $conn->query("SHOW TABLES LIKE '$table'");
        echo ($result->num_rows > 0 ? "✓ " : "✗ ") . "$table\n";
    }
    
    echo "\nSample Query Test:\n";
    $result = Database::query("SELECT COUNT(*) as count FROM users");
    echo "Users in database: " . ($result[0]['count'] ?? 0) . "\n";
    
} catch (Exception $e) {
    echo "✗ Database error: " . $e->getMessage() . "\n";
}

echo "\nPHP Extensions:\n";
$extensions = ['mysqli', 'json', 'curl', 'mbstring'];
foreach ($extensions as $ext) {
    echo (extension_loaded($ext) ? "✓ " : "✗ ") . "$ext\n";
}

echo "\nDirectory Permissions:\n";
$dirs = ['.', 'logs'];
foreach ($dirs as $dir) {
    $writable = is_writable($dir);
    echo ($writable ? "✓ " : "✗ ") . "$dir is " . ($writable ? "writable" : "not writable") . "\n";
}

echo "\nTracking Test:\n";
echo "Test URL: <a href='track.php?site_id=test&url=http://example.com'>track.php?site_id=test</a>\n";

echo "</pre>";
?>
EOF

# 3. Test the system
echo "Testing the installation..."

# Test PHP
php -v

# Test MySQL
mysql -u traffic_user -p'StrongPassword123!' -e "SHOW DATABASES;"

# Test Apache
sudo systemctl status apache2

# 4. Create a test website with tracking
cat > test_site.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Test Site - Traffic Analytics</title>
</head>
<body>
    <h1>Test Website with Traffic Tracking</h1>
    <p>This page includes the tracking script.</p>
    
    <!-- Tracking Script -->
    <script>
    (function() {
        var site_id = 'test_site_001';
        var script = document.createElement('script');
        script.src = 'http://traffic.local/track.php?site_id=' + site_id + '&url=' + encodeURIComponent(window.location.href);
        script.async = true;
        document.body.appendChild(script);
        
        console.log('Traffic Analytics tracking loaded for site:', site_id);
    })();
    </script>
    
    <p>Open browser console to see tracking messages.</p>
    <p><a href="admin.php">View Dashboard</a></p>
</body>
</html>
EOF
```

## 🎯 **9. QUICK START COMMANDS**

```bash
# Summary of all commands to run:

# 1. Install dependencies
sudo apt update && sudo apt install -y apache2 mysql-server php php-mysql php-curl php-json php-mbstring php-xml libapache2-mod-php

# 2. Setup database
sudo mysql -u root -p <<EOF
CREATE DATABASE traffic_db;
CREATE USER 'traffic_user'@'localhost' IDENTIFIED BY 'StrongPassword123!';
GRANT ALL PRIVILEGES ON traffic_db.* TO 'traffic_user'@'localhost';
FLUSH PRIVILEGES;
EOF

# 3. Import schema
sudo mysql -u root -p traffic_db < schema.sql

# 4. Set permissions
sudo chown -R www-data:www-data /var/www/html/traffic
sudo chmod -R 755 /var/www/html/traffic

# 5. Configure Apache
sudo nano /etc/apache2/sites-available/traffic.conf
# Add VirtualHost configuration

# 6. Enable site
sudo a2ensite traffic.conf
sudo a2dissite 000-default.conf
sudo systemctl restart apache2

# 7. Edit hosts file
sudo nano /etc/hosts
# Add: 127.0.0.1 traffic.local

# 8. Test installation
curl http://traffic.local/test.php
```

## 📊 **10. MONITORING & MAINTENANCE**

```bash
# Create monitoring script
cat > monitor.sh << 'EOF'
#!/bin/bash
# monitor.sh - System monitoring

echo "Traffic Analytics Monitor"
echo "========================"
echo "Timestamp: $(date)"
echo ""

# Check services
echo "Service Status:"
systemctl is-active apache2 >/dev/null 2>&1 && echo "✓ Apache2 is running" || echo "✗ Apache2 is not running"
systemctl is-active mysql >/dev/null 2>&1 && echo "✓ MySQL is running" || echo "✗ MySQL is not running"
echo ""

# Check disk space
echo "Disk Space:"
df -h /var/www/html
echo ""

# Check memory usage
echo "Memory Usage:"
free -h
echo ""

# Check logs
echo "Recent Errors:"
tail -20 /var/log/apache2/traffic_error.log 2>/dev/null | grep -i error || echo "No recent errors found"
echo ""

# Database stats
echo "Database Statistics:"
mysql -u traffic_user -p'StrongPassword123!' traffic_db <<MYSQL_SCRIPT 2>/dev/null
SELECT 
    (SELECT COUNT(*) FROM visitors) as total_visitors,
    (SELECT COUNT(*) FROM visitors WHERE DATE(visit_date) = CURDATE()) as today_visitors,
    (SELECT COUNT(*) FROM backlinks) as total_backlinks,
    (SELECT COUNT(*) FROM backlinks WHERE status = 'active') as active_backlinks,
    (SELECT COUNT(*) FROM users) as total_users;
MYSQL_SCRIPT
EOF

chmod +x monitor.sh
```

## 🔒 **11. SECURITY HARDENING**

```bash
# Security checklist for Kali Linux:

# 1. Change default passwords
mysql -u root -p -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'NewStrongPassword!@#';"
mysql -u root -p'NewStrongPassword!@#' -e "ALTER USER 'traffic_user'@'localhost' IDENTIFIED BY 'NewTrafficPassword!@#';"

# 2. Remove install.php after setup
rm install.php

# 3. Configure firewall
sudo ufw allow 80/tcp
sudo ufw enable

# 4. Set proper file permissions
find /var/www/html/traffic -type f -exec chmod 644 {} \;
find /var/www/html/traffic -type d -exec chmod 755 {} \;
chmod 600 config.php
chmod 600 database.php

# 5. Enable SSL (optional)
sudo apt install certbot python3-certbot-apache
sudo certbot --apache -d traffic.local

# 6. Regular updates
sudo apt update && sudo apt upgrade -y
```

## 🎉 **12. FINAL VERIFICATION**

```bash
# Run complete verification
echo "=== Traffic Analytics Installation Complete ==="
echo ""
echo "✅ Services:"
sudo systemctl status apache2 --no-pager | grep Active
sudo systemctl status mysql --no-pager | grep Active

echo ""
echo "✅ Database:"
mysql -u traffic_user -p'StrongPassword123!' -e "USE traffic_db; SHOW TABLES;" traffic_db

echo ""
echo "✅ Web Access:"
echo "Dashboard: http://traffic.local/admin.php"
echo "Login: http://traffic.local/login.php"
echo "Test Tracking: http://traffic.local/track.php?site_id=test"

echo ""
echo "✅ Tracking Script for Your Websites:"
cat <<TRACKING_SCRIPT
<script>
(function() {
    var site_id = 'YOUR_SITE_ID';
    var script = document.createElement('script');
    script.src = 'http://traffic.local/track.php?site_id=' + site_id;
    script.async = true;
    document.body.appendChild(script);
})();
</script>
TRACKING_SCRIPT

echo ""
echo "=== Setup Complete ==="
echo "Default Admin Credentials:"
echo "Username: admin"
echo "Password: admin123"
echo ""
echo "IMPORTANT: Change default passwords immediately!"
```

## 🚨 **Troubleshooting Tips:**

1. **Apache won't start:**
   ```bash
   sudo apache2ctl configtest
   sudo tail -f /var/log/apache2/error.log
   ```

2. **Database connection error:**
   ```bash
   mysql -u traffic_user -p'StrongPassword123!' -e "SELECT 1;"
   sudo nano config.php  # Check credentials
   ```

3. **Permission denied errors:**
   ```bash
   sudo chown -R www-data:www-data /var/www/html/traffic
   sudo chmod -R 755 /var/www/html/traffic
   ```

4. **Tracking script not working:**
   - Check browser console for errors
   - Verify site_id parameter
   - Check CORS headers

5. **Dashboard not loading:**
   ```bash
   sudo tail -f /var/www/html/traffic/logs/php_errors.log

   ```
