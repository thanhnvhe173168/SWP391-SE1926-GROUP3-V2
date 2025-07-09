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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
            .payment-container {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                min-height: 40px; /* Đảm bảo chiều cao tối thiểu */
            }

            .payment-option {
                min-width: 120px; /* hoặc tuỳ theo bạn muốn chia đều bao nhiêu cột */
                flex: 1;           /* để các option chia đều khoảng trống */
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
        <jsp:include page="/components/Header.jsp"></jsp:include>
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
                    <input type="hidden" name="id" value="${item.getLaptop().getLaptopID()}" />
                    <td><button type="button" onclick="window.location.href = 'LaptopInfo?id=${item.getLaptop().getLaptopID()}'"><img src="images/${item.laptop.imageURL}" width="100" alt="${item.laptop.laptopName}" /></button></td>
                    <td>${item.laptop.laptopName}</td>
                    <td><fmt:formatNumber value="${item.unitPrice}" type="number" groupingUsed="true"/> VNĐ</td>
                    <td>


                        ${item.quantity}


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
                                <option value="${code.vouchercode}" data-discount="${code.discount}" data-voutype="${code.vouchertype}">
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
                        <div class="payment-container">
                            <c:forEach var="meth" items="${listPayment}">
                                <label class="payment-option payment-${meth.paymentMethodID}" style="display: inline-flex; align-items: center; margin-right: 20px; cursor: pointer;">
                                    <input type="radio" name="payment" value="${meth.paymentMethodID}" style="margin-right: 6px;" />
                                    ${meth.methodName}
                                </label>
                            </c:forEach>
                        </div>
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
                <input type="hidden" name="totalprice" value="${finalTotal}" />
                </tr>
                <tr>
                    <td colspan="3"><button type="submit" onclick="orderSuccess()"><strong>Đặt hàng</strong></button></td>
                </tr>
            </table>

        </form>
        <jsp:include page="/components/Footer.jsp"></jsp:include>
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
                // Lấy thông tin voucher
                const voucherSelect = document.getElementById("voucherSelect");
                const selectedVoucherOption = voucherSelect.options[voucherSelect.selectedIndex];
                let discount = 0;
                if (voucherSelect.selectedIndex > 0) {
                    const discountValue = parseFloat(selectedVoucherOption.getAttribute("data-discount")) || 0;
                    const voucherType = selectedVoucherOption.getAttribute("data-voutype");
                    if (voucherType === "Giảm số tiền cố định") {
                        discount = discountValue;
                    } else if (voucherType === "Miễn phí ship") {
                        discount = fee;
                    } else if (voucherType === "Giảm %") {
                        discount = totalProduct * discountValue / 100;
                    }

                    document.getElementById("discountDisplay").innerText = discount.toLocaleString() + " VNĐ";
                } else {
                    document.getElementById("discountDisplay").innerText = "";
                }

                // Tính tổng tiền cuối cùng
                const finalTotal = totalProduct + fee - discount;
                document.getElementById("totalDisplay").innerHTML = "<strong>" + finalTotal.toLocaleString() + " VNĐ</strong>";
                document.querySelector('input[name="totalprice"]').value = finalTotal;
            }

            function showShipFee() {
                updateTotal();

                const selectedWay = document.getElementById("choosewaySelect").value;

                if (selectedWay === '1') {
                    // Nhận tại shop => hiện tất cả
                    document.querySelectorAll('.payment-option').forEach(el => {
                        el.style.visibility = 'visible';
                    });
                } else {
                    // Các cách khác => chỉ hiện Tiền mặt
                    document.querySelectorAll('.payment-option').forEach(el => {
                        el.style.visibility = 'hidden';
                    });
                    document.querySelectorAll('.payment-1').forEach(el => {
                        el.style.visibility = 'visible';
                    });
                }
            }

            function showdiscount() {
                updateTotal();
            }

            function orderSuccess() {
                alert("Đặt hàng thành công!");
                // Tiếp tục xử lý submit ở đây nếu cần
            }

        </script>



    </body>
</html>
