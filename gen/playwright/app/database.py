from app import db
from app.models import Visit, PageView, ScheduledJob
from datetime import datetime, timedelta
from sqlalchemy import func
import pandas as pd
import os

class DatabaseManager:
    @staticmethod
    def init_app(app):
        """Initialize database with app context"""
        with app.app_context():
            # Ensure directory exists
            db_path = app.config['SQLALCHEMY_DATABASE_URI'].replace('sqlite:///', '')
            db_dir = os.path.dirname(db_path)
            if db_dir:
                os.makedirs(db_dir, exist_ok=True)
            db.create_all()
    
    @staticmethod
    def log_visit(data):
        try:
            visit = Visit(
                session_id=data['session_id'],
                ip_address=data.get('ip_address'),
                user_agent=data.get('user_agent'),
                referrer=data.get('referrer'),
                landing_page=data.get('landing_page'),
                pages_visited=data.get('pages_visited', 1),
                total_duration=data.get('total_duration', 0),
                is_bounce=data.get('is_bounce', False),
                traffic_source=data.get('traffic_source', 'direct'),
                keyword=data.get('keyword'),
                proxy_used=data.get('proxy_used')
            )
            db.session.add(visit)
            db.session.commit()
            return visit.id
        except Exception as e:
            db.session.rollback()
            raise e
    
    @staticmethod
    def log_page_view(data):
        try:
            page_view = PageView(
                session_id=data['session_id'],
                url=data.get('url'),
                time_on_page=data.get('time_on_page', 0),
                scroll_depth=data.get('scroll_depth', 0),
                click_count=data.get('click_count', 0)
            )
            db.session.add(page_view)
            db.session.commit()
            return page_view.id
        except Exception as e:
            db.session.rollback()
            raise e
    
    @staticmethod
    def log_scheduled_job(data):
        try:
            job = ScheduledJob(
                name=data['name'],
                schedule_time=data.get('schedule_time', datetime.utcnow()),
                status=data.get('status', 'pending'),
                visits_generated=data.get('visits_generated', 0)
            )
            db.session.add(job)
            db.session.commit()
            return job.id
        except Exception as e:
            db.session.rollback()
            raise e
    
    @staticmethod
    def get_stats():
        try:
            stats = {
                'total_visits': Visit.query.count(),
                'unique_visitors': db.session.query(func.count(Visit.session_id.distinct())).scalar(),
                'avg_duration': db.session.query(func.avg(Visit.total_duration)).scalar() or 0,
                'bounce_rate': 0,
                'traffic_sources': {},
                'last_24_hours': Visit.query.filter(
                    Visit.timestamp >= datetime.utcnow() - timedelta(hours=24)
                ).count(),
                'page_depth': db.session.query(func.avg(Visit.pages_visited)).scalar() or 0
            }
            
            # Calculate bounce rate
            total = stats['total_visits']
            if total > 0:
                bounces = Visit.query.filter(Visit.is_bounce == True).count()
                stats['bounce_rate'] = round((bounces / total) * 100, 2)
            
            # Traffic sources breakdown
            sources = db.session.query(
                Visit.traffic_source,
                func.count(Visit.id)
            ).group_by(Visit.traffic_source).all()
            
            for source, count in sources:
                stats['traffic_sources'][source] = count
            
            return stats
        except Exception as e:
            print(f"Error getting stats: {e}")
            return {
                'total_visits': 0,
                'unique_visitors': 0,
                'avg_duration': 0,
                'bounce_rate': 0,
                'traffic_sources': {},
                'last_24_hours': 0,
                'page_depth': 0
            }
    
    @staticmethod
    def get_recent_visits(limit=50):
        try:
            visits = Visit.query.order_by(Visit.timestamp.desc()).limit(limit).all()
            return [visit.to_dict() for visit in visits]
        except:
            return []
    
    @staticmethod
    def get_traffic_timeline(hours=24):
        try:
            start_time = datetime.utcnow() - timedelta(hours=hours)
            data = db.session.query(
                func.strftime('%Y-%m-%d %H:00:00', Visit.timestamp).label('hour'),
                func.count(Visit.id).label('count')
            ).filter(Visit.timestamp >= start_time).group_by('hour').order_by('hour').all()
            
            return [{'hour': row.hour, 'count': row.count} for row in data]
        except:
            return []
    
    @staticmethod
    def export_to_csv():
        try:
            visits = Visit.query.all()
            data = [visit.to_dict() for visit in visits]
            df = pd.DataFrame(data)
            return df.to_csv(index=False)
        except:
            return ''
    
    @staticmethod
    def get_traffic_breakdown():
        try:
            sources = db.session.query(
                Visit.traffic_source,
                func.count(Visit.id).label('count')
            ).group_by(Visit.traffic_source).all()
            
            return {source: count for source, count in sources}
        except:
            return {}

db_manager = DatabaseManager()