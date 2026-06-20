// tracker.js - Script untuk diload di website client
class TrafficTracker {
    constructor(options = {}) {
        this.endpoint = options.endpoint || '/api/track';
        this.autoTrack = options.autoTrack !== false;
        this.debug = options.debug || false;
        
        if (this.autoTrack) {
            this.track();
        }
    }
    
    async track(customData = {}) {
        try {
            const data = {
                url: window.location.href,
                referrer: document.referrer || 'direct',
                screen: `${window.screen.width}x${window.screen.height}`,
                language: navigator.language,
                ...customData
            };
            
            // Menggunakan Beacon API jika tersedia (untuk page unload)
            if (navigator.sendBeacon) {
                const blob = new Blob([JSON.stringify(data)], {type: 'application/json'});
                navigator.sendBeacon(this.endpoint, blob);
            } else {
                // Fallback ke fetch API
                await fetch(this.endpoint, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(data),
                    keepalive: true // Untuk menjaga request tetap hidup
                });
            }
            
            if (this.debug) {
                console.log('Tracking data sent:', data);
            }
            
            // Cek untuk auto-generate backlink (10% chance)
            if (Math.random() < 0.1) {
                this.generateBacklink();
            }
            
        } catch (error) {
            if (this.debug) {
                console.error('Tracking error:', error);
            }
        }
    }
    
    async generateBacklink() {
        try {
            const response = await fetch('/api/backlinks/generate', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    url: window.location.href,
                    count: 1
                })
            });
            
            if (this.debug) {
                const result = await response.json();
                console.log('Backlink generated:', result);
            }
        } catch (error) {
            // Silent fail untuk backlink generation
        }
    }
    
    // Metode untuk track custom events
    async trackEvent(eventName, eventData = {}) {
        return this.track({
            event: eventName,
            event_data: eventData,
            type: 'event'
        });
    }
    
    // Track page view time
    startPageViewTimer() {
        this.pageLoadTime = new Date();
        
        window.addEventListener('beforeunload', () => {
            const timeSpent = new Date() - this.pageLoadTime;
            this.track({
                time_spent: Math.round(timeSpent / 1000), // dalam detik
                type: 'page_exit'
            });
        });
    }
}

// Auto-initialize jika di load di browser
if (typeof window !== 'undefined') {
    window.TrafficTracker = TrafficTracker;
    
    // Auto-start dengan default options
    const tracker = new TrafficTracker({
        endpoint: 'http://localhost:5000/api/track',
        autoTrack: true,
        debug: false
    });
    
    // Track page view time
    tracker.startPageViewTimer();
    
    // Expose ke window object untuk akses manual
    window.tracker = tracker;
}

export default TrafficTracker;
