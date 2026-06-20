const faker = require('faker');
const config = require('../../config/config');

class TrafficSources {
  constructor() {
    this.sources = ['direct', 'organic', 'referral', 'social'];
    
    this.searchEngines = {
      google: 'https://www.google.com/search?q=',
      bing: 'https://www.bing.com/search?q=',
      duckduckgo: 'https://duckduckgo.com/?q='
    };
    
    this.referralDomains = [
      'https://news.ycombinator.com',
      'https://www.reddit.com',
      'https://www.quora.com',
      'https://medium.com',
      'https://dev.to',
      'https://stackoverflow.com'
    ];
    
    this.socialPlatforms = [
      'https://www.facebook.com',
      'https://www.instagram.com',
      'https://twitter.com',
      'https://www.tiktok.com',
      'https://www.linkedin.com',
      'https://www.youtube.com'
    ];
  }

  getRandomSource() {
    const weights = {
      direct: 30,
      organic: 40,
      referral: 15,
      social: 15
    };
    
    const rand = Math.random() * 100;
    let cumulative = 0;
    
    for (const [source, weight] of Object.entries(weights)) {
      cumulative += weight;
      if (rand <= cumulative) {
        return source;
      }
    }
    return 'direct';
  }

  generateTrafficContext(targetUrl) {
    const source = this.getRandomSource();
    const context = {
      source: source,
      referrer: null,
      keyword: null,
      landingPage: targetUrl
    };
    
    switch (source) {
      case 'organic':
        const searchEngine = Object.keys(this.searchEngines)[
          Math.floor(Math.random() * Object.keys(this.searchEngines).length)
        ];
        context.keyword = faker.lorem.words(this.randomInt(1, 4));
        context.referrer = `${this.searchEngines[searchEngine]}${encodeURIComponent(context.keyword)}`;
        context.landingPage = targetUrl; // Will navigate to target
        break;
        
      case 'referral':
        context.referrer = this.referralDomains[
          Math.floor(Math.random() * this.referralDomains.length)
        ];
        break;
        
      case 'social':
        context.referrer = this.socialPlatforms[
          Math.floor(Math.random() * this.socialPlatforms.length)
        ];
        break;
        
      case 'direct':
      default:
        context.referrer = null;
        break;
    }
    
    return context;
  }

  randomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
  }

  // Simulate Google search behavior
  async simulateSearch(page, keyword) {
    console.log(`🔍 Searching Google for: "${keyword}"`);
    
    await page.goto('https://www.google.com', { waitUntil: 'networkidle' });
    await this.randomPause(1000, 2000);
    
    // Type search query with human-like delay
    await page.type('input[name="q"]', keyword, { delay: this.randomInt(50, 200) });
    await this.randomPause(500, 1000);
    
    // Click search button or press Enter
    await page.keyboard.press('Enter');
    await page.waitForSelector('#search', { timeout: 10000 });
    await this.randomPause(2000, 4000);
    
    // Click a random search result
    const results = await page.$$('h3');
    if (results.length > 0) {
      const randomResult = results[Math.floor(Math.random() * Math.min(results.length, 5))];
      await randomResult.click();
      await page.waitForLoadState('networkidle');
    }
    
    return await page.url();
  }

  async randomPause(min, max) {
    const duration = Math.floor(Math.random() * (max - min + 1)) + min;
    await new Promise(resolve => setTimeout(resolve, duration));
  }
}

module.exports = new TrafficSources();