<%-- 
    Document   : CartOrder
    Created on : May 22, 2025, 4:00:49 PM
    Author     : Window 11
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*" %>
<%@page import="dal.*" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Giỏ hàng</title>
        <link rel="stylesheet" href="styles.css" />
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                padding: 12px;
                border: 1px solid #ccc;
                text-align: center;
            }
            th {
                background-color: #f4f4f4;
            }
            .total-row td {
                font-weight: bold;
                color: green;
            }
            .remove-btn {
                background-color: #dc3545;
                color: white;
                padding: 5px 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <h2>Giỏ hàng</h2>
        <button onclick="window.location.href = 'home.jsp'">Tiếp tục mua hàng</button>

        <c:set var="listcartdetails" value="${sessionScope.listcartdetail}" />

        <c:choose>
            <c:when test="${empty listcartdetails}">
                <p>Giỏ hàng của bạn đang trống.</p>
            </c:when>

            <c:otherwise>
                <table>
                    <tr>
                        <th>Hình ảnh</th>
                        <th>Tên Laptop</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Thành tiền</th>
                        <th>Mua</th>
                        <th>Xóa</th>
                    </tr>
                    <c:set var="total" value="0" />
                    <c:forEach var="item" items="${listcartdetails}">

                        <tr>
                            <td><button onclick="window.location.href = 'LaptopInfo?id=${item.getLaptop().getLaptopID()}'"><img src="images/${item.laptop.imageURL}" width="100" alt="${item.laptop.laptopName}" /></button></td>
                            <td>${item.laptop.laptopName}</td>
                            <td>${item.unitPrice} VNĐ</td>
                            <td>
                                <button onclick="window.location.href = 'QuantityChange?action=dec&id=${item.getLaptop().getLaptopID()}'">-</button>

                                ${item.quantity}
                                <button onclick="window.location.href = 'QuantityChange?action=inc&id=${item.getLaptop().getLaptopID()}'">+</button>

                            </td>
                        <td>${item.unitPrice * item.quantity} VNĐ</td>
                        <td><button style=" background-color: greenyellow" onclick="window.location.href= 'Order?id=${item.getLaptop().getLaptopID()}'">Mua</button></td>
                        <td>
                            <button style=" background-color: greenyellow" onclick="window.location.href = 'RemoveFromCart?id=${item.getLaptop().getLaptopID()}'">Xóa</button>
                        </td>
                    </tr>
                    <c:set var="total" value="${total + (item.unitPrice * item.quantity)}" />
                </c:forEach>

                <tr class="total-row">
                    <td colspan="4"><strong>Tổng cộng:</strong></td>
                    <td colspan="3"><strong>${total} VNĐ</strong></td>
                </tr>
            </table>
        </c:otherwise>
    </c:choose>
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

