const cron = require('node-cron');
const Database = require('../database/database');
const TrafficGenerator = require('../traffic/generator');
const config = require('../../config/config');

class Scheduler {
    constructor() {
        this.jobs = [];
        this.generator = new TrafficGenerator();
        this.isRunning = false;
    }

    async init() {
        await Database.init();
        
        if (config.scheduler.enabled) {
            console.log('📅 Scheduler enabled');
            
            // Schedule traffic generation
            cron.schedule(config.scheduler.cron, async () => {
                console.log('⏰ Scheduled traffic generation starting...');
                await this.runScheduledJob('automated_traffic', 25);
            });
            
            console.log(`✅ Scheduler configured with cron: ${config.scheduler.cron}`);
        } else {
            console.log('⏰ Scheduler disabled');
        }
    }

    async runScheduledJob(name, visits) {
        if (this.isRunning) {
            console.log('⚠️ Previous job still running, skipping...');
            return;
        }

        this.isRunning = true;
        const startTime = new Date().toISOString();

        try {
            await Database.logScheduledJob({
                name: name,
                scheduleTime: startTime,
                status: 'running',
                visitsGenerated: 0
            });

            console.log(`📊 Running scheduled job: ${name}`);
            await this.generator.generateBurst(visits);

            // Update job status
            await Database.logScheduledJob({
                name: name,
                scheduleTime: startTime,
                status: 'completed',
                visitsGenerated: visits
            });

            console.log(`✅ Scheduled job ${name} completed successfully`);

        } catch (error) {
            console.error(`❌ Scheduled job ${name} failed:`, error);
            
            await Database.logScheduledJob({
                name: name,
                scheduleTime: startTime,
                status: 'failed',
                visitsGenerated: 0
            });
        } finally {
            this.isRunning = false;
        }
    }

    async scheduleCustomJob(name, scheduleTime, visits) {
        const job = {
            name: name,
            scheduleTime: scheduleTime,
            visits: visits || 25
        };
        
        this.jobs.push(job);
        console.log(`📅 Custom job scheduled: ${name} at ${scheduleTime}`);
        
        // Schedule one-time job
        const now = new Date();
        const targetTime = new Date(scheduleTime);
        const delay = targetTime - now;
        
        if (delay > 0) {
            setTimeout(async () => {
                await this.runScheduledJob(name, visits);
            }, delay);
        }
        
        return job;
    }

    async listJobs() {
        return this.jobs;
    }

    async stop() {
        this.isRunning = false;
        if (this.generator) {
            await this.generator.stop();
        }
        console.log('🛑 Scheduler stopped');
    }
}

// Run scheduler if executed directly
if (require.main === module) {
    const scheduler = new Scheduler();
    scheduler.init().catch(console.error);
}

module.exports = Scheduler;const cron = require('node-cron');
const Database = require('../database/database');
const TrafficGenerator = require('../traffic/generator');
const config = require('../../config/config');

class Scheduler {
    constructor() {
        this.jobs = [];
        this.generator = new TrafficGenerator();
        this.isRunning = false;
    }

    async init() {
        await Database.init();
        
        if (config.scheduler.enabled) {
            console.log('📅 Scheduler enabled');
            
            // Schedule traffic generation
            cron.schedule(config.scheduler.cron, async () => {
                console.log('⏰ Scheduled traffic generation starting...');
                await this.runScheduledJob('automated_traffic', 25);
            });
            
            console.log(`✅ Scheduler configured with cron: ${config.scheduler.cron}`);
        } else {
            console.log('⏰ Scheduler disabled');
        }
    }

    async runScheduledJob(name, visits) {
        if (this.isRunning) {
            console.log('⚠️ Previous job still running, skipping...');
            return;
        }

        this.isRunning = true;
        const startTime = new Date().toISOString();

        try {
            await Database.logScheduledJob({
                name: name,
                scheduleTime: startTime,
                status: 'running',
                visitsGenerated: 0
            });

            console.log(`📊 Running scheduled job: ${name}`);
            await this.generator.generateBurst(visits);

            // Update job status
            await Database.logScheduledJob({
                name: name,
                scheduleTime: startTime,
                status: 'completed',
                visitsGenerated: visits
            });

            console.log(`✅ Scheduled job ${name} completed successfully`);

        } catch (error) {
            console.error(`❌ Scheduled job ${name} failed:`, error);
            
            await Database.logScheduledJob({
                name: name,
                scheduleTime: startTime,
                status: 'failed',
                visitsGenerated: 0
            });
        } finally {
            this.isRunning = false;
        }
    }

    async scheduleCustomJob(name, scheduleTime, visits) {
        const job = {
            name: name,
            scheduleTime: scheduleTime,
            visits: visits || 25
        };
        
        this.jobs.push(job);
        console.log(`📅 Custom job scheduled: ${name} at ${scheduleTime}`);
        
        // Schedule one-time job
        const now = new Date();
        const targetTime = new Date(scheduleTime);
        const delay = targetTime - now;
        
        if (delay > 0) {
            setTimeout(async () => {
                await this.runScheduledJob(name, visits);
            }, delay);
        }
        
        return job;
    }

    async listJobs() {
        return this.jobs;
    }

    async stop() {
        this.isRunning = false;
        if (this.generator) {
            await this.generator.stop();
        }
        console.log('🛑 Scheduler stopped');
    }
}

// Run scheduler if executed directly
if (require.main === module) {
    const scheduler = new Scheduler();
    scheduler.init().catch(console.error);
}

module.exports = Scheduler;