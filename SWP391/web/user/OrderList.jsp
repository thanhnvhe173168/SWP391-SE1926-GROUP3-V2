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
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Đơn hàng</h1>
        <c:set var="orderlists" value="${orderlist}"/> 
        <c:set var="stt" value="1"/>
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
                            <td><button>Xem đơn</button></td>
                            <td><button>Hủy đơn</button></td>
                        </tr>
                    </c:forEach>
                </table>

            </c:otherwise>
        </c:choose>
    </body>
</html>
