<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.User" %> <%-- Đúng tên package chứa class User --%>
<html>
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
