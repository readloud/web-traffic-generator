const express = require('express');
const path = require('path');
const http = require('http');
const socketIO = require('socket.io');
const cors = require('cors');
const rateLimit = require('express-rate-limit');
const Database = require('../database/database');
const TrafficGenerator = require('../traffic/generator');
const config = require('../../config/config');

const app = express();
const server = http.createServer(app);
const io = socketIO(server);

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname, 'static')));

// Rate limiting
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 100
});
app.use('/api/', limiter);

// Initialize generator
const generator = new TrafficGenerator();

// Routes
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'static', 'index.html'));
});

app.get('/api/stats', async (req, res) => {
  try {
    const stats = await Database.getStats();
    const generatorStats = generator.getStats();
    res.json({
      ...stats,
      ...generatorStats,
      proxyCount: require('../proxy/ProxyManager').getProxyCount()
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.get('/api/recent', async (req, res) => {
  try {
    const limit = parseInt(req.query.limit) || 50;
    const visits = await Database.getRecentVisits(limit);
    res.json(visits);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.get('/api/export/csv', async (req, res) => {
  try {
    const data = await Database.exportToCSV();
    const { Parser } = require('json2csv');
    const parser = new Parser({
      fields: ['session_id', 'ip_address', 'user_agent', 'traffic_source', 
               'keyword', 'pages_visited', 'total_duration', 'is_bounce', 'timestamp']
    });
    const csv = parser.parse(data);
    
    res.header('Content-Type', 'text/csv');
    res.attachment('traffic_data.csv');
    res.send(csv);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.post('/api/generate', async (req, res) => {
  try {
    const { visits = 10, mode = 'burst' } = req.body;
    
    if (generator.isRunning) {
      return res.status(400).json({ error: 'Generator already running' });
    }
    
    // Run generator in background
    if (mode === 'burst') {
      generator.generateBurst(visits);
    } else if (mode === 'continuous') {
      generator.generateContinuous({
        visitsPerHour: visits,
        durationMinutes: 60
      });
    }
    
    res.json({ success: true, message: 'Traffic generation started' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.post('/api/stop', async (req, res) => {
  try {
    await generator.stop();
    res.json({ success: true, message: 'Generator stopped' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// WebSocket for real-time updates
io.on('connection', (socket) => {
  console.log('📡 Client connected');
  
  // Send initial stats
  socket.emit('stats', { 
    message: 'Connected to traffic generator'
  });
  
  // Send updates every 5 seconds
  const interval = setInterval(async () => {
    try {
      const stats = await Database.getStats();
      socket.emit('stats_update', stats);
    } catch (error) {
      console.error('Error sending stats update:', error);
    }
  }, 5000);
  
  socket.on('disconnect', () => {
    clearInterval(interval);
    console.log('📡 Client disconnected');
  });
});

// Start server
async function startDashboard() {
  await Database.init();
  
  server.listen(config.dashboard.port, () => {
    console.log(`📊 Dashboard running on http://localhost:${config.dashboard.port}`);
  });
}

if (require.main === module) {
  startDashboard();
}

module.exports = { app, server, io };