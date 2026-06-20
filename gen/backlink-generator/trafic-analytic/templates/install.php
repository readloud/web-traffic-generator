<?php
// install.php - Installer untuk sistem
if (file_exists('config.php')) {
    die('System already installed. Please remove install.php for security.');
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $db_host = $_POST['db_host'];
    $db_user = $_POST['db_user'];
    $db_pass = $_POST['db_pass'];
    $db_name = $_POST['db_name'];
    $admin_user = $_POST['admin_user'];
    $admin_pass = $_POST['admin_pass'];
    $admin_email = $_POST['admin_email'];
    
    // Test database connection
    try {
        $conn = new mysqli($db_host, $db_user, $db_pass);
        
        if ($conn->connect_error) {
            throw new Exception("Database connection failed: " . $conn->connect_error);
        }
        
        // Create database if not exists
        $conn->query("CREATE DATABASE IF NOT EXISTS $db_name");
        $conn->select_db($db_name);
        
        // Read and execute schema
        $schema = file_get_contents('schema.sql');
        $queries = explode(';', $schema);
        
        foreach ($queries as $query) {
            if (trim($query)) {
                $conn->query($query);
            }
        }
        
        // Create config file
        $config_content = "<?php
define('DB_HOST', '$db_host');
define('DB_USER', '$db_user');
define('DB_PASS', '$db_pass');
define('DB_NAME', '$db_name');
define('SITE_URL', '" . ($_SERVER['HTTPS'] ? 'https' : 'http') . "://" . $_SERVER['HTTP_HOST'] . "');
define('ADMIN_EMAIL', '$admin_email');
define('TRACK_CHANCE_PERCENT', 30);
define('SESSION_TIMEOUT', 1800);
?>";
        
        file_put_contents('config.php', $config_content);
        
        // Create admin user
        $hashed_pass = password_hash($admin_pass, PASSWORD_DEFAULT);
        $conn->query("UPDATE users SET username='$admin_user', email='$admin_email', password_hash='$hashed_pass' WHERE username='admin'");
        
        echo json_encode(['success' => true, 'message' => 'Installation successful!']);
        
    } catch (Exception $e) {
        echo json_encode(['success' => false, 'message' => $e->getMessage()]);
    }
    exit();
}
?>
<!DOCTYPE html>
<html>
<head>
    <title>Install Traffic Analytics</title>
    <style>
        body { font-family: Arial; padding: 20px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input { width: 300px; padding: 8px; }
        button { padding: 10px 20px; }
    </style>
</head>
<body>
    <h1>Traffic Analytics Installation</h1>
    <form id="installForm">
        <div class="form-group">
            <label>Database Host:</label>
            <input type="text" name="db_host" value="localhost" required>
        </div>
        <div class="form-group">
            <label>Database User:</label>
            <input type="text" name="db_user" value="root" required>
        </div>
        <div class="form-group">
            <label>Database Password:</label>
            <input type="password" name="db_pass">
        </div>
        <div class="form-group">
            <label>Database Name:</label>
            <input type="text" name="db_name" value="traffic_db" required>
        </div>
        <hr>
        <div class="form-group">
            <label>Admin Username:</label>
            <input type="text" name="admin_user" value="admin" required>
        </div>
        <div class="form-group">
            <label>Admin Password:</label>
            <input type="password" name="admin_pass" required>
        </div>
        <div class="form-group">
            <label>Admin Email:</label>
            <input type="email" name="admin_email" required>
        </div>
        <button type="submit">Install</button>
    </form>
    
    <script>
        document.getElementById('installForm').onsubmit = function(e) {
            e.preventDefault();
            var formData = new FormData(this);
            
            fetch('install.php', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert(data.message + ' Please remove install.php file.');
                    window.location.href = 'login.php';
                } else {
                    alert('Error: ' + data.message);
                }
            });
        };
    </script>
</body>
</html>