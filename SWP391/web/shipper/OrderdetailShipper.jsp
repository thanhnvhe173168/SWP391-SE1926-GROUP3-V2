<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        html, body {
            margin: 0;
            padding: 0;
            overflow-x: hidden; /* Chặn cuộn ngang */
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f9;
        }

        .wrapper {
            display: flex;
        }

        .page-container {
            margin-left: 220px;
            padding: 30px;
            min-height: 100vh;
            background-color: #f4f6f9;
            width: calc(100% - 220px);
            box-sizing: border-box;
        }

        h1 {
            color: #dd3726;
            font-size: 40px;
            font-weight: 700;
            margin-bottom: 30px;
        }

        .detail-container {
            display: flex;
            gap: 30px;
            flex-wrap: wrap;
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
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            overflow: hidden;
            margin-bottom: 30px;
        }

        th, td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }

        tr:hover {
            background-color: #ffeae8;
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
            background: #007bff;
            color: #fff;
            padding: 10px 15px;
            margin: -20px -20px 20px -20px;
            border-radius: 8px 8px 0 0;
            font-size: 18px;
        }

        .order-info table {
            box-shadow: none;
            border-radius: 0;
        }

        .order-info tr td:first-child {
            text-align: right;
            font-weight: bold;
            color: #555;
            width: 40%;
            padding: 12px 10px;
            border-bottom: 1px solid #eee;
        }

        .order-info tr td:last-child {
            text-align: left;
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
            .page-container {
                margin-left: 0;
                width: 100%;
            }
        }
    </style>
</head>
<body>

<div class="wrapper">
    <jsp:include page="/components/ShipperSidebar.jsp"></jsp:include>

    <div class="page-container">
        <h1>Chi tiết đơn hàng</h1>

        <div class="detail-container">
            <!-- Bên trái: danh sách sản phẩm -->
            <div class="order-items">
                <c:set var="lists" value="${list}"/>
                <table>
                    <thead>
                        <tr>
                            <th>Hình ảnh</th>
                            <th>Tên sản phẩm</th>
                            <th>Số lượng</th>
                            <th>Giá</th>
                            <th>Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${lists}" var="orderdetail">
                            <tr>
                                <td>
                                    <button type="button" onclick="window.location.href = 'LaptopInfo?id=${orderdetail.laptop.laptopID}'">
                                        <img src="images/${orderdetail.laptop.imageURL}" width="100" alt="${orderdetail.laptop.laptopName}" />
                                    </button>
                                </td>
                                <td>${orderdetail.laptop.laptopName}</td>
                                <td>${orderdetail.quantity}</td>
                                <td><fmt:formatNumber value="${orderdetail.laptop.price}" type="number" groupingUsed="true"/> VNĐ</td>
                                <td><fmt:formatNumber value="${orderdetail.unitPrice * orderdetail.quantity}" type="number" groupingUsed="true"/> VNĐ</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Bên phải: thông tin đơn hàng -->
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

    </div>
</div>

</body>
</html>
