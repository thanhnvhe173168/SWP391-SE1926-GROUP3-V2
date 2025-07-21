<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*" %>
<%@page import="dao.*" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>OrderList</title>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f7f9fc;
            }
            h1 {
                text-align: center;
                color: #333;
                margin-bottom: 20px;
            }

            /* Tabs giữ nguyên nếu cần */

            .order-card {
                background: #fff;
                border: 1px solid #ddd;
                margin-bottom: 20px;
                padding: 15px;
            }
            .shop-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 15px;
                font-weight: bold;
            }
            .order-status {
                color: #ee4d2d;
            }
            .product-info {
                display: flex;
                border-top: 1px solid #f0f0f0;
                padding-top: 10px;
                margin-top: 10px;
            }
            .product-info img {
                width: 80px;
                height: 80px;
                margin-right: 15px;
                border: 1px solid #eee;
            }
            .product-details {
                flex: 1;
            }
            .product-details div {
                margin-bottom: 4px;
            }
            .order-footer {
                text-align: right;
                border-top: 1px solid #eee;
                padding-top: 10px;
                margin-top: 10px;
            }
            .order-footer p {
                margin: 5px 0;
                font-size: 16px;
            }
            .order-footer span {
                color: #ee4d2d;
                font-size: 20px;
                font-weight: bold;
            }
            .order-footer button {
                background: #ee4d2d;
                color: #fff;
                border: none;
                padding: 8px 16px;
                margin-left: 5px;
                cursor: pointer;
                border-radius: 4px;
            }
            .order-footer button.contact {
                background: #fff;
                color: #333;
                border: 1px solid #ccc;
            }
            .order-tabs {
                display: flex;
                flex-wrap: wrap;
                background: #fff;
                border-bottom: 2px solid #f1f1f1;
                margin-bottom: 20px;
            }

            .order-tabs .tab {
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
                background: #ee4d2d;
                color: #fff;
                font-weight: bold;
            }
            .order-tabs {
                overflow-x: auto;
                white-space: nowrap;
            }
            .main{
                padding: 30px;
            }
        </style>
        <script>
            function confirmCancel(id) {
                Swal.fire({
                    title: "Bạn chắc chắn muốn hủy đơn?",
                    text: "Sau khi hủy sẽ không thể hoàn tác!",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#d33",
                    cancelButtonColor: "#3085d6",
                    confirmButtonText: "Vâng, hủy đơn",
                    cancelButtonText: "Không"
                }).then((result) => {
                    if (result.isConfirmed) {
                        document.getElementById("cancelform-" + id).submit();
                    }
                });
            }
        </script>
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
        <jsp:include page="/components/Header.jsp"></jsp:include>
        <h1>${title}</h1>
        <c:set var="currentStatus" value="${OrderStatus}" />

        <div class="main">
        <div class="order-tabs">
            <div class="tab ${currentStatus == 'OrderList' ? 'active' : ''}" onclick="window.location.href = 'OrderList'">Tất cả đơn</div>
            <div class="tab ${currentStatus == 'waitconfirmed' ? 'active' : ''}" onclick="window.location.href = 'waitconfirmed?id=1'">Chờ xác nhận</div>
            <div class="tab ${currentStatus == 'confirmed' ? 'active' : ''}" onclick="window.location.href = 'confirmed?id=1'">Đã xác nhận</div>
            <div class="tab ${currentStatus == 'delivering' ? 'active' : ''}" onclick="window.location.href = 'delivering?id=1'">Đang giao</div>
            <div class="tab ${currentStatus == 'delivered' ? 'active' : ''}" onclick="window.location.href = 'delivered?id=1'">Đã giao</div>
            <div class="tab ${currentStatus == 'canceled' ? 'active' : ''}" onclick="window.location.href = 'canceled?id=1'">Đã hủy</div>
            <div class="tab ${currentStatus == 'wantreturn' ? 'active' : ''}" onclick="window.location.href = 'wantreturn?id=1'">Yêu cầu trả hàng</div>
            <div class="tab ${currentStatus == 'returned' ? 'active' : ''}" onclick="window.location.href = 'returned?id=1'">Đã trả hàng</div>
            <div class="tab ${currentStatus == 'unpaid' ? 'active' : ''}" onclick="window.location.href = 'unpaid?id=1'">Chưa thanh toán</div>
            <div class="tab ${currentStatus == 'evaluate' ? 'active' : ''}" onclick="window.location.href = 'evaluate?id=1'">Cần đánh giá</div>
            <div class="tab ${currentStatus == 'completed' ? 'active' : ''}" onclick="window.location.href = 'completed?id=1'">Hoàn tất</div>
        </div>



        <!-- Danh sách đơn -->
        <c:set var="orderlists" value="${list}" />
        <c:choose>
            <c:when test="${empty orderlists}">
                <p>Không có đơn hàng nào</p>
            </c:when>
            <c:otherwise>
                <c:forEach items="${orderlists}" var="order">
                    <div class="order-card">
                        <div class="shop-header">
                            <span>Order Date: ${order.orderDate}</span>
                            <span class="order-status">${order.orderstatus.statusName}</span>
                        </div>
                        <c:forEach items="${oddao.GetListOrderDetailByID(order.orderID)}" var="orderdetail">
                            <div class="product-info">
                                <img src="images/${orderdetail.laptop.imageURL}" alt="Product">
                                <div class="product-details">
                                    <div style="display: flex; justify-content: space-between; align-items: center;">
                                        <div>
                                            <div>Laptop Name: ${orderdetail.laptop.laptopName}</div>
                                            <div>Category: ${cdao.GetCategory(orderdetail.laptop.category).categoryName}</div>
                                            <div>x ${orderdetail.quantity}</div>
                                        </div>
                                        <div style="text-align: right;">
                                            <span style="color:#ee4d2d; font-weight:bold; font-size:16px;">
                                                Price: <fmt:formatNumber value="${orderdetail.laptop.price}" type="number" groupingUsed="true"/> VNĐ
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <div class="order-footer">
                            <div style="color:#ee4d2d; font-weight:bold; font-size: 16px;">
                                Total amount: <fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/> VNĐ
                            </div>
                            <c:if test="${order.orderstatus.statusName eq 'Đã giao' || order.orderstatus.statusName eq 'Đã hủy' || order.orderstatus.statusName eq 'Đã hoàn' || order.orderstatus.statusName eq 'Hoàn tất' || order.orderstatus.statusName eq 'Đã hoàn 1 phần'}">
                                <form action="reOrder" method="get" style="display:inline;">
                                    <input type="hidden" name="id" value="${order.orderID}" />
                                    <button>Re Order</button>
                                </form>
                            </c:if>
                            <c:if test="${order.orderstatus.statusName eq 'Chờ xác nhận'}">
                                <form id="cancelform-${order.orderID}" action="CancelOrder" method="post" style="display:inline;">
                                    <input type="hidden" name="id" value="${order.orderID}" />
                                    <button type="button" onclick="confirmCancel('${order.orderID}')">Cancel Order</button>
                                </form>
                            </c:if>
                            <c:if test="${order.orderstatus.statusName eq 'Đã giao'}">
                                <div style="display: inline">
                                    <button type="button" onclick="window.location.href = 'detailReturnOrder?id=${order.orderID}'">Return Order</button>
                                </div>
                                <c:forEach items="${orderidneedreview}" var="orderidneed">
                                    <c:if test="${orderidneed==order.orderID}">
                                        <div style="display: inline">
                                            <button type="button" onclick="window.location.href='reviewOrder?orderID=${order.orderID}'">Review Order</button>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </c:if>
                            <button onclick="window.location.href = 'OrderDetailScreen?id=${order.orderID}'">View Detail</button>
                            <button>Liên hệ người bán</button>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        </div>
        <jsp:include page="/components/Footer.jsp"></jsp:include>
    </body>
</html>
