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
                <h2 class="login-title">Thay đổi mật khẩu</h2>
                <form action="changePassword" method="POST" id="changePasswordForm">
                    <!-- Password -->
                    <div class="mb-3">
                        <label for="password" class="form-label">Mật khẩu mới</label>
                        <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                    </div>
                    <!-- Password -->
                    <div class="mb-3">
                        <label for="password" class="form-label">Xác nhận mật khẩu</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                    </div>
                    <div id="errorMessage" class="text-danger mb-3" style="display: none;">
                        Mật khẩu mới và xác nhận mật khẩu không trùng khớp!
                    </div>
                <%if(message != null) {%>
                <p class="text-danger"><%=message%></p>
                <%}%>
                <!-- Submit Button -->
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary">Lưu</button>
                </div>
            </form>
        </div>
        <jsp:include page="/components/Footer.jsp"></jsp:include>
        <script>
            document.getElementById("changePasswordForm").addEventListener("submit", function (event) {
                const password = document.getElementById("newPassword").value;
                const confirmPassword = document.getElementById("confirmPassword").value;
                const errorMessage = document.getElementById("errorMessage");

                if (password !== confirmPassword) {
                    event.preventDefault();
                    errorMessage.style.display = "block";
                }
            });
        </script>
    </body>
</html>
