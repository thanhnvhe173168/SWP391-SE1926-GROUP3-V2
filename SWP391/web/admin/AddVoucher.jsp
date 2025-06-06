<%-- 
    Document   : AddVoucher
    Created on : Jun 6, 2025, 12:58:44 AM
    Author     : Window 11
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm Voucher</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="card shadow rounded-4">
            <div class="card-body p-4">
                <h2 class="mb-4 text-primary">Thêm Voucher</h2>
                <form action="AddVoucher" method="post">
                    <div class="mb-3">
                        <label class="form-label">Mã Voucher</label>
                        <input type="text" name="vouchercode" class="form-control" placeholder="Nhập mã voucher" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Loại Voucher</label>
                        <input type="text" name="vouchertype" class="form-control" placeholder="Ví dụ: Giảm giá % hoặc Giảm số tiền" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Giảm giá</label>
                        <input type="number" name="discount" class="form-control" placeholder="Nhập % giảm giá hoặc Số tiền giảm" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Số lượng</label>
                        <input type="number" name="quantity" class="form-control" placeholder="Nhập số lượng" required>
                    </div>
                    <button type="submit" class="btn btn-success w-100">Thêm Voucher</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
