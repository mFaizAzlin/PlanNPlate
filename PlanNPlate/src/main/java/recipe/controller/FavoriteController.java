package recipe.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import project.dao.AdminDAO;
import project.dao.FavoriteDAO;
import project.dao.RecipeDAO;
import project.dao.UserDAO;
import project.model.Admin;
import project.model.Favorite;
import project.model.Recipe;
import project.model.User;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;

/**
 * Servlet implementation class FavoriteController
 */
public class FavoriteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private HttpSession session;
	private RequestDispatcher view;
	private int userID;
	private int recipeID;
	private int favoriteID;
	private String action="", forward="";
	private static String LIST = "user/favorite.jsp";
	private static String VIEW = "user/viewFavoriteRecipe.jsp";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FavoriteController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		action = request.getParameter("action");
		
		//view all favorite recipes
		if(action.equalsIgnoreCase("listFavoriteRecipes")) {
			forward = LIST;
			userID = Integer.parseInt(request.getParameter("userID"));  
			request.setAttribute("recipe", FavoriteDAO.getAllFavorites(userID)); 
			request.setAttribute("favorite", FavoriteDAO.getAllFavoritesID(userID));
		}
		if(action.equalsIgnoreCase("viewFavorite")) {
			forward = VIEW;
			recipeID = Integer.parseInt(request.getParameter("recipeID"));  
	        request.setAttribute("recipe", RecipeDAO.getRecipe(recipeID));
	        request.setAttribute("favorite", FavoriteDAO.getFavorite(recipeID));
		}
		//delete favorite
		if(action.equalsIgnoreCase("deleteFavorite")) {
			forward = LIST;
			favoriteID = Integer.parseInt(request.getParameter("favoriteID"));  
			FavoriteDAO.deleteFavorite(favoriteID);
			userID = Integer.parseInt(request.getParameter("userID"));
			request.setAttribute("recipe", FavoriteDAO.getAllFavorites(userID)); 
			request.setAttribute("favorite", FavoriteDAO.getAllFavoritesID(userID));    
			}	
		view = request.getRequestDispatcher(forward);
        view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Favorite favorite = new Favorite();
		
		favorite.setUserID(Integer.parseInt(request.getParameter("userid")));
		favorite.setRecipeID(Integer.parseInt(request.getParameter("recipeID")));
		try {
			FavoriteDAO.addFavorite(favorite);
			
		} catch(SQLException e) {
			e.printStackTrace();
		}
		request.setAttribute("recipe", FavoriteDAO.getAllFavorites(userID)); 
		request.setAttribute("favorite", FavoriteDAO.getAllFavoritesID(userID));
	    view = request.getRequestDispatcher(LIST);
				//Dispatch the request to another resource using forward() methods of the RequestDispatcher
		view.forward(request, response);
	}

}
