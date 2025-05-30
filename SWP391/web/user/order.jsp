<%-- 
    Document   : order
    Created on : May 27, 2025, 3:53:04 PM
    Author     : Window 11
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="model.*" %>
<%@page import="dao.*" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Page</title>
        <link rel="stylesheet" href="styles.css" />
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet" />

        <style>
            body {
                font-family: 'Roboto', sans-serif;
                background-color: #f8f9fa;
                color: #212529;
                padding: 30px 15px;
                min-height: 100vh;
            }

            h1 {
                font-weight: 700;
                font-size: 2rem;
                margin-bottom: 30px;
                color: #343a40;
                text-align: center;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 35px;
                background-color: #fff;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            }

            th, td {
                padding: 14px 18px;
                text-align: left;
                border-bottom: 1px solid #dee2e6;
                vertical-align: middle;
            }

            th {
                background-color: #343a40;
                color: #fff;
                font-weight: 500;
                text-transform: uppercase;
                letter-spacing: 0.05em;
                user-select: none;
            }

            tr:hover {
                background-color: #f1f3f5;
                transition: background-color 0.2s ease;
            }

            img {
                border-radius: 6px;
                max-width: 100px;
                box-shadow: 0 1px 4px rgba(0,0,0,0.1);
                transition: transform 0.2s ease;
            }
            img:hover {
                transform: scale(1.03);
            }

            button {
                background-color: #495057;
                color: #fff;
                border: none;
                border-radius: 6px;
                padding: 6px 14px;
                font-weight: 500;
                cursor: pointer;
                transition: background-color 0.25s ease;
            }
            button:hover {
                background-color: #212529;
            }
            button:active {
                background-color: #16181b;
                transform: scale(0.95);
            }
            td > button {
                margin: 0 8px;
            }

            input[type="text"], textarea {
                width: 100%;
                padding: 9px 14px;
                border: 1.5px solid #ced4da;
                border-radius: 6px;
                font-size: 15px;
                transition: border-color 0.3s ease;
            }
            input[type="text"]:focus, textarea:focus {
                border-color: #495057;
                outline: none;
            }

            label {
                cursor: pointer;
                font-weight: 500;
                color: #495057;
            }

            input[type="radio"] {
                appearance: none;
                width: 18px;
                height: 18px;
                border: 2px solid #495057;
                border-radius: 50%;
                margin-right: 8px;
                position: relative;
                cursor: pointer;
                transition: border-color 0.3s ease, background-color 0.3s ease;
            }
            input[type="radio"]:checked {
                background-color: #495057;
                border-color: #495057;
            }
            input[type="radio"]:checked::after {
                content: "";
                position: absolute;
                top: 4px;
                left: 4px;
                width: 8px;
                height: 8px;
                background: white;
                border-radius: 50%;
            }

            .total-row td {
                font-weight: 700;
                font-size: 1.3rem;
                background-color: #e9ecef;
                text-align: right;
                padding-right: 25px;
            }

            /* Responsive */
            @media (max-width: 768px) {
                table, thead, tbody, th, td, tr {
                    display: block;
                }
                thead tr {
                    display: none;
                }
                tr {
                    margin-bottom: 20px;
                    background-color: #fff !important;
                    box-shadow: 0 1px 6px rgba(0,0,0,0.05);
                    border-radius: 8px;
                    padding: 15px 10px;
                }
                td {
                    border: none !important;
                    padding-left: 50%;
                    position: relative;
                    text-align: left !important;
                    margin-bottom: 10px;
                }
                td::before {
                    position: absolute;
                    top: 50%;
                    left: 15px;
                    transform: translateY(-50%);
                    font-weight: 600;
                    white-space: nowrap;
                    color: #495057;
                    content: attr(data-label);
                }
                .order-details {
                    width: 60%;          /* Bạn chỉnh % này theo ý muốn */
                    margin: 0 auto 40px auto;  /* Căn giữa, cách dưới 40px */
                    font-size: 0.95rem;  /* Thu nhỏ font một chút (tuỳ chọn) */
                    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                    border-radius: 8px;
                    background-color: #fff;
                }

            }
        </style>

        <%
                PaymentMethodDAO pmdao = new PaymentMethodDAO();
                List<PaymentMethod> list= pmdao.listpaymentmethod();
                request.setAttribute("listPayment", list); // Đặt vào request scope
        %>
    </head>
    <body>
        <h1>Đặt hàng</h1>
        <form>
            <c:set var="listorderings" value="${listordering}" />

            <table>
                <tr>
                    <th>Hình ảnh</th>
                    <th>Tên Laptop</th>
                    <th>Giá</th>
                    <th>Số lượng</th>
                    <th>Thành tiền</th>
                </tr>

                <c:forEach var="item" items="${listorderings}">
                    <tr>
                        <td><button type="button" onclick="window.location.href = 'LaptopInfo?id=${item.getLaptop().getLaptopID()}'"><img src="images/${item.laptop.imageURL}" width="100" alt="${item.laptop.laptopName}" /></button></td>
                        <td>${item.laptop.laptopName}</td>
                        <td><fmt:formatNumber value="${item.unitPrice}" type="number" groupingUsed="true"/> VNĐ</td>
                        <td>
                            <button type="button" onclick="window.location.href = 'QuantityChange?action=dec&id=${item.getLaptop().getLaptopID()}'">-</button>

                            ${item.quantity}
                            <button type="button" onclick="window.location.href = 'QuantityChange?action=inc&id=${item.getLaptop().getLaptopID()}'">+</button>

                        </td>
                        <td><fmt:formatNumber value="${item.unitPrice * item.quantity}" type="number" groupingUsed="true"/> VNĐ</td>
                    </tr>
                </c:forEach>
            </table>
            <table class="order-details">
                <tr>
                    <td>Cách nhận hàng:</td>
                    <td><label>Nhận tại cửa hàng<input type="radio" name="op" value="1" 
                                                       onclick="showShipFee(this.value)"/></label></td>
                    <td><label>Giao đến nơi<input type="radio" name="op" value="2" 
                                                  onclick="showShipFee(this.value)"/></label></td>
                </tr>
                <tr>
                    <td colspan="1">Voucher:</td> 
                    <td>
                        <input type="text" name="Voucher" value="" /> 
                    </td>
                    <td>
                        <button onclick="window.location.href = 'addvoucher?'">Áp dụng</button>
                    </td>
                </tr>
                <tr>
                    <td>Địa chỉ nhận hàng:</td> 
                    <td><input type="text" name="address" value="" /></td>
                </tr>
                <tr>
                    <td>Ghi chú:</td> 
                    <td><textarea name="note" rows="4" cols="20"></textarea></td>
                </tr>
                <tr>
                    <td>Hình thức thanh toán: </td>
                    <td>
                        <c:forEach var="meth" items="${listPayment}">
                            <label>
                                <input type="radio" name="payment" value="${meth.paymentMethodID}" />
                                ${meth.methodName}
                            </label><br/>
                        </c:forEach>

                    </td>

                </tr>
                <tr>
                    <td>Phí ship:</td>
                    <td id="shipFee">${fee}</td>
                </tr>
                <input type="hidden" id="totalPrice" value="${total}" />
                <td>Chiết khấu:</td>

                <tr class="total-row">
                    <td colspan="1"><strong>Tổng tiền:</strong></td>
                    <td colspan="2" id=""><strong></strong></td>
                </tr>
                <tr>
                    <td colspan="3"><button><strong>Đặt hàng</strong></button></td>
                </tr>
            </table>

        </form>
        <%
                     String mess = (String) request.getAttribute("mess");
                    if (mess != null) {
        %>
        <script>
            alert("<%= mess %>");
        </script>
        <%
            }
        %>
        <script>
            function showShipFee(value) {
                let fee = 0;
                if (value === "1") {
                    fee = 0;
                } else if (value === "2") {
                    fee = 30000;
                }
                document.getElementById("shipFee").innerText = fee.toLocaleString('vi-VN') + " VNĐ";
            }
        </script>
    </body>
</html>
