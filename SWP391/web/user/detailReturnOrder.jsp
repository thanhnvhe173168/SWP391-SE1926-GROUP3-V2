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
                background: #f9f9f9;
                margin: 0;
            }

            main {
                max-width: 1200px;
                margin: 0 auto;
                background: #fff;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }

            h1 {
                text-align: center;
                color: #007bff;
                margin-bottom: 30px;
            }

            table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                background: #fff;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 1px 6px rgba(0,0,0,0.1);
            }

            table th {
                background: #007bff;
                color: #fff;
                font-weight: bold;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                text-align: center;
                padding: 15px;
                vertical-align: middle;
            }

            td {
                text-align: center;
                padding: 20px 15px;
                vertical-align: middle;
                border-bottom: 1px solid #f2f2f2;
            }

            tr:hover {
                background: #f9f9f9;
            }

            img {
                border-radius: 8px;
                object-fit: cover;
                box-shadow: 0 1px 4px rgba(0,0,0,0.1);
            }

            button {
                background: #ee4d2d; /* Shopee cam */
                color: #fff;
                border: none;
                padding: 10px 20px;
                border-radius: 4px;
                cursor: pointer;
                font-weight: bold;
                transition: background 0.3s;
            }

            button:hover {
                background: #d8431f;
            }

            /* Nút hoàn đơn hàng dưới cùng */
            table tr:last-child td {
                text-align: left;
                padding: 20px;
            }

            table tr:last-child button {
                background: #27ae60; /* Xanh nổi bật */
            }

            table tr:last-child button:hover {
                background: #1e874b;
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
                                <a href="LaptopInfo?id=${orderdetail.laptop.laptopID}">
                                    <img src="images/${orderdetail.laptop.imageURL}" width="100" alt="${orderdetail.laptop.laptopName}" />
                                </a>
                            </td>
                            <td>${orderdetail.quantity}</td>
                            <td><fmt:formatNumber value="${orderdetail.laptop.price}" type="number" groupingUsed="true"/> VNĐ</td>
                            <td><fmt:formatNumber value="${orderdetail.unitPrice}" type="number" groupingUsed="true"/> VNĐ</td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td>
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