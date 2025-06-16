<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Chi tiết Khách hàng</title>
        <style>
            body {
                font-family: Arial;
                padding: 20px;
                background-color: #f9f9f9;
            }
            h2 {
                margin-bottom: 20px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
                background-color: white;
            }
            th, td {
                padding: 10px;
                border: 1px solid #ccc;
            }
            thead {
                background-color: #007bff;
                color: white;
            }
        </style>
    </head>
    <body>

        <h2>Thông tin khách hàng</h2>
        <p><strong>User ID:</strong> ${user.userID}</p>
        <p><strong>Full Name:</strong> ${user.fullName}</p>
        <p><strong>Email:</strong> ${user.email}</p>
        <p><strong>Phone:</strong> ${user.phoneNumber}</p>
        <p><strong>Address:</strong> ${user.address}</p>
        <p><strong>Registration Date:</strong> ${user.registrationDate}</p>
        <p><strong>Status ID:</strong> ${user.statusID}</p>
        <p><strong>Role ID:</strong> ${user.roleID}</p>

        <hr>

        <h3>Danh sách Đơn hàng</h3>
        <table>
            <thead>
                <tr><th>Order ID</th><th>Date</th><th>Status</th><th>Total</th></tr>
            </thead>
            <tbody>
                <c:forEach var="o" items="${orders}">
                    <tr>
                        <td>${o.orderID}</td>
                        <td>${o.orderDate}</td>
                        <td>${o.statusID}</td>
                        <td>${o.totalAmount}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty orders}">
                    <tr><td colspan="4" style="text-align: center;">Không có đơn hàng nào.</td></tr>
                </c:if>
            </tbody>
        </table>

        <h3>Danh sách Đánh giá</h3>
        <table>
            <thead>
                <tr><th>Review ID</th>
                    <th>Laptop ID</th>
                    <th>Rating</th>
                    <th>Comment</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="r" items="${reviews}">
                    <tr>
                        <td>${r.reviewID}</td>
                        <td>${r.laptopID}</td>
                        <td>${r.rating}</td>
                        <td>${r.comment}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty reviews}">
                    <tr><td colspan="4" style="text-align: center;">Không có đánh giá nào.</td></tr>
                </c:if>
            </tbody>
        </table>

        <br>
        <button onclick="history.back()">Quay lại</button>

    </body>
</html>
