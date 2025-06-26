package project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import project.connection.ConnectionManager;
import project.model.Meal;

public class MealDAO {
	private static Connection con = null;
	private static PreparedStatement ps = null;;
	private static ResultSet rs = null;
	private static Statement stmt = null;
	
	//add meal
	public static void addMeal(Meal meal) {
		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();
			//3. create statement
			String sql = "INSERT INTO meal(title,time,date,userid,recipeid)VALUES(?,?,?,?,?)";
			ps = con.prepareStatement(sql);

			ps.setString(1, meal.getTitle());
			ps.setString(2, meal.getTime());
			ps.setString(3, meal.getDate());
			ps.setInt(4, meal.getUserID());
			ps.setInt(5, meal.getRecipeID());
			//4. execute query
			ps.executeUpdate();
			
			

		}catch(Exception e) {
			e.printStackTrace();
		}	
	}
	//update meal
	public static void updateMeal(Meal meal) {
		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();
			//3. create statement
			ps = con.prepareStatement("UPDATE meal SET title=?,time=?,date=?,userID=?,recipeID=? WHERE mealID=?");

			ps.setString(1, meal.getTitle());
			ps.setString(2, meal.getTime());
			ps.setString(3, meal.getDate());
			ps.setInt(4, meal.getUserID());
			ps.setInt(5, meal.getMealID());
			ps.setInt(6, meal.getRecipeID());
			//4. execute query
			ps.executeUpdate();

			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}	
	}
	//delete meal
	public static void deleteMeal(int mealID) {
		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();
			//3. create statement
			String sql = "DELETE FROM meal WHERE mealID=?";
			ps = con.prepareStatement(sql);

			ps.setInt(1, mealID);
			//4. execute query
			ps.executeUpdate();

			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}	
	}
	//get meal by mealID
	public static Meal getMeal(int mealID) {
		Meal meal = new Meal();
		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();
			//3. create statement
			ps = con.prepareStatement("SELECT * FROM meal WHERE mealID=?");
			
			//set parameter values
			ps.setInt(1, mealID);

			//4. execute query
			rs = ps.executeQuery();

			if(rs.next()) {
				meal.setMealID(rs.getInt("mealID"));
				meal.setTitle(rs.getString("title"));
				meal.setTime(rs.getString("time"));
				meal.setDate(rs.getString("date"));
				meal.setUserID(rs.getInt("userID"));
				meal.setRecipeID(rs.getInt("recipeID"));
			}
			
			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}	
		return meal;
	}
	//get all meals
	public static List<Meal> getAllMeal() {
		
		List<Meal> meals = new ArrayList<Meal>();
		
		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();
			//3. create statement
			stmt = con.createStatement();
			String sql = "SELECT * FROM meal ORDER BY mealID";

			//4. execute query
			rs = stmt.executeQuery(sql);

			while(rs.next()) {		//process result
				Meal meal = new Meal();
				meal.setMealID(rs.getInt("mealID"));
				meal.setTitle(rs.getString("title"));
				meal.setTime(rs.getString("time"));
				meal.setDate(rs.getString("date"));
				meal.setUserID(rs.getInt("userID"));
				meal.setRecipeID(rs.getInt("recipeID"));
				meals.add(meal);

			}

			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}	
		return meals;
	}
	
	
}
