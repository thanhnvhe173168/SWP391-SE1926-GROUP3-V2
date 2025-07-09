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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

        <style>
            table {
                width: 80%;
                margin: auto;
                border-collapse: collapse;
            }
            th, td {
                border: 1px solid #ccc;
                padding: 10px;
                text-align: center;
            }
            input[type=number] {
                width: 50px;
                text-align: center;
            }
            button {
                padding: 5px 10px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/components/Header.jsp"></jsp:include>

            <h2 style="text-align: center;">Chọn sản phẩm muốn mua</h2>
            <main>
            <c:set var="lists" value="${sessionScope.listReOrder}" />
            <table>
                <thead>
                    <tr>
                        <th>Chọn</th>
                        <th>Hình ảnh</th>
                        <th>Tên Laptop</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Thành tiền</th>
                        <th>Mua</th>    </tr>
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
                                ${item.unitPrice * item.quantity}
                            </td>
                            <td><button type="button" style=" background-color: greenyellow" onclick="window.location.href = 'Order?id=${item.getLaptop().getLaptopID()}&ids=1'">Mua</button></td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr>
                        <td>
                            <button type="button" style=" background-color: greenyellow" onclick="window.location.href = 'Order?ids=2'">Mua</button>
                        </td>
                        <td colspan="3"><strong>Tổng tiền:</strong></td>
                        <td id="total-price">
                            ${totalPrice}
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
