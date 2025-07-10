<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String currentPage = request.getRequestURI();
%>
<style>
    .nav-link.active {
        background-color: rgba(255, 255, 255, 0.2);
        font-weight: bold;
    }
</style>

<div class="bg-dark text-white" style="width: 250px; min-height: 100vh;">
    <h4 class="text-center py-3">Admin Panel</h4>
    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link text-white <%= currentPage.contains("dashboard") ? "active" : "" %>" href="dashboard">
                🏠Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white <%= currentPage.contains("getListUser") ? "active" : "" %>" href="staffList">
                <i class="fas fa-users me-2"></i> Quản lý nhân viên
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white <%= currentPage.contains("getListUser") ? "active" : "" %>" href="userList">
                <i class="fas fa-users me-2"></i> Quản lý khách hàng
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white <%= currentPage.contains("getListLaptop") ? "active" : "" %>" href="getListLaptop">
                <i class="fas fa-box me-2"></i> Quản lý sản phẩm
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white <%= currentPage.contains("getListPromotion") ? "active" : "" %>" href="getListPromotion">
                <i class="fas fa-tags me-2"></i> Quản lý khuyến mãi
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white <%= currentPage.contains("getListCategory") ? "active" : "" %>" href="getListCategory">
                <i class="fas fa-list me-2"></i> Quản lý danh mục sản phẩm
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white <%= currentPage.contains("getListBrand") ? "active" : "" %>" href="getListBrand">
                <i class="fas fa-tags me-2"></i> Quản lý nhãn hiệu
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white <%= currentPage.contains("getListBlog") ? "active" : "" %>" href="getListBlog">
                <i class="fas fa-tags me-2"></i> Quản lý blog
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-danger" href="logout">
                <i class="fas fa-sign-out-alt me-2"></i> Đăng xuất
            </a>
        </li>
    </ul>
</div>
