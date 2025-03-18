<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Dairy Products</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(135deg, #71b7e6, #9b59b6);
            overflow: hidden;
        }

        .container {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
            text-align: center;
            animation: fadeIn 1s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }

        h2 {
            color: #333;
            font-size: 1.8rem;
            margin-bottom: 1.5rem;
        }

        .input-group {
            position: relative;
            margin-bottom: 1.2rem;
            width: 100%;
        }

        .input-group input {
            width: 100%;
            padding: 12px 40px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .input-group input:focus {
            border-color: #9b59b6;
            outline: none;
            box-shadow: 0 0 5px rgba(155, 89, 182, 0.5);
        }

        .input-group i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
        }

        .input-group i.toggle-password {
            left: auto;
            right: 12px;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .input-group i.toggle-password:hover {
            color: #9b59b6;
        }

        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.9rem;
            margin-bottom: 1.5rem;
        }

        .remember-forgot label {
            display: flex;
            align-items: center;
            color: #666;
        }

        .remember-forgot input[type="checkbox"] {
            margin-right: 5px;
        }

        .forgot-password {
            color: #9b59b6;
            text-decoration: none;
        }

        .forgot-password:hover {
            text-decoration: underline;
        }

        .btn {
            width: 100%;
            padding: 12px;
            background: #9b59b6;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        .btn:hover {
            background: #8e44ad;
            transform: scale(1.05);
        }

        .switch-text {
            margin-top: 1rem;
            color: #666;
        }

        .switch-text a {
            color: #9b59b6;
            text-decoration: none;
            font-weight: 600;
        }

        .switch-text a:hover {
            text-decoration: underline;
        }

        .error-message {
            color: #ff4444;
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Login</h2>

        <!-- Display error message if any -->
        <% if(request.getAttribute("error") != null) { %>
            <div class="error-message">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <form id="loginForm" action="loginform" method="POST">
            <div class="input-group">
                <i class="fas fa-envelope"></i>
                <input type="email" id="loginEmail" name="email" placeholder="Email" required>
            </div>
            <div class="input-group">
                <i class="fas fa-lock"></i>
                <input type="password" id="loginPassword" name="password" placeholder="Password" required>
                <i class="fas fa-eye toggle-password"></i>
            </div>
            <div class="remember-forgot">
                <label>
                    <input type="checkbox" id="rememberMe" name="rememberMe">
                    Remember me
                </label>
                <a href="forgot-password.jsp" class="forgot-password">Forgot Password?</a>
            </div>
            <button type="submit" class="btn">Login</button>
        </form>

        <p class="switch-text">Don't have an account? <a href="register.jsp">Register</a></p>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const togglePasswordButton = document.querySelector('.toggle-password');
            const passwordInput = document.getElementById('loginPassword');

            // Toggle password visibility
            togglePasswordButton.addEventListener('click', () => {
                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                    togglePasswordButton.classList.remove('fa-eye');
                    togglePasswordButton.classList.add('fa-eye-slash');
                } else {
                    passwordInput.type = 'password';
                    togglePasswordButton.classList.remove('fa-eye-slash');
                    togglePasswordButton.classList.add('fa-eye');
                }
            });
        });
    </script>
</body>
</html>
