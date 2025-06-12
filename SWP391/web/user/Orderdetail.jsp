<%-- 
    Document   : Orderdetail
    Created on : Jun 3, 2025, 4:03:21 AM
    Author     : Window 11
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Page</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background: linear-gradient(to right, #f0f4f8, #ffffff);
                margin: 0;
                padding: 20px;
            }

            h1 {
                text-align: center;
                color: #333;
                margin-bottom: 30px;
                font-size: 2rem;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                border-radius: 12px;
                overflow: hidden;
                animation: fadeIn 0.6s ease-in-out;
            }

            th, td {
                padding: 16px 12px;
                text-align: center;
                font-size: 1rem;
            }

            th {
                background-color: #1976d2;
                color: #fff;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tr:hover {
                background-color: #eef6ff;
                transition: background-color 0.3s ease;
            }

            button {
                background: none;
                border: none;
                cursor: pointer;
                transition: transform 0.2s ease;
            }

            button:hover img {
                transform: scale(1.05);
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            }

            img {
                border-radius: 8px;
                transition: all 0.3s ease;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
        </style>

    </head>
    <body>
        <h1>Order Detail</h1>
        <c:set var="stt" value="0"/>
        <c:set var="lists" value="${list}"/>
        <table>
            <tr>
                <th>STT</th>
                <th>Hình ảnh</th>
                <th>Số lượng</th>
                <th>Giá</th>
                <th>Đơn giá</th>
            </tr>
            <tr>
                <c:forEach items="${lists}" var="orderdetail">
                    <td>${stt+1}</td>
                    <td><button type="button" onclick="window.location.href = 'LaptopInfo?id=${orderdetail.laptop.laptopID}'"><img src="images/${orderdetail.laptop.imageURL}" width="100" alt="${orderdetail.laptop.laptopName}" /></button></td>
                    <td>${orderdetail.quantity}</td>
                    <td><fmt:formatNumber value="${orderdetail.laptop.price}" type="number" groupingUsed="true"/> VNĐ</td>
                    <td><fmt:formatNumber value="${orderdetail.unitPrice}" type="number" groupingUsed="true"/> VNĐ</td>
                </c:forEach>
            </tr>
        </table>
    </body>
</html>
