## 🚀 Quick Start Guide

### Installation

```bash
# Create a fresh virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Make install script executable and run it
chmod +x install.sh
./install.sh

# Upgrade pip first
pip install --upgrade pip

# Install with the fixed requirements
pip install -r requirements.txt

# If using playwright, install browsers
playwright install chromium
```

### Running the Application

```bash
# Edit configuration
nano .env

# Add proxies (optional)
nano proxies.txt

# Start the application
python run.py

# Access the dashboard
http://localhost:5000
```

### API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/` | GET | Dashboard |
| `/api/stats` | GET | Get all statistics |
| `/api/recent` | GET | Get recent visits |
| `/api/timeline` | GET | Get traffic timeline |
| `/api/traffic-sources` | GET | Get source breakdown |
| `/api/generate` | POST | Start traffic generation |
| `/api/stop` | POST | Stop traffic generation |
| `/api/export/csv` | GET | Export data to CSV |
| `/api/proxies/refresh` | POST | Refresh proxy list |
| `/api/config` | GET | Get configuration |

## ✅ Features Implemented

### 1. Behavior Simulation ✅
- Random dwell time (30s - 5min)
- Scroll behavior with variable speed
- Mouse movement with Bezier curves
- Internal link clicks (page depth 1-3)
- Natural bounce rate (40-60%)

### 2. Traffic Source Variation ✅
- Direct traffic
- Organic search (Google, Bing, DuckDuckGo)
- Referral traffic
- Social media traffic

### 3. Anti-Detection ✅
- User-Agent rotation
- Proxy/IP rotation (HTTP/HTTPS/SOCKS5)
- Headless browser with stealth
- Canvas fingerprint & WebGL randomization
- Timezone & geolocation matching

### 4. Dashboard & Output ✅
- Real-time monitoring dashboard
- Statistics: total visits, unique visitors, avg duration, bounce rate
- Traffic source breakdown
- Export to CSV
- Scheduler with cron support

### 5. Technology Stack ✅
- Python 3.11+
- Flask + Flask-SocketIO
- Playwright + playwright-stealth
- SQLite/MySQL
- APScheduler
- **REQUIRE**: Flask Flask-SocketIO Flask-SQLAlchemy Flask-CORS Faker playwright playwright-stealth aiohttp pandas python-engineio python-socketio SQLAlchemy python-dotenv dotenv python-dateutil schedule requests APScheduler eventlet

## 🔐 Security & Legal Notice

**IMPORTANT**: This software is for **educational purposes only**. Use only on websites you own or have explicit permission to test. Unauthorized traffic generation may violate:

- Terms of Service of websites
- Computer Fraud and Abuse Act (CFAA)
- Various international cybercrime laws
- Google Analytics Terms of Service

## 📝 Notes

1. **First run**: Install Playwright browsers with `playwright install chromium`
2. **Proxies**: For best results, use residential proxies
3. **Headless mode**: Set `HEADLESS=true` for production
4. **Database**: SQLite is used by default, can be changed to MySQL
5. **Performance**: Adjust `MIN_DWELL_TIME` and `MAX_DWELL_TIME` for realistic behavior

## 🔧 Troubleshooting

If you still get errors:

1. **Delete the database and start fresh**:
```bash
rm logs/traffic.db
python run.py
```

2. **Check if all dependencies are installed**:
```bash
pip list | findstr Flask
pip list | findstr playwright
```

3. **Run with debug mode**:
```python
# In run.py, change debug=True
socketio.run(app, host='0.0.0.0', port=Config.PORT, debug=True)
```
