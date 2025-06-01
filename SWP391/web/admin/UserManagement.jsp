<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách người dùng</title>
        <style>
            body {
                font-family: Arial, sans-serif;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            tr {
                border-bottom: 1px solid #ddd;
            }
            th, td {
                padding: 10px;
                text-align: left;
                vertical-align: middle;
            }
            .avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                margin-right: 10px;
                vertical-align: middle;
            }
            .user-info {
                display: inline-block;
                vertical-align: middle;
            }
            .role {
                color: #0066cc;
                font-size: 12px;
            }
            .status {
                padding: 5px 10px;
                border-radius: 5px;
                color: white;
                font-size: 12px;
            }
            .status-active {
                background-color: #28a745;
            }
            .status-inactive {
                background-color: #6c757d;
            }
            .status-banned {
                background-color: #dc3545;
            }
            .status-locked {
                background-color: #dc3545;
            }
            .status-pending {
                background-color: #ffc107;
                color: black;
            }
            .action-buttons img {
                width: 20px;
                height: 20px;
                margin: 0 5px;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <h2>Danh sách người dùng</h2>
        <table>
            <tr>
                <th>User ID</th>
                <th>Username</th>
                <th>Full Name</th>
                <th>Role</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            <c:forEach items="${listU}" var="o">
                <tr>
                    <td>${o.userID}</td>
                    <td>${o.userName}</td>
                    <td>${o.fullName}</td>
                    <td>
                        <span class="role">
                            <c:choose>
                                <c:when test="${o.roleID == 1}">Admin</c:when>
                                <c:when test="${o.roleID == 2}">Staff</c:when>
                                <c:when test="${o.roleID == 3}">Customer</c:when>
                                <c:otherwise>Unknown</c:otherwise>
                            </c:choose>
                        </span>
                    </td>
                    <td>
                        <span class="status
                              <c:choose>
                                  <c:when test="${o.statusID == 1}">status-active</c:when>
                                  <c:when test="${o.statusID == 2}">status-locked</c:when>
                                  <c:otherwise>status-locked</c:otherwise>
                              </c:choose>">
                            <c:choose>
                                <c:when test="${o.statusID == 1}">Đang hoạt động</c:when>
                                <c:when test="${o.statusID == 2}">Đã khóa</c:when>
                                <c:otherwise>Đã khóa (ID: ${o.statusID})</c:otherwise>
                            </c:choose>
                        </span>
                    </td>
                    <td class="action-buttons">
                        <a href="ViewUserServlet?userID=${o.userID}">View</a>
                        <a href="EditUserServlet?userID=${o.userID}">Edit</a>
                        <a href="javascript:void(0);" onclick="confirmDelete(${o.userID})">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </table>

    </body>
</html>