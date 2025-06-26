<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap');

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f2f2f2;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
            width: 100%;
        }

       .background {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('img/registerimage.jpg'); /* Path to your image */
            background-size: cover;
            background-position: center;
            z-index: -1;
        }

        .form-box {
            position: relative;
            padding: 40px;
            width: 400px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }

        .form-box h1 {
            margin-top: 0;
            font-size: 24px;
            color: #333;
            font-weight: 600;
            font-family: "Brush Script MT", cursive;
        }

        .form-box p {
            color: #666;
            margin-bottom: 20px;
        }

        .form-box input[type="text"],
        .form-box input[type="email"],
        .form-box input[type="password"] {
            width: 100%;
            padding: 12px 20px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        .form-box input[type="submit"] {
            width: 100%;
            background-color: #4CAF50;
            color: white;
            padding: 14px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-family: 'Poppins', sans-serif;
            font-weight: 500;
        }

        .form-box .login-link {
            text-align: center;
            margin-top: 20px;
            color: #666;
        }

        .form-box .login-link a {
            color: #4CAF50;
            text-decoration: none;
        }
        
        .error-message {
            color: red;
            margin-top: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="background"></div>
        <div class="form-box">
            <h1>Plan n Plate</h1>
            <p>Create your account</p>
            <form action="RegisterController?action=user" method="post" onsubmit="return validateEmail()">
                <input type="text" name="username" placeholder="Username">
                <input type="email" id="email" name="email" placeholder="Email Address">
                <input type="password" name="password" placeholder="Password">
                <input type="submit" value="Sign Up">
                <div class="login-link">
                    Already have an account? <a href="RegisterController?action=login">Sign In</a>
                </div>
                <div id="error-message" class="error-message"></div>
            </form>

            <c:forEach items="${users}" var="user">
                <input type="hidden" id="email_${user.email}" value="${user.email}">
            </c:forEach>
            <c:forEach items="${admins}" var="admin">
                <input type="hidden" id="email_${admin.email}" value="${admin.email}">
            </c:forEach>
        </div>
    </div>
    
    <script>
        function validateEmail() {
            var email = document.getElementById('email').value;
            var emails = [];
            <c:forEach items="${users}" var="user">
                emails.push("${user.email}");
            </c:forEach>
            <c:forEach items="${admins}" var="admin">
                emails.push("${admin.email}");
            </c:forEach>
            if (emails.includes(email)) {
                document.getElementById("error-message").innerText = "Email already used!";
                return false; // Prevent form submission
            }
            return true; // Allow form submission
        }
    </script>
</body>
</html>
