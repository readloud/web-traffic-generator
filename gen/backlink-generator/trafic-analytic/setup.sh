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