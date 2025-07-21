<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Feedback" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>📋 Danh sách Phản hồi</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background: #f8f9fa;
                margin: 0;
            }

            .sidebar {
                position: fixed;
                top: 0;
                left: 0;
                width: 250px;
                height: 100%;
                background: #343a40;
                color: #fff;
                z-index: 1000;
                padding: 20px 0;
            }

            .main-content {
                margin-left: 250px;
                padding: 30px;
                max-width: calc(100% - 250px);
                overflow-x: auto;
            }

            h2 {
                color: #343a40;
                margin-bottom: 30px;
                font-weight: 600;
                font-size: 28px;
                text-align: center;
            }

            .table {
                table-layout: auto;
                background-color: white;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
            }

            .table th, .table td {
                vertical-align: middle;
                padding: 12px 16px;
            }

            .table-hover tbody tr:hover {
                background-color: #f1f3f5;
            }

            .btn-primary.btn-sm {
                background-color: #4a90e2;
                border: none;
                padding: 5px 12px;
                font-size: 13px;
                border-radius: 5px;
            }

            .btn-danger.btn-sm {
                background-color: #e74c3c;
                border: none;
                padding: 5px 12px;
                font-size: 13px;
                border-radius: 5px;
            }

            .btn-primary.btn-sm:hover,
            .btn-danger.btn-sm:hover {
                opacity: 0.9;
            }

            .pagination .page-link {
                color: #007bff;
            }

            .pagination .active .page-link {
                background-color: #007bff;
                border-color: #007bff;
                color: white;
            }

            @media (max-width: 768px) {
                .sidebar {
                    display: none;
                }

                .main-content {
                    margin-left: 0;
                    max-width: 100%;
                    padding: 20px;
                }

                .table th, .table td {
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

        <!-- Sidebar -->
        <div class="sidebar">
            <jsp:include page="/components/AdminSidebar.jsp" />
        </div>

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
