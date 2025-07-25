<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Feedback" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>📋 Danh sách Phản hồi</title>

        <!-- Bootstrap CSS -->
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

            .main-content {
                margin:auto;
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
                text-align: center;
            }

            .table-responsive {
                overflow-x: auto;
            }

            .table {
                width: 100%;
                background-color: #fff;
                border-collapse: separate;
                border-spacing: 0;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }

            .table th,
            .table td {
                vertical-align: middle;
                padding: 12px 16px;
            }

            .table-hover tbody tr:hover {
                background-color: #f9f9f9;
            }

            .table-primary {
                background-color: #d70018;
                color: #fff;
            }

            .table-primary th {
                font-weight: 600;
                font-size: 15px;
            }

            .btn-primary.btn-sm {
                background-color: #d70018;
                border: none;
                padding: 5px 12px;
                font-size: 13px;
                border-radius: 5px;
                transition: background-color 0.3s, transform 0.2s;
            }

            .btn-primary.btn-sm:hover {
                background-color: #b30014;
                transform: translateY(-2px);
            }

            .btn-danger.btn-sm {
                background-color: #e74c3c;
                border: none;
                padding: 5px 12px;
                font-size: 13px;
                border-radius: 5px;
                transition: background-color 0.3s, transform 0.2s;
            }

            .btn-danger.btn-sm:hover {
                background-color: #c0392b;
                transform: translateY(-2px);
            }

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

            .pagination .active .page-link {
                background-color: #d70018;
                border-color: #d70018;
                color: #fff;
            }

            .pagination .page-link:hover {
                background-color: #fce4e4;
                transform: translateY(-2px);
            }

            .pagination .disabled .page-link {
                color: #6b7280;
                cursor: not-allowed;
            }

            @media (max-width: 768px) {
                .sidebar {
                    display: none;
                }
                .main-content {
                    margin-left: 0;
                    padding: 20px;
                }
                .table th,
                .table td {
                    font-size: 14px;
                    padding: 10px 8px;
                }
                .btn-sm {
                    font-size: 12px;
                    padding: 4px 8px;
                }
            }
        </style>
    </head>
    <body>

        <div class="d-flex">
            
                <jsp:include page="/components/AdminSidebar.jsp" />
          
        <!-- Main Content -->
        <div class="main-content container-fluid">
            <h2>📋 Danh sách Phản hồi Khách hàng</h2>

            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover align-middle">
                    <thead class="table-primary">
                        <tr>
                            <th>ID</th>
                            <th>UserID</th>
                            <th>LaptopID</th>
                            <th>Title</th>
                            <th>Content</th>
                            <th>Created At</th>
                            <th>Updated At</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty feedbackList}">
                                <c:forEach var="f" items="${feedbackList}">
                                    <tr>
                                        <td>${f.feedbackID}</td>
                                        <td>${f.userID}</td>
                                        <td>${f.laptopID}</td>
                                        <td>${f.title}</td>
                                        <td>${f.content}</td>
                                        <td>${f.createdAt}</td>
                                        <td>${f.updatedAt}</td>
                                        <td>
                                            <a href="feedbackDetail?fid=${f.getFeedbackID()}" class="btn btn-primary btn-sm">View Detail</a>
                                            <a href="deleteFeedback?feedbackId=${f.feedbackID}&productId=${f.laptopID}" onclick="return confirm('Xoá đánh giá này?')" class="btn btn-danger btn-sm">Delete</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="12" class="text-center text-danger">Không có phản hồi nào.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
                <c:if test="${totalPages > 1}">
                    <nav aria-label="Pagination" class="mt-4">
                        <ul class="pagination justify-content-center">
                            <!-- Nút Trước -->
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="feedBackList?page=${currentPage - 1}">Trước</a>
                            </li>

                            <!-- Trang đầu và dấu ... -->
                            <c:if test="${currentPage > 3}">
                                <li class="page-item"><a class="page-link" href="feedBackList?page=1">1</a></li>
                                <li class="page-item disabled"><span class="page-link">...</span></li>
                            </c:if>

                            <!-- Các trang gần current -->
                            <c:forEach begin="${currentPage - 2 < 1 ? 1 : currentPage - 2}" 
                                       end="${currentPage + 2 > totalPages ? totalPages : currentPage + 2}" 
                                       var="i">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="feedBackList?page=${i}">${i}</a>
                                </li>
                            </c:forEach>

                            <!-- Dấu ... và trang cuối -->
                            <c:if test="${currentPage + 2 < totalPages}">
                                <li class="page-item disabled"><span class="page-link">...</span></li>
                                <li class="page-item"><a class="page-link" href="feedBackList?page=${totalPages}">${totalPages}</a></li>
                            </c:if>

                            <!-- Nút Sau -->
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="feedBackList?page=${currentPage + 1}">Sau</a>
                            </li>
                        </ul>
                    </nav>
                </c:if>
            </div>
        </div>

    </body>
</html>