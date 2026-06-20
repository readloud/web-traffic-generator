import requests
import random
import time
import sqlite3
from datetime import datetime
from bs4 import BeautifulSoup
from fake_useragent import UserAgent
import threading
import queue

class BacklinkAutomation:
    def __init__(self, db_path='traffic.db'):
        self.db_path = db_path
        self.ua = UserAgent()
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': self.ua.random
        })
        
    def connect_db(self):
        """Connect to SQLite database"""
        return sqlite3.connect(self.db_path)
    
    def create_backlink(self, target_url, platform='auto'):
        """
        Create backlink on various platforms
        
        Platforms: blogger, wordpress, medium, github, tumblr
        """
        platforms = {
            'blogger': self.create_blogger_backlink,
            'wordpress': self.create_wordpress_backlink,
            'medium': self.create_medium_backlink,
            'github': self.create_github_backlink,
            'tumblr': self.create_tumblr_backlink
        }
        
        if platform == 'auto':
            platform = random.choice(list(platforms.keys()))
        
        if platform in platforms:
            try:
                result = platforms[platform](target_url)
                self.save_backlink(result)
                return result
            except Exception as e:
                print(f"Error creating backlink on {platform}: {str(e)}")
                return None
    
    def create_blogger_backlink(self, target_url):
        """Simulate Blogger backlink creation"""
        # Note: Ini hanya simulasi. Untuk implementasi real, 
        # perlu menggunakan Blogger API dengan OAuth
        blog_url = f"https://{random.randint(100000, 999999)}.blogspot.com"
        post_id = random.randint(1000000, 9999999)
        
        backlink_code = f'''
        <div class="blog-post">
            <h2>Interesting Article About Technology</h2>
            <p>Read more about this topic at: 
            <a href="{target_url}" rel="dofollow" title="Visit Website">Click Here</a></p>
            <p>Published on: {datetime.now().strftime('%B %d, %Y')}</p>
        </div>
        '''
        
        return {
            'url': f"{blog_url}/p/{post_id}.html",
            'backlink_code': backlink_code,
            'platform': 'blogger',
            'da_score': random.randint(20, 50)
        }
    
    def create_medium_backlink(self, target_url):
        """Simulate Medium story creation"""
        username = f"user{random.randint(1000, 9999)}"
        story_id = random.randint(1000000, 9999999)
        
        backlink_code = f'''
        ## Interesting Read
        
        I recently came across this fascinating resource that I think you'll find valuable.
        
        You can check it out here: [{target_url}]({target_url})
        
        *Posted via automated content system*
        '''
        
        return {
            'url': f"https://medium.com/@{username}/{story_id}",
            'backlink_code': backlink_code,
            'platform': 'medium',
            'da_score': random.randint(40, 70)
        }
    
    def create_github_backlink(self, target_url):
        """Create GitHub gist backlink"""
        gist_id = ''.join(random.choices('abcdef0123456789', k=32))
        
        backlink_code = f'''
        # Resource Collection
        
        ## Useful Links
        - Main Resource: {target_url}
        - Documentation: {target_url}/docs
        - Examples: {target_url}/examples
        
        ```python
        # Example code
        def track_visitor():
            print("Tracking visitor...")
        ```
        '''
        
        return {
            'url': f"https://gist.github.com/anonymous/{gist_id}",
            'backlink_code': backlink_code,
            'platform': 'github',
            'da_score': random.randint(70, 95)
        }
    
    def save_backlink(self, backlink_data):
        """Save backlink to database"""
        conn = self.connect_db()
        cursor = conn.cursor()
        
        cursor.execute('''
        INSERT INTO backlink (url, backlink_code, platform, da_score, status, created_at)
        VALUES (?, ?, ?, ?, ?, ?)
        ''', (
            backlink_data['url'],
            backlink_data['backlink_code'],
            backlink_data['platform'],
            backlink_data.get('da_score', 0),
            'active',
            datetime.now()
        ))
        
        conn.commit()
        conn.close()
        
        print(f"Backlink saved: {backlink_data['url']}")
    
    def bulk_create_backlinks(self, target_urls, count_per_url=3):
        """Create multiple backlinks for multiple URLs"""
        results = []
        
        for target_url in target_urls:
            for _ in range(count_per_url):
                backlink = self.create_backlink(target_url)
                if backlink:
                    results.append(backlink)
                time.sleep(1)  # Delay untuk menghindari rate limiting
        
        return results
    
    def check_backlink_status(self, backlink_id=None):
        """Check if backlink is still active"""
        conn = self.connect_db()
        cursor = conn.cursor()
        
        if backlink_id:
            cursor.execute('SELECT id, url FROM backlink WHERE id = ?', (backlink_id,))
        else:
            cursor.execute('SELECT id, url FROM backlink WHERE status = "active"')
        
        backlinks = cursor.fetchall()
        results = []
        
        for backlink in backlinks:
            try:
                response = self.session.get(backlink[1], timeout=10)
                status = 'active' if response.status_code == 200 else 'broken'
                
                cursor.execute(
                    'UPDATE backlink SET status = ?, last_checked = ? WHERE id = ?',
                    (status, datetime.now(), backlink[0])
                )
                
                results.append({
                    'id': backlink[0],
                    'url': backlink[1],
                    'status': status,
                    'http_code': response.status_code
                })
                
                print(f"Checked {backlink[1]}: {status}")
                
            except requests.RequestException:
                cursor.execute(
                    'UPDATE backlink SET status = "broken", last_checked = ? WHERE id = ?',
                    (datetime.now(), backlink[0])
                )
                results.append({
                    'id': backlink[0],
                    'url': backlink[1],
                    'status': 'broken',
                    'http_code': 0
                })
            
            time.sleep(0.5)  # Delay antar request
        
        conn.commit()
        conn.close()
        return results
    
    def run_automation_schedule(self, interval_hours=24):
        """Run automation on schedule"""
        import schedule
        
        def automation_job():
            print(f"Running automation job at {datetime.now()}")
            
            # Check existing backlinks
            self.check_backlink_status()
            
            # Create new backlinks
            conn = self.connect_db()
            cursor = conn.cursor()
            cursor.execute('SELECT DISTINCT page_url FROM visitor LIMIT 5')
            urls = [row[0] for row in cursor.fetchall()]
            conn.close()
            
            for url in urls:
                if url and url.startswith('http'):
                    self.create_backlink(url)
                    time.sleep(2)
        
        # Schedule jobs
        schedule.every(interval_hours).hours.do(automation_job)
        schedule.every().day.at("02:00").do(automation_job)
        
        print(f"Backlink automation scheduler started. Interval: {interval_hours} hours")
        
        # Run scheduler
        while True:
            schedule.run_pending()
            time.sleep(60)

# CLI Interface
if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description='Backlink Automation Tool')
    parser.add_argument('--create', help='Create backlink for URL')
    parser.add_argument('--check', action='store_true', help='Check all backlinks')
    parser.add_argument('--schedule', action='store_true', help='Run scheduled automation')
    parser.add_argument('--bulk', help='Create bulk backlinks (comma-separated URLs)')
    parser.add_argument('--count', type=int, default=3, help='Number of backlinks per URL')
    
    args = parser.parse_args()
    
    automation = BacklinkAutomation()
    
    if args.create:
        result = automation.create_backlink(args.create)
        print(f"Created backlink: {result}")
    
    elif args.check:
        results = automation.check_backlink_status()
        print(f"Checked {len(results)} backlinks")
    
    elif args.bulk:
        urls = args.bulk.split(',')
        results = automation.bulk_create_backlinks(urls, args.count)
        print(f"Created {len(results)} backlinks")
    
    elif args.schedule:
        automation.run_automation_schedule()
    
    else:
        print("Please specify an action. Use --help for options.")
