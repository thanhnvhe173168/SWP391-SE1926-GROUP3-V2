<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết người dùng</title>
        <style>
            body {
                font-family: Arial;
                padding: 20px;
                background-color: #f2f2f2;
            }
            .detail-box {
                background: #fff;
                padding: 20px;
                border-radius: 10px;
                width: 500px;
                margin: auto;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            h2 {
                text-align: center;
            }
            p {
                margin: 10px 0;
            }
            .back {
                margin-top: 20px;
                text-align: center;
            }
            .back button {
                padding: 8px 16px;
                background: #6c757d;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .back button:hover {
                background-color: #5a6268;
            }
        </style>
    </head>
    <body>

        <div class="detail-box">
            <h2>Chi tiết người dùng</h2>

            <c:if test="${not empty error}">
                <p style="color: red;">${error}</p>
            </c:if>

            <c:if test="${not empty user}">
                <p><strong>User ID:</strong> ${user.userID}</p>
                <p><strong>Full Name:</strong> ${user.fullName}</p>
                <p><strong>Email:</strong> ${user.email}</p>
                <p><strong>Phone Number:</strong> ${user.phoneNumber}</p>
                <p><strong>Password:</strong> ${user.password}</p>
                <p><strong>Registration Date:</strong> ${user.registrationDate}</p>
                <p><strong>Role:</strong>
                <c:choose>
                    <c:when test="${user.roleID == 1}">Admin</c:when>
                    <c:when test="${user.roleID == 2}">Staff</c:when>
                    <c:when test="${user.roleID == 3}">Customer</c:when>
                    <c:otherwise>Unknown</c:otherwise>
                </c:choose>
                </p>
                <p><strong>Status:</strong>
                <c:choose>
                    <c:when test="${user.statusID == 1}">Đang hoạt động</c:when>
                    <c:otherwise>Đã khóa</c:otherwise>
                </c:choose>
                </p>
            </c:if>

            <div class="back">
                <button onclick="location.href = 'getListUser'">Quay lại danh sách</button>
            </div>
        </div>

    </body>
</html>
