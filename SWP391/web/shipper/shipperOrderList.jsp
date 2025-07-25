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

            html, body {
                margin: 0;
                padding: 0;
                overflow-x: hidden; /* Chặn tràn ngang toàn trang */
                font-family: Arial, sans-serif;
                background-color: #f4f6f9;
            }

            /* Wrapper chung */
            .wrapper {
                display: flex;
            }

            /* Bên phải nội dung */
            .page-container {
                margin-left: 220px;
                padding: 30px;
                background-color: #f4f6f9;
                width: calc(100% - 220px);
                box-sizing: border-box;
                max-width: 100vw; /* Không cho tràn ra ngoài */
            }

            /* Tabs đơn hàng */
            .order-tabs {
                display: flex;
                overflow-x: auto;
                white-space: nowrap;
                gap: 10px;
                margin-bottom: 20px;
                padding-bottom: 5px;
                border-bottom: 2px solid #007bff;
                scroll-behavior: smooth;
                max-width: 100%;
                box-sizing: border-box;

                /* Ẩn scrollbar */
                scrollbar-width: none;         /* Firefox */
                -ms-overflow-style: none;      /* IE/Edge */
            }
            .order-tabs::-webkit-scrollbar {
                display: none;                 /* Chrome/Safari */
            }

            .order-tabs .tab {
                flex: 0 0 auto;
                text-align: center;
                min-width: 120px;
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

            /* Các phần khác giữ nguyên như bạn đã dùng */


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
                    <h1 style="text-align: center">Danh sách đơn hàng</h1>
                <c:set var="currentStatus" value="${OrderStatus}" />
                <div class="order-tabs">
                    <div class="tab ${currentStatus == 'shipperList' ? 'active' : ''}" onclick="window.location.href = 'ShipperOrderList'">Tất cả đơn</div>
                    <div class="tab ${currentStatus == 'waittoget' ? 'active' : ''}" onclick="window.location.href = 'waittoget'">Chờ lấy hàng</div>
                    <div class="tab ${currentStatus == 'waitdeliver' ? 'active' : ''}" onclick="window.location.href = 'waitdeliver'">Chờ vận chuyển</div>
                    <div class="tab ${currentStatus == 'delivering' ? 'active' : ''}" onclick="window.location.href = 'delivering?id=3'">Đang giao</div>
                    <div class="tab ${currentStatus == 'delivered' ? 'active' : ''}" onclick="window.location.href = 'delivered?id=3'">Đã giao</div>
                    <div class="tab ${currentStatus == 'fail' ? 'active' : ''}" onclick="window.location.href = 'fail'">Giao thất bại</div>
                    <div class="tab ${currentStatus == 'redel' ? 'active' : ''}" onclick="window.location.href = 'redel'">Giao lại</div>
                    <div class="tab ${currentStatus == 'refail' ? 'active' : ''}" onclick="window.location.href = 'refail'">Giao lại thất bại</div>
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
                                    <th>Mã đơn</th>
                                    <th>Người đặt</th>
                                    <th>Ngày đặt hàng</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái đơn hàng</th>
                                    <th>Trạng thái thanh toán</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${orderlists}" var="order">
                                    <tr>
                                        <td>${order.orderID}</td>
                                        <td>${udao.getUserById(order.userID).fullName}</td>
                                        <td>${order.orderDate}</td>
                                        <td><fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/> VNĐ</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${order.orderstatus.statusID == 9}">
                                                    <form>
                                                        <input type="hidden" name="orderid" value="${order.orderID}"/>
                                                        <select name="OrderStatus" onchange="updateStatus(this)">
                                                            <option value="${order.orderstatus.statusID}">${order.orderstatus.statusName}</option>
                                                            <c:forEach items="${selectWhenWaitTake}" var="statusItem">
                                                                <c:if test="${order.orderstatus.statusID != statusItem.statusID}">
                                                                    <option value="${statusItem.statusID}">${statusItem.statusName}</option>
                                                                </c:if>
                                                            </c:forEach>
                                                        </select>
                                                    </form>
                                                </c:when>
                                                <c:when test="${order.orderstatus.statusID == 10}">
                                                    <form>
                                                        <input type="hidden" name="orderid" value="${order.orderID}"/>
                                                        <select name="OrderStatus" onchange="updateStatus(this)">
                                                            <option value="${order.orderstatus.statusID}">${order.orderstatus.statusName}</option>
                                                            <c:forEach items="${selectWhenDVVCtakesuccess}" var="statusItem">
                                                                <c:if test="${order.orderstatus.statusID != statusItem.statusID}">
                                                                    <option value="${statusItem.statusID}">${statusItem.statusName}</option>
                                                                </c:if>
                                                            </c:forEach>
                                                        </select>
                                                    </form>
                                                </c:when>
                                                <c:when test="${order.orderstatus.statusID == 11}">
                                                    <form>
                                                        <input type="hidden" name="orderid" value="${order.orderID}"/>
                                                        <select name="OrderStatus" onchange="updateStatus(this)">
                                                            <option value="${order.orderstatus.statusID}">${order.orderstatus.statusName}</option>
                                                            <c:forEach items="${selectWhendelivering}" var="statusItem">
                                                                <c:if test="${order.orderstatus.statusID != statusItem.statusID}">
                                                                    <option value="${statusItem.statusID}">${statusItem.statusName}</option>
                                                                </c:if>
                                                            </c:forEach>
                                                        </select>
                                                    </form>
                                                </c:when>
                                                <c:when test="${order.orderstatus.statusID == 13}">
                                                    <form>
                                                        <input type="hidden" name="orderid" value="${order.orderID}"/>
                                                        <select name="OrderStatus" onchange="updateStatus(this)">
                                                            <option value="${order.orderstatus.statusID}">${order.orderstatus.statusName}</option>
                                                            <c:forEach items="${selectWhenFail}" var="statusItem">
                                                                <c:if test="${order.orderstatus.statusID != statusItem.statusID}">
                                                                    <option value="${statusItem.statusID}">${statusItem.statusName}</option>
                                                                </c:if>
                                                            </c:forEach>
                                                        </select>
                                                    </form>
                                                </c:when>
                                                <c:when test="${order.orderstatus.statusID == 14}">
                                                    <form>
                                                        <input type="hidden" name="orderid" value="${order.orderID}"/>
                                                        <select name="OrderStatus" onchange="updateStatus(this)">
                                                            <option value="${order.orderstatus.statusID}">${order.orderstatus.statusName}</option>
                                                            <c:forEach items="${selectWhenReShip}" var="statusItem">
                                                                <c:if test="${order.orderstatus.statusID != statusItem.statusID}">
                                                                    <option value="${statusItem.statusID}">${statusItem.statusName}</option>
                                                                </c:if>
                                                            </c:forEach>
                                                        </select>
                                                    </form>
                                                </c:when>
                                                <c:when test="${order.orderstatus.statusID == 15}">
                                                    <form>
                                                        <input type="hidden" name="orderid" value="${order.orderID}"/>
                                                        <select name="OrderStatus" onchange="updateStatus(this)">
                                                            <option value="${order.orderstatus.statusID}">${order.orderstatus.statusName}</option>
                                                            <c:forEach items="${selectWhenReShipFail}" var="statusItem">
                                                                <c:if test="${order.orderstatus.statusID != statusItem.statusID}">
                                                                    <option value="${statusItem.statusID}">${statusItem.statusName}</option>
                                                                </c:if>
                                                            </c:forEach>
                                                        </select>
                                                    </form>
                                                </c:when>
                                                <c:when test="${order.orderstatus.statusID == 18 && order.orderstatus.statusID == 19}">
                                                    <form>
                                                        <input type="hidden" name="orderid" value="${order.orderID}"/>
                                                        <select name="OrderStatus" onchange="updateStatus(this)">
                                                            <option value="${order.orderstatus.statusID}">${order.orderstatus.statusName}</option>
                                                            <c:forEach items="${selectWhenRequestReturnPass}" var="statusItem">
                                                                <c:if test="${order.orderstatus.statusID != statusItem.statusID}">
                                                                    <option value="${statusItem.statusID}">${statusItem.statusName}</option>
                                                                </c:if>
                                                            </c:forEach>
                                                        </select>
                                                    </form>
                                                </c:when>
                                                <c:when test="${order.orderstatus.statusID == 23}">
                                                    <form>
                                                        <input type="hidden" name="orderid" value="${order.orderID}"/>
                                                        <select name="OrderStatus" onchange="updateStatus(this)">
                                                            <option value="${order.orderstatus.statusID}">${order.orderstatus.statusName}</option>
                                                            <c:forEach items="${selectWhenDVVCTakeReturnItem}" var="statusItem">
                                                                <c:if test="${order.orderstatus.statusID != statusItem.statusID}">
                                                                    <option value="${statusItem.statusID}">${statusItem.statusName}</option>
                                                                </c:if>
                                                            </c:forEach>
                                                        </select>
                                                    </form>
                                                </c:when>
                                                <c:when test="${order.orderstatus.statusID == 24}">
                                                    <form>
                                                        <input type="hidden" name="orderid" value="${order.orderID}"/>
                                                        <select name="OrderStatus" onchange="updateStatus(this)">
                                                            <option value="${order.orderstatus.statusID}">${order.orderstatus.statusName}</option>
                                                            <c:forEach items="${selectWhenReturnItemShipping}" var="statusItem">
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
                                        <td><button onclick="window.location.href = 'OrderDetailScreen?id=${order.orderID}&ids=2'">View Order</button></td>
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
