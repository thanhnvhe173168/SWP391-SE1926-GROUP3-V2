<%-- 
    Document   : evaluate
    Created on : Jun 11, 2025, 2:01:26 AM
    Author     : Window 11
--%>
<%@page import="model.*" %>
<%@page import="dao.*" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Evaluate Page</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f0f2f5;
                padding: 20px;
                color: #2c3e50;
            }

            h1 {
                text-align: center;
                color: #1e272e;
                margin-bottom: 30px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background: #ffffff;
                margin-bottom: 25px;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
            }

            table:first-of-type th, table:first-of-type td {
                padding: 14px;
                border-bottom: 1px solid #ddd;
                text-align: center;
            }

            table:first-of-type th {
                background-color: #dfe6e9;
                color: #2c3e50;
                font-weight: bold;
            }

            /* Table chi tiết đơn hàng */
            .order-details {
                width: 65%;
                margin: auto;
                background: #ffffff;
                border: 1px solid #b2bec3;
                font-size: 15px;
            }

            .order-details td {
                padding: 12px;
                border-bottom: 1px solid #dcdde1;
                vertical-align: top;
                font-weight: 500;
            }

            .order-details input,
            .order-details select,
            .order-details textarea {
                width: 100%;
                padding: 8px;
                font-size: 14px;
                border: 1px solid #636e72;
                border-radius: 5px;
                box-sizing: border-box;
            }

            .order-details input[type="radio"] {
                margin-right: 8px;
                transform: scale(1.1);
                cursor: pointer;
            }

            .order-details label {
                display: block;
                margin-bottom: 6px;
                cursor: pointer;
                color: #2c3e50;
            }

            button {
                background-color: #0984e3;
                color: white;
                border: none;
                padding: 9px 16px;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                font-weight: 600;
            }

            button:hover {
                background-color: #0652dd;
            }

            #shipFeeDisplay {
                font-weight: bold;
                color: #e17055;
            }

            .total-row td {
                font-weight: bold;
                font-size: 16px;
                background-color: #dff9fb;
                color: #130f40;
            }

            input:focus, select:focus, textarea:focus {
                border-color: #00a8ff;
                outline: none;
                box-shadow: 0 0 6px rgba(0, 168, 255, 0.5);
            }
            input[type="radio"]:focus {
                outline: none;
                box-shadow: none;
            }
            td {
                cursor: pointer;
                transition: background-color 0.2s, transform 0.1s;
            }

            td:active {
                background-color: #e0e0e0;
                transform: scale(0.97);
            }

            td:hover {
                background-color: #f5f5f5;
            }

        </style>
    </head>
    <body>
        <h1>Đơn hàng cần đánh giá</h1>
        <table>
            <tr>
                <td onclick="window.location.href = 'waitconfirmed'" style="cursor: pointer;">Chờ xác nhận</td>
                <td onclick="window.location.href = 'delivering'" style="cursor: pointer;">Đang giao</td>
                <td onclick="window.location.href = 'delivered'" style="cursor: pointer;">Đã giao</td>
                <td onclick="window.location.href = 'canceled'" style="cursor: pointer;">Đã hủy</td>
                <td onclick="window.location.href = 'returned'" style="cursor: pointer;">Đã trả hàng</td>
                <td onclick="window.location.href = 'unpaid'" style="cursor: pointer;">Chưa thanh toán</td>
                <td onclick="window.location.href = 'evaluate'" style="cursor: pointer;">Cần đánh giá</td>
            </tr>
        </table>
        <c:set var="lists" value="${list}"/> 
        <c:set var="stt" value="0"/>
        <c:choose>
            <c:when test="${empty lists}">
                <P>Không có đơn hàng nào</P>
                </c:when>
                <c:otherwise>
                <table border="1">
                    <tr>
                        <th>STT</th>
                        <th>Ngày đặt hàng</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái đơn hàng</th>
                        <th>Trạng thái thanh toán</th>
                        <th>Xem đơn</th>
                        <th>Đánh giá</th>
                    </tr>
                    <c:forEach items="${lists}" var="order">
                        <tr>
                            <td>${stt+1}</td>
                            <td>${order.orderDate}</td>
                            <td>${order.totalAmount}</td>
                            <td>${order.orderstatus.statusName}</td>
                            <td>${order.paymentstatus.statusName}</td>
                            <td><button onclick="window.location.href = 'OrderDetailScreen?id=${order.orderID}'">Xem đơn</button></td>
                            <td><button onclick="window.location.href = 'ReviewOrder?id=${order.orderID}'">Đánh giá</button></td>
                        </tr>
                    </c:forEach>
                </table>

            </c:otherwise>
        </c:choose>
    </body>
</html>
