CREATE DATABASE traffic_db;
USE traffic_db;

CREATE TABLE visitors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    ip_address VARCHAR(45),
    user_agent TEXT,
    referrer TEXT,
    page_url TEXT,
    visit_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    country VARCHAR(100),
    browser VARCHAR(100)
);

CREATE TABLE backlinks (
    id INT PRIMARY KEY AUTO_INCREMENT,
    url VARCHAR(500),
    backlink_code TEXT,
    traffic_count INT DEFAULT 0,
    status ENUM('active', 'inactive', 'pending'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_checked TIMESTAMP
);

CREATE INDEX idx_visitors_date ON visitors(visit_date);
CREATE INDEX idx_backlinks_status ON backlinks(status);
