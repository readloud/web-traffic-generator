<?php
// login.php - Sistem login yang aman
session_start();
require_once 'config.php';
require_once 'database.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = filter_var($_POST['username'], FILTER_SANITIZE_STRING);
    $password = $_POST['password'];
    
    try {
        $conn = Database::getInstance();
        
        // Cek user
        $stmt = $conn->prepare("
            SELECT u.*, s.id as site_id 
            FROM users u 
            LEFT JOIN sites s ON u.site_id = s.id 
            WHERE u.username = ? AND u.is_active = 1
        ");
        $stmt->bind_param("s", $username);
        $stmt->execute();
        $result = $stmt->get_result();
        
        if ($result->num_rows === 1) {
            $user = $result->fetch_assoc();
            
            // Verifikasi password
            if (password_verify($password, $user['password_hash'])) {
                // Set session
                $_SESSION['admin'] = true;
                $_SESSION['user_id'] = $user['id'];
                $_SESSION['username'] = $user['username'];
                $_SESSION['role'] = $user['role'];
                $_SESSION['site_id'] = $user['site_id'];
                $_SESSION['login_time'] = time();
                
                // Update last login
                $stmt = $conn->prepare("UPDATE users SET last_login = NOW() WHERE id = ?");
                $stmt->bind_param("i", $user['id']);
                $stmt->execute();
                
                // Redirect berdasarkan role
                if ($user['role'] === 'superadmin') {
                    header('Location: admin.php?page=dashboard');
                } else {
                    header('Location: admin.php');
                }
                exit();
            }
        }
        
        $_SESSION['error'] = 'Username atau password salah';
        header('Location: login.php');
        exit();
        
    } catch (Exception $e) {
        $_SESSION['error'] = 'Terjadi kesalahan sistem';
        header('Location: login.php');
        exit();
    }
}
?>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Traffic Analytics</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .login-container {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 400px;
        }
        
        .logo {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .logo i {
            font-size: 3rem;
            color: #4361ee;
            margin-bottom: 10px;
        }
        
        .logo h1 {
            color: #333;
            font-size: 1.8rem;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
        }
        
        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #ddd;
            border-radius: 10px;
            font-size: 16px;
            transition: border-color 0.3s;
        }
        
        .form-group input:focus {
            outline: none;
            border-color: #4361ee;
        }
        
        .btn-login {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #4361ee 0%, #3f37c9 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(67, 97, 238, 0.3);
        }
        
        .error-message {
            background: #fee;
            color: #c33;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
            border: 1px solid #fcc;
        }
        
        .footer-links {
            margin-top: 20px;
            text-align: center;
            color: #666;
            font-size: 0.9rem;
        }
        
        .footer-links a {
            color: #4361ee;
            text-decoration: none;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="login-container">
        <div class="logo">
            <i class="fas fa-chart-line"></i>
            <h1>Traffic Analytics</h1>
        </div>
        
        <?php if (isset($_SESSION['error'])): ?>
            <div class="error-message">
                <?php echo $_SESSION['error']; unset($_SESSION['error']); ?>
            </div>
        <?php endif; ?>
        
        <form method="POST" action="">
            <div class="form-group">
                <label for="username"><i class="fas fa-user"></i> Username</label>
                <input type="text" id="username" name="username" required autofocus>
            </div>
            
            <div class="form-group">
                <label for="password"><i class="fas fa-lock"></i> Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <button type="submit" class="btn-login">
                <i class="fas fa-sign-in-alt"></i> Login
            </button>
        </form>
        
        <div class="footer-links">
            <p>© <?php echo date('Y'); ?> Traffic Analytics System</p>
        </div>
    </div>
</body>
</html>