<%-- 
    Document   : CreateAccountStaff
    Created on : Jun 17, 2025, 5:40:38 PM
    Author     : linhd
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Tạo tài khoản nhân viên</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 0;
            }

            .form-wrapper {
                max-width: 500px;
                margin: 60px auto;
                background-color: #ffffff;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                padding: 30px;
            }

            h2 {
                text-align: center;
                color: #d70018;
                margin-bottom: 25px;
            }

            label {
                font-weight: 500;
                margin-top: 15px;
                display: block;
                color: #333;
            }

            input[type="text"],
            input[type="password"],
            select {
                width: 100%;
                padding: 10px 12px;
                margin-top: 6px;
                border: 1px solid #ccc;
                border-radius: 8px;
                transition: border-color 0.2s;
            }

            input:focus,
            select:focus {
                outline: none;
                border-color: #d70018;
            }

            .btn-submit {
                background-color: #D70018;
                color: #fff;
            }

            .btn-submit:hover {
                background-color: #b80014;
            }

            .btn-cancel {
                background-color: #ccc;
                color: #333;
            }

            .btn-cancel:hover {
                background-color: #b3b3b3;
            }
            .form-actions {
                display: flex;
                justify-content: space-between;
                gap: 16px;
                margin-top: 24px;
            }

            .btn-submit, .btn-cancel {
                flex: 1;
                padding: 12px;
                font-size: 16px;
                font-weight: 500;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                transition: background-color 0.2s ease;
            }

        </style>

    </head>
    <body>
        <div class="form-wrapper">
            <h2>Tạo tài khoản nhân viên</h2>

            <form action="/swp391/createAccountStaff" method="post">
                <label>Họ và tên:</label>
                <input type="text" name="fullName" required />

                <label>Email:</label>
                <input type="text" name="email" required />

                <c:if test="${not empty error}">
                    <div id="email-error" class="error" style="color:red; font-size:13px;">${emailError}</div>
                </c:if>

                <label>Số điện thoại:</label>
                <input type="text" name="phoneNumber" required />
                <c:if test="${not empty phoneError}">
                    <div id="phone-error" class="error" style="color:red; font-size:13px;">${phoneError}</div>
                </c:if>


                <label>Mật khẩu:</label>
                <input type="password" name="password" required />

                <input type="hidden" name="roleId" value="2" />


                <label>Trạng thái:</label>
                <select name="statusId">
                    <option value="1">Đang hoạt động</option>
                    <option value="2">Đã khóa</option>
                </select>

                <div class="form-actions">
                    <button type="submit" class="btn-submit">Tạo tài khoản</button>
                    <button type="button" class="btn-cancel" onclick="window.history.back();">Hủy</button>
                </div>

            </form>
        </div>
    </body>
</html>

