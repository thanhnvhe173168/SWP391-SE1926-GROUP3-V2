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
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 40px;
            }

            .detail-container {
                max-width: 650px;
                background-color: #ffffff;
                padding: 32px 40px;
                border-radius: 12px;
                margin: auto;
                border: 1px solid #e0e0e0;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            }

            h2 {
                text-align: center;
                margin-bottom: 30px;
                color: #d70018;
                font-weight: 700;
                font-size: 24px;
            }

            .detail-item {
                margin-bottom: 16px;
                font-size: 16px;
                color: #333;
                padding: 8px 0;
                border-bottom: 1px solid #eee;
            }

            .detail-item strong {
                color: #444;
                display: inline-block;
                width: 170px;
            }

            .status-active {
                color: #28a745;
                font-weight: 600;
            }

            .status-locked {
                color: #d70018;
                font-weight: 600;
            }

            .btn-group {
                text-align: center;
                margin-top: 30px;
            }

            .btn-back {
                background-color: #d70018;
                color: white;
                border: none;
                padding: 10px 22px;
                font-weight: 600;
                font-size: 15px;
                border-radius: 6px;
                transition: background-color 0.3s ease;
            }

            .btn-back:hover {
                background-color: #a50012;
            }

            .error-message {
                color: #d70018;
                text-align: center;
                font-weight: 600;
                margin-bottom: 20px;
                font-size: 15px;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .detail-container {
                    padding: 24px;
                }

                .detail-item strong {
                    width: 140px;
                }
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
                    <button class="btn-back" onclick="location.href = '${pageContext.request.contextPath}/userList'">
                        <i class="fas fa-arrow-left me-1"></i> Quay lại danh sách
                    </button>
                </div>
            </c:if>
        </div>
    </body>
</html>