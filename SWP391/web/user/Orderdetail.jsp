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
                background-color: #f4f6f9;
                margin: 0;
                padding: 30px;
            }

            h1 {
                text-align: center;
                color: #333;
                margin-bottom: 30px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                overflow: hidden;
            }

            th, td {
                padding: 15px;
                text-align: center;
                border-bottom: 1px solid #eee;
            }

            th {
                background-color: #1e88e5;
                color: white;
                font-weight: 500;
            }

            tr:last-child td {
                border-bottom: none;
            }

            img {
                border-radius: 8px;
                transition: transform 0.3s;
            }

            img:hover {
                transform: scale(1.05);
            }

            button {
                background: none;
                border: none;
                cursor: pointer;
            }

            /* Dòng thông tin đơn hàng */
            .order-info {
                margin-top: 30px;
            }

            .order-info tr td:first-child {
                text-align: right;
                font-weight: bold;
                color: #555;
                width: 30%;
            }

            .order-info tr td:last-child {
                text-align: left;
                padding-left: 10px;
                color: #333;
            }

            @media (max-width: 768px) {
                table, th, td {
                    font-size: 14px;
                }

                img {
                    width: 80px;
                }
            }
        </style>

    </head>
    <body>
        <jsp:include page="/components/Header.jsp"></jsp:include>
        <a href="OrderList">Trở về</a>
        <h1>Chi tiết đơn hàng</h1>
        <c:set var="stt" value="0"/>
        <c:set var="lists" value="${list}"/>
        <c:set var="order" value="${od}"/>
        <table>
            <tr>
                <th>STT</th>
                <th>Hình ảnh</th>
                <th>Số lượng</th>
                <th>Giá</th>
                <th>Đơn giá</th>
            </tr>
            <c:forEach items="${lists}" var="orderdetail" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>
                        <button type="button" onclick="window.location.href = 'LaptopInfo?id=${orderdetail.laptop.laptopID}'">
                            <img src="images/${orderdetail.laptop.imageURL}" width="100" alt="${orderdetail.laptop.laptopName}" />
                        </button>
                    </td>
                    <td>${orderdetail.quantity}</td>
                    <td><fmt:formatNumber value="${orderdetail.laptop.price}" type="number" groupingUsed="true"/> VNĐ</td>
                    <td><fmt:formatNumber value="${orderdetail.unitPrice}" type="number" groupingUsed="true"/> VNĐ</td>
                </tr>
            </c:forEach>
        </table>
        <table class="order-info">
            <tr>
                <td>Voucher:</td>
                <td>${order.voucher.vouchercode}</td>
            </tr>
            <tr>
                <td>Phí ship:</td>
                <td><fmt:formatNumber value="${order.shipfee.fee}" type="number" groupingUsed="true"/> VNĐ</td>
            </tr>
            <tr>
                <td>Địa chỉ nhận hàng:</td>
                <td>${order.address}</td>
            </tr>
            <tr>
                <td>Số điện thoại người nhận:</td>
                <td>${order.phoneNumber}</td>
            </tr>
            <tr>
                <td>Hình thức thanh toán:</td>
                <td>${order.paymentmethod.methodName}</td>
            </tr>
            <tr>
                <td>Lưu ý:</td>
                <td>${order.note}</td>
            </tr>
        </table>
        <jsp:include page="/components/Footer.jsp"></jsp:include>
    </body>
</html>
