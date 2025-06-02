<%-- 
    Document   : Login
    Created on : May 28, 2025, 8:42:01 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            body {
                background-color: #f8f9fa;
            }
            .login-container {
                max-width: 400px;
                margin: 50px auto;
                background: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .login-title {
                text-align: center;
                margin-bottom: 20px;
                color: #333;
            }
        </style>
    </head>
    <body>
        <%
           String message = (String) request.getAttribute("message");
        %>
        <jsp:include page="/components/Header.jsp"></jsp:include>
            <div class="login-container">
                <h2 class="login-title">Đăng nhập</h2>
                <form action="login" method="POST">
                    <!-- Email -->
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <!-- Password -->
                    <div class="mb-3">
                        <label for="password" class="form-label">Mật khẩu</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                <%if(message != null) {%>
                <p class="text-danger"><%=message%></p>
                <%}%>
                <!-- Submit Button -->
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Đăng nhập</button>
                </div>
            </form>
            <p class="text-center mt-3"><a href="forgotPassword">Quên mật khẩu?</a></p>
            <p class="text-center mt-3">Bạn không có tài khoản? <a href="register">Đăng ký</a></p>
        </div>
        <jsp:include page="/components/Footer.jsp"></jsp:include>
    </body>
</html>
