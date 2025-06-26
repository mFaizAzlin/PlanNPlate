<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
response.addHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.addHeader("Cache-Control", "pre-check=0, post-check=0");
response.setDateHeader("Expires", 0);

if (session.getAttribute("sessionEmail") == null)
    response.sendRedirect("/PlanNPlate/login.jsp");
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Account</title>
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
        .close {
            position: absolute;
            top: -10px;
            right: -10px;
            background: #fff;
            height: 60px;
            width: 60px;
            border-radius: 50%;
            box-shadow: 6px 6px 29px -4px rgba(0,0,0,0,0.75);
            cursor: pointer;
        }
        .popup {
            background: rgba(0,0,0,0.6);
            position: absolute;
            display: none;
            justify-content: center;
            align-items: center;
        }
        
        .close2 {
            position: absolute;
            top: -10px;
            right: -10px;
            background: #fff;
            height: 60px;
            width: 60px;
            border-radius: 50%;
            box-shadow: 6px 6px 29px -4px rgba(0,0,0,0,0.75);
            cursor: pointer;
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
        <a href="index.jsp">
            <img src="img/close2.png" class="close">
        </a>
            <h1>Plan n Plate</h1>
            <p>Create your account</p>
            <form action="UserController?action=updateUser2" method="post" onsubmit="return validateEmail()">
                <input type="hidden" name="userid" value="<c:out value="${user.userid}"/>">
                <input type="hidden" name="adminId" value="<c:out value="${user.adminID}"/>">
                Username:
                <input type="text" name="username" value="<c:out value="${user.username}" />">
                Email:
                <input type="email" id="email" name="email" value="<c:out value="${user.email}"/>">
                <div id="error-message" class="error-message"></div>
                <div class="login-link">
                    Want to change password? <a href="#" class="button btn btn-primary rounded-pill" id="button">Change Password</a>
                </div><br>
                <input type="submit" value="Update">
            </form>
        </div>
        <c:forEach items="${users}" var="user">
                <input type="hidden" id="email_${user.email}" value="${user.email}">
            </c:forEach>
            <c:forEach items="${admins}" var="admin">
                <input type="hidden" id="email_${admin.email}" value="${admin.email}">
            </c:forEach>
        <!-- Pop up Start -->
        <div class="popup">
            <div class="popup-content">
                <div class="form-box">
                    <img src="img/close2.png" alt="Close" class="close2">
                    <h1>Plan n Plate</h1>
                    <p>Change your password</p>
                    <form action="UserController?action=updateUser2" method="post" onsubmit="return validatePasswords()">
                        <input type="hidden" name="userid" value="<c:out value="${user.userid}"/>">
		                <input type="hidden" name="adminId" value="<c:out value="${user.adminID}"/>">
		                <input type="hidden" name="username" value="<c:out value="${user.username}" />">
		                <input type="hidden" name="email" value="<c:out value="${user.email}"/>">
                        <div id="password">
                            Password:
                            <input type="password" id="password1" name="password">
                            Confirm Password:
                            <input type="password" id="password2" name="password">
                        </div>
                        <div class="show-password">
                            <input type="checkbox" id="showPassword" onclick="togglePassword()">
                            <label for="showPassword">Show Password</label>
                        </div><br><br>
                        <span id="error" class="error-message"></span>
                        <input type="submit" value="Update">
                    </form>    
                </div>                    
            </div>
        </div>
        <!-- Pop up End -->
    </div>
    <script>
        document.getElementById("button").addEventListener("click", function(){
            document.querySelector(".popup").style.display = "flex";
        });
        
        document.querySelector(".close2").addEventListener("click", function() {
            document.querySelector(".popup").style.display = "none";
        });

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
        
        function validatePasswords() {
            var password1 = document.getElementById("password1").value;
            var password2 = document.getElementById("password2").value;
            if (password1 !== password2) {
                document.getElementById("error").innerText = "Passwords do not match!";
                return false; // Prevent form submission
            }
            return true; // Allow form submission
        }

        function togglePassword() {
            var password1 = document.getElementById("password1");
            var password2 = document.getElementById("password2");
            if (password1.type === "password") {
                password1.type = "text";
                password2.type = "text";
            } else {
                password1.type = "password";
                password2.type = "password";
            }
        }
    </script>
</body>
</html>
