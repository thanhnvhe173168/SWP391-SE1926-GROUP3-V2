<%-- 
  File: ShipperSidebar.jsp
  Author: Bạn
  Mục đích: Sidebar cố định, highlight link đang active
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String currentPage = request.getServletPath();
%>

<!-- CSS riêng cho sidebar -->
<style>
  .sidebar {
    width: 220px;
    height: 100vh;
    position: fixed; /* Giữ cố định bên trái */
    top: 0;
    left: 0;
    background-color: #343a40;
    color: #fff;
    display: flex;
    flex-direction: column;
    padding: 20px 0;
  }

  .sidebar h4 {
    text-align: center;
    margin-bottom: 30px;
  }

  .sidebar .nav {
    list-style: none;
    padding-left: 0;
    margin: 0;
  }

  .sidebar .nav-item {
    margin-bottom: 5px;
  }

  .sidebar .nav-link {
    color: #ddd;
    text-decoration: none;
    display: block;
    padding: 10px 20px;
    border-radius: 4px;
    transition: background-color 0.2s ease;
  }

  .sidebar .nav-link:hover,
  .sidebar .nav-link.active {
    background-color: rgba(255, 255, 255, 0.2);
    color: #fff;
    font-weight: bold;
  }

  .sidebar .nav-link.logout {
    color: #f44336; /* đỏ */
  }

  .sidebar .nav-link.logout:hover {
    background-color: rgba(255, 255, 255, 0.1);
  }
</style>

<!-- Sidebar content -->
<div class="sidebar">
  <h4>🚚 Shipper Panel</h4>
  <ul class="nav flex-column">
    <li class="nav-item">
      <a class="nav-link <%= currentPage.contains("shipperDashboard") ? "active" : "" %>"
         href="${pageContext.request.contextPath}/shipperDashboard">
         🏠 Dashboard
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link <%= currentPage.contains("shipperOrderList") ? "active" : "" %>"
         href="${pageContext.request.contextPath}/ShipperOrderList">
         📦 Danh sách đơn giao
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link <%= currentPage.contains("updateOrderStatus") ? "active" : "" %>"
         href="${pageContext.request.contextPath}/updateOrderStatus">
         🔄 Cập nhật trạng thái đơn
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link logout"
         href="${pageContext.request.contextPath}/logout">
         🚪 Đăng xuất
      </a>
    </li>
  </ul>
</div>
