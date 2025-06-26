package recipe.controller;



import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.dao.UserDAO;
import project.model.User;

import java.io.IOException;

/**
 * Servlet implementation class RegisterController
 */
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L; 
	private RequestDispatcher view;
	private String action="", forward="";
	
	private static String LIST = "admin/useradmin.jsp";
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RegisterController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub		
		view = request.getRequestDispatcher("login.jsp");
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		action = request.getParameter("action");
		
		User user = new User();
		//retrieve input and set
		user.setUsername(request.getParameter("username"));	
		user.setEmail(request.getParameter("email"));		
		user.setPassword(request.getParameter("password"));

		
		
		//check if user exists
		if(!user.isValid()){
			try {
				//if user not exist, add/register the user------->boleh tmbah else untuk prompt error pada user
				UserDAO.addUser(user);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			if(action.equalsIgnoreCase("admin")) {
				forward=LIST;
				request.setAttribute("users", UserDAO.getAllUser());
				
				RequestDispatcher view = request.getRequestDispatcher(forward);
				view.forward(request, response);
			}
			else {
			//redirect to index.html
			RequestDispatcher view = request.getRequestDispatcher("login.jsp"); // staff page
			view.forward(request, response);
			}
		}        
	}
}