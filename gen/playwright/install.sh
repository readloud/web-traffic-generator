#!/bin/bash

echo "🚀 Installing Organic Traffic Generator (Python/Flask)"

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Install Playwright browsers
playwright install chromium
playwright install-deps

# Create necessary directories
mkdir -p logs
mkdir -p app/dashboard/static/css
mkdir -p app/dashboard/static/js

# Copy environment file
if [ ! -f .env ]; then
    cp .env.example .env
    echo "⚠️ Please edit .env file with your settings"
fi

# Create proxy file if it doesn't exist
if [ ! -f proxies.txt ]; then
    touch proxies.txt
    echo "⚠️ Please add proxies to proxies.txt"
fi

# Make run script executable
chmod +x run.py

echo ""
echo "✅ Installation complete!"
echo ""
echo "To start the application:"
echo "  source venv/bin/activate"
echo "  python run.py"
echo ""
echo "Or with environment variables:"
echo "  FLASK_APP=run.py FLASK_ENV=production python run.py"