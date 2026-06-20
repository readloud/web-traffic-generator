<?php
// track.php - Script untuk melacak traffic
header('Content-Type: application/javascript');

// Koneksi database
$conn = new mysqli('localhost', 'username', 'password', 'traffic_db');

// Ambil data pengunjung
$ip_address = $_SERVER['REMOTE_ADDR'];
$user_agent = $_SERVER['HTTP_USER_AGENT'];
$referrer = isset($_SERVER['HTTP_REFERER']) ? $_SERVER['HTTP_REFERER'] : 'Direct';
$page_url = isset($_GET['url']) ? $_GET['url'] : $_SERVER['HTTP_HOST'];

// Simpan ke database
$stmt = $conn->prepare("INSERT INTO visitors (ip_address, user_agent, referrer, page_url) VALUES (?, ?, ?, ?)");
$stmt->bind_param("ssss", $ip_address, $user_agent, $referrer, $page_url);
$stmt->execute();

// Generate backlink otomatis
if (rand(1, 100) <= 30) { // 30% chance untuk generate backlink
    generateAutoBacklink($page_url, $conn);
}

function generateAutoBacklink($url, $conn) {
    $backlink_urls = [
        "https://blogspot.com/" . generateRandomString(),
        "https://wordpress.com/" . generateRandomString(),
        "https://medium.com/" . generateRandomString()
    ];
    
    $selected_url = $backlink_urls[array_rand($backlink_urls)];
    $backlink_code = generateBacklinkCode($url);
    
    $stmt = $conn->prepare("INSERT INTO backlinks (url, backlink_code, status) VALUES (?, ?, 'active')");
    $stmt->bind_param("ss", $selected_url, $backlink_code);
    $stmt->execute();
}

function generateRandomString($length = 10) {
    return substr(str_shuffle("0123456789abcdefghijklmnopqrstuvwxyz"), 0, $length);
}

function generateBacklinkCode($target_url) {
    return '<a href="' . htmlspecialchars($target_url) . '" rel="dofollow">Visit Website</a>';
}
?>

// JavaScript untuk pelacakan real-time
(function() {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', 'track.php?url=' + encodeURIComponent(window.location.href), true);
    xhr.send();
})();
