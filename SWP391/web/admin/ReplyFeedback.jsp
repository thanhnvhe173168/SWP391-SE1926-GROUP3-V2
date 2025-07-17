<%-- 
    Document   : replyFeedback
    Created on : Jul 10, 2025
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
    <title>Phản hồi Feedback</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f6f9;
            padding: 40px;
        }
        .container {
            max-width: 600px;
            background: #fff;
            margin: 0 auto;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            font-weight: 600;
            margin-bottom: 5px;
        }
        textarea {
            width: 100%;
            padding: 10px;
            min-height: 100px;
            border: 1px solid #ccc;
            border-radius: 4px;
            resize: vertical;
            font-size: 14px;
        }
        input[type="submit"] {
            background: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            transition: background 0.3s;
        }
        input[type="submit"]:hover {
            background: #0056b3;
        }
        .feedback-info {
            background: #f8f9fa;
            border: 1px solid #ddd;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>📣 Phản hồi Feedback</h2>

        <div class="feedback-info">
            <p><strong>ID:</strong> <%= fb.getFeedbackID() %></p>
            <p><strong>Title:</strong> <%= fb.getTitle() %></p>
            <p><strong>Content:</strong> <%= fb.getContent() %></p>
            <p><strong>Created At:</strong> <%= fb.getCreatedAt() %></p>
            <p><strong>Reply:</strong> 
                <% if (fb.getReplyContent() != null && !fb.getReplyContent().isEmpty()) { %>
                    <%= fb.getReplyContent() %>
                <% } else { %>
                    <em>Chưa có phản hồi</em>
                <% } %>
            </p>
        </div>

        <form action="replyFeedback" method="post">
            <input type="hidden" name="feedbackID" value="<%= fb.getFeedbackID() %>">
            <div class="form-group">
                <label for="replyContent">Nội dung phản hồi:</label>
                <textarea name="replyContent" required><%= fb.getReplyContent() != null ? fb.getReplyContent() : "" %></textarea>
            </div>
            <input type="submit" value="Gửi phản hồi">
        </form>
    </div>
</body>
</html>
