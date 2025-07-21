<%-- 
    Document   : StaffList
    Created on : Jun 17, 2025, 2:09:14 PM
    Author     : linhd
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách nhân viên</title>

        <!-- Bootstrap & Font Awesome -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f3f4f6;
                margin: 0;
                padding: 0;
                overflow-x: hidden; /* Ngăn cuộn ngang */
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
                z-index: 1000; /* Đảm bảo sidebar luôn ở trên cùng */
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

            /* Main content với padding-left để tránh chồng lên sidebar */
            .main-content {
                margin-left: 250px; /* Độ rộng của sidebar */
                padding: 30px;
                background-color: #ffffff;
                border-radius: 12px;
                min-height: calc(100vh - 40px); /* Điều chỉnh chiều cao */
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

            .toolbar .right-controls button {
                background-color: #22c55e;
                border: none;
                padding: 8px 16px;
                border-radius: 8px;
                color: #ffffff;
                font-weight: 600;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .toolbar .right-controls button:hover {
                background-color: #16a34a;
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

            /* Pagination */
            .pagination {
                margin-top: 24px;
                text-align: center;
            }

            .pagination a {
                display: inline-block;
                margin: 0 4px;
                padding: 8px 14px;
                border-radius: 8px;
                border: 1px solid #d1d5db;
                background-color: white;
                color: #2563eb;
                font-weight: 500;
                text-decoration: none;
                transition: all 0.3s ease;
            }

            .pagination a:hover {
                background-color: #2563eb;
                color: white;
            }

            .pagination a.active {
                background-color: #2563eb;
                color: white;
                font-weight: bold;
                pointer-events: none;
            }

            /* Responsive fix */
            @media (max-width: 768px) {
                .sidebar {
                    display: none; /* Ẩn sidebar trên màn hình nhỏ */
                }
                .main-content {
                    margin-left: 0; /* Xóa margin khi sidebar ẩn */
                    margin: 0;
                    border-radius: 0;
                }
                .toolbar {
                    flex-direction: column;
                    align-items: stretch;
                }
                .toolbar .left-controls,
                .toolbar .right-controls {
                    width: 100%;
                    justify-content: space-between;
                }
                .toolbar .right-controls button {
                    width: 100%;
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
                <h2>Danh sách Nhân viên</h2>

                <!-- Toolbar -->
                <form action="staffList" method="get" class="toolbar">
                    <div class="left-controls">
                        <input type="text" name="search" value="${param.search}" placeholder="Nhập tên nhân viên">
                        <select name="statusId">
                            <option value="">Tất cả trạng thái</option>
                            <option value="1" ${param.status == '1' ? 'selected' : ''}>Đang hoạt động</option>
                            <option value="2" ${param.status == '2' ? 'selected' : ''}>Đã khóa</option>
                        </select>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-search me-1"></i> Tìm kiếm
                        </button>
                    </div>

                    <div class="right-controls">
                        <button type="button" onclick="location.href = 'admin/CreateAccountStaff.jsp'">
                            <i class="fas fa-user-plus me-1"></i> Thêm Nhân viên mới
                        </button>
                    </div>
                </form>

                <!-- Hiển thị thông báo lỗi hoặc thành công -->
                <c:if test="${not empty errorMessage}">
                    <div class="message error">${errorMessage}</div>
                </c:if>
                <c:if test="${not empty param.message}">
                    <div class="message ${param.message.contains('thành công') ? 'success' : 'error'}">${param.message}</div>
                </c:if>

                <!-- Nút trở về -->
                <c:if test="${not empty param.search || not empty param.status}">
                    <div class="back-home">
                        <button type="button" onclick="location.href = 'staffList?reset=true'">
                            <i class="fas fa-arrow-left me-1"></i> Trở về
                        </button>
                    </div>
                </c:if>

                <!-- Table -->
                <table>
                    <thead>
                        <tr>
                            <th>User ID</th>
                            <th>Full name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Registration Date</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listStaff}" var="o">
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
                                    <a href="staffDetail?id=${o.userID}"><i class="fas fa-eye"></i> View</a>
                                    <a href="staffEditAccount?userId=${o.userID}">Edit</a>

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
                        <c:if test="${empty listStaff}">
                            <tr><td colspan="7" style="text-align: center; color: red;">Không tìm thấy nhân viên nào.</td></tr>
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
                                <a class="page-link" href="staffList?page=${currentPage - 1}">
                                    <i class="bi bi-chevron-left"></i> Trước
                                </a>
                            </li>

                            <!-- Trang đầu + dấu ... nếu cần -->
                            <c:if test="${startPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="staffList?page=1">1</a>
                                </li>
                                <c:if test="${startPage > 2}">
                                    <li class="page-item disabled"><a class="page-link">...</a></li>
                                    </c:if>
                                </c:if>

                            <!-- Các trang lân cận -->
                            <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="staffList?page=${i}">${i}</a>
                                </li>
                            </c:forEach>

                            <!-- Dấu ... + trang cuối nếu cần -->
                            <c:if test="${endPage < totalPages}">
                                <c:if test="${endPage < totalPages - 1}">
                                    <li class="page-item disabled"><a class="page-link">...</a></li>
                                    </c:if>
                                <li class="page-item">
                                    <a class="page-link" href="staffList?page=${totalPages}">${totalPages}</a>
                                </li>
                            </c:if>

                            <!-- Nút Sau -->
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="staffList?page=${currentPage + 1}">
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