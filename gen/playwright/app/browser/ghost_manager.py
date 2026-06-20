import asyncio
import random
from playwright.async_api import async_playwright
from faker import Faker
import os
from config import Config

# Try different stealth imports
try:
    from playwright_stealth import Stealth
    STEALTH_AVAILABLE = True
except ImportError:
    STEALTH_AVAILABLE = False
    print("⚠️ playwright_stealth not available, using basic stealth")

fake = Faker()

class GhostManager:
    def __init__(self):
        self.playwright = None
        self.browser = None
        self.context = None
        self.proxy_config = None
        self.stealth = None
        
        if STEALTH_AVAILABLE:
            try:
                self.stealth = Stealth()
            except:
                self.stealth = None
    
    async def init(self, proxy_string=None):
        """Initialize browser with stealth and fingerprint randomization"""
        self.playwright = await async_playwright().start()
        
        # Prepare browser launch options
        launch_options = {
            'headless': Config.HEADLESS,
            'args': [
                '--no-sandbox',
                '--disable-setuid-sandbox',
                '--disable-dev-shm-usage',
                '--disable-accelerated-2d-canvas',
                '--disable-gpu',
                '--window-size=1920,1080'
            ]
        }
        
        # Add proxy if configured
        if proxy_string and Config.USE_PROXY:
            parsed = self._parse_proxy(proxy_string)
            if parsed:
                launch_options['proxy'] = parsed
                self.proxy_config = proxy_string
        
        # Launch browser
        self.browser = await self.playwright.chromium.launch(**launch_options)
        
        # Generate random fingerprint
        fingerprint = self._generate_fingerprint()
        
        # Create context with fingerprint
        context_options = {
            'viewport': fingerprint['viewport'],
            'user_agent': fingerprint['user_agent'],
            'locale': fingerprint['locale'],
            'timezone_id': fingerprint['timezone'],
            'permissions': ['geolocation'],
            'geolocation': fingerprint['geolocation']
        }
        
        self.context = await self.browser.new_context(**context_options)
        
        # Apply stealth if enabled
        if Config.USE_STEALTH:
            await self._apply_stealth()
        
        return self.context
    
    def _generate_fingerprint(self):
        """Generate realistic browser fingerprint"""
        user_agents = [
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/121.0',
            'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1 Safari/605.1.15',
            'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
        ]
        
        timezones = [
            'America/New_York', 'America/Los_Angeles', 'Europe/London',
            'Europe/Paris', 'Asia/Tokyo', 'Australia/Sydney',
            'America/Chicago', 'Europe/Berlin', 'Asia/Singapore'
        ]
        
        locales = ['en-US', 'en-GB', 'en-CA', 'en-AU', 'en-IN']
        
        # Generate realistic coordinates
        lat = random.uniform(-90, 90)
        lng = random.uniform(-180, 180)
        
        return {
            'user_agent': random.choice(user_agents),
            'timezone': random.choice(timezones),
            'locale': random.choice(locales),
            'viewport': {
                'width': random.randint(1024, 1920),
                'height': random.randint(768, 1080)
            },
            'geolocation': {
                'latitude': lat,
                'longitude': lng,
                'accuracy': random.randint(10, 100)
            }
        }
    
    async def _apply_stealth(self):
        """Apply stealth techniques"""
        # Try using playwright_stealth if available
        if STEALTH_AVAILABLE and self.stealth:
            try:
                await self.stealth.apply_stealth(self.context)
                print("✅ Applied playwright_stealth")
                return
            except Exception as e:
                print(f"⚠️ playwright_stealth failed: {e}")
        
        # Fallback to manual stealth
        await self._apply_manual_stealth()
    
    async def _apply_manual_stealth(self):
        """Apply manual stealth techniques"""
        await self.context.add_init_script("""
            // Remove webdriver
            Object.defineProperty(navigator, 'webdriver', {
                get: () => undefined
            });
            
            // Override navigator properties
            const originalQuery = window.navigator.permissions.query;
            window.navigator.permissions.query = (parameters) => (
                parameters.name === 'notifications' ?
                    Promise.resolve({ state: Notification.permission }) :
                    originalQuery(parameters)
            );
            
            // Override plugins
            Object.defineProperty(navigator, 'plugins', {
                get: () => {
                    return [
                        { name: 'Chrome PDF Plugin' },
                        { name: 'Chrome PDF Viewer' },
                        { name: 'Native Client' }
                    ];
                }
            });
            
            // Override languages
            Object.defineProperty(navigator, 'languages', {
                get: () => ['en-US', 'en']
            });
            
            // Override platform
            Object.defineProperty(navigator, 'platform', {
                get: () => 'Win32'
            });
            
            // Override hardware concurrency
            Object.defineProperty(navigator, 'hardwareConcurrency', {
                get: () => 8
            });
            
            // Override device memory
            Object.defineProperty(navigator, 'deviceMemory', {
                get: () => 8
            });
            
            // Canvas fingerprint protection
            const originalToDataURL = HTMLCanvasElement.prototype.toDataURL;
            HTMLCanvasElement.prototype.toDataURL = function(type) {
                if (type === 'image/png') {
                    const context = this.getContext('2d');
                    const imageData = context.getImageData(0, 0, this.width, this.height);
                    const data = imageData.data;
                    // Add random noise
                    for (let i = 0; i < data.length; i += 4) {
                        if (Math.random() < 0.01) {
                            data[i] = data[i] ^ Math.floor(Math.random() * 10);
                        }
                    }
                    context.putImageData(imageData, 0, 0);
                }
                return originalToDataURL.apply(this, arguments);
            };
            
            // WebGL fingerprint protection
            const originalGetParameter = WebGLRenderingContext.prototype.getParameter;
            WebGLRenderingContext.prototype.getParameter = function(parameter) {
                if (parameter === 37445) { // UNMASKED_VENDOR_WEBGL
                    return 'Intel Inc.';
                }
                if (parameter === 37446) { // UNMASKED_RENDERER_WEBGL
                    return 'Intel Iris OpenGL Engine';
                }
                return originalGetParameter.apply(this, arguments);
            };
        """)
        print("✅ Applied manual stealth")
    
    def _parse_proxy(self, proxy_string):
        """Parse proxy string into playwright format"""
        try:
            # Format: http://user:pass@host:port or http://host:port
            if '://' not in proxy_string:
                proxy_string = f'http://{proxy_string}'
            
            parts = proxy_string.split('@')
            if len(parts) == 2:
                auth, server = parts
                auth_parts = auth.split('://')[1].split(':')
                return {
                    'server': f"{auth.split('://')[0]}://{server}",
                    'username': auth_parts[0],
                    'password': auth_parts[1]
                }
            else:
                return {'server': proxy_string}
        except:
            return None
    
    async def create_page(self):
        """Create a new page with stealth"""
        page = await self.context.new_page()
        return page
    
    async def close(self):
        """Clean up browser resources"""
        if self.browser:
            await self.browser.close()
        if self.playwright:
            await self.playwright.stop()