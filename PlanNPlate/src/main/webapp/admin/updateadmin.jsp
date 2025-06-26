<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

/* General styles for both popups */
.popup {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 90%;
    max-width: 500px;
    background: #fff;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    z-index: 1000;
    border-radius: 10px;
    display: none; /* Initially hidden */
}

.popup-content {
    padding: 20px;
    text-align: center;
}

.popup-content .close,
.popup-header .close2 {
    position: absolute;
    top: 15px;
    right: 15px;
    cursor: pointer;
    width: 24px;
    height: 24px;
}

.popup-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-bottom: 10px;
    border-bottom: 1px solid #ccc;
    margin-bottom: 20px;
}

.popup-header .popup-title {
    font-size: 24px;
    font-weight: bold;
}

.popup-body {
    text-align: left;
}

/* Form styles */
form .form-group {
    margin-bottom: 15px;
}

form .form-group label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
}

form .form-group input[type="password"],
form .form-group input[type="file"] {
    width: calc(100% - 20px);
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    margin: 0 auto;
}

form .form-actions {
    text-align: right;
}

form .form-actions input[type="submit"] {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 10px 20px; 
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
}

form .form-actions input[type="submit"]:hover {
    background-color: #0056b3;
}

.error {
    color: red;
    font-size: 12px;
}

/* Overlay to darken background */
.overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    z-index: 500;
    display: none; /* Initially hidden */
}

/* Make popups visible when triggered */
.popup.show,
.overlay.show {
    display: block;
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
						<li class="nav-item active"><a
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
						<li class="nav-item"><a
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
						<ul class="breadcrumbs mb-3">

						</ul>
					</div>
					<div class="row">
						<div class="col-md-12">
							<div class="card">
								<div class="card-header">
									<div
										class="card-header d-flex justify-content-between align-items-center">
										<h5 class="card-title">Edit Profile</h5>
										<a
											href="AdminController?action=viewprofile&adminID=<c:out value="${sessionScope.sessionId}" />"
											class="btn btn-primary btn-round"> back </a>
									</div>
								</div>
								<div class="card-body">
									<div class="mb-3"
										style="display: flex; justify-content: start; align-items: center;">
										<img
											src="data:image/jpg;base64,<c:out value="${admin.image}" />"
											alt=""
											style="width: 300px; height: auto; margin-right: 10px;">

										<button type="button" id="button1"
											class="btn btn-warning ml-3">Change Image</button>
									</div>
									<form action="AdminController" method="POST"
										enctype="multipart/form-data">
										<div class="mb-3">
											<label for="recipeid" class="form-label">Admin Id</label> <input
												type="number" class="form-control" id="adminID"
												name="adminID" value="<c:out value="${admin.adminID}"/>"
												readonly>
										</div>
										<div class="mb-3">
											<label for="title" class="form-label">Name </label> <input
												type="text" class="form-control" id="name" name="name"
												value="<c:out value="${admin.name}"/>">
										</div>

										<div class="mb-3">
											<label for="tag" class="form-label">Email </label> <input
												type="email" class="form-control" id="email" name="email"
												value="<c:out value="${admin.email}"/>">
										</div>
										<div class="mb-3">
											<label for="ingredient" class="form-label">Phone
												Number </label> <input type="text" class="form-control"
												id="phonenum" name="phonenum"
												value="<c:out value="${admin.phonenum}"/>">
										</div>
										<div class="mb-3">
											<label for="instruction" class="form-label">Address </label>
											<input type="text" class="form-control" id="address"
												name="address" value="<c:out value="${admin.address}"/>">
										</div>
										<div class="mb-3">
											<label for="instruction" class="form-label">Quote </label> <input
												type="text" class="form-control" id="quote" name="quote"
												value="<c:out value="${admin.quote}"/>">
										</div>
										<div class="mb-3 d-flex justify-content-between">
											<input type="submit" class="btn btn-primary" value="Submit">
									</form>
									<button type="button" id="button2" class="btn btn-warning ml-3">Change
										Password</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

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


	<!-- Overlay -->
	<div class="overlay" id="overlay"></div>

	<!-- Popup 1 Start -->
	<div class="popup" id="popup1">
		<div class="popup-content">
			<img src="img/close.png" alt="Close" class="close" id="close1">
			<form action="AdminController" method="post"
				enctype="multipart/form-data">
				<div class="col-12 text-center">
					<input type="hidden" name="adminID"
						value="<c:out value="${admin.adminID}" />"> <input
						class="form-control border-primary p-2" type="file" name="image"
						style="margin-top: 30px;"> <input type="submit"
						class="btn btn-primary px-5 py-3 rounded-pill"
						value="Change Image" style="margin-top: 20px;">
				</div>
			</form>
		</div>
	</div>
	<!-- Popup 1 End -->

	<!-- Popup 2 Start -->
	<div class="popup" id="popup2">
		<div class="popup-content">
			<div class="popup-header">
				<span class="popup-title">Plan n Plate</span> <span class="close2"
					id="close2" aria-label="Close">&times;</span>
			</div>
			<div class="popup-body">
				<p>Change your password</p>
				<form action="AdminController" method="post"
					onsubmit="return validatePasswords()" enctype="multipart/form-data">
					<input type="hidden" name="adminID"
						value="<c:out value="${admin.adminID}" />"> <input
						type="hidden" name="name" value="<c:out value="${admin.name}" />">
					<input type="hidden" name="email"
						value="<c:out value="${admin.email}" />">

					<div class="form-group">
						<label for="password1">Password:</label> <input type="password"
							id="password1" name="password" required>
					</div>

					<div class="form-group">
						<label for="password2">Confirm Password:</label> <input
							type="password" id="password2" name="password" required>
					</div>

					<span id="error-message" class="error"></span>

					<div class="form-actions">
						<input type="submit" value="Update">
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- Popup 2 End -->


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

	<script src="js/main.js"></script>

	<script>
document.addEventListener('DOMContentLoaded', function() {
    // Get elements
    var overlay = document.getElementById('overlay');
    var popup1 = document.getElementById('popup1');
    var popup2 = document.getElementById('popup2');
    var close1 = document.getElementById('close1');
    var close2 = document.getElementById('close2');
    var button1 = document.getElementById('button1');
    var button2 = document.getElementById('button2');

    // Function to show popup
    function showPopup(popup) {
        overlay.classList.add('show');
        popup.classList.add('show');
    }

    // Function to hide popup
    function hidePopup() {
        overlay.classList.remove('show');
        popup1.classList.remove('show');
        popup2.classList.remove('show');
    }

    // Event listeners for showing popups
    button1.addEventListener('click', function() {
        showPopup(popup1);
    });

    button2.addEventListener('click', function() {
        showPopup(popup2);
    });

    // Event listeners for closing popups
    close1.addEventListener('click', hidePopup);
    close2.addEventListener('click', hidePopup);
    overlay.addEventListener('click', hidePopup);

    // Password validation
    document.querySelector("form[onsubmit]").addEventListener("submit", function(event) {
        var password1 = document.getElementById("password1").value;
        var password2 = document.getElementById("password2").value;
        if (password1 !== password2) {
            document.getElementById("error-message").innerText = "Passwords do not match!";
            event.preventDefault(); // Prevent form submission
        }
    });

    // Toggle password visibility
    document.getElementById("toggle-password").addEventListener('click', function() {
        var password1 = document.getElementById("password1");
        var password2 = document.getElementById("password2");
        if (password1.type === "password") {
            password1.type = "text";
            password2.type = "text";
        } else {
            password1.type = "password";
            password2.type = "password";
        }
    });
});
</script>

</body>
</html>
