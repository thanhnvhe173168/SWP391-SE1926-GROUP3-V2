<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Voucher</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" />
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .container {
            padding: 30px 20px;
        }

        .form-card {
            max-width: 700px;
            margin: 0 auto;
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
        }

        .form-label {
            font-weight: 600;
            color: #34495e;
        }

        .form-control:focus {
            border-color: #dd3726;
            box-shadow: 0 0 6px rgba(221, 55, 38, 0.3);
        }

        .submit-btn {
            background-color: #dd3726;
            color: white;
            padding: 10px 24px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            transition: background 0.3s ease;
            width: 100%;
        }

        .submit-btn:hover {
            background-color: #bb2d20;
        }

        .back-link {
            text-decoration: none;
            color: #dd3726;
            font-weight: 600;
            display: inline-block;
            margin-bottom: 20px;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
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
            alertButton.addEventListener('click', () => alert.remove());
            if (timeout !== null) {
                setTimeout(() => alert.remove(), Number(timeout));
            }
            document.body.appendChild(alert);
        };
    </script>
</head>
<body>
<%
    String mess = (String) request.getAttribute("mess");
%>
<% if (mess != null) { %>
<script>
    window.alert("<%= mess %>", 3000);
</script>
<% } %>

<div class="d-flex">
    <jsp:include page="/components/AdminSidebar.jsp"></jsp:include>

    <div style="width: 100%; height: calc(100vh - 118px); overflow-y: auto" class="container">

        <div class="form-card">
            <h3 class="text-center mb-4" style="color: #dd3726; font-weight: 700;">Thêm Voucher</h3>
            <form action="${pageContext.request.contextPath}/AddVoucher" method="post">
                <div class="mb-3">
                    <label class="form-label">Mã Voucher</label>
                    <input type="text" name="vouchercode" class="form-control" placeholder="Nhập mã voucher" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Loại Voucher</label>
                    <input type="text" name="vouchertype" class="form-control" placeholder="Ví dụ: Miễn phí ship % / Giảm tiền cố định / Giảm %" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Giảm giá</label>
                    <input type="number" name="discount" class="form-control" placeholder="Nhập % hoặc số tiền giảm" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Số lượng</label>
                    <input type="number" name="quantity" class="form-control" placeholder="Nhập số lượng voucher" required>
                </div>
                <button type="submit" class="submit-btn">Thêm Voucher</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
