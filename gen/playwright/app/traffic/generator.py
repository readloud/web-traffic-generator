import asyncio
import random
import uuid
from datetime import datetime
from config import Config
from app.browser import GhostManager, BehaviorSimulator
from app.traffic.sources import TrafficSources
from app.proxy import ProxyManager
from app.database import db_manager
import logging

logger = logging.getLogger(__name__)

class TrafficGenerator:
    def __init__(self):
        self.ghost_manager = None
        self.is_running = False
        self.stats = {
            'total_visits': 0,
            'successful_visits': 0,
            'failed_visits': 0
        }
        self.traffic_sources = TrafficSources()
        self.proxy_manager = ProxyManager()
    
    async def generate_single_visit(self):
        """Generate a single realistic visit"""
        session_id = str(uuid.uuid4())
        page = None
        context = None
        
        try:
            # Initialize browser
            self.ghost_manager = GhostManager()
            
            # Get proxy if enabled
            proxy_string = None
            if Config.USE_PROXY:
                proxy_string = self.proxy_manager.get_random_proxy()
                if proxy_string:
                    logger.info(f"🌐 Using proxy: {proxy_string}")
            
            # Initialize browser with proxy
            context = await self.ghost_manager.init(proxy_string)
            page = await self.ghost_manager.create_page()
            
            # Generate traffic context
            traffic_context = self.traffic_sources.generate_traffic_context()
            
            logger.info(f"🔄 Visit {self.stats['total_visits'] + 1}")
            logger.info(f"📊 Source: {traffic_context['source']}")
            if traffic_context.get('keyword'):
                logger.info(f"🔑 Keyword: {traffic_context['keyword']}")
            if traffic_context.get('referrer'):
                logger.info(f"🔗 Referrer: {traffic_context['referrer']}")
            
            # Navigate based on traffic source
            if traffic_context['source'] == 'organic' and traffic_context.get('keyword'):
                # Simulate organic search
                await self.traffic_sources.simulate_search(
                    page,
                    traffic_context['keyword'],
                    Config.TARGET_URL
                )
            else:
                # Direct navigation
                await page.goto(Config.TARGET_URL, wait_until='networkidle')
            
            # Get page info
            behavior = BehaviorSimulator(page)
            page_info = await behavior.get_page_info()
            logger.info(f"📄 Page: {page_info['title']}")
            
            # Simulate human behavior
            initial_dwell = await behavior.simulate_human_behavior()
            
            # Click internal links (page depth)
            clicked_links = await behavior.click_random_links()
            page_depth = len(clicked_links) + 1
            
            # Check bounce rate
            bounce_rate = random.randint(
                Config.BOUNCE_RATE_MIN,
                Config.BOUNCE_RATE_MAX
            )
            is_bounce = random.random() * 100 <= bounce_rate
            
            # Get scroll depth
            scroll_depth = await behavior.get_scroll_depth()
            
            # Get final URL
            final_url = await page.evaluate('window.location.href')
            
            # Get IP address
            ip_address = await self._get_ip_address(page)
            
            # Get user agent
            user_agent = await page.evaluate('navigator.userAgent')
            
            # Calculate total duration
            total_duration = initial_dwell + (len(clicked_links) * 30)
            
            # Prepare visit data
            visit_data = {
                'session_id': session_id,
                'ip_address': ip_address or '127.0.0.1',
                'user_agent': user_agent,
                'referrer': traffic_context.get('referrer', 'direct'),
                'landing_page': Config.TARGET_URL,
                'pages_visited': page_depth,
                'total_duration': total_duration,
                'is_bounce': is_bounce or page_depth == 1,
                'traffic_source': traffic_context['source'],
                'keyword': traffic_context.get('keyword'),
                'proxy_used': 'yes' if proxy_string else 'no'
            }
            
            # Log to database
            visit_id = db_manager.log_visit(visit_data)
            
            # Log page views
            db_manager.log_page_view({
                'session_id': session_id,
                'url': final_url,
                'time_on_page': initial_dwell,
                'scroll_depth': scroll_depth,
                'click_count': len(clicked_links)
            })
            
            # Update stats
            self.stats['total_visits'] += 1
            self.stats['successful_visits'] += 1
            
            logger.info(f"✅ Visit complete! Session: {session_id[:8]}")
            logger.info(f"📊 Bounce: {'Yes' if is_bounce else 'No'}, Pages: {page_depth}")
            logger.info(f"⏱️  Duration: {total_duration}s, Scroll: {scroll_depth}%")
            
            return {
                'success': True,
                'session_id': session_id,
                'data': visit_data
            }
            
        except Exception as e:
            logger.error(f"❌ Error generating visit: {str(e)}")
            self.stats['failed_visits'] += 1
            return {
                'success': False,
                'error': str(e)
            }
        
        finally:
            # Cleanup
            if page:
                await page.close()
            if context:
                await context.close()
            if self.ghost_manager:
                await self.ghost_manager.close()
    
    async def _get_ip_address(self, page):
        """Get IP address from page"""
        try:
            ip = await page.evaluate("""
                async () => {
                    try {
                        const response = await fetch('https://api.ipify.org?format=json');
                        const data = await response.json();
                        return data.ip;
                    } catch {
                        return null;
                    }
                }
            """)
            return ip
        except:
            return None
    
    async def generate_burst(self, visits=10):
        """Generate a burst of visits"""
        if self.is_running:
            logger.warning("⚠️ Generator already running")
            return
        
        self.is_running = True
        logger.info(f"🚀 Starting burst of {visits} visits...")
        
        try:
            for i in range(visits):
                await self.generate_single_visit()
                
                # Random delay between visits
                if i < visits - 1:
                    delay = random.uniform(2, 10)
                    logger.info(f"⏳ Waiting {delay:.1f}s before next visit...")
                    await asyncio.sleep(delay)
        
        except Exception as e:
            logger.error(f"Error during burst: {e}")
        
        finally:
            self.is_running = False
            logger.info(f"✅ Burst complete! Successful: {self.stats['successful_visits']}, Failed: {self.stats['failed_visits']}")
    
    async def generate_continuous(self, visits_per_hour=10, duration_minutes=60):
        """Generate continuous traffic over a period"""
        logger.info(f"🔄 Continuous generation: {visits_per_hour}/hour for {duration_minutes}min")
        
        start_time = datetime.utcnow()
        end_time = start_time.timestamp() + (duration_minutes * 60)
        visit_count = 0
        
        while datetime.utcnow().timestamp() < end_time:
            await self.generate_single_visit()
            visit_count += 1
            
            # Calculate delay to achieve desired visits per hour
            elapsed_minutes = (datetime.utcnow() - start_time).total_seconds() / 60
            target_visits = (elapsed_minutes / 60) * visits_per_hour
            
            if visit_count < target_visits:
                wait_time = (60 / visits_per_hour) * (target_visits - visit_count)
                await asyncio.sleep(min(wait_time, 10))
        
        logger.info(f"✅ Continuous generation complete. Generated {visit_count} visits")
    
    def get_stats(self):
        """Get generator statistics"""
        return {
            **self.stats,
            'running': self.is_running
        }
    
    async def stop(self):
        """Stop the generator"""
        self.is_running = False
        if self.ghost_manager:
            await self.ghost_manager.close()
        logger.info("🛑 Generator stopped")