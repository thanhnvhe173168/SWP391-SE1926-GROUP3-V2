<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.DecimalFormat, java.util.Locale, java.time.Year" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f6f9;
            }
            .dashboard-header {
                background-color: #fff;
                padding: 20px;
                border-bottom: 1px solid #e9ecef;
                margin-bottom: 20px;
            }
            .dashboard-title {
                font-size: 1.8rem;
                font-weight: bold;
                color: #333;
            }
            .card-stat {
                background-color: #fff;
                border: none;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                text-align: center;
                padding: 20px;
                margin-bottom: 20px;
                transition: transform 0.2s;
            }
            .card-stat:hover {
                transform: translateY(-5px);
            }
            .stat-value {
                font-size: 1.5rem;
                font-weight: bold;
                color: #dc3545;
            }
            .stat-label {
                font-size: 0.9rem;
                color: #666;
            }
            .chart-container {
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                padding: 20px;
                margin-bottom: 20px;
            }
            .table-container {
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                padding: 20px;
            }
            .table th {
                background-color: #f8f9fa;
                border-bottom: 2px solid #dee2e6;
            }
            .table td {
                vertical-align: middle;
            }
        </style>
    </head>
    <body>
        <%
            int totalLaptop = (int) request.getAttribute("totalLaptop");
            int totalCustomer = (int) request.getAttribute("totalCustomer");
            int totalOrder = (int) request.getAttribute("totalOrder");
            double totalAmount = request.getAttribute("totalAmount") != null ? (double) request.getAttribute("totalAmount") : 0;
            String formattedAmount = "";
            if(totalAmount != 0) {
                formattedAmount = String.format("%,.0f VNĐ", totalAmount);
            }
            int totalCancelOrder = (int) request.getAttribute("totalCancelOrder");
            int totalRefundOrder = (int) request.getAttribute("totalRefundOrder");
        %>
        <div class="d-flex">
            <jsp:include page="/components/AdminSidebar.jsp"></jsp:include>
                <div style="width: 100%; height: 100dvh; overflow-y: auto" class="container">
                    <div class="dashboard-header">
                        <h2 class="dashboard-title">Dashboard</h2>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="card-stat">
                                <i class="bi bi-cart" style="font-size: 2rem; color: #28a745;"></i>
                                <div class="stat-value"><%=totalOrder%></div>
                            <div class="stat-label">Đơn hàng</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card-stat">
                            <i class="bi bi-cart" style="font-size: 2rem; color: #28a745;"></i>
                            <div class="stat-value"><%=totalCancelOrder%></div>
                            <div class="stat-label">Đơn hàng đã huỷ</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card-stat">
                            <i class="bi bi-cart" style="font-size: 2rem; color: #28a745;"></i>
                            <div class="stat-value"><%=totalRefundOrder%></div>
                            <div class="stat-label">Đơn hàng đã hoàn</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card-stat">
                            <i class="bi bi-currency-dollar" style="font-size: 2rem; color: #dc3545;"></i>
                            <div class="stat-value"><%=formattedAmount%></div>
                            <div class="stat-label">Doanh thu</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card-stat">
                            <i class="bi bi-box" style="font-size: 2rem; color: #007bff;"></i>
                            <div class="stat-value"><%=totalLaptop%></div>
                            <div class="stat-label">Sản phẩm</div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card-stat">
                            <i class="bi bi-people" style="font-size: 2rem; color: #17a2b8;"></i>
                            <div class="stat-value"><%=totalCustomer%></div>
                            <div class="stat-label">Khách hàng</div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div>
                        <select id="yearFilter" onchange="loadRevenueChart()">
                            <%
                                int currentYear = Year.now().getValue(); 
                                for (int year = 2010; year <= currentYear; year++) {
                                    String selected = (year == currentYear) ? "selected" : "";
                            %>
                            <option value="<%= year %>" <%= selected %>><%= year %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="col-12">
                        <div class="chart-container">
                            <h4>Biểu đồ doanh thu</h4>
                            <canvas id="revenueChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
                            let revenueChart;
                            function loadRevenueChart() {
                                const year = document.getElementById('yearFilter').value;
                                fetch(`/swp391/getRevenueByMonth?year=` + year)
                                        .then(response => response.json())
                                        .then(data => {
                                            if (revenueChart) {
                                                revenueChart.destroy();
                                            }
                                            const ctx = document.getElementById('revenueChart').getContext('2d');
                                            revenueChart = new Chart(ctx, {
                                                type: 'line',
                                                data: {
                                                    labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6',
                                                        'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'],
                                                    datasets: [{
                                                            label: 'Doanh thu (VNĐ)',
                                                            data: data.list,
                                                            borderColor: '#dc3545',
                                                            backgroundColor: 'rgba(220, 53, 69, 0.2)',
                                                            tension: 0.4
                                                        }]
                                                },
                                                options: {
                                                    responsive: true,
                                                    scales: {
                                                        y: {
                                                            beginAtZero: true,
                                                            ticks: {
                                                                callback: function (value) {
                                                                    return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".") + " VNĐ";
                                                                }
                                                            }
                                                        }
                                                    },
                                                    plugins: {
                                                        tooltip: {
                                                            callbacks: {
                                                                label: function (context) {
                                                                    let value = context.raw;
                                                                    return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".") + " VNĐ";
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            });
                                        })
                                        .catch(error => console.error('Error fetching revenue data:', error));
                            }

                            // Tải biểu đồ khi trang load với năm mặc định
                            document.addEventListener('DOMContentLoaded', () => {
                                loadRevenueChart();
                            });
        </script>
    </body>
</html>