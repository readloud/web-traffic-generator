<?php
// test.php - Test script
require_once 'config.php';
require_once 'database.php';

echo "<h1>Traffic Analytics Test</h1>";
echo "<pre>";

echo "PHP Version: " . phpversion() . "\n\n";

echo "Database Test:\n";
try {
    $conn = Database::getInstance();
    echo "✓ Database connected successfully\n";
    echo "MySQL Version: " . $conn->server_info . "\n\n";
    
    echo "Table Check:\n";
    $tables = ['visitors', 'backlinks', 'users', 'sites'];
    foreach ($tables as $table) {
        $result = $conn->query("SHOW TABLES LIKE '$table'");
        echo ($result->num_rows > 0 ? "✓ " : "✗ ") . "$table\n";
    }
    
    echo "\nSample Query Test:\n";
    $result = Database::query("SELECT COUNT(*) as count FROM users");
    echo "Users in database: " . ($result[0]['count'] ?? 0) . "\n";
    
} catch (Exception $e) {
    echo "✗ Database error: " . $e->getMessage() . "\n";
}

echo "\nPHP Extensions:\n";
$extensions = ['mysqli', 'json', 'curl', 'mbstring'];
foreach ($extensions as $ext) {
    echo (extension_loaded($ext) ? "✓ " : "✗ ") . "$ext\n";
}

echo "\nDirectory Permissions:\n";
$dirs = ['.', 'logs'];
foreach ($dirs as $dir) {
    $writable = is_writable($dir);
    echo ($writable ? "✓ " : "✗ ") . "$dir is " . ($writable ? "writable" : "not writable") . "\n";
}

echo "\nTracking Test:\n";
echo "Test URL: <a href='track.php?site_id=test&url=http://example.com'>track.php?site_id=test</a>\n";

echo "</pre>";
?>
