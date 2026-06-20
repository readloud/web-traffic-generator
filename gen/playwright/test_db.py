import os
import sys
from config import Config

print("Testing database configuration...")
print(f"BASE_DIR: {Config.BASE_DIR}")
print(f"DB_PATH: {Config.DB_PATH}")

# Ensure directory exists
db_dir = os.path.dirname(Config.DB_PATH)
if db_dir:
    os.makedirs(db_dir, exist_ok=True)
    print(f"✅ Directory created: {db_dir}")

# Test creating the database
from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = Config.SQLALCHEMY_DATABASE_URI
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

class Test(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100))

try:
    with app.app_context():
        db.create_all()
        print("✅ Database created successfully!")
        print(f"✅ Database file exists: {os.path.exists(Config.DB_PATH)}")
        
        # Test insert
        test = Test(name="test")
        db.session.add(test)
        db.session.commit()
        print("✅ Test insert successful!")
        
        # Test query
        result = Test.query.first()
        print(f"✅ Test query successful: {result.name}")
        
        print("\n🎉 Database is working properly!")
        
except Exception as e:
    print(f"❌ Error: {e}")
    import traceback
    traceback.print_exc()