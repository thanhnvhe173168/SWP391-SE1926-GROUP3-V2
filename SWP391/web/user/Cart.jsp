<%-- 
    Document   : CartOrder
    Created on : May 22, 2025, 4:00:49 PM
    Author     : Window 11
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*" %>
<%@page import="dao.*" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Giỏ hàng</title>
        <link rel="stylesheet" href="styles.css" />
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, sans-serif;
                background-color: #f5f5f5;
                padding: 30px;
            }

            h2 {
                text-align: center;
                margin-bottom: 30px;
                color: #ee4d2d; /* Shopee cam */
            }

            table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 12px rgba(0,0,0,0.1);
                overflow: hidden;
            }

            th {
                background: #007bff;  /* Cam Shopee nổi bật */
                color: #fff;          /* Chữ trắng dễ đọc */
                font-weight: bold;
                text-transform: uppercase; /* Viết hoa tất cả tiêu đề */
                letter-spacing: 0.5px;
                padding: 18px;
            }

            td {
                text-align: center;
                padding: 20px 15px;
                border-bottom: 1px solid #f2f2f2;
                vertical-align: middle;
            }

            tr:hover {
                background: #fffdfa;
            }

            img {
                width: 100px;   /* Tăng từ 80 lên 100 */
                height: 100px;  /* Đảm bảo tỷ lệ vuông */
                border-radius: 8px;
                object-fit: cover;
                box-shadow: 0 1px 5px rgba(0,0,0,0.1);
            }
            input[type="checkbox"] {
                transform: scale(1.2);
                cursor: pointer;
            }

            .price {
                color: #ee4d2d;
                font-weight: bold;
                font-size: 16px;
            }

            .qty-control {
                display: inline-flex;
                align-items: center;
                border: 1px solid #ccc;
                border-radius: 4px;
                overflow: hidden;
            }

            .qty-control button {
                width: 36px;
                height: 36px;
                font-size: 16px;
            }

            .qty-control span {
                width: 40px;
                line-height: 36px;
            }

            button[onclick*='Order'] {
                background: #27ae60;
                color: #fff;
                padding: 6px 12px;
                border-radius: 4px;
                border: none;
            }

            button[onclick*='RemoveFromCart'] {
                background: #e74c3c;
                color: #fff;
                padding: 6px 12px;
                border-radius: 4px;
                border: none;
            }

            button:hover {
                opacity: 0.9;
            }

            .total-row {
                background: #fafafa;
                font-weight: bold;
                color: #555;
            }

            .total-row td {
                font-size: 18px;
            }

            .empty-cart {
                text-align: center;
                color: #888;
                font-size: 20px;
                margin: 50px auto;
            }

        </style>
        <%  
            User user = (User)session.getAttribute("user");
            CartDAO cdao = new CartDAO();
            Cart cart = cdao.GetCartByUserID(user.getUserID());
        %>
    </head>
    <body>
        <jsp:include page="/components/Header.jsp"></jsp:include>
            <h2>Giỏ hàng</h2>

        <c:set var="listcartdetails" value="${sessionScope.listcartdetail}" />

        <c:choose>
            <c:when test="${empty listcartdetails}">
                <p>Giỏ hàng của bạn đang trống.</p>
            </c:when>

            <c:otherwise>
                <form action="UppdateTotal" method="post" id="cartForm">
                    <table>
                        <tr>
                            <th>Chọn</th>
                            <th>Hình ảnh</th>
                            <th>Tên Laptop</th>
                            <th>Giá</th>
                            <th>Số lượng</th>
                            <th>Thành tiền</th>
                            <th>Mua</th>
                            <th>Xóa</th>
                        </tr>

                        <c:forEach var="item" items="${listcartdetails}">
                            <tr>
                                <td>
                                    <input type="checkbox" name="selectedItem"
                                           value="${item.laptop.laptopID}"
                                           ${item.isIsSelect() ? "checked" : ""}
                                           onchange="document.getElementById('cartForm').submit();" />
                                </td>
                                <td><button type="button" onclick="window.location.href = 'LaptopInfo?id=${item.getLaptop().getLaptopID()}'"><img src="images/${item.laptop.imageURL}" width="100" alt="${item.laptop.laptopName}" /></button></td>
                                <td>${item.laptop.laptopName}</td>
                                <td class="price"><fmt:formatNumber value="${item.unitPrice}" type="number" groupingUsed="true"/> VNĐ</td>
                                <td>
                                    <div class="qty-control">
                                        <button type="button" onclick="window.location.href = 'QuantityChange?action=dec&id=${item.getLaptop().getLaptopID()}'">-</button>
                                        <span>${item.quantity}</span>
                                        <button type="button" onclick="window.location.href = 'QuantityChange?action=inc&id=${item.getLaptop().getLaptopID()}'">+</button>
                                    </div>
                                </td>
                                <td class="price"><fmt:formatNumber value="${item.unitPrice * item.quantity}" type="number" groupingUsed="true"/> VNĐ</td>
                                <td><button type="button" style=" background-color: greenyellow" onclick="window.location.href = 'Order?id=${item.getLaptop().getLaptopID()}'">Mua</button></td>
                                <td>
                                    <button type="button" style=" background-color: greenyellow" onclick="window.location.href = 'RemoveFromCart?id=${item.getLaptop().getLaptopID()}'">Xóa</button>
                                </td>
                            </tr>
                        </c:forEach>

                        <tr class="total-row">
                            <td colspan="1"><button type="button" style=" background-color: greenyellow" onclick="window.location.href = 'OrderItemSelect?'">Mua nhiều</button></td>
                            <td colspan="4"><strong>Tổng cộng:</strong></td>
                            <td colspan="1"><strong><fmt:formatNumber value="<%= cart.getTotal()%>" type="number" groupingUsed="true"/> VNĐ</strong></td>


                        </tr>
                    </table>
                </form>
            </c:otherwise>
        </c:choose>
        <jsp:include page="/components/Footer.jsp"></jsp:include>
        <%
                     String mess = (String) request.getAttribute("mess");
                    if (mess != null) {
        %>
        <script>
            alert("<%= mess %>");
        </script>
        <%
            }
        %>

    </body>
</html>

