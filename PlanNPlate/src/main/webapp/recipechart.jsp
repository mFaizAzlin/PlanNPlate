<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="project.connection.ConnectionManager" %>
<!DOCTYPE html>
<html>
<head>
    <title>Monthly Recipe Data</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .chart-container {
            width: 100%;
            max-width: 600px; /* Adjust width as needed */
            height: 400px; /* Adjust height as needed */
            margin: auto;
        }
    </style>
</head>
<body>

    <%
        List<Map<String, Object>> recipeDataList = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = ConnectionManager.getConnection();
            String sql = "SELECT DATE_FORMAT(addTime, '%Y-%m') AS registration_month, COUNT(*) AS recipe_count FROM recipe GROUP BY registration_month ORDER BY registration_month";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> recipeData = new HashMap<>();
                recipeData.put("month", rs.getString("registration_month"));
                recipeData.put("recipeCount", rs.getInt("recipe_count"));
                recipeDataList.add(recipeData);
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
        <canvas id="myRecipeChart"></canvas>
    </div>

    <script>
        var ctx = document.getElementById('myRecipeChart').getContext('2d');
        var recipeData = {
            labels: [
                <% for (Map<String, Object> data : recipeDataList) { %>
                    '<%= data.get("month") %>',
                <% } %>
            ],
            datasets: [{
                label: 'Recipe Counts',
                data: [
                    <% for (Map<String, Object> data : recipeDataList) { %>
                        <%= data.get("recipeCount") %>,
                    <% } %>
                ],
                fill: false, // Ensures line chart is not filled
                borderColor: 'rgba(54, 162, 235, 1)', // Color of the line
                borderWidth: 1,
                pointBackgroundColor: 'rgba(54, 162, 235, 1)', // Color of data points
                pointRadius: 5, // Size of data points
                pointHoverRadius: 7, // Size of data points on hover
                tension: 0.1 // Curve tension of the line
            }]
        };

        var myRecipeChart = new Chart(ctx, {
            type: 'line', // Changed to line chart type
            data: recipeData,
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: true,
                        position: 'top',
                    },
                    title: {
                        display: true,
                        text: 'Monthly Recipe Data'
                    }
                },
                scales: {
                    x: {
                        display: true,
                        title: {
                            display: true,
                            text: 'Month'
                        }
                    },
                    y: {
                        display: true,
                        title: {
                            display: true,
                            text: 'Recipe Count'
                        }
                    }
                }
            }
        });
    </script>
</body>
</html>
