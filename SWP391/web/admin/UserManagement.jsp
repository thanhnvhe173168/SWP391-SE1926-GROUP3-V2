<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách người dùng</title>
    
    <!-- Bootstrap & Font Awesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
        }

        .main-content {
            flex: 1;
            padding: 30px;
            background-color: #f9f9f9;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        form.toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 25px;
        }

        .left-controls {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .left-controls input,
        .left-controls select {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            min-width: 160px;
        }

        .right-controls button {
            padding: 10px 18px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            white-space: nowrap;
        }

        .right-controls button:hover {
            background-color: #218838;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }

        th, td {
            padding: 14px 12px;
            text-align: left;
        }

        thead {
            background-color: #007bff;
            color: white;
        }

        tbody tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        tbody tr:hover {
            background-color: #e9ecef;
        }

        .status {
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 13px;
            font-weight: bold;
            color: white;
        }

        .status-active {
            background-color: #28a745;
        }

        .status-locked {
            background-color: #dc3545;
        }

        .actions a {
            margin-right: 10px;
            color: #007bff;
            text-decoration: none;
        }

        .actions a:hover {
            text-decoration: underline;
        }

        .pagination {
            margin-top: 25px;
            text-align: center;
        }

        .pagination a {
            padding: 8px 14px;
            margin: 0 4px;
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

    <!-- Layout container -->
    <div class="d-flex">

        <!-- Sidebar -->
        <jsp:include page="/components/AdminSidebar.jsp" />

        <!-- Main Content -->
        <div class="main-content">
            <h2>Danh sách Người dùng</h2>

            <!-- Toolbar -->
            <form action="getListUser" method="get" class="toolbar">
                <div class="left-controls">
                    <input type="text" name="search" value="${param.search}" placeholder="Nhập tên người dùng">

                    <select name="role">
                        <option value="">Tất cả vai trò</option>
                        <option value="1" ${param.role == '1' ? 'selected' : ''}>Admin</option>
                        <option value="2" ${param.role == '2' ? 'selected' : ''}>Staff</option>
                        <option value="3" ${param.role == '3' ? 'selected' : ''}>Customer</option>
                    </select>

                    <select name="status">
                        <option value="">Tất cả trạng thái</option>
                        <option value="1" ${param.status == '1' ? 'selected' : ''}>Đang hoạt động</option>
                        <option value="2" ${param.status == '2' ? 'selected' : ''}>Đã khóa</option>
                    </select>

                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-search me-1"></i> Tìm kiếm
                    </button>
                </div>

                <div class="right-controls">
                    <button type="button" onclick="location.href = 'admin/CreateUser.jsp'">
                        <i class="fas fa-user-plus me-1"></i> Thêm Người dùng Mới
                    </button>
                </div>
            </form>

            <!-- Table -->
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
                                <a href="viewerUser?id=${o.userID}"><i class="fas fa-eye"></i> View</a>
                                <a href="updateUser?userID=${o.userID}"><i class="fas fa-edit"></i> Edit</a>
                                <a href="deleteUser?uid=${o.userID}" onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng này không?')">
                                    <i class="fas fa-trash"></i> Delete
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Pagination -->
            <div class="pagination">
                <c:forEach var="i" begin="1" end="${totalPages}">
                    <a href="UserListServlet?page=${i}&search=${param.search}&role=${param.role}&status=${param.status}"
                       class="${currentPage == i ? 'active' : ''}">${i}</a>
                </c:forEach>
            </div>

<!--             Back to Home 
            <div class="back-home">
                <button onclick="location.href = 'home'">
                    <i class="fas fa-home me-1"></i> Quay lại Trang chủ
                </button>
            </div>-->
        </div>
    </div>

</body>
</html>
