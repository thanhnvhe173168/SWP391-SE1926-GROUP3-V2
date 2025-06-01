<%-- 
    Document   : ViewUserDetail
    Created on : May 31, 2025, 4:24:54 PM
    Author     : linhd
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết người dùng</title>
    </head>
    <body>
        <h2>Chi tiết người dùng</h2>
        <p><strong>User ID:</strong> ${user.userID}</p>
        <p><strong>User Name:</strong> ${user.userName}</p>
        <p><strong>Full Name:</strong> ${user.fullName}</p>
        <p><strong>Email:</strong> ${user.email}</p>
        <p><strong>Phone Number:</strong> ${user.phoneNumber}</p>
        <p><strong>Password:</strong> ${user.password}</p>
        <p><strong>Registration Date:</strong> ${user.Date}</p>
        <p><strong>Role ID:</strong> ${user.roleID}</p>
        <p><strong>Status ID:</strong> ${user.statusID}</p>
        <br/>
        <a href="getListUser">Quay lại danh sách</a>
    </body>
</html>

