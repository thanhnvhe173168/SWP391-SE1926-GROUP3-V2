<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Laptop Store - Wishlist</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background-color: #f8f9fa;
                color: #333;
            }
            .wishlist-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }
            .wishlist-header {
                background-color: #007bff;
                color: white;
                padding: 15px;
                border-radius: 10px 10px 0 0;
                margin-bottom: 20px;
            }
            .wishlist-table {
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }
            .wishlist-table th {
                background-color: #007bff;
                color: white;
                padding: 12px;
                text-align: center;
            }
            .wishlist-table td {
                vertical-align: middle;
                padding: 15px;
                border-bottom: 1px solid #dee2e6;
            }
            .wishlist-table img {
                width: 100px;
                height: 100px;
                object-fit: cover;
                border-radius: 5px;
            }
            .btn-custom {
                padding: 5px 15px;
                font-size: 14px;
            }
            .btn-danger {
                background-color: #dc3545;
                border-color: #dc3545;
            }
            .btn-danger:hover {
                background-color: #c82333;
                border-color: #c82333;
            }
            .btn-success {
                background-color: #28a745;
                border-color: #28a745;
            }
            .btn-success:hover {
                background-color: #218838;
                border-color: #218838;
            }
            .empty-wishlist {
                text-align: center;
                padding: 50px;
                color: #666;
            }
            .continue-shopping {
                text-align: center;
                margin-top: 20px;
            }
            .continue-shopping .btn {
                background-color: #6c757d;
                color: white;
            }
            .continue-shopping .btn:hover {
                background-color: #5a6268;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/components/Header.jsp"></jsp:include>

            <div class="wishlist-container">
                <div class="wishlist-header">
                    <h2>Danh sách yêu thích</h2>
                </div>

            <% 
                String mess = (String) session.getAttribute("mess");
                if (mess != null) {
            %>
            <div class="alert alert-info alert-dismissible fade show mt-3" role="alert">
                <%= mess %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% session.removeAttribute("mess"); } %>

            <c:choose>
                <c:when test="${not empty wishList}">
                    <table class="table wishlist-table">
                        <thead>
                            <tr>
                                <th>Hình ảnh</th>
                                <th>Tên sản phẩm</th>
                                <th>Giá</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="w" items="${wishList}">
                                <tr>
                                    <td>
                                        <img src="images/${w.laptop.imageURL}" alt="${w.laptop.laptopName}">
                                    </td>
                                    <td>${w.laptop.laptopName}</td>
                                    <td>${w.laptop.price} VNĐ</td>
                                    <td>
                                        <a href="productDetail?productId=${w.laptop.laptopID}" class="btn btn-primary btn-custom">Xem chi tiết</a>
                                        <button onclick="addtocart(<%=rsLaptop.getInt("LaptopID")%>,<%=rsLaptop.getDouble("Price")%>)" class="btn btn-success btn-custom ms-2">Thêm vào giỏ</button>
                                        <a href="removeWishList?id=${w.wishlistId}" class="btn btn-danger btn-custom ms-2" onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">
                                            <i class="fas fa-trash"></i> Xóa
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-wishlist">
                        <h4>Danh sách yêu thích của bạn đang trống!</h4>
                        <p>Thêm các sản phẩm yêu thích để theo dõi chúng.</p>
                    </div>
                </c:otherwise>
            </c:choose>

            <c:if test="${totalPages > 1}">
                <nav aria-label="Pagination" class="mt-4">
                    <ul class="pagination justify-content-center">
                        <!-- Nút Trước -->
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="wishList?page=${currentPage - 1}">Trước</a>
                        </li>

                        <!-- Trang đầu và dấu ... -->
                        <c:if test="${currentPage > 3}">
                            <li class="page-item"><a class="page-link" href="wishList?page=1">1</a></li>
                            <li class="page-item disabled"><span class="page-link">...</span></li>
                            </c:if>

                        <!-- Các trang gần current -->
                        <c:forEach begin="${currentPage - 2 < 1 ? 1 : currentPage - 2}" 
                                   end="${currentPage + 2 > totalPages ? totalPages : currentPage + 2}" 
                                   var="i">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="wishList?page=${i}">${i}</a>
                            </li>
                        </c:forEach>

                        <!-- Dấu ... và trang cuối -->
                        <c:if test="${currentPage + 2 < totalPages}">
                            <li class="page-item disabled"><span class="page-link">...</span></li>
                            <li class="page-item"><a class="page-link" href="wishList?page=${totalPages}">${totalPages}</a></li>
                            </c:if>

                        <!-- Nút Sau -->
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="wishList?page=${currentPage + 1}">Sau</a>
                        </li>
                    </ul>
                </nav>
            </c:if>

            <div class="continue-shopping">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-lg">Tiếp tục mua sắm</a>
            </div>
        </div>

        <jsp:include page="/components/Footer.jsp"></jsp:include>
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
        </script>
    </body>

</html>