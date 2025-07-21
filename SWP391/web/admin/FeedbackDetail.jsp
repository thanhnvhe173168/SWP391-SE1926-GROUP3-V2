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
        body {
            background-color: #f5f5f5;
            font-family: 'Segoe UI', sans-serif;
            padding: 40px;
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
            font-weight: bold;
            color: #ee4d2d;
        }
        .table th {
            width: 220px;
            background-color: #fafafa;
            color: #555;
        }
        .star-rating i {
            color: #ffce3d;
            margin-right: 2px;
        }
        .feedback-img {
            max-width: 100%;
            height: auto;
            border-radius: 10px;
            margin-top: 15px;
            border: 1px solid #ddd;
        }
        .btn-back {
            background-color: #ee4d2d;
            color: #fff;
        }
        .btn-back:hover {
            background-color: #d8431f;
            color: #fff;
        }
    </style>
</head>
<body>

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
            <th>Đánh giá người bán</th>
            <td class="star-rating">
                <% for (int i = 1; i <= 5; i++) { %>
                    <i class="fa-star <%= i <= fb.getSellerRating() ? "fas" : "far" %>"></i>
                <% } %>
            </td>
        </tr>
        <tr>
            <th>Đánh giá giao hàng</th>
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

</body>
</html>
