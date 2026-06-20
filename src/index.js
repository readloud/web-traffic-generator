#!/usr/bin/env node

const path = require('path');
const fs = require('fs');
const config = require('../config/config');
const Database = require('./database/database');
const TrafficGenerator = require('./traffic/generator');
const Scheduler = require('./scheduler/scheduler');
const { startDashboard } = require('./dashboard/server');

// Ensure log directory exists
const logDir = path.dirname(config.logging.file);
if (!fs.existsSync(logDir)) {
    fs.mkdirSync(logDir, { recursive: true });
}

// Configure logger
const winston = require('winston');
const logger = winston.createLogger({
    level: config.logging.level,
    format: winston.format.combine(
        winston.format.timestamp(),
        winston.format.json()
    ),
    transports: [
        new winston.transports.File({ filename: config.logging.file }),
        new winston.transports.Console({
            format: winston.format.combine(
                winston.format.colorize(),
                winston.format.simple()
            )
        })
    ]
});

// Main application
class TrafficGeneratorApp {
    constructor() {
        this.db = Database;
        this.generator = new TrafficGenerator();
        this.scheduler = new Scheduler();
        this.isShuttingDown = false;
    }

    async init() {
        try {
            logger.info('🚀 Starting Organic Traffic Generator');
            
            // Initialize database
            await this.db.init();
            
            // Start scheduler
            await this.scheduler.init();
            
            // Start dashboard
            const dashboardServer = await startDashboard();
            
            // Handle shutdown
            process.on('SIGINT', () => this.shutdown());
            process.on('SIGTERM', () => this.shutdown());
            process.on('uncaughtException', (error) => {
                logger.error('Uncaught exception:', error);
                this.shutdown();
            });
            
            logger.info('✅ Application started successfully');
            
            // Start continuous generation if specified
            if (process.env.AUTO_START === 'true') {
                logger.info('🔄 Auto-starting traffic generation');
                this.generator.generateContinuous({
                    visitsPerHour: parseInt(process.env.AUTO_VISITS_PER_HOUR) || 10,
                    durationMinutes: parseInt(process.env.AUTO_DURATION) || 60
                });
            }
            
        } catch (error) {
            logger.error('❌ Failed to initialize application:', error);
            process.exit(1);
        }
    }

    async shutdown() {
        if (this.isShuttingDown) return;
        this.isShuttingDown = true;
        
        logger.info('🛑 Shutting down...');
        
        try {
            // Stop generator
            if (this.generator) {
                await this.generator.stop();
            }
            
            // Stop scheduler
            if (this.scheduler) {
                await this.scheduler.stop();
            }
            
            // Close database
            if (this.db) {
                await this.db.close();
            }
            
            logger.info('✅ Shutdown complete');
            process.exit(0);
        } catch (error) {
            logger.error('❌ Error during shutdown:', error);
            process.exit(1);
        }
    }
}

// Run application
const app = new TrafficGeneratorApp();
app.init().catch((error) => {
    console.error('Fatal error:', error);
    process.exit(1);
});

module.exports = app;