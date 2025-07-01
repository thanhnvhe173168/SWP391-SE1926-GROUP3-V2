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
                font-family: Arial;
                padding: 20px;
                background-color: #f8f9fa;
            }
            .form-container {
                max-width: 500px;
                background-color: #fff;
                padding: 25px;
                margin: auto;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                border-radius: 8px;
            }
            h2 {
                text-align: center;
            }
            label {
                display: block;
                margin-top: 15px;
            }
            input, select {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
            }
            .btn-submit {
                margin-top: 20px;
                background-color: #28a745;
                color: white;
                border: none;
                padding: 10px;
                width: 100%;
                cursor: pointer;
                border-radius: 5px;
            }
            .btn-submit:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h2>Tạo tài khoản nhân viên</h2>
            <form action="/swp391/createAccountStaff" method="get">

                <label>Họ và tên:</label>
                <input type="text" name="fullName" required />
                
                <label>Email:</label>
                <input type="text" name="email" required />

                <label>Số điện thoại:</label>
                <input type="text" name="phoneNumber" required />

                <label>Mật khẩu:</label>
                <input type="password" name="password" required />
                
                <label>Vai trò:</label>
                <select name="roleId">
                    <option value="2">Staff</option> 
                </select>
                
                <label>Trạng thái:</label>
                <select name="statusId">
                    <option value="1">Đang hoạt động</option>
                    <option value="2">Đã khóa</option>
                </select>


                <button type="submit" class="btn-submit">Tạo tài khoản</button>
            </form>
        </div>
    </body>
</html>
