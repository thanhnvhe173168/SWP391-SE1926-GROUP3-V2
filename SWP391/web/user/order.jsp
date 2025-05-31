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
                    <td>  
                        <select name="chooseway" id="choosewaySelect" onchange="showShipFee()">
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
                        <select name="voucher">
                            <c:forEach var="code" items="${listvoucher}">
                                <option>${code.vouchercode}</option>
                            </c:forEach>
                        </select>
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
                    <td id="shipFeeDisplay">0 VNĐ</td>
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
            function showShipFee() {
                const select = document.getElementById("choosewaySelect");
                const selectedOption = select.options[select.selectedIndex];
                const fee = selectedOption.getAttribute("data-fee");

                const feeDisplay = document.getElementById("shipFeeDisplay");
                feeDisplay.innerText = parseFloat(fee).toLocaleString()+" VNĐ";

            }
        </script>
    </body>
</html>
