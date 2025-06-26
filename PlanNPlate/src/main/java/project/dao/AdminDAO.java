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

import project.connection.ConnectionManager;
import project.model.Admin;

public class AdminDAO {
	private static Connection con = null;
	private static ResultSet rs = null; 
	private static PreparedStatement ps=null;
	private static Statement stmt = null;

	private static String sql=null;

	//login
	public static Admin login(Admin admin) throws NoSuchAlgorithmException{

		//convert the password to MD5
		MessageDigest md = MessageDigest.getInstance("MD5");
		md.update(admin.getPassword().getBytes());

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
			sql = "SELECT * FROM  admin WHERE email = ? AND password = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, admin.getEmail());
			ps.setString(2, sb.toString());

			//4. execute query
			rs = ps.executeQuery();

			// if admin exists set the isValid variable to true
			if (rs.next()) {
				admin.setAdminID(rs.getInt("adminID"));
				admin.setEmail(rs.getString("email"));
				admin.setValid(true);
			}
			// if admin does not exist set the isValid variable to false
			else{
				admin.setValid(false);
			}

			//5. close connection
			con.close();
		}catch(Exception e) {
			e.printStackTrace();		
		}

		return admin;
	}

	//get admin by email
	public static Admin getAdminByEmail(String email) {
		Admin admin = new Admin();
		try {
			//call getConnection() method 
			con = ConnectionManager.getConnection();

			//3. create statement  
			sql = "SELECT * FROM admin WHERE email=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, email);

			//execute statement
			rs = ps.executeQuery();

			if (rs.next()) {	            
				admin.setAdminID(rs.getInt("adminID"));
				admin.setName(rs.getString("name"));
				admin.setEmail(rs.getString("email"));				
				admin.setPassword(rs.getString("password"));
				admin.setAddress(rs.getString("address"));
				admin.setPhonenum(rs.getString("phonenum"));
				admin.setQuote(rs.getString("quote"));
			}
			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();		
		}

		return admin;
	}

	//get admin by id
	public static Admin getAdminByID(String adminIdParam) {
		Admin admin = new Admin();
		try {
			//call getConnection() method 
			con = ConnectionManager.getConnection();

			//3. create statement  
			sql = "SELECT * FROM admin WHERE adminID=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, adminIdParam);

			//execute statement
			rs = ps.executeQuery();

			if (rs.next()) {	            
				admin.setAdminID(rs.getInt("adminID"));
				admin.setName(rs.getString("name"));
				admin.setEmail(rs.getString("email"));				
				admin.setPassword(rs.getString("password"));
				admin.setAddress(rs.getString("address"));
				admin.setPhonenum(rs.getString("phonenum"));
				admin.setQuote(rs.getString("quote"));
			}
			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();		
		}

		return admin;
	}

	//add admin
	public static void addAdmin(Admin admin) {
		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();
			//3. create statement
			String sql = "INSERT INTO admin(name,email,password,address,phonenum,quote,image)VALUES(?,?,?,?,?,?,?)";
			ps = con.prepareStatement(sql);

			ps.setString(1, admin.getName());
			ps.setString(2, admin.getEmail());
			ps.setString(3, admin.getPassword());
			ps.setString(4, admin.getAddress());
			ps.setString(5, admin.getPhonenum());
			ps.setString(6, admin.getQuote());
			ps.setBlob(7, admin.getFile());

			//4. execute query
			ps.executeUpdate();

			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}	
	}

	//update admin
	public static void updateAdmin(Admin admin) {
		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();
			//3. create statement
			ps = con.prepareStatement("UPDATE admin SET name=?,email=?, address=?, phonenum=?, quote=? WHERE adminID=?");

			ps.setString(1, admin.getName());
			ps.setString(2, admin.getEmail());
			ps.setString(3, admin.getAddress());
			ps.setString(4, admin.getPhonenum());
			ps.setString(5, admin.getQuote());
			ps.setInt(6, admin.getAdminID());

			//4. execute query
			ps.executeUpdate();

			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}	
	}

	//update admin password
	public static void updateAdminPassword(Admin admin) throws NoSuchAlgorithmException{
		MessageDigest md = MessageDigest.getInstance("MD5");
		md.update(admin.getPassword().getBytes());
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
			ps = con.prepareStatement("UPDATE admin SET password=? WHERE adminID=?");

			ps.setString(1, sb.toString());
			ps.setInt(2, admin.getAdminID());

			//4. execute query
			ps.executeUpdate();

			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}	
	}

	public static void updateAdminImage(Admin admin) {
		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();
			//3. create statement
			ps = con.prepareStatement("UPDATE admin SET image=? WHERE adminID=?");

			ps.setBlob(1, admin.getFile());
			ps.setInt(2, admin.getAdminID());

			//4. execute query
			ps.executeUpdate();

			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}	
	}

	//delete admin
	public static void deleteAdmin(int adminID) {
		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();
			//3. create statement
			String sql = "DELETE FROM admin WHERE adminID=?";
			ps = con.prepareStatement(sql);

			ps.setInt(1, adminID);
			//4. execute query
			ps.executeUpdate();

			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}	
	}

	//get all admins
	public static List<Admin> getAllAdmin() {

		List<Admin> admins = new ArrayList<Admin>();

		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();

			//3. create statement
			stmt = con.createStatement();
			String sql = "SELECT * FROM admin ORDER BY adminID";

			//4. execute query
			rs = stmt.executeQuery(sql);

			while(rs.next()) {		//process result
				Admin admin = new Admin();
				admin.setAdminID(rs.getInt("adminID"));

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

				admin.setImage(image);
				inputStream.close();
				outputStream.close();

				//recipe.setImage(rs.getString("image"));
				admin.setName(rs.getString("name"));
				admin.setEmail(rs.getString("email"));
				admin.setPassword(rs.getString("password"));
				admin.setAddress(rs.getString("address"));
				admin.setPhonenum(rs.getString("phonenum"));
				admin.setQuote(rs.getString("quote"));
				admins.add(admin);

			}
			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}	
		return admins;
	}

	public static List<Admin> getAllRecipeByAdminID(int adminID) {
		List<Admin> admins = new ArrayList<Admin>(); 
		try { 
			//call getConnection() method 
			con = ConnectionManager.getConnection();

			//3. create statement 
			String sql = "SELECT * FROM admin WHERE adminID=?";
			ps = con.prepareStatement(sql);

			ps.setInt(1,adminID);

			//4. execute query
			rs = ps.executeQuery();

			while (rs.next()) { 
				Admin admin = new Admin();
				admin.setAdminID(rs.getInt("adminID"));	  

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

				admin.setImage(image);
				inputStream.close();
				outputStream.close();

				//recipe.setImage(rs.getString("image"));
				admin.setName(rs.getString("name"));
				admin.setEmail(rs.getString("email"));
				admin.setPassword(rs.getString("password"));
				admin.setAddress(rs.getString("address"));
				admin.setPhonenum(rs.getString("phonenum"));
				admin.setQuote(rs.getString("quote"));
				admins.add(admin);
			} 

			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}

		return admins; 
	}

	public static Admin getAdmin(int adminID) {
		Admin admin = new Admin();
		try {			
			//call getConnection() method
			con = ConnectionManager.getConnection();
			//3. create statement
			ps = con.prepareStatement("SELECT * FROM admin WHERE adminID=?");

			//set parameter values
			ps.setInt(1, adminID);

			//4. execute query
			rs = ps.executeQuery();

			//process ResultSet and set the values to the Shawl object
			if(rs.next()) {
				admin.setAdminID(rs.getInt("adminID"));

				//recipe.setImage(rs.getString("image"));
				admin.setName(rs.getString("name"));
				admin.setEmail(rs.getString("email"));
				admin.setPassword(rs.getString("password"));
				admin.setAddress(rs.getString("address"));
				admin.setPhonenum(rs.getString("phonenum"));
				admin.setQuote(rs.getString("quote"));

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

				admin.setImage(image);
				inputStream.close();
				outputStream.close();
			}

			//5. close connection
			con.close();

		}catch(Exception e) {
			e.printStackTrace();
		}	
		return admin;
	}

	public static boolean emailExists(String email) {
		boolean exists = false;

		try {
			con = ConnectionManager.getConnection();

			String sql = "SELECT * FROM admin WHERE email = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, email);

			rs = ps.executeQuery();

			if (rs.next()) {
				exists = true;
			}

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return exists;
	}
	
	public static int countAdmin() {
	    int count = 0;

	    try {
	        con = ConnectionManager.getConnection();
	        ps = con.prepareStatement("SELECT COUNT(*) AS admin_count FROM admin");
	        rs = ps.executeQuery();

	        if (rs.next()) {
	            count = rs.getInt("admin_count");
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
