<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết đơn hàng</title>
        <style>
            /* Cấu hình cơ bản */
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f9f9f9;
                margin: 0;
                padding: 0;
                color: #333;
            }

            h1, h2, h3 {
                margin: 20px 0;
                color: #222;
                font-weight: 600;
                text-align: center;
            }

            a {
                text-decoration: none;
                color: #e60012;
            }

            button {
                background-color: #e60012;
                color: white;
                border: none;
                padding: 10px 18px;
                font-size: 15px;
                border-radius: 6px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            button:hover {
                background-color: #c50010;
            }

            /* Container chính */
            .detail-container {
                display: flex;
                gap: 30px;
                max-width: 1200px;
                margin: 0 auto;
                padding: 30px 20px 60px;
                align-items: flex-start;
            }

            /* Danh sách sản phẩm */
            .order-items {
                flex: 2;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                border-radius: 12px;
                box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
                overflow: hidden;
                margin-bottom: 30px;
            }

            table th, table td {
                padding: 14px;
                text-align: center;
                border-bottom: 1px solid #eee;
                font-size: 15px;
            }

            table th {
                background-color: #e60012;
                color: #fff;
                font-weight: 500;
            }

            table tr:hover {
                background-color: #f2f2f2;
            }

            table tr:last-child td {
                border-bottom: none;
            }

            img {
                width: 80px;
                height: auto;
                border-radius: 6px;
                transition: transform 0.3s;
            }

            img:hover {
                transform: scale(1.05);
            }

            /* Thông tin đơn hàng */
            .order-info {
                flex: 1;
                background: #fff;
                border-radius: 8px;
                padding: 20px;
                box-shadow: 0 4px 14px rgba(0,0,0,0.08);
                position: sticky;
                top: 20px;
            }

            .order-info h2 {
                background: #e60012;
                color: #fff;
                padding: 12px 15px;
                margin: -20px -20px 20px -20px;
                border-radius: 8px 8px 0 0;
                font-size: 17px;
                text-align: center;
            }

            .order-info table {
                box-shadow: none;
                border-radius: 0;
                background: none;
            }

            .order-info td {
                padding: 10px 8px;
                border-bottom: 1px solid #eee;
                font-size: 15px;
            }

            .order-info td:first-child {
                font-weight: 500;
                color: #666;
                text-align: left;
            }

            .order-info td:last-child {
                font-weight: 600;
                color: #222;
                text-align: right;
            }

            .order-info tr:last-child td {
                border-bottom: none;
            }

            /* Responsive */
            @media (max-width: 992px) {
                .detail-container {
                    flex-direction: column;
                }

                .order-info {
                    position: static;
                    top: auto;
                    margin-top: 20px;
                }

                table th, table td {
                    padding: 12px 8px;
                    font-size: 14px;
                }

                img {
                    width: 60px;
                }
            }

        </style>
    </head>
    <body>
        <jsp:include page="/components/Header.jsp"></jsp:include>

            <h1>Order details</h1>

            <div class="detail-container">

                <!-- Danh sách sản phẩm bên trái -->
                <div class="order-items">
                <c:set var="lists" value="${list}"/>
                <table>
                    <thead>
                        <tr>
                            <th>Image</th>
                            <th>Laptop Name</th>
                            <th>Quantity</th>
                            <th>Unit Price</th>
                            <th>Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${lists}" var="orderdetail" varStatus="status">
                            <tr>
                                <td>         
                                        <img src="images/${orderdetail.laptop.imageURL}" width="100" alt="${orderdetail.laptop.laptopName}" />
                                </td>
                                <td>${orderdetail.laptop.laptopName}</td>
                                <td>${orderdetail.quantity}</td>
                                <td><fmt:formatNumber value="${orderdetail.laptop.price}" type="number" groupingUsed="true"/> VNĐ</td>
                                <td><fmt:formatNumber value="${orderdetail.unitPrice*orderdetail.quantity}" type="number" groupingUsed="true"/> VNĐ</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Thông tin đơn hàng bên phải -->
            <div class="order-info">
                <h2>Order information</h2>
                <c:set var="order" value="${od}"/>
                <table>
                    <tr>
                        <td>Voucher:</td>
                        <td>${order.voucher.vouchercode}</td>
                    </tr>
                    <tr>
                        <td>Shipping fee:</td>
                        <td><fmt:formatNumber value="${order.shipfee.fee}" type="number" groupingUsed="true"/> VNĐ</td>
                    </tr>
                    <tr>
                        <td>Delivery address:</td>
                        <td>${order.address}</td>
                    </tr>
                    <tr>
                        <td>Phone number:</td>
                        <td>${order.phoneNumber}</td>
                    </tr>
                    <tr>
                        <td>Payment method:</td>
                        <td>${order.paymentmethod.methodName}</td>
                    </tr>
                    <tr>
                        <td>Note:</td>
                        <td>${order.note}</td>
                    </tr>
                </table>
            </div>

        </div>

        <jsp:include page="/components/Footer.jsp"></jsp:include>
    </body>
</html>
