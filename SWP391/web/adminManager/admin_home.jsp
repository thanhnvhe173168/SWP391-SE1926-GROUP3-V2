<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Admin Dashboard</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Main CSS -->
        <link rel="stylesheet" type="text/css" href="view/assets/admin/css/main.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

        <!-- Chart.js -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    </head>

    <body onload="time()" class="app sidebar-mini rtl">
        <%@include file="sidebar.jsp"%>

        <main class="a


              pp-content">
            <!-- Header -->
            <div class="app-title">
                <div>
                    <h1><i class="fas fa-chart-line"></i> Bảng điều khiển</h1>
                    <p id="clock" class="text-muted small"></p>
                </div>
            </div>

            <!-- Thống kê -->
            <div class="row">
                <div class="col-md-4">
                    <div class="widget-small primary coloured-icon"><i class='bx bxs-user-account fa-3x'></i>
                        <div class="info">
                            <h4>Tổng khách hàng</h4>
                            <p><b>${requestScope.TOTALUSERS} khách hàng</b></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="widget-small info coloured-icon"><i class='bx bxs-data fa-3x'></i>
                        <div class="info">
                            <h4>Tổng sản phẩm</h4>
                            <p><b>${requestScope.TOTALPRODUCTS} sản phẩm</b></p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="widget-small warning coloured-icon"><i class='bx bxs-shopping-bags fa-3x'></i>
                        <div class="info">
                            <h4>Tổng đơn hàng</h4>
                            <p><b>${requestScope.TOTALORDERS} đơn hàng</b></p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Đơn hàng gần đây -->
            <div class="tile mt-4">
                <h3 class="tile-title">Đơn hàng gần đây</h3>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover text-center">
                        <thead class="thead-dark">
                            <tr>
                                <th>ID</th>
                                <th>Khách hàng</th>
                                <th>SĐT</th>
                                <th>Địa chỉ</th>
                                <th>Ngày mua</th>
                                <th>Tổng tiền</th>
                                <th>Thanh toán</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${LAST_RECENT_ORDERS}" var="b">
                                <tr>
                                    <td>${b.getId()}</td>
                                    <td>${b.getFullname()}</td>
                                    <td>(+84) ${b.getPhoneNumber()}</td>
                                    <td>${b.getAddress()}</td>
                                    <td>${b.getOrderDate()}</td>
                                    <td>${b.getTotalMoney()} VND</td>
                                    <td>
                                        <span class="badge badge-success">${b.getPaymentId()}</span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>

        <!-- JS -->
        <script src="view/assets/admin/js/jquery-3.2.1.min.js"></script>
        <script src="view/assets/admin/js/popper.min.js"></script>
        <script src="view/assets/admin/js/bootstrap.min.js"></script>
        <script src="view/assets/admin/js/main.js"></script>
        <script src="view/assets/admin/js/plugins/pace.min.js"></script>

        <!-- Đồng hồ thời gian -->
        <script type="text/javascript">
        function time() {
            const today = new Date();
            const weekday = ["Chủ Nhật", "Thứ Hai", "Thứ Ba", "Thứ Tư", "Thứ Năm", "Thứ Sáu", "Thứ Bảy"];
            const day = weekday[today.getDay()];
            const dd = String(today.getDate()).padStart(2, '0');
            const mm = String(today.getMonth() + 1).padStart(2, '0');
            const yyyy = today.getFullYear();
            const h = today.getHours();
            const m = String(today.getMinutes()).padStart(2, '0');
            const nowTime = `${h}:${m}`;
                    const date = `${day}, ${dd}/${mm}/${yyyy}`;
                            document.getElementById("clock").innerHTML = `<span class="date">${date} - ${nowTime}</span>`;
                            setTimeout(time, 1000);
                        }
        </script>
    </body>

</html>
