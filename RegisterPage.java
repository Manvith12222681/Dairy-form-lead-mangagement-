package Dairyproducts;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Properties;


/**
 * Servlet implementation class RegisterPage
 */
@WebServlet("/registerform")
public class RegisterPage extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/DairyProducts";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Nagu@2004";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement stmt = null;
        PreparedStatement checkStmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Check if the email already exists
            String checkQuery = "SELECT * FROM users WHERE email = ?";
            checkStmt = conn.prepareStatement(checkQuery);
            checkStmt.setString(1, email);
            rs = checkStmt.executeQuery();

            if (rs.next()) {
                // Email already exists
                response.setContentType("text/html");
                out.println("<h2 style='color:red;'>Email already registered. Try another one!</h2>");
                request.getRequestDispatcher("/register.jsp").include(request, response);
            } else {
                // Insert new user with default lead_count = 1
                String sql = "INSERT INTO users (full_name, email, password, lead_count) VALUES (?, ?, ?, ?)";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, fullName);
                stmt.setString(2, email);
                stmt.setString(3, password);
                stmt.setInt(4, 1);  // New user starts with lead_count = 1

                int rowsInserted = stmt.executeUpdate();
                if (rowsInserted > 0) {
                    response.setContentType("text/html");
                    out.println("<h2 style='color:green;'>Registration Successful! Redirecting to login page...</h2>");
                    response.setHeader("Refresh", "2; URL=login.jsp"); // Redirect after 2 seconds
                } else {
                    request.setAttribute("error", "Registration failed. Try again.");
                    request.getRequestDispatcher("/register.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        } finally {
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
