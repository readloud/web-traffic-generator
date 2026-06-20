module.exports = {
  createTables: `
    CREATE TABLE IF NOT EXISTS visits (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      session_id TEXT UNIQUE,
      ip_address TEXT,
      user_agent TEXT,
      referrer TEXT,
      landing_page TEXT,
      pages_visited INTEGER,
      total_duration INTEGER,
      is_bounce BOOLEAN,
      traffic_source TEXT,
      keyword TEXT,
      proxy_used TEXT,
      timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
    );
    
    CREATE TABLE IF NOT EXISTS page_views (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      session_id TEXT,
      url TEXT,
      time_on_page INTEGER,
      scroll_depth INTEGER,
      click_count INTEGER,
      timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (session_id) REFERENCES visits(session_id)
    );
    
    CREATE TABLE IF NOT EXISTS scheduled_jobs (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      schedule_time DATETIME,
      status TEXT,
      visits_generated INTEGER,
      timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
    );
    
    CREATE INDEX IF NOT EXISTS idx_visits_timestamp ON visits(timestamp);
    CREATE INDEX IF NOT EXISTS idx_visits_traffic_source ON visits(traffic_source);
  `,
  
  insertVisit: `
    INSERT INTO visits (
      session_id, ip_address, user_agent, referrer, landing_page,
      pages_visited, total_duration, is_bounce, traffic_source,
      keyword, proxy_used
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  `,
  
  insertPageView: `
    INSERT INTO page_views (
      session_id, url, time_on_page, scroll_depth, click_count
    ) VALUES (?, ?, ?, ?, ?)
  `,
  
  insertScheduledJob: `
    INSERT INTO scheduled_jobs (name, schedule_time, status, visits_generated)
    VALUES (?, ?, ?, ?)
  `
};