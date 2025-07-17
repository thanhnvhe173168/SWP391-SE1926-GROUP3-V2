<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="model.*" %>
<%@ page import="dao.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Shipper Dashboard</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
            .wrapper {
                display: flex;
            }

            .page-container {
                margin-left: 220px;
                padding: 30px;
                min-height: 30vh; /* Thay vì 100vh */
                background-color: #f4f6f9;
                width: calc(100% - 220px);
                font-family: Arial, sans-serif;
            }


            .welcome-title {
                font-size: 28px;
                font-weight: bold;
                margin-bottom: 10px;
                color: #333;
            }

            .sub-title {
                font-size: 16px;
                color: #666;
                margin-bottom: 30px;
            }

            .status-cards {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
                gap: 20px;
                margin-bottom: 40px;
            }

            .card {
                background-color: #ffffff;
                border-radius: 12px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                padding: 20px;
                text-align: center;
                transition: transform 0.2s ease;
            }

            .card:hover {
                transform: translateY(-4px);
            }

            .card h3 {
                margin: 0;
                font-size: 18px;
                color: #555;
            }

            .card .count {
                font-size: 36px;
                font-weight: bold;
                color: #007bff;
                margin-top: 10px;
            }

            /* Icon shipper dưới cùng */
            .shipper-icon {
                text-align: center;
                margin: 60px 0 30px 0;
            }

            .shipper-icon i {
                font-size: 100px;
                color: #007bff;
            }

            .shipper-icon p {
                margin-top: 10px;
                font-size: 18px;
                color: #444;
            }
        </style>
        <%
            OrderDAO odao = new OrderDAO();
        %>
    </head>
    <body>
        <div class="wrapper">
            <jsp:include page="/components/ShipperSidebar.jsp"></jsp:include>
                <div class="page-container">
                    <div class="welcome-title">Chào mừng bạn đến với trang Shipper</div>
                    <div class="sub-title">Dưới đây là tình hình các đơn hàng bạn đang phụ trách</div>

                    <!-- Thống kê trạng thái đơn hàng -->
                    <div class="status-cards">
                        <div class="card">
                            <h3>Đơn chờ lấy</h3>
                            <div class="count"><%= odao.countOrdersByStatusID(9) %></div>
                    </div>
                    <div class="card">
                        <h3>Đang giao</h3>
                        <div class="count"><%= odao.countOrdersByStatusID(11) %></div>
                    </div>
                    <div class="card">
                        <h3>Đã giao</h3>
                        <div class="count"><%= odao.countOrdersByStatusID(12) %></div>
                    </div>
                    <div class="card">
                        <h3>Giao thất bại</h3>
                        <div class="count"><%= odao.countOrdersByStatusID(13) %></div>
                    </div>
                    <div class="card">
                        <h3>Đang hoàn</h3>
                        <div class="count"><%= odao.countOrdersByStatusID(24) %></div>
                    </div>
                </div>
            </div> <!-- Kết thúc page-container -->
        </div> <!-- Kết thúc wrapper -->

        <!-- Icon xe shipper ở cuối trang -->
        <div class="shipper-icon">
            <i class="fas fa-truck-moving"></i>
            <p>Shipper luôn sẵn sàng giao hàng!</p>
        </div>
    </body>
</html>
