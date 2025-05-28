<%-- 
    Document   : menuAdmin
    Created on : Mar 15, 2025, 12:38:54 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <title>JSP Page</title>
        <style>
            .nav-link.active {
                background-color: rgba(255, 255, 255, 0.2);
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <%
          String currentPage = (String) request.getRequestURI();
        %>
        <div class="bg-dark text-white" style="width: 250px; height: calc(100vh - 118px)">
            <h4 class="text-center py-3">Admin Panel</h4>
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link text-white <%=currentPage.contains("paymentManagement.jsp") ? "active" : ""%>" href="statistic"><i class="fas fa-tachometer-alt"></i>Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white <%=currentPage.contains("UserManagement.jsp") ? "active" : ""%>" href="getListUser" >
                        <i class="fas fa-users"></i> Quản lý người dùng
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white <%=currentPage.contains("LaptopManagement.jsp") ? "active" : ""%>" href="getListLaptop">
                        <i class="fas fa-box"></i> Quản lý sản phẩm
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white <%=currentPage.contains("CategoryManagement.jsp") ? "active" : ""%>" href="getListCategory">
                        <i class="fas fa-shopping-cart"></i> Quản lý danh mục sản phẩm
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white <%=currentPage.contains("BrandManagement.jsp") ? "active" : ""%>" href="getListBrand">
                        <i class="fas fa-shopping-cart"></i> Quản lý nhãn hiệu
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link text-danger" href="logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
                </li>
            </ul>
        </div>
    </body>
</html>
