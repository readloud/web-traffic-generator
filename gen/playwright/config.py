import os
from dotenv import load_dotenv

load_dotenv()

class Config:
    # Flask
    SECRET_KEY = os.getenv('SECRET_KEY', 'dev-secret-key-change-me')
    PORT = int(os.getenv('DASHBOARD_PORT', 5000))
    
    # Database - Use absolute path
    BASE_DIR = os.path.abspath(os.path.dirname(__file__))
    DB_PATH = os.path.join(BASE_DIR, 'logs', 'traffic.db')
    
    # Ensure logs directory exists
    os.makedirs(os.path.dirname(DB_PATH), exist_ok=True)
    
    # Use absolute path for database
    SQLALCHEMY_DATABASE_URI = f'sqlite:///{DB_PATH}'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    
    # Target
    TARGET_URL = os.getenv('TARGET_URL', 'https://readloud.github.io')
    
    # Proxy
    PROXY_FILE = os.getenv('PROXY_FILE', './proxies.txt')
    USE_PROXY = os.getenv('USE_PROXY', 'false').lower() == 'true'
    PROXY_ROTATION_INTERVAL = int(os.getenv('PROXY_ROTATION_INTERVAL', 300))
    
    # Traffic
    MIN_DWELL_TIME = int(os.getenv('MIN_DWELL_TIME', 30))
    MAX_DWELL_TIME = int(os.getenv('MAX_DWELL_TIME', 300))
    BOUNCE_RATE_MIN = int(os.getenv('BOUNCE_RATE_MIN', 40))
    BOUNCE_RATE_MAX = int(os.getenv('BOUNCE_RATE_MAX', 60))
    PAGE_DEPTH_MIN = int(os.getenv('PAGE_DEPTH_MIN', 1))
    PAGE_DEPTH_MAX = int(os.getenv('PAGE_DEPTH_MAX', 3))
    
    # Stealth
    USE_STEALTH = os.getenv('USE_STEALTH', 'true').lower() == 'true'
    HEADLESS = os.getenv('HEADLESS', 'true').lower() == 'true'
    RANDOMIZE_FINGERPRINT = os.getenv('RANDOMIZE_FINGERPRINT', 'true').lower() == 'true'
    
    # Scheduler
    SCHEDULE_ENABLED = os.getenv('SCHEDULE_ENABLED', 'false').lower() == 'true'
    SCHEDULE_INTERVAL = int(os.getenv('SCHEDULE_INTERVAL', 3600))
    SCHEDULE_VISITS_PER_RUN = int(os.getenv('SCHEDULE_VISITS_PER_RUN', 25))
    
    # Logging
    LOG_LEVEL = os.getenv('LOG_LEVEL', 'INFO')
    LOG_FILE = os.path.join(BASE_DIR, 'logs', 'traffic.log')
    
    # Auto-start
    AUTO_START = os.getenv('AUTO_START', 'false').lower() == 'true'
    AUTO_VISITS_PER_HOUR = int(os.getenv('AUTO_VISITS_PER_HOUR', 10))
    AUTO_DURATION_MINUTES = int(os.getenv('AUTO_DURATION_MINUTES', 60))