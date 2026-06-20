<?php
session_start();
if (!isset($_SESSION['admin'])) {
    header('Location: login.php');
    exit();
}

// Koneksi database
$conn = new mysqli('localhost', 'username', 'password', 'traffic_db');

// Hitung statistik
$total_visitors = $conn->query("SELECT COUNT(*) FROM visitors")->fetch_row()[0];
$today_visitors = $conn->query("SELECT COUNT(*) FROM visitors WHERE DATE(visit_date) = CURDATE()")->fetch_row()[0];
$unique_visitors = $conn->query("SELECT COUNT(DISTINCT ip_address) FROM visitors")->fetch_row()[0];
?>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard Traffic</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .stats-container { display: flex; gap: 20px; margin: 20px 0; }
        .stat-box { padding: 20px; background: #f5f5f5; border-radius: 8px; flex: 1; }
        .backlink-list { margin-top: 30px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: left; }
    </style>
</head>
<body>
    <h1>Website Traffic Dashboard</h1>
    
    <div class="stats-container">
        <div class="stat-box">
            <h3>Total Pengunjung</h3>
            <p><?php echo $total_visitors; ?></p>
        </div>
        <div class="stat-box">
            <h3>Pengunjung Hari Ini</h3>
            <p><?php echo $today_visitors; ?></p>
        </div>
        <div class="stat-box">
            <h3>Visitor Unik</h3>
            <p><?php echo $unique_visitors; ?></p>
        </div>
    </div>

    <div style="width: 80%; margin: 20px auto;">
        <canvas id="trafficChart"></canvas>
    </div>

    <div class="backlink-list">
        <h2>Backlink Auto-Generated</h2>
        <table>
            <tr>
                <th>URL</th>
                <th>Traffic</th>
                <th>Status</th>
                <th>Tanggal</th>
            </tr>
            <?php
            $backlinks = $conn->query("SELECT * FROM backlinks ORDER BY created_at DESC LIMIT 10");
            while($row = $backlinks->fetch_assoc()) {
                echo "<tr>
                    <td>{$row['url']}</td>
                    <td>{$row['traffic_count']}</td>
                    <td>{$row['status']}</td>
                    <td>{$row['created_at']}</td>
                </tr>";
            }
            ?>
        </table>
    </div>

    <script>
        // Chart.js untuk menampilkan grafik traffic
        const ctx = document.getElementById('trafficChart').getContext('2d');
        const trafficChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: <?php echo json_encode(getLast7Days()); ?>,
                datasets: [{
                    label: 'Traffic Harian',
                    data: <?php echo json_encode(getDailyTraffic()); ?>,
                    borderColor: 'rgb(75, 192, 192)',
                    tension: 0.1
                }]
            }
        });

        function getLast7Days() {
            // Fungsi untuk mendapatkan 7 hari terakhir
            return ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7'];
        }
    </script>
</body>
</html>
