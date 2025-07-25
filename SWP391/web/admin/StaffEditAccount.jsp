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

            input[readonly] {
                background-color: #f0f0f0;
                color: #777;
            }

            input[type="text"]:focus, select:focus {
                border-color: #D70018;
                outline: none;
                box-shadow: 0 0 0 2px rgba(215, 0, 24, 0.2);
            }

            .form-actions {
                display: flex;
                justify-content: space-between;
                gap: 16px;
                margin-top: 28px;
            }

            .btn-submit,
            .btn-cancel {
                flex: 1;
                padding: 12px;
                font-size: 16px;
                font-weight: 500;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                transition: background-color 0.2s ease;
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
            .password-row {
                display: flex;
                gap: 8px;
                align-items: center;
                margin-top: 6px;
            }

            .password-row input {
                flex: 1;
            }

            .btn-reset {
                padding: 10px 14px;
                background-color: #fff;
                color: #d70018;
                border: 1px solid #d70018;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.2s ease;
            }

            .btn-reset:hover {
                background-color: #d70018;
                color: white;
            }

        </style>
    </head>
    <body>
        <div class="form-container">
            <h2>Chỉnh sửa thông tin nhân viên</h2>
            <form method="post" action="staffEditAccount">
                <input type="hidden" name="userId" value="${user.userID}" />

                <label>Họ và tên:</label>
                <input type="text" name="fullName" value="${user.fullName}" required />

                <label>Số điện thoại:</label>
                <input type="text" name="phoneNumber" value="${user.phoneNumber}" required />

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

                <div class="form-actions">
                    <button type="submit" class="btn-submit">Lưu thay đổi</button>
                    <button type="button" class="btn-cancel" onclick="window.history.back();">Hủy</button>
                </div>
            </form>
        </div>
    </body>
</html>