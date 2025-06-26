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
<title>Admin Dashboard</title>
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
	width: 40px; /* Adjust size as needed */
	height: auto; /* Maintain aspect ratio */
	display: block; /* Make image a block element */
	margin-bottom: 10px; /* Space between image and text */
}

.user-greeting {
	font-size: 18px; /* Adjust text size */
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
					<a href="index.html" class="logo"> <img
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
						<a href="index.html" class="logo"> <img
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
							class="navbar navbar-header-left navbar-expand-lg navbar-form nav-search p-0 d-none d-lg-flex"></nav>

						<h3 class="fw-bold mb-3">Dashboard</h3>

						<ul class="navbar-nav topbar-nav ms-md-auto align-items-center">

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
					<div
						class="d-flex align-items-left align-items-md-center flex-column flex-md-row pt-2 pb-4">
					</div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="card card-stats card-round">
								<div class="card-body">
									<div class="row align-items-center">
										<div class="col-icon">
											<div
												class="icon-big text-center icon-primary bubble-shadow-small">
												<i class="fas fa-users"></i>
											</div>
										</div>
										<div class="col col-stats ms-3 ms-sm-0">
											<div class="numbers">
												<p class="card-category">User</p>
												<h4 class="card-title">${countuser}</h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="card card-stats card-round">
								<div class="card-body">
									<div class="row align-items-center">
										<div class="col-icon">
											<div
												class="icon-big text-center icon-info bubble-shadow-small">
												<i class="fas fa-utensils"></i>
											</div>
										</div>
										<div class="col col-stats ms-3 ms-sm-0">
											<div class="numbers">
												<p class="card-category">Recipe</p>
												<h4 class="card-title">${countrecipe}</h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="card card-stats card-round">
								<div class="card-body">
									<div class="row align-items-center">
										<div class="col-icon">
											<div
												class="icon-big text-center icon-success bubble-shadow-small">
												<i class="fas fa-coffee"></i>
											</div>
										</div>
										<div class="col col-stats ms-3 ms-sm-0">
											<div class="numbers">
												<p class="card-category">Admin</p>
												<h4 class="card-title">${countadmin}</h4>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="card">
								<div class="card-body">
									<jsp:include page="../userchart.jsp" />
								</div>
							</div>							
						</div>
						<div class="col-md-6">
							<div class="card">
								<div class="card-body">
									<jsp:include page="../recipechart.jsp" />
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

		<!-- Custom template | don't include it in your project! -->
		<div class="custom-template">
			<div class="title">Settings</div>
			<div class="custom-content">
				<div class="switcher">
					<div class="switch-block">
						<h4>Logo Header</h4>
						<div class="btnSwitch">
							<button type="button" class="selected changeLogoHeaderColor"
								data-color="dark"></button>
							<button type="button" class="changeLogoHeaderColor"
								data-color="blue"></button>
							<button type="button" class="changeLogoHeaderColor"
								data-color="purple"></button>
							<button type="button" class="changeLogoHeaderColor"
								data-color="light-blue"></button>
							<button type="button" class="changeLogoHeaderColor"
								data-color="green"></button>
							<button type="button" class="changeLogoHeaderColor"
								data-color="orange"></button>
							<button type="button" class="changeLogoHeaderColor"
								data-color="red"></button>
							<button type="button" class="changeLogoHeaderColor"
								data-color="white"></button>
							<br />
							<button type="button" class="changeLogoHeaderColor"
								data-color="dark2"></button>
							<button type="button" class="changeLogoHeaderColor"
								data-color="blue2"></button>
							<button type="button" class="changeLogoHeaderColor"
								data-color="purple2"></button>
							<button type="button" class="changeLogoHeaderColor"
								data-color="light-blue2"></button>
							<button type="button" class="changeLogoHeaderColor"
								data-color="green2"></button>
							<button type="button" class="changeLogoHeaderColor"
								data-color="orange2"></button>
							<button type="button" class="changeLogoHeaderColor"
								data-color="red2"></button>
						</div>
					</div>
					<div class="switch-block">
						<h4>Navbar Header</h4>
						<div class="btnSwitch">
							<button type="button" class="changeTopBarColor" data-color="dark"></button>
							<button type="button" class="changeTopBarColor" data-color="blue"></button>
							<button type="button" class="changeTopBarColor"
								data-color="purple"></button>
							<button type="button" class="changeTopBarColor"
								data-color="light-blue"></button>
							<button type="button" class="changeTopBarColor"
								data-color="green"></button>
							<button type="button" class="changeTopBarColor"
								data-color="orange"></button>
							<button type="button" class="changeTopBarColor" data-color="red"></button>
							<button type="button" class="selected changeTopBarColor"
								data-color="white"></button>
							<br />
							<button type="button" class="changeTopBarColor"
								data-color="dark2"></button>
							<button type="button" class="changeTopBarColor"
								data-color="blue2"></button>
							<button type="button" class="changeTopBarColor"
								data-color="purple2"></button>
							<button type="button" class="changeTopBarColor"
								data-color="light-blue2"></button>
							<button type="button" class="changeTopBarColor"
								data-color="green2"></button>
							<button type="button" class="changeTopBarColor"
								data-color="orange2"></button>
							<button type="button" class="changeTopBarColor" data-color="red2"></button>
						</div>
					</div>
					<div class="switch-block">
						<h4>Sidebar</h4>
						<div class="btnSwitch">
							<button type="button" class="changeSideBarColor"
								data-color="white"></button>
							<button type="button" class="selected changeSideBarColor"
								data-color="dark"></button>
							<button type="button" class="changeSideBarColor"
								data-color="dark2"></button>
						</div>
					</div>
				</div>
			</div>
			<div class="custom-toggle">
				<i class="icon-settings"></i>
			</div>
		</div>
		<!-- End Custom template -->
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

	<!-- Sweet Alert -->
	<script src="assets/js/plugin/sweetalert/sweetalert.min.js"></script>

	<!-- Kaiadmin JS -->
	<script src="assets/js/kaiadmin.min.js"></script>

	<!-- Kaiadmin DEMO methods, don't include it in your project! -->
	<script src="assets/js/setting-demo.js"></script>
	<script src="assets/js/demo.js"></script>
	<script>
		$("#lineChart").sparkline([ 102, 109, 120, 99, 110, 105, 115 ], {
			type : "line",
			height : "70",
			width : "100%",
			lineWidth : "2",
			lineColor : "#177dff",
			fillColor : "rgba(23, 125, 255, 0.14)",
		});

		$("#lineChart2").sparkline([ 99, 125, 122, 105, 110, 124, 115 ], {
			type : "line",
			height : "70",
			width : "100%",
			lineWidth : "2",
			lineColor : "#f3545d",
			fillColor : "rgba(243, 84, 93, .14)",
		});

		$("#lineChart3").sparkline([ 105, 103, 123, 100, 95, 105, 115 ], {
			type : "line",
			height : "70",
			width : "100%",
			lineWidth : "2",
			lineColor : "#ffa534",
			fillColor : "rgba(255, 165, 52, .14)",
		});
	</script>
</body>
</html>
