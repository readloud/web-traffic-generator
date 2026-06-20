class Dashboard {
    constructor() {
        this.socket = io();
        this.sourcesChart = null;
        this.timelineChart = null;
        this.isRunning = false;
        this.init();
    }

    init() {
        this.setupWebSocket();
        this.setupEventListeners();
        this.initCharts();
        this.loadStats();
        this.loadRecentVisits();
        
        // Auto-refresh every 30 seconds
        setInterval(() => {
            this.loadStats();
            this.loadRecentVisits();
        }, 30000);
    }

    setupWebSocket() {
        this.socket.on('connect', () => {
            console.log('Connected to server');
            document.getElementById('status-indicator').textContent = '● Connected';
            document.getElementById('status-indicator').className = 'status-online';
        });

        this.socket.on('stats_update', (stats) => {
            this.updateStats(stats);
        });

        this.socket.on('disconnect', () => {
            document.getElementById('status-indicator').textContent = '● Disconnected';
            document.getElementById('status-indicator').className = 'status-offline';
        });
    }

    setupEventListeners() {
        document.getElementById('start-btn').addEventListener('click', () => {
            this.startTraffic();
        });

        document.getElementById('stop-btn').addEventListener('click', () => {
            this.stopTraffic();
        });

        document.getElementById('export-btn').addEventListener('click', () => {
            this.exportCSV();
        });
    }

    initCharts() {
        // Sources chart
        const ctx1 = document.getElementById('sources-chart').getContext('2d');
        this.sourcesChart = new Chart(ctx1, {
            type: 'doughnut',
            data: {
                labels: ['Direct', 'Organic', 'Referral', 'Social'],
                datasets: [{
                    data: [0, 0, 0, 0],
                    backgroundColor: ['#4299e1', '#48bb78', '#ed8936', '#9f7aea']
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });

        // Timeline chart
        const ctx2 = document.getElementById('timeline-chart').getContext('2d');
        this.timelineChart = new Chart(ctx2, {
            type: 'line',
            data: {
                labels: [],
                datasets: [{
                    label: 'Visits',
                    data: [],
                    borderColor: '#4299e1',
                    backgroundColor: 'rgba(66, 153, 225, 0.1)',
                    fill: true
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    }

    async loadStats() {
        try {
            const response = await fetch('/api/stats');
            const stats = await response.json();
            this.updateStats(stats);
        } catch (error) {
            console.error('Error loading stats:', error);
        }
    }

    updateStats(stats) {
        document.getElementById('total-visits').textContent = stats.totalVisits || 0;
        document.getElementById('unique-visitors').textContent = stats.uniqueVisitors || 0;
        document.getElementById('avg-duration').textContent = `${stats.avgDuration || 0}s`;
        document.getElementById('bounce-rate').textContent = `${stats.bounceRate || 0}%`;
        document.getElementById('page-depth').textContent = stats.pageDepth || 0;
        document.getElementById('proxy-count').textContent = stats.proxyCount || 0;
        document.getElementById('last-24h').textContent = stats.last24Hours || 0;
        document.getElementById('visit-counter').textContent = `Visits: ${stats.totalVisits || 0}`;

        // Update sources chart
        if (this.sourcesChart && stats.trafficSources) {
            const sources = stats.trafficSources;
            this.sourcesChart.data.datasets[0].data = [
                sources.direct || 0,
                sources.organic || 0,
                sources.referral || 0,
                sources.social || 0
            ];
            this.sourcesChart.update();
        }

        // Update status
        if (stats.running) {
            document.getElementById('status-indicator').textContent = '● Running';
            document.getElementById('status-indicator').className = 'status-running';
            document.getElementById('start-btn').disabled = true;
            document.getElementById('stop-btn').disabled = false;
            this.isRunning = true;
        } else {
            document.getElementById('status-indicator').textContent = '● Online';
            document.getElementById('status-indicator').className = 'status-online';
            document.getElementById('start-btn').disabled = false;
            document.getElementById('stop-btn').disabled = true;
            this.isRunning = false;
        }
    }

    async loadRecentVisits() {
        try {
            const response = await fetch('/api/recent?limit=20');
            const visits = await response.json();
            
            const tbody = document.getElementById('visits-body');
            if (visits.length === 0) {
                tbody.innerHTML = '<tr><td colspan="6">No visits recorded yet</td></tr>';
                return;
            }
            
            tbody.innerHTML = visits.map(visit => `
                <tr>
                    <td><code>${visit.session_id.slice(0, 8)}...</code></td>
                    <td><span class="source-tag">${visit.traffic_source}</span></td>
                    <td>${visit.pages_visited}</td>
                    <td>${visit.total_duration}s</td>
                    <td>${visit.is_bounce ? '✅' : '❌'}</td>
                    <td>${new Date(visit.timestamp).toLocaleTimeString()}</td>
                </tr>
            `).join('');
            
            // Update timeline
            if (this.timelineChart) {
                const times = visits.map(v => new Date(v.timestamp).toLocaleTimeString());
                const counts = visits.map((_, i) => i + 1);
                
                this.timelineChart.data.labels = times.reverse();
                this.timelineChart.data.datasets[0].data = counts.reverse();
                this.timelineChart.update();
            }
        } catch (error) {
            console.error('Error loading recent visits:', error);
        }
    }

    async startTraffic() {
        const visitCount = parseInt(document.getElementById('visit-count').value) || 10;
        const mode = document.getElementById('mode-select').value;
        
        try {
            const response = await fetch('/api/generate', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ visits: visitCount, mode: mode })
            });
            
            const data = await response.json();
            if (data.success) {
                console.log('Traffic generation started');
                document.getElementById('start-btn').disabled = true;
                document.getElementById('stop-btn').disabled = false;
                document.getElementById('status-indicator').textContent = '● Running';
                document.getElementById('status-indicator').className = 'status-running';
            }
        } catch (error) {
            console.error('Error starting traffic:', error);
        }
    }

    async stopTraffic() {
        try {
            const response = await fetch('/api/stop', {
                method: 'POST'
            });
            
            const data = await response.json();
            if (data.success) {
                console.log('Traffic generation stopped');
                document.getElementById('start-btn').disabled = false;
                document.getElementById('stop-btn').disabled = true;
                document.getElementById('status-indicator').textContent = '● Online';
                document.getElementById('status-indicator').className = 'status-online';
            }
        } catch (error) {
            console.error('Error stopping traffic:', error);
        }
    }

    async exportCSV() {
        try {
            const response = await fetch('/api/export/csv');
            const blob = await response.blob();
            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = `traffic_data_${new Date().toISOString().slice(0,10)}.csv`;
            document.body.appendChild(a);
            a.click();
            window.URL.revokeObjectURL(url);
            document.body.removeChild(a);
        } catch (error) {
            console.error('Error exporting CSV:', error);
        }
    }
}

// Initialize dashboard when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    new Dashboard();
});