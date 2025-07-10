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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

    </head>
    <body>
        <jsp:include page="/components/Header.jsp"></jsp:include>
            <main>
                <h1>Chi tiết đơn hàng</h1>
            <c:set var="lists" value="${list}"/>
            <c:set var="order" value="${od}"/>
            <table>
                <tr>
                    <th>Hình ảnh</th>
                    <th>Số lượng</th>
                    <th>Giá</th>
                    <th>Đơn giá</th>
                    <th>Hoàn đơn</th>
                </tr>
                <c:forEach items="${lists}" var="orderdetail" >
                    <tr>
                        <td>
                            <a href="LaptopInfo?id=${orderdetail.laptop.laptopID}">
                                <img src="images/${orderdetail.laptop.imageURL}" width="100" alt="${orderdetail.laptop.laptopName}" />
                            </a>
                        </td>
                        <td>${orderdetail.quantity}</td>
                        <td><fmt:formatNumber value="${orderdetail.laptop.price}" type="number" groupingUsed="true"/> VNĐ</td>
                        <td><fmt:formatNumber value="${orderdetail.unitPrice}" type="number" groupingUsed="true"/> VNĐ</td>
                        <td>
                            <button type="button" onclick="window.location.href = 'user/reasonReturnLaptop.jsp?lapid=${orderdetail.laptop.laptopID}&orderid=${order.orderID}'">Hoàn sản phẩm</button>
                        </td>
                    </tr>
                </c:forEach>
                <tr>
                    <td>
                        <button onclick="window.location.href = 'user/reasonReturnOrder.jsp?id=${od.orderID}'">Hoàn đơn hàng</button>
                    </td>
            </table>
        </main>
        <jsp:include page="/components/Footer.jsp"></jsp:include>

    </body>
</html>