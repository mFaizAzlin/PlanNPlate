package recipe.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.IOException;
import java.util.List;

import project.dao.GraphDAO;
import project.model.UserData;
import project.model.RecipeData;

@WebServlet("/graph")

public class GraphController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private GraphDAO graphDAO = new GraphDAO();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GraphController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<UserData> userDataList = graphDAO.getMonthlyUserData();
        request.setAttribute("userDataList", userDataList);
        request.getRequestDispatcher("userchart.jsp").forward(request, response);
        
        List<RecipeData> recipeDataList = graphDAO.getMonthlyRecipeData();
        request.setAttribute("recipeDataList", recipeDataList);
        request.getRequestDispatcher("test.jsp").forward(request, response);
        
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

}
