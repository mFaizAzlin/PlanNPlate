package project.dao;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
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
import project.model.Admin;
import project.model.Favorite;
import project.model.Recipe;


public class FavoriteDAO {
	private static Connection con = null;
	private static PreparedStatement ps = null;;
	private static ResultSet rs = null;
	private static Statement stmt = null;
	private static String sql=null;

	//add favorite
	public static void addFavorite(Favorite favorite) throws SQLException{
		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();
			//3. create statement
			String sql = "INSERT INTO favorite(userID,recipeID)VALUES(?,?)";

			ps = con.prepareStatement(sql);
			//ps.setString(1, favorite.getDate());
			ps.setInt(1, favorite.getUserID());
			ps.setInt(2, favorite.getRecipeID());

			//4. execute query
			ps.executeUpdate();

			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}	
	}
	//delete favorite
	public static void deleteFavorite(int favoriteID) {
		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();
			//3. create statement
			String sql = "DELETE FROM favorite WHERE favoriteID=?";
			ps = con.prepareStatement(sql);

			ps.setInt(1, favoriteID);
			//4. execute query
			ps.executeUpdate();

			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}	
	}
	//get favorite by favoriteID
	public static Favorite getFavorite(int recipeID) {
		Favorite favorite = new Favorite();
		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();
			//3. create statement
			ps = con.prepareStatement("SELECT * FROM favorite WHERE recipeID=?");
			
			//set parameter values
			ps.setInt(1, recipeID);

			//4. execute query
			rs = ps.executeQuery();

			//process ResultSet and set the values to the Shawl object
			if(rs.next()) {
				favorite.setFavoriteID(rs.getInt("favoriteID"));
				favorite.setUserID(rs.getInt("userID"));
				favorite.setRecipeID(rs.getInt("recipeID"));
			}
			
			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}	
		return favorite;
	}
	//get all favorite recipe by userid
	public static List<Recipe> getAllFavorites(int userID) {
		List<Recipe> recipes = new ArrayList<Recipe>(); 
		try { 
			//call getConnection() method 
			con = ConnectionManager.getConnection();

			//3. create statement 
			sql = "SELECT * FROM recipe r INNER JOIN favorite f ON r.recipeID = f.recipeID WHERE f.userID=?";
			ps = con.prepareStatement(sql);

			ps.setInt(1,userID);
			
			//4. execute query
			rs = ps.executeQuery();

			while (rs.next()) { 
				Recipe recipe = new Recipe();
				recipe.setRecipeID(rs.getInt("recipeID"));	  
				//recipe.setImage(rs.getString("image"));
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
	//get all favoriteID by userID
	public static List<Favorite> getAllFavoritesID(int userID) {
		List<Favorite> favorites = new ArrayList<Favorite>(); 
		try { 
			//call getConnection() method 
			con = ConnectionManager.getConnection();

			//3. create statement 
			sql = "SELECT * FROM favorite f INNER JOIN recipe r ON f.recipeID = r.recipeID WHERE f.userID=?";
			ps = con.prepareStatement(sql);

			ps.setInt(1,userID);
			
			//4. execute query
			rs = ps.executeQuery();

			while (rs.next()) { 
				Favorite favorite = new Favorite();
				favorite.setFavoriteID(rs.getInt("favoriteID"));
				favorite.setRecipeID(rs.getInt("recipeID"));
				favorite.setUserID(rs.getInt("userID"));
				favorites.add(favorite);
			} 

			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}

		return favorites; 
	}
}
