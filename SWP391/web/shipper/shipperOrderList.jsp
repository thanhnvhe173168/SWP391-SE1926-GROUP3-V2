<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Quản lý đơn hàng - Shipper</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f6f9;
                margin: 0;
            }

            .wrapper {
                display: flex;
            }

            .page-container {
                margin-left: 220px;
                padding: 30px;
                background-color: #f4f6f9;
                width: calc(100% - 220px);
            }

            .order-tabs {
                display: flex;
                flex-wrap: wrap; /* Cho phép xuống hàng nếu không đủ chỗ */
                gap: 10px;
                margin-bottom: 20px;
                padding-bottom: 5px;
                border-bottom: 2px solid #007bff;
            }

            .order-tabs .tab {
                flex: 1 1 auto;  /* Cho phép co giãn đều */
                text-align: center;
                min-width: 100px;
                padding: 8px 12px;
                background-color: #e3f2fd;
                border-radius: 20px;
                cursor: pointer;
                font-weight: 500;
                color: #007bff;
                border: 1px solid transparent;
                transition: 0.3s;
                white-space: nowrap;
            }

            .order-tabs .tab:hover {
                background-color: #cce4f6;
            }

            .order-tabs .tab.active {
                background-color: #007bff;
                color: white;
                font-weight: bold;
                border: 1px solid #0056b3;
                box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.2);
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #ffffff;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            }

            th, td {
                padding: 14px 16px;
                text-align: left;
                border-bottom: 1px solid #e0e0e0;
            }

            th {
                background-color: #007bff;
                color: white;
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tr:hover {
                background-color: #eef7ff;
            }

            select {
                padding: 6px 10px;
                border-radius: 4px;
                border: 1px solid #ccc;
                font-size: 14px;
            }

            button {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 6px 12px;
                border-radius: 4px;
                cursor: pointer;
            }

            button:hover {
                background-color: #0056b3;
            }

            .pagination {
                text-align: center;
                margin-top: 20px;
            }

            .pagination a,
            .pagination span {
                margin: 0 4px;
                padding: 8px 16px;
                border: 1px solid #007bff;
                border-radius: 4px;
                color: #007bff;
                text-decoration: none;
                display: inline-block;
            }

            .pagination a:hover,
            .pagination span.current {
                background-color: #007bff;
                color: white;
            }
        </style>
    </head>
    <body>
        <div class="wrapper">
            <jsp:include page="/components/ShipperSidebar.jsp"></jsp:include>
                <div class="page-container">
                <c:set var="currentStatus" value="${OrderStatus}" />
                <div class="order-tabs">
                    <div class="tab ${currentStatus == 'shipperList' ? 'active' : ''}" onclick="window.location.href = 'ShipperOrderList'">Tất cả đơn</div>
                    <div class="tab ${currentStatus == 'waittoget' ? 'active' : ''}" onclick="window.location.href = 'waittoget'">Chờ lấy hàng</div>
                    <div class="tab ${currentStatus == 'waitdeliver' ? 'active' : ''}" onclick="window.location.href = 'waitdeliver'">Chờ vận chuyển</div>
                    <div class="tab ${currentStatus == 'delivering' ? 'active' : ''}" onclick="window.location.href = 'delivering?id=3'">Đang giao</div>
                    <div class="tab ${currentStatus == 'delivered' ? 'active' : ''}" onclick="window.location.href = 'delivered?id=3'">Đã giao</div>
                    <div class="tab ${currentStatus == 'fail' ? 'active' : ''}" onclick="window.location.href = 'fail'">Giao thất bại</div>
                    <div class="tab ${currentStatus == 'redel1' ? 'active' : ''}" onclick="window.location.href = 'redel1'">Giao lại lần 1</div>
                    <div class="tab ${currentStatus == 'redel2' ? 'active' : ''}" onclick="window.location.href = 'redel2'">Giao lại lần 2</div>
                    <div class="tab ${currentStatus == 'returnbycus' ? 'active' : ''}" onclick="window.location.href = 'returnbycus'">Khách hoàn trả</div>
                    <div class="tab ${currentStatus == 'returning' ? 'active' : ''}" onclick="window.location.href = 'returning?id=3'">Đang hoàn</div>
                    <div class="tab ${currentStatus == 'returned' ? 'active' : ''}" onclick="window.location.href = 'returntoshopsuccess'">Hoàn thành công</div>
                </div>

                <c:set var="orderlists" value="${shipperorderlist}"/>
                <c:choose>
                    <c:when test="${empty orderlists}">
                        <p>Không có đơn hàng nào</p>
                    </c:when>
                    <c:otherwise>
                        <table>
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Ngày đặt hàng</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái đơn hàng</th>
                                    <th>Trạng thái thanh toán</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${orderlists}" var="order" varStatus="status">
                                    <tr>
                                        <td>${status.index + 1}</td>
                                        <td>${order.orderDate}</td>
                                        <td><fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/> VNĐ</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${order.orderstatus.statusID != 12 && order.orderstatus.statusID != 25}">
                                                    <form>
                                                        <input type="hidden" name="orderid" value="${order.orderID}"/>
                                                        <select name="OrderStatus" onchange="updateStatus(this)">
                                                            <option value="${order.orderstatus.statusID}">${order.orderstatus.statusName}</option>
                                                            <c:forEach items="${liststatus}" var="statusItem">
                                                                <c:if test="${order.orderstatus.statusID != statusItem.statusID}">
                                                                    <option value="${statusItem.statusID}">${statusItem.statusName}</option>
                                                                </c:if>
                                                            </c:forEach>
                                                        </select>
                                                    </form>
                                                </c:when>
                                                <c:otherwise>
                                                    ${order.orderstatus.statusName}
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${order.paymentstatus.statusName}</td>
                                        <td><button onclick="window.location.href = ''">View Order</button></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>

                <div class="pagination">
                    <c:if test="${totalPages > 1}">
                        <c:if test="${currentPage > 1}">
                            <a href="?page=${currentPage - 1}">Previous</a>
                        </c:if>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <c:choose>
                                <c:when test="${i == currentPage}">
                                    <span class="current">${i}</span>
                                </c:when>
                                <c:otherwise>
                                    <a href="?page=${i}">${i}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <c:if test="${currentPage < totalPages}">
                            <a href="?page=${currentPage + 1}">Next</a>
                        </c:if>
                    </c:if>
                </div>
            </div>
        </div>

        <script>
            function updateStatus(selectElement) {
                const newStatusID = selectElement.value;
                const orderID = selectElement.closest('form').querySelector('[name="orderid"]').value;

                fetch('updateOrderStatusByShipper', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        orderId: orderID,
                        newStatusID: newStatusID
                    })
                })
                        .then(res => res.text())
                        .then(data => {
                            console.log(data);
                        });
            }
        </script>
    </body>
</html>
