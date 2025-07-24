<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*" %>
<%@page import="dao.*" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
    <head>
        <title>Mua lại</title>

        <style>
            :root {
                --main-red: #d70018;
                --gray-bg: #f5f5f5;
                --text-dark: #212121;
                --text-light: #757575;
                --border-color: #e0e0e0;
                --box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
            }

            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: 'Roboto', sans-serif;
                background-color: var(--gray-bg);
                color: var(--text-dark);
            }

            h2 {
                font-size: 26px;
                font-weight: 700;
                color: var(--main-red);
                margin: 40px 0 20px;
                text-align: center;
                text-transform: uppercase;
            }

            main {
                width: 96%;
                max-width: 1200px;
                margin: 0 auto 60px auto;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #fff;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: var(--box-shadow);
            }

            thead {
                background-color: #d70018;
                border-bottom: 1px solid var(--border-color);
            }

            th, td {
                padding: 16px;
                text-align: center;
                font-size: 15px;
                color: var(--text-dark);
            }

            th {
                font-weight: 600;
                color: white;
            }

            tbody tr {
                border-bottom: 1px solid var(--border-color);
                transition: background-color 0.2s ease;
            }

            tbody tr:hover {
                background-color: #fff1f2;
            }

            td img {
                width: 80px;
                height: auto;
                border-radius: 8px;
                border: 1px solid #eee;
            }

            input[type="number"] {
                width: 60px;
                padding: 6px;
                border: 1px solid #ccc;
                border-radius: 6px;
                text-align: center;
                font-size: 14px;
            }

            input[type="checkbox"] {
                transform: scale(1.2);
                cursor: pointer;
            }

            button {
                border: none;
                padding: 8px 14px;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.2s ease;
            }

            button.update-btn {
                background-color: #eeeeee;
                color: #333;
            }

            button[onclick*='Order'] {
                background-color: var(--main-red);
                color: white;
            }

            button[onclick*='Order']:hover {
                background-color: #b40013;
            }

            button:disabled {
                background-color: #ccc;
                cursor: not-allowed;
            }

            tfoot td {
                font-weight: 600;
                font-size: 16px;
                color: var(--main-red);
                background-color: #fff9fa;
            }

            /* Footer */
            footer {
                background-color: #1f1f1f;
                color: #aaa;
                padding: 20px 0;
                text-align: center;
                font-size: 13px;
            }

            /* Responsive */
            @media screen and (max-width: 768px) {
                table, thead, tbody, th, td, tr {
                    font-size: 13px;
                }

                td img {
                    width: 60px;
                }

                input[type="number"] {
                    width: 45px;
                }

                button {
                    padding: 6px 10px;
                    font-size: 13px;
                }
            }
        </style>


    </head>
    <body>
        <jsp:include page="/components/Header.jsp"></jsp:include>

            <h2 style="text-align: center;">Select the product you want to buy</h2>
            <main>
            <c:set var="lists" value="${sessionScope.listReOrder}" />
            <table>
                <thead>
                    <tr>
                        <th>Select</th>
                        <th>Image</th>
                        <th>Laptop Name</th>
                        <th>Unit Price</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Order</th>    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${lists}">
                        <tr>
                            <td>
                                <input type="checkbox"
                                       class="items-checkbox"
                                       data-productid="${item.laptop.laptopID}"
                                       checked
                                       onchange="itemSelectReOrder(this)">
                            </td>
                            <td><button type="button" onclick="window.location.href = 'LaptopInfo?id=${item.getLaptop().getLaptopID()}'"><img src="images/${item.laptop.imageURL}" width="100" alt="${item.laptop.laptopName}" /></button></td>
                            <td>${item.laptop.laptopName}</td>
                            <td><fmt:formatNumber value="${item.unitPrice}" type="number" groupingUsed="true"/> VNĐ</td>
                            <td>
                                <button onclick="updateQuantity(${item.laptop.laptopID}, -1)">-</button>
                                <input type="number" id="qty-${item.laptop.laptopID}" value="${item.quantity}" min="1"
                                       onchange="manualUpdate(${item.laptop.laptopID})">
                                <button onclick="updateQuantity(${item.laptop.laptopID}, 1)">+</button>
                            </td>
                            <td id="price-${item.laptop.laptopID}">
                                <fmt:formatNumber value="${item.unitPrice * item.quantity}" type="number" groupingUsed="true"/> VNĐ
                            </td>
                            <td><button type="button" style=" background-color: greenyellow" onclick="window.location.href = 'Order?id=${item.getLaptop().getLaptopID()}&ids=1'">Order</button></td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr>
                        <td>
                            <button type="button" style=" background-color: greenyellow" onclick="window.location.href = 'Order?ids=2'">Order</button>
                        </td>
                        <td colspan="3"><strong>Total amount:</strong></td>
                        <td id="total-price">
                            <fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true"/> VNĐ
                        </td>
                    </tr>
                </tfoot>
            </table>
        </main>
        <jsp:include page="/components/Footer.jsp"></jsp:include>
        <script>
            function updateQuantity(productId, delta) {
                let input = document.getElementById('qty-' + productId);
                let newQty = parseInt(input.value) + delta;
                if (newQty < 1)
                    newQty = 1;
                input.value = newQty;
                sendUpdate(productId, newQty);
            }

            function manualUpdate(productId) {
                let input = document.getElementById('qty-' + productId);
                let qty = parseInt(input.value);
                if (qty < 1) {
                    qty = 1;
                    input.value = 1;
                }
                sendUpdate(productId, qty);
            }

            function sendUpdate(productId, quantity) {
                fetch('updateQuantityReOrder', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        productId: productId,
                        quantity: quantity
                    })
                })
                        .then(res => res.json())
                        .then(data => {
                            document.getElementById('price-' + productId).innerText = data.itemTotal;
                            document.getElementById('total-price').innerText = data.totalPrice;
                        });
            }


            function itemSelectReOrder(checkbox) {
                const productId = checkbox.dataset.productid;
                const isChecked = checkbox.checked;

                fetch('itemSelectReOrder', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        productId: productId,
                        selected: isChecked
                    })
                })
                        .then(res => res.json())
                        .then(data => {
                            document.getElementById('total-price').innerText = data.totalPrice;
                        });
            }

        </script>
    </body>
</html>
