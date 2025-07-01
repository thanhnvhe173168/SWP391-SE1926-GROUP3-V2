<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>JSP Title</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                font-family: Arial, sans-serif;
            }
            .product-image {
                max-width: 100%;
                height: auto;
                border-radius: 8px;
            }
            .product-content img {
                max-width: 100%;
                height: auto;
                border-radius: 4px;
            }
            .product-title {
                font-size: 2.5rem;
                font-weight: bold;
                color: #333;
                margin-bottom: 10px;
            }
            .product-short-desc {
                font-size: 1rem;
                color: #666;
                margin-bottom: 20px;
            }
            .product-price {
                font-size: 1.8rem;
                color: #dc3545;
                font-weight: bold;
                margin-bottom: 20px;
            }
            .quantity-container {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
            }
            .quantity-btn {
                width: 40px;
                height: 40px;
                border: 1px solid #ccc;
                background-color: #fff;
                cursor: pointer;
                font-size: 1.2rem;
            }
            .quantity-input {
                width: 60px;
                height: 40px;
                text-align: center;
                border: 1px solid #ccc;
                margin: 0 5px;
                font-size: 1rem;
            }
            .add-to-cart-btn {
                background-color: #fff;
                border: 1px solid #ccc;
                padding: 10px 20px;
                margin-right: 10px;
                display: flex;
                align-items: center;
            }
            .add-to-cart-btn:hover {
                background-color: #f8f9fa;
            }
            .add-to-cart-btn span {
                color: #dc3545;
                font-size: 1.5rem;
                margin-left: 5px;
            }
            .buy-now-btn {
                background-color: #dc3545;
                color: #fff;
                border: none;
                padding: 12px 30px;
                border-radius: 5px;
                font-weight: bold;
                text-transform: uppercase;
                width: 100%;
                text-align: center;
            }
            .buy-now-btn:hover {
                background-color: #c82333;
            }
            .buy-now-text {
                font-size: 0.8rem;
                color: #fff;
                margin-top: 5px;
            }
        </style>
    </head>
    <body>
        <%
           ResultSet rsLaptop = (ResultSet) request.getAttribute("rsLaptop");
        %>
        <jsp:include page="/components/Header.jsp"></jsp:include>
            <div class="container my-5">
            <%if(rsLaptop.next()) {%>
            <div class="row">
                <div class="col-md-8">
                    <img src="images/<%=rsLaptop.getString("ImageURL")%>" class="product-image" alt="">
                </div>
                <!-- Thông tin sản phẩm -->
                <div class="col-md-4">
                    <h1 class="product-title">
                        <%=rsLaptop.getString("LaptopName")%>
                    </h1>
                    <div class="product-short-desc">
                        <div>Bộ sử lý: <%=rsLaptop.getString("CPUInfo")%></div>
                        <div>Bộ nhớ: RAM <%=rsLaptop.getString("RAM")%></div>
                        <div>Ổ cứng: <%=rsLaptop.getString("HardDrive")%></div>
                        <div>Màn hình: <%=rsLaptop.getString("Size")%></div>
                    </div>
                    <div class="product-price">
                        <%=String.format("%,.0f VNĐ", rsLaptop.getDouble("Price"))%>
                    </div>
                    <div class="quantity-container">
                        <span>Số lượng:</span>
                        <button class="quantity-btn" onclick="updateQuantity(-1)">-</button>
                        <input type="number" id="quantity" class="quantity-input" value="1" min="1" readonly>
                        <button class="quantity-btn" onclick="updateQuantity(1)">+</button>
                    </div>
                    <button class="buy-now-btn" onclick="buyNow()">
                        Thêm vào giỏ hàng
                    </button>
                </div>
            </div>
            <%}%>
        </div>
        <jsp:include page="/components/Footer.jsp"></jsp:include>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                        function updateQuantity(change) {
                            let quantity = parseInt(document.getElementById('quantity').value);
                            quantity += change;
                            if (quantity < 1)
                                quantity = 1;
                            document.getElementById('quantity').value = quantity;
                        }

                        function addToCart() {
                            let quantity = document.getElementById('quantity').value;
                            alert('Đã thêm ' + quantity + ' sản phẩm vào giỏ hàng!');
                            // Thêm logic thực tế tại đây (gọi Servlet, cập nhật giỏ hàng, v.v.)
                        }

                        function buyNow() {
                            let quantity = document.getElementById('quantity').value;
                            alert('Mua ngay ' + quantity + ' sản phẩm!');
                            // Thêm logic thực tế tại đây (chuyển đến trang thanh toán, v.v.)
                        }
        </script>
    </body>
</html>