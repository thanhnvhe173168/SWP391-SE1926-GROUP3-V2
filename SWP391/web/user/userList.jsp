<%-- 
    Document   : userList
    Created on : May 27, 2025, 11:35:34 PM
    Author     : linhd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*" %>
<%@page import="dal.*" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <head>
        <title>Danh sách người dùng</title>
        <style>
            table {
                width: 60%;
                border-collapse: collapse;
                margin: 20px auto;
            }
            th, td {
                padding: 10px;
                border: 1px solid #999;
                text-align: center;
            }
            th {
                background-color: #f0f0f0;
            }
        </style>
    </head>
</head>
<body>
    <h2 style="text-align:center;">Danh sách người dùng</h2>
<table>
    <tr>
        <th>ID</th>
        <th>Tên đăng nhập</th>
        <th>Họ tên</th>
        <th>Mật khẩu</th>
    </tr>
    <%
        List<User> users = (List<User>) request.getAttribute("users");
        if (users != null) {
            for (User user : users) {
    %>
    <tr>
        <td><%= user.getUserID() %></td>
        <td><%= user.getUserName() %></td>
        <td><%= user.getFullName() %></td>
        <td><%= user.getPassword() %></td>
    </tr>
    <%
            }
        }
    %>
</table>

</body>
</html>
