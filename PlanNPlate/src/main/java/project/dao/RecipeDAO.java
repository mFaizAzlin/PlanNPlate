package project.dao;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.sql.SQLException;

import project.connection.ConnectionManager;
import project.model.CaloriesCalculator;
import project.model.Ingredient;
import project.model.Recipe;

public class RecipeDAO {
	private static Connection con = null;
	private static PreparedStatement ps = null;;
	private static ResultSet rs = null;
	private static Statement stmt = null;
	
	//add recipe
	public static void addRecipe(Recipe recipe) throws SQLException{
		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();
			//3. create statement
			String sql = "INSERT INTO recipe(image,title,ingredient,instruction,tag,userID)SELECT ?,?,?,?,?,userID FROM user WHERE userID=?";

			ps = con.prepareStatement(sql);
			ps.setBlob(1, recipe.getFile());//store image
			ps.setString(2, recipe.getTitle());
			ps.setString(3, recipe.getIngredient());
			ps.setString(4, recipe.getInstruction());
			ps.setString(5, recipe.getTag());
			ps.setInt(6, recipe.getUserID());
			
			//4. execute query
			ps.executeUpdate();

			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}	
	}
	//update recipe
	public static void updateRecipe(Recipe recipe) {
		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();
			//3. create statement
			ps = con.prepareStatement("UPDATE recipe SET title=?,ingredient=?,instruction=?,tag=?,userID=? WHERE recipeID=?");

			ps.setString(1, recipe.getTitle());
			ps.setString(2, recipe.getIngredient());
			ps.setString(3, recipe.getInstruction());
			ps.setString(4, recipe.getTag());
			ps.setInt(5, recipe.getUserID());
			ps.setInt(6, recipe.getRecipeID());

			//4. execute query
			ps.executeUpdate();

			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}	
	}
	//update recipe
		public static void updateRecipeImage(Recipe recipe) {
			try {			
				//call getConnection() method
				con = ConnectionManager.getConnection();
				//3. create statement
				ps = con.prepareStatement("UPDATE recipe SET image=? WHERE recipeID=?");

				ps.setBlob(1, recipe.getFile());
				ps.setInt(2, recipe.getRecipeID());

				//4. execute query
				ps.executeUpdate();

				//5. close connection
				con.close();

			}catch(Exception e) {
				e.printStackTrace();
			}	
		}
	//delete recipe
	public static void deleteRecipe(int recipeID) {
		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();
			//3. create statement
			String sql = "DELETE FROM recipe WHERE recipeID=?";
			ps = con.prepareStatement(sql);

			ps.setInt(1, recipeID);
			//4. execute query
			ps.executeUpdate();

			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}	
	}
	//get recipe by recipeID
	public static Recipe getRecipe(int recipeID) {
		Recipe recipe = new Recipe();
		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();
			//3. create statement
			ps = con.prepareStatement("SELECT * FROM recipe WHERE recipeID=?");
			
			//set parameter values
			ps.setInt(1, recipeID);

			//4. execute query
			rs = ps.executeQuery();

			//process ResultSet and set the values to the Shawl object
			if(rs.next()) {
				recipe.setRecipeID(rs.getInt("recipeID"));
				//get image
				Blob blob = rs.getBlob("image");
				
				InputStream inputStream = blob.getBinaryStream();
				ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
				byte[] buffer = new byte[4096];
				int bytesRead = -1;
				while ((bytesRead = inputStream.read(buffer)) != -1) {
					outputStream.write(buffer, 0, bytesRead);                  
				}
				byte[] imageBytes = outputStream.toByteArray();
				String image = Base64.getEncoder().encodeToString(imageBytes);

				recipe.setImage(image);
				inputStream.close();
				outputStream.close();
				
				//recipe.setImage(rs.getString("image"));
				recipe.setTitle(rs.getString("title"));
				recipe.setIngredient(rs.getString("ingredient"));
				recipe.setInstruction(rs.getString("instruction"));
				recipe.setTag(rs.getString("tag"));
				recipe.setUserID(rs.getInt("userID"));
			}
			
			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}	
		return recipe;
	}
	//get all recipes
	public static List<Recipe> getAllRecipe() {
		
		List<Recipe> recipes = new ArrayList<Recipe>();
		
		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();
			//3. create statement
			stmt = con.createStatement();
			String sql = "SELECT * FROM recipe ORDER BY recipeID";

			//4. execute query
			rs = stmt.executeQuery(sql);

			while(rs.next()) {		//process result
				Recipe recipe = new Recipe();
				recipe.setRecipeID(rs.getInt("recipeID"));
				
				//get image
				Blob blob = rs.getBlob("image");
				
				InputStream inputStream = blob.getBinaryStream();
				ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
				byte[] buffer = new byte[4096];
				int bytesRead = -1;
				while ((bytesRead = inputStream.read(buffer)) != -1) {
					outputStream.write(buffer, 0, bytesRead);                  
				}
				byte[] imageBytes = outputStream.toByteArray();
				String image = Base64.getEncoder().encodeToString(imageBytes);

				recipe.setImage(image);
				inputStream.close();
				outputStream.close();
				
				//recipe.setImage(rs.getString("image"));
				recipe.setTitle(rs.getString("title"));
				recipe.setIngredient(rs.getString("ingredient"));
				recipe.setInstruction(rs.getString("instruction"));
				recipe.setTag(rs.getString("tag"));
				recipe.setUserID(rs.getInt("userID"));
				recipes.add(recipe);

			}
			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}	
		return recipes;
	}
	
	//get all recipe by name
		public static List<Recipe> getAllRecipeName() {
			
			List<Recipe> RecipeName = new ArrayList<Recipe>();
			
			try {			
				//call getConnection() method
				con = ConnectionManager.getConnection();
				//3. create statement
				stmt = con.createStatement();
				String sql = "SELECT * FROM recipe ORDER BY recipeID";

				//4. execute query
				rs = stmt.executeQuery(sql);

				while(rs.next()) {		//process result
					Recipe recipeName = new Recipe();
					recipeName.setTitle(rs.getString("title"));
					RecipeName.add(recipeName);

				}


				//5. close connection
				con.close();

			}catch(Exception e) {
				e.printStackTrace();
			}	
			return RecipeName;
		}

		

		//get all recipe by userid
		public static List<Recipe> getAllRecipeByUserID(int userID) {
			List<Recipe> recipes = new ArrayList<Recipe>(); 
			try { 
				//call getConnection() method 
				con = ConnectionManager.getConnection();

				//3. create statement 
				String sql = "SELECT * FROM recipe WHERE userID=?";
				ps = con.prepareStatement(sql);

				ps.setInt(1,userID);
				
				//4. execute query
				rs = ps.executeQuery();

				while (rs.next()) { 
					Recipe recipe = new Recipe();
					recipe.setRecipeID(rs.getInt("recipeID"));	  
					
					//get image
					Blob blob = rs.getBlob("image");
					
					InputStream inputStream = blob.getBinaryStream();
					ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
					byte[] buffer = new byte[4096];
					int bytesRead = -1;
					while ((bytesRead = inputStream.read(buffer)) != -1) {
						outputStream.write(buffer, 0, bytesRead);                  
					}
					byte[] imageBytes = outputStream.toByteArray();
					String image = Base64.getEncoder().encodeToString(imageBytes);

					recipe.setImage(image);
					inputStream.close();
					outputStream.close();
					
					//recipe.setImage(rs.getString("image"));
					recipe.setTitle(rs.getString("title"));
					recipe.setIngredient(rs.getString("ingredient"));
					recipe.setInstruction(rs.getString("instruction"));
					recipe.setTag(rs.getString("tag"));
					recipe.setUser(UserDAO.getUserById(rs.getInt("userID")));
					recipes.add(recipe);
				} 
			
				//5. close connection
				con.close();

			}catch(Exception e) {
				e.printStackTrace();
			}

			return recipes; 
		}
		
		public static int countRecipe() {
		    int count = 0;

		    try {
		        con = ConnectionManager.getConnection();
		        ps = con.prepareStatement("SELECT COUNT(*) AS recipe_count FROM recipe");
		        rs = ps.executeQuery();

		        if (rs.next()) {
		            count = rs.getInt("recipe_count");
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        try {
		            if (rs != null) rs.close();
		            if (ps != null) ps.close();
		            if (con != null) con.close();
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		    }

		    return count;
		}

}
