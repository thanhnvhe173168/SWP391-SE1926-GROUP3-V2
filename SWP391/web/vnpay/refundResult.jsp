<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.DecimalFormat" %>

<%
    // Lấy kết quả hoàn tiền từ servlet (JSON String)
    String refundJson = (String) request.getAttribute("refundResult");

    // Parse JSON
    JSONObject refundResult = new JSONObject(refundJson);

    // Lấy các field cần hiển thị
    String vnp_ResponseCode = refundResult.optString("vnp_ResponseCode");
    String vnp_TransactionNo = refundResult.optString("vnp_TransactionNo");
    String vnp_TxnRef = refundResult.optString("vnp_TxnRef");
    String vnp_Amount = refundResult.optString("vnp_Amount");
    String vnp_TransactionType = refundResult.optString("vnp_TransactionType");
    String vnp_CreateDate = refundResult.optString("vnp_PayDate");
    String vnp_TransactionStatus = refundResult.optString("vnp_TransactionStatus");
    BigDecimal amountRaw = new BigDecimal(vnp_Amount);
    BigDecimal amountVND = amountRaw.divide(BigDecimal.valueOf(100));
    
    DecimalFormat df = new DecimalFormat("#,###");
    String formattedAmount = df.format(amountVND) + " VNĐ";
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Kết Quả Hoàn Tiền</title>
        <!-- Bootstrap -->
        <link href="/swp391/assets/bootstrap.min.css" rel="stylesheet"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </head>
    <body class="bg-light">

        <div class="container py-5">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">KẾT QUẢ HOÀN TIỀN VNPAY</h4>
                </div>
                <form action="UpdateRefund" method="post">
                    <div class="card-body">
                        <input type="hidden" name="vnp_TransactionStatus" value="<%= vnp_TransactionStatus %>">
                        <input type="hidden" name="vnp_CreateDate" value="<%= vnp_CreateDate %>">
                        <input type="hidden" name="vnp_TxnRef" value="<%= vnp_TxnRef %>">
                        <input type="hidden" name="vnp_TransactionNo" value="<%= vnp_TransactionNo %>">
                        <input type="hidden" name="vnp_Amount" value="<%= amountVND %>">
                        <input type="hidden" name="vnp_TransactionType" value="<%= vnp_TransactionType %>">
                        <input type="hidden" name="vnp_ResponseCode" value="<%= vnp_ResponseCode %>">
                        <div class="mb-3">
                            <strong>Mã giao dịch gốc :</strong>
                            <span class="text-primary"><%= vnp_TxnRef %></span>
                        </div>

                        <div class="mb-3">
                            <strong>Mã giao dịch tại VNPAY:</strong>
                            <span class="text-primary"><%= vnp_TransactionNo %></span>
                        </div>

                        <div class="mb-3">
                            <strong>Số tiền hoàn:</strong>
                            <span class="text-primary"><%= formattedAmount %></span>
                        </div>

                        <div class="mb-3">
                            <strong>Loại hoàn tiền:</strong>
                            <span><%= vnp_TransactionType.equals("02") ? "Hoàn toàn phần" : "Hoàn một phần" %></span>
                        </div>
                        <div class="alert
                             <%= "00".equals(vnp_ResponseCode) ? "alert-success" : "alert-danger" %>">
                            <strong>
                                <%= "00".equals(vnp_ResponseCode) ? "Hoàn tiền thành công!" : "Hoàn tiền thất bại!" %>
                            </strong>
                        </div>

                        <button type="submit" class="btn btn-primary">
                            Quay lại danh sách đơn hàng
                        </button>
                    </div>
                </form>
                <div class="card-footer text-muted text-center">
                    &copy; VNPAY Refund - <%= new java.util.Date() %>
                </div>
            </div>
        </div>
    </body>
</html>

