<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết Khách hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f3f4f6;
            margin: 0;
            padding: 40px;
        }

        .detail-container {
            max-width: 600px;
            background-color: #ffffff;
            padding: 30px 40px;
            border-radius: 16px;
            margin: auto;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #111827;
            font-weight: 600;
        }

        .detail-item {
            margin-bottom: 16px;
            font-size: 16px;
            color: #374151;
        }

        .detail-item strong {
            color: #111827;
            display: inline-block;
            width: 160px;
        }

        .status-active {
            color: #065f46;
            font-weight: 600;
        }

        .status-locked {
            color: #991b1b;
            font-weight: 600;
        }

        .btn-group {
            text-align: center;
            margin-top: 30px;
        }

        .btn-back {
            background-color: #6b7280;
            color: white;
            border: none;
            padding: 10px 18px;
            font-weight: 600;
            border-radius: 8px;
            transition: background-color 0.3s;
        }

        .btn-back:hover {
            background-color: #4b5563;
        }

        .error-message {
            color: red;
            text-align: center;
            font-weight: 500;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="detail-container">
        <h2>Chi tiết Khách hàng</h2>

        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <c:if test="${not empty user}">
            <div class="detail-item"><strong>User ID:</strong> ${user.userID}</div>
            <div class="detail-item"><strong>Full Name:</strong> ${user.fullName}</div>
            <div class="detail-item"><strong>Email:</strong> ${user.email}</div>
            <div class="detail-item"><strong>Phone Number:</strong> ${user.phoneNumber}</div>
            <div class="detail-item"><strong>Password:</strong> ${user.password}</div>
            <div class="detail-item"><strong>Registration Date:</strong> ${user.registrationDate}</div>
            <div class="detail-item">
                <strong>Status:</strong>
                <span class="${user.statusID == 1 ? 'status-active' : 'status-locked'}">
                    <c:choose>
                        <c:when test="${user.statusID == 1}">Đang hoạt động</c:when>
                        <c:otherwise>Đã khóa</c:otherwise>
                    </c:choose>
                </span>
            </div>

            <div class="btn-group">
                <button class="btn-back" onclick="location.href='${pageContext.request.contextPath}/userList'">
                    <i class="fas fa-arrow-left me-1"></i> Quay lại danh sách
                </button>
            </div>
        </c:if>
    </div>
</body>
</html>