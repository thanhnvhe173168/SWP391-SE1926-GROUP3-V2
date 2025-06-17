<%-- 
    Document   : AddVoucher
    Created on : Jun 6, 2025, 12:58:44 AM
    Author     : Window 11
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Thêm Voucher</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
        <script>
    window.alert = function (message, timeout = null) {
        const alert = document.createElement('div');
        const alertButton = document.createElement('button');
        alertButton.innerHTML = 'OK';
        alert.classList.add('alert');
        alert.setAttribute('style', `
            position: fixed;
            top: 50px;
            left: 50%;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 10px 5px 0 #00000022;
            display: flex;
            flex-direction: column;
            transform: translateX(-50%);
            background-color: #5ced73;
            z-index: 9999;
        `);
                alertButton.setAttribute('style', `
            border: 1px solid #333;
            background: white;
            border-radius: 5px;
            padding: 5px;
            margin-top: 10px;
            cursor: pointer;
        `);
                alert.innerHTML = `<span style="padding: 10px">${mess}</span>`;
                alert.appendChild(alertButton);
                alertButton.addEventListener('click', (e) => {
                    alert.remove();
                });
                if (timeout !== null) {
                    setTimeout(() => {
                        alert.remove();
                    }, Number(timeout));
                }
                document.body.appendChild(alert);
            };
        </script>

    </head>
    <body>
        <% String mess = (String) request.getAttribute("mess"); %>
        <% if (mess != null) { %>
        <script>
        window.alert("<%= mess %>", 3000);
        </script>
        <% } %>
        <div class="container mt-5">
            <a href="${pageContext.request.contextPath}/VoucherList">Trở về</a>
            <div class="card shadow rounded-4">
                <div class="card-body p-4">
                    <h2 class="mb-4 text-primary">Thêm Voucher</h2>
                    <form action="${pageContext.request.contextPath}/AddVoucher" method="post">
                        <div class="mb-3">
                            <label class="form-label">Mã Voucher</label>
                            <input type="text" name="vouchercode" class="form-control" placeholder="Nhập mã voucher" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Loại Voucher</label>
                            <input type="text" name="vouchertype" class="form-control" placeholder="Ví dụ: Miễn phí ship % hoặc Giảm số tiền cố định hoặc Giảm %" required>
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
