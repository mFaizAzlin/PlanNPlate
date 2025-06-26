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
							 <i
								class="fas fa-home"></i>
								<p>Dashboard</p>
						</a></li>
						<li class="nav-section"><span class="sidebar-mini-icon">
								<i class="fa fa-ellipsis-h"></i>
						</span>
							<h4 class="text-section">Table</h4></li>
						<li class="nav-item"><a 
						href="AdminController?action=list&adminID=<c:out value="${sessionId}" />">
						<i
								class="fas fa-user"></i>
								<p>Admin</p>
						</a></li>
						<li class="nav-item active"><a
							href="UserController?action=listUser&adminID=<c:out value="${sessionId}" />">
							 <i
								class="fas fa-users"></i>
								<p>User</p>
						</a></li>
						<li class="nav-item"><a
							href="AdminRecipeController?action=listRecipeAdmin&adminID=<c:out value="${sessionId}" />">
							 <i
								class="fas fa-utensils"></i>
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
										<h4 class="card-title">Create User</h4>
										<form id="userForm" action="RegisterController?action=admin" method="POST">
											<input type="reset" class="btn btn-primary" value="Reset">
									</div>
								</div>
								<div class="card-body">
									<div class="mb-3">
										<label for="username" class="form-label">Username</label> <input
											type="text" class="form-control" id="username"
											name="username" placeholder="Fill Username">
									</div>
									<div class="mb-3">
										<label for="email" class="form-label">Email</label> <input
											type="email" class="form-control" id="email" name="email"
											placeholder="Fill Email">
									</div>
									<div class="mb-3">
										<label for="password" class="form-label">Password</label> <input
											type="password" class="form-control" id="password"
											name="password" placeholder="Fill Password">
									</div>
									<div class="mb-3">
										<label for="confirmpassword" class="form-label">Confirm
											Password</label> <input type="password" class="form-control"
											id="confirmpassword" name="confirmpassword"
											placeholder="Confirm Password">
									</div>
									<input type="hidden" name="adminId" value="1">
									<div class="mb-3">
										<input type="submit" class="btn btn-success" value="Submit">
										<a href="UserController?action=listUser&adminID=<c:out value="${sessionId}" />"
											class="btn btn-danger"> cancel </a>
									</div>
									</form>
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
							<li class="nav-item"><a class="nav-link" href="#"> Help
							</a></li>
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

	</div>

	<div class="modal fade" id="errorModal" tabindex="-1"
		aria-labelledby="errorModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="errorModalLabel">Error!</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p id="errorMessage">Passwords do not match. Please try again.</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
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
		document.getElementById('userForm').addEventListener(
				'submit',
				function(event) {
					var password = document.getElementById('password').value;
					var confirmPassword = document
							.getElementById('confirmpassword').value;

					if (password !== confirmPassword) {
						// Show error modal
						var errorModal = new bootstrap.Modal(document
								.getElementById('errorModal'));
						errorModal.show();
						event.preventDefault(); // Prevent form submission
					}
				});
	</script>


</body>
</html>
