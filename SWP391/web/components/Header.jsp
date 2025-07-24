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
                background: linear-gradient(rgb(228, 84, 100) -13%, rgb(215, 0, 24));
            }
            .navbar-nav .nav-link {
                color: #ffffff !important;
            }
            .dropdown-menu {
                background-color: #ffffff;
            }
            .dropdown-item {
                color: #000000;
            }
            .dropdown-item:hover {
                background-color: #f8f9fa;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark">
            <div class="container-fluid">
                <!-- Logo -->
                <a class="navbar-brand" href="home">
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
                            <a class="nav-link" href="productList">Sản phẩm</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="promotionList">Khuyến mãi</a>
                        </li>
                        <%if(session.getAttribute("user") != null) {
                            User user = (User) session.getAttribute("user");
                        %>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <%=user.getFullName()%>
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="userDropdown">
                                <li><a class="dropdown-item" href="CartServlet">Giỏ hàng</a></li>
                                <li><a class="dropdown-item" href="OrderList">Lịch sử mua hàng</a></li>
                                <li><a class="dropdown-item" href="wishList">Sản phẩm yêu thích</a></li>
                                 <li><a class="dropdown-item" href="changePassword">Đổi mật khẩu</a></li>
                                 <li><a class="dropdown-item" href="createContribute">Gửi góp ý</a></li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="logout">Logout</a>
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