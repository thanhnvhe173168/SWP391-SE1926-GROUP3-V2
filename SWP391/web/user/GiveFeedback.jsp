<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Laptop" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gửi Đánh Giá</title>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            body {
                background-color: #f0f2f5;
                font-family: 'Roboto', sans-serif;
                margin: 0;
                padding: 20px;
                color: #333;
                line-height: 1.6;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }

            .form-section {
                background: #fff;
                border-radius: 12px;
                padding: 35px 40px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
                max-width: 650px;
                width: 100%;
                margin: 20px auto;
                animation: fadeIn 0.8s ease-out;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .form-section h2 {
                text-align: center;
                margin-bottom: 35px;
                font-weight: 700;
                color: #d70018;
                font-size: 30px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .form-label, .rating-label {
                font-weight: 500;
                margin-bottom: 8px;
                display: block;
                color: #555;
                font-size: 15px;
            }

            .form-control {
                border-radius: 8px;
                padding: 12px 16px;
                font-size: 15px;
                border: 1px solid #dcdcdc;
                transition: border-color 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
            }

            .form-control:focus {
                border-color: #d70018;
                box-shadow: 0 0 0 0.25rem rgba(215, 0, 24, 0.2);
                outline: none;
            }

            .star-rating {
                direction: rtl;
                display: inline-flex;
                font-size: 32px;
                justify-content: flex-start;
                gap: 5px;
                padding: 8px 0;
                vertical-align: middle;
            }

            .star-rating input[type="radio"] {
                display: none;
            }

            .star-rating label {
                color: #e0e0e0;
                cursor: pointer;
                transition: transform 0.2s, color 0.3s;
            }

            .star-rating label:hover,
            .star-rating label:hover ~ label,
            .star-rating input:checked ~ label {
                color: #ffcc00;
                transform: scale(1.1);
            }

            .btn-submit {
                display: inline-block;
                padding: 14px 30px;
                background-color: #d70018;
                color: #fff;
                text-decoration: none;
                border: none;
                border-radius: 8px;
                font-size: 17px;
                font-weight: 600;
                transition: background-color 0.2s ease, transform 0.2s ease, box-shadow 0.2s ease;
                box-shadow: 0 4px 10px rgba(215, 0, 24, 0.3);
                width: auto;
                min-width: 180px;
            }

            .btn-submit:hover {
                background-color: #b70015;
                transform: translateY(-2px);
                box-shadow: 0 6px 15px rgba(215, 0, 24, 0.4);
            }

            .alert {
                padding: 15px 25px;
                margin-bottom: 25px;
                border-radius: 8px;
                font-size: 15px;
                text-align: center;
                border: 1px solid transparent;
                animation: slideInTop 0.5s ease-out;
            }

            @keyframes slideInTop {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .alert-info {
                background-color: #e6f7ff;
                color: #0056b3;
                border-color: #91d5ff;
            }


            @media (max-width: 768px) {
                body {
                    padding: 15px;
                    min-height: auto;
                    align-items: flex-start;
                }
                .form-section {
                    padding: 25px 20px;
                    margin-top: 20px;
                    margin-bottom: 20px;
                }
                .form-section h2 {
                    font-size: 26px;
                    margin-bottom: 25px;
                }
                .star-rating {
                    font-size: 28px;
                    gap: 3px;
                }
                .btn-submit {
                    width: 100%;
                    padding: 12px 20px;
                    font-size: 16px;
                }
                .alert {
                    padding: 12px 20px;
                }
            }
        </style>

    </head>
    <body>
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
                    <label class="rating-label">Dịch vụ người bán:</label><br>
                    <div class="star-rating">
                        <input type="radio" id="seller5" name="sellerRating" value="5" required><label for="seller5">★</label>
                        <input type="radio" id="seller4" name="sellerRating" value="4"><label for="seller4">★</label>
                        <input type="radio" id="seller3" name="sellerRating" value="3"><label for="seller3">★</label>
                        <input type="radio" id="seller2" name="sellerRating" value="2"><label for="seller2">★</label>
                        <input type="radio" id="seller1" name="sellerRating" value="1"><label for="seller1">★</label>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="rating-label">Tốc độ giao hàng:</label><br>
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

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>