require('dotenv').config();

module.exports = {
  database: {
    path: process.env.DB_PATH || './logs/traffic.db'
  },
  dashboard: {
    port: parseInt(process.env.DASHBOARD_PORT) || 3000,
    secret: process.env.DASHBOARD_SECRET || 'default-secret-change-me'
  },
  proxy: {
    file: process.env.PROXY_FILE || './proxies.txt',
    rotationInterval: parseInt(process.env.PROXY_ROTATION_INTERVAL) || 300000,
    enabled: process.env.USE_PROXY === 'true'
  },
  traffic: {
    minDwellTime: parseInt(process.env.MIN_DWELL_TIME) || 30,
    maxDwellTime: parseInt(process.env.MAX_DWELL_TIME) || 300,
    bounceRateMin: parseInt(process.env.BOUNCE_RATE_MIN) || 40,
    bounceRateMax: parseInt(process.env.BOUNCE_RATE_MAX) || 60,
    pageDepthMin: parseInt(process.env.PAGE_DEPTH_MIN) || 1,
    pageDepthMax: parseInt(process.env.PAGE_DEPTH_MAX) || 3,
    targetUrl: process.env.TARGET_URL || 'http://localhost:3000'
  },
  scheduler: {
    enabled: process.env.SCHEDULE_ENABLED === 'true',
    cron: process.env.SCHEDULE_CRON || '0 */4 * * *'
  },
  stealth: {
    enabled: process.env.USE_STEALTH === 'true',
    randomizeFingerprint: process.env.RANDOMIZE_FINGERPRINT === 'true',
    headless: process.env.HEADLESS === 'true'
  },
  logging: {
    level: process.env.LOG_LEVEL || 'info',
    file: process.env.LOG_FILE || './logs/traffic.log'
  }
};