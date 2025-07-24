<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.OrderDetail"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>Đánh giá sản phẩm</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 20px;
            color: #333;
            line-height: 1.6;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            overflow-x: hidden;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 0 15px;
            width: 100%;
        }

        h2 {
            text-align: center;
            color: #d70018;
            font-size: 32px;
            font-weight: 700;
            margin: 30px 0 40px;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            position: relative;
            padding-bottom: 15px;
        }

        h2::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background-color: #d70018;
            border-radius: 2px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.08);
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 25px;
        }

        th {
            background-color: #f7f7f7;
            color: #555;
            padding: 18px 15px;
            font-size: 14px;
            font-weight: 600;
            text-transform: uppercase;
            border-bottom: 1px solid #eee;
            text-align: center;
        }

        td {
            padding: 15px;
            text-align: center;
            vertical-align: middle;
            border-bottom: 1px solid #f0f0f0;
            font-size: 14px;
            color: #333;
        }

        tr:last-child td {
            border-bottom: none;
        }

        tr:hover {
            background-color: #f8f8f8;
        }

        td img {
            width: 70px;
            height: 70px;
            border-radius: 6px;
            object-fit: cover;
            border: 1px solid #eee;
        }

        td strong {
            font-weight: 600;
            color: #1a1a1a;
        }

        a.button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 10px 22px;
            background-color: #d70018;
            color: #fff;
            text-decoration: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            transition: background-color 0.2s ease, transform 0.2s ease, box-shadow 0.2s ease;
            box-shadow: 0 2px 6px rgba(215, 0, 24, 0.2);
        }

        a.button:hover {
            background-color: #b70015;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(215, 0, 24, 0.3);
        }

        p {
            text-align: center;
            font-size: 16px;
            color: #666;
            margin: 30px 0;
            font-weight: 400;
        }

        @media (max-width: 768px) {
            body {
                padding: 15px;
            }

            h2 {
                font-size: 24px;
                margin: 20px 0 30px;
            }

            h2::after {
                width: 60px;
                height: 3px;
            }

            table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
                -webkit-overflow-scrolling: touch;
                border-radius: 8px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.07);
            }

            th, td {
                padding: 12px 10px;
                min-width: 100px;
                font-size: 13px;
            }

            td img {
                width: 50px;
                height: 50px;
            }

            a.button {
                padding: 8px 18px;
                font-size: 13px;
            }
        }

        @media (max-width: 576px) {
            .container {
                padding: 0 10px;
            }

            h2 {
                font-size: 20px;
                margin: 15px 0 25px;
            }

            th, td {
                padding: 10px 8px;
                min-width: 80px;
            }

            td img {
                width: 40px;
                height: 40px;
            }

            a.button {
                padding: 7px 14px;
                font-size: 12px;
            }
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
                        <td><strong>${od.laptop.laptopName}</strong></td>
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