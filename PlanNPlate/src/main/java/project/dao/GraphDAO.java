package project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import project.connection.ConnectionManager;
import project.model.UserData;
import project.model.RecipeData;

public class GraphDAO {
	
	private static Connection con = null;
	private static ResultSet rs = null; 
	private static PreparedStatement ps=null;
	private static Statement stmt = null;

	private static String sql=null;
	
	public List<UserData> getMonthlyUserData() {
        List<UserData> userDataList = new ArrayList<>();
        
        try {
            con = ConnectionManager.getConnection();
            String sql = "SELECT DATE_FORMAT(registerTime, '%Y-%m') AS registration_month, COUNT(*) AS user_count FROM user GROUP BY registration_month ORDER BY registration_month";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while(rs.next()) {
                String month = rs.getString("registration_month");
                int userCount = rs.getInt("user_count");
                userDataList.add(new UserData(month, userCount));
            }

            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (ps != null) try { ps.close(); } catch (Exception e) {}
            if (con != null) try { con.close(); } catch (Exception e) {}
        } 
        
        return userDataList;
    }
	
	public List<RecipeData> getMonthlyRecipeData() {
        List<RecipeData> userDataList = new ArrayList<>();
        
        try {
            con = ConnectionManager.getConnection();
            String sql = "SELECT DATE_FORMAT(addTime, '%Y-%m') AS registration_month, COUNT(*) AS recipe_count FROM recipe GROUP BY registration_month ORDER BY registration_month";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while(rs.next()) {
                String month = rs.getString("registration_month");
                int userCount = rs.getInt("recipe_count");
                userDataList.add(new RecipeData(month, userCount));
            }

            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (ps != null) try { ps.close(); } catch (Exception e) {}
            if (con != null) try { con.close(); } catch (Exception e) {}
        } 
        
        return userDataList;
    }
	 
}
