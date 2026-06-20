import os
import random
from config import Config

class ProxyManager:
    def __init__(self):
        self.proxies = []
        self.current_index = 0
        self.load_proxies()
    
    def load_proxies(self):
        """Load proxies from file"""
        try:
            if os.path.exists(Config.PROXY_FILE):
                with open(Config.PROXY_FILE, 'r') as f:
                    content = f.read()
                    self.proxies = [
                        line.strip() 
                        for line in content.split('\n')
                        if line.strip() and not line.startswith('#')
                    ]
                print(f"✅ Loaded {len(self.proxies)} proxies")
            else:
                print("⚠️ No proxy file found, using direct connection")
                self.proxies = []
        except Exception as e:
            print(f"Error loading proxies: {e}")
            self.proxies = []
    
    def get_next_proxy(self):
        """Get next proxy in rotation"""
        if not Config.USE_PROXY or not self.proxies:
            return None
        
        proxy = self.proxies[self.current_index % len(self.proxies)]
        self.current_index += 1
        return proxy
    
    def get_random_proxy(self):
        """Get a random proxy"""
        if not Config.USE_PROXY or not self.proxies:
            return None
        
        return random.choice(self.proxies)
    
    def parse_proxy(self, proxy_string):
        """Parse proxy string to dict"""
        try:
            # Format: http://user:pass@host:port
            parts = proxy_string.split('@')
            if len(parts) == 2:
                auth, server = parts
                proto_parts = auth.split('://')
                if len(proto_parts) == 2:
                    protocol = proto_parts[0]
                    auth_parts = proto_parts[1].split(':')
                    return {
                        'server': f"{protocol}://{server}",
                        'username': auth_parts[0],
                        'password': auth_parts[1]
                    }
            return {'server': proxy_string}
        except:
            return None
    
    def get_count(self):
        """Get number of proxies loaded"""
        return len(self.proxies)
    
    def refresh(self):
        """Refresh proxy list"""
        self.current_index = 0
        self.load_proxies()