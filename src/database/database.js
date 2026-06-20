const sqlite3 = require('sqlite3').verbose();
const { open } = require('sqlite');
const path = require('path');
const fs = require('fs');
const models = require('./models');
const config = require('../../config/config');

class Database {
  constructor() {
    this.db = null;
    this.initialized = false;
  }

  async init() {
    const dbPath = config.database.path;
    const dir = path.dirname(dbPath);
    
    // Ensure directory exists
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }

    this.db = await open({
      filename: dbPath,
      driver: sqlite3.Database
    });

    // Create tables
    await this.db.exec(models.createTables);
    this.initialized = true;
    console.log('✅ Database initialized');
    return this.db;
  }

  async logVisit(data) {
    if (!this.initialized) await this.init();
    
    const result = await this.db.run(
      models.insertVisit,
      data.sessionId,
      data.ipAddress,
      data.userAgent,
      data.referrer,
      data.landingPage,
      data.pagesVisited,
      data.totalDuration,
      data.isBounce ? 1 : 0,
      data.trafficSource,
      data.keyword || null,
      data.proxyUsed || null
    );
    return result.lastID;
  }

  async logPageView(data) {
    if (!this.initialized) await this.init();
    
    await this.db.run(
      models.insertPageView,
      data.sessionId,
      data.url,
      data.timeOnPage,
      data.scrollDepth,
      data.clickCount
    );
  }

  async logScheduledJob(data) {
    if (!this.initialized) await this.init();
    
    await this.db.run(
      models.insertScheduledJob,
      data.name,
      data.scheduleTime,
      data.status,
      data.visitsGenerated
    );
  }

  async getStats() {
    if (!this.initialized) await this.init();
    
    const stats = {
      totalVisits: 0,
      uniqueVisitors: 0,
      avgDuration: 0,
      bounceRate: 0,
      trafficSources: {},
      last24Hours: 0,
      pageDepth: 0
    };

    // Total visits
    const totalResult = await this.db.get('SELECT COUNT(*) as count FROM visits');
    stats.totalVisits = totalResult?.count || 0;

    // Unique visitors (session_id is unique per visit)
    const uniqueResult = await this.db.get('SELECT COUNT(DISTINCT session_id) as count FROM visits');
    stats.uniqueVisitors = uniqueResult?.count || 0;

    // Average duration
    const avgResult = await this.db.get('SELECT AVG(total_duration) as avg FROM visits');
    stats.avgDuration = Math.round(avgResult?.avg || 0);

    // Bounce rate
    const bounceResult = await this.db.get(
      'SELECT (COUNT(CASE WHEN is_bounce = 1 THEN 1 END) * 100.0 / COUNT(*)) as rate FROM visits'
    );
    stats.bounceRate = Math.round(bounceResult?.rate || 0);

    // Traffic sources
    const sourcesResult = await this.db.all(
      'SELECT traffic_source, COUNT(*) as count FROM visits GROUP BY traffic_source'
    );
    sourcesResult.forEach(row => {
      stats.trafficSources[row.traffic_source] = row.count;
    });

    // Last 24 hours
    const last24Result = await this.db.get(
      "SELECT COUNT(*) as count FROM visits WHERE timestamp >= datetime('now', '-24 hours')"
    );
    stats.last24Hours = last24Result?.count || 0;

    // Average page depth
    const depthResult = await this.db.get('SELECT AVG(pages_visited) as avg FROM visits');
    stats.pageDepth = Math.round(depthResult?.avg || 0);

    return stats;
  }

  async getRecentVisits(limit = 50) {
    if (!this.initialized) await this.init();
    
    return await this.db.all(
      `SELECT * FROM visits ORDER BY timestamp DESC LIMIT ?`,
      limit
    );
  }

  async getTrafficBreakdown(startDate, endDate) {
    if (!this.initialized) await this.init();
    
    return await this.db.all(
      `SELECT 
        strftime('%H:00', timestamp) as hour,
        traffic_source,
        COUNT(*) as count
       FROM visits
       WHERE timestamp BETWEEN ? AND ?
       GROUP BY hour, traffic_source
       ORDER BY hour`,
      startDate,
      endDate
    );
  }

  async exportToCSV() {
    if (!this.initialized) await this.init();
    
    return await this.db.all('SELECT * FROM visits ORDER BY timestamp DESC');
  }

  async close() {
    if (this.db) {
      await this.db.close();
      this.initialized = false;
    }
  }
}

module.exports = new Database();