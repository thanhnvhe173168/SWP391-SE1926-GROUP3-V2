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
        <p><strong>User ID:</strong> ${list.userID}</p>
        <p><strong>User Name:</strong> ${list.userName}</p>
        <p><strong>Full Name:</strong> ${list.fullName}</p>
        <p><strong>Email:</strong> ${list.email}</p>
        <p><strong>Phone Number:</strong> ${list.phoneNumber}</p>
        <p><strong>Password:</strong> ${list.password}</p>
        <p><strong>Registration Date:</strong> ${list.Date}</p>
        <p><strong>Role ID:</strong> ${list.roleID}</p>
        <p><strong>Status ID:</strong> ${list.statusID}</p>
        <br/>
        <a href="getListUser">Quay lại danh sách</a>
    </body>
</html>

