<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
response.addHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.addHeader("Cache-Control", "pre-check=0, post-check=0");
response.setDateHeader("Expires", 0);

if (session.getAttribute("sessionEmail") == null)
	//response.sendRedirect("/PlanNPlate/login.jsp");
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Kaiadmin - Bootstrap 5 Admin Dashboard</title>
<meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
	name="viewport" />
<link rel="icon" href="assets/img/kaiadmin/favicon.ico"
	type="image/x-icon" />

<!-- Fonts and icons -->
<script src="assets/js/plugin/webfont/webfont.min.js"></script>
<script>
	WebFont.load({
		google : {
			families : [ "Public Sans:300,400,500,600,700" ]
		},
		custom : {
			families : [ "Font Awesome 5 Solid", "Font Awesome 5 Regular",
					"Font Awesome 5 Brands", "simple-line-icons", ],
			urls : [ "assets/css/fonts.min.css" ],
		},
		active : function() {
			sessionStorage.fonts = true;
		},
	});
</script>

<style>

/* Logo Header */
.sidebar-logo {
	display: flex;
	flex-direction: column; /* Stack logo and text vertically */
	align-items: center; /* Center items horizontally */
	padding: 15px; /* Add padding around the logo */
	position: relative; /* Position for absolute children */
}

/* Logo Image */
.logo-img {
	width: 35px; /* Adjust size as needed */
	height: auto; /* Maintain aspect ratio */
	display: block; /* Make image a block element */
	margin-bottom: 10px; /* Space between image and text */
}

.user-greeting {
	font-size: 24px; /* Adjust text size */
	font-weight: bold; /* Make text bold */
	color: #ffcc00; /* Custom color */
	font-family: "Brush Script MT", cursive;
	display: block; /* Make text block element */
	text-align: center; /* Center text */
}

.container {
	position: relative;
	/* Establishes a positioning context for the button */
}

#passwordForm {
	position: absolute;
	bottom: 0;
	right: 0;
	margin: 20px; /* Optional: Adds some margin around the button */
}

.btn-round {
	border-radius: 50px; /* Optional: Makes the button round */
}

/* Popup background and layout */
.popup {
    background: rgba(0, 0, 0, 0.6); /* Semi-transparent background */
    position: fixed; /* Fixed position to stay in the same place even when scrolling */
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    display: none; /* Hidden by default */
    justify-content: center; /* Center content horizontally */
    align-items: center; /* Center content vertically */
    z-index: 1000; /* Ensure the popup is on top of other content */
}

/* Popup content styling */
.popup-content {
    background: #fff; /* White background for the popup */
    border-radius: 8px; /* Rounded corners */
    padding: 20px; /* Space inside the popup */
    max-width: 500px; /* Maximum width of the popup */
    width: 90%; /* Width of the popup */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Subtle shadow for a lifted effect */
    position: relative; /* Position relative for the close button */
}

/* Popup header styling */
.popup-header {
    display: flex; /* Flexbox layout for the header */
    justify-content: space-between; /* Space between title and close button */
    align-items: center; /* Center items vertically */
    border-bottom: 1px solid #ddd; /* Divider between header and body */
    padding-bottom: 10px; /* Padding at the bottom of the header */
    margin-bottom: 15px; /* Margin below the header */
}

.popup-title {
    font-size: 1.5em; /* Larger font size for the title */
    font-weight: bold; /* Bold text for the title */
}

/* Close button styling */
.close2 {
    background: #fff; /* White background for the close button */
    height: 30px;
    width: 30px;
    border-radius: 50%;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2); /* Subtle shadow */
    cursor: pointer; /* Pointer cursor on hover */
    display: flex; /* Center the icon inside the button */
    justify-content: center;
    align-items: center;
    font-size: 20px; /* Size of the close icon */
    color: #333; /* Color of the close icon */
    text-align: center; /* Center the icon */
}

.close2::before {
    content: '×'; /* Close icon character */
}

/* Popup body styling */
.popup-body {
    font-size: 1em; /* Font size for the body text */
}

/* Form group styling */
.form-group {
    margin-bottom: 15px; /* Space between form fields */
}

.form-group label {
    display: block; /* Make labels block elements */
    margin-bottom: 5px; /* Space below the label */
    font-weight: bold; /* Bold text for labels */
}

.form-group input {
    width: 100%; /* Full width input fields */
    padding: 8px; /* Padding inside input fields */
    border: 1px solid #ccc; /* Border color */
    border-radius: 4px; /* Rounded corners for input fields */
}

/* Error message styling */
.error {
    color: red; /* Red color for error messages */
    font-size: 0.875em;  /* Slightly smaller font size */
    display: block; /* Block display to separate from other elements */
    margin-top: 10px; /* Space above the error message */
}

/* Form actions styling */
.form-actions {
    text-align: right; /* Align buttons to the right */
}

.form-actions input[type="submit"] {
    background-color: #007bff; /* Primary button color */
    color: #fff; /* Text color */
    border: none; /* Remove border */
    padding: 10px 20px; /* Padding for the button */
    border-radius: 4px; /* Rounded corners */
    cursor: pointer; /* Pointer cursor on hover */
}

.form-actions input[type="submit"]:hover {
    background-color: #0056b3; /* Darker shade on hover */
}

</style>

<!-- CSS Files -->
<link rel="stylesheet" href="assets/css/bootstrap.min.css" />
<link rel="stylesheet" href="assets/css/plugins.min.css" />
<link rel="stylesheet" href="assets/css/kaiadmin.min.css" />

<!-- CSS Just for demo purpose, don't include it in your project -->
<link rel="stylesheet" href="assets/css/demo.css" />
</head>
<body>
	<div class="wrapper">
		<!-- Sidebar -->
		<div class="sidebar" data-background-color="dark">
			<div class="sidebar-logo">
				<!-- Logo Header -->
				<div class="logo-header" data-background-color="dark">
					<a href="../index.html" class="logo"> <img
						src="assets/img/kaiadmin/logo_light.svg" alt="navbar brand"
						class="navbar-brand" height="20" />
					</a>
					<div class="nav-toggle">
						<button class="btn btn-toggle toggle-sidebar">
							<i class="gg-menu-right"></i>
						</button>
						<button class="btn btn-toggle sidenav-toggler">
							<i class="gg-menu-left"></i>
						</button>
					</div>
					<button class="topbar-toggler more">
						<i class="gg-more-vertical-alt"></i>
					</button>
				</div>
				<!-- End Logo Header -->
			</div>
			<div class="sidebar-wrapper scrollbar scrollbar-inner">
				<div class="sidebar-content">
					<ul class="nav nav-secondary">
						<li class="nav-item"><a
							href="AdminController?action=dashboard&adminID=<c:out value="${sessionId}" />">
								<i class="fas fa-home"></i>
								<p>Dashboard</p>
						</a></li>
						<li class="nav-section"><span class="sidebar-mini-icon">
								<i class="fa fa-ellipsis-h"></i>
						</span>
							<h4 class="text-section">Table</h4></li>
						<li class="nav-item"><a
							href="AdminController?action=list&adminID=<c:out value="${sessionId}" />">
								<i class="fas fa-user"></i>
								<p>Admin</p>
						</a></li>
						<li class="nav-item active"><a
							href="UserController?action=listUser&adminID=<c:out value="${sessionId}" />">
								<i class="fas fa-users"></i>
								<p>User</p>
						</a></li>
						<li class="nav-item"><a
							href="AdminRecipeController?action=listRecipeAdmin&adminID=<c:out value="${sessionId}" />">
								<i class="fas fa-utensils"></i>
								<p>Recipe</p>
						</a></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- End Sidebar -->

		<div class="main-panel">
			<div class="main-header">
				<div class="main-header-logo">
					<!-- Logo Header -->
					<div class="logo-header" data-background-color="dark">
						<a href="../index.html" class="logo"> <img
							src="assets/img/kaiadmin/logo_light.svg" alt="navbar brand"
							class="navbar-brand" height="20" />
						</a>
						<div class="nav-toggle">
							<button class="btn btn-toggle toggle-sidebar">
								<i class="gg-menu-right"></i>
							</button>
							<button class="btn btn-toggle sidenav-toggler">
								<i class="gg-menu-left"></i>
							</button>
						</div>
						<button class="topbar-toggler more">
							<i class="gg-more-vertical-alt"></i>
						</button>
					</div>
					<!-- End Logo Header -->
				</div>
				<!-- Navbar Header -->
				<nav
					class="navbar navbar-header navbar-header-transparent navbar-expand-lg border-bottom">
					<div class="container-fluid">
						<nav
							class="navbar navbar-header-left navbar-expand-lg navbar-form nav-search p-0 d-none d-lg-flex">

							<h3 class="fw-bold mb-3">Plan n Plate</h3>

						</nav>

						<ul class="navbar-nav topbar-nav ms-md-auto align-items-center">

							<li
								class="nav-item topbar-icon dropdown hidden-caret d-flex d-lg-none">
							<li class="nav-item topbar-user dropdown hidden-caret"><a
								class="dropdown-toggle profile-pic" data-bs-toggle="dropdown"
								href="#" aria-expanded="false">
									<div class="avatar-sm">
										<img
											src="data:image/jpg;base64,<c:out value="${admin.image}" />"
											alt="" class="avatar-img rounded-circle" />
									</div> <span class="profile-username"> <span class="op-7">Hi,</span>
										<span class="fw-bold">${admin.name}</span>
								</span>
							</a>
								<ul class="dropdown-menu dropdown-user animated fadeIn">
									<div class="dropdown-user-scroll scrollbar-outer">
										<li>
											<div class="user-box">
												<div class="avatar-lg">
													<img
														src="data:image/jpg;base64,<c:out value="${admin.image}" />"
														alt="" class="avatar-img rounded" />
												</div>
												<div class="u-text">
													<h4>${admin.name}</h4>
													<p class="text-muted">${sessionEmail}</p>
												</div>
											</div>
										</li>
										<li>
											<div class="dropdown-divider"></div> <a class="dropdown-item"
											href="AdminController?action=viewprofile&adminID=<c:out value="${sessionId}" />">My
												Profile</a>
											<div class="dropdown-divider"></div> <a class="dropdown-item"
											href="LogoutController">Logout</a>
										</li>
									</div>
								</ul></li>
						</ul>
					</div>
				</nav>
				<!-- End Navbar -->
			</div>

			<div class="container">
				<div class="page-inner">
					<div class="page-header">
						<ul class="breadcrumbs mb-3"></ul>
					</div>
					<div class="row">
						<div class="col-md-12">
							<div class="card">
								<div class="card-header">
									<div class="d-flex justify-content-between align-items-center">
										<h5 class="card-title">Edit User</h5>
										<a
											href="UserController?action=viewUser&userid=<c:out value="${user.userid}" />&adminID=<c:out value="${sessionId}" />"
											class="btn btn-primary btn-round">Back</a>
									</div>
								</div>
								<div class="card-body">
									<form action="AdminUserController?action=admin" method="POST">
										<div class="mb-3">
											<label for="userid" class="form-label">User Id</label> <input
												type="number" class="form-control" id="userid" name="userid"
												value="<c:out value="${user.userid}"/>" readonly>
										</div>
										<div class="mb-3">
											<label for="username" class="form-label">Name</label> <input
												type="text" class="form-control" id="username"
												name="username" value="<c:out value="${user.username}"/>">
										</div>
										<div class="mb-3">
											<label for="email" class="form-label">Email</label> <input
												type="email" class="form-control" id="email" name="email"
												value="<c:out value="${user.email}"/>">
										</div>
										<div class="mb-5"></div>
										<div class="mb-3 d-flex justify-content-between">
											<input type="text" name="adminID"
												value="<c:out value="${sessionId}" />"> <input
												type="submit" class="btn btn-primary" value="Submit">
											<button type="button" id="button"
												class="btn btn-warning btn-round">Change Password</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Popup Start -->
<div class="popup">
    <div class="popup-content">
        <div class="popup-header">
            <span class="popup-title">Plan n Plate</span>
            <span class="close2" aria-label="Close"></span>
        </div>
        <div class="popup-body">
            <p>Change your password</p>
            <form action="UserController?action=admin" method="post" onsubmit="return validatePasswords()">
                <input type="hidden" name="userid" value="<c:out value="${user.userid}"/>">
                <input type="hidden" name="adminId" value="<c:out value="${user.adminID}"/>">
                <input type="hidden" name="username" value="<c:out value="${user.username}" />">
                <input type="hidden" name="email" value="<c:out value="${user.email}"/>">
                <input type="hidden" name="session" value="<c:out value="${sessionId}"/>">

                <div class="form-group">
                    <label for="password1">Password:</label>
                    <input type="password" id="password1" name="password" required>
                </div>

                <div class="form-group">
                    <label for="password2">Confirm Password:</label>
                    <input type="password" id="password2" name="password" required>
                </div>

                <span id="error-message" class="error"></span>
                
                <div class="form-actions">
                    <input type="submit" value="Update">
                </div>
            </form>
        </div>
    </div>
</div>
<!-- Popup End -->




		<footer class="footer">
			<div class="container-fluid d-flex justify-content-between">
				<nav class="pull-left">
					<ul class="nav">
						<li class="nav-item"><a class="nav-link"
							href="http://www.themekita.com"> ThemeKita </a></li>
						<li class="nav-item"><a class="nav-link" href="#"> Help </a></li>
						<li class="nav-item"><a class="nav-link" href="#">
								Licenses </a></li>
					</ul>
				</nav>
				<div class="copyright">
					2024, made with <i class="fa fa-heart heart text-danger"></i> by <a
						href="http://www.themekita.com">ThemeKita</a>
				</div>
				<div>
					Distributed by <a target="_blank" href="https://themewagon.com/">ThemeWagon</a>.
				</div>
			</div>
		</footer>
	</div>

	<!--   Core JS Files   -->
	<script src="assets/js/core/jquery-3.7.1.min.js"></script>
	<script src="assets/js/core/popper.min.js"></script>
	<script src="assets/js/core/bootstrap.min.js"></script>

	<!-- jQuery Scrollbar -->
	<script src="assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

	<!-- Chart JS -->
	<script src="assets/js/plugin/chart.js/chart.min.js"></script>

	<!-- jQuery Sparkline -->
	<script src="assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js"></script>

	<!-- Chart Circle -->
	<script src="assets/js/plugin/chart-circle/circles.min.js"></script>

	<!-- Datatables -->
	<script src="assets/js/plugin/datatables/datatables.min.js"></script>

	<!-- Bootstrap Notify -->
	<script src="assets/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>

	<!-- jQuery Vector Maps -->
	<script src="assets/js/plugin/jsvectormap/jsvectormap.min.js"></script>
	<script src="assets/js/plugin/jsvectormap/world.js"></script>

	<!-- Google Maps Plugin -->
	<script src="assets/js/plugin/gmaps/gmaps.js"></script>

	<!-- Sweet Alert -->
	<script src="assets/js/plugin/sweetalert/sweetalert.min.js"></script>

	<!-- Kaiadmin JS -->
	<script src="assets/js/kaiadmin.min.js"></script>

	<script>
        document.getElementById("button").addEventListener("click", function(){
            document.querySelector(".popup").style.display = "flex";
        });
        
        document.querySelector(".close2").addEventListener("click", function() {
            document.querySelector(".popup").style.display = "none";
        });

        function validatePasswords() {
            var password1 = document.getElementById("password1").value;
            var password2 = document.getElementById("password2").value;
            if (password1 !== password2) {
                document.getElementById("error-message").innerText = "Passwords do not match!";
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
