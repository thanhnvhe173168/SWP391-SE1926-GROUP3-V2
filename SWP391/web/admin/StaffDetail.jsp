<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết nhân viên</title>

        <!-- Bootstrap & Font Awesome (optional, nếu muốn dùng icon) -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f8f9fa;
                margin: 0;
                padding: 40px;
            }

            .detail-container {
                max-width: 600px;
                background-color: #ffffff;
                padding: 30px 40px;
                border-radius: 12px;
                margin: auto;
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
                border-top: 4px solid #D70018;
            }

            h2 {
                text-align: center;
                margin-bottom: 30px;
                color: #D70018;
                font-weight: 600;
            }

            .detail-item {
                margin-bottom: 16px;
                font-size: 15px;
                color: #333;
            }

            .detail-item strong {
                display: inline-block;
                width: 160px;
                font-weight: 600;
                color: #111;
            }

            .status-active {
                background-color: #d1fae5;
                color: #065f46;
                padding: 5px 10px;
                border-radius: 12px;
                font-weight: 600;
                font-size: 14px;
            }

            .status-locked {
                background-color: #fde2e2;
                color: #991b1b;
                padding: 5px 10px;
                border-radius: 12px;
                font-weight: 600;
                font-size: 14px;
            }

            .btn-group {
                text-align: center;
                margin-top: 30px;
            }

            .btn-back {
                background-color: #D70018;
                color: white;
                border: none;
                padding: 10px 20px;
                font-weight: 600;
                border-radius: 6px;
                transition: background-color 0.3s;
            }

            .btn-back:hover {
                background-color: #b10014;
            }

            .error-message {
                color: #b91c1c;
                background-color: #fee2e2;
                padding: 10px;
                border-radius: 6px;
                text-align: center;
                font-weight: 500;
                margin-bottom: 20px;
            }
        </style>

    </head>
    <body>

        <div class="detail-container">
            <h2>Chi tiết Nhân viên</h2>

            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>

            <c:if test="${not empty user}">
                <div class="detail-item"><strong>User ID:</strong> ${user.userID}</div>
                <div class="detail-item"><strong>Full Name:</strong> ${user.fullName}</div>
                <div class="detail-item"><strong>Email:</strong> ${user.email}</div>
                <div class="detail-item"><strong>Phone Number:</strong> ${user.phoneNumber}</div>
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

                    <button class="btn-back" onclick="location.href = 'staffList'">
                        <i class="fas fa-arrow-left me-1"></i> Quay lại danh sách
                    </button>
                </div>
            </c:if>
        </div>

    </body>
</html>
