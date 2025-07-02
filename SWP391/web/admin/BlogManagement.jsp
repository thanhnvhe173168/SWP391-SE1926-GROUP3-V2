<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý blog</title>
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

        .btn-update {
            color: #ffc107;
            border: 1px solid #ffc107;
            border-radius: 6px;
            padding: 4px 8px;
        }

        .btn-update:hover {
            background-color: #ffc107;
            color: white;
        }

        .btn-delete {
            color: #dc3545;
            border: 1px solid #dc3545;
            border-radius: 6px;
            padding: 4px 8px;
        }

        .btn-delete:hover {
            background-color: #dc3545;
            color: white;
        }

        img.avatar {
            width: 50px;
            height: 50px;
            border-radius: 10px;
            object-fit: cover;
        }
    </style>
</head>
<body>
<%
    ResultSet rsBlog = (ResultSet) request.getAttribute("rsBlog");
%>
<div class="d-flex">
    <jsp:include page="/components/AdminSidebar.jsp"></jsp:include>
    <div style="width: 100%; height: calc(100vh - 100px); overflow-y: auto" class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <p style="color: #dd3726; font-size: 40px; font-weight: 700;">Quản lý blog</p>
            <button type="button" class="btn btn-outline-primary" onclick="handleRedirect()">
                <i class="fa-solid fa-plus"></i> Thêm blog
            </button>
        </div>
        <div class="row">
            <div class="col-12 table-responsive">
                <table class="table table-bordered text-center">
                    <thead>
                        <tr>
                            <th style="width: 8%">STT</th>
                            <th style="width: 15%">Ảnh</th>
                            <th>Tiêu đề</th>
                            <th style="width: 20%">Chức năng</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (rsBlog != null) {
                            int index = 0;
                            while (rsBlog.next()) {
                                index++;
                        %>
                        <tr>
                            <td><%= index %></td>
                            <td>
<img src="<%= rsBlog.getString("Avatar") %>" class="avatar" alt="Ảnh blog">
                            </td>
                            <td><%= rsBlog.getString("Title") %></td>
                            <td>
                                <a href="updateBlog?blogId=<%= rsBlog.getInt("BlogID") %>" class="btn btn-update me-2">
                                    <i class="fa-solid fa-pen-to-square"></i> Sửa
                                </a>
                                <a href="deleteBlog?blogId=<%= rsBlog.getInt("BlogID") %>" class="btn btn-delete"
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa blog này không?');">
                                    <i class="fa-solid fa-trash"></i> Xóa
                                </a>
                            </td>
                        </tr>
                        <%  } 
                           } else { %>
                        <tr>
                            <td colspan="4">
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
        window.location.href = "createBlog";
    }
</script>
</body>
</html>
