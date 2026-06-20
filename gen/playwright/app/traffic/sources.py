import random
import asyncio
from faker import Faker
from config import Config

fake = Faker()

class TrafficSources:
    def __init__(self):
        self.sources = ['direct', 'organic', 'referral', 'social']
        
        self.search_engines = {
            'google': 'https://www.google.com/search?q=',
            'bing': 'https://www.bing.com/search?q=',
            'duckduckgo': 'https://duckduckgo.com/?q=',
            'yahoo': 'https://search.yahoo.com/search?p='
        }
        
        self.referral_domains = [
            'https://news.ycombinator.com',
            'https://www.reddit.com',
            'https://www.quora.com',
            'https://medium.com',
            'https://dev.to',
            'https://stackoverflow.com',
            'https://github.com',
            'https://www.producthunt.com'
        ]
        
        self.social_platforms = [
            'https://www.facebook.com',
            'https://www.instagram.com',
            'https://twitter.com',
            'https://www.tiktok.com',
            'https://www.linkedin.com',
            'https://www.youtube.com',
            'https://www.pinterest.com',
            'https://www.tumblr.com'
        ]
    
    def get_random_source(self):
        """Get random traffic source with weights"""
        weights = {
            'direct': 30,
            'organic': 40,
            'referral': 15,
            'social': 15
        }
        
        rand = random.random() * 100
        cumulative = 0
        
        for source, weight in weights.items():
            cumulative += weight
            if rand <= cumulative:
                return source
        
        return 'direct'
    
    def generate_traffic_context(self, target_url=None):
        """Generate complete traffic context"""
        if target_url is None:
            target_url = Config.TARGET_URL
        
        source = self.get_random_source()
        context = {
            'source': source,
            'referrer': None,
            'keyword': None,
            'landing_page': target_url
        }
        
        if source == 'organic':
            # Organic search
            search_engine = random.choice(list(self.search_engines.keys()))
            keyword = fake.words(nb=random.randint(1, 4))
            keyword_str = ' '.join(keyword)
            
            context['keyword'] = keyword_str
            context['referrer'] = f"{self.search_engines[search_engine]}{keyword_str.replace(' ', '+')}"
            
        elif source == 'referral':
            # Referral traffic
            context['referrer'] = random.choice(self.referral_domains)
            
        elif source == 'social':
            # Social media traffic
            context['referrer'] = random.choice(self.social_platforms)
            
        elif source == 'direct':
            # Direct traffic - no referrer
            context['referrer'] = None
        
        return context
    
    async def simulate_search(self, page, keyword, target_url=None):
        """Simulate organic search and click through to target"""
        if target_url is None:
            target_url = Config.TARGET_URL
        
        search_engine = random.choice(list(self.search_engines.keys()))
        search_url = f"{self.search_engines[search_engine]}{keyword.replace(' ', '+')}"
        
        print(f"🔍 Searching {search_engine} for: '{keyword}'")
        
        # Go to search engine
        await page.goto(search_url, wait_until='networkidle')
        await self.random_pause(1000, 3000)
        
        # Wait for results
        try:
            await page.wait_for_selector('a[href]', timeout=10000)
            await self.random_pause(1000, 2000)
        except:
            pass
        
        # Click random result
        links = await page.evaluate("""
            () => {
                const links = Array.from(document.querySelectorAll('a[href]'));
                return links
                    .map(el => el.href)
                    .filter(href => href && href.startsWith('http') && !href.includes('google.com'));
            }
        """)
        
        if links:
            # Filter to find target URL if possible
            target_links = [link for link in links if target_url in link]
            if target_links:
                selected_link = random.choice(target_links)
            else:
                selected_link = random.choice(links[:10])  # Top 10 results
            
            print(f"📄 Clicking search result: {selected_link}")
            await page.goto(selected_link, wait_until='networkidle')
            await self.random_pause(2000, 4000)
            
            return selected_link
        
        # If no links found, go directly to target
        print(f"🌐 No search results found, going to target: {target_url}")
        await page.goto(target_url, wait_until='networkidle')
        return target_url
    
    @staticmethod
    async def random_pause(min_ms, max_ms):
        duration = random.randint(min_ms, max_ms)
        await asyncio.sleep(duration / 1000)