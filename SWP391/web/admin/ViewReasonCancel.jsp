<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reason Cancel</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
        }

        .main-content {
            flex: 1;
            background: #f8f9fa;
            height: 100vh;
            overflow-y: auto;
        }

        .return-container {
            max-width: 1200px;
            margin: 30px auto;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
        }

        h2, h3 {
            color: #dd3726;
            font-weight: 700;
            margin-bottom: 20px;
        }

        .content-flex {
            display: flex;
            gap: 30px;
        }

        .left-side, .right-side {
            flex: 1;
        }

        .laptop-list {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .laptop-item {
            background: #ffffff;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 15px;
            display: flex;
            align-items: flex-start;
            gap: 15px;
            transition: box-shadow 0.3s ease;
        }

        .laptop-item:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .laptop-item img.laptop-img {
            width: 150px;
            height: auto;
            border-radius: 6px;
            object-fit: cover;
        }

        .laptop-info {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 20px;
            flex: 1;
        }

        .info-left {
            flex: 1;
            min-width: 220px;
        }

        .info-right {
            background-color: #fff3cd;
            border: 1px solid #ffeeba;
            padding: 20px;
            border-radius: 8px;
        }

        .action-buttons {
            margin-top: 30px;
            text-align: right;
        }

        .action-buttons button {
            padding: 10px 20px;
            background: #dd3726;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .action-buttons button:hover {
            background: #bb2d20;
        }

        p strong {
            color: #333;
        }
    </style>
</head>
<body>
    <div class="d-flex">
        <!-- Sidebar -->
        <jsp:include page="/components/AdminSidebar.jsp"></jsp:include>

        <!-- Main content -->
        <div class="main-content">
            <div class="return-container">
                <h2>Reason Cancel for #${orderid}</h2>

                <form action="${pageContext.request.contextPath}/AccepCancel" method="post">
                    <input type="hidden" name="orderID" value="${orderid}" />

                    <div class="content-flex">
                        <!-- Bên trái: Danh sách laptop -->
                        <div class="left-side">
                            <h3>List of returned laptops:</h3>
                            <div class="laptop-list">
                                <c:forEach var="od" items="${list}">
                                    <div class="laptop-item">
                                        <img class="laptop-img" src="images/${od.laptop.imageURL}" alt="${od.laptop.laptopName}" />
                                        <div class="laptop-info">
                                            <div class="info-left">
                                                <p><strong>Laptop Name:</strong> ${od.laptop.laptopName}</p>
                                                <p><strong>Quantity:</strong> ${od.quantity}</p>
                                                <p><strong>Price:</strong>
                                                    <fmt:formatNumber value="${od.laptop.price}" type="number" groupingUsed="true"/> VNĐ
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Bên phải: Lý do hủy -->
                        <div class="right-side">
                            <h3>Reason for Cancellation</h3>
                            <div class="info-right">
                                <p>${reason}</p>
                            </div>
                        </div>
                    </div>

                    <!-- Nút submit -->
                    <div class="action-buttons">
                        <button type="submit">✅ Chấp nhận hủy đơn</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
