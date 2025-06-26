<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.sql.*, java.util.*"%>
<%@ page import="project.connection.ConnectionManager"%>
<!DOCTYPE html>
<html>
<head>
<title style="font-size: 35px;">Monthly User Registration</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
.chart-container {
	display: flex;
	justify-content: space-between;
	align-items: center;
	width: 100%;
	max-width: 800px; /* Adjust width as needed */
	margin: auto;
}

.chart {
	flex: 1;
	margin-right: 20px;
}

.legend {
	flex: 1;
	padding: 20px;
	background-color: #f2f2f2;
	border-radius: 5px;
}

.legend-item {
	display: flex;
	align-items: center;
	margin-bottom: 10px;
}

.legend-color {
	width: 20px;
	height: 10px; /* Adjust height as needed */
	margin-right: 10px;
	background-color: rgba(0, 0, 0, 0.3); /* Default background color */
}
</style>
</head>
<body>

	<%
        List<Map<String, Object>> userDataList = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = ConnectionManager.getConnection();
            String sql = "SELECT DATE_FORMAT(registerTime, '%Y-%m') AS registration_month, COUNT(*) AS user_count FROM user GROUP BY registration_month ORDER BY registration_month";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> userData = new HashMap<>();
                userData.put("month", rs.getString("registration_month"));
                userData.put("userCount", rs.getInt("user_count"));
                userDataList.add(userData);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>

	<div class="chart-container">
		<div class="legend">
			<h5>Month Label</h5>
			<%
                String[] colors = {
                    "rgba(255, 99, 132, 0.8)",
                    "rgba(54, 162, 235, 0.8)",
                    "rgba(255, 206, 86, 0.8)",
                    "rgba(75, 192, 192, 0.8)",
                    "rgba(153, 102, 255, 0.8)",
                    "rgba(255, 159, 64, 0.8)"
                };
                for (int i = 0; i < userDataList.size(); i++) {
                    Map<String, Object> userData = userDataList.get(i);
            %>
			<div class="legend-item">
				<div class="legend-color"
					style="background-color: <%= colors[i % colors.length] %>;"></div>
				<span><%= userData.get("month") %></span>
			</div>
			<% } %>
		</div>

		<div class="chart">
			<canvas id="myChart"></canvas>
		</div>
	</div>

	<script>
        var ctx = document.getElementById('myChart').getContext('2d');
        var chartData = {
            
            datasets: [{
                label: 'User Registrations',
                data: [
                    <% for (Map<String, Object> userData : userDataList) { %>
                        <%= userData.get("userCount") %>,
                    <% } %>
                ],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.8)',
                    'rgba(54, 162, 235, 0.8)',
                    'rgba(255, 206, 86, 0.8)',
                    'rgba(75, 192, 192, 0.8)',
                    'rgba(153, 102, 255, 0.8)',
                    'rgba(255, 159, 64, 0.8)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 1
            }]
        };

        var myChart = new Chart(ctx, {
            type: 'pie',
            data: chartData,
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    title: {
                        display: true,
                        text: 'Monthly User Registration'
                    }
                }
            }
        });
    </script>
</body>
</html>
