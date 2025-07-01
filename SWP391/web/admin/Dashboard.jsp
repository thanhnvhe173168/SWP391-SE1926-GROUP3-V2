<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        %>
        <div class="d-flex">
            <jsp:include page="/components/AdminSidebar.jsp"></jsp:include>
            <div style="width: 100%; height: calc(100dvh - 100px); overflow-y: auto" class="container">
                <div class="dashboard-header">
                    <h2 class="dashboard-title">Dashboard</h2>
                </div>
                <div class="row">
                    <div class="col-md-3">
                        <div class="card-stat">
                            <i class="bi bi-currency-dollar" style="font-size: 2rem; color: #dc3545;"></i>
                            <div class="stat-value">0</div>
                            <div class="stat-label">Doanh thu</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card-stat">
                            <i class="bi bi-cart" style="font-size: 2rem; color: #28a745;"></i>
                            <div class="stat-value">0</div>
                            <div class="stat-label">Đơn hàng</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card-stat">
                            <i class="bi bi-box" style="font-size: 2rem; color: #007bff;"></i>
                            <div class="stat-value"><%=totalLaptop%></div>
                            <div class="stat-label">Sản phẩm</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card-stat">
                            <i class="bi bi-people" style="font-size: 2rem; color: #17a2b8;"></i>
                            <div class="stat-value"><%=totalCustomer%></div>
                            <div class="stat-label">Khách hàng</div>
                        </div>
                    </div>
                </div>

                <div class="row">
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
            // Biểu đồ doanh thu (dữ liệu mẫu)
            const ctx = document.getElementById('revenueChart').getContext('2d');
            new Chart(ctx, {
                type: 'line',
                data: {
                    labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6'],
                    datasets: [{
                            label: 'Doanh thu (VNĐ)',
                            data: [10000000, 15000000, 12000000, 18000000, 20000000, 25000000],
                            borderColor: '#dc3545',
                            backgroundColor: 'rgba(220, 53, 69, 0.2)',
                            tension: 0.4
                        }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        </script>
    </body>
</html>F