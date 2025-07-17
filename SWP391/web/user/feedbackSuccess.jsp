<%-- 
    Document   : feedbackSuccess
    Created on : Jul 2, 2025, 10:50:29 PM
    Author     : linhd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thank You!</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                text-align: center;
                padding-top: 100px;
            }
            h1 {
                color: #2c3e50;
            }
            p {
                color: #34495e;
                margin-top: 20px;
            }
            a {
                display: inline-block;
                margin-top: 30px;
                text-decoration: none;
                color: white;
                background-color: #3498db;
                padding: 10px 20px;
                border-radius: 5px;
            }
            a:hover {
                background-color: #2980b9;
            }
        </style>
    </head>
    <body>
        <h1>🎉 Cảm ơn bạn đã gửi phản hồi!</h1>
        <p>Chúng tôi rất trân trọng ý kiến đóng góp của bạn.</p>

        <a href="customerFeedbackList">Xem phản hồi của bạn</a>
        <br>
        <a href="home">Quay về Trang chủ</a>
    </body>
</html>

