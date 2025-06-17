<%-- 
    Document   : EditVoucher
    Created on : Jun 14, 2025, 1:51:49 PM
    Author     : Window 11
--%>
<%@page import="model.*" %>
<%@page import="dao.*" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Voucher Page</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, sans-serif;
                background-color: #f4f6f9;
                margin: 0;
                padding: 0;
            }

            h1 {
                text-align: center;
                margin-top: 40px;
                font-size: 28px;
                color: #2c3e50;
            }

            form {
                max-width: 600px;
                margin: 40px auto;
                background-color: #fff;
                padding: 30px 40px;
                border-radius: 12px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            }

            table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0 12px;
            }

            td {
                padding: 8px 10px;
                vertical-align: middle;
            }

            td:first-child {
                width: 35%;
                text-align: right;
                font-weight: 600;
                color: #34495e;
            }

            input[type="text"] {
                width: 100%;
                padding: 10px 12px;
                border: 1px solid #ccc;
                border-radius: 8px;
                font-size: 15px;
                transition: 0.3s ease;
            }

            input[type="text"]:focus {
                border-color: #3498db;
                box-shadow: 0 0 6px rgba(52, 152, 219, 0.5);
                outline: none;
            }

            input[type="number"] {
                width: 100%;
                padding: 10px 12px;
                border: 1px solid #ccc;
                border-radius: 8px;
                font-size: 15px;
                transition: 0.3s ease;
            }

            input[type="number"]:focus {
                border-color: #3498db;
                box-shadow: 0 0 6px rgba(52, 152, 219, 0.5);
                outline: none;
            }

            .form-actions {
                text-align: center;
                margin-top: 30px;
            }

            .submit-btn {
                background: #3498db;
                color: #fff;
                border: none;
                padding: 12px 28px;
                font-size: 16px;
                border-radius: 8px;
                cursor: pointer;
                transition: background 0.3s, transform 0.2s;
            }

            .submit-btn:hover {
                background: #2980b9;
                transform: translateY(-2px);
                box-shadow: 0 4px 10px rgba(41, 128, 185, 0.3);
            }

            .submit-btn:active {
                transform: scale(0.96);
            }
        </style>
        <script>
            window.alert = function (message, timeout = null) {
                const alert = document.createElement('div');
                const alertButton = document.createElement('button');
                alertButton.innerHTML = 'OK';
                alert.classList.add('alert');
                alert.setAttribute('style', `
            position: fixed;
            top: 50px;
            left: 50%;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 10px 5px 0 #00000022;
            display: flex;
            flex-direction: column;
            transform: translateX(-50%);
            background-color: #5ced73;
            z-index: 9999;
        `);
                alertButton.setAttribute('style', `
            border: 1px solid #333;
            background: white;
            border-radius: 5px;
            padding: 5px;
            margin-top: 10px;
            cursor: pointer;
        `);
                alert.innerHTML = `<span style="padding: 10px">${mess}</span>`;
                alert.appendChild(alertButton);
                alertButton.addEventListener('click', (e) => {
                    alert.remove();
                });
                if (timeout !== null) {
                    setTimeout(() => {
                        alert.remove();
                    }, Number(timeout));
                }
                document.body.appendChild(alert);
            };
        </script>
    </head>
    <body>
        <% String mess = (String) request.getAttribute("mess"); %>
        <% if (mess != null) { %>
        <script>
        window.alert("<%= mess %>", 3000);
        </script>
        <% } %>
        <a href="${pageContext.request.contextPath}/VoucherList">Trở về</a>
        <h1>Sửa thông tin voucher</h1>
        <form method="post" action="${pageContext.request.contextPath}/EditVoucher">
            <c:set value="${v1}" var="voucher"/>
            <table>
                <tr>
                    <td>VoucherID:</td>
                    <td><input type="number" name="voucherid" value="${voucher.voucherID}" readonly=""/></td>
                </tr>
                <tr>
                    <td>VoucherCode:</td>
                    <td><input type="text" name="vouchercode" value="${voucher.vouchercode}" readonly=""/></td>
                </tr>
                <tr>
                    <td>VoucherType:</td>
                    <td><input type="text" name="vouchertype" value="${voucher.vouchertype}" readonly=""/></td>
                </tr>
                <tr>
                    <td>Discount:</td>
                    <td><input type="number" name="discount" value="${voucher.discount}" readonly=""/></td>
                </tr>
                <tr>
                    <td>Quantity:</td>
                    <td><input type="number" name="quantity" value="${voucher.quantity}" required=""/></td>
                </tr>
            </table>
            <div class="form-actions">
                <input type="submit" value="Sửa" class="submit-btn"/>
            </div>
        </form>
    </body>
</html>
