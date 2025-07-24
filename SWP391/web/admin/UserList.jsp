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
            * {
                box-sizing: border-box;
            }

            body {
                font-family: 'Roboto', 'Arial', sans-serif;
                margin: 0;
                background-color: #f4f4f4;
                color: #333;
                overflow-x: hidden;
            }

            .d-flex {
                display: flex;
                min-height: 100vh;
            }

            /* Sidebar giống CellphoneS */
            .sidebar {
                width: 260px;
                background-color: #1a1a1a;
                color: #fff;
                padding: 20px 0;
                position: fixed;
                top: 0;
                left: 0;
                height: 100vh;
                overflow-y: auto;
                box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            }

            .sidebar a {
                color: #fff;
                text-decoration: none;
                padding: 12px 20px;
                display: block;
                font-size: 15px;
                transition: background-color 0.3s;
                display: flex;
                align-items: center;
            }

            .sidebar a:hover,
            .sidebar .nav-link.active {
                background-color: #d70018;
            }

            .sidebar a i {
                margin-right: 10px;
            }

            /* Main content */
            .main-content {
                margin: auto;
                padding: 40px;
                width: calc(100% - 260px);
                background-color: #fff;
                min-height: 100vh;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
            }

            h2 {
                font-size: 28px;
                color: #d70018;
                font-weight: 700;
                margin-bottom: 30px;
                border-bottom: 2px solid #d70018;
                padding-bottom: 10px;
            }

            /* Toolbar */
            .toolbar {
                display: flex;
                gap: 15px;
                flex-wrap: wrap;
                margin-bottom: 25px;
                align-items: center;
            }

            .toolbar .left-controls {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
            }

            .toolbar .left-controls input,
            .toolbar .left-controls select {
                border-radius: 6px;
                padding: 10px 15px;
                border: 1px solid #ddd;
                font-size: 14px;
                min-width: 200px;
                transition: border-color 0.3s;
            }

            .toolbar .left-controls input:focus,
            .toolbar .left-controls select:focus {
                border-color: #d70018;
                outline: none;
                box-shadow: 0 0 5px rgba(215, 0, 24, 0.3);
            }

            .btn-primary {
                background-color: #d70018;
                border: none;
                color: #fff;
                padding: 10px 24px;
                border-radius: 6px;
                font-size: 14px;
                font-weight: 500;
                transition: background-color 0.3s, transform 0.2s;
            }

            .btn-primary:hover {
                background-color: #b30014;
                transform: translateY(-2px);
            }

            /* Table */
            table {
                width: 100%;
                background-color: #fff;
                border-collapse: separate;
                border-spacing: 0;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            thead {
                background-color: #d70018;
                color: #fff;
            }

            thead th {
                padding: 16px;
                text-align: left;
                font-weight: 600;
                font-size: 15px;
            }

            tbody td {
                padding: 14px;
                font-size: 14px;
                border-bottom: 1px solid #eee;
                vertical-align: middle;
            }

            tbody tr:hover {
                background-color: #f9f9f9;
            }

            /* Status */
            .status {
                padding: 6px 14px;
                border-radius: 20px;
                font-size: 13px;
                font-weight: 500;
                display: inline-block;
            }

            .status-active {
                background-color: #e6f4ea;
                color: #15803d;
            }

            .status-locked {
                background-color: #fde8e8;
                color: #b91c1c;
            }

            /* Action buttons */
            .actions a {
                color: #d70018;
                text-decoration: none;
                font-weight: 500;
                margin-right: 15px;
                font-size: 14px;
                transition: color 0.3s;
            }

            .actions a:hover {
                color: #b30014;
                text-decoration: underline;
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
                color: #fff;
                border: none;
                padding: 10px 20px;
                border-radius: 6px;
                font-size: 14px;
                font-weight: 500;
                transition: background-color 0.3s, transform 0.2s;
            }

            .back-home button:hover {
                background-color: #4b5563;
                transform: translateY(-2px);
            }

            /* Pagination */
            .pagination {
                justify-content: center;
                margin-top: 30px;
            }

            .pagination .page-link {
                color: #d70018;
                border-radius: 6px;
                font-size: 14px;
                padding: 8px 14px;
                margin: 0 4px;
                transition: background-color 0.3s, transform 0.2s;
            }

            .pagination .page-item.active .page-link {
                background-color: #d70018;
                border-color: #d70018;
                color: #fff;
            }

            .pagination .page-link:hover {
                background-color: #fce4e4;
                transform: translateY(-2px);
            }

            .pagination .page-item.disabled .page-link {
                color: #6b7280;
                cursor: not-allowed;
            }

            /* Thông báo */
            .message {
                padding: 12px 20px;
                border-radius: 6px;
                font-weight: 500;
                margin-bottom: 20px;
                font-size: 14px;
            }

            .success {
                background-color: #e6f4ea;
                color: #15803d;
            }

            .error {
                background-color: #fde8e8;
                color: #b91c1c;
            }

            /* Responsive design */
            @media (max-width: 768px) {
                .sidebar {
                    display: none;
                }
                .main-content {
                    margin-left: 0;
                    padding: 15px;
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
        </style>
    </head>
    <body>

        <div class="d-flex">
            <!-- Layout container -->
            <div class="d-flex">

                <jsp:include page="/components/AdminSidebar.jsp" />



                <div class="main-content">
                    <h2>Danh sách khách hàng</h2>


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


                    <c:if test="${not empty param.message}">
                        <div class="message ${param.message.contains('thành công') ? 'success' : 'error'}">${param.message}</div>
                    </c:if>


                    <c:if test="${not empty param.search || not empty param.statusId}">
                        <div class="back-home">
                            <button type="button" onclick="location.href = 'userList?reset=true'">
                                <i class="fas fa-arrow-left me-1"></i> Trở về
                            </button>
                        </div>
                    </c:if>


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
                                                <a href="changeStatusAccount?userId=${o.userID}&statusId=2&redirectPage=user"
                                                   onclick="return confirm('Bạn có chắc muốn khóa tài khoản này không?')">
                                                    <i class="fas fa-lock"></i> Khóa
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="changeStatusAccount?userId=${o.userID}&statusId=1&redirectPage=user"
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
                    <c:if test="${totalPages > 1}">
                        <c:set var="startPage" value="${currentPage - 2 < 1 ? 1 : currentPage - 2}" />
                        <c:set var="endPage" value="${currentPage + 2 > totalPages ? totalPages : currentPage + 2}" />

                        <nav aria-label="Pagination" class="mt-4">
                            <ul class="pagination justify-content-center">
                                <!-- Nút Trước -->
                                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="userList?page=${currentPage - 1}">
                                        <i class="bi bi-chevron-left"></i> Trước
                                    </a>
                                </li>

                                <!-- Trang đầu + dấu ... nếu cần -->
                                <c:if test="${startPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="userList?page=1">1</a>
                                    </li>
                                    <c:if test="${startPage > 2}">
                                        <li class="page-item disabled"><a class="page-link">...</a></li>
                                        </c:if>
                                    </c:if>

                                <!-- Các trang lân cận -->
                                <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="userList?page=${i}">${i}</a>
                                    </li>
                                </c:forEach>

                                <!-- Dấu ... + trang cuối nếu cần -->
                                <c:if test="${endPage < totalPages}">
                                    <c:if test="${endPage < totalPages - 1}">
                                        <li class="page-item disabled"><a class="page-link">...</a></li>
                                        </c:if>
                                    <li class="page-item">
                                        <a class="page-link" href="userList?page=${totalPages}">${totalPages}</a>
                                    </li>
                                </c:if>

                                <!-- Nút Sau -->
                                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                    <a class="page-link" href="userList?page=${currentPage + 1}">
                                        Sau <i class="bi bi-chevron-right"></i>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </c:if>
                </div>
            </div>
    </body>
</html>