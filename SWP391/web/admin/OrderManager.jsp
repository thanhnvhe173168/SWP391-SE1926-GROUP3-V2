<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*"%>
<%@page import="dao.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Quản lý đơn hàng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            .container {
                padding: 30px 20px;
            }
            .order-tabs {
                display: flex;
                flex-wrap: nowrap;               /* Không xuống dòng */
                overflow-x: auto;                /* Cho phép scroll ngang */
                -webkit-overflow-scrolling: touch; /* Scroll mượt trên mobile */
                background: #fff;
                border-bottom: 2px solid #f1f1f1;
                margin-bottom: 20px;
                scrollbar-width: none;           /* Firefox: ẩn scrollbar */
            }

            .order-tabs::-webkit-scrollbar {
                display: none;                   /* Chrome/Safari: ẩn scrollbar */
            }

            .order-tabs .tab {
                flex: 0 0 auto;                  /* Không co giãn */
                white-space: nowrap;             /* Nội dung tab không xuống dòng */
                padding: 10px 18px;
                cursor: pointer;
                transition: all 0.3s ease;
                border-radius: 4px 4px 0 0;
                margin-right: 5px;
                font-weight: 500;
            }

            .order-tabs .tab:hover {
                background: #f5f5f5;
            }

            .order-tabs .tab.active {
                background: #dd3726;
                color: #fff;
                font-weight: bold;
            }

            table {
                background-color: #ffffff;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 4px 12px rgba(0,0,0,0.06);
                width: 100%;
                border-collapse: collapse;
            }
            thead th {
                background-color: #dd3726;
                color: white;
                font-weight: bold;
            }
            tbody tr:hover {
                background-color: #ffeae8;
            }
            th, td {
                padding: 12px 16px;
                text-align: center;
                border: 1px solid #ddd;
            }
            td select {
                padding: 6px 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                background-color: #fff;
                font-size: 14px;
                color: #333;
                appearance: none; /* Ẩn style mặc định của browser */
                -webkit-appearance: none;
                -moz-appearance: none;
                background-image: url('data:image/svg+xml;utf8,<svg fill="%23333" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/></svg>');
                background-repeat: no-repeat;
                background-position: right 10px center;
                background-size: 16px;
            }

            td select:hover {
                border-color: #888;
            }

            td select:focus {
                border-color: #555;
                outline: none;
            }

            td {
                vertical-align: middle; /* Canh giữa select theo chiều dọc */
            }
        </style>
    </head>
    <body>
        <%
            String mess = (String) request.getAttribute("mess");
            if (mess != null) {
        %>
        <script>
            Swal.fire({
                icon: 'success',
                title: '<%= mess %>',
                showConfirmButton: false,
                timer: 2000
            });
        </script>
        <% } %>
        <div class="d-flex">
            <!-- Sidebar -->
            <jsp:include page="/components/AdminSidebar.jsp"></jsp:include>

                <!-- Nội dung chính -->
                <div style="width: 100%; height: calc(100dvh - 40px); overflow-y: auto;" class="container">
                    <!-- Tiêu đề -->
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <p style="color: #dd3726; font-size: 40px; font-weight: 700;">Quản lý đơn hàng</p>
                        <!-- Nếu cần thêm nút action ở đây -->
                    </div>

                    <!-- Tabs -->
                <c:set var="currentStatus" value="${OrderStatus}" />
                <div class="order-tabs">
                    <div class="tab ${currentStatus == 'OrderList' ? 'active' : ''}" onclick="window.location.href = 'OrderManager'">Tất cả đơn</div>
                    <div class="tab ${currentStatus == 'waitconfirmed' ? 'active' : ''}" onclick="window.location.href = 'waitconfirmed?id=2'">Chờ xác nhận</div>
                    <div class="tab ${currentStatus == 'wantcancel' ? 'active' : ''}" onclick="window.location.href = 'wantcancel?id=2'">Yêu cầu hủy</div>
                    <div class="tab ${currentStatus == 'confirmed' ? 'active' : ''}" onclick="window.location.href = 'confirmed?id=2'">Đã xác nhận</div>
                    <div class="tab ${currentStatus == 'delivering' ? 'active' : ''}" onclick="window.location.href = 'delivering?id=2'">Đang giao</div>
                    <div class="tab ${currentStatus == 'delivered' ? 'active' : ''}" onclick="window.location.href = 'delivered?id=2'">Đã giao</div>
                    <div class="tab ${currentStatus == 'canceled' ? 'active' : ''}" onclick="window.location.href = 'canceled?id=2'">Đã hủy</div>
                    <div class="tab ${currentStatus == 'wantreturn' ? 'active' : ''}" onclick="window.location.href = 'wantreturn?id=2'">Yêu cầu trả hàng</div>
                    <div class="tab ${currentStatus == 'returned' ? 'active' : ''}" onclick="window.location.href = 'returned?id=2'">Đã trả hàng</div>
                    <div class="tab ${currentStatus == 'unpaid' ? 'active' : ''}" onclick="window.location.href = 'unpaid?id=2'">Chưa thanh toán</div>
                    <div class="tab ${currentStatus == 'evaluate' ? 'active' : ''}" onclick="window.location.href = 'evaluate?id=2'">Cần đánh giá</div>
                    <div class="tab ${currentStatus == 'completed' ? 'active' : ''}" onclick="window.location.href = 'completed?id=2'">Hoàn tất</div>
                </div>

                <!-- Bảng danh sách đơn -->
                <c:set var="orderlists" value="${list}" />
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
                                    <th>Người đặt</th>
                                    <th>Tổng tiền</th>
                                    <th>Trạng thái đơn</th>
                                    <th>Trạng thái thanh toán</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${orderlists}" var="order" varStatus="status">
                                    <tr>
                                        <td>${status.index + 1}</td>
                                        <td>${order.orderDate}</td>
                                        <td>${udao.getUserById(order.userID).fullName}</td>
                                        <td><fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/> VNĐ</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${order.orderstatus.statusID == 5 || order.orderstatus.statusID == 6 || order.orderstatus.statusID == 8 || order.orderstatus.statusID == 16 ||order.orderstatus.statusID == 17 || order.orderstatus.statusID == 25 || order.orderstatus.statusID == 12}">
                                                    <form>
                                                        <input type="hidden" name="orderid" id="orderid" value="${order.orderID}"/>
                                                        <select name="OrderStatus" onchange="updateStatus(this)" id="orderstatus">
                                                            <option value="${order.orderstatus.statusID}">${order.orderstatus.statusName}</option>
                                                            <c:forEach items="${liststatus}" var="status">
                                                                <c:if test="${order.orderstatus.statusID != status.statusID}">
                                                                    <option value="${status.statusID}">${status.statusName}</option>
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
                                        <td>
                                            <form>
                                                <input type="hidden" name="orderid" value="${order.orderID}" />
                                                <select name="PaymentStatus" onchange="updatePaymentStatus(this)">
                                                    <option value="${order.paymentstatus.statusID}">${order.paymentstatus.statusName}</option>
                                                    <c:forEach items="${listPaymentStatus}" var="pstatus">
                                                        <c:if test="${pstatus.statusID != order.paymentstatus.statusID}">
                                                            <option value="${pstatus.statusID}">${pstatus.statusName}</option>
                                                        </c:if>
                                                    </c:forEach>
                                                </select>
                                            </form>
                                        </td>

                                        <td>
                                            <a href="OrderDetailScreen?id=${order.orderID}&ids=1" class="btn btn-outline-primary btn-sm">View Order</a>
                                            <c:if test="${(order.orderstatus.statusName eq 'Đã hủy' && order.paymentstatus.statusName eq 'Đã thanh toán')||order.orderstatus.statusName eq 'Đã hoàn' || order.orderstatus.statusName eq 'Đã hoàn 1 phần'}">
                                                <a href="vnpayRefundInput?id=${order.orderID}" class="btn btn-outline-primary btn-sm">Refund</a>
                                            </c:if>
                                            <c:if test="${order.orderstatus.statusName eq 'Yêu cầu hủy'}">
                                                <a href="${pageContext.request.contextPath}/ViewReasonCancel?id=${order.orderID}" class="btn btn-outline-primary btn-sm">View Reason Cancel</a>
                                            </c:if>
                                            <c:if test="${order.orderstatus.statusID == 17 || order.orderstatus.statusID == 16}">
                                                <a href="${pageContext.request.contextPath}/ViewReasonReturn?id=${order.orderID}" class="btn btn-outline-primary btn-sm"> View Reason Return</a>
                                            </c:if>
                                            <c:forEach items="${listOrderIdHaveReview}" var="orderidhave">
                                                <c:if test="${orderidhave==order.orderID}">
                                                    <a href="${pageContext.request.contextPath}/ViewReview?id=${order.orderID}" class="btn btn-outline-primary btn-sm"> View Review</a>
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        <script>

            function updateStatus(selectElement) {
                const newStatusID = selectElement.value;
                const form = selectElement.closest('form');
                const orderID = form.querySelector('[name="orderid"]').value;

                fetch('UpdateStatusByAdmin', {
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
                        .then(html => {
                            // Cập nhật nội dung cột Action bằng HTML trả về
                            const row = form.closest('tr');
                            const actionCell = row.querySelector('td:last-child');
                            actionCell.innerHTML = html;
                        });
            }

            function updatePaymentStatus(selectElement) {
                const newPaymentStatusID = selectElement.value;
                const orderID = selectElement.closest('form').querySelector('[name="orderid"]').value;

                fetch('UpdatePaymentStatusByAdmin', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        orderId: orderID,
                        newPaymentStatusID: newPaymentStatusID
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
