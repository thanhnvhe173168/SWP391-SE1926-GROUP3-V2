<%-- 
    Document   : GiveFeedback
    Created on : Jul 2, 2025, 5:08:03 PM
    Author     : linhd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user"); 
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "guest/Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Gửi phản hồi</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f9fafb;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                margin: 0;
            }

            .feedback-container {
                background: #fff;
                padding: 40px 35px;
                border-radius: 16px;
                box-shadow: 0 12px 30px rgba(0, 0, 0, 0.1);
                max-width: 550px;
                width: 100%;
            }

            .feedback-container h2 {
                margin-top: 0;
                margin-bottom: 25px;
                text-align: center;
                color: #222;
                font-weight: 700;
                font-size: 26px;
            }

            label {
                display: block;
                margin-bottom: 6px;
                font-weight: 600;
                color: #333;
            }

            input[type="text"],
            textarea,
            select,
            input[type="file"] {
                width: 100%;
                padding: 12px 16px;
                border: 1px solid #ddd;
                border-radius: 8px;
                font-size: 15px;
                margin-bottom: 20px;
                transition: border-color 0.3s, box-shadow 0.3s;
                background: #fdfdfd;
            }

            input[type="text"]:focus,
            textarea:focus,
            select:focus,
            input[type="file"]:focus {
                border-color: #ff5722;
                box-shadow: 0 0 5px rgba(255, 87, 34, 0.3);
                outline: none;
            }

            select {
                appearance: none;
                background: url('data:image/svg+xml;utf8,<svg fill="%23333" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5H7z"/></svg>') no-repeat right 12px center;
                background-size: 18px;
            }

            button[type="submit"] {
                background-color: #ff5722;
                color: #fff;
                padding: 14px 0;
                border: none;
                border-radius: 8px;
                font-size: 17px;
                font-weight: 600;
                cursor: pointer;
                width: 100%;
                transition: background-color 0.3s, transform 0.1s;
            }

            button[type="submit"]:hover {
                background-color: #e64a19;
            }

            button[type="submit"]:active {
                transform: scale(0.98);
            }

            p {
                text-align: center;
                margin-top: 18px;
                font-weight: bold;
                color: #28a745;
            }

            ::placeholder {
                color: #aaa;
                font-style: italic;
            }
        </style>
    </head>

    <body>
        <div class="feedback-container">
            <h2>Gửi phản hồi của bạn</h2>

            <form action="<%= request.getContextPath() %>/giveFeedback" 
                  method="post" enctype="multipart/form-data">

                <input type="hidden" name="userID" value="<%= user.getUserID() %>">


                <label for="title">Tiêu đề:</label>
                <input type="text" id="title" name="title" required>


                <label for="content">Nội dung:</label>
                <textarea id="content" name="content" rows="5" required></textarea>


                <label for="rating">Đánh giá sao sản phẩm:</label>
                <select id="rating" name="rating">
                    <option value="1">1 ⭐</option>
                    <option value="2">2 ⭐</option>
                    <option value="3">3 ⭐</option>
                    <option value="4">4 ⭐</option>
                    <option value="5">5 ⭐</option>
                </select>


                <label for="sellerRating">Dịch vụ người bán:</label>
                <select id="sellerRating" name="sellerRating">
                    <option value="1">1 ⭐</option>
                    <option value="2">2 ⭐</option>
                    <option value="3">3 ⭐</option>
                    <option value="4">4 ⭐</option>
                    <option value="5">5 ⭐</option>
                </select>


                <label for="shippingRating">Tốc độ giao hàng:</label>
                <select id="shippingRating" name="shippingRating">
                    <option value="1">1 ⭐</option>
                    <option value="2">2 ⭐</option>
                    <option value="3">3 ⭐</option>
                    <option value="4">4 ⭐</option>
                    <option value="5">5 ⭐</option>
                </select>


                <label for="productImage">Ảnh thực tế sản phẩm:</label>
                <input type="file" id="productImage" name="productImage" accept="image/*" required>

                <!-- Submit -->
                <button type="submit">Gửi phản hồi</button>

            </form>

            <p><%= request.getAttribute("mess") != null ? request.getAttribute("mess") : "" %></p>
        </div>
    </body>
</html>
