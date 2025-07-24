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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
            .filter-select {
                width: 100%; /* Độ rộng cố định cho mỗi dropdown */
                padding: 10px 15px;
                border: 2px solid #e0e0e0;
                border-radius: 8px; /* Bo góc */
                font-size: 16px;
                background-color: #ffffff;
                appearance: none; /* Xóa style mặc định của select */
                cursor: pointer;
                transition: all 0.3s ease;
                background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' fill='%23333' viewBox='0 0 16 16'%3E%3Cpath d='M7 10l5-5-1.5-1.5L7 7 2.5 2.5 1 4l5 5z'/%3E%3C/svg%3E");
                background-repeat: no-repeat;
                background-position: right 10px center;
            }

            .filter-select:hover {
                border-color: #007bff; /* Màu viền khi hover */
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Hiệu ứng bóng */
            }

            .filter-select:focus {
                outline: none;
                border-color: #007bff;
                box-shadow: 0 0 5px rgba(0, 123, 255, 0.5); /* Hiệu ứng focus */
            }
        </style>
    </head>
    <body>
        <% String mess = (String) request.getAttribute("mess"); %>
        <% if (mess != null) { %>
        <script>
            window.alert("<%= mess %>", 3000);
        </script>
        <% } %>
        <%
           ResultSet rsBrand = (ResultSet) request.getAttribute("rsBrand");
           ResultSet rsCategory = (ResultSet) request.getAttribute("rsCategory");
           ResultSet rsCPU = (ResultSet) request.getAttribute("rsCPU");
           ResultSet rsScreen = (ResultSet) request.getAttribute("rsScreen");
           ResultSet rsLaptop = (ResultSet) request.getAttribute("rsLaptop");
           int currentPage = (int) request.getAttribute("currentPage");
           int totalPage = (int) request.getAttribute("totalPage");
        %>
        <jsp:include page="/components/Header.jsp"></jsp:include>
            <div class="container my-5">
                <div class="row mb-4">
                    <div class="col-md-3">
                        <select name="brandId" id="brandId" class="filter-select" onchange="handleFilter('brandId', this.value)">
                            <option value="0" <%="0".equals(request.getParameter("brandId")) ? "selected" : "" %>>Nhãn hiệu</option>
                        <%while(rsBrand.next()) {%>
                        <option 
                            value="<%=rsBrand.getInt("BrandID")%>"
                            <%=(request.getParameter("brandId") != null && request.getParameter("brandId").equals(String.valueOf(rsBrand.getInt("BrandID")))) ? "selected" : "" %>
                            >
                            <%=rsBrand.getString("BrandName")%>
                        </option>
                        <%}%>
                    </select>
                </div>
                <div class="col-md-3">
                    <select name="categoryId" id="categoryId" class="filter-select" style="width: 100%" onchange="handleFilter('categoryId', this.value)">
                        <option value="0" <%="0".equals(request.getParameter("categoryId")) ? "selected" : "" %>>Loại laptop</option>
                        <%while(rsCategory.next()) {%>
                        <option
                            value="<%=rsCategory.getInt("CategoryID")%>"
                            <%=(request.getParameter("categoryId") != null && request.getParameter("categoryId").equals(String.valueOf(rsCategory.getInt("CategoryID")))) ? "selected" : "" %>
                            >
                            <%=rsCategory.getString("CategoryName")%>
                        </option>
                        <%}%>
                    </select>
                </div>
                <div class="col-md-3">
                    <select name="cpuId" id="cpuId" class="filter-select" onchange="handleFilter('cpuId', this.value)">
                        <option value="0" <%="0".equals(request.getParameter("cpuId")) ? "selected" : "" %>>CPU</option>
                        <%while(rsCPU.next()) {%>
                        <option 
                            value="<%=rsCPU.getInt("CPUID")%>"
                            <%=(request.getParameter("cpuId") != null && request.getParameter("cpuId").equals(String.valueOf(rsCPU.getInt("CPUID")))) ? "selected" : "" %>
                            >
                            <%=rsCPU.getString("CPUInfo")%>
                        </option>
                        <%}%>
                    </select>
                </div>
                <div class="col-md-3">
                    <select name="screenId" id="screenId" class="filter-select" onchange="handleFilter('screenId', this.value)">
                        <option value="0" <%="0".equals(request.getParameter("screenId")) ? "selected" : "" %>>Màn hình</option>
                        <%while(rsScreen.next()) {%>
                        <option 
                            value="<%=rsScreen.getInt("ScreenID")%>"
                            <%=(request.getParameter("screenId") != null && request.getParameter("screenId").equals(String.valueOf(rsScreen.getInt("ScreenID")))) ? "selected" : "" %>
                            >
                            <%=rsScreen.getString("Size")%>
                        </option>
                        <%}%>
                    </select>
                </div>
            </div>
            <div class="row row-cols-1 row-cols-md-3 g-4">
                <%while(rsLaptop.next()) {%>
                <div class="col">
                    <div class="card laptop-card">
                        <img src="images/<%=rsLaptop.getString("ImageURL")%>" class="card-img-top laptop-image" alt="Dell XPS 133456246524">
                        <div class="card-body">
                            <h5 class="card-title"><%=rsLaptop.getString("LaptopName")%></h5>
                            <p class="card-text"><%=rsLaptop.getString("Size")%>, <%=rsLaptop.getString("CPUInfo")%>, <%=rsLaptop.getString("RAM")%>, <%=rsLaptop.getString("HardDrive")%></p>
                            <p class="card-text fw-bold"><%=String.format("%,.0f VNĐ", rsLaptop.getDouble("Price"))%></p>
                            <a href="productDetail?productId=<%=rsLaptop.getInt("LaptopID")%>" class="btn btn-primary">View Details</a>
                            <button class="btn btn-success ms-2" onclick="addtocart(<%=rsLaptop.getInt("LaptopID")%>, <%=rsLaptop.getDouble("Price")%>)">
                                Add to Cart
                            </button> 
                            <button class="btn btn-outline-danger ms-2" onclick="addToWishlist(<%=rsLaptop.getInt("LaptopID")%>)">
                                <i class="fas fa-heart"></i>
                            </button>    
                        </div>
                    </div>
                </div>
                <%}%>
            </div>
            <nav aria-label="Page navigation example" class="mt-4">
                <ul class="pagination justify-content-center">
                    <li
                        class="page-item <%=currentPage == 1 ? "disabled" : ""%>"
                        onclick="handleFilter('currentPage', <%=currentPage-1%>)"
                        style="cursor: pointer"
                        >
                        <a class="page-link">Previous</a>
                    </li>
                    <%for (int i = 1; i <= totalPage; i++) {%>
                    <li 
                        class="page-item <%=i == currentPage ? "active" : ""%>" 
                        onclick="handleFilter('currentPage', <%=i%>)"
                        style="cursor: pointer"
                        >
                        <a class="page-link"><%=i%></a>
                    </li>
                    <%}%>
                    <li 
                        class="page-item <%=currentPage == totalPage ? "disabled" : ""%>"
                        onclick="handleFilter('currentPage', <%=currentPage+1%>)"
                        style="cursor: pointer"
                        >
                        <a class="page-link">Next</a>
                    </li>
                </ul>
            </nav>
        </div>
        <jsp:include page="/components/Footer.jsp"></jsp:include>
            <script>
                const params = new URLSearchParams(window.location.search);
                const totalPage = <%=totalPage%>;

                function handleRedirect() {
                    window.location.href = "createLaptop";
                }

                function handleFilter(key, value) {
                    var intValue = +value;
                    if (key === 'currentPage') {
                        if (intValue < 1)
                            return;
                        if (intValue > totalPage)
                            return;
                    }
                    if (intValue === 0) {
                        params.delete(key);
                    } else {
                        if (params.get(key)) {
                            params.set(key, value);
                        } else {
                            params.append(key, value);
                        }
                    }
                    window.location.href = "productList?" + params.toString();
                }
                function addToWishlist(laptopId) {
                    window.location.href = '/swp391/addToWishList?id=' + laptopId;
                }

                function addtocart(laptopid, price) {
                    const url = 'AddToCart?id=' + encodeURIComponent(laptopid) + '&price=' + encodeURIComponent(price);
                    fetch(url)
                            .then(res => res.json())
                            .then(data => {
                                Swal.fire({
                                    icon: data.icon,
                                    title: data.mess,
                                    showConfirmButton: false,
                                    timer: 2000
                                });
                            })
                            .catch(error => {
                                console.error('Lỗi:', error);
                            });
                }

        </script>
    </body>
</html>
