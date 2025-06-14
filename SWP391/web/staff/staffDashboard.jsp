<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Dashboard Staff</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f9f9f9;
                margin: 0;
                padding: 0;
            }

            .sidebar {
                width: 250px;
                height: 100vh;
                background-color: #2c2c2c;
                padding-top: 20px;
                position: fixed;
                top: 0;
                left: 0;
            }

            .sidebar-title {
                text-align: center;
                font-size: 22px;
                color: white;
                font-weight: bold;
                margin-bottom: 20px;
            }

            .sidebar a {
                display: block;
                padding: 15px 20px;
                color: #fff;
                text-decoration: none;
                font-size: 16px;
            }

            .sidebar a:hover {
                background-color: #444;
            }

            .sidebar a.active {
                background-color: #555;
            }

            .content {
                margin-left: 260px;
                padding: 20px;
            }

            h2 {
                margin-bottom: 20px;
            }

            form.toolbar {
                margin-bottom: 20px;
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                align-items: center;
            }

            .toolbar input[type="text"],
            .toolbar button {
                padding: 8px;
                border-radius: 4px;
                border: 1px solid #ccc;
            }

            .toolbar button {
                background-color: #6c63ff;
                color: white;
                cursor: pointer;
                border: none;
            }

            .toolbar button:hover {
                background-color: #5848e5;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: white;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 0 10px rgba(0,0,0,0.05);
            }

            th, td {
                padding: 12px;
                text-align: left;
            }

            thead {
                background-color: #007bff;
                color: white;
            }

            tbody tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            .actions a {
                margin-right: 8px;
                color: #007bff;
                text-decoration: none;
            }

            .actions a:hover {
                text-decoration: underline;
            }

            .back-home {
                margin-top: 30px;
                text-align: center;
            }

            .back-home button {
                padding: 10px 20px;
                background-color: #6c757d;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .back-home button:hover {
                background-color: #5a6268;
            }
        </style>
    </head>
    <body>

        <!-- Sidebar -->
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-title">Staff Management</div>
            <a href="home">🏠 Trang chủ</a>
            <a href="productManagement">📦 Quản lý sản phẩm</a>
            <a href="recentOrders">🛒 Quản lý đơn hàng</a>
            <a href="RevenueManagementServlet">💰 Quản lý doanh thu</a>
            <a href="inventoryManagement">📊 Quản lý tồn kho</a>
            <a href="profile">👤 Thông tin cá nhân</a>
            <a href="/swp391/home" style="color: red;">↩️ Đăng xuất</a>
        </div>


    </body>
</html>
