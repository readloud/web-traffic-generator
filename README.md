## 🚀 Quick Start Guide

### Installation

```bash
# Install dependencies
npm install

# Start dashboard only
npm run dashboard

# Start scheduler only
npm run scheduler

# Start the application (includes dashboard, scheduler, and generator)
npm start

# Development mode with auto-reload
npm run dev

# Generate a single traffic burst (use API or dashboard)
curl -X POST http://localhost:3000/api/generate \
  -H "Content-Type: application/json" \
  -d '{"visits": 10, "mode": "burst"}'

# Export data to CSV
curl http://localhost:3000/api/export/csv > traffic_data.csv
```

## 🎯 Key Features Implemented

### ✅ Behavioral Simulation
- Random dwell time (30 sec - 5 min)
- Realistic scroll behavior with variable speed
- Mouse movement tracking with Bezier curves
- Random internal link clicks (page depth 1-3)
- Natural bounce rate (40-60%)

### ✅ Traffic Source Variation
- Direct traffic
- Organic search (Google, Bing) with keyword simulation
- Referral traffic from various domains
- Social media traffic (Facebook, Instagram, Twitter, TikTok)

### ✅ Anti-Detection
- User-Agent rotation (Chrome, Firefox, Safari, Edge, Mobile)
- Proxy/IP rotation (HTTP/HTTPS/SOCKS5)
- Headless browser with stealth plugin
- Canvas fingerprint & WebGL randomization
- Timezone & geolocation matching

### ✅ Dashboard & Output
- Real-time monitoring dashboard
- Statistics: total visits, unique visitors, avg session duration, bounce rate
- Traffic source breakdown
- Export to CSV
- Scheduler with cron support

## 🔐 Security & Legal Notice

This software is for **educational purposes only**. Use responsibly and only on websites you own or have explicit permission to test. Unauthorized traffic generation may violate:
- Terms of Service of websites
- Computer Fraud and Abuse Act (CFAA)
- Various international cybercrime laws

## 🚀 Performance Tips

1. **Use residential proxies** for best anti-detection results
2. **Enable stealth mode** for better fingerprint randomization
3. **Keep headless mode disabled** during testing (enabled for production)
4. **Adjust dwell times** to match real user behavior
5. **Use the scheduler** for consistent traffic patterns