	<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%
  response.addHeader("Pragma", "no-cache");
  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
  response.addHeader("Cache-Control", "pre-check=0, post-check=0");
  response.setDateHeader("Expires", 0);
  
  %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
@import
	url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap')
	;

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
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
	overflow: hidden;
}

.login-box {
	padding: 40px;
	width: 400px;
}

.login-box h1 {
	margin-top: 0;
	font-size: 24px;
	color: #333;
	font-weight: 600;
	font-family: "Brush Script MT", cursive;
}

.login-box p {
	color: #666;
	margin-bottom: 20px;
}

.login-box input[type="email"], .login-box input[type="password"] {
	width: 100%;
	padding: 12px 20px;
	margin-bottom: 20px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
	font-family: 'Poppins', sans-serif;
}

.login-box .remember-forgot {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.login-box .sign-in {
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

.login-box .signup-link {
	text-align: center;
	margin-top: 20px;
	color: #666;
}

.login-box .signup-link a {
	color: #4CAF50;
	text-decoration: none;
}

.image-box {
	position: relative;
	width: 600px;
	height: 500px;
}

.image-box img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}
</style>
</head>
<body>
    <div class="container">
        <div class="login-box">
            <h1>Plan n Plate</h1>
            <p>Welcome Back</p>
            <p>Sign in with your email address and Password.</p>
            <form action="LoginController" method="POST">
	            <input type="email" name="email" placeholder="Email Address">
	            <input type="password" name="password" placeholder="Password">
	            <div class="remember-forgot">
	                <label>
	                    <input type="checkbox"> Remember me
	                </label>
	                <a href="#">Forgot Password?</a>
	            </div>
	            <div >
	            	<input type="submit" class="sign-in" value="sign in"> 
	            </div>
	            <div class="signup-link">
	                Don't have an account? <a href="LoginController?action=register">Sign Up</a>
	            </div>
	        </form>
        </div>
        <div class="image-box"></div>
    </div>
    <script>
        // Replace '/images/loginimage.jpg' with the correct path or URL of your image
		const imageUrl = "img/loginimage.jpg";

        // Get the image box element
        const imageBox = document.querySelector('.image-box');

        // Create a new image element
        const image = new Image();

        // Set the src attribute of the image element
        image.src = imageUrl;

        // Append the image element to the image box
        imageBox.appendChild(image);
    </script>
</body>
</html>