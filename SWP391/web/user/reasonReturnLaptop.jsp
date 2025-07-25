<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*" %>
<%@page import="dao.*" %>
<%@page import="java.util.List" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Hoàn sản phẩm</title>
        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #f5f5f5;
            }
            .return-container {
                max-width: 800px;
                margin: 50px auto;
                background: white;
                padding: 40px;
                border-radius: 12px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            }
            .product-item {
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 20px;
            }
            .product-item img {
                width: 100px;
                border-radius: 8px;
            }
            textarea {
                width: 100%;
                height: 100px;
                margin-top: 10px;
                padding: 10px;
            }
            input[type="file"] {
                margin-top: 10px;
                display: block;
            }
            button {
                width: 100%;
                background: #ee4d2d;
                border: none;
                color: white;
                padding: 14px;
                border-radius: 8px;
                font-size: 16px;
                cursor: pointer;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/components/Header.jsp"></jsp:include>

            <div class="return-container">
                <h2>Return product</h2>
                <form action="returnLaptop" method="post" enctype="multipart/form-data">
                    <!-- Bọc tất cả trong 1 form -->
                    <input type="hidden" name="orderID" value="${orderid}">

                <c:forEach var="item" items="${listreturn}">
                    <div class="product-item">
                        <h4>${item.laptop.laptopName}</h4>
                        <img src="images/${item.laptop.imageURL}" alt="${item.laptop.laptopName}">
                        <input type="hidden" name="laptopIDs" value="${item.laptop.laptopID}">
                        <label>Reason for return:</label>
                        <textarea name="reason_${item.laptop.laptopID}" placeholder="Enter reason for return"></textarea>

                        <label>Photo evidence:</label>
                        <input type="file" name="image_${item.laptop.laptopID}" multiple accept="image/*">
                    </div>
                </c:forEach>

                <button type="submit">Submit a refund request</button>
            </form>
        </div>

        <jsp:include page="/components/Footer.jsp"></jsp:include>
    </body>
</html>
