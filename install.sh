#!/bin/bash

echo "🚀 Installing Organic Traffic Generator"

# Install dependencies
npm install

# Create necessary directories
mkdir -p logs
mkdir -p src/dashboard/static

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

# Make scripts executable
chmod +x src/index.js
chmod +x src/scheduler/scheduler.js

echo "✅ Installation complete!"
echo ""
echo "To start the application:"
echo "  npm start"
echo ""
echo "To start the dashboard only:"
echo "  npm run dashboard"
echo ""
echo "To start the scheduler only:"
echo "  npm run scheduler"