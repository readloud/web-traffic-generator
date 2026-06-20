import asyncio
import random
import math
from config import Config

class BehaviorSimulator:
    def __init__(self, page):
        self.page = page
    
    async def simulate_human_behavior(self, duration=None):
        """Simulate realistic human behavior on a page"""
        # Random scroll
        await self.simulate_scrolling()
        
        # Random mouse movements
        await self.simulate_mouse_movement()
        
        # Random pauses
        await self.random_pause(1000, 3000)
        
        # Dwell on page
        if duration is None:
            duration = random.randint(Config.MIN_DWELL_TIME, Config.MAX_DWELL_TIME)
        await self.dwell(duration)
        
        return duration
    
    async def simulate_scrolling(self):
        """Simulate realistic scrolling behavior"""
        scroll_count = random.randint(2, 6)
        
        for _ in range(scroll_count):
            # Get page dimensions
            viewport_height = await self.page.evaluate('window.innerHeight')
            page_height = await self.page.evaluate('document.documentElement.scrollHeight')
            
            # Random scroll position
            scroll_position = random.uniform(0, 1) * (page_height - viewport_height)
            
            # Smooth scroll with variable speed
            steps = random.randint(10, 30)
            current_position = await self.page.evaluate('window.pageYOffset')
            delta = (scroll_position - current_position) / steps
            
            for step in range(steps):
                position = current_position + (delta * (step + 1))
                await self.page.evaluate(f'window.scrollTo(0, {position})')
                await asyncio.sleep(random.uniform(0.01, 0.05))
            
            # Random pause between scrolls
            await self.random_pause(500, 2000)
    
    async def simulate_mouse_movement(self):
        """Simulate realistic mouse movements using bezier curves"""
        for _ in range(random.randint(2, 4)):
            # Get random coordinates
            x1 = random.randint(100, 800)
            y1 = random.randint(100, 600)
            x2 = x1 + random.randint(-200, 200)
            y2 = y1 + random.randint(-200, 200)
            
            # Move mouse with bezier curve
            await self._bezier_move(x1, y1, x2, y2)
            
            # Random click (30% chance)
            if random.random() > 0.7:
                await self.page.mouse.click(x2, y2)
                await self.random_pause(500, 1500)
            
            await self.random_pause(1000, 3000)
    
    async def _bezier_move(self, x1, y1, x2, y2):
        """Move mouse using bezier curve for natural movement"""
        steps = random.randint(15, 30)
        
        for i in range(steps):
            t = i / steps
            
            # Cubic bezier with random control points
            cx = x1 + (x2 - x1) * t + random.randint(-50, 50) * math.sin(t * math.pi)
            cy = y1 + (y2 - y1) * t + random.randint(-50, 50) * math.sin(t * math.pi)
            
            await self.page.mouse.move(cx, cy)
            await asyncio.sleep(random.uniform(0.01, 0.03))
    
    async def dwell(self, duration_seconds):
        """Dwell on page for specified duration"""
        print(f"⏱️ Dwelling for {duration_seconds} seconds")
        
        # Simulate activity during dwell
        activity_count = random.randint(1, 3)
        for _ in range(activity_count):
            # Random scroll or mouse movement
            if random.random() > 0.5:
                await self.simulate_scrolling()
            else:
                await self.simulate_mouse_movement()
            
            # Wait a bit
            wait_time = min(duration_seconds / activity_count, 30)
            await asyncio.sleep(wait_time)
    
    async def click_random_links(self, max_clicks=None):
        """Click random internal links on the page"""
        if max_clicks is None:
            max_clicks = random.randint(Config.PAGE_DEPTH_MIN, Config.PAGE_DEPTH_MAX)
        
        # Get all internal links
        links = await self.page.evaluate("""
            () => {
                const origin = window.location.origin;
                return Array.from(document.querySelectorAll('a[href]'))
                    .map(el => el.href)
                    .filter(href => 
                        href.startsWith(origin) &&
                        !href.includes('#') &&
                        !href.includes('mailto:') &&
                        !href.includes('tel:') &&
                        href !== window.location.href
                    );
            }
        """)
        
        if not links:
            return []
        
        # Select random links to click
        max_links = min(max_clicks, len(links))
        selected_links = random.sample(links, max_links)
        
        clicked_links = []
        for link in selected_links:
            try:
                print(f"🔗 Clicking internal link: {link}")
                await self.page.goto(link, wait_until='networkidle')
                clicked_links.append(link)
                
                # Simulate behavior on subpage
                await self.simulate_scrolling()
                await self.random_pause(500, 2000)
                
                # Short dwell on subpage
                await self.dwell(random.randint(15, 60))
                
            except Exception as e:
                print(f"Error clicking link: {e}")
                continue
        
        return clicked_links
    
    async def random_pause(self, min_ms, max_ms):
        """Random pause to simulate human thinking"""
        duration = random.randint(min_ms, max_ms)
        await asyncio.sleep(duration / 1000)
    
    async def get_scroll_depth(self):
        """Get current scroll depth percentage"""
        depth = await self.page.evaluate("""
            () => {
                const scrollTop = window.scrollY;
                const docHeight = document.documentElement.scrollHeight - window.innerHeight;
                return docHeight > 0 ? Math.round((scrollTop / docHeight) * 100) : 0;
            }
        """)
        return depth
    
    async def get_page_info(self):
        """Get current page information"""
        info = await self.page.evaluate("""
            () => ({
                title: document.title,
                url: window.location.href,
                pathname: window.location.pathname
            })
        """)
        return info
    
    async def type_with_delay(self, selector, text):
        """Type text with human-like delays"""
        for char in text:
            await self.page.type(selector, char)
            await asyncio.sleep(random.uniform(0.05, 0.2))