const config = require('../../config/config');

class BehaviorSimulator {
  constructor(page) {
    this.page = page;
  }

  async simulateHumanBehavior(duration) {
    // Random scroll behavior
    await this.simulateScrolling();
    
    // Random mouse movements
    await this.simulateMouseMovement();
    
    // Random pauses (human-like thinking)
    await this.randomPause(2000, 5000);
    
    // Dwell time on page
    await this.dwell(duration);
  }

  async simulateScrolling() {
    const scrolls = Math.floor(Math.random() * 5) + 2;
    const viewportHeight = await this.page.evaluate(() => window.innerHeight);
    const pageHeight = await this.page.evaluate(() => document.documentElement.scrollHeight);
    
    for (let i = 0; i < scrolls; i++) {
      const scrollPosition = Math.random() * (pageHeight - viewportHeight);
      await this.page.evaluate((position) => {
        window.scrollTo({
          top: position,
          behavior: 'smooth'
        });
      }, scrollPosition);
      
      // Random pause between scrolls
      await this.randomPause(500, 2000);
    }
  }

  async simulateMouseMovement() {
    // Move mouse to random positions
    for (let i = 0; i < 3; i++) {
      const x = Math.floor(Math.random() * 800) + 100;
      const y = Math.floor(Math.random() * 500) + 100;
      
      await this.page.mouse.move(x, y, {
        steps: Math.floor(Math.random() * 10) + 5
      });
      
      // Click randomly (not always)
      if (Math.random() > 0.7) {
        await this.page.mouse.click(x, y);
        console.log('🖱️ Random click at', x, y);
      }
      
      await this.randomPause(1000, 3000);
    }
  }

  async randomPause(min, max) {
    const duration = Math.floor(Math.random() * (max - min + 1)) + min;
    await this.page.waitForTimeout(duration);
  }

  async dwell(minSeconds = null, maxSeconds = null) {
    const min = minSeconds || config.traffic.minDwellTime;
    const max = maxSeconds || config.traffic.maxDwellTime;
    const duration = this.randomInt(min, max);
    
    console.log(`⏱️ Dwelling for ${duration} seconds`);
    await this.page.waitForTimeout(duration * 1000);
    return duration;
  }

  randomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
  }

  async clickRandomLinks() {
    try {
      // Get all internal links
      const links = await this.page.$$eval('a[href]', elements => {
        return elements
          .map(el => el.href)
          .filter(href => 
            href.startsWith(window.location.origin) && 
            !href.includes('#') &&
            !href.includes('mailto:') &&
            !href.includes('tel:')
          );
      });

      if (links.length === 0) return null;

      // Click 1-3 random links (page depth)
      const maxClicks = Math.min(
        this.randomInt(config.traffic.pageDepthMin, config.traffic.pageDepthMax),
        links.length
      );

      let clickedLinks = [];
      for (let i = 0; i < maxClicks; i++) {
        const randomIndex = Math.floor(Math.random() * links.length);
        const link = links[randomIndex];
        
        if (!clickedLinks.includes(link)) {
          console.log(`🔗 Clicking link: ${link}`);
          await this.page.goto(link, { waitUntil: 'networkidle' });
          clickedLinks.push(link);
          
          // Random dwell on subpage
          await this.dwell(15, 60);
          
          // Simulate behavior on subpage
          await this.simulateScrolling();
        }
      }

      return clickedLinks;
    } catch (error) {
      console.error('Error clicking random links:', error.message);
      return null;
    }
  }

  async getScrollDepth() {
    return await this.page.evaluate(() => {
      const scrollTop = window.scrollY;
      const docHeight = document.documentElement.scrollHeight - window.innerHeight;
      return Math.round((scrollTop / docHeight) * 100);
    });
  }

  async getCurrentUrl() {
    return await this.page.url();
  }
}

module.exports = BehaviorSimulator;