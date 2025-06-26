package recipe.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import project.dao.AdminDAO;
import project.dao.UserDAO;
import project.model.User;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;

/**
 * Servlet implementation class AdminUserController
 */
public class AdminUserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RequestDispatcher view;
	private String action="", forward="";
	
	private static String LIST = "admin/useradmin.jsp";
	private static String VIEW = "admin/viewuser.jsp";
	private static String UPDATE2 = "index.jsp";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminUserController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		User user = new User();
		System.out.print(request.getParameter("adminID"));
		user.setUsername(request.getParameter("username"));
		user.setEmail(request.getParameter("email"));
		int id = Integer.parseInt(request.getParameter("adminID"));
		user.setAdminID(id);
		
		action = request.getParameter("action");
		
		String password = request.getParameter("password");
		String userid = request.getParameter("userid");
		
		 if(userid ==null || userid.isEmpty()) {
	        	try {
					UserDAO.addUser(user);
				} catch (NoSuchAlgorithmException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	        	request.setAttribute("users", UserDAO.getAllUser());	    
	    	    view = request.getRequestDispatcher(LIST);
	            view.forward(request, response);
			}
			else {
				user.setUserid(Integer.parseInt(userid));
				UserDAO.updateUser(user);
				
				if(action.equalsIgnoreCase("updateUser2")) { 
					
					if (password ==null || password.isEmpty()) {
						UserDAO.updateUser(user);
						forward = UPDATE2;
					}
					else {
						user.setPassword(request.getParameter("password"));
						try {
							UserDAO.updateUserPassword(user);
						} catch (NoSuchAlgorithmException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
					
					int adminID = Integer.parseInt(request.getParameter("session"));
					request.setAttribute("admin", AdminDAO.getAdmin(adminID));
					int userID = Integer.parseInt(request.getParameter("userid"));
					request.setAttribute("user", UserDAO.getUserById(userID));
					view = request.getRequestDispatcher(forward);
					view.forward(request, response);
				}
				else {
					
					if (password ==null || password.isEmpty()) {
						UserDAO.updateUser(user);
						forward = VIEW;
					}
					else {
						user.setPassword(request.getParameter("password"));
						try {
							UserDAO.updateUserPassword(user);
						} catch (NoSuchAlgorithmException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
					
					request.setAttribute("users", UserDAO.getAllUser());	    
				    view = request.getRequestDispatcher(LIST);
			        view.forward(request, response);
				}
		}
  
	}

}
