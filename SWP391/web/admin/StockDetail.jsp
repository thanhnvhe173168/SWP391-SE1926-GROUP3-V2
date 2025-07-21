<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết tồn kho</title>
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
            ResultSet rsStock = (ResultSet) request.getAttribute("rsStock");
            ResultSet rsLaptop = (ResultSet) request.getAttribute("rsLaptop");
        %>
        <div class="d-flex">
            <jsp:include page="/components/AdminSidebar.jsp"></jsp:include>
                <div style="width: 100%; height: calc(100dvh - 100px); overflow-y: auto" class="container">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <p style="color: #dd3726; font-size: 40px; font-weight: 700;">Quản lý tồn kho</p>
                    </div>
                <%if(rsLaptop != null && rsLaptop.next()) {%>
                <div class="row">
                    <div class="col-12">
                        <div class="d-flex align-items-center">
                            <p style="margin-right: 4px">Tên sản phẩm: </p>
                            <p><%=rsLaptop.getString("LaptopName")%></p>
                        </div>
                        <div class="d-flex align-items-center">
                            <p style="margin-right: 4px">Loại sản phẩm: </p>
                            <p><%=rsLaptop.getString("CategoryName")%></p>
                        </div>
                        <div class="d-flex align-items-center">
                            <p style="margin-right: 4px">Nhãn hiệu: </p>
                            <p><%=rsLaptop.getString("BrandName")%></p>
                        </div>
                        <div class="d-flex align-items-center">
                            <p style="margin-right: 4px">Số lượng tồn kho: </p>
                            <p><%=rsLaptop.getInt("Stock")%></p>
                        </div>
                        <div class="d-flex align-items-center">
                            <p style="margin-right: 4px">Trạng thái: </p>
                            <p><%=rsLaptop.getString("StatusName")%></p>
                        </div>
                    </div>
                    <%}%>
                    <div class="col-12 table-responsive">
                        <table class="table table-bordered text-center">
                            <thead>
                                <tr>
                                    <th style="width: 10%">STT</th>
                                    <th>Người thực hiện</th>
                                    <th>Sản phẩm</th>
                                    <th>Ngày</th>
                                    <th>Hành động</th>
                                    <th>Số lượng</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (rsStock != null) {
                                        int index = 0;
                                        while (rsStock.next()) {
                                            index++;
                                %>
                                <tr>
                                    <th><%= index %></th>
                                    <td><%= rsStock.getString("FullName") %></td>
                                    <td><%= rsStock.getString("LaptopName") %></td>
                                    <td><%= rsStock.getString("Date") %></td>
                                    <td><%= rsStock.getString("Action") %></td>
                                    <td><%= rsStock.getInt("Quantity") %></td>
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
                <div class="d-flex justify-content-end" style="margin-bottom: 30px">
                    <button 
                        type="button"
                        class="btn btn-outline-primary" 
                        style="margin-right: 12px"
                        onclick="handleRedirect()"
                        >
                        Trở lại
                    </button>
                </div>
            </div>
        </div>
        <script>
            function handleRedirect() {
                window.location.href = "getListLaptop";
            }
        </script>
    </body>
</html>
