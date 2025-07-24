<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Chỉnh sửa nhân viên</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f5f5f5;
                padding: 40px 0;
            }

            .form-container {
                max-width: 550px;
                background-color: #ffffff;
                margin: auto;
                padding: 30px 40px;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            }

            .form-container h2 {
                text-align: center;
                color: #D70018;
                margin-bottom: 25px;
                font-weight: 600;
            }

            label {
                display: block;
                margin-top: 18px;
                font-weight: 500;
                color: #333;
            }

            input[type="text"], select {
                width: 100%;
                padding: 10px 12px;
                margin-top: 6px;
                border: 1px solid #ccc;
                border-radius: 8px;
                font-size: 15px;
            }

            input[type="text"]:focus, select:focus {
                border-color: #D70018;
                outline: none;
                box-shadow: 0 0 0 2px rgba(215, 0, 24, 0.2);
            }

            .btn-submit {
                margin-top: 28px;
                width: 100%;
                padding: 12px;
                background-color: #D70018;
                color: #fff;
                border: none;
                border-radius: 8px;
                font-size: 16px;
                font-weight: 500;
                cursor: pointer;
                transition: background-color 0.2s ease;
            }

            .btn-submit:hover {
                background-color: #b80014;
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h2>Chỉnh sửa nhân viên</h2>
            <form method="post" action="staffEditAccount">
                <input type="hidden" name="action" value="save"/>
                <input type="hidden" name="userId" value="${user.userID}"/>

                <label>Họ và tên:</label>
                <input type="text" name="fullName" value="${user.fullName}" required/>

                <label>Số điện thoại:</label>
                <input type="text" name="phoneNumber" value="${user.phoneNumber}" required/>

                <label>Mật khẩu:</label>
                <input type="text" name="password" value="${user.password}" required/>

                <label>Trạng thái:</label>
                <select name="statusId">
                    <option value="1" ${user.statusID == 1 ? 'selected' : ''}>Đang hoạt động</option>
                    <option value="2" ${user.statusID == 2 ? 'selected' : ''}>Đã khóa</option>
                </select>

                <label>Vai trò:</label>
                <select name="roleId">
                    <option value="1" ${user.roleID == 1 ? 'selected' : ''}>Admin</option>
                    <option value="2" ${user.roleID == 2 ? 'selected' : ''}>Staff</option>
                </select>

                <button type="submit" class="btn-submit">Lưu thay đổi</button>
            </form>
        </div>
    </body>
</html>
