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
        <%
        String mess = (String) request.getAttribute("mess");
        String icon = (String) request.getAttribute("icon");
        if (mess != null && icon != null) {
        %>
        <script>
            window.alert("<%= mess %>", 3000);
            Swal.fire({
                icon: '<%= icon %>',
                title: '<%= mess %>',
                showConfirmButton: false,
                timer: 2000
            });
        </script>
        <%
            }
        %>


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
                        <img src="<%=rsLaptop.getString("ImageURL")%>" class="card-img-top laptop-image" alt="Dell XPS 133456246524">
                        <div class="card-body">
                            <h5 class="card-title"><%=rsLaptop.getString("LaptopName")%></h5>
                            <p class="card-text"><%=rsLaptop.getString("Size")%>, <%=rsLaptop.getString("CPUInfo")%>, <%=rsLaptop.getString("RAM")%>, <%=rsLaptop.getString("HardDrive")%></p>
                            <p class="card-text fw-bold"><%=rsLaptop.getInt("Price")%></p>
                            <a href="productDetail?productId=<%=rsLaptop.getInt("LaptopID")%>" class="btn btn-primary">View Details</a>
                            <button class="btn btn-success ms-2" onclick="window.location.href = 'AddToCart?id=<%=rsLaptop.getInt("LaptopID")%>'">
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
                        <img src="<%=rsBlog.getString("Avatar")%>" class="card-img-top laptop-image" alt="Dell XPS 133456246524">
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

        </script>
    </body>
</html>
