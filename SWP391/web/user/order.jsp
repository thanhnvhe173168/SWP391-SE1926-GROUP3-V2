<%-- 
    Document   : order
    Created on : May 27, 2025, 3:53:04 PM
    Author     : Window 11
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="model.*" %>
<%@page import="dao.*" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Page</title>
        <link rel="stylesheet" href="styles.css" />
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, sans-serif;
                background-color: #f9f9f9;
            }

            h2 {
                text-align: center;
                color: #2c3e50;
                margin-bottom: 20px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: white;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                border-radius: 10px;
                overflow: hidden;
            }

            th, td {
                padding: 14px;
                text-align: center;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #f1f1f1;
                color: #333;
            }

            tr:hover {
                background-color: #f5f5f5;
            }

            img {
                border-radius: 8px;
            }

            button {
                padding: 6px 12px;
                border-radius: 6px;
                border: none;
                cursor: pointer;
                font-size: 14px;
            }

            button:hover {
                opacity: 0.9;
            }

            .total-row {
                background-color: #f1f1f1;
                font-weight: bold;
                font-size: 1.1em;
            }

            button[onclick*="QuantityChange"][onclick*='dec'],
            button[onclick*="QuantityChange"][onclick*='inc'] {
                background-color: #ecf0f1;
                color: #333;
            }

            button[onclick*='Order'] {
                background-color: #2ecc71 !important;
                color: white;
            }

            button[onclick*='RemoveFromCart'] {
                background-color: #e74c3c !important;
                color: white;
            }

            .empty-cart {
                text-align: center;
                font-size: 18px;
                color: #888;
                margin-top: 40px;
            }

            button[onclick*='home.jsp'] {
                background-color: #3498db;
                color: white;
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <h1>Đặt hàng</h1>
        <form>
            <c:set var="listorderings" value="${listordering}" />
                    
                        <table>
                            <tr>
                                <th>Hình ảnh</th>
                                <th>Tên Laptop</th>
                                <th>Giá</th>
                                <th>Số lượng</th>
                                <th>Thành tiền</th>
                            </tr>

                            <c:forEach var="item" items="${listorderings}">
                                <tr>
                                    <td><button type="button" onclick="window.location.href = 'LaptopInfo?id=${item.getLaptop().getLaptopID()}'"><img src="images/${item.laptop.imageURL}" width="100" alt="${item.laptop.laptopName}" /></button></td>
                                    <td>${item.laptop.laptopName}</td>
                                    <td><fmt:formatNumber value="${item.unitPrice}" type="number" groupingUsed="true"/> VNĐ</td>
                                <td>
                                    <button type="button" onclick="window.location.href = 'QuantityChange?action=dec&id=${item.getLaptop().getLaptopID()}'">-</button>

                                    ${item.quantity}
                                    <button type="button" onclick="window.location.href = 'QuantityChange?action=inc&id=${item.getLaptop().getLaptopID()}'">+</button>

                                </td>
                                <td><fmt:formatNumber value="${item.unitPrice * item.quantity}" type="number" groupingUsed="true"/> VNĐ</td>
                                </tr>
                            </c:forEach>

                            <tr class="total-row">
                                <td colspan="4"><strong>Tổng cộng:</strong></td>
                                <td colspan="1"><strong><fmt:formatNumber value="${total}" type="number" groupingUsed="true"/> VNĐ</strong></td>


                            </tr>
                        </table>
                    </form>
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
