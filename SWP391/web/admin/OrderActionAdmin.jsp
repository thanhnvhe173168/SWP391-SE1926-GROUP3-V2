<%-- 
    Document   : OrderActionAdmin
    Created on : Jul 17, 2025, 9:40:22 PM
    Author     : Window 11
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="model.*"%>
<%@page import="dao.*"%>

    <a href="OrderDetailScreen?id=${order.orderID}&ids=1" class="btn btn-outline-primary btn-sm">View Order</a>
    <c:if test="${(order.orderstatus.statusName eq 'Đã hủy' && order.paymentstatus.statusName eq 'Đã thanh toán')||order.orderstatus.statusName eq 'Đã hoàn' || order.orderstatus.statusName eq 'Đã hoàn 1 phần'}">
        <a href="vnpayRefundInput?id=${order.orderID}" class="btn btn-outline-primary btn-sm">Refund</a>
    </c:if>
    <c:if test="${order.orderstatus.statusName eq 'Yêu cầu hủy'}">
        <a href="${pageContext.request.contextPath}/ViewReasonCancel?id=${order.orderID}" class="btn btn-outline-primary btn-sm">View Reason Cancel</a>
    </c:if>
    <c:if test="${order.orderstatus.statusID == 17 || order.orderstatus.statusID == 16}">
        <a href="${pageContext.request.contextPath}/ViewReasonReturn?id=${order.orderID}" class="btn btn-outline-primary btn-sm"> View Reason Return</a>
    </c:if>
    <c:forEach items="${listOrderIdHaveReview}" var="orderidhave">
        <c:if test="${orderidhave==order.orderID}">
            <a href="${pageContext.request.contextPath}/ViewReview?id=${order.orderID}" class="btn btn-outline-primary btn-sm"> View Review</a>
        </c:if>
    </c:forEach>