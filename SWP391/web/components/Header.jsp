<%-- 
    Document   : Header
    Created on : May 29, 2025, 10:35:05 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            .navbar-brand img {
                height: 40px;
            }
            .navbar {
                background-color: #343a40;
            }
            .navbar-nav .nav-link {
                color: #ffffff !important;
            }
            .navbar-nav .nav-link:hover {
                color: #17a2b8 !important;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark">
            <div class="container-fluid">
                <!-- Logo -->
                <a class="navbar-brand" href="index.jsp">
                    <img src="https://via.placeholder.com/150x40?text=Laptop+Store" alt="Laptop Store Logo">
                </a>
                <!-- Toggle button for mobile -->
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <!-- Navigation items -->
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="home">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="products.jsp">Products</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="contact.jsp">Contact</a>
                        </li>
                        <%if(session.getAttribute("user") != null) {
                            User user = (User) session.getAttribute("user");
                        %>
                         <li class="nav-item">
                            <a class="nav-link" href="CartSeverlet">Cart</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="OrderList">Order</a>
                        </li>
                         <li class="nav-item">
                            <a class="nav-link" href="wishList">WishList</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="viewProfile"><%=user.getFullName()%></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="logout">Login</a>
                        </li>
                        <%} else {%>      
                        <li class="nav-item">
                            <a class="nav-link" href="login">Login</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="register">Register</a>
                        </li>
                        <%}%>
                    </ul>
                </div>
            </div>
        </nav>
    </body>
</html>