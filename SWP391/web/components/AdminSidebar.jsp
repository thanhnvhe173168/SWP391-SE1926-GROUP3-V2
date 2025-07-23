<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
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
            <a class="nav-link text-white <%= currentPage.contains("getListUser") ? "active" : "" %>" href="${pageContext.request.contextPath}/userList">
                <i class="fas fa-users me-2"></i> Quản lý khách hàng
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white <%= currentPage.contains("getListLaptop") ? "active" : "" %>" href="${pageContext.request.contextPath}/getListLaptop">
                <i class="fas fa-box me-2"></i> Quản lý sản phẩm
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white <%= currentPage.contains("getListOrder") ? "active" : "" %>" href="${pageContext.request.contextPath}/OrderManager">
                <i class="fas fa-box me-2"></i> Quản lý đơn hàng
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white <%= currentPage.contains("VoucherList") ? "active" : "" %>" href="${pageContext.request.contextPath}/VoucherList">
                <i class="fas fa-box me-2"></i> Quản lý Voucher
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white <%= currentPage.contains("getListPromotion") ? "active" : "" %>" href="${pageContext.request.contextPath}/getListPromotion">
                <i class="fas fa-tags me-2"></i> Quản lý khuyến mãi
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white <%= currentPage.contains("getListContribute") ? "active" : "" %>" href="${pageContext.request.contextPath}/getListContribute">
                <i class="fas fa-tags me-2"></i> Ý kiến khách hàng
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white <%= currentPage.contains("feedBackList") ? "active" : "" %>" href="${pageContext.request.contextPath}/feedBackList">
                <i class="fas fa-tags me-2"></i> Quản lý đánh giá
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white <%= currentPage.contains("getListCategory") ? "active" : "" %>" href="${pageContext.request.contextPath}/getListCategory">
                <i class="fas fa-list me-2"></i> Quản lý danh mục sản phẩm
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white <%= currentPage.contains("getListBrand") ? "active" : "" %>" href="${pageContext.request.contextPath}/getListBrand">
                <i class="fas fa-tags me-2"></i> Quản lý nhãn hiệu
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-white <%= currentPage.contains("getListBlog") ? "active" : "" %>" href="${pageContext.request.contextPath}/getListBlog">
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
