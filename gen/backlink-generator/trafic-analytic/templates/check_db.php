<?php
// check_db.php - Database health check
header('Content-Type: application/json');
require_once 'config.php';

try {
    $conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
    
    if ($conn->connect_error) {
        echo json_encode([
            'success' => false,
            'status' => 'Connection failed: ' . $conn->connect_error
        ]);
    } else {
        // Check if tables exist
        $tables = ['visitors', 'backlinks', 'users', 'sites'];
        $missing_tables = [];
        
        foreach ($tables as $table) {
            $result = $conn->query("SHOW TABLES LIKE '$table'");
            if ($result->num_rows == 0) {
                $missing_tables[] = $table;
            }
        }
        
        if (empty($missing_tables)) {
            echo json_encode([
                'success' => true,
                'status' => 'Connected - All tables present'
            ]);
        } else {
            echo json_encode([
                'success' => false,
                'status' => 'Missing tables: ' . implode(', ', $missing_tables)
            ]);
        }
        
        $conn->close();
    }
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'status' => 'Exception: ' . $e->getMessage()
    ]);
}
?>
