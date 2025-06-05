<%-- 
    Document   : UpdateUser
    Created on : Jun 3, 2025, 8:34:30 PM
    Author     : linhd
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chỉnh sửa Người dùng</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f2f5;
                padding: 30px;
            }
            .form-container {
                background-color: white;
                padding: 25px;
                border-radius: 10px;
                max-width: 500px;
                margin: 0 auto;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            h2 {
                margin-bottom: 20px;
                text-align: center;
            }
            label {
                display: block;
                margin-top: 10px;
                font-weight: bold;
            }
            input[readonly], select {
                width: 100%;
                padding: 8px;
                margin-top: 5px;
                border-radius: 5px;
                border: 1px solid #ccc;
                background-color: #f9f9f9;
            }
            select {
                background-color: white;
            }
            .btn-group {
                margin-top: 20px;
                text-align: center;
            }
            button {
                padding: 10px 20px;
                margin: 0 10px;
                border: none;
                border-radius: 5px;
                background-color: #007bff;
                color: white;
                cursor: pointer;
            }
            button:hover {
                background-color: #0056b3;
            }
            .cancel-btn {
                background-color: #6c757d;
            }
            .cancel-btn:hover {
                background-color: #5a6268;
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h2>Chỉnh sửa Người dùng</h2>
            <form action="updateUser" method="post">
                <input type="hidden" name="userID" value="${user.userID}" />

                <label>Họ và tên:</label>
                <input type="text" value="${user.fullName}" readonly />

                <label>Email:</label>
                <input type="text" value="${user.email}" readonly />

                <label>Vai trò:</label>
                <select name="roleID">
                    <option value="1" ${user.roleID == 1 ? 'selected' : ''}>Admin</option>
                    <option value="2" ${user.roleID == 2 ? 'selected' : ''}>Staff</option>
                    <option value="3" ${user.roleID == 3 ? 'selected' : ''}>Customer</option>
                </select>

                <label>Trạng thái:</label>
                <select name="statusID">
                    <option value="1" ${user.statusID == 1 ? 'selected' : ''}>Đang hoạt động</option>
                    <option value="2" ${user.statusID == 2 ? 'selected' : ''}>Đã khóa</option>
                </select>

                <div class="btn-group">
                    <button type="submit">Lưu thay đổi</button>
                    <button type="button" class="cancel-btn" onclick="window.history.back()">Hủy</button>
                </div>
            </form>
        </div>
    </body>
</html>
