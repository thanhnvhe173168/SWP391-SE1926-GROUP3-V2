<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản lý Sản phẩm</title>
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
            .toolbar select {
                padding: 8px;
                border-radius: 4px;
                border: 1px solid #ccc;
            }

            .toolbar button {
                padding: 8px 16px;
                border: none;
                border-radius: 4px;
                background-color: #6c63ff;
                color: white;
                cursor: pointer;
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
        </style>
    </head>
    <body>

        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-title">Staff Management</div>
            <a href="home">🏠 Trang chủ</a>
            <a href="productManagement">📦 Quản lý sản phẩm</a>
            <a href="recentOrders">🛒 Quản lý đơn hàng </a>
            <a href="RevenueManagementServlet">💰 Quản lý doanh thu</a>
            <a href="inventoryManagement">📊 Quản lý tồn kho</a>
            <a href="profile">👤 Thông tin cá nhân</a>
            <a href="/swp391/home" style="color: red;">↩️ Đăng xuất</a>
        </div>

        <!-- Content -->
        <div class="content">
            <h2>Danh sách Sản phẩm</h2>

            <form action="productManagement" method="get" class="toolbar">
                <input type="text" name="search" value="${param.search}" placeholder="Nhập tên laptop">

                <select name="brand">
                    <option value="">Tất cả hãng</option>
                    <option value="1" ${param.brand == '1' ? 'selected' : ''}>Asus</option>
                    <option value="2" ${param.brand == '2' ? 'selected' : ''}>Dell</option>
                    <option value="3" ${param.brand == '3' ? 'selected' : ''}>HP</option>
                </select>

                <select name="cpu">
                    <option value="">Tất cả CPU</option>
                    <option value="i5" ${param.cpu == 'i5' ? 'selected' : ''}>Intel Core i5</option>
                    <option value="i7" ${param.cpu == 'i7' ? 'selected' : ''}>Intel Core i7</option>
                    <option value="R5" ${param.cpu == 'R5' ? 'selected' : ''}>Ryzen 5</option>
                </select>

                <button type="submit">Tìm kiếm</button>

                <button type="button" onclick="location.href = 'addProduct.jsp'" style="background-color: #28a745; margin-left: auto;">
                    + Thêm Sản phẩm Mới
                </button>
            </form>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên Laptop</th>
                        <th>Giá</th>
                        <th>Lượng hàng trong kho</th>
                        <th>Miêu tả</th>
                        <th>Ổ cứng</th>
                        <th>Bảo hành</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="o" items="${rslaptop}">
                        <tr>
                            <td>${o.laptopID}</td>
                            <td>${o.laptopName}</td>
                            <td>${o.price}</td>
                            <td>${o.stock}</td>
                            <td>${o.description}</td>
                            <td>${o.hardDrive}</td>
                            <td>${o.warrantyPeriod}</td>
                            <td class="actions">
                                <a href="editProduct?lid=${o.laptopID}">Edit</a>
                                <a href="deleteProduct?lid=${o.laptopID}">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

    </body>
</html>
