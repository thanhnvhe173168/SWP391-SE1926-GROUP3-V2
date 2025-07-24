<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Feedback" %>
<%
    Feedback fb = (Feedback) request.getAttribute("fb");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết đánh giá</title>
        <!-- Bootstrap 5 CDN -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome CDN (for stars) -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

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
                margin-left: auto;
                padding: 40px;
                width: calc(100% - 260px);
                background-color: #fff;
                min-height: 100vh;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
            }

            .feedback-card {
                max-width: 900px;
                margin: auto;
                background-color: #fff;
                border-radius: 12px;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
                padding: 35px;
            }

            .feedback-card h3 {
                font-weight: 700;
                color: #d70018;
                margin-bottom: 30px;
                border-bottom: 2px solid #d70018;
                padding-bottom: 10px;
                text-align: center;
            }

            .table th {
                width: 220px;
                background-color: #fafafa;
                color: #555;
                font-weight: 600;
            }

            .table td {
                vertical-align: middle;
            }

            .star-rating i {
                color: #ffce3d;
                margin-right: 2px;
            }

            .btn-back {
                background-color: #d70018;
                border: none;
                color: #fff;
                padding: 10px 24px;
                border-radius: 6px;
                font-size: 14px;
                font-weight: 500;
                transition: background-color 0.3s, transform 0.2s;
            }

            .btn-back:hover {
                background-color: #b30014;
                transform: translateY(-2px);
            }

            @media (max-width: 768px) {
                .sidebar {
                    display: none;
                }
                .main-content {
                    margin-left: 0;
                    padding: 20px;
                }
                .feedback-card {
                    padding: 20px;
                }
                .table th,
                .table td {
                    font-size: 14px;
                    padding: 10px 8px;
                }
                .btn-back {
                    font-size: 13px;
                    padding: 8px 16px;
                }
            }
        </style>
    </head>
    <body>
        <div class="d-flex">

            <jsp:include page="/components/AdminSidebar.jsp" />

            <!-- Main Content -->
            <div class="main-content">
                <div class="feedback-card">
                    <h3 class="text-center mb-4">Chi tiết đánh giá</h3>
                    <table class="table table-bordered">
                        <tr><th>FeedbackID</th><td><%= fb.getFeedbackID() %></td></tr>
                        <tr><th>LaptopID</th><td><%= fb.getLaptopID() %></td></tr>
                        <tr><th>OrderID</th><td><%= fb.getOrderID() %></td></tr>
                        <tr><th>Tiêu đề</th><td><%= fb.getTitle() %></td></tr>
                        <tr><th>Nội dung</th><td><%= fb.getContent() %></td></tr>

                        <tr>
                            <th>Đánh giá sản phẩm</th>
                            <td class="star-rating">
                                <% for (int i = 1; i <= 5; i++) { %>
                                <i class="fa-star <%= i <= fb.getRating() ? "fas" : "far" %>"></i>
                                <% } %>
                            </td>
                        </tr>
                        <tr>
                            <th>DỊch vụ người bán</th>
                            <td class="star-rating">
                                <% for (int i = 1; i <= 5; i++) { %>
                                <i class="fa-star <%= i <= fb.getSellerRating() ? "fas" : "far" %>"></i>
                                <% } %>
                            </td>
                        </tr>
                        <tr>
                            <th>Tốc độ giao hàng</th>
                            <td class="star-rating">
                                <% for (int i = 1; i <= 5; i++) { %>
                                <i class="fa-star <%= i <= fb.getShippingRating() ? "fas" : "far" %>"></i>
                                <% } %>
                            </td>
                        </tr>

                        <tr><th>Ngày tạo</th><td><%= fb.getCreatedAt() %></td></tr>
                        <tr><th>Ngày cập nhật</th><td><%= fb.getUpdatedAt() %></td></tr>
                    </table>

                    <div class="text-end mt-3">
                        <a href="feedBackList" class="btn btn-back">⬅ Quay lại danh sách</a>
                    </div>
                </div>
            </div>

    </body>
</html>