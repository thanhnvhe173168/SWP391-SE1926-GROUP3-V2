<%-- 
    Document   : returnOrder
    Created on : Jun 22, 2025, 12:17:19 AM
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
        <title>Detail Return Order Page</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 0;
            }

            main {
                max-width: 1200px;
                margin: 0 auto;
                background: #fff;
                padding: 20px 30px;
                border-radius: 8px;
                box-shadow: 0 1px 6px rgba(0,0,0,0.05);
            }

            h1 {
                text-align: center;
                color: #1d4ed8; /* Xanh dương đậm */
                margin-bottom: 30px;
                font-size: 30px;
                font-weight: 600;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background: #fff;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 1px 6px rgba(0, 0, 0, 0.05);
            }

            th, td {
                text-align: center;
                padding: 16px 12px;
                border-bottom: 1px solid #eee;
                font-size: 15px;
            }

            th {
                background: #d70018; /* Đổi màu header thành xanh dương */
                color: #fff;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            tr:hover {
                background-color: #eef2ff;
            }

            button {
                background: #2563eb; /* Xanh dương */
                color: #fff;
                border: none;
                padding: 10px 16px;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 500;
                font-size: 14px;
                transition: background-color 0.3s ease;
            }

            button:hover {
                background-color: #1e40af; /* Đậm hơn khi hover */
            }

            img {
                width: 100px;
                height: 100px;
                border-radius: 12px;
                object-fit: cover;
                box-shadow: 0 2px 6px rgba(0,0,0,0.15);
                transition: transform 0.2s ease;
            }

            img:hover {
                transform: scale(1.05);
            }

            /* Hàng cuối */
            table tr:last-child td {
                text-align: left;
                padding: 20px;
                border-bottom: none;
            }

            table tr:last-child button {
                background: #2563eb;
            }

            table tr:last-child button:hover {
                background: #1e40af;
            }
        </style>




    </head>
    <body>
        <jsp:include page="/components/Header.jsp"></jsp:include>
            <main>
                <h1>Return Details</h1>
            <c:set var="lists" value="${list}"/>
            <c:set var="order" value="${od}"/>
            <form action="ItemSelectReturn" method="post">
                <table>
                    <tr>
                        <th>Select Item</th>
                        <th>Laptop Image</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Unit Price</th>
                    </tr>
                    <c:forEach items="${lists}" var="orderdetail" >
                        <tr>
                            <td>
                                <input type="checkbox" name="selectedLaptopIDs" value="${orderdetail.laptop.laptopID}" />
                            </td>
                            <td>
                                <img src="images/${orderdetail.laptop.imageURL}" width="100" alt="${orderdetail.laptop.laptopName}" />
                            </td>
                            <td>${orderdetail.quantity}</td>
                            <td><fmt:formatNumber value="${orderdetail.laptop.price}" type="number" groupingUsed="true"/> VNĐ</td>
                            <td><fmt:formatNumber value="${orderdetail.unitPrice}" type="number" groupingUsed="true"/> VNĐ</td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td colspan="5">
                            <input type="hidden" name="orderid" value="${order.orderID}">
                            <button type="submit">Return Order</button>
                        </td>
                    </tr>    
                </table>
            </form>
        </main>
        <jsp:include page="/components/Footer.jsp"></jsp:include>

    </body>
</html>