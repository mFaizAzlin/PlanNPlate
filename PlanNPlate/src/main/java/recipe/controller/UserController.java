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
 * Servlet implementation class UserController
 */
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RequestDispatcher view;
	private int userid;
	private String action="", forward="";
	
	private static String LIST = "admin/useradmin.jsp";
	private static String UPDATE = "admin/updateuser.jsp";	
	private static String VIEW = "admin/viewuser.jsp";
	private static String ADD = "admin/adduser.jsp";	
	private static String VIEW2 = "user/manageAccount.jsp";
	private static String UPDATE2 = "index.jsp";
	private static String UPDATEADMIN = "admin/viewuser.jsp";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		action = request.getParameter("action");
		
		
		//view all Users
		if(action.equalsIgnoreCase("listUser")) {
			forward = LIST;
			request.setAttribute("users", UserDAO.getAllUser());
			int adminID = Integer.parseInt(request.getParameter("adminID"));
			request.setAttribute("admin", AdminDAO.getAdmin(adminID)); 
		}		
		//view User
		if(action.equalsIgnoreCase("viewUser")) { 
			forward = VIEW;
			userid = Integer.parseInt(request.getParameter("userid"));
			request.setAttribute("user", UserDAO.getUserById(userid));
			int adminID = Integer.parseInt(request.getParameter("adminID"));
			request.setAttribute("admin", AdminDAO.getAdmin(adminID)); 
		}
		//delete User
		if(action.equalsIgnoreCase("deleteUser")) {
			forward = LIST;
			userid = Integer.parseInt(request.getParameter("userid"));  
			int adminID = Integer.parseInt(request.getParameter("adminID"));
			request.setAttribute("admin", AdminDAO.getAdmin(adminID)); 
			UserDAO.deleteUser(userid);
			request.setAttribute("users", UserDAO.getAllUser());    
		}
		//add User
		if(action.equalsIgnoreCase("addUser")) {
			forward = ADD;			  
		}
		//update User
		if(action.equalsIgnoreCase("updateUser")) { 
			forward = UPDATE;
			userid = Integer.parseInt(request.getParameter("userid"));
			int adminID = Integer.parseInt(request.getParameter("adminID"));
			request.setAttribute("admin", AdminDAO.getAdmin(adminID)); 
			request.setAttribute("user", UserDAO.getUserById(userid));
		}
		//manage account by user
		if(action.equalsIgnoreCase("viewUser2")) { 
			forward = VIEW2;
			request.setAttribute("users", UserDAO.getAllUser());       
			request.setAttribute("admins", AdminDAO.getAllAdmin());
			userid = Integer.parseInt(request.getParameter("userid"));
			request.setAttribute("user", UserDAO.getUserById(userid));
		}

		view = request.getRequestDispatcher(forward);
		view.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		User user = new User();
		user.setUsername(request.getParameter("username"));
		user.setEmail(request.getParameter("email"));
		user.setAdminID(Integer.parseInt(request.getParameter("adminId")));
		
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
