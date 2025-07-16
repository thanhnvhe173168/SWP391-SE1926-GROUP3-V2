<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý khuyến mãi</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .container {
                padding: 30px 20px;
            }

            .table {
                background-color: #ffffff;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 4px 12px rgba(0,0,0,0.06);
            }

            thead th {
                background-color: #dd3726;
                color: white;
                font-weight: bold;
            }

            tbody tr:hover {
                background-color: #ffeae8;
            }

            .btn-outline-primary {
                font-weight: 600;
                border-radius: 8px;
                border-color: #dd3726;
                color: #dd3726;
                transition: all 0.3s ease;
            }

            .btn-outline-primary:hover {
                background-color: #dd3726;
                color: white;
            }

            .btn-icon {
                border-radius: 50px;
                padding: 6px 12px;
                font-size: 14px;
            }

            .btn-update {
                color: #ffc107;
                border: 1px solid #ffc107;
            }

            .btn-update:hover {
                background-color: #ffc107;
                color: white;
            }

            .btn-delete {
                color: #dc3545;
                border: 1px solid #dc3545;
            }

            .btn-delete:hover {
                background-color: #dc3545;
                color: white;
            }
        </style>
    </head>
    <body>
        <%
            ResultSet rsPromotion = (ResultSet) request.getAttribute("rsPromotion");
        %>
        <div class="d-flex">
            <jsp:include page="/components/AdminSidebar.jsp"></jsp:include>
                <div style="width: 100%; height: calc(100vh - 118px); overflow-y: auto" class="container">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <p style="color: #dd3726; font-size: 40px; font-weight: 700;">Quản lý khuyến mãi</p>
                        <button type="button" class="btn btn-outline-primary" onclick="handleRedirect()">
                            <i class="fa-solid fa-plus"></i> Thêm chương trình khuyến mãi
                        </button>
                    </div>
                    <div class="row">
                        <div class="col-12 table-responsive">
                            <table class="table table-bordered text-center">
                                <thead>
                                    <tr>
                                        <th>STT</th>
                                        <th>Ảnh</th>
                                        <th>Tiêu đề chương trình khuyến mãi</th>
                                        <th>Thời gian băt đầu</th>
                                        <th>Thời gian kết thúc</th>
                                        <th>Số lượng sản phẩm</th>
                                        <th>Trạng thái</th>
                                        <th>Chức năng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
                            if (rsPromotion != null) {
                                int index = 0;
                                while (rsPromotion.next()) {
                                    index++;
                                %>
                                <tr>
                                    <th><%= index %></th>
                                    <td>
                                        <img src="<%=rsPromotion.getString("Image")%>" alt="<%=rsPromotion.getString("Title")%>" style="width: 40px; height: 40px"/>
                                    </td>
                                    <td><%= rsPromotion.getString("Title") %></td>
                                    <td><%= rsPromotion.getString("StartDate") %></td>
                                    <td><%= rsPromotion.getString("EndDate") %></td>
                                    <td><%= rsPromotion.getInt("NumberProduct") %></td>
                                    <td><%= rsPromotion.getString("Status") %></td>
                                    <td>
                                        <a href="updatePromotion?promotionId=<%= rsPromotion.getInt("ID") %>" 
                                           class="btn btn-update btn-icon me-2">
                                            <i class="fa-solid fa-pen-to-square"></i>
                                        </a>
                                        <a href="deletePromotion?promotionId=<%= rsPromotion.getInt("ID") %>" 
                                           class="btn btn-delete btn-icon" 
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa chương trình khuyến mãi này?');">
                                            <i class="fa-solid fa-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="3">
                                        <div class="text-center">Không có dữ liệu</div>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <script>
            function handleRedirect() {
                window.location.href = "createPromotion";
            }
        </script>
    </body>
</html>
