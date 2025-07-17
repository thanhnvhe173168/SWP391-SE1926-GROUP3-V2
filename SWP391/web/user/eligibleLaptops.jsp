<%-- 
    Document   : eligibleLaptops
    Created on : Jul 17, 2025, 12:59:39 AM
    Author     : linhd
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Laptop đủ điều kiện đánh giá</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .laptop-card {
            background-color: #fff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .laptop-card img {
            display: block;
            margin-bottom: 15px;
            max-width: 100%;
            height: auto;
            border-radius: 4px;
        }

        .feedback-form input[type="text"],
        .feedback-form input[type="number"],
        .feedback-form textarea {
            margin-bottom: 10px;
        }

        .feedback-form button {
            margin-top: 10px;
        }

        h2 {
            margin: 30px 0;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Laptop đã mua & đủ điều kiện đánh giá</h2>

        <c:forEach var="item" items="${eligibleLaptops}">
            <div class="laptop-card">
                <h5><b>Tên Laptop:</b> ${item.laptop.laptopName}</h5>
                <img src="images/${item.laptop.imageURL}" alt="${item.laptop.laptopName}" class="img-fluid" width="200px"/>

                <p><b>Số lượng:</b> ${item.quantity}</p>
                <p><b>Đơn giá:</b> ${item.unitPrice}</p>

                <form action="add-feedback" method="post" class="feedback-form">
                    <input type="hidden" name="laptopID" value="${item.laptop.laptopID}">
                    <input type="hidden" name="orderID" value="${item.orderID}">

                    <div class="mb-3">
                        <label class="form-label">Tiêu đề:</label>
                        <input type="text" name="title" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Nội dung:</label>
                        <textarea name="content" class="form-control" rows="3" required></textarea>
                    </div>

                    <div class="mb-3 row">
                        <div class="col-md-4">
                            <label class="form-label">Đánh giá sản phẩm:</label>
                            <input type="number" name="rating" class="form-control" min="1" max="5" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Đánh giá shop:</label>
                            <input type="number" name="sellerRating" class="form-control" min="1" max="5" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Đánh giá giao hàng:</label>
                            <input type="number" name="shippingRating" class="form-control" min="1" max="5" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Hình ảnh</label>
                        <input type="text" name="imageURL" class="form-control">
                    </div>

                    <button type="submit" class="btn btn-primary">Gửi Feedback</button>
                </form>
            </div>
        </c:forEach>
    </div>

    <!-- Bootstrap JS Bundle (tuỳ chọn nếu có component cần JS) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


