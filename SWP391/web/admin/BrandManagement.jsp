<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quản lý thương hiệu</title>
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
    ResultSet rsBrand = (ResultSet) request.getAttribute("rsBrand");
%>
<div class="d-flex">
    <jsp:include page="/components/AdminSidebar.jsp"></jsp:include>
    <div style="width: 100%; height: calc(100dvh - 100px); overflow-y: auto" class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <p style="color: #dd3726; font-size: 40px; font-weight: 700;">Quản lý thương hiệu</p>
            <button type="button" class="btn btn-outline-primary" onclick="handleRedirect()">
                <i class="fa-solid fa-plus"></i> Thêm thương hiệu
            </button>
        </div>
        <div class="row">
            <div class="col-12 table-responsive">
                <table class="table table-bordered text-center">
                    <thead>
                        <tr>
                            <th style="width: 10%">STT</th>
                            <th>Tên nhãn hiệu</th>
                            <th style="width: 20%">Chức năng</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (rsBrand != null) {
                                int index = 0;
                                while (rsBrand.next()) {
                                    index++;
                        %>
                        <tr>
                            <th><%= index %></th>
                            <td><%= rsBrand.getString("BrandName") %></td>
                            <td>
                                <a href="updateBrand?brandId=<%= rsBrand.getInt("BrandID") %>" 
                                   class="btn btn-update btn-icon me-2">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                </a>
                                <a href="deleteBrand?brandId=<%= rsBrand.getInt("BrandID") %>" 
                                   class="btn btn-delete btn-icon" 
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa thương hiệu này?');">
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
        window.location.href = "createBrand";
    }
</script>
</body>
</html>
