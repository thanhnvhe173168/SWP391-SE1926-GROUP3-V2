<%-- 
    Document   : delivering
    Created on : Jun 11, 2025, 1:12:23 AM
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
        <title>delivering Page</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f7f9fc;
                margin: 0;
                padding: 20px;
            }

            h1 {
                text-align: center;
                color: #333;
                margin-bottom: 30px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 30px;
            }

            /* Thanh menu trạng thái */
            table:first-of-type td {
                text-align: center;
                padding: 12px 20px;
                background-color: #ffffff;
                border: 1px solid #ddd;
                transition: background-color 0.3s, color 0.3s;
                font-weight: 500;
            }

            table:first-of-type td:hover {
                background-color: #e3f2fd;
                cursor: pointer;
            }

            table:first-of-type td.active {
                background-color: #1976d2;
                color: white;
                font-weight: bold;
                border-bottom: 3px solid #0d47a1;
            }

            /* Bảng danh sách đơn hàng */
            table:last-of-type {
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
                overflow: hidden;
            }

            table:last-of-type th,
            table:last-of-type td {
                padding: 12px 16px;
                border: 1px solid #e0e0e0;
                text-align: center;
            }

            table:last-of-type th {
                background-color: #f1f1f1;
                font-weight: 600;
                color: #333;
            }

            table:last-of-type tr:hover {
                background-color: #fafafa;
            }

            button {
                padding: 8px 14px;
                background-color: #1976d2;
                color: white;
                border: none;
                border-radius: 5px;
                transition: background-color 0.3s;
                cursor: pointer;
            }

            button:hover {
                background-color: #0d47a1;
            }

            p {
                text-align: center;
                color: #888;
                font-size: 16px;
            }
        </style>
    </head>
    <body>
        <h1>Đơn hàng đang giao</h1>
        <c:set var="currentStatus" value="${OrderStatus}" />

        <table>
            <tr>
                <td class="${currentStatus == 'OrderList' ? 'active' : ''}" onclick="window.location.href = 'OrderList'" style="cursor: pointer;">Tất cả đơn</td>
                <td class="${currentStatus == 'waitconfirmed' ? 'active' : ''}" onclick="window.location.href = 'waitconfirmed'" style="cursor: pointer;">Chờ xác nhận</td>
                <td class="${currentStatus == 'delivering' ? 'active' : ''}" onclick="window.location.href = 'delivering'" style="cursor: pointer;">Đang giao</td>
                <td class="${currentStatus == 'delivered' ? 'active' : ''}" onclick="window.location.href = 'delivered'" style="cursor: pointer;">Đã giao</td>
                <td class="${currentStatus == 'canceled' ? 'active' : ''}" onclick="window.location.href = 'canceled'" style="cursor: pointer;">Đã hủy</td>
                <td class="${currentStatus == 'returned' ? 'active' : ''}" onclick="window.location.href = 'returned'" style="cursor: pointer;">Đã trả hàng</td>
                <td class="${currentStatus == 'unpaid' ? 'active' : ''}" onclick="window.location.href = 'unpaid'" style="cursor: pointer;">Chưa thanh toán</td>
                <td class="${currentStatus == 'evaluate' ? 'active' : ''}" onclick="window.location.href = 'evaluate'" style="cursor: pointer;">Cần đánh giá</td>
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
                </tr>
                <c:forEach items="${lists}" var="order">
                    <tr>
                        <td>${stt+1}</td>
                        <td>${order.orderDate}</td>
                        <td>${order.totalAmount}</td>
                        <td>${order.orderstatus.statusName}</td>
                        <td>${order.paymentstatus.statusName}</td>
                        <td><button onclick="window.location.href = 'OrderDetailScreen?id=${order.orderID}'">Xem đơn</button></td>
                    </tr>
                </c:forEach>
            </table>

        </c:otherwise>
    </c:choose>
    </body>
</html>
