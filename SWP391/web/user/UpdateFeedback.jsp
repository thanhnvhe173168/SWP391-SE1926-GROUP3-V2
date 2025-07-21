<%-- 
    Document   : UpdateFeedback
    Created on : Jul 5, 2025, 4:16:18 PM
    Author     : linhd
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Feedback" %>
<%
    Feedback fb = (Feedback) request.getAttribute("feedback");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cập nhật phản hồi</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f1f3f5;
                margin: 0;
                padding: 50px 20px;
            }
            h2 {
                text-align: center;
                color: #212529;
                margin-bottom: 40px;
            }
            form {
                background: #fff;
                max-width: 600px;
                margin: 0 auto;
                padding: 40px;
                border-radius: 8px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
            }
            label {
                display: block;
                margin-bottom: 6px;
                font-weight: 600;
                color: #343a40;
            }
            input[type="text"],
            textarea,
            select {
                width: 100%;
                padding: 12px 14px;
                margin-bottom: 20px;
                border: 1px solid #ced4da;
                border-radius: 5px;
                font-size: 14px;
                background: #f8f9fa;
                transition: border-color 0.3s;
            }
            input[type="text"]:focus,
            textarea:focus,
            select:focus {
                border-color: #007bff;
                outline: none;
                background: #fff;
            }
            textarea {
                resize: vertical;
                min-height: 120px;
            }
            button {
                display: inline-block;
                width: 100%;
                padding: 14px 0;
                background: #1c7ed6;
                color: #fff;
                border: none;
                border-radius: 5px;
                font-weight: bold;
                font-size: 16px;
                cursor: pointer;
                transition: background 0.3s;
            }
            button:hover {
                background: #1971c2;
            }
            .star-rating {
                direction: rtl;
                display: inline-flex;
            }

            .star-rating input[type="radio"] {
                display: none;
            }

            .star-rating label {
                font-size: 1.5em;
                color: #ccc;
                cursor: pointer;
            }

            .star-rating input[type="radio"]:checked ~ label,
            .star-rating label:hover,
            .star-rating label:hover ~ label {
                color: gold;
            }


        </style>
    </head>
    <body>
        <h2>📋 Cập nhật phản hồi</h2>
        <% if (fb != null) { %>
        <form action="updateFeedback" method="post">
            <input type="hidden" name="feedbackID" value="<%= fb.getFeedbackID() %>" />
            <input type="hidden" name="laptopID" value="<%= fb.getLaptopID() %>" />
            <input type="hidden" name="orderID" value="<%= fb.getOrderID() %>" />
            <input type="hidden" name="productId" value="<%= fb.getLaptopID() %>" />




            <label>Tiêu đề</label>
            <input type="text" name="title" value="<%= fb.getTitle() %>" required />

            <label>Nội dung</label>
            <textarea name="content" rows="5" required><%= fb.getContent() %></textarea>

            <div class="mb-3">
                <label class="rating-label">Đánh giá sản phẩm:</label><br>
                <div class="star-rating">
                    <% for (int i = 5; i >= 1; i--) { %>
                    <input type="radio" id="product<%= i %>" name="rating" value="<%= i %>" <%= (fb.getRating() == i ? "checked" : "") %> required>
                    <label for="product<%= i %>">★</label>
                    <% } %>
                </div>
            </div>


            <div class="mb-3">
                <label class="rating-label">Đánh giá shop:</label><br>
                <div class="star-rating">
                    <% for (int i = 5; i >= 1; i--) { %>
                    <input type="radio" id="seller<%= i %>" name="sellerRating" value="<%= i %>" <%= (fb.getSellerRating() == i ? "checked" : "") %> required>
                    <label for="seller<%= i %>">★</label>
                    <% } %>
                </div>
            </div>


            <div class="mb-3">
                <label class="rating-label">Đánh giá giao hàng:</label><br>
                <div class="star-rating">
                    <% for (int i = 5; i >= 1; i--) { %>
                    <input type="radio" id="ship<%= i %>" name="shippingRating" value="<%= i %>" <%= (fb.getShippingRating() == i ? "checked" : "") %> required>
                    <label for="ship<%= i %>">★</label>
                    <% } %>
                </div>
            </div>
            <button type="submit">Cập nhật phản hồi</button>
        </form>
        <% } else { %>
        <h3 style="text-align:center; color:red;">Phản hồi không tồn tại hoặc đã bị xoá!</h3>
        <% } %>
    </body>
</html>
