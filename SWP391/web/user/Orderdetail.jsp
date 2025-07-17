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
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            color: #333;
            margin: 30px 0;
        }

        .detail-container {
            display: flex;
            gap: 30px;
            max-width: 1200px;
            margin: 0 auto 50px;
            padding: 0 20px;
            align-items: flex-start;
        }

        .order-items {
            flex: 2;
        }

        .order-info {
            flex: 1;
            background: #fff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            position: sticky;
            top: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            margin-bottom: 30px;
        }

         table th, td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #1e88e5;
            color: white;
            font-weight: 500;
        }

        tr:hover {
            background-color: #f0f0f0;
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

        .order-info h2 {
            background: #1e88e5;
            color: #fff;
            padding: 10px 15px;
            margin: -20px -20px 20px -20px;
            border-radius: 8px 8px 0 0;
            font-size: 18px;
            text-align: center;
        }

        .order-info table {
            box-shadow: none;
            border-radius: 0;
        }

        .order-info tr td:first-child {
            text-align: center;
            font-weight: bold;
            color: #555;
            width: 40%;
            padding: 12px 10px;
            border-bottom: 1px solid #eee;
        }

        .order-info tr td:last-child {
            text-align: center;
            padding-left: 10px;
            color: #333;
            padding: 12px 10px;
            border-bottom: 1px solid #eee;
        }

        .order-info tr:last-child td {
            border-bottom: none;
        }

        @media (max-width: 992px) {
            .detail-container {
                flex-direction: column;
            }

            .order-info {
                position: static;
                top: auto;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/components/Header.jsp"></jsp:include>

<h1>Chi tiết đơn hàng</h1>

<div class="detail-container">

    <!-- Danh sách sản phẩm bên trái -->
    <div class="order-items">
        <c:set var="lists" value="${list}"/>
        <table>
            <thead>
            <tr>
                <th>Hình ảnh</th>
                <th>Tên sản phẩm</th>
                <th>Số lượng</th>
                <th>Giá</th>
                <th>Đơn giá</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${lists}" var="orderdetail" varStatus="status">
                <tr>
                    <td>
                        <button type="button" onclick="window.location.href = 'LaptopInfo?id=${orderdetail.laptop.laptopID}'">
                            <img src="images/${orderdetail.laptop.imageURL}" width="100" alt="${orderdetail.laptop.laptopName}" />
                        </button>
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
        <h2>Thông tin đơn hàng</h2>
        <c:set var="order" value="${od}"/>
        <table>
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
                <td>Số điện thoại:</td>
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
    </div>

</div>

<jsp:include page="/components/Footer.jsp"></jsp:include>
</body>
</html>
