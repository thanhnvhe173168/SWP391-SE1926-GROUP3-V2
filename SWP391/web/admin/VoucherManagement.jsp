<%-- 
    Document   : VoucherManagement
    Created on : Jun 5, 2025, 5:17:32 PM
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
        <title>JSP Page</title>
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
    </head>
    <body>
        <h1>Quản lý voucher</h1>
        <c:set value="${voucherlist}" var="voulist"/>
        <c:choose>
            <c:when test="${empty voulist}">
                <p>Danh sách voucher trống</p>
            </c:when>
            <c:otherwise>
                <table border="1">
                    <tr>
                        <th>Voucher ID</th>
                        <th>Voucher Code</th>
                        <th>Voucher Type</th>
                        <th>Discount</th>
                        <th>Quantity</th>
                        <th colspan="2">Action</th>
                    </tr>
                    <c:forEach items="${voulist}" var="voucher">
                        <tr>
                            <td>${voucher.voucherID}</td>
                            <td>${voucher.vouchercode}</td>
                            <td>${voucher.vouchertype}</td>
                            <td>${voucher.discount}</td>
                            <td>${voucher.quantity}</td>

                            <td colspan="1"><button>Sửa</button></td>
                            <td colspan="1"><button>Xóa</button></td>

                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </table>
        <button onclick="window.location.href = 'admin/AddVoucher.jsp'">Thêm voucher</button>
        
    </body>
</html>
