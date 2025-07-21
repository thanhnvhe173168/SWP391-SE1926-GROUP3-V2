<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.OrderDetail"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Đánh giá sản phẩm</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        th {
            background-color: #007bff;
            color: white;
            padding: 12px;
            text-transform: uppercase;
        }

        td {
            padding: 12px;
            text-align: center;
            vertical-align: middle;
            border-bottom: 1px solid #eee;
        }

        tr:hover {
            background-color: #f1f9ff;
        }

        img {
            width: 80px;
            height: auto;
            border-radius: 4px;
        }

        a.button {
            padding: 8px 16px;
            background-color: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        a.button:hover {
            background-color: #218838;
        }

        p {
            text-align: center;
            font-size: 18px;
            color: #888;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Đánh giá sản phẩm trong đơn hàng #${orderID}</h2>

    <c:if test="${empty orderDetails}">
        <p>Không có sản phẩm nào trong đơn hàng này.</p>
    </c:if>

    <c:if test="${not empty orderDetails}">
        <table>
            <thead>
                <tr>
                    <th>Hình ảnh</th>
                    <th>Tên Laptop</th>
                    <th>Số lượng</th>
                    <th>Đơn giá</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="od" items="${orderDetails}">
                    <tr>
                        <td><img src="images/${od.laptop.imageURL}" alt="Hình ảnh laptop"/></td>
                        <td>${od.laptop.laptopName}</td>
                        <td>${od.quantity}</td>
                        <td>${od.unitPrice}₫</td>
                        
                        <td>
                            <a class="button"
                               href="giveFeedback?orderID=${od.orderID}&laptopID=${od.laptop.laptopID}">
                                Đánh giá
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>
</body>
</html>
