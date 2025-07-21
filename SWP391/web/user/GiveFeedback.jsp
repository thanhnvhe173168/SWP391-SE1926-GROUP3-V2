<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Laptop" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Gửi Đánh Giá</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            body {
                background: linear-gradient(to right, #e3f2fd, #ffffff);
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .form-section {
                background: #fff;
                border-radius: 20px;
                padding: 40px;
                box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
                max-width: 700px;
                margin: auto;
            }

            .form-section h2 {
                text-align: center;
                margin-bottom: 35px;
                font-weight: 700;
                color: #0d6efd;
                font-size: 30px;
            }

            .form-label, .rating-label {
                font-weight: 600;
                margin-bottom: 8px;
                display: block;
                color: #333;
            }

            .form-control {
                border-radius: 10px;
                padding: 12px 16px;
                font-size: 15px;
                border: 1px solid #ced4da;
                transition: border-color 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
            }

            .form-control:focus {
                border-color: #0d6efd;
                box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.15);
            }

            .star-rating {
                direction: rtl;
                display: inline-flex;
                font-size: 28px;
                justify-content: flex-start;
                gap: 3px;
                padding: 5px 0;
            }

            .star-rating input[type="radio"] {
                display: none;
            }

            .star-rating label {
                color: #ccc;
                cursor: pointer;
                transition: transform 0.2s, color 0.3s;
            }

            .star-rating label:hover,
            .star-rating label:hover ~ label,
            .star-rating input:checked ~ label {
                color: #ffc107;
                transform: scale(1.1);
            }

            .btn-submit {
                background: linear-gradient(to right, #0d6efd, #6610f2);
                border: none;
                padding: 12px 30px;
                font-size: 16px;
                font-weight: 600;
                border-radius: 10px;
                color: #fff;
                transition: background 0.3s ease-in-out;
            }

            .btn-submit:hover {
                background: linear-gradient(to right, #0056b3, #520dc2);
            }

            @media (max-width: 768px) {
                .form-section {
                    padding: 25px 20px;
                }

                .form-section h2 {
                    font-size: 24px;
                }

                .star-rating {
                    font-size: 22px;
                }

                .btn-submit {
                    width: 100%;
                }
            }
        </style>

    </head>
    <body style="background-color: #f8f9fa;">
        <div class="container mt-5">
            <div class="form-section">
                <h2>Gửi Đánh Giá Sản Phẩm</h2>

               <form action="${pageContext.request.contextPath}/giveFeedback" method="post" enctype="multipart/form-data">

                    <input type="hidden" name="orderID" value="${requestScope.orderId}" />
                    <input type="hidden" name="laptopID" value="${requestScope.laptopId}" />

                    <c:if test="${not empty mess}">
                        <div class="alert alert-info">${mess}</div>
                    </c:if>

                    <div class="mb-3">
                        <label class="form-label">Tiêu đề:</label>
                        <input type="text" class="form-control" name="title" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Nội dung đánh giá:</label>
                        <textarea class="form-control" name="content" rows="4" required></textarea>
                    </div>

                    <div class="mb-3">
                        <label class="rating-label">Đánh giá sản phẩm:</label><br>
                        <div class="star-rating">
                            <input type="radio" id="product5" name="productRating" value="5" required><label for="product5">★</label>
                            <input type="radio" id="product4" name="productRating" value="4"><label for="product4">★</label>
                            <input type="radio" id="product3" name="productRating" value="3"><label for="product3">★</label>
                            <input type="radio" id="product2" name="productRating" value="2"><label for="product2">★</label>
                            <input type="radio" id="product1" name="productRating" value="1"><label for="product1">★</label>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="rating-label">Đánh giá shop:</label><br>
                        <div class="star-rating">
                            <input type="radio" id="seller5" name="sellerRating" value="5" required><label for="seller5">★</label>
                            <input type="radio" id="seller4" name="sellerRating" value="4"><label for="seller4">★</label>
                            <input type="radio" id="seller3" name="sellerRating" value="3"><label for="seller3">★</label>
                            <input type="radio" id="seller2" name="sellerRating" value="2"><label for="seller2">★</label>
                            <input type="radio" id="seller1" name="sellerRating" value="1"><label for="seller1">★</label>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="rating-label">Đánh giá giao hàng:</label><br>
                        <div class="star-rating">
                            <input type="radio" id="ship5" name="shippingRating" value="5" required><label for="ship5">★</label>
                            <input type="radio" id="ship4" name="shippingRating" value="4"><label for="ship4">★</label>
                            <input type="radio" id="ship3" name="shippingRating" value="3"><label for="ship3">★</label>
                            <input type="radio" id="ship2" name="shippingRating" value="2"><label for="ship2">★</label>
                            <input type="radio" id="ship1" name="shippingRating" value="1"><label for="ship1">★</label>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">Hình ảnh minh họa:</label>
                        <input type="file" class="form-control" name="productImage" accept="image/*">

                    </div>

                    <div class="text-center">
                        <button type="submit" class="btn btn-submit">Gửi đánh giá</button>
                    </div>
                </form>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
