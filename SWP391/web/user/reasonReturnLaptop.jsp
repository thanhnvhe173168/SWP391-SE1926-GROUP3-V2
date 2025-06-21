<%-- 
    Document   : returnOrder
    Created on : Jun 21, 2025, 10:07:32 PM
    Author     : Window 11
--%>
<%@page import="model.*" %>
<%@page import="dao.*" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lý do hoàn đơn</title>
        <meta charset="UTF-8">
        <title>Hoàn đơn hàng</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 0;
            }
            .return-container {
                max-width: 600px;
                margin: 50px auto;
                background: white;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            }
            h2 {
                color: #333;
                text-align: center;
            }
            label {
                font-weight: bold;
                margin-bottom: 5px;
                display: block;
            }
            textarea {
                width: 100%;
                height: 120px;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 8px;
                resize: vertical;
                font-size: 14px;
            }
            button {
                background-color: #ff4d4f;
                color: white;
                border: none;
                padding: 12px 24px;
                font-size: 16px;
                border-radius: 8px;
                cursor: pointer;
                margin-top: 20px;
                float: right;
            }
            button:hover {
                background-color: #e04344;
            }
        </style>
        <%
        String ids = request.getParameter("id");
        int id = Integer.parseInt(ids);
        
        %>
    </head>
    <body>
        <jsp:include page="/components/Header.jsp"></jsp:include>
            <div class="return-container">
                <h2>Hoàn sản phẩm</h2>
            <form action="returnOrder" method="post">
                <input type="hidden" name="laptopID" value="<%= id %>">
                <label for="reason">Lý do hoàn hàng:</label>
                <textarea name="reason" id="reason" required placeholder="Ví dụ: sản phẩm bị lỗi, giao nhầm..."></textarea>
                <button type="submit">Gửi yêu cầu</button>
            </form>
        </div>
        <jsp:include page="/components/Footer.jsp"></jsp:include>
    </body>
</html>
