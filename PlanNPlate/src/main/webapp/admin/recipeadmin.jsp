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
						<li class="nav-item active"><a
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
						<h3 class="fw-bold mb-3">Table</h3>
						<ul class="breadcrumbs mb-3">

						</ul>
					</div>
					<div class="row">
						<div class="col-md-12">
							<div class="card">
								<div class="card-header">
									<div
										class="card-header d-flex justify-content-between align-items-center">
										<h4 class="card-title">Recipe</h4>
										<a
											href="AdminRecipeController?action=addRecipeAdmin&adminID=<c:out value="${sessionId}" />"
											class="btn btn-primary btn-round"> <i class="fa fa-plus"></i>
											Add Recipe
										</a>
									</div>
								</div>
								<div class="card-body">
									<div class="table-responsive">
										<table id="add-row"
											class="display table table-striped table-hover">
											<thead>
												<tr>
													<th>Recipe ID</th>
													<th>Image</th>
													<th>Title</th>
													<th>Tag</th>
													<th>User ID</th>
													<th style="width: 10%">Action</th>
												</tr>
											</thead>
											<tfoot>
												<tr>
													<th>Recipe ID</th>
													<th>Image</th>
													<th>Title</th>
													<th>Tag</th>
													<th>User ID</th>
													<th>Action</th>
												</tr>
											</tfoot>
											<tbody>
												<c:forEach items="${recipes}" var="recipe" varStatus="r">
													<tr>
														<td><c:out value="${recipe.recipeID}" /></td>
														<td><img
															src="data:image/jpg;base64,<c:out value="${recipe.image}" />"
															alt="" style="width: 150px; height: auto;"></td>
														<td><c:out value="${recipe.title}" /></td>
														<td><c:out value="${recipe.tag}" /></td>
														<td><c:out value="${recipe.userID}" /></td>
														<td>
															<div class="form-button-action">
																<a
																	href="AdminRecipeController?action=viewRecipeAdmin&recipeID=<c:out value="${recipe.recipeID}" />&userID=<c:out value='${recipe.userID}' />&adminID=<c:out value="${sessionId}" />"
																	class="btn btn-link btn-primary btn-lg"> <i
																	class="fa fa-edit"></i>
																</a> <input type="hidden" id="recipeID-${r.index}"
																	value="<c:out value="${recipe.recipeID}"/>"> 
																	 <input
																	type="hidden" id="adminID-${r.index}"
																	value="<c:out value="${sessionId}" />">

																	<button class="btn btn-link btn-danger"
																		onclick="confirmation('${r.index}')">
																		<i class="fa fa-times"></i>
																	</button>
															</div>
														</td>
												</c:forEach>
											</tbody>
										</table>
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
		function confirmation(index) {
			var recipeID = document.getElementById('recipeID-' + index).value;
			var adminID = document.getElementById('adminID-' + index).value;
			if (confirm('Are you sure you want to delete this recipe?')) {
				window.location.href = 'AdminRecipeController?action=delete&recipeID=' + recipeID + '&adminID=' + adminID;
			}
		}
	</script>

	<script>
		$(document)
				.ready(
						function() {
							$("#basic-datatables").DataTable({});

							$("#multi-filter-select")
									.DataTable(
											{
												pageLength : 5,
												initComplete : function() {
													this
															.api()
															.columns()
															.every(
																	function() {
																		var column = this;
																		var select = $(
																				'<select class="form-select"><option value=""></option></select>')
																				.appendTo(
																						$(
																								column
																										.footer())
																								.empty())
																				.on(
																						"change",
																						function() {
																							var val = $.fn.dataTable.util
																									.escapeRegex($(
																											this)
																											.val());

																							column
																									.search(
																											val ? "^"
																													+ val
																													+ "$"
																													: "",
																											true,
																											false)
																									.draw();
																						});

																		column
																				.data()
																				.unique()
																				.sort()
																				.each(
																						function(
																								d,
																								j) {
																							select
																									.append('<option value="' + d + '">'
																											+ d
																											+ "</option>");
																						});
																	});
												},
											});

							// Add Row
							$("#add-row").DataTable({
								pageLength : 5,
							});

							var action = '<td> <div class="form-button-action"> <button type="button" data-bs-toggle="tooltip" title="" class="btn btn-link btn-primary btn-lg" data-original-title="Edit Task"> <i class="fa fa-edit"></i> </button> <button type="button" data-bs-toggle="tooltip" title="" class="btn btn-link btn-danger" data-original-title="Remove"> <i class="fa fa-times"></i> </button> </div> </td>';

							$("#addRowButton")
									.click(
											function() {
												$("#add-row")
														.dataTable()
														.fnAddData(
																[
																		$(
																				"#addName")
																				.val(),
																		$(
																				"#addPosition")
																				.val(),
																		$(
																				"#addOffice")
																				.val(),
																		action, ]);
												$("#addRowModal").modal("hide");
											});
						});
	</script>

</body>
</html>
