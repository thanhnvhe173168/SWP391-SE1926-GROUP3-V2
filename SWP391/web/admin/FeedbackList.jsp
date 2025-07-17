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
                background: #f4f6f9;
                margin: 0;
            }

            .sidebar {
                position: fixed;
                top: 0;
                left: 0;
                width: 250px;
                height: 100%;
                background: #222;
                color: #fff;
                z-index: 1000;
                padding: 20px 0;
            }

            .main-content {
                margin-left: 250px; /* same as sidebar width */
                padding: 30px;
                max-width: calc(100% - 250px);
                overflow-x: auto;
            }

            h2 {
                color: #111827;
                margin-bottom: 20px;
            }

            img {
                max-width: 80px;
                height: auto;
                border-radius: 4px;
            }

            .reply-text {
                background: #e9f7ef;
                border: 1px solid #d4edda;
                padding: 8px;
                border-radius: 4px;
                font-size: 13px;
            }

            .no-reply {
                color: #999;
                font-style: italic;
            }

            .table {
                table-layout: auto; /* Cho phép cột tự co */
                width: 100%;
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
                            <th>Title</th>
                            <th>Content</th>
                            <th>Rating</th>
                            <th>Seller</th>
                            <th>Shipping</th>
                            <th>Image</th>
                            <th>Created At</th>
                            <th>Reply</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Feedback> list = (List<Feedback>) request.getAttribute("feedbackList");
                            if (list != null && !list.isEmpty()) {
                                for (Feedback fb : list) {
                        %>
                        <tr>
                            <td><%= fb.getFeedbackID() %></td>
                            <td><%= fb.getUserID() %></td>
                            <td><%= fb.getTitle() %></td>
                            <td><%= fb.getContent() %></td>
                            <td><%= fb.getRating() %></td>
                            <td><%= fb.getSellerRating() %></td>
                            <td><%= fb.getShippingRating() %></td>
                            <td>
                                <% if (fb.getImageURL() != null && !fb.getImageURL().isEmpty()) { %>
                                <img src="<%= request.getContextPath() %>/image?path=<%= fb.getImageURL() %>">
                                <% } else { %>
                                <span class="no-reply">No Image</span>
                                <% } %>
                            </td>
                            <td style="white-space: nowrap;"><%= fb.getCreatedAt() %></td>
                            <td>
                                <% if (fb.getReplyContent() != null && !fb.getReplyContent().isEmpty()) { %>
                                <div class="reply-text"><%= fb.getReplyContent() %></div>
                                <% } else { %>
                                <span class="no-reply">Chưa phản hồi</span>
                                <% } %>
                            </td>
                            <td><%= fb.getStatusName() %></td>
                            <td>
                                <a href="replyFeedback?id=<%= fb.getFeedbackID() %>" class="btn btn-success btn-sm">Reply</a>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="12" class="text-center text-danger">Không có phản hồi nào.</td>
                        </tr>
                        <% } %>
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
