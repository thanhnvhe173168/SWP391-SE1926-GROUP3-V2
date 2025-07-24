<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.*" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Nhập lý do huỷ đơn hàng</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, sans-serif;
                background: #f5f5f5;
                margin: 0;
                padding: 0;
            }

            .container {
                max-width: 600px;
                margin: 80px auto;
                background: #fff;
                border-radius: 8px;
                padding: 40px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            }

            h1 {
                text-align: center;
                color: #007bff;
                margin-bottom: 30px;
            }

            label {
                display: block;
                font-weight: bold;
                margin-bottom: 10px;
                color: #333;
            }

            textarea {
                width: 100%;
                min-height: 120px;
                border: 1px solid #ccc;
                border-radius: 4px;
                padding: 12px;
                font-size: 16px;
                resize: vertical;
                transition: border-color 0.3s;
            }

            textarea:focus {
                border-color: #007bff;
                outline: none;
            }

            .container .btn {
                display: block;
                background: #ee4d2d; /* Shopee cam */
                color: #fff;
                border: none;
                padding: 12px 24px;
                border-radius: 4px;
                font-size: 16px;
                cursor: pointer;
                margin: 30px auto 0;
                transition: background 0.3s;
            }

            .btn:hover {
                background: #d8431f;
            }

            .back-link {
                display: block;
                text-align: center;
                margin-top: 20px;
                color: #007bff;
                text-decoration: none;
            }

            .back-link:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <%
                String mess = (String) request.getAttribute("mess");
                if (mess != null) {
        %>
        <script>
            Swal.fire({
                icon: 'success',
                title: '<%= mess %>',
                showConfirmButton: false,
                timer: 2000
            });
        </script>
        <% } %>

        <jsp:include page="/components/Header.jsp" />

        <div class="container">
            <h1>Enter reason for canceling order</h1>
            <form action="CancelOrder" method="get"">
                <input type="hidden" name="orderID" value="${id}" />

                <label for="reason">Reason for cancellation:</label>
                <textarea id="reason" name="reason" placeholder="Enter your reason..." required></textarea>

                <button type="submit" class="btn">Cancel order</button>
            </form>

            <a href="OrderList" class="back-link">Back to order history</a>
        </div>

        <jsp:include page="/components/Footer.jsp" />
    </body>
</html>

