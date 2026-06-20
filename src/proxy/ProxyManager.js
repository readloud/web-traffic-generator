const fs = require('fs');
const path = require('path');
const config = require('../../config/config');

class ProxyManager {
  constructor() {
    this.proxies = [];
    this.currentIndex = 0;
    this.loadProxies();
  }

  loadProxies() {
    try {
      const proxyFile = config.proxy.file;
      if (fs.existsSync(proxyFile)) {
        const content = fs.readFileSync(proxyFile, 'utf8');
        this.proxies = content
          .split('\n')
          .map(line => line.trim())
          .filter(line => line && !line.startsWith('#'));
        console.log(`✅ Loaded ${this.proxies.length} proxies`);
      } else {
        console.warn('⚠️ No proxy file found, using direct connection');
        this.proxies = [];
      }
    } catch (error) {
      console.error('Error loading proxies:', error);
      this.proxies = [];
    }
  }

  getNextProxy() {
    if (!config.proxy.enabled || this.proxies.length === 0) {
      return null;
    }

    const proxy = this.proxies[this.currentIndex % this.proxies.length];
    this.currentIndex++;
    return proxy;
  }

  getRandomProxy() {
    if (!config.proxy.enabled || this.proxies.length === 0) {
      return null;
    }
    
    return this.proxies[Math.floor(Math.random() * this.proxies.length)];
  }

  parseProxy(proxyString) {
    // Supports: http://user:pass@host:port, socks5://host:port
    try {
      const url = new URL(proxyString);
      return {
        host: url.hostname,
        port: parseInt(url.port),
        username: url.username || null,
        password: url.password || null,
        protocol: url.protocol.replace(':', '')
      };
    } catch {
      // Simple format: host:port
      const parts = proxyString.split(':');
      if (parts.length === 2) {
        return {
          host: parts[0],
          port: parseInt(parts[1]),
          username: null,
          password: null,
          protocol: 'http'
        };
      }
      return null;
    }
  }

  getProxyConfig(proxyString) {
    if (!proxyString) return null;
    
    const parsed = this.parseProxy(proxyString);
    if (!parsed) return null;

    const config = {
      server: `${parsed.protocol}://${parsed.host}:${parsed.port}`
    };

    if (parsed.username && parsed.password) {
      config.username = parsed.username;
      config.password = parsed.password;
    }

    return config;
  }

  getProxyCount() {
    return this.proxies.length;
  }

  refresh() {
    this.currentIndex = 0;
    this.loadProxies();
  }
}

module.exports = new ProxyManager();