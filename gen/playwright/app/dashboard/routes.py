from flask import Blueprint, render_template, jsonify, request, send_file
from flask_socketio import emit
from app import socketio, db
from app.database import db_manager
from app.traffic import TrafficGenerator
from app.proxy import ProxyManager
from config import Config
import asyncio
import threading
import io
import json
import logging
from datetime import datetime

dashboard_bp = Blueprint('dashboard', __name__, template_folder='static')
logger = logging.getLogger(__name__)

# Initialize components
generator = TrafficGenerator()
proxy_manager = ProxyManager()

@dashboard_bp.route('/')
def index():
    """Dashboard main page"""
    try:
        return render_template('index.html')
    except Exception as e:
        logger.error(f"Error rendering template: {e}")
        return jsonify({'error': str(e)}), 500

@dashboard_bp.route('/api/stats')
def get_stats():
    """Get all statistics"""
    try:
        stats = db_manager.get_stats()
        gen_stats = generator.get_stats()
        
        stats.update({
            'running': gen_stats.get('running', False),
            'successful_visits': gen_stats.get('successful_visits', 0),
            'failed_visits': gen_stats.get('failed_visits', 0),
            'proxy_count': proxy_manager.get_count(),
            'target_url': Config.TARGET_URL
        })
        
        return jsonify(stats)
    except Exception as e:
        logger.error(f"Error getting stats: {e}")
        return jsonify({'error': str(e)}), 500

@dashboard_bp.route('/api/recent')
def get_recent():
    """Get recent visits"""
    try:
        limit = request.args.get('limit', 50, type=int)
        visits = db_manager.get_recent_visits(limit)
        return jsonify(visits)
    except Exception as e:
        logger.error(f"Error getting recent visits: {e}")
        return jsonify({'error': str(e)}), 500

@dashboard_bp.route('/api/timeline')
def get_timeline():
    """Get traffic timeline"""
    try:
        hours = request.args.get('hours', 24, type=int)
        data = db_manager.get_traffic_timeline(hours)
        return jsonify(data)
    except Exception as e:
        logger.error(f"Error getting timeline: {e}")
        return jsonify({'error': str(e)}), 500

@dashboard_bp.route('/api/traffic-sources')
def get_traffic_sources():
    """Get traffic source breakdown"""
    try:
        data = db_manager.get_traffic_breakdown()
        return jsonify(data)
    except Exception as e:
        logger.error(f"Error getting traffic sources: {e}")
        return jsonify({'error': str(e)}), 500

@dashboard_bp.route('/api/generate', methods=['POST'])
def generate_traffic():
    """Start traffic generation"""
    try:
        data = request.json
        visits = data.get('visits', 10)
        mode = data.get('mode', 'burst')
        
        if generator.is_running:
            return jsonify({'error': 'Generator already running'}), 400
        
        def run_generator():
            loop = asyncio.new_event_loop()
            asyncio.set_event_loop(loop)
            try:
                if mode == 'burst':
                    loop.run_until_complete(generator.generate_burst(visits))
                elif mode == 'continuous':
                    loop.run_until_complete(
                        generator.generate_continuous(
                            visits_per_hour=visits,
                            duration_minutes=60
                        )
                    )
            except Exception as e:
                logger.error(f"Generator error: {e}")
            finally:
                loop.close()
        
        thread = threading.Thread(target=run_generator)
        thread.daemon = True
        thread.start()
        
        return jsonify({
            'success': True,
            'message': f'Traffic generation started ({mode} mode)'
        })
        
    except Exception as e:
        logger.error(f"Error starting generation: {e}")
        return jsonify({'error': str(e)}), 500

@dashboard_bp.route('/api/stop', methods=['POST'])
def stop_traffic():
    """Stop traffic generation"""
    try:
        loop = asyncio.new_event_loop()
        asyncio.set_event_loop(loop)
        try:
            loop.run_until_complete(generator.stop())
        finally:
            loop.close()
        
        return jsonify({'success': True, 'message': 'Generator stopped'})
    except Exception as e:
        logger.error(f"Error stopping generator: {e}")
        return jsonify({'error': str(e)}), 500

@dashboard_bp.route('/api/export/csv')
def export_csv():
    """Export data to CSV"""
    try:
        csv_data = db_manager.export_to_csv()
        
        return send_file(
            io.BytesIO(csv_data.encode('utf-8')),
            mimetype='text/csv',
            as_attachment=True,
            download_name=f'traffic_data_{datetime.now().strftime("%Y%m%d_%H%M%S")}.csv'
        )
    except Exception as e:
        logger.error(f"Error exporting CSV: {e}")
        return jsonify({'error': str(e)}), 500

@dashboard_bp.route('/api/proxies/refresh', methods=['POST'])
def refresh_proxies():
    """Refresh proxy list"""
    try:
        proxy_manager.refresh()
        return jsonify({
            'success': True,
            'count': proxy_manager.get_count()
        })
    except Exception as e:
        logger.error(f"Error refreshing proxies: {e}")
        return jsonify({'error': str(e)}), 500

@dashboard_bp.route('/api/config')
def get_config():
    """Get current configuration"""
    try:
        config_data = {
            'target_url': Config.TARGET_URL,
            'min_dwell_time': Config.MIN_DWELL_TIME,
            'max_dwell_time': Config.MAX_DWELL_TIME,
            'bounce_rate_min': Config.BOUNCE_RATE_MIN,
            'bounce_rate_max': Config.BOUNCE_RATE_MAX,
            'page_depth_min': Config.PAGE_DEPTH_MIN,
            'page_depth_max': Config.PAGE_DEPTH_MAX,
            'use_proxy': Config.USE_PROXY,
            'headless': Config.HEADLESS,
            'schedule_enabled': Config.SCHEDULE_ENABLED,
            'schedule_interval': Config.SCHEDULE_INTERVAL,
            'schedule_visits_per_run': Config.SCHEDULE_VISITS_PER_RUN
        }
        return jsonify(config_data)
    except Exception as e:
        logger.error(f"Error getting config: {e}")
        return jsonify({'error': str(e)}), 500

# Socket.IO event handlers
@socketio.on('connect')
def handle_connect():
    logger.info('📡 Client connected')
    emit('connected', {'status': 'success'})

@socketio.on('disconnect')
def handle_disconnect():
    logger.info('📡 Client disconnected')

@socketio.on('request_stats')
def handle_stats_request():
    try:
        stats = db_manager.get_stats()
        gen_stats = generator.get_stats()
        stats.update({
            'running': gen_stats.get('running', False),
            'successful_visits': gen_stats.get('successful_visits', 0),
            'failed_visits': gen_stats.get('failed_visits', 0),
            'proxy_count': proxy_manager.get_count()
        })
        emit('stats_update', stats)
    except Exception as e:
        logger.error(f"Error sending stats update: {e}")