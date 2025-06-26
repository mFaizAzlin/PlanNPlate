package recipe.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import project.dao.AdminDAO;
import project.dao.RecipeDAO;
import project.dao.UserDAO;
import project.model.Admin;
import project.model.User;

import java.io.IOException;

/**
 * Servlet implementation class LoginController1
 */
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private HttpSession session;
	private RequestDispatcher view;
	private String email;
	private String action="", forward="";
	private static String REGISTER = "register.jsp";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
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
		if(action.equalsIgnoreCase("register")) {
			forward = REGISTER;
			request.setAttribute("users", UserDAO.getAllUser());       
			request.setAttribute("admins", AdminDAO.getAllAdmin());
		}	
		view = request.getRequestDispatcher(forward);
        view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			User user = new User();
			Admin admin = new Admin();
			
			email = request.getParameter("email");
			
			if(AdminDAO.emailExists(email)) {
				admin.setEmail(email);
				admin.setPassword(request.getParameter("password"));
				
				admin = AdminDAO.login(admin);
				
				if(admin.isValid()){
					session = request.getSession(true);
					session.setAttribute("sessionId", admin.getAdminID()); 
					session.setAttribute("sessionEmail", admin.getEmail());  				
					
					request.setAttribute("admin", AdminDAO.getAdmin(admin.getAdminID())); 
					
					request.setAttribute("countuser", UserDAO.countUsers());
					request.setAttribute("countrecipe", RecipeDAO.countRecipe());
					request.setAttribute("countadmin", AdminDAO.countAdmin());
					
					view = request.getRequestDispatcher("/admin/dashboard.jsp"); 			
					view.forward(request, response);
				}
				//redirect to invalidLoggin.jsp if user is not valid
				else{
					response.sendRedirect("invalidLogin.jsp");
				}
			}
			else {
				user.setEmail(request.getParameter("email"));
				user.setPassword(request.getParameter("password"));
				
				user = UserDAO.login(user);
				
				if(user.isValid()){
					session = request.getSession(true);
					session.setAttribute("sessionId", user.getUserid()); //set current session based on id
					session.setAttribute("sessionEmail", user.getEmail());
					
					
					request.setAttribute("user", UserDAO.getUserByEmail(user.getEmail()));  
					request.setAttribute("recipes", RecipeDAO.getAllRecipe());       

					view = request.getRequestDispatcher("index.jsp"); 			
					view.forward(request, response);
				}
				//redirect to invalidLoggin.jsp if user is not valid
				else{
					response.sendRedirect("invalidLogin.jsp");
				}
			}
			
		}

		catch (Throwable ex) {
			ex.printStackTrace();
		}
	}

}
