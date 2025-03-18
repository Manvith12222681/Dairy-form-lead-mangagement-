package Dairyproducts;

import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Retrieve or initialize cart
        List<String> cart = (List<String>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }
        
        // Add selected product to the cart
        String productName = request.getParameter("productName");
        cart.add(productName);
        
        // Update session attributes
        session.setAttribute("cart", cart);
        session.setAttribute("cartSize", cart.size());
        
        // Redirect back to main page
        response.sendRedirect("main.jsp");
    }
}
