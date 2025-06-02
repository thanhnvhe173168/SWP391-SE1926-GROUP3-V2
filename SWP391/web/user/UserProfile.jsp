<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            body {
                background-color: #f8f9fa;
            }
            .register-container {
                max-width: 500px;
                margin: 50px auto;
                background: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .register-title {
                text-align: center;
                margin-bottom: 20px;
                color: #333;
            }
        </style>
    </head>
    <body>
        <%
           User user = (User) session.getAttribute("user");
           String message = (String) request.getAttribute("message");
        %>
        <jsp:include page="/components/Header.jsp"></jsp:include>
            <div class="register-container">
                <h2 class="register-title">Thông tin tài khoản</h2>
                <form action="updateProfile" method="POST">
                    <!-- Full Name -->
                    <div class="mb-3">
                        <label for="fullName" class="form-label">Họ và tên</label>
                        <input type="text" class="form-control" id="fullName" name="fullName" value="<%=user.getFullName()%>" required>
                </div>
                <!-- Email -->
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="<%=user.getEmail()%>" readonly required>
                </div>
                <!-- Phone Number -->
                <div class="mb-3">
                    <label for="phoneNumber" class="form-label">Số điện thoại</label>
                    <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" value="<%=user.getPhoneNumber()%>" required>
                </div>
                <%if(message != null) {%>
                <p class="text-success"><%=message%></p>
                <%}%>

                <!-- Submit Button -->
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                </div>
            </form>
        </div>
        <jsp:include page="/components/Footer.jsp"></jsp:include>
    </body>
</html>
