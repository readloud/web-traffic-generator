const GhostManager = require('../browser/GhostManager');
const BehaviorSimulator = require('../browser/behavior');
const TrafficSources = require('./sources');
const ProxyManager = require('../proxy/ProxyManager');
const Database = require('../database/database');
const config = require('../../config/config');
const { v4: uuidv4 } = require('uuid');

class TrafficGenerator {
  constructor() {
    this.ghostManager = new GhostManager();
    this.isRunning = false;
    this.stats = {
      totalVisits: 0,
      successfulVisits: 0,
      failedVisits: 0
    };
  }

  async generateSingleVisit() {
    const sessionId = uuidv4();
    let context = null;
    let page = null;
    let visitData = null;

    try {
      // Initialize browser
      context = await this.ghostManager.init();
      page = await this.ghostManager.createPage();
      
      // Generate traffic source
      const targetUrl = config.traffic.targetUrl;
      const trafficContext = TrafficSources.generateTrafficContext(targetUrl);
      
      console.log(`\n🔄 Visit ${this.stats.totalVisits + 1}`);
      console.log(`📊 Source: ${trafficContext.source}`);
      if (trafficContext.keyword) {
        console.log(`🔑 Keyword: ${trafficContext.keyword}`);
      }
      if (trafficContext.referrer) {
        console.log(`🔗 Referrer: ${trafficContext.referrer}`);
      }

      // Set referrer if available
      if (trafficContext.referrer) {
        await page.goto(trafficContext.referrer, { waitUntil: 'networkidle' });
        await page.waitForTimeout(1000);
      }

      // Navigate to target
      console.log(`🌐 Navigating to: ${targetUrl}`);
      await page.goto(targetUrl, { waitUntil: 'networkidle' });
      
      // Get page info
      const pageInfo = await page.evaluate(() => {
        return {
          title: document.title,
          url: window.location.href
        };
      });
      
      console.log(`📄 Page title: ${pageInfo.title}`);
      console.log(`📌 URL: ${pageInfo.url}`);
      
      // Simulate human behavior
      const behavior = new BehaviorSimulator(page);
      
      // Initial dwell time
      const initialDwellTime = await behavior.dwell(
        config.traffic.minDwellTime,
        config.traffic.maxDwellTime
      );
      
      // Scroll behavior
      await behavior.simulateScrolling();
      
      // Mouse movements
      await behavior.simulateMouseMovement();
      
      // Click internal links (page depth)
      const clickedLinks = await behavior.clickRandomLinks();
      const pageDepth = clickedLinks ? clickedLinks.length + 1 : 1;
      
      // Random chance of bounce
      const bounceRate = Math.random() * 100;
      const isBounce = bounceRate <= config.traffic.bounceRateMax && 
                       bounceRate >= config.traffic.bounceRateMin;
      
      // Get final scroll depth
      const scrollDepth = await behavior.getScrollDepth();
      
      // Calculate total duration
      const totalDuration = initialDwellTime + 
        (clickedLinks ? clickedLinks.length * 30 : 0);
      
      // Get user agent
      const userAgent = await page.evaluate(() => navigator.userAgent);
      
      // Get IP (from proxy or page)
      const ipAddress = await this.getIPAddress(page);
      
      // Prepare visit data for database
      visitData = {
        sessionId: sessionId,
        ipAddress: ipAddress || 'unknown',
        userAgent: userAgent,
        referrer: trafficContext.referrer || 'direct',
        landingPage: targetUrl,
        pagesVisited: pageDepth,
        totalDuration: totalDuration,
        isBounce: isBounce || pageDepth === 1,
        trafficSource: trafficContext.source,
        keyword: trafficContext.keyword || null,
        proxyUsed: ProxyManager.getProxyCount() > 0 ? 'yes' : 'no'
      };
      
      // Log to database
      const visitId = await Database.logVisit(visitData);
      
      // Log page views
      await Database.logPageView({
        sessionId: sessionId,
        url: targetUrl,
        timeOnPage: initialDwellTime,
        scrollDepth: scrollDepth,
        clickCount: clickedLinks ? clickedLinks.length : 0
      });

      // Update stats
      this.stats.totalVisits++;
      this.stats.successfulVisits++;
      
      console.log(`✅ Visit complete! Session: ${sessionId}`);
      console.log(`📊 Bounce: ${isBounce ? 'Yes' : 'No'}, Page depth: ${pageDepth}`);
      console.log(`⏱️  Duration: ${totalDuration} seconds`);
      console.log(`📜 Scroll depth: ${scrollDepth}%`);
      
      return {
        sessionId,
        success: true,
        data: visitData
      };

    } catch (error) {
      console.error('❌ Error generating visit:', error.message);
      this.stats.failedVisits++;
      return {
        success: false,
        error: error.message
      };
    } finally {
      // Cleanup browser
      if (page) await page.close();
      if (context) await context.close();
    }
  }

  async getIPAddress(page) {
    try {
      const ip = await page.evaluate(() => {
        return fetch('https://api.ipify.org?format=json')
          .then(res => res.json())
          .then(data => data.ip)
          .catch(() => null);
      });
      return ip;
    } catch {
      return null;
    }
  }

  async generateBurst(visits = 10) {
    if (this.isRunning) {
      console.log('⚠️ Generator already running');
      return;
    }

    this.isRunning = true;
    console.log(`\n🚀 Starting burst of ${visits} visits...`);

    try {
      for (let i = 0; i < visits; i++) {
        await this.generateSingleVisit();
        
        // Random delay between visits (2-10 seconds)
        if (i < visits - 1) {
          const delay = Math.floor(Math.random() * 8000) + 2000;
          console.log(`⏳ Waiting ${Math.round(delay/1000)} seconds before next visit...`);
          await new Promise(resolve => setTimeout(resolve, delay));
        }
      }
    } catch (error) {
      console.error('Error during burst:', error);
    } finally {
      this.isRunning = false;
      await this.ghostManager.cleanup();
      console.log(`\n✅ Burst complete! Successful: ${this.stats.successfulVisits}, Failed: ${this.stats.failedVisits}`);
    }
  }

  async generateContinuous(options = {}) {
    const {
      visitsPerHour = 10,
      durationMinutes = 60
    } = options;

    console.log(`🔄 Starting continuous generation: ${visitsPerHour} visits/hour for ${durationMinutes} minutes`);
    
    const startTime = Date.now();
    const endTime = startTime + (durationMinutes * 60 * 1000);
    let visitCount = 0;

    while (Date.now() < endTime) {
      await this.generateSingleVisit();
      visitCount++;
      
      // Calculate delay to achieve desired visits per hour
      const elapsedMinutes = (Date.now() - startTime) / 60000;
      const targetVisits = (elapsedMinutes / 60) * visitsPerHour;
      
      if (visitCount < targetVisits) {
        const timeToNext = (60000 / visitsPerHour) * (targetVisits - visitCount);
        await new Promise(resolve => setTimeout(resolve, Math.min(timeToNext, 10000)));
      }
    }

    console.log(`✅ Continuous generation complete. Generated ${visitCount} visits`);
  }

  getStats() {
    return {
      ...this.stats,
      running: this.isRunning
    };
  }

  async stop() {
    this.isRunning = false;
    await this.ghostManager.cleanup();
    console.log('🛑 Generator stopped');
  }
}

module.exports = TrafficGenerator;