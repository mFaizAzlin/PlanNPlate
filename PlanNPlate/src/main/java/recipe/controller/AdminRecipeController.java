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
import project.dao.AdminDAO;
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
public class AdminRecipeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RequestDispatcher view;
	private int recipeID;
	private int userID;
	private String action="", forward="";

	private static String LISTADMIN = "admin/recipeadmin.jsp";
	private static String VIEWADMIN = "admin/viewrecipe.jsp";
	private static String ADDADMIN = "admin/addrecipe.jsp";
	private static String UPDATEADMIN = "admin/editrecipe.jsp";
	private static String ADD = "admin/recipeadmin.jsp";
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminRecipeController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		action = request.getParameter("action");
		int adminID = Integer.parseInt(request.getParameter("adminID"));
		request.setAttribute("admin", AdminDAO.getAdmin(adminID)); 
		
		if(action.equalsIgnoreCase("addRecipe")) { 
			forward = ADD;
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
		if(action.equalsIgnoreCase("delete")) {
			forward = LISTADMIN;
			recipeID = Integer.parseInt(request.getParameter("recipeID"));  
			RecipeDAO.deleteRecipe(recipeID);
			request.setAttribute("recipes", RecipeDAO.getAllRecipe());   
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
		
		System.out.print("recipeID: "+recipeID);
		
		if(recipeID ==null || recipeID.isEmpty()) {
			System.out.print("done");
			Part file=request.getPart("image");
			
			InputStream is=file.getInputStream();
			
			recipe.setFile(is);
			
			System.out.print("Selected Image file name: " + recipe.getImage());

			try {
				RecipeDAO.addRecipe(recipe);
				
			} catch(SQLException e) {
				e.printStackTrace();
			}

			request.setAttribute("recipes", RecipeDAO.getAllRecipe());
			
			int adminID = Integer.parseInt(request.getParameter("adminID"));
			request.setAttribute("admin", AdminDAO.getAdmin(adminID));
			
			RequestDispatcher req = request.getRequestDispatcher(LISTADMIN);

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
				RequestDispatcher req = request.getRequestDispatcher("admin/editrecipe.jsp");
				req.forward(request, response);
			}
			else {
				System.out.print("masuk x");
				recipe.setRecipeID(Integer.parseInt(recipeID));
				RecipeDAO.updateRecipe(recipe);
				
				request.setAttribute("recipes", RecipeDAO.getAllRecipe());
				RequestDispatcher req = request.getRequestDispatcher(LISTADMIN);
				req.forward(request, response);
			}
		}
		
	}

}
