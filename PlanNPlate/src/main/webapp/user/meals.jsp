<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
<meta charset="utf-8">
<title>Plan n Plate - Catering Services Website Template</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Playball&display=swap"
	rel="stylesheet">

<!-- Icon Font Stylesheet -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">

<!-- Libraries Stylesheet -->
<link href="lib/animate/animate.min.css" rel="stylesheet">
<link href="lib/lightbox/css/lightbox.min.css" rel="stylesheet">
<link href="lib/owlcarousel/owl.carousel.min.css" rel="stylesheet">

<!-- Customized Bootstrap Stylesheet -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Template Stylesheet -->
<link href="css/style.css" rel="stylesheet">
<link
	href='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.css'
	rel='stylesheet' />

<style>
.popup {
    background: rgba(0, 0, 0, 0.5);
    width: 300px; /* Adjust width as needed */
    height: 100px; /* Adjust height as needed */
    position: fixed; /* Ensures the popup stays fixed in the viewport */
    bottom: 200px; /* Distance from the bottom of the viewport */
    right: 200px; /* Distance from the right of the viewport */
    display: none; /* Initially hidden */
    justify-content: center;
    align-items: center;
}

.popup-content {
    height: 250px;
    width: 300px;
    background: #fff;
    padding: 20px;
    border-radius: 5px;
    position: relative;
}


	
.close2 {
		position: absolute;
		top: -15px;
		right: -15px;
		background: #fff;
		height: 20px;
		width: 20px;
		border-radius: 50%;
		box-shadow: 6px 6px 29px -4px rgba(0,0,0,0,0.75);
		cursor: pointer;
	}
#calendar-container {
	width: 100%;
	max-width: 900px;
	margin: 20px;
	padding: 20px;
	background: white;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
}

#calendar {
	margin-top: 20px;
}

#controls {
	display: flex;
	justify-content: center;
	margin-bottom: 20px;
}

#monthSelector, #yearSelector {
	padding: 10px;
	margin: 0 10px;
	font-size: 16px;
	border: 1px solid #ddd;
	border-radius: 5px;
	background-color: #fff;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}
</style>
</head>

<body>

	<!-- Spinner Start -->
	<div id="spinner"
		class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
		<div class="spinner-grow text-primary" role="status"></div>
	</div>
	<!-- Spinner End -->


	<!-- Navbar start -->
	 <div class="container-fluid " >
            <div class="container" > 
                <nav class="navbar navbar-light navbar-expand-lg py-4">
                    <a href="index.jsp" class="navbar-brand">
                        <h1 class="text-primary fw-bold mb-0">PLAN<span class="text-dark">n</span><span class="text-primary fw-bold mb-0">PLATE</span></h1>
                    </a>
                    <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" >
                        <span class="fa fa-bars text-primary"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarCollapse">
                        <div class="navbar-nav mx-auto">
                            <a href="index.jsp" class="nav-item nav-link ">Home</a>
                            <a href="RecipeController?action=listRecipes" class="nav-item nav-link">Recipe</a>
                            <a href="MealController?action=list&userID=<c:out value="${sessionId}" />" class="nav-item nav-link active">Meal</a> <!-- edit nnti ikut class lain!! -->
                            <div class="nav-item dropdown">
                                <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Personal</a>
                                <div class="dropdown-menu bg-light">
                                    <a href="RecipeController?action=listPersonalRecipe&userID=<c:out value="${sessionId}" />" class="nav-item nav-link">Your Recipe</a>
                                    <a href="FavoriteController?action=listFavoriteRecipes&userID=<c:out value="${sessionId}" />" class="nav-item nav-link">Favorite</a>
                                    <a href="UserController?action=viewUser2&userid=<c:out value="${sessionId}" />" class="nav-item nav-link">Account</a>
                                </div>
                            </div> 
                            
                            
                        </div>
                        <a href="LogoutController" class="btn btn-primary py-2 px-4 d-none d-xl-inline-block rounded-pill" style="margin-right: 10px;">Logout</a>
                        <a href="MealController?action=list&userID=<c:out value="${sessionId}" />" class="btn btn-primary py-2 px-4 d-none d-xl-inline-block rounded-pill " >Plan Now</a>
                    </div> 
                </nav>
            </div>
        </div>
        <!-- Navbar End -->


	<!-- Modal Search Start -->
	<div class="modal fade" id="searchModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-fullscreen">
			<div class="modal-content rounded-0">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Search by
						keyword</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body d-flex align-items-center">
					<div class="input-group w-75 mx-auto d-flex">
						<input type="search" class="form-control bg-transparent p-3"
							placeholder="keywords" aria-describedby="search-icon-1">
						<span id="search-icon-1" class="input-group-text p-3"><i
							class="fa fa-search"></i></span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal Search End -->


	<!-- Hero Start -->
	<div class="container-fluid bg-light py-6 my-6 mt-0">
		<div class="container text-center animated bounceInDown">
			<h1 class="display-1 mb-4">Manage Meal</h1>
			<ol
				class="breadcrumb justify-content-center mb-0 animated bounceInDown">
				<li class="breadcrumb-item"><a href="#">Home</a></li>
				<li class="breadcrumb-item"><a href="#">Pages</a></li>
				<li class="breadcrumb-item text-dark" aria-current="page">Our
					Team</li>
			</ol>
		</div>
	</div>
	<!-- Hero End -->


	<!-- Team Start -->
	<div class="container-fluid team py-6">

		<div class="text-center wow bounceInUp" data-wow-delay="0.1s">
			<small
				class="d-inline-block fw-bold text-dark text-uppercase bg-light border border-primary rounded-pill px-4 py-1 mb-3">Our
				Team</small>
			<h1 class="display-5 mb-5">Manage Your Meals</h1>
		</div>
		<div class="row wow bounceInUp">
			<!-- End Align Area -->
			<div id="calendar-container">
				<!--   <div id="controls">
					<label for="monthSelector">Month: </label> <select
						id="monthSelector">
						<option value="0">January</option>
						<option value="1">February</option>
						<option value="2">March</option>
						<option value="3">April</option>
						<option value="4">May</option>
						<option value="5">June</option>
						<option value="6">July</option>
						<option value="7">August</option>
						<option value="8">September</option>
						<option value="9">October</option>
						<option value="10">November</option>
						<option value="11">December</option>
					</select> <label for="yearSelector">Year: </label> <select id="yearSelector">
						
					</select>
				</div>-->
				<div id="calendar"></div>
			</div>
			<div id="addMealForm" style="margin-top: 50px; width: 500px;">
				<form id="addMealForm" action="MealController" method="post">
					<h3 class="mb-30">Add Meal</h3>

					<div>
						<input type="hidden" name="userid"
							value="<c:out value="${sessionId}" />">
					</div>
					<div class="col-lg-4 col-md-6">
						<input type="text" class="form-control border-primary p-2"
							id="title" name="title" placeholder="Title"
							style="width: 400px; margin-bottom: 20px;">
					</div>
					<input type="date" class="form-control border-primary p-2"
						id="date" name="date" placeholder="Time"
						style="width: 400px; margin-bottom: 20px;"> <input
						type="time" class="form-control border-primary p-2" id="time"
						name="time" placeholder="Time"
						style="width: 400px; margin-bottom: 20px">

					<div class="col-lg-4 col-md-6">

						<select class="form-select border-primary p-2" name="recipeID"
							style="width: 400px; margin-bottom: 20px">
							<option>Choose Recipe</option>
							<c:forEach items="${recipe}" var="recipe">
								<option value="${recipe.recipeID}"
									${recipe.recipeID == selectedRecipe ? 'selected="selected"' : ''}>
									<c:out value="${recipe.title}" /></option>
							</c:forEach>
						</select>
					
			</div>
			<div style="width: 174px; height: 40px;">
				<button type="submit" class="btn btn-primary" type="button"
					id="add-ingredient"
					style="padding-bottom: 8px; padding-top: 8px; width: 74px;">Submit</button>
			</div>
			</form>
			
			<c:forEach items="${meals}" var="meal" varStatus="meals">
        
       <input type="hidden" id="mealID_${meal.mealID}" value="${meal.mealID}">
       <input type="hidden" id="mealTitle_${meal.mealID}" value="${meal.title}">
       <input type="hidden" id="mealDate_${meal.mealID}" value="${meal.date}">
       <input type="hidden" id="mealTime_${meal.mealID}" value="${meal.time}">
       <input type="hidden" id="mealUserID_${meal.mealID}" value="${meal.userID}">
       <input type="hidden" id="mealRecipeID_${meal.mealID}" value="${meal.recipeID}">

        </c:forEach>
			</div>

		</div>
	</div>
	<div id="calendar" style="margin-top: 20px;"></div>

	<!-- Team End -->



	<!-- Footer Start -->
	<div
		class="container-fluid footer py-6 my-6 mb-0 bg-light wow bounceInUp"
		data-wow-delay="0.1s">
		<div class="container">
			<div class="row">
				<div class="col-lg-3 col-md-6">
					<div class="footer-item">
						<h1 class="text-primary">
							Cater<span class="text-dark">Serv</span>
						</h1>
						<p class="lh-lg mb-4">There cursus massa at urnaaculis
							estieSed aliquamellus vitae ultrs condmentum leo massamollis its
							estiegittis miristum.</p>
						<div class="footer-icon d-flex">
							<a class="btn btn-primary btn-sm-square me-2 rounded-circle"
								href=""><i class="fab fa-facebook-f"></i></a> <a
								class="btn btn-primary btn-sm-square me-2 rounded-circle"
								href=""><i class="fab fa-twitter"></i></a> <a href="#"
								class="btn btn-primary btn-sm-square me-2 rounded-circle"><i
								class="fab fa-instagram"></i></a> <a href="#"
								class="btn btn-primary btn-sm-square rounded-circle"><i
								class="fab fa-linkedin-in"></i></a>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="footer-item">
						<h4 class="mb-4">Special Facilities</h4>
						<div class="d-flex flex-column align-items-start">
							<a class="text-body mb-3" href=""><i
								class="fa fa-check text-primary me-2"></i>Cheese Burger</a> <a
								class="text-body mb-3" href=""><i
								class="fa fa-check text-primary me-2"></i>Sandwich</a> <a
								class="text-body mb-3" href=""><i
								class="fa fa-check text-primary me-2"></i>Panner Burger</a> <a
								class="text-body mb-3" href=""><i
								class="fa fa-check text-primary me-2"></i>Special Sweets</a>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="footer-item">
						<h4 class="mb-4">Contact Us</h4>
						<div class="d-flex flex-column align-items-start">
							<p>
								<i class="fa fa-map-marker-alt text-primary me-2"></i> 123
								Street, New York, USA
							</p>
							<p>
								<i class="fa fa-phone-alt text-primary me-2"></i> (+012) 3456
								7890 123
							</p>
							<p>
								<i class="fas fa-envelope text-primary me-2"></i>
								info@example.com
							</p>
							<p>
								<i class="fa fa-clock text-primary me-2"></i> 26/7 Hours Service
							</p>
						</div>
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="footer-item">
						<h4 class="mb-4">Social Gallery</h4>
						<div class="row g-2">
							<div class="col-4">
								<img src="img/menu-01.jpg"
									class="img-fluid rounded-circle border border-primary p-2"
									alt="">
							</div>
							<div class="col-4">
								<img src="img/menu-02.jpg"
									class="img-fluid rounded-circle border border-primary p-2"
									alt="">
							</div>
							<div class="col-4">
								<img src="img/menu-03.jpg"
									class="img-fluid rounded-circle border border-primary p-2"
									alt="">
							</div>
							<div class="col-4">
								<img src="img/menu-04.jpg"
									class="img-fluid rounded-circle border border-primary p-2"
									alt="">
							</div>
							<div class="col-4">
								<img src="img/menu-05.jpg"
									class="img-fluid rounded-circle border border-primary p-2"
									alt="">
							</div>
							<div class="col-4">
								<img src="img/menu-06.jpg"
									class="img-fluid rounded-circle border border-primary p-2"
									alt="">
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Footer End -->
	
	<!-- Pop up Start -->
<div class="popup" id="viewMealPopup" style="display: none;">
    <div class="popup-content">
        <img src="img/close2.png" alt="Close" class="close2">
        <div class="col-12 text-center">
            <ul class="list-group">
                <li class="list-group-item">
                    <strong>Meal Title:</strong> <span id="popupMealTitle"></span>
                </li>
                <li class="list-group-item">
                    <strong>Meal Date:</strong> <span id="popupMealDate"></span>
                </li>
                <li class="list-group-item">
                    <strong>Meal Time:</strong> <span id="popupMealTime"></span>
                </li>
               
                <li class="list-group-item">
    				<strong><a href="user/viewPersonalRecipe.jsp" id="viewRecipeLink">Recipe</a></strong> <!--  <span id="popupRecipeID"></span>-->
				</li>   
            </ul>
            <!-- Hidden input fields to collect mealID and userID -->
            <input type="hidden" id="popupUserID" name="userID" value="<c:out value='${sessionId}' />">
            <input type="hidden" id="popupMealID" name="mealID" value="">
            
            <div class="mt-3">
                <a href="#" id="deleteMealBtn" class="btn btn-danger">Delete</a>
            </div>
        </div>
    </div>
</div>

	<!-- Pop up End -->
	
	

	<!-- Copyright Start -->
	<div class="container-fluid copyright bg-dark py-4">
		<div class="container">
			<div class="row">
				<div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
					<span class="text-light"><a href="#"><i
							class="fas fa-copyright text-light me-2"></i>Your Site Name</a>, All
						right reserved.</span>
				</div>
				<div class="col-md-6 my-auto text-center text-md-end text-white">
					<!--/*** This template is free as long as you keep the below author’s credit link/attribution link/backlink. ***/-->
					<!--/*** If you'd like to use the template without the below author’s credit link/attribution link/backlink, ***/-->
					<!--/*** you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". ***/-->
					Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML
						Codex</a> Distributed By <a class="border-bottom"
						href="https://themewagon.com">ThemeWagon</a>
				</div>
			</div>
		</div>
	</div>
	<!-- Copyright End -->


	<!-- Back to Top -->
	<a href="#"
		class="btn btn-md-square btn-primary rounded-circle back-to-top"><i
		class="fa fa-arrow-up"></i></a>


	<!-- JavaScript Libraries -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="lib/wow/wow.min.js"></script>
	<script src="lib/easing/easing.min.js"></script>
	<script src="lib/waypoints/waypoints.min.js"></script>
	<script src="lib/counterup/counterup.min.js"></script>
	<script src="lib/lightbox/js/lightbox.min.js"></script>
	<script src="lib/owlcarousel/owl.carousel.min.js"></script>

	<!-- Template Javascript -->
	<script src="js/main.js"></script>

	<script
		src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.js'></script>
	<script
		src='https://cdn.jsdelivr.net/npm/@fullcalendar/interaction@5.11.0/main.min.js'></script>
	<script
		src='https://cdn.jsdelivr.net/npm/@fullcalendar/daygrid@5.11.0/main.min.js'></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    var sessionID = "<c:out value='${sessionId}' />";
    var meals = [];

    <c:forEach items="${meals}" var="meal">
        var mealID = document.getElementById('mealID_${meal.mealID}').value;
        var mealTitle = document.getElementById('mealTitle_${meal.mealID}').value;
        var mealDate = document.getElementById('mealDate_${meal.mealID}').value;
        var mealTime = document.getElementById('mealTime_${meal.mealID}').value;
        var mealUserID = document.getElementById('mealUserID_${meal.mealID}').value;
        var mealRecipeID = document.getElementById('mealRecipeID_${meal.mealID}').value;

        if (mealUserID === sessionID) {
            meals.push({
                title: mealTitle,
                start: mealDate + 'T' + mealTime,
                allDay: false,
                extendedProps: {
                    mealID: mealID,
                    userID: mealUserID,
                    recipeID: mealRecipeID
                }
            });
        }
    </c:forEach>

    var calendarEl = document.getElementById('calendar');
    var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        editable: true,
        selectable: true,
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay'
        },
        events: meals,
        select: function(info) {
            var addMealFormDiv = document.getElementById('addMealForm');
            var dateInput = document.getElementById('mealDate_');
            var timeInput = document.getElementById('mealTime_');
            var mealForm = document.getElementById('mealForm');

            addMealFormDiv.style.display = 'block';
            dateInput.value = info.startStr.substring(0, 10);
            timeInput.value = '12:00:00';
        },
        eventClick: function(info) {
            showPopup(info.event);
        }
    });

    calendar.render();

    var addMealForm = document.getElementById('mealForm');
    var recipeDropdown = document.getElementById('mealTitle_');
    addMealForm.addEventListener('submit', function(event) {
        event.preventDefault();

        var date = dateInput.value;
        var time = timeInput.value;
        var recipe = recipeDropdown.value;

        if (!date || !time || recipe === "Recipe") {
            alert("Please fill out all fields.");
            return;
        }

        calendar.addEvent({
            title: recipe,
            start: date + 'T' + time,
            allDay: false
        });

        addMealForm.reset();
        addMealFormDiv.style.display = 'none';
    });

    var currentYear = new Date().getFullYear();
    var yearSelector = document.getElementById('yearSelector');
    for (var i = currentYear - 5; i <= currentYear + 5; i++) {
        var option = document.createElement("option");
        option.value = i;
        option.text = i;
        yearSelector.appendChild(option);
    }
    yearSelector.value = currentYear;

    function showPopup(event) {
        var popup = document.getElementById('viewMealPopup');

        document.getElementById('popupMealID').value = event.extendedProps.mealID;
        document.getElementById('popupMealTitle').textContent = event.title;
        document.getElementById('popupMealDate').textContent = event.startStr.substring(0, 10);
        document.getElementById('popupMealTime').textContent = event.startStr.substring(11, 16);

        // Update links with meal ID
        document.getElementById('deleteMealBtn').href = 'MealController?action=deleteMeal&mealID=' + event.extendedProps.mealID;
        
        // Assuming event contains the necessary meal details including recipeID
        var recipeID = event.extendedProps.recipeID;

        // Update the href of the viewRecipeLink based on the recipeID
        var viewRecipeLink = 'RecipeController?action=viewRecipe&recipeID=' + recipeID;
        document.getElementById('viewRecipeLink').href = viewRecipeLink;

        popup.style.display = 'block';

        // Close popup handler (assuming you have this functionality)
        document.querySelector(".close2").addEventListener("click", function() {
            popup.style.display = "none";
        });
    }
});

</script>


</body>

</html>
