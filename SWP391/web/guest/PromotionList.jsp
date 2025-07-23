<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Promotion List</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .promotion-card {
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 30px 10px;
                text-align: center;
                background-color: #fff;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            .promotion-card img {
                width: 220px;
                height: 220px;
                margin: 0 auto 10px;
                background-color: #e9ecef;
                border-radius: 50%;
            }
            .btn-view {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 8px 10px;
                border-radius: 5px;
                text-decoration: none;
            }
            .btn-view:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <%
               ResultSet rsPromotion = (ResultSet) request.getAttribute("rsPromotion");
        %>
        <jsp:include page="/components/Header.jsp"></jsp:include>
            <div class="container my-5">
                <h1 class="text-center mb-4">Chương trình khuyến mãi</h1>
                <div class="row row-cols-1 row-cols-md-3 g-4">
                <%if(rsPromotion != null) {
                while(rsPromotion.next()) {%>
                <div class="col">
                    <div class="promotion-card">
                        <img src="<%=rsPromotion.getString("Image")%>" alt="Promotion Image">
                        <h5><%=rsPromotion.getString("Title")%></h5>
                        <p style="margin-bottom: 4px">Từ ngày: <%=rsPromotion.getString("StartDate")%></p>
                        <p>Đến ngày: <%=rsPromotion.getString("EndDate")%></p>
                        <a href="promotionDetail?promotionId=<%=rsPromotion.getInt("ID")%>" class="btn-view">View Detail</a>
                    </div>
                </div>
                <%}
}%>
            </div>
        </div>
        <jsp:include page="/components/Footer.jsp"></jsp:include>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>