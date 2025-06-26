package recipe.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import project.dao.AdminDAO;
import project.dao.RecipeDAO;
import project.dao.UserDAO;
import project.model.Admin;
import project.model.Recipe;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

/**
 * Servlet implementation class AdminController
 */
@MultipartConfig(maxFileSize = 16177215)
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RequestDispatcher view;
	private String action="", forward="";
	private HttpSession session;
	
	private static String LIST = "admin/admin.jsp";
	private static String DASHBOARD = "admin/dashboard.jsp";
	private static String ADD = "admin/addadmin.jsp";
	private static String VIEW = "admin/viewadmin.jsp";
	private static String VIEWPROFILE = "admin/viewprofile.jsp";
	private static String UPDATE = "admin/updateadmin.jsp";
	
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub\
		action = request.getParameter("action");
		
		int adminID = Integer.parseInt(request.getParameter("adminID"));
		request.setAttribute("admin", AdminDAO.getAdmin(adminID)); 
		
		String sessionId = request.getParameter("adminID");
	    request.getSession().setAttribute("sessionId", sessionId);
	    
		if(action.equalsIgnoreCase("dashboard")) {
			forward = DASHBOARD;
			request.setAttribute("countuser", UserDAO.countUsers());
			request.setAttribute("countrecipe", RecipeDAO.countRecipe());
			request.setAttribute("countadmin", AdminDAO.countAdmin());
		}
		//view all Users
		if(action.equalsIgnoreCase("list")) {
			forward = LIST;
			request.setAttribute("admins", AdminDAO.getAllAdmin());       
		}
		if(action.equalsIgnoreCase("add")) { 
			forward = ADD;
		}
		if(action.equalsIgnoreCase("view")) {
			forward = VIEW;
			int viewID = Integer.parseInt(request.getParameter("viewID"));
			request.setAttribute("view", AdminDAO.getAdmin(viewID));
		}
		
		if(action.equalsIgnoreCase("viewprofile")) {
			forward = VIEWPROFILE; 			
			
		}
		
		if(action.equalsIgnoreCase("update")) { 
			forward = UPDATE;  
		}
		
		if(action.equalsIgnoreCase("delete")) {
			forward = LIST;
			adminID = Integer.parseInt(request.getParameter("adminID"));  
			AdminDAO.deleteAdmin(adminID);
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
		Admin admin = new Admin();

		admin.setName(request.getParameter("name"));
		admin.setEmail(request.getParameter("email"));
		admin.setPassword(request.getParameter("password"));
		admin.setAddress(request.getParameter("address"));
		admin.setPhonenum(request.getParameter("phonenum"));
		admin.setQuote(request.getParameter("quote"));
		Part image = request.getPart("image");
		
		String adminID = request.getParameter("adminID");
		String password = request.getParameter("password");
		
		if(adminID ==null || adminID.isEmpty()) {
			System.out.print("done");
			Part file=request.getPart("image");

			InputStream is=file.getInputStream();

			admin.setFile(is);

			System.out.print("Selected Image file name: " + admin.getImage());

			try {
				AdminDAO.addAdmin(admin);

			} catch(Exception e) {
				e.printStackTrace();
			}
			
			int id = Integer.parseInt(request.getParameter("session"));
			request.setAttribute("admin", AdminDAO.getAdmin(id)); 
			
			request.setAttribute("admins", AdminDAO.getAllAdmin());

			RequestDispatcher req = request.getRequestDispatcher(LIST);

			req.forward(request, response);
		}
		else {

			if(image !=null) {
				System.out.print("updateimage");
				Part file=request.getPart("image");

				InputStream is=file.getInputStream();

				admin.setFile(is);
				System.out.print("Selected Image file name: " + admin.getImage());
				admin.setAdminID(Integer.parseInt(adminID));
				AdminDAO.updateAdminImage(admin);

				int adminIDforImage = admin.getAdminID();
				request.setAttribute("admin", AdminDAO.getAdmin(adminIDforImage));
				RequestDispatcher req = request.getRequestDispatcher("admin/updateadmin.jsp");
				req.forward(request, response);
			}
			else {
				admin.setAdminID(Integer.parseInt(adminID));
				
				
				if (password ==null || password.isEmpty()) {
					AdminDAO.updateAdmin(admin);
				}
				else {
					admin.setPassword(request.getParameter("password"));
					try {
						AdminDAO.updateAdminPassword(admin);
					} catch (NoSuchAlgorithmException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			    
			    int adminIdInt = Integer.parseInt(adminID);
			    
			    session = request.getSession(true);
			    session.setAttribute("sessionId", adminIdInt);
			    
			    System.out.print("admin id: "+adminID);
			    System.out.print("admin id: "+adminIdInt);
			    
				request.setAttribute("admin", AdminDAO.getAdmin(Integer.parseInt(adminID)));
				RequestDispatcher req = request.getRequestDispatcher(VIEWPROFILE);
				req.forward(request, response);
			}
		}
	}

}
