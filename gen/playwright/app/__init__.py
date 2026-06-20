from flask import Flask
from flask_socketio import SocketIO
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy
from config import Config
import os

# Initialize extensions
db = SQLAlchemy()
socketio = SocketIO(cors_allowed_origins="*")

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)
    
    # Ensure directories exist
    os.makedirs('logs', exist_ok=True)
    os.makedirs('app/dashboard/static/css', exist_ok=True)
    os.makedirs('app/dashboard/static/js', exist_ok=True)
    
    # Ensure database directory exists
    db_path = Config.DB_PATH
    db_dir = os.path.dirname(db_path)
    if db_dir:
        os.makedirs(db_dir, exist_ok=True)
    
    # Initialize extensions
    db.init_app(app)
    CORS(app)
    socketio.init_app(app, async_mode='eventlet')
    
    # Import models here to avoid circular imports
    from app.models import Visit, PageView, ScheduledJob
    
    # Register blueprints
    from app.dashboard.routes import dashboard_bp
    app.register_blueprint(dashboard_bp)
    
    # Create tables if they don't exist
    with app.app_context():
        db.create_all()
        print(f"✅ Database created at: {Config.DB_PATH}")
    
    return app