<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Laptop Store - Homepage</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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
            .toast-message {
                position: fixed;
                top: 20px;
                right: 20px;
                background-color: #28a745;
                color: white;
                padding: 12px 20px;
                border-radius: 6px;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
                z-index: 9999;
                animation: fadeOut 5s forwards;
                min-width: 200px;
                max-width: 300px;
                font-size: 14px;
            }

            .close-btn {
                position: absolute;
                top: 5px;
                right: 10px;
                color: white;
                font-weight: bold;
                cursor: pointer;
                font-size: 16px;
            }

            @keyframes fadeOut {
                0% {
                    opacity: 1;
                }
                80% {
                    opacity: 1;
                }
                100% {
                    opacity: 0;
                    display: none;
                }
            }
        </style>


    </head>
    <script>
        function closeToast() {
            var toast = document.getElementById("toastMessage");
            if (toast) {
                toast.style.display = "none";
            }
        }
    </script>
    <body>
        <c:if test="${not empty sessionScope.mess}">
            <div id="toastMessage" class="toast-message">
                <span class="close-btn" onclick="closeToast()">✕</span>
                ${sessionScope.mess}
            </div>
            <c:remove var="mess" scope="session"/>
        </c:if>

        <%
           ResultSet rsBrand = (ResultSet) request.getAttribute("rsBrand");
           ResultSet rsCategory = (ResultSet) request.getAttribute("rsCategory");
           ResultSet rsCPU = (ResultSet) request.getAttribute("rsCPU");
           ResultSet rsScreen = (ResultSet) request.getAttribute("rsScreen");
           ResultSet rsLaptop = (ResultSet) request.getAttribute("rsLaptop");
           ResultSet rsBlog = (ResultSet) request.getAttribute("rsBlog");
        %>
        <jsp:include page="/components/Header.jsp"></jsp:include>
            <div class="container my-5">
                <div class="row mb-4">
                    <div class="col-md-3">
                        <select name="brandId" id="brandId" style="width: 100%" onchange="handleRedirectProduct('brandId', this.value)">
                            <option value="0">Brand</option>
                        <%while(rsBrand.next()) {%>
                        <option value="<%=rsBrand.getInt("BrandID")%>">
                            <%=rsBrand.getString("BrandName")%>
                        </option>
                        <%}%>
                    </select>
                </div>
                <div class="col-md-3">
                    <select name="categoryId" id="categoryId" style="width: 100%" onchange="handleRedirectProduct('categoryId', this.value)">
                        <option value="0">Categories</option>
                        <%while(rsCategory.next()) {%>
                        <option
                            value="<%=rsCategory.getInt("CategoryID")%>"
                            >
                            <%=rsCategory.getString("CategoryName")%>
                        </option>
                        <%}%>
                    </select>
                </div>
                <div class="col-md-3">
                    <select name="cpuId" id="cpuId" style="width: 100%" onchange="handleRedirectProduct('cpuId', this.value)">
                        <option value="0">CPU</option>
                        <%while(rsCPU.next()) {%>
                        <option 
                            value="<%=rsCPU.getInt("CPUID")%>"
                            >
                            <%=rsCPU.getString("CPUInfo")%>
                        </option>
                        <%}%>
                    </select>
                </div>
                <div class="col-md-3">
                    <select name="screenId" id="screenId" style="width: 100%" onchange="handleRedirectProduct('screenId', this.value)">
                        <option value="0">Screen</option>
                        <%while(rsScreen.next()) {%>
                        <option 
                            value="<%=rsScreen.getInt("ScreenID")%>"
                            >
                            <%=rsScreen.getString("Size")%>
                        </option>
                        <%}%>
                    </select>
                </div>
            </div>
            <h1 class="text-center mb-4">Laptop</h1>
            <div class="row row-cols-1 row-cols-md-3 g-4">
                <%while(rsLaptop.next()) {%>
                <div class="col">
                    <div class="card laptop-card">
                        <img src="images/<%=rsLaptop.getString("ImageURL")%>" class="card-img-top laptop-image" alt="Dell XPS 133456246524">
                        <div class="card-body">
                            <h5 class="card-title"><%=rsLaptop.getString("LaptopName")%></h5>
                            <p class="card-text"><%=rsLaptop.getString("Size")%>, <%=rsLaptop.getString("CPUInfo")%>, <%=rsLaptop.getString("RAM")%>, <%=rsLaptop.getString("HardDrive")%></p>
                            <p class="card-text fw-bold"><%=rsLaptop.getInt("Price")%></p>
                            <a href="productDetail?productId=<%=rsLaptop.getInt("LaptopID")%>" class="btn btn-primary">View Details</a>
                            <button class="btn btn-success ms-2" onclick="addtocart(<%=rsLaptop.getInt("LaptopID")%>)">
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
            <div class="d-flex justify-content-center">
                <button type="button" class="btn btn-outline-primary" onclick="handleRedirectProduct()">Xem thêm</button>
            </div>
            <h1 class="text-center mb-4" style="margin-top: 40px">Blog</h1>
            <div class="row row-cols-1 row-cols-md-3 g-4">
                <%while(rsBlog.next()) {%>
                <div class="col">
                    <div class="card laptop-card">
                        <img src="images/<%=rsBlog.getString("Avatar")%>" class="card-img-top laptop-image" alt="Dell XPS 133456246524">
                        <div class="card-body">
                            <h5 class="card-title"><%=rsBlog.getString("Title")%></h5>
                            <a href="blogDetail?blogId=<%=rsBlog.getInt("BlogID")%>" class="btn btn-primary">View Details</a>
                        </div>
                    </div>
                </div>
                <%}%>
            </div> 
            <div class="d-flex justify-content-center">
                <button type="button" class="btn btn-outline-primary" onclick="handleRedirectBlog()">Xem thêm</button>
            </div>
        </div>
        <jsp:include page="/components/Footer.jsp"></jsp:include>
        <script>

            function handleRedirectProduct(key, value) {
                if (key && value) {
                    window.location.href = "productList?" + key + "=" + value;
                } else {
                    window.location.href = "productList";
                }
            }

            function handleRedirectBlog() {
                window.location.href = "blogList";
            }

            function addToWishlist(laptopId) {
                window.location.href = '/swp391/addToWishList?id=' + laptopId;
            }

            function addtocart(laptopid) {
                fetch('AddToCart?id=' + encodeURIComponent(laptopid))
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
