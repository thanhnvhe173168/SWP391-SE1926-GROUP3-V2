<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Refund</title>
        <!-- Bootstrap core CSS -->
        <link href="/swp391/assets/bootstrap.min.css" rel="stylesheet"/>
        <!-- Custom styles for this template -->   
        <script src="/swp391/assets/jquery-1.11.3.min.js"></script>
    </head>

    <body>
        <%
        User user = (User)session.getAttribute("user");
        %>
        
        <c:set var="payment" value="${p}"></c:set>
            <div class="container">
                <div class="header clearfix">

                    <h3 class="text-muted">VNPAY DEMO</h3>
                </div>
                <h3>Refund</h3>
                <div class="table-responsive">
                    <form action="vnpayRefund" id="frmrefund" method="Post">
                        <div class="form-group">
                            <label for="order_id">Mã giao dịch cần hoàn</label>
                            <input class="form-control" id="order_id"
                                   name="order_id" type="text" value="${orderid}"/>
                    </div>
                    <div>
                        <input name="TranNo" value="${payment.transactionNo}" type="hidden"/>
                    </div>
                    <fmt:formatNumber value="${payment.amount}" type="number" groupingUsed="true" var="payamount"/>
                    <div class="form-group">
                        <label for=<"amount">Số tiền hoàn</label>
                        <input name="amount" class="form-control" type="text" value="${payamount} VNĐ"/>             
                    </div>
                    <div class="form-group">
                        <label for="trantype">Kiểu hoàn tiền</label>
                        <select name="trantype" id="trantype" class="form-control">
                            <option value="02">Hoàn tiền toàn phần</option>
                            <option value="03">Hoàn tiền một phần</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="trans_date">Thời gian khởi tạo giao dịch</label>
                        <input class="form-control" id="trans_date"
                               name="trans_date" type="text" value="${payDate}"/>
                    </div>
                    <div class="form-group">
                        <label for="user">User khởi tạo hoàn</label>
                        <input class="form-control" id="user"
                               name="user" type="text" value="${user.fullName}"/>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">Refund</button>
                    </div>
                </form>   
                <p>
                    &nbsp;
                </p>
                <footer class="footer">
                    <p>&copy; VNPAY 2020</p>
                </footer>
            </div> 
        </div>
    </body>
</html>
