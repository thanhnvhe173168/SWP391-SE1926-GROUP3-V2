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
        <link rel="stylesheet" href="styles.css" />\
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, sans-serif;
                background-color: #f5f5f5;
            }

            h2 {
                text-align: center;
                margin-bottom: 30px;
                color: #ee4d2d; /* Shopee cam */
            }

            table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 12px rgba(0,0,0,0.1);
                overflow: hidden;
            }

            th {
                background: #007bff;  /* Cam Shopee nổi bật */
                color: #fff;          /* Chữ trắng dễ đọc */
                font-weight: bold;
                text-transform: uppercase; /* Viết hoa tất cả tiêu đề */
                letter-spacing: 0.5px;
                padding: 18px;
            }

            td {
                text-align: center;
                padding: 20px 15px;
                border-bottom: 1px solid #f2f2f2;
                vertical-align: middle;
            }

            tr:hover {
                background: #fffdfa;
            }

            img {
                border-radius: 8px;
                object-fit: cover;
                box-shadow: 0 1px 5px rgba(0,0,0,0.1);
            }
            input[type="checkbox"] {
                transform: scale(1.2);
                cursor: pointer;
            }

            .price {
                color: #ee4d2d;
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
                width: 36px;
                height: 36px;
                font-size: 16px;
            }

            .qty-control span {
                width: 40px;
                line-height: 36px;
            }

            button[onclick*='Order'] {
                background: #27ae60;
                color: #fff;
                padding: 6px 12px;
                border-radius: 4px;
                border: none;
            }

            button[onclick*='RemoveFromCart'] {
                background: #e74c3c;
                color: #fff;
                padding: 6px 12px;
                border-radius: 4px;
                border: none;
            }

            button:hover {
                opacity: 0.9;
            }

            .total-row {
                background: #fafafa;
                font-weight: bold;
                color: #555;
            }

            .total-row td {
                font-size: 18px;
            }

            .empty-cart {
                text-align: center;
                color: #888;
                font-size: 20px;
                margin: 50px auto;
            }
            .main{
                padding: 30px;
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
            <h2>Giỏ hàng</h2>
            <div class="main">
            <c:set var="listcartdetails" value="${listcartdetail}" />

            <c:choose>
                <c:when test="${empty listcartdetails}">
                    <p>Giỏ hàng của bạn đang trống.</p>
                </c:when>

                <c:otherwise>
                        <table>
                            <tr>
                                <th>Chọn</th>
                                <th>Hình ảnh</th>
                                <th>Tên Laptop</th>
                                <th>Giá</th>
                                <th>Số lượng</th>
                                <th>Thành tiền</th>
                                <th>Mua</th>
                                <th>Xóa</th>
                            </tr>

                            <c:forEach var="item" items="${listcartdetails}">
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
                                    <td class="price"><fmt:formatNumber value="${item.unitPrice}" type="number" groupingUsed="true"/> VNĐ</td>
                                    <td>
                                        <button onclick="updateQuantity(${item.laptop.laptopID}, -1, ${item.laptop.stock})">-</button>
                                        <input type="number" id="qty-${item.laptop.laptopID}" value="${item.quantity}"
                                               onchange="manualUpdate(${item.laptop.laptopID}, ${item.laptop.stock})">
                                        <button onclick="updateQuantity(${item.laptop.laptopID}, 1, ${item.laptop.stock})">+</button>
                                    </td>                                    
                                    <td id="price-${item.laptop.laptopID}">
                                        ${item.unitPrice * item.quantity}
                                    </td>
                                    <td><button type="button" style=" background-color: greenyellow" onclick="window.location.href = 'Order?id=${item.getLaptop().getLaptopID()}'">Mua</button></td>
                                    <td>
                                        <button type="button" style=" background-color: greenyellow" onclick="window.location.href = 'RemoveFromCart?id=${item.getLaptop().getLaptopID()}'">Xóa</button>
                                    </td>
                                </tr>
                            </c:forEach>

                            <tr class="total-row">
                                <td colspan="1"><button type="button" style=" background-color: greenyellow" onclick="window.location.href = 'OrderItemSelect?'">Mua nhiều</button></td>
                                <td colspan="4"><strong>Tổng cộng:</strong></td>
                                <td id="total-price" colspan="1"><strong>${total}</strong></td>
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

