<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Người Dùng Mới</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h2 {
            color: #333;
        }
        .form-container {
            max-width: 500px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .form-group input[type="submit"] {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 14px;
        }
        .form-group input[type="submit"]:hover {
            background-color: #218838;
        }
        .error {
            color: #dc3545;
            font-size: 12px;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <h2>Thêm Người Dùng Mới</h2>
    
        <div class="form-container">
        <form action="createUser" method="post">
            <div class="form-group">
                <label for="fullName">Họ tên:</label>
                <input type="text" id="fullName" name="fullName" value="${addU.fullName}" required>
                <c:if test="${not empty errors.fullName}">
                    <div class="error">${errors.fullName}</div>
                </c:if>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="${addU.email}" required>
                <c:if test="${not empty errors.email}">
                    <div class="error">${errors.email}</div>
                </c:if>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
                <c:if test="${not empty errors.password}">
                    <div class="error">${errors.password}</div>
                </c:if>
            </div>
            <div class="form-group">
                <label for="phoneNumber">Số điện thoại:</label>
                <input type="text" id="phoneNumber" name="phoneNumber" value="${addU.phoneNumber}">
                <c:if test="${not empty errors.phoneNumber}">
                    <div class="error">${errors.phoneNumber}</div>
                </c:if>
            </div>
            <div class="form-group">
                <label for="roleID">Vai trò:</label>
                <select id="roleID" name="roleID" required>
                    <option value="">-- Chọn vai trò --</option>
                    <option value="1" <c:if test="${addU.roleID == '1'}">selected</c:if>>Admin</option>
                    <option value="2" <c:if test="${addU.roleID == '2'}">selected</c:if>>Staff</option>
                    <option value="3" <c:if test="${addU.roleID == '3'}">selected</c:if>>Customer</option>
                </select>
                <c:if test="${not empty errors.roleID}">
                    <div class="error">${errors.roleID}</div>
                </c:if>
            </div>
            <div class="form-group">
                <label for="statusID">Trạng thái:</label>
                <select id="statusID" name="statusID" required>
                    <option value="">-- Chọn trạng thái --</option>
                    <option value="1" <c:if test="${addU.statusID == '1'}">selected</c:if>>Đang hoạt động</option>
                    <option value="2" <c:if test="${addU.statusID == '2'}">selected</c:if>>Đã khóa</option>
                </select>
                <c:if test="${not empty errors.statusID}">
                    <div class="error">${errors.statusID}</div>
                </c:if>
            </div>
            <div class="form-group">
                <input type="submit" value="Thêm Người Dùng">
            </div>
        </form>
    </div>
    
</body>
</html>