from flask import Flask, render_template, request, jsonify, session, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime, timedelta
import json
import os
from user_agents import parse
import geoip2.database
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)
app.secret_key = os.urandom(24)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///traffic.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# Model Database
class Visitor(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    ip_address = db.Column(db.String(45))
    user_agent = db.Column(db.Text)
    referrer = db.Column(db.Text)
    page_url = db.Column(db.Text)
    visit_date = db.Column(db.DateTime, default=datetime.utcnow)
    country = db.Column(db.String(100))
    city = db.Column(db.String(100))
    browser = db.Column(db.String(100))
    os = db.Column(db.String(100))
    device = db.Column(db.String(50))

class Backlink(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    url = db.Column(db.String(500))
    backlink_code = db.Column(db.Text)
    traffic_count = db.Column(db.Integer, default=0)
    status = db.Column(db.String(20), default='active')
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    last_checked = db.Column(db.DateTime)
    platform = db.Column(db.String(50))
    da_score = db.Column(db.Integer)  # Domain Authority

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True)
    password_hash = db.Column(db.String(120))

# GeoIP Reader
try:
    geoip_reader = geoip2.database.Reader('GeoLite2-City.mmdb')
except:
    geoip_reader = None

@app.route('/')
def index():
    return redirect(url_for('login'))

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        
        user = User.query.filter_by(username=username).first()
        
        if user and check_password_hash(user.password_hash, password):
            session['user_id'] = user.id
            return redirect(url_for('dashboard'))
    
    return render_template('login.html')

@app.route('/dashboard')   
def dashboard():
    if 'user_id' not in session:
        return redirect(url_for('login'))
    
    # Statistik
    total_visitors = Visitor.query.count()
    today = datetime.utcnow().date()
    today_visitors = Visitor.query.filter(db.func.date(Visitor.visit_date) == today).count()
    
    # Visitor unik berdasarkan IP
    unique_visitors = db.session.query(db.func.count(db.func.distinct(Visitor.ip_address))).scalar()
    
    # Data untuk chart 7 hari terakhir
    last_7_days = []
    daily_counts = []
    
    for i in range(6, -1, -1):
        day = today - timedelta(days=i)
        count = Visitor.query.filter(db.func.date(Visitor.visit_date) == day).count()
        last_7_days.append(day.strftime('%Y-%m-%d'))
        daily_counts.append(count)
    
    # Top pages
    top_pages = db.session.query(
        Visitor.page_url,
        db.func.count(Visitor.id).label('count')
    ).group_by(Visitor.page_url).order_by(db.desc('count')).limit(10).all()
    
    # Recent backlinks
    recent_backlinks = Backlink.query.order_by(Backlink.created_at.desc()).limit(10).all()
    
    return render_template('dashboard.html',
                         total_visitors=total_visitors,
                         today_visitors=today_visitors,
                         unique_visitors=unique_visitors,
                         last_7_days=json.dumps(last_7_days),
                         daily_counts=json.dumps(daily_counts),
                         top_pages=top_pages,
                         backlinks=recent_backlinks)

@app.route('/api/track', methods=['GET', 'POST'])
def track_visitor():
    """API endpoint untuk tracking visitor"""
    try:
        # Dapatkan data visitor
        ip_address = request.headers.get('X-Forwarded-For', request.remote_addr).split(',')[0]
        user_agent = request.headers.get('User-Agent', '')
        referrer = request.headers.get('Referer', 'Direct')
        page_url = request.args.get('url', request.host_url)
        
        # Parse user agent
        ua = parse(user_agent)
        
        # Get location from IP
        country = "Unknown"
        city = "Unknown"
        
        if geoip_reader and ip_address != '127.0.0.1':
            try:
                response = geoip_reader.city(ip_address)
                country = response.country.name
                city = response.city.name
            except:
                pass
        
        # Simpan visitor ke database
        visitor = Visitor(
            ip_address=ip_address,
            user_agent=user_agent,
            referrer=referrer,
            page_url=page_url,
            country=country,
            city=city,
            browser=ua.browser.family,
            os=ua.os.family,
            device='Mobile' if ua.is_mobile else 'Desktop' if ua.is_pc else 'Tablet'
        )
        
        db.session.add(visitor)
        db.session.commit()
        
        # Auto generate backlink (30% probability)
        import random
        if random.random() < 0.3:
            generate_auto_backlink(page_url)
        
        return jsonify({'status': 'success', 'visitor_id': visitor.id})
    
    except Exception as e:
        return jsonify({'status': 'error', 'message': str(e)})

@app.route('/api/backlinks/generate', methods=['POST'])
def generate_backlink():
    """Generate backlink secara manual"""
    if 'user_id' not in session:
        return jsonify({'error': 'Unauthorized'}), 401
    
    target_url = request.json.get('url')
    count = request.json.get('count', 3)
    
    generated = []
    for _ in range(count):
        backlink = create_auto_backlink(target_url)
        if backlink:
            generated.append(backlink)
    
    return jsonify({'status': 'success', 'generated': generated})

def generate_auto_backlink(target_url):
    """Fungsi untuk generate backlink otomatis"""
    from faker import Faker
    import random
    
    fake = Faker()
    
    platforms = [
        {
            'name': 'blogger',
            'url_template': 'https://{}.blogspot.com/p/{}.html',
            'da': random.randint(20, 60)
        },
        {
            'name': 'medium',
            'url_template': 'https://medium.com/@{}/{}',
            'da': random.randint(40, 70)
        },
        {
            'name': 'github',
            'url_template': 'https://gist.github.com/{}/{}',
            'da': random.randint(70, 90)
        },
        {
            'name': 'wordpress',
            'url_template': 'https://{}.wordpress.com/{}',
            'da': random.randint(30, 60)
        }
    ]
    
    platform = random.choice(platforms)
    username = fake.user_name().lower().replace(' ', '')
    slug = fake.slug()
    
    backlink_url = platform['url_template'].format(username, slug)
    backlink_code = f'<a href="{target_url}" rel="dofollow" title="{fake.sentence()}">Read More</a>'
    
    # Simpan ke database
    backlink = Backlink(
        url=backlink_url,
        backlink_code=backlink_code,
        platform=platform['name'],
        da_score=platform['da'],
        status='active'
    )
    
    db.session.add(backlink)
    db.session.commit()
    
    return backlink_url

def create_auto_backlink(target_url):
    """Versi lain untuk create backlink"""
    import hashlib
    import time
    
    # Generate unique identifier
    unique_id = hashlib.md5(f"{target_url}{time.time()}".encode()).hexdigest()[:8]
    
    platforms = [
        'blogger.com',
        'wordpress.com',
        'medium.com',
        'github.io',
        'tumblr.com',
        'weebly.com',
        'wixsite.com'
    ]
    
    selected_platform = random.choice(platforms)
    backlink_url = f"https://{unique_id}.{selected_platform}/post/{int(time.time())}"
    
    backlink = Backlink(
        url=backlink_url,
        backlink_code=f'<!-- Backlink for {target_url} -->\n<a href="{target_url}">Visit Site</a>',
        platform=selected_platform,
        status='pending'
    )
    
    db.session.add(backlink)
    db.session.commit()
    
    return backlink_url

@app.route('/api/analytics')
def get_analytics():
    """API untuk data analytics"""
    if 'user_id' not in session:
        return jsonify({'error': 'Unauthorized'}), 401
    
    # Data untuk chart
    today = datetime.utcnow()
    
    # Last 30 days data
    dates = []
    counts = []
    
    for i in range(29, -1, -1):
        day = today - timedelta(days=i)
        count = Visitor.query.filter(db.func.date(Visitor.visit_date) == day.date()).count()
        dates.append(day.strftime('%m/%d'))
        counts.append(count)
    
    # Top referrers
    top_referrers = db.session.query(
        Visitor.referrer,
        db.func.count(Visitor.id).label('count')
    ).group_by(Visitor.referrer).order_by(db.desc('count')).limit(10).all()
    
    # Browser statistics
    browser_stats = db.session.query(
        Visitor.browser,
        db.func.count(Visitor.id).label('count')
    ).group_by(Visitor.browser).order_by(db.desc('count')).limit(5).all()
    
    return jsonify({
        'dates': dates,
        'counts': counts,
        'top_referrers': [{'name': r[0], 'count': r[1]} for r in top_referrers],
        'browsers': [{'name': b[0], 'count': b[1]} for b in browser_stats]
    })

@app.route('/api/backlinks')
def get_backlinks():
    """API untuk mendapatkan list backlink"""
    if 'user_id' not in session:
        return jsonify({'error': 'Unauthorized'}), 401
    
    page = request.args.get('page', 1, type=int)
    per_page = 20
    
    backlinks = Backlink.query.order_by(Backlink.created_at.desc()).paginate(
        page=page, per_page=per_page, error_out=False)
    
    result = {
        'backlinks': [{
            'id': b.id,
            'url': b.url,
            'traffic_count': b.traffic_count,
            'status': b.status,
            'platform': b.platform,
            'da_score': b.da_score,
            'created_at': b.created_at.strftime('%Y-%m-%d %H:%M')
        } for b in backlinks.items],
        'total': backlinks.total,
        'pages': backlinks.pages,
        'current_page': backlinks.page
    }
    
    return jsonify(result)

@app.route('/backlink-checker', methods=['POST'])
def check_backlinks():
    """Check status backlink secara batch"""
    if 'user_id' not in session:
        return jsonify({'error': 'Unauthorized'}), 401
    
    import requests
    from bs4 import BeautifulSoup
    import concurrent.futures
    
    backlink_ids = request.json.get('ids', [])
    results = []
    
    def check_single_backlink(backlink_id):
        backlink = Backlink.query.get(backlink_id)
        if not backlink:
            return None
        
        try:
            response = requests.get(backlink.url, timeout=10)
            soup = BeautifulSoup(response.text, 'html.parser')
            
            # Cek apakah backlink code ada di halaman
            found = backlink.backlink_code in response.text
            
            backlink.last_checked = datetime.utcnow()
            backlink.status = 'active' if found else 'broken'
            db.session.commit()
            
            return {
                'id': backlink.id,
                'url': backlink.url,
                'status': backlink.status,
                'http_status': response.status_code
            }
        except:
            backlink.status = 'broken'
            backlink.last_checked = datetime.utcnow()
            db.session.commit()
            
            return {
                'id': backlink.id,
                'url': backlink.url,
                'status': 'broken',
                'http_status': 0
            }
    
    # Gunakan thread pool untuk check parallel
    with concurrent.futures.ThreadPoolExecutor(max_workers=5) as executor:
        futures = [executor.submit(check_single_backlink, bid) for bid in backlink_ids]
        for future in concurrent.futures.as_completed(futures):
            result = future.result()
            if result:
                results.append(result)
    
    return jsonify({'results': results})

def init_db():
    """Inisialisasi database"""
    db.create_all()
    
    # Buat user admin default jika belum ada
    if not User.query.filter_by(username='admin').first():
        admin = User(
            username='admin',
            password_hash=generate_password_hash('admin123')
        )
        db.session.add(admin)
        db.session.commit()

@app.route('/logout')
def logout():
    session.pop('user_id', None)
    return redirect(url_for('login'))
    
if __name__ == '__main__':
    with app.app_context():
        init_db()
    app.run(debug=True, port=5000)
