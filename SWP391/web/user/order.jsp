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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                background-color: #f6f6f6;
                color: #212121;
                margin: 0;
                padding: 20px;
            }

            h1 {
                text-align: center;
                color: #d70018;
                margin-bottom: 30px;
                font-weight: 700;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background: #ffffff;
                margin-bottom: 25px;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            }

            table th, table td {
                padding: 14px 16px;
                border-bottom: 1px solid #eee;
                text-align: center;
                font-size: 15px;
            }

            table th {
                background-color: #d70018;
                color: white;
                font-weight: 600;
            }

            .order-details {
                width: 65%;
                margin: 0 auto 30px auto;
                background: #fff;
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                padding: 20px;
            }

            .order-details td {
                padding: 12px 10px;
                border-bottom: 1px solid #f1f1f1;
                font-weight: 500;
            }

            .order-details input,
            .order-details select,
            .order-details textarea {
                width: 100%;
                padding: 10px;
                font-size: 14px;
                border: 1px solid #ccc;
                border-radius: 6px;
                transition: border-color 0.3s;
            }

            .order-details input:focus,
            .order-details select:focus,
            .order-details textarea:focus {
                border-color: #d70018;
                outline: none;
                box-shadow: 0 0 4px rgba(215, 0, 24, 0.3);
            }

            .order-details input[type="radio"] {
                transform: scale(1.1);
                margin-right: 8px;
                cursor: pointer;
            }

            .order-details label {
                display: block;
                margin-bottom: 6px;
                font-weight: 500;
                color: #333;
            }

            button {
                background-color: #d70018;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 6px;
                cursor: pointer;
                font-weight: 600;
                transition: background-color 0.3s ease;
            }

            button:hover {
                background-color: #b40015;
            }

            #shipFeeDisplay {
                font-weight: bold;
                color: #d70018;
                font-size: 16px;
            }

            .total-row td {
                font-weight: bold;
                font-size: 16px;
                background-color: #ffecec;
                color: #d70018;
            }

            .payment-container {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                margin-top: 10px;
            }

            .payment-option {
                flex: 1;
                min-width: 150px;
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
            <c:set var="listorderings" value="${sessionScope.listordering}" />
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
                    <td><img src="images/${item.laptop.imageURL}" width="100" alt="${item.laptop.laptopName}" /></td>
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
