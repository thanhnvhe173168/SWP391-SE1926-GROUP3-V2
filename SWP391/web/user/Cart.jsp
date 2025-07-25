<%-- 
    Document   : CartOrder
    Created on : May 22, 2025, 4:00:49 PM
    Author     : Window 11
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*" %>
<%@page import="dao.*" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Giỏ hàng</title>
        <link rel="stylesheet" href="styles.css" />
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f9f9f9;
                margin: 0;
                padding: 0;
            }

            h2 {
                text-align: center;
                margin: 30px 0;
                color: #d70018; /* Đỏ đặc trưng CellphoneS */
                font-weight: bold;
                font-size: 28px;
            }

            .main {
                padding: 30px;
            }

            table {
                width: 100%;
                background: #fff;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 2px 8px rgba(0,0,0,0.05);
                border-collapse: collapse;
            }

            table th {
                background: #d70018;
                color: white;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                padding: 16px;
                font-size: 14px;
            }

            table td {
                text-align: center;
                padding: 16px;
                border-bottom: 1px solid #f0f0f0;
            }

            tr:hover {
                background-color: #fcfcfc;
            }

            img {
                border-radius: 6px;
                width: 100px;
                object-fit: cover;
                box-shadow: 0 1px 4px rgba(0,0,0,0.1);
            }

            .price {
                color: #d70018;
                font-weight: bold;
                font-size: 16px;
            }

            .qty-control {
                display: inline-flex;
                align-items: center;
                border: 1px solid #ccc;
                border-radius: 4px;
                overflow: hidden;
            }

            .qty-control button {
                width: 32px;
                height: 32px;
                background: #eee;
                border: none;
                font-weight: bold;
                cursor: pointer;
            }

            .qty-control input {
                width: 50px;
                border: none;
                text-align: center;
            }

            button {
                padding: 8px 14px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 500;
                transition: all 0.2s ease-in-out;
            }

            button:hover {
                opacity: 0.9;
            }

            button.order-btn {
                background-color: #d70018;
                color: white;
            }

            button.remove-btn {
                background-color: #888;
                color: white;
            }

            button.buy-more-btn {
                background-color: #d70018;
                color: white;
                font-weight: bold;
            }

            input[type="checkbox"] {
                transform: scale(1.2);
                cursor: pointer;
            }

            .total-row {
                background: #f8f8f8;
                font-weight: bold;
            }

            .total-row td {
                font-size: 18px;
                color: #333;
            }

            .empty-cart {
                text-align: center;
                font-size: 20px;
                color: #999;
                margin: 50px 0;
            }


        </style>
        <%  
            User user = (User)session.getAttribute("user");
            
        %>
    </head>
    <body>
        <script>
            function confirmRemoveFromCart(productId) {
                Swal.fire({
                    title: "Bạn chắc chắn muốn xoá sản phẩm này?",
                    text: "Sau khi xoá sẽ không thể hoàn tác!",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#d33",
                    cancelButtonColor: "#3085d6",
                    confirmButtonText: "Vâng, xoá",
                    cancelButtonText: "Không"
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = 'RemoveFromCart?id=' + productId;
                    }
                });
            }

            function showToast(icon, message, timer = 2000) {
                Swal.fire({
                    icon: icon, // 'success', 'warning', 'error'
                    title: message,
                    showConfirmButton: false,
                    timer: timer
                });
            }
        </script>
        <jsp:include page="/components/Header.jsp"></jsp:include>
            <h2>Shopping Cart</h2>
            <div class="main">
            <c:set var="listcartdetails" value="${listcartdetail}" />

            <c:choose>
                <c:when test="${empty listcartdetails}">
                    <p>Giỏ hàng của bạn đang trống.</p>
                </c:when>

                <c:otherwise>
                    <table>
                        <tr>
                            <th>Select</th>
                            <th>Product Image</th>
                            <th>Laptop Name</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Unit Price</th>
                            <th>Order</th>
                            <th>Remove</th>
                        </tr>

                        <c:forEach var="item" items="${listcartdetails}">
                            <tr>
                                <td>
                                    <input type="checkbox"
                                           class="items-checkbox"
                                           data-productid="${item.laptop.laptopID}"
                                           ${item.isSelect ? 'checked' : ''}
                                           onchange="itemSelectReOrder(this)">
                                </td>
                                <td><img src="images/${item.laptop.imageURL}" width="100" alt="${item.laptop.laptopName}" /></td>
                                <td>${item.laptop.laptopName}</td>
                                <td class="price"><fmt:formatNumber value="${item.unitPrice}" type="number" groupingUsed="true"/> VNĐ</td>
                                <td>
                                    <div class="qty-control">
                                        <button onclick="updateQuantity(${item.laptop.laptopID}, -1, ${item.laptop.stock})">-</button>
                                        <input type="text" id="qty-${item.laptop.laptopID}" value="${item.quantity}"
                                               onchange="manualUpdate(${item.laptop.laptopID}, ${item.laptop.stock})">
                                        <button onclick="updateQuantity(${item.laptop.laptopID}, 1, ${item.laptop.stock})">+</button>
                                    </div>
                                </td>                                    
                                <td id="price-${item.laptop.laptopID}">
                                    <fmt:formatNumber value="${item.unitPrice * item.quantity}" type="number" groupingUsed="true"/> VNĐ</td>
                                <td><button class="order-btn" onclick="window.location.href = 'Order?id=${item.getLaptop().getLaptopID()}'">Order</button></td>
                                <td><button class="remove-btn" onclick="window.location.href = 'RemoveFromCart?id=${item.getLaptop().getLaptopID()}'">Remove</button></td>
                            </tr>
                        </c:forEach>

                        <tr class="total-row">
                            <td colspan="1"><button class="buy-more-btn" onclick="window.location.href = 'OrderItemSelect?'">Buy more</button></td>
                            <td colspan="4"><strong>Total amount:</strong></td>
                            <td id="total-price" colspan="1"><strong><fmt:formatNumber value="${total}" type="number" groupingUsed="true"/> VNĐ</strong></td>
                        </tr>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
        <jsp:include page="/components/Footer.jsp"></jsp:include>
        <script>
            function updateQuantity(productId, delta, stock) {
                let input = document.getElementById('qty-' + productId);
                let newQty = parseInt(input.value) + delta;

                if (newQty <= 0) {
                    confirmRemoveFromCart(productId);
                    return;
                }

                if (newQty > stock) {
                    showToast('warning', 'Số lượng bạn chọn vượt quá tồn kho!');
                    return;
                }

                input.value = newQty;
                sendUpdate(productId, newQty);
            }

            function manualUpdate(productId, stock) {
                let input = document.getElementById('qty-' + productId);
                let qty = parseInt(input.value);

                if (qty <= 0) {
                    confirmRemoveFromCart(productId);
                    return;
                }

                if (qty > stock) {
                    showToast('warning', 'Số lượng bạn chọn vượt quá tồn kho!');
                    input.value = stock;
                    qty = stock;
                }

                sendUpdate(productId, qty);
            }


            function sendUpdate(productId, quantity) {
                fetch('QuantityChange', {
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
                        })
                        .catch(error => {
                            console.error('Lỗi:', error);
                            showToast('error', 'Có lỗi xảy ra!');
                        });
            }


            function itemSelectReOrder(checkbox) {
                const productId = checkbox.dataset.productid;
                const isChecked = checkbox.checked;

                fetch('itemSelectInCart', {
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

