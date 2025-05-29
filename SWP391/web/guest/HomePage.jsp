<%-- 
    Document   : HomePage
    Created on : May 24, 2025, 11:21:28 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Laptop Store - Homepage</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            .laptop-card {
                transition: transform 0.2s;
            }
            .laptop-card:hover {
                transform: scale(1.05);
            }
            .laptop-image {
                height: 200px;
                object-fit: cover;
            }
        </style>
    </head>
    <body>
        <%
           ResultSet rsBrand = (ResultSet) request.getAttribute("rsBrand");
           ResultSet rsCategory = (ResultSet) request.getAttribute("rsCategory");
           ResultSet rsCPU = (ResultSet) request.getAttribute("rsCPU");
           ResultSet rsScreen = (ResultSet) request.getAttribute("rsScreen");
           ResultSet rsLaptop = (ResultSet) request.getAttribute("rsLaptop");
        %>
        <jsp:include page="/components/Header.jsp"></jsp:include>
            <div class="container my-5">
                <div class="row mb-4">
                    <div class="col-md-3">
                        <select name="brandId" id="brandId" style="width: 100%">
                        <%while(rsBrand.next()) {%>
                        <option value="<%=rsBrand.getInt("BrandID")%>"><%=rsBrand.getString("BrandName")%></option>
                        <%}%>
                    </select>
                </div>
                <div class="col-md-3">
                    <select name="categoryId" id="categoryId" style="width: 100%">
                        <%while(rsCategory.next()) {%>
                        <option value="<%=rsCategory.getInt("CategoryID")%>"><%=rsCategory.getString("CategoryName")%></option>
                        <%}%>
                    </select>
                </div>
                <div class="col-md-3">
                    <select name="cpuId" id="cpuId" style="width: 100%">
                        <%while(rsCPU.next()) {%>
                        <option value="<%=rsCPU.getInt("CPUID")%>"><%=rsCPU.getString("CPUInfo")%></option>
                        <%}%>
                    </select>
                </div>
                <div class="col-md-3">
                    <select name="screenId" id="screenId" style="width: 100%">
                        <%while(rsScreen.next()) {%>
                        <option value="<%=rsScreen.getInt("ScreenID")%>"><%=rsScreen.getString("Size")%></option>
                        <%}%>
                    </select>
                </div>
            </div>
            <h1 class="text-center mb-4">Our Laptops</h1>
            <div class="row row-cols-1 row-cols-md-3 g-4">
                <%while(rsLaptop.next()) {%>
                <div class="col">
                    <div class="card laptop-card">
                        <img src="<%=rsLaptop.getString("ImageURL")%>" class="card-img-top laptop-image" alt="Dell XPS 133456246524">
                        <div class="card-body">
                            <h5 class="card-title"><%=rsLaptop.getString("LaptopName")%></h5>
                            <p class="card-text"><%=rsLaptop.getString("Size")%>, <%=rsLaptop.getString("CPUInfo")%>, <%=rsLaptop.getString("RAM")%>, <%=rsLaptop.getString("HardDrive")%></p>
                            <p class="card-text fw-bold"><%=rsLaptop.getInt("Price")%></p>
                            <a href="product.jsp?id=1" class="btn btn-primary">View Details</a>
                        </div>
                    </div>
                </div>
                <%}%>
            </div>
        </div>
        <jsp:include page="/components/Footer.jsp"></jsp:include>
    </body>
</html>
