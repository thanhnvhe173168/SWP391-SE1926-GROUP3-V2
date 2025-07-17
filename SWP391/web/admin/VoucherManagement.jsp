<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*" %>
<%@page import="dao.*" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Voucher</title>
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
    String mess = (String) request.getAttribute("mess");
%>
<% if (mess != null) { %>
<script>
    alert("<%= mess %>");
</script>
<% } %>

<div class="d-flex">
    <jsp:include page="/components/AdminSidebar.jsp"></jsp:include>

    <div style="width: 100%; height: calc(100vh - 118px); overflow-y: auto" class="container">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 style="color: #dd3726; font-weight: 700;">Quản lý Voucher</h2>
            <button class="btn btn-outline-primary" onclick="window.location.href = 'admin/AddVoucher.jsp'">
                <i class="fa-solid fa-plus"></i> Thêm Voucher
            </button>
        </div>

        <c:set var="voulist" value="${voucherlist}" />
        <c:choose>
            <c:when test="${empty voulist}">
                <div class="alert alert-warning">Danh sách voucher trống.</div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-bordered text-center">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Mã Voucher</th>
                                <th>Loại</th>
                                <th>Giảm giá</th>
                                <th>Số lượng</th>
                                <th colspan="2">Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${voulist}" var="voucher">
                                <tr>
                                    <td>${voucher.voucherID}</td>
                                    <td>${voucher.vouchercode}</td>
                                    <td>${voucher.vouchertype}</td>
                                    <td>${voucher.discount}</td>
                                    <td>${voucher.quantity}</td>
                                    <td>
                                        <a href="EditVoucher?id=${voucher.voucherID}" class="btn btn-update btn-icon">
                                            <i class="fa-solid fa-pen-to-square"></i>
                                        </a>
                                    </td>
                                    <td>
                                        <a href="DeleteVoucher?id=${voucher.voucherID}" class="btn btn-delete btn-icon"
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa voucher này?');">
                                            <i class="fa-solid fa-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

</body>
</html>
