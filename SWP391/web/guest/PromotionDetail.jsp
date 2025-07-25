<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi Tiết khuyến mãi</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            .product-container {
                background-color: #fff;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
            }
            .product-image img {
                width: 100%;
                border-radius: 10px;
            }
            .product-specs {
                margin-top: 20px;
            }
            .product-price {
                font-size: 18px;
                color: #dc3545;
                margin: 10px 0;
            }
            .discount-price {
                text-decoration: line-through;
                color: #6c757d;
                margin-right: 10px;
            }
            .student-price {
                background-color: #28a745;
                color: white;
                padding: 5px 10px;
                border-radius: 5px;
                display: inline-block;
            }
            .rating {
                color: #ffc107;
                margin-right: 10px;
            }
            .like-btn {
                color: #dc3545;
                border: none;
                background: none;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <%
                   ResultSet rsLaptop = (ResultSet) request.getAttribute("rsLaptop");
        %>
        <jsp:include page="/components/Header.jsp"></jsp:include>
            <div class="container my-5">
                <img style="width: 100%; margin-bottom: 20px" src="https://cdn2.cellphones.com.vn/insecure/rs:fill:0:0/q:100/plain/https://cellphones.com.vn/media/wysiwyg/hotdeal.png" />
                <div class="row row-cols-1 row-cols-md-3 g-4">
                <%if(rsLaptop != null) {
                while(rsLaptop.next()) {%>
                <div class="col">
                    <div class="product-container">
                        <div class="product-image">
                            <img src="images/<%=rsLaptop.getString("ImageURL")%>" alt="Product Image">
                        </div>
                        <div class="product-specs">
                            <h4><%=rsLaptop.getString("LaptopName")%></h4>
                            <p><%=rsLaptop.getString("HardDrive")%> <%=rsLaptop.getString("RAM")%></p>
                            <div class="product-price">
                                <span class="discount-price"><%=String.format("%,.0f VNĐ", rsLaptop.getDouble("Price"))%></span>
                                <span><%=String.format("%,.0f VNĐ", rsLaptop.getDouble("DiscountPrice"))%></span>
                            </div>
                        </div>  
                        <button class="btn btn-success ms-2" onclick="addtocart(<%=rsLaptop.getInt("LaptopID")%>,<%=rsLaptop.getDouble("DiscountPrice")%>)">
                            Add to Cart
                        </button> 
                        <button class="btn btn-outline-danger ms-2" onclick="addToWishlist(<%=rsLaptop.getInt("LaptopID")%>)">
                            <i class="fas fa-heart"></i>
                        </button>    
                    </div>        
                </div>
                <%}
}%>
            </div>
        </div>
        <jsp:include page="/components/Footer.jsp"></jsp:include>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <script>
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

                            function addToWishlist(laptopId) {
                                window.location.href = '/swp391/addToWishList?id=' + laptopId;
                            }
        </script>
    </body>
</html>