
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Lý do hủy đơn hàng</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f9f9f9;
                padding: 40px;
            }
            .container {
                background: white;
                padding: 30px;
                max-width: 500px;
                margin: auto;
                border-radius: 8px;
                box-shadow: 0 0 10px #ccc;
            }
            textarea {
                width: 100%;
                height: 120px;
                padding: 10px;
                resize: vertical;
                font-size: 14px;
            }
            button {
                padding: 10px 20px;
                background: #d9534f;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            button:hover {
                background: #c9302c;
            }
        </style>
        <%
            String id_raw = request.getParameter("id");
            int id = Integer.parseInt(id_raw);
            request.setAttribute("id", id);
        %>
    </head>
    <body>
        <a href="${pageContext.request.contextPath}/OrderList">Trở về</a>
        <div class="container">
            <h2>Hủy đơn hàng</h2>
            <form action="CancelOrder" method="post">
                <input type="hidden" name="orderId" value="${id}" />
                <label for="reason">Lý do hủy đơn hàng:</label><br>
                <textarea name="reason" id="reason" required placeholder="Nhập lý do..."></textarea><br><br>
                <button type="submit">Xác nhận hủy</button>
            </form>
        </div>
    </body>
</html>
