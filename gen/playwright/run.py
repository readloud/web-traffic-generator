#!/usr/bin/env python3
"""
Organic Traffic Generator - Main Entry Point
"""

import os
import sys
import asyncio
import logging
from config import Config
from app import create_app, socketio

# Create all necessary directories FIRST
os.makedirs('logs', exist_ok=True)
os.makedirs('app/dashboard/static/css', exist_ok=True)
os.makedirs('app/dashboard/static/js', exist_ok=True)

# Ensure database directory exists
db_dir = os.path.dirname(Config.DB_PATH)
if db_dir:
    os.makedirs(db_dir, exist_ok=True)

# Configure logging
log_file = Config.LOG_FILE
log_dir = os.path.dirname(log_file)
if log_dir:
    os.makedirs(log_dir, exist_ok=True)

logging.basicConfig(
    level=getattr(logging, Config.LOG_LEVEL, 'INFO'),
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(log_file, encoding='utf-8'),
        logging.StreamHandler()
    ]
)

logger = logging.getLogger(__name__)

def setup_environment():
    """Setup environment and create necessary directories"""
    os.makedirs('logs', exist_ok=True)
    os.makedirs('app/dashboard/static/css', exist_ok=True)
    os.makedirs('app/dashboard/static/js', exist_ok=True)
    
    # Create proxy file if it doesn't exist
    if not os.path.exists('proxies.txt'):
        with open('proxies.txt', 'w') as f:
            f.write('# Add your proxies here\n')
            f.write('# Format: http://user:pass@host:port\n')
            f.write('# Example: http://user:pass@192.168.1.100:8080\n')
            f.write('# Or just: http://192.168.1.100:8080\n')
    
    # Touch database file
    db_path = Config.DB_PATH
    db_dir = os.path.dirname(db_path)
    if db_dir:
        os.makedirs(db_dir, exist_ok=True)
    if not os.path.exists(db_path):
        open(db_path, 'a').close()
        logger.info(f"✅ Created database file: {db_path}")

def main():
    """Main entry point"""
    try:
        setup_environment()
        logger.info("📁 Environment setup complete")
        logger.info(f"📁 Database path: {Config.DB_PATH}")
        logger.info(f"📁 Log file: {Config.LOG_FILE}")
        
        # Create Flask app
        app = create_app()
        logger.info("✅ Application created")
        
        # Start the background stats update thread
        def push_stats_updates():
            """Background task to push stats to all clients"""
            import time
            while True:
                try:
                    with app.app_context():
                        from app.database import db_manager
                        from app.dashboard.routes import generator, proxy_manager
                        stats = db_manager.get_stats()
                        gen_stats = generator.get_stats()
                        stats.update({
                            'running': gen_stats.get('running', False),
                            'successful_visits': gen_stats.get('successful_visits', 0),
                            'failed_visits': gen_stats.get('failed_visits', 0),
                            'proxy_count': proxy_manager.get_count()
                        })
                        socketio.emit('stats_update', stats)
                except Exception as e:
                    logger.error(f"Error pushing stats updates: {e}")
                
                # Wait 5 seconds
                time.sleep(5)
        
        # Start stats thread
        import threading
        stats_thread = threading.Thread(target=push_stats_updates, daemon=True)
        stats_thread.start()
        logger.info("📊 Stats update thread started")
        
        # Run Flask app with Socket.IO
        logger.info(f"🚀 Starting server on port {Config.PORT}")
        logger.info(f"🌐 Dashboard: http://localhost:{Config.PORT}")
        logger.info("Press Ctrl+C to stop")
        
        socketio.run(
            app,
            host='0.0.0.0',
            port=Config.PORT,
            debug=False,
            allow_unsafe_werkzeug=True,
            use_reloader=False
        )
        
    except KeyboardInterrupt:
        logger.info("🛑 Shutting down...")
        sys.exit(0)
    except Exception as e:
        logger.error(f"❌ Fatal error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)

if __name__ == '__main__':
    main()