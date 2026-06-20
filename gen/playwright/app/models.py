from app import db
from datetime import datetime
import uuid

class Visit(db.Model):
    __tablename__ = 'visits'
    
    id = db.Column(db.Integer, primary_key=True)
    session_id = db.Column(db.String(36), unique=True, nullable=False)
    ip_address = db.Column(db.String(45))
    user_agent = db.Column(db.Text)
    referrer = db.Column(db.Text)
    landing_page = db.Column(db.Text)
    pages_visited = db.Column(db.Integer, default=1)
    total_duration = db.Column(db.Integer, default=0)
    is_bounce = db.Column(db.Boolean, default=False)
    traffic_source = db.Column(db.String(50))
    keyword = db.Column(db.String(200))
    proxy_used = db.Column(db.String(50))
    timestamp = db.Column(db.DateTime, default=datetime.utcnow)
    
    page_views = db.relationship('PageView', backref='visit', lazy=True)
    
    def to_dict(self):
        return {
            'id': self.id,
            'session_id': self.session_id,
            'ip_address': self.ip_address,
            'user_agent': self.user_agent,
            'referrer': self.referrer,
            'landing_page': self.landing_page,
            'pages_visited': self.pages_visited,
            'total_duration': self.total_duration,
            'is_bounce': self.is_bounce,
            'traffic_source': self.traffic_source,
            'keyword': self.keyword,
            'proxy_used': self.proxy_used,
            'timestamp': self.timestamp.isoformat() if self.timestamp else None
        }

class PageView(db.Model):
    __tablename__ = 'page_views'
    
    id = db.Column(db.Integer, primary_key=True)
    session_id = db.Column(db.String(36), db.ForeignKey('visits.session_id'))
    url = db.Column(db.Text)
    time_on_page = db.Column(db.Integer, default=0)
    scroll_depth = db.Column(db.Integer, default=0)
    click_count = db.Column(db.Integer, default=0)
    timestamp = db.Column(db.DateTime, default=datetime.utcnow)
    
    def to_dict(self):
        return {
            'id': self.id,
            'session_id': self.session_id,
            'url': self.url,
            'time_on_page': self.time_on_page,
            'scroll_depth': self.scroll_depth,
            'click_count': self.click_count,
            'timestamp': self.timestamp.isoformat() if self.timestamp else None
        }

class ScheduledJob(db.Model):
    __tablename__ = 'scheduled_jobs'
    
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100))
    schedule_time = db.Column(db.DateTime)
    status = db.Column(db.String(50))
    visits_generated = db.Column(db.Integer, default=0)
    timestamp = db.Column(db.DateTime, default=datetime.utcnow)
    
    def to_dict(self):
        return {
            'id': self.id,
            'name': self.name,
            'schedule_time': self.schedule_time.isoformat() if self.schedule_time else None,
            'status': self.status,
            'visits_generated': self.visits_generated,
            'timestamp': self.timestamp.isoformat() if self.timestamp else None
        }