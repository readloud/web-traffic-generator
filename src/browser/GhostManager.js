const { GhostBrowser } = require('ghoster');
const { chromium } = require('playwright-extra');
const StealthPlugin = require('puppeteer-extra-plugin-stealth');
const config = require('../../config/config');
const proxyManager = require('../proxy/ProxyManager');
const faker = require('faker');

// Apply stealth plugin if enabled
if (config.stealth.enabled) {
  chromium.use(StealthPlugin());
}

class GhostManager {
  constructor() {
    this.browser = null;
    this.context = null;
    this.ghost = null;
  }

  async init() {
    // Get random proxy
    let proxyConfig = null;
    if (config.proxy.enabled) {
      const proxyString = proxyManager.getRandomProxy();
      if (proxyString) {
        proxyConfig = proxyManager.getProxyConfig(proxyString);
        console.log(`🌐 Using proxy: ${proxyString}`);
      }
    }

    // Generate random fingerprint
    const fingerprint = this.generateFingerprint();

    // Initialize GhostBrowser
    this.ghost = new GhostBrowser({
      proxies: proxyConfig ? [proxyConfig] : []
    });

    const options = {
      headless: config.stealth.headless,
      args: [
        '--no-sandbox',
        '--disable-setuid-sandbox',
        '--disable-dev-shm-usage',
        '--disable-accelerated-2d-canvas',
        '--disable-gpu'
      ],
      viewport: {
        width: this.randomInt(1024, 1920),
        height: this.randomInt(768, 1080)
      }
    };

    // Launch browser
    this.browser = await this.ghost.launch(options);
    this.context = await this.browser.newContext({
      locale: fingerprint.locale,
      timezoneId: fingerprint.timezone,
      userAgent: fingerprint.userAgent,
      viewport: fingerprint.viewport
    });

    console.log('🌐 Browser initialized with fingerprint');
    return this.context;
  }

  generateFingerprint() {
    const userAgents = [
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/119.0',
      'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.1 Safari/605.1.15',
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Edg/120.0.0.0'
    ];

    const timezones = [
      'America/New_York',
      'America/Los_Angeles',
      'Europe/London',
      'Europe/Paris',
      'Asia/Tokyo',
      'Australia/Sydney',
      'America/Chicago',
      'Europe/Berlin'
    ];

    const locales = ['en-US', 'en-GB', 'en-CA', 'en-AU'];

    return {
      userAgent: userAgents[Math.floor(Math.random() * userAgents.length)],
      timezone: timezones[Math.floor(Math.random() * timezones.length)],
      locale: locales[Math.floor(Math.random() * locales.length)],
      viewport: {
        width: this.randomInt(1024, 1920),
        height: this.randomInt(768, 1080)
      }
    };
  }

  randomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
  }

  async createPage() {
    if (!this.browser) {
      await this.init();
    }
    return await this.context.newPage();
  }

  async close() {
    if (this.browser) {
      await this.browser.close();
      this.browser = null;
      this.context = null;
      this.ghost = null;
    }
  }

  async cleanup() {
    await this.close();
  }
}

module.exports = GhostManager;