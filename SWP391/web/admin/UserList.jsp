<%-- 
    Document   : UserList
    Created on : Jun 17, 2025, 10:46 PM
    Author     : linhd
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách khách hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f3f4f6;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }

        /* Sidebar cố định */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            height: 100%;
            background-color: #222;
            color: white;
            padding: 20px 0;
            z-index: 1000;
        }

        .sidebar a {
            color: #bbb;
            padding: 10px 20px;
            text-decoration: none;
            display: block;
        }

        .sidebar a:hover {
            color: #fff;
            background-color: #333;
        }

        .sidebar .active {
            color: #fff;
            background-color: #555;
        }

        /* Main content */
        .main-content {
            margin-left: 250px;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 12px;
            min-height: calc(100vh - 40px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
        }

        h2 {
            color: #111827;
            font-size: 26px;
            font-weight: 600;
            margin-bottom: 20px;
        }

        /* Toolbar */
        .toolbar {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            gap: 10px;
        }

        .toolbar .left-controls {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .toolbar .left-controls input,
        .toolbar .left-controls select {
            padding: 8px 12px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            background-color: #ffffff;
            min-width: 180px;
        }

        .toolbar .btn-primary {
            background-color: #2563eb;
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }

        .toolbar .btn-primary:hover {
            background-color: #1d4ed8;
        }

        /* Table */
        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 12px;
            overflow: hidden;
            background-color: white;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        thead {
            background-color: #2563eb;
            color: white;
        }

        thead th {
            padding: 14px;
            text-align: left;
            font-size: 14px;
        }

        tbody td {
            padding: 14px;
            font-size: 14px;
            border-bottom: 1px solid #f3f4f6;
            vertical-align: middle;
        }

        tbody tr:nth-child(even) {
            background-color: #f9fafb;
        }

        /* Status */
        .status {
            padding: 6px 12px;
            border-radius: 999px;
            font-weight: 600;
            font-size: 13px;
            display: inline-block;
        }

        .status-active {
            background-color: #d1fae5;
            color: #065f46;
        }

        .status-locked {
            background-color: #fee2e2;
            color: #991b1b;
        }

        /* Action buttons */
        .actions a {
            margin-right: 8px;
            color: #2563eb;
            font-weight: 500;
            text-decoration: none;
            transition: color 0.2s ease;
        }

        .actions a:hover {
            color: #1e40af;
        }

        .actions i {
            margin-right: 4px;
        }

        /* Back button */
        .back-home {
            margin-top: 10px;
        }

        .back-home button {
            background-color: #6b7280;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 500;
        }

        .back-home button:hover {
            background-color: #4b5563;
        }

        /* Responsive fix */
        @media (max-width: 768px) {
            .sidebar {
                display: none;
            }
            .main-content {
                margin-left: 0;
                margin: 0;
                border-radius: 0;
            }
            .toolbar {
                flex-direction: column;
                align-items: stretch;
            }
            .toolbar .left-controls {
                width: 100%;
                justify-content: space-between;
            }
        }

        /* Thông báo */
        .message {
            margin-bottom: 10px;
            padding: 10px;
            border-radius: 5px;
            font-weight: 500;
        }
        .success {
            background-color: #d1fae5;
            color: #065f46;
        }
        .error {
            background-color: #fee2e2;
            color: #991b1b;
        }
    </style>
</head>
<body>
    <!-- Layout container -->
    <div class="d-flex">
        <!-- Sidebar -->
        <div class="sidebar">
            <jsp:include page="/components/AdminSidebar.jsp" />
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <h2>Danh sách khách hàng</h2>

            <!-- Toolbar -->
            <form action="userList" method="get" class="toolbar">
                <div class="left-controls">
                    <input type="text" name="search" value="${param.search}" placeholder="Nhập tên khách hàng">
                    <select name="statusId">
                        <option value="" ${empty param.statusId ? 'selected' : ''}>Tất cả trạng thái</option>
                        <option value="1" ${param.statusId == '1' ? 'selected' : ''}>Đang hoạt động</option>
                        <option value="2" ${param.statusId == '2' ? 'selected' : ''}>Đã khóa</option>
                    </select>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-search me-1"></i> Tìm kiếm
                    </button>
                </div>
            </form>

            <!-- Hiển thị thông báo -->
            <c:if test="${not empty param.message}">
                <div class="message ${param.message.contains('thành công') ? 'success' : 'error'}">${param.message}</div>
            </c:if>

            <!-- Nút trở về -->
            <c:if test="${not empty param.search || not empty param.statusId}">
                <div class="back-home">
                    <button type="button" onclick="location.href='userList?reset=true'">
                        <i class="fas fa-arrow-left me-1"></i> Trở về
                    </button>
                </div>
            </c:if>

            <!-- Table -->
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>FullName</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Registration Date</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="o" items="${listU}">
                        <tr>
                            <td>${o.userID}</td>
                            <td>${o.fullName}</td>
                            <td>${o.email}</td>
                            <td>${o.phoneNumber}</td>
                            <td>${o.registrationDate}</td>
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
                                <a href="userDetail?userId=${o.userID}"><i class="fas fa-eye"></i> View Detail</a>
                                <c:choose>
                                    <c:when test="${o.statusID == 1}">
                                        <a href="changeStatusAccount?userId=${o.userID}&statusId=2"
                                           onclick="return confirm('Bạn có chắc muốn khóa tài khoản này không?')">
                                            <i class="fas fa-lock"></i> Khóa
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="changeStatusAccount?userId=${o.userID}&statusId=1"
                                           onclick="return confirm('Bạn có chắc muốn kích hoạt tài khoản này không?')">
                                            <i class="fas fa-unlock"></i> Kích hoạt
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty listU}">
                        <tr><td colspan="7" style="text-align: center; color: red;">Không tìm thấy khách hàng nào.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>