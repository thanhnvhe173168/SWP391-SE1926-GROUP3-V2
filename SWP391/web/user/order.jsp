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

        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f0f2f5;
                padding: 20px;
                color: #2c3e50;
            }

            h1 {
                text-align: center;
                color: #1e272e;
                margin-bottom: 30px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background: #ffffff;
                margin-bottom: 25px;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
            }

            table:first-of-type th, table:first-of-type td {
                padding: 14px;
                border-bottom: 1px solid #ddd;
                text-align: center;
            }

            table:first-of-type th {
                background-color: #dfe6e9;
                color: #2c3e50;
                font-weight: bold;
            }

            /* Table chi tiết đơn hàng */
            .order-details {
                width: 65%;
                margin: auto;
                background: #ffffff;
                border: 1px solid #b2bec3;
                font-size: 15px;
            }

            .order-details td {
                padding: 12px;
                border-bottom: 1px solid #dcdde1;
                vertical-align: top;
                font-weight: 500;
            }

            .order-details input,
            .order-details select,
            .order-details textarea {
                width: 100%;
                padding: 8px;
                font-size: 14px;
                border: 1px solid #636e72;
                border-radius: 5px;
                box-sizing: border-box;
            }

            .order-details input[type="radio"] {
                margin-right: 8px;
                transform: scale(1.1);
                cursor: pointer;
            }

            .order-details label {
                display: block;
                margin-bottom: 6px;
                cursor: pointer;
                color: #2c3e50;
            }

            button {
                background-color: #0984e3;
                color: white;
                border: none;
                padding: 9px 16px;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease;
                font-weight: 600;
            }

            button:hover {
                background-color: #0652dd;
            }

            #shipFeeDisplay {
                font-weight: bold;
                color: #e17055;
            }

            .total-row td {
                font-weight: bold;
                font-size: 16px;
                background-color: #dff9fb;
                color: #130f40;
            }

            input:focus, select:focus, textarea:focus {
                border-color: #00a8ff;
                outline: none;
                box-shadow: 0 0 6px rgba(0, 168, 255, 0.5);
            }
            input[type="radio"]:focus {
                outline: none;
                box-shadow: none;
            }
        </style>


        <%
                PaymentMethodDAO pmdao = new PaymentMethodDAO();
                List<PaymentMethod> list= pmdao.listpaymentmethod();
                request.setAttribute("listPayment", list); // Đặt vào request scope
                
                FeeShipDAO fsdao=new FeeShipDAO();
                VoucherDAO vdao=new VoucherDAO();
                List<FeeShip> listfs = fsdao.GetFeeShip();
                List<Voucher> listvoucher = vdao.GetListVoucher();
                request.setAttribute("listfs", listfs);
                request.setAttribute("listvoucher", listvoucher);
        %>
    </head>
    <body>
        <h1>Đặt hàng</h1>
        <form method="post" action="OrderSuccess">
            <c:set var="listorderings" value="${listordering}" />
            <input type="hidden" id="totalProductPrice" value="${total}" />
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
                    <td>  
                        <select name="chooseway" id="choosewaySelect" onchange="showShipFee()">
                            <option></option>
                            <c:forEach var="way" items="${listfs}">
                                <option value="${way.getFeeShipID()}" data-fee="${way.getFee()}">
                                    ${way.des}
                                </option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="1">Voucher:</td> 
                    <td>
                        <select name="voucher" id="voucherSelect" onchange="showdiscount()">
                            <option></option>
                            <c:forEach var="code" items="${listvoucher}">
                                <option value="${code.vouchercode}" data-discount="${code.discount}">
                                    ${code.vouchercode}
                                </option>
                            </c:forEach>
                        </select>

                    </td>
                </tr>
                <tr>
                    <td>Địa chỉ nhận hàng:</td> 
                    <td><input type="text" name="address" value="" /></td>
                </tr>
                <tr>
                    <td>Số điện thoại:</td>
                    <td><input type="text" name="PhoneNumber" value="" /></td>
                </tr>    
                <tr>
                    <td>Ghi chú:</td> 
                    <td><textarea name="note" rows="4" cols="20"></textarea></td>
                </tr>
                <tr>
                    <td>Hình thức thanh toán: </td>
                    <td>
                        <c:forEach var="meth" items="${listPayment}">
                            <label style="display: inline-flex; align-items: center; margin-right: 20px; cursor: pointer;">
                                <input type="radio" name="payment" value="${meth.paymentMethodID}" style="margin-right: 6px;" />
                                ${meth.methodName}
                            </label>
                        </c:forEach>
                    </td>

                </tr>
                <tr>
                    <td>Phí ship:</td>
                    <td id="shipFeeDisplay"></td>
                </tr>
                <tr>
                    <td>Chiết khấu:</td>
                    <td id="discountDisplay"></td>
                </tr>
                <tr class="total-row">
                    <td colspan="1"><strong>Tổng tiền:</strong></td>
                    <td colspan="2" id="totalDisplay"><strong></strong></td>
                </tr>
                <tr>
                    <td colspan="3"><button type="submit"><strong>Đặt hàng</strong></button></td>
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
    function updateTotal() {
        const totalProduct = parseFloat(document.getElementById("totalProductPrice").value) || 0;

        // Lấy phí ship
        const selectShip = document.getElementById("choosewaySelect");
        const selectedShipOption = selectShip.options[selectShip.selectedIndex];
        const fee = parseFloat(selectedShipOption?.getAttribute("data-fee")) || 0;
        document.getElementById("shipFeeDisplay").innerText = fee.toLocaleString() + " VNĐ";

        // Lấy discount từ voucher
        const voucherSelect = document.getElementById("voucherSelect");
        const selectedVoucherIndex = voucherSelect.selectedIndex;
        let discount = 0;

        if (selectedVoucherIndex > 0) {
            const selectedVoucherOption = voucherSelect.options[selectedVoucherIndex];
            discount = parseFloat(selectedVoucherOption.getAttribute("data-discount")) || 0;

            if (discount === 0) {
                discount = fee; // nếu là freeship
            }
            document.getElementById("discountDisplay").innerText = discount.toLocaleString() + " VNĐ";
        } else {
            document.getElementById("discountDisplay").innerText = "";
        }

        // Tính tổng tiền cuối cùng
        const finalTotal = totalProduct + fee - discount;
        document.getElementById("totalDisplay").innerHTML = "<strong>" + finalTotal.toLocaleString() + " VNĐ</strong>";
    }

    function showShipFee() {
        updateTotal();
    }

    function showdiscount() {
        updateTotal();
    }
</script>


    </body>
</html>
