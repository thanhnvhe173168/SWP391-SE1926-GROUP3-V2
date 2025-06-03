<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách người dùng</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f9f9f9;
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

            .status {
                padding: 5px 10px;
                border-radius: 5px;
                font-size: 12px;
                color: white;
            }

            .status-active {
                background-color: #28a745;
            }

            .status-locked {
                background-color: #dc3545;
            }

            .actions a {
                margin-right: 8px;
                color: #007bff;
                text-decoration: none;
            }

            .actions a:hover {
                text-decoration: underline;
            }

            .pagination {
                margin-top: 20px;
                text-align: center;
            }

            .pagination a {
                padding: 6px 12px;
                margin: 0 5px;
                border: none;
                background-color: #007bff;
                color: white;
                border-radius: 4px;
                text-decoration: none;
            }

            .pagination a.active {
                background-color: #0056b3;
                font-weight: bold;
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

        <h2>Danh sách Người dùng</h2>

        <form class="toolbar" action="UserListServlet" method="get">
            <input type="text" name="search" placeholder="Tìm theo tên người dùng hoặc họ tên" value="${param.search}">
            <select name="role">
                <option value="">Tất cả Vai trò</option>
                <option value="1" ${param.role == '1' ? 'selected' : ''}>Admin</option>
                <option value="2" ${param.role == '2' ? 'selected' : ''}>Staff</option>
                <option value="3" ${param.role == '3' ? 'selected' : ''}>Customer</option>
            </select>
            <select name="status">
                <option value="">Tất cả Trạng thái</option>
                <option value="1" ${param.status == '1' ? 'selected' : ''}>Đang hoạt động</option>
                <option value="2" ${param.status == '2' ? 'selected' : ''}>Đã khóa</option>
            </select>
            <button type="submit">Tìm kiếm</button>
            <button type="button" onclick="location.href = 'admin/CreateUser.jsp'">+ Thêm Người dùng Mới</button>
        </form>

        <table>
            <thead>
                <tr>
                    <th>User ID</th>
                    <th>Full name</th>
                    <th>Role</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${listU}" var="o">
                    <tr>
                        <td>${o.userID}</td>
                        <td>${o.fullName}</td>
                        <td>
                            <c:choose>
                                <c:when test="${o.roleID == 1}">Admin</c:when>
                                <c:when test="${o.roleID == 2}">Staff</c:when>
                                <c:when test="${o.roleID == 3}">Customer</c:when>
                                <c:otherwise>Unknown</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <span class="status
                                  <c:choose>
                                      <c:when test="${o.statusID == 1}">status-active</c:when>
                                      <c:otherwise>status-locked</c:otherwise>
                                  </c:choose>">
                                <c:choose>
                                    <c:when test="${o.statusID == 1}">Đang hoạt động</c:when>
                                    <c:otherwise>Đã khóa</c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                        <td class="actions">
                            <a href="viewerUser?id=${o.userID}">View</a>
                            <a href="updateUser?userID=${o.userID}">Edit</a>
                            <a href="deleteUser?uid=${o.userID}">Delete</a>

                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Phân trang -->
        <div class="pagination">
            <c:forEach var="i" begin="1" end="${totalPages}">
                <a href="UserListServlet?page=${i}&search=${param.search}&role=${param.role}&status=${param.status}"
                   class="${currentPage == i ? 'active' : ''}">${i}</a>
            </c:forEach>
        </div>

        <!-- Nút quay lại -->
        <div class="back-home">
            <button onclick="location.href = 'home.jsp'">Quay lại Trang chủ</button>
        </div>

    </body>
</html>
