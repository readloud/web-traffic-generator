<?php
// database.php - Database Connection Class
require_once 'config.php';

class Database {
    private static $instance = null;
    private $connection;
    private $query_count = 0;
    private $queries = [];
    
    private function __construct() {
        try {
            $this->connection = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
            
            if ($this->connection->connect_error) {
                $this->logError("Database connection failed: " . $this->connection->connect_error);
                throw new Exception("Database connection failed");
            }
            
            $this->connection->set_charset("utf8mb4");
            $this->connection->options(MYSQLI_OPT_INT_AND_FLOAT_NATIVE, 1);
            
        } catch (Exception $e) {
            $this->logError($e->getMessage());
            throw $e;
        }
    }
    
    public static function getInstance() {
        if (self::$instance === null) {
            self::$instance = new Database();
        }
        return self::$instance->connection;
    }
    
    public static function query($sql, $params = [], $types = '') {
        $db = self::getInstance();
        $stmt = $db->prepare($sql);
        
        if (!$stmt) {
            self::$instance->logError("Prepare failed: " . $db->error);
            return false;
        }
        
        if (!empty($params)) {
            if (empty($types)) {
                $types = str_repeat('s', count($params));
            }
            $stmt->bind_param($types, ...$params);
        }
        
        $result = $stmt->execute();
        
        if (!$result) {
            self::$instance->logError("Execute failed: " . $stmt->error);
            $stmt->close();
            return false;
        }
        
        self::$instance->query_count++;
        self::$instance->queries[] = $sql;
        
        if (stripos($sql, 'SELECT') === 0) {
            $res = $stmt->get_result();
            $data = [];
            while ($row = $res->fetch_assoc()) {
                $data[] = $row;
            }
            $stmt->close();
            return $data;
        } else {
            $affected = $stmt->affected_rows;
            $stmt->close();
            return $affected;
        }
    }
    
    public static function getQueryCount() {
        return self::$instance ? self::$instance->query_count : 0;
    }
    
    public static function getQueries() {
        return self::$instance ? self::$instance->queries : [];
    }
    
    public static function escape($string) {
        $db = self::getInstance();
        return $db->real_escape_string($string);
    }
    
    public static function lastInsertId() {
        $db = self::getInstance();
        return $db->insert_id;
    }
    
    public static function close() {
        if (self::$instance !== null && self::$instance->connection) {
            self::$instance->connection->close();
            self::$instance = null;
        }
    }
    
    private function logError($message) {
        $log_file = __DIR__ . '/logs/db_errors.log';
        $timestamp = date('Y-m-d H:i:s');
        $log_message = "[$timestamp] $message\n";
        
        file_put_contents($log_file, $log_message, FILE_APPEND);
        
        // Email admin jika error critical
        if (strpos($message, 'connection failed') !== false) {
            @mail(ADMIN_EMAIL, 'Database Error Alert', $log_message);
        }
    }
    
    public function __destruct() {
        $this->close();
    }
}

// Create tables if not exists (auto-install)
function checkAndInstallTables() {
    try {
        $conn = Database::getInstance();
        
        // Check if tables exist
        $result = $conn->query("SHOW TABLES LIKE 'visitors'");
        if ($result->num_rows == 0) {
            // Run installation
            $schema = file_get_contents(__DIR__ . '/schema.sql');
            $queries = array_filter(explode(';', $schema));
            
            foreach ($queries as $query) {
                if (trim($query)) {
                    $conn->query($query);
                }
            }
            
            error_log("Auto-installed database tables");
        }
    } catch (Exception $e) {
        error_log("Auto-install failed: " . $e->getMessage());
    }
}

// Run auto-check on include
checkAndInstallTables();
?>
