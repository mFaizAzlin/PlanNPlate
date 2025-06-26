package recipe.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import project.connection.ConnectionManager;
import project.dao.RecipeDAO;
import project.dao.UserDAO;
import project.model.Recipe;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Servlet implementation class NewAddRecipeController
 */
@MultipartConfig(maxFileSize = 16177215)
public class RecipeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RequestDispatcher view;
	private int recipeID;
	private int userID;
	private String action="", forward="";
	private static String LIST = "user/displayRecipes.jsp";
	private static String VIEW = "user/viewRecipe.jsp";
	private static String ADD = "user/addRecipe.jsp";
	private static String PERSONAL = "user/displayPersonalRecipe.jsp";
	private static String VIEWPERSONAL = "user/viewPersonalRecipe.jsp";
	private static String UPDATE = "user/updateRecipe.jsp";
	
	private static String LISTADMIN = "admin/recipeadmin.jsp";
	private static String VIEWADMIN = "admin/viewrecipe.jsp";
	private static String ADDADMIN = "admin/addrecipe.jsp";
	private static String UPDATEADMIN = "admin/editrecipe.jsp";
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RecipeController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		action = request.getParameter("action");
		
		//list all recipes
		if(action.equalsIgnoreCase("listRecipes")) {
			forward = LIST;
			request.setAttribute("recipes", RecipeDAO.getAllRecipe());       
		}	
		//view recipe
		if(action.equalsIgnoreCase("viewRecipe")) { 
			forward = VIEW;
			recipeID = Integer.parseInt(request.getParameter("recipeID"));  
	        request.setAttribute("recipe", RecipeDAO.getRecipe(recipeID));
		}
		if(action.equalsIgnoreCase("addRecipe")) { 
			forward = ADD;
		}
		//list personal recipe
		if(action.equalsIgnoreCase("listPersonalRecipe")) {
			forward = PERSONAL;
			userID = Integer.parseInt(request.getParameter("userID"));
			request.setAttribute("recipes", RecipeDAO.getAllRecipeByUserID(userID));       
		}	
		//view recipe
		if(action.equalsIgnoreCase("viewPersonalRecipe")) { 
			forward = VIEWPERSONAL;
			recipeID = Integer.parseInt(request.getParameter("recipeID"));  
			request.setAttribute("recipe", RecipeDAO.getRecipe(recipeID));
		}
		//update recipe
		if(action.equalsIgnoreCase("updateRecipe")) {
			forward = UPDATE;
			Recipe recipe = new Recipe();			
			recipeID = Integer.parseInt(request.getParameter("recipeID"));   
			recipe = RecipeDAO.getRecipe(recipeID);
			request.setAttribute("selectedUser", recipe.getUserID()); 	      	       	                
			request.setAttribute("recipe", RecipeDAO.getRecipe(recipeID));
			request.setAttribute("users", UserDAO.getAllUser());	        
		}
		//delete personal recipe
		if(action.equalsIgnoreCase("deletePersonalRecipe")) {
			forward = PERSONAL;
			recipeID = Integer.parseInt(request.getParameter("recipeID"));
			RecipeDAO.deleteRecipe(recipeID);
			userID = Integer.parseInt(request.getParameter("userID"));
			request.setAttribute("recipes", RecipeDAO.getAllRecipeByUserID(userID));
		}	
		//admin
		if(action.equalsIgnoreCase("listRecipeAdmin")) {
			forward = LISTADMIN;
			request.setAttribute("recipes", RecipeDAO.getAllRecipe());       
		}	
		if(action.equalsIgnoreCase("viewRecipeAdmin")) { 
			forward = VIEWADMIN;
			recipeID = Integer.parseInt(request.getParameter("recipeID"));  
	        request.setAttribute("recipe", RecipeDAO.getRecipe(recipeID));
	        int userid = Integer.parseInt(request.getParameter("userID"));
			request.setAttribute("user", UserDAO.getUserById(userid));
		}
		if(action.equalsIgnoreCase("addRecipeAdmin")) {
			forward = ADDADMIN;			  

		}
		//update recipe
		if(action.equalsIgnoreCase("updateRecipeAdmin")) { 
			forward = UPDATEADMIN;
			recipeID = Integer.parseInt(request.getParameter("recipeID"));  
	        request.setAttribute("recipe", RecipeDAO.getRecipe(recipeID));
	        int userid = Integer.parseInt(request.getParameter("userID"));
			request.setAttribute("user", UserDAO.getUserById(userid));
		}
		
		
		view = request.getRequestDispatcher(forward);
        view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Recipe recipe = new Recipe();
		
		recipe.setTitle(request.getParameter("title"));
		recipe.setInstruction(request.getParameter("instruction"));
		recipe.setIngredient(request.getParameter("ingredient"));
		recipe.setTag(request.getParameter("tag"));
		recipe.setUserID(Integer.parseInt(request.getParameter("userid")));
		Part image = request.getPart("image");
		String recipeID = request.getParameter("recipeID");
		
		System.out.print("id:"+request.getPart("image"));
		

		if(recipeID ==null || recipeID.isEmpty()) {
			System.out.print("done");
			Part file=request.getPart("image");
			
			InputStream is=file.getInputStream();
			
			recipe.setFile(is);
			System.out.print("Selected Image file name: " + recipe.getImage());
			
			int userid=Integer.parseInt(request.getParameter("userid"));
			try {
				RecipeDAO.addRecipe(recipe);
				
			} catch(SQLException e) {
				e.printStackTrace();
			}
			//set attribute to a servlet request. Set the attribute name to shawls and call getAllShawls() from ShawlDAO class
			request.setAttribute("recipes", RecipeDAO.getAllRecipeByUserID(userid));
					//Obtain the RequestDispatcher from the request object. The the pathname to the resource is index.html
			RequestDispatcher req = request.getRequestDispatcher("user/displayPersonalRecipe.jsp");
					//Dispatch the request to another resource using forward() methods of the RequestDispatcher
			req.forward(request, response);
		}
		else {
			
			if(image !=null) {
				System.out.print("done");
				Part file=request.getPart("image");
				
				InputStream is=file.getInputStream();
				
				recipe.setFile(is);
				System.out.print("Selected Image file name: " + recipe.getImage());
				recipe.setRecipeID(Integer.parseInt(recipeID));
				RecipeDAO.updateRecipeImage(recipe);
				
				int recipeIDforImage = Integer.parseInt(request.getParameter("recipeID"));
				request.setAttribute("recipes", RecipeDAO.getAllRecipe());
				request.setAttribute("recipe", RecipeDAO.getRecipe(recipeIDforImage));
				RequestDispatcher req = request.getRequestDispatcher("user/updateRecipe.jsp");
				req.forward(request, response);
			}
			else {
				recipe.setRecipeID(Integer.parseInt(recipeID));
				RecipeDAO.updateRecipe(recipe);
				
				request.setAttribute("recipes", RecipeDAO.getAllRecipe());
				userID = recipe.getUserID();
				request.setAttribute("recipes", RecipeDAO.getAllRecipeByUserID(userID));
				RequestDispatcher req = request.getRequestDispatcher("user/displayPersonalRecipe.jsp");
				req.forward(request, response);
			}
		}
		
	}

}
