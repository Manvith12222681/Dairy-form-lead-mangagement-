package Dairyproducts;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/loginform")
public class LoginPage extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/DairyProducts";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Nagu@2004";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Check if user exists
            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);
            rs = stmt.executeQuery();

            if (rs.next()) {
                // User authenticated, increase lead count
                PreparedStatement updateStmt = conn.prepareStatement("UPDATE users SET lead_count = lead_count + 1 WHERE email = ?");
                updateStmt.setString(1, email);
                updateStmt.executeUpdate();
                updateStmt.close();

                HttpSession session = request.getSession();
                session.setAttribute("user_email", email);
                response.setContentType("text/html");
                out.println("<h2 style='color:green;'>Login Successful</h2>");
                RequestDispatcher rd = request.getRequestDispatcher("/main.jsp");
                rd.include(request, response);
            } else {
                response.setContentType("text/html");
                out.println("<h2 style='color:red;'>Invalid Login Credentials!</h2>");
                RequestDispatcher req = request.getRequestDispatcher("/login.jsp");
                req.include(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("<h2 style='color:red;'>" + e.getMessage() + "</h2>");
        } 
    }
}
