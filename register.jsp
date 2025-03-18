<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dairy Products - Register</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: linear-gradient(135deg, #71b7e6, #9b59b6);
        }

        .container {
            background: white;
            padding: 2rem;
            border-radius: 20px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }

        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 2rem;
            font-size: 1.8rem;
        }

        .input-group {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .input-group input {
            width: 100%;
            padding: 12px 40px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .input-group input:focus {
            border-color: #9b59b6;
            outline: none;
            box-shadow: 0 0 0 2px rgba(155, 89, 182, 0.2);
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
        }

        .btn {
            width: 100%;
            padding: 12px;
            background: #9b59b6;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 1rem;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .btn:hover {
            background: #8e44ad;
        }

        .switch-text {
            text-align: center;
            margin-top: 1.5rem;
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
            font-size: 0.8rem;
            margin-top: 5px;
            text-align: center;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Create Account</h2>
        
        <!-- Display error message if any -->
        <% if(request.getAttribute("error") != null) { %>
            <div class="error-message">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
        
        <form id="registerForm" action="registerform" method="POST">
            <div class="input-group">
                <i class="fas fa-user"></i>
                <input type="text" id="registerName" name="fullName" placeholder="Full Name" required>
            </div>
            <div class="input-group">
                <i class="fas fa-envelope"></i>
                <input type="email" id="registerEmail" name="email" placeholder="Email" required>
            </div>
            <div class="input-group">
                <i class="fas fa-lock"></i>
                <input type="password" id="registerPassword" name="password" placeholder="Password" required>
                <i class="fas fa-eye toggle-password"></i>
            </div>
            <div class="input-group">
                <i class="fas fa-lock"></i>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required>
                <i class="fas fa-eye toggle-password"></i>
            </div>
            <button type="submit" class="btn">Register</button>
        </form>
        <p class="switch-text">Already have an account? <a href="login.jsp">Login</a></p>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const togglePasswordButtons = document.querySelectorAll('.toggle-password');
            const registerForm = document.getElementById('registerForm');

            // Toggle password visibility
            togglePasswordButtons.forEach(button => {
                button.addEventListener('click', () => {
                    const input = button.previousElementSibling;
                    if (input.type === 'password') {
                        input.type = 'text';
                        button.classList.remove('fa-eye');
                        button.classList.add('fa-eye-slash');
                    } else {
                        input.type = 'password';
                        button.classList.remove('fa-eye-slash');
                        button.classList.add('fa-eye');
                    }
                });
            });

            // Form validation
            registerForm.addEventListener('submit', (e) => {
                const name = document.getElementById('registerName');
                const email = document.getElementById('registerEmail');
                const password = document.getElementById('registerPassword');
                const confirmPassword = document.getElementById('confirmPassword');
                let isValid = true;

                // Validate name
                if (name.value.trim().length < 2) {
                    e.preventDefault();
                    showError(name, 'Name must be at least 2 characters long');
                    isValid = false;
                }

                // Validate email
                if (!validateEmail(email.value)) {
                    e.preventDefault();
                    showError(email, 'Please enter a valid email address');
                    isValid = false;
                }

                // Validate password
                if (password.value.length < 8) {
                    e.preventDefault();
                    showError(password, 'Password must be at least 8 characters long');
                    isValid = false;
                }

                // Validate password confirmation
                if (password.value !== confirmPassword.value) {
                    e.preventDefault();
                    showError(confirmPassword, 'Passwords do not match');
                    isValid = false;
                }
            });

            function validateEmail(email) {
                const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                return re.test(email);
            }

            function showError(input, message) {
                const errorDiv = document.createElement('div');
                errorDiv.className = 'error-message';
                errorDiv.textContent = message;
                input.parentElement.appendChild(errorDiv);
                setTimeout(() => errorDiv.remove(), 3000);
            }
        });
    </script>
</body>
</html>