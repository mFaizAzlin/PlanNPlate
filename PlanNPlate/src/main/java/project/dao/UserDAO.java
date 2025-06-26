package project.dao;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import project.connection.ConnectionManager;
import project.model.User;

public class UserDAO {
	private static Connection con = null;
	private static PreparedStatement ps = null;;
	private static ResultSet rs = null;
	private static Statement stmt = null;

	private static String sql=null;
	
	//add user
	public static void addUser(User user) throws NoSuchAlgorithmException{
		
		MessageDigest md = MessageDigest.getInstance("MD5");
		md.update(user.getPassword().getBytes());
		byte byteData[] = md.digest();

		//convert the byte to hex format
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < byteData.length; i++) {
			sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
		}
		
		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();
			//3. create statement
			String sql = "INSERT INTO user(username,email,password,adminID)VALUES(?,?,?,4)";
			ps = con.prepareStatement(sql);

			ps.setString(1, user.getUsername());
			ps.setString(2, user.getEmail());
			ps.setString(3, sb.toString());
			//4. execute query
			ps.executeUpdate();

			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}	
	}
	//update user
	public static void updateUser(User user){

		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();
			//3. create statement
			ps = con.prepareStatement("UPDATE user SET username=?,email=?, adminID=? WHERE userid=?");

			ps.setString(1, user.getUsername());
			ps.setString(2, user.getEmail());
			ps.setInt(3, user.getAdminID());
			ps.setInt(4, user.getUserid());

			//4. execute query
			ps.executeUpdate();

			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}	
	}
	//update user password
	public static void updateUserPassword(User user) throws NoSuchAlgorithmException{
		MessageDigest md = MessageDigest.getInstance("MD5");
		md.update(user.getPassword().getBytes());
		byte byteData[] = md.digest();

		//convert the byte to hex format
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < byteData.length; i++) {
			sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
		}
		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();
			//3. create statement
			ps = con.prepareStatement("UPDATE user SET password=? WHERE userid=?");

			ps.setString(1, sb.toString());
			ps.setInt(2, user.getUserid());

			//4. execute query
			ps.executeUpdate();

			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}	
	}
	//delete user
	public static void deleteUser(int userid) {
		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();
			//3. create statement
			String sql = "DELETE FROM user WHERE userid=?";
			ps = con.prepareStatement(sql);

			ps.setInt(1, userid);
			//4. execute query
			ps.executeUpdate();

			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}	
	}
	//get user by userid
	public static User getUserById(int userid) {
		User user = new User();
		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();
			//3. create statement
			ps = con.prepareStatement("SELECT * FROM user WHERE userid=?");

			//set parameter values
			ps.setInt(1, userid);

			//4. execute query
			rs = ps.executeQuery();

			//process ResultSet and set the values to the user object
			if(rs.next()) {
				user.setUserid(rs.getInt("userid"));
				user.setUsername(rs.getString("username"));
				user.setEmail(rs.getString("email"));
				user.setPassword(rs.getString("password"));
				user.setAdminID(rs.getInt("adminID"));
			}
			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}	
		return user;
	}
	//get all users
	public static List<User> getAllUser() {

		List<User> users = new ArrayList<User>();

		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();

			//3. create statement
			stmt = con.createStatement();
			String sql = "SELECT * FROM user ORDER BY userid";

			//4. execute query
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
	            User user = new User();
	            user.setUserid(rs.getInt("userid"));
	            user.setUsername(rs.getString("username"));
	            user.setEmail(rs.getString("email"));
	            user.setPassword(rs.getString("password"));
	            users.add(user);
	        }
			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}	
		return users;
	}
	//login
	public static User login(User user) throws NoSuchAlgorithmException{

		//convert the password to MD5
		MessageDigest md = MessageDigest.getInstance("MD5");
		md.update(user.getPassword().getBytes());

		byte byteData[] = md.digest();

		//convert the byte to hex format
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < byteData.length; i++) {
			sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
		}

		try {
			//call getConnection() method 
			con = ConnectionManager.getConnection();
			
			//3. create statement
			sql = "SELECT * FROM  user WHERE email = ? AND password = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, user.getEmail());
			ps.setString(2, sb.toString());
			
		    //4. execute query
			rs = ps.executeQuery();

			// if user exists set the isValid variable to true
			if (rs.next()) {
				user.setUserid(rs.getInt("userid"));
				user.setEmail(rs.getString("email"));
				user.setValid(true);
			}
			// if user does not exist set the isValid variable to false
			else{
				user.setValid(false);
			}

			//5. close connection
			con.close();
		}catch(Exception e) {
			e.printStackTrace();		
		}

		return user;
	}
	//get user by email
	public static User getUserByEmail(String email) {
		User user = new User();
		try {
			//call getConnection() method 
			con = ConnectionManager.getConnection();
			
			//3. create statement  
			sql = "SELECT * FROM user WHERE email=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, email);
			
			//execute statement
			rs = ps.executeQuery();

			if (rs.next()) {	            
				user.setUserid(rs.getInt("userid"));
				user.setUsername(rs.getString("username"));
				user.setEmail(rs.getString("email"));				
				user.setPassword(rs.getString("password"));
			}
			//5. close connection
			con.close();
			
		}catch(Exception e) {
			e.printStackTrace();		
		}

		return user;
	}
	
	public static int countUsers() {
	    int count = 0;

	    try {
	        con = ConnectionManager.getConnection();
	        ps = con.prepareStatement("SELECT COUNT(*) AS user_count FROM user");
	        rs = ps.executeQuery();

	        if (rs.next()) {
	            count = rs.getInt("user_count");
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
