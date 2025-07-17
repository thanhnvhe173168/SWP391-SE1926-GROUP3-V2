<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reason Return</title>
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

        .form-check {
            margin-top: 10px;
        }

        .laptop-item img.laptop-img {
            width: 180px;
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

        .info-left, .info-right {
            flex: 1;
            min-width: 220px;
        }

        .info-right img {
            margin-top: 5px;
            border: 1px solid #ddd;
            border-radius: 4px;
            max-width: 200px;
            height: auto;
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
            <h2>Reason Return for #${order.orderID}</h2>

            <!-- Form bắt đầu -->
            <form action="${pageContext.request.contextPath}/AcceptReturnOrder" method="post">
                <input type="hidden" name="orderID" value="${order.orderID}" />

                <h3>List of returned laptops:</h3>
                <div class="laptop-list">
                    <c:forEach var="od" items="${list}">
                        <div class="laptop-item">
                            <!-- Checkbox chọn -->
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="selectedItems" value="${od.laptop.laptopID}" id="check${od.laptop.laptopID}">
                                <label class="form-check-label" for="check${od.laptop.laptopID}">Chọn</label>
                            </div>

                            <!-- Ảnh laptop -->
                            <img class="laptop-img" src="images/${od.laptop.imageURL}" alt="${od.laptop.laptopName}" />

                            <!-- Thông tin -->
                            <div class="laptop-info">
                                <!-- Thông tin cơ bản -->
                                <div class="info-left">
                                    <p><strong>Laptop Name:</strong> ${od.laptop.laptopName}</p>
                                    <p><strong>Quantity:</strong> ${od.quantity}</p>
                                    <p><strong>Price:</strong>
                                        <fmt:formatNumber value="${od.laptop.price}" type="number" groupingUsed="true"/> VNĐ
                                    </p>
                                </div>

                                <!-- Reason & Image -->
                                <div class="info-right">
                                    <p><strong>Reason return:</strong> ${od.reasonReturn}</p>
                                    <c:if test="${not empty od.imageReturn}">
                                        <p><strong>Image Return:</strong></p>
                                        <img src="${pageContext.request.contextPath}/${od.imageReturn}" alt="Image Return"/>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Nút submit -->
                <div class="action-buttons">
                    <button type="submit">✅ Chấp nhận hoàn đơn</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
