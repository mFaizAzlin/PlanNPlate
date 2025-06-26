package recipe.controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import project.dao.MealDAO;
import project.dao.RecipeDAO;

import project.model.Meal;



public class MealController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String action ="", forward=""; 
	private final String LIST = "user/meals.jsp";
	private static String VIEW = "user/viewMeal.jsp";
	private static String delete ="user/meals.jsp";
	private int mealID;

public MealController() {
	super();
	// TODO Auto-generated constructor stub
}

/**
 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
 */
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			//set attribute to a servlet request. Set the attribute name to shawls and call getAllShawls() from ShawlDAO class
	action = request.getParameter("action");

	try {
		
		//list
		if(action.equalsIgnoreCase("list")) {
			forward = LIST;
			//set attribute to a servlet request. Set the attribute name to ingredients and call getAllIngredientName() from IngredientDAO class
			request.setAttribute("recipe", RecipeDAO.getAllRecipe());
			request.setAttribute("meals", MealDAO.getAllMeal());
			
		}
		if(action.equalsIgnoreCase("viewMeal")) { 
			forward = VIEW;
			mealID = Integer.parseInt(request.getParameter("mealID"));  
	        request.setAttribute("meal", MealDAO.getMeal(mealID));
		}
		
		if(action.equalsIgnoreCase("deleteMeal")) {
			forward = delete;
			mealID = Integer.parseInt(request.getParameter("mealID"));
			MealDAO.deleteMeal(mealID);
			request.setAttribute("meals", MealDAO.getAllMeal());
		}	
		

	}
	catch(Exception e){
		e.printStackTrace();
	}
	
	//Obtain the RequestDispatcher from the request object. The pathname to the resource is viewShawl.jsp
	RequestDispatcher req = request.getRequestDispatcher(forward);

	//Dispatch the request to another resource using forward() methods of the RequestDispatcher
	req.forward(request, response);
}

/**
 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
 */
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
	//create Shawl object
	
	Meal meal = new Meal();
	
	//retrieve input from HTML and set the values to the recipe object
	meal.setTitle(request.getParameter("title"));
	meal.setTime(request.getParameter("time"));
	meal.setDate(request.getParameter("date"));
	meal.setUserID(Integer.parseInt(request.getParameter("userid")));
	meal.setRecipeID(Integer.parseInt(request.getParameter("recipeID"))) ;
	
	System.out.println(meal.getUserID());
	
	try {
		
		MealDAO.addMeal(meal);
	} catch(Exception e) { 
		e.printStackTrace();
	}
	
	//set attribute to a servlet request. Set the attribute name to shawls and call getAllShawls() from ShawlDAO class
	
	
	request.setAttribute("recipe", RecipeDAO.getAllRecipe());
	request.setAttribute("meals", MealDAO.getAllMeal());
	//Obtain the RequestDispatcher from the request object. The the pathname to the resource is meals.jsp
	RequestDispatcher req = request.getRequestDispatcher("user/meals.jsp");
	//Dispatch the request to another resource using forward() methods of the RequestDispatcher

	req.forward(request, response);
}
}
