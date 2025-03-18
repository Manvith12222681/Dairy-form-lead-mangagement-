<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dairy Products Store</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        header {
            background: #9b59b6;
            padding: 1rem;
            color: white;
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo h1 {
            font-size: 2rem;
            font-weight: bold;
        }

        .cart-icon {
            position: relative;
            cursor: pointer;
        }

        .cart-count {
            position: absolute;
            top: -8px;
            right: -8px;
            background: #e74c3c;
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
        }

        nav {
            background: #8e44ad;
            padding: 1rem;
        }

        nav ul {
            max-width: 1200px;
            margin: 0 auto;
            list-style: none;
            display: flex;
            justify-content: center;
            gap: 2rem;
        }

        nav a {
            color: white;
            text-decoration: none;
            font-size: 1.1rem;
            transition: color 0.3s;
        }

        nav a:hover {
            color: #ddd;
        }

        .main-content {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }

        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            padding: 1rem;
        }

        .product-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.3s;
        }

        .product-card:hover {
            transform: translateY(-5px);
        }

        .product-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .product-info {
            padding: 1rem;
        }

        .product-title {
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
            color: #333;
        }

        .product-price {
            font-size: 1.1rem;
            color: #9b59b6;
            font-weight: bold;
            margin-bottom: 1rem;
        }

        .add-to-cart {
            background: #9b59b6;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 1rem;
            transition: background 0.3s;
        }

        .add-to-cart:hover {
            background: #8e44ad;
        }

        @media (max-width: 768px) {
            nav ul {
                flex-direction: column;
                align-items: center;
                gap: 1rem;
            }

            .products-grid {
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="header-content">
            <div class="logo">
                <h1>Dairy Delights</h1>
            </div>
            <div class="cart-icon" onclick="openCart()">
                <i class="fas fa-shopping-cart fa-2x"></i>
                <span class="cart-count">
                    <% 
                        Integer cartSize = (Integer) session.getAttribute("cartSize");
                        out.print(cartSize == null ? "0" : cartSize);
                    %>
                </span>
            </div>
        </div>
    </header>

    <nav>
        <ul>
            <li><a href="main.jsp">Home</a></li>
            <li><a href="about.jsp">About Us</a></li>
            <li><a href="contact.jsp">Contact Us</a></li>
            <li><a href="cart.jsp">Cart</a></li>
        </ul>
    </nav>

    <main class="main-content">
        <div class="products-grid">
            <%
                String[][] products = {
                    {"Pure Cow Ghee", "15.99", "https://5.imimg.com/data5/SELLER/Default/2021/3/KO/QG/XG/3922575/desi-ghee-500x500.jpg"},
                    {"Natural Honey", "12.99", "https://m.media-amazon.com/images/I/61KSqmN0KYL._SL1500_.jpg"},
                    {"Fresh Milk", "3.99", "https://www.dairyfarmers.ca/sites/default/files/styles/header_image_1025_x_300/public/header-images/headers_milk-products2.jpg?itok=WCki6JFZ"},
                    {"Fresh Curd", "4.99", "https://www.indianhealthyrecipes.com/wp-content/uploads/2022/04/homemade-curd-yogurt-recipe.jpg"}
                };

                for (String[] product : products) {
            %>
            <div class="product-card">
                <img src="<%= product[2] %>" alt="<%= product[0] %>" class="product-image">
                <div class="product-info">
                    <h3 class="product-title"><%= product[0] %></h3>
                    <p class="product-price">$<%= product[1] %></p>
                    
                    <form action="AddToCartServlet" method="post" onsubmit="return showAddedMessage('<%= product[0] %>')">
                        <input type="hidden" name="productName" value="<%= product[0] %>">
                        <input type="hidden" name="productPrice" value="<%= product[1] %>">
                        <button type="submit" class="add-to-cart">Add to Cart</button>
                    </form>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </main>

    <script>
        function openCart() {
            window.location.href = 'cart.jsp';
        }

        function showAddedMessage(productName) {
            alert(productName + " has been added to your cart!");
            return true;
        }
    </script>
</body>
</html>
