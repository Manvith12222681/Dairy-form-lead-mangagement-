<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            text-align: center;
        }
        table {
            width: 50%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #9b59b6;
            color: white;
        }
        .cart-container {
            margin: 20px auto;
            max-width: 600px;
        }
        .checkout-btn {
            background: #27ae60;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h1>Your Shopping Cart</h1>
    <div class="cart-container">
        <table>
            <tr>
                <th>Product Name</th>
            </tr>

            <%
                // Retrieve cart session attribute
                List<String> cart = (List<String>) session.getAttribute("cart");
                
                if (cart == null || cart.isEmpty()) {
            %>
                    <tr><td colspan="2">Your cart is empty</td></tr>
            <%
                } else {
                    for (String product : cart) {
            %>
                        <tr><td><%= product %></td></tr>
            <%
                    }
                }
            %>
        </table>
        
        <% if (cart != null && !cart.isEmpty()) { %>
            <button class="checkout-btn">Checkout</button>
        <% } %>
    </div>
</body>
</html>
