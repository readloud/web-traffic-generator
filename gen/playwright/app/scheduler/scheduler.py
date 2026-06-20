import asyncio
from datetime import datetime
from apscheduler.schedulers.asyncio import AsyncIOScheduler
from apscheduler.triggers.interval import IntervalTrigger
from config import Config
from app.traffic import TrafficGenerator
from app.database import db_manager
import logging

logger = logging.getLogger(__name__)

class Scheduler:
    def __init__(self):
        self.scheduler = AsyncIOScheduler()
        self.generator = TrafficGenerator()
        self.is_running = False
    
    async def start(self):
        """Start the scheduler"""
        if Config.SCHEDULE_ENABLED:
            logger.info("📅 Scheduler enabled")
            
            # Add job
            self.scheduler.add_job(
                self.run_scheduled_job,
                trigger=IntervalTrigger(seconds=Config.SCHEDULE_INTERVAL),
                id='traffic_generation',
                name='Scheduled Traffic Generation',
                replace_existing=True
            )
            
            self.scheduler.start()
            logger.info(f"✅ Scheduler started - interval: {Config.SCHEDULE_INTERVAL}s")
            
            # Run initial job if auto-start
            if Config.AUTO_START:
                await asyncio.sleep(5)
                await self.run_scheduled_job()
        else:
            logger.info("⏰ Scheduler disabled")
    
    async def run_scheduled_job(self):
        """Run a scheduled traffic generation job"""
        if self.is_running:
            logger.warning("⚠️ Previous job still running, skipping...")
            return
        
        self.is_running = True
        start_time = datetime.utcnow()
        
        try:
            logger.info("📊 Running scheduled traffic generation...")
            
            # Log job start
            db_manager.log_scheduled_job({
                'name': 'Scheduled Traffic Generation',
                'schedule_time': start_time,
                'status': 'running',
                'visits_generated': 0
            })
            
            # Generate traffic
            await self.generator.generate_burst(Config.SCHEDULE_VISITS_PER_RUN)
            
            # Log completion
            db_manager.log_scheduled_job({
                'name': 'Scheduled Traffic Generation',
                'schedule_time': start_time,
                'status': 'completed',
                'visits_generated': Config.SCHEDULE_VISITS_PER_RUN
            })
            
            logger.info("✅ Scheduled job completed successfully")
            
        except Exception as e:
            logger.error(f"❌ Scheduled job failed: {e}")
            
            db_manager.log_scheduled_job({
                'name': 'Scheduled Traffic Generation',
                'schedule_time': start_time,
                'status': 'failed',
                'visits_generated': 0
            })
        
        finally:
            self.is_running = False
    
    async def stop(self):
        """Stop the scheduler"""
        self.scheduler.shutdown()
        await self.generator.stop()
        logger.info("🛑 Scheduler stopped")

scheduler = Scheduler()