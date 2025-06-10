<%-- 
    Document   : OrderList
    Created on : Jun 7, 2025, 9:59:09 AM
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
        <title>OrderList</title>
        <style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f4f6f9;
        margin: 0;
        padding: 20px;
        color: #333;
    }

    h1 {
        text-align: center;
        color: #2c3e50;
        margin-bottom: 30px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        background-color: #fff;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        border-radius: 10px;
        overflow: hidden;
    }

    th, td {
        padding: 14px 20px;
        text-align: center;
        border-bottom: 1px solid #e0e0e0;
    }

    th {
        background-color: #f1f3f5;
        color: #2c3e50;
        font-weight: 600;
    }

    tr:hover {
        background-color: #f9fbfc;
    }

    td[onclick] {
        transition: background-color 0.2s, transform 0.1s;
    }

    td[onclick]:hover {
        background-color: #e9f2ff;
    }

    td[onclick]:active {
        transform: scale(0.98);
        background-color: #d0e6ff;
    }

    button {
        padding: 8px 14px;
        background-color: #3498db;
        border: none;
        border-radius: 6px;
        color: white;
        font-weight: 500;
        cursor: pointer;
        transition: background-color 0.2s ease, transform 0.1s ease;
    }

    button:hover {
        background-color: #2980b9;
    }

    button:active {
        transform: scale(0.95);
    }

    p {
        text-align: center;
        font-size: 18px;
        color: #999;
    }
</style>

    </head>
    <body>
        <h1>Đơn hàng</h1>
        <table>
            <tr>
                <td onclick="window.location.href='waitconfirmed'" style="cursor: pointer;">Chờ xác nhận</td>
                <td onclick="window.location.href='delivering'" style="cursor: pointer;">Đang giao</td>
                <td onclick="window.location.href='delivered'" style="cursor: pointer;">Đã giao</td>
                <td onclick="window.location.href='canceled'" style="cursor: pointer;">Đã hủy</td>
                <td onclick="window.location.href='returned'" style="cursor: pointer;">Đã trả hàng</td>
                <td onclick="window.location.href='unpaid'" style="cursor: pointer;">Chưa thanh toán</td>
                <td onclick="window.location.href='evaluate'" style="cursor: pointer;">Cần đánh giá</td>
            </tr>
        </table>
        <c:set var="orderlists" value="${orderlist}"/> 
        <c:set var="stt" value="0"/>
        <c:choose>
            <c:when test="${empty orderlists}">
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
                        <th>Hủy đơn</th>
                    </tr>
                    <c:forEach items="${orderlists}" var="order">
                        <tr>
                            <td>${stt+1}</td>
                            <td>${order.orderDate}</td>
                            <td>${order.totalAmount}</td>
                            <td>${order.orderstatus.statusName}</td>
                            <td>${order.paymentstatus.statusName}</td>
                            <td><button onclick="window.location.href='OrderDetailScreen?id=${order.orderID}'">Xem đơn</button></td>
                            <td><button onclick="window.location.href='CancelOrder?id=${order.orderID}'">Hủy đơn</button></td>
                        </tr>
                    </c:forEach>
                </table>

            </c:otherwise>
        </c:choose>
    </body>
</html>
