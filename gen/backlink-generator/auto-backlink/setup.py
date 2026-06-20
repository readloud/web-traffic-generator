#!/usr/bin/env python3
"""
Setup script for Traffic Analytics System
"""

import os
import sys
import subprocess
import sqlite3
from datetime import datetime

def check_python_version():
    """Check Python version"""
    if sys.version_info < (3, 7):
        print("❌ Python 3.7 or higher is required")
        sys.exit(1)
    print("✅ Python version check passed")

def download_geoip_database():
    """Download GeoLite2 database"""
    import urllib.request
    import tarfile
    
    geoip_url = "https://git.io/GeoLite2-City.mmdb"
    geoip_path = "GeoLite2-City.mmdb"
    
    if not os.path.exists(geoip_path):
        print("🌍 Downloading GeoIP database...")
        try:
            urllib.request.urlretrieve(geoip_url, geoip_path)
            print("✅ GeoIP database downloaded")
        except:
            print("⚠️ Could not download GeoIP database. Proceeding without it.")

def setup_database():
    """Setup SQLite database"""
    print("🗄️ Setting up database...")
    
    conn = sqlite3.connect('traffic.db')
    cursor = conn.cursor()
    
    # Create tables
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS visitor (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        ip_address VARCHAR(45),
        user_agent TEXT,
        referrer TEXT,
        page_url TEXT,
        visit_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        country VARCHAR(100),
        city VARCHAR(100),
        browser VARCHAR(100),
        os VARCHAR(100),
        device VARCHAR(50)
    )
    ''')
    
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS backlink (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        url VARCHAR(500),
        backlink_code TEXT,
        traffic_count INTEGER DEFAULT 0,
        status VARCHAR(20) DEFAULT 'active',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        last_checked TIMESTAMP,
        platform VARCHAR(50),
        da_score INTEGER
    )
    ''')
    
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS user (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username VARCHAR(80) UNIQUE,
        password_hash VARCHAR(120)
    )
    ''')
    
    # Create indexes
    cursor.execute('CREATE INDEX IF NOT EXISTS idx_visitor_date ON visitor(visit_date)')
    cursor.execute('CREATE INDEX IF NOT EXISTS idx_backlink_status ON backlink(status)')
    cursor.execute('CREATE INDEX IF NOT EXISTS idx_backlink_platform ON backlink(platform)')
    
    # Create admin user
    from werkzeug.security import generate_password_hash
    
    admin_password = input("Enter admin password (default: admin123): ") or "admin123"
    password_hash = generate_password_hash(admin_password)
    
    try:
        cursor.execute(
            'INSERT OR IGNORE INTO user (username, password_hash) VALUES (?, ?)',
            ('admin', password_hash)
        )
    except:
        pass
    
    conn.commit()
    conn.close()
    
    print("✅ Database setup completed")

def create_config_files():
    """Create configuration files"""
    print("⚙️ Creating configuration files...")
    
    # Create .env file
    with open('.env', 'w') as f:
        f.write('''# Traffic Analytics Configuration
SECRET_KEY=your-secret-key-here-change-this
DATABASE_URL=sqlite:///traffic.db
DEBUG=False
GEOIP_PATH=GeoLite2-City.mmdb

# Backlink Automation
BACKLINK_MIN_DA=20
BACKLINK_MAX_DA=80
AUTO_BACKLINK_CHANCE=0.3
BACKLINK_CHECK_INTERVAL=24

# API Keys (optional)
# GOOGLE_API_KEY=your_google_api_key
# GITHUB_TOKEN=your_github_token
''')
    
    # Create config.py
    with open('config.py', 'w') as f:
        f.write('''import os
from dotenv import load_dotenv

load_dotenv()

class Config:
    SECRET_KEY = os.getenv('SECRET_KEY', 'dev-secret-key')
    SQLALCHEMY_DATABASE_URI = os.getenv('DATABASE_URL', 'sqlite:///traffic.db')
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    GEOIP_PATH = os.getenv('GEOIP_PATH', 'GeoLite2-City.mmdb')
    
    # Backlink settings
    BACKLINK_MIN_DA = int(os.getenv('BACKLINK_MIN_DA', 20))
    BACKLINK_MAX_DA = int(os.getenv('BACKLINK_MAX_DA', 80))
    AUTO_BACKLINK_CHANCE = float(os.getenv('AUTO_BACKLINK_CHANCE', 0.3))
    BACKLINK_CHECK_INTERVAL = int(os.getenv('BACKLINK_CHECK_INTERVAL', 24))
''')
    
    print("✅ Configuration files created")

def create_directories():
    """Create necessary directories"""
    directories = ['templates', 'static', 'logs', 'backups']
    
    for directory in directories:
        if not os.path.exists(directory):
            os.makedirs(directory)
            print(f"📁 Created directory: {directory}")

def print_instructions():
    """Print setup completion instructions"""
    print("\n" + "="*50)
    print("✅ SETUP COMPLETED SUCCESSFULLY!")
    print("="*50)
    print("\n📋 Next Steps:")
    print("1. Start the server: python main.py")
    print("2. Access dashboard: http://localhost:5000")
    print("3. Login with: admin / [your password]")
    print("\n🔧 Additional Configuration:")
    print("   - Edit .env file for custom settings")
    print("   - Place GeoLite2-City.mmdb in project root for location tracking")
    print("\n🚀 To start backlink automation:")
    print("   python backlink_automation.py --schedule")
    print("\n📊 To embed tracker in your website:")
    print("   Add: <script src='http://127.0.0.1:5000/static/tracker.js'></script>")
    print("="*50)

def main():
    """Main setup function"""
    print("🚀 Traffic Analytics System Setup")
    print("="*50)
    
    check_python_version()
    download_geoip_database()
    create_directories()
    setup_database()
    create_config_files()
    print_instructions()

if __name__ == "__main__":
    main()
