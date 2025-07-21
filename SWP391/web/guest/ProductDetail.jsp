<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>JSP Title</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
                background-color: #1e88e5;
                border: 1px solid #ccc;
                border-radius: 5px;
                padding: 10px 20px;
                margin-right: 10px;
                display: flex;
                align-items: center;
            }
            .add-to-cart-btn:hover {
                background-color: #00a8ff;
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
        String mess = (String) request.getAttribute("mess");
        String icon = (String) request.getAttribute("icon");
        if (mess != null && icon != null) {
        %>
        <script>
            Swal.fire({
                icon: '<%= icon %>',
                title: '<%= mess %>',
                showConfirmButton: false,
                timer: 2000
            });
        </script>
        <%
            }
        %>

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
                    <button class="add-to-cart-btn" onclick="addToCart()">
                        Add To Cart
                    </button>
                    <form id="addToCartForm" action="AddToCart" method="post">
                        <input type="hidden" name="productId" id="productId" value="<%=rsLaptop.getInt("LaptopID")%>">
                        <input type="hidden" name="quantity" id="quantityhidden">
                    </form>
                    <br>
                    <button class="buy-now-btn" onclick="buyNow()">
                        Buy Now
                    </button>
                    <form id="buynow" action="Order" method="get">
                        <input type="hidden" name="id" id="productId" value="<%=rsLaptop.getInt("LaptopID")%>">
                        <input type="hidden" name="idss" value="1">
                        <input type="hidden" name="quantity2" id="quantityhidden2">
                    </form>
                </div>
            </div>
            <jsp:useBean id="feedbackList" type="java.util.List" scope="request" />
            <h3>Khách hàng đánh giá</h3>

            <c:choose>
                <c:when test="${empty feedbackList}">
                    <p>Chưa có đánh giá nào cho sản phẩm này.</p>
                </c:when>
                <c:otherwise>
                    <c:forEach var="fb" items="${feedbackList}">
                        <div class="mb-3 p-3 border rounded shadow-sm position-relative">


                            <c:if test="${not empty sessionScope.user && fb.userID == sessionScope.user.userID}">

                                <div style="position: absolute; top: 10px; right: 10px;">
                                    <form action="updateFeedback" method="get" style="display:inline;">
                                        <input type="hidden" name="feedbackID" value="${fb.feedbackID}" />
                                        <button type="submit" class="btn btn-sm btn-outline-primary">Edit</button>
                                    </form>
                                    <form action="deleteFeedback" method="get" style="display:inline;"
                                          onsubmit="return confirm('Bạn có chắc muốn xóa đánh giá này?');">
                                        <input type="hidden" name="feedbackId" value="${fb.feedbackID}" />
                                        <input type="hidden" name="laptopId" value="${fb.laptopID}" />
                                        <input type="hidden" name="orderId" value="${fb.orderID}" />
                                        <input type="hidden" name="productId" value="${fb.laptopID}" />
                                        <button type="submit" class="btn btn-sm btn-outline-danger">Xóa</button>
                                    </form>
                                </div>
                            </c:if>


                            <h5 class="mb-1">Tiêu đề: ${fb.title}</h5>
                            <div class="text-muted small mb-2">
                                Ngày: <fmt:formatDate value="${fb.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                            </div>
                            <div>Nội dung : ${fb.content}</div>
                            <div>
                                Sản phẩm: ${fb.rating}⭐ /5 ⭐ |
                                Giao hàng: ${fb.shippingRating}⭐ /5⭐  |
                                Người bán: ${fb.sellerRating}⭐ /5⭐ 
                            </div>

                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>




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
                      document.getElementById('quantityhidden').value = quantity;
                      document.getElementById('addToCartForm').submit();
                  }

                  function buyNow() {
                      let quantity = document.getElementById('quantity').value;
                      alert('Mua ngay ' + quantity + ' sản phẩm!');

                  }
        </script>
    </body>
</html>