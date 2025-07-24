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
                font-family: 'Segoe UI', Roboto, Arial, sans-serif;
                background-color: #f5f5f5;
                color: #212529;
            }

            .wishlist-container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }

            .wishlist-header {
                background-color: #d70018;
                color: white;
                padding: 18px 25px;
                border-radius: 4px;
                font-weight: bold;
                font-size: 20px;
                margin-bottom: 20px;
            }

            .wishlist-table {
                background-color: white;
                border-radius: 6px;
                box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1);
            }

            .wishlist-table th {
                background-color: #d70018;
                color: white;
                text-align: center;
                padding: 14px;
                font-weight: 500;
                font-size: 15px;
            }

            .wishlist-table td {
                vertical-align: middle;
                padding: 16px;
                border-bottom: 1px solid #eee;
                font-size: 15px;
            }

            .wishlist-table img {
                width: 90px;
                height: 90px;
                object-fit: cover;
                border-radius: 4px;
                border: 1px solid #ddd;
            }

            .btn-custom {
                padding: 6px 16px;
                font-size: 14px;
                border-radius: 4px;
                font-weight: 500;
            }

            .btn-danger {
                background-color: #dc3545;
                border-color: #dc3545;
            }

            .btn-danger:hover {
                background-color: #b52a37;
                border-color: #b52a37;
            }

            .btn-success {
                background-color: #28a745;
                border-color: #28a745;
            }

            .btn-success:hover {
                background-color: #218838;
                border-color: #218838;
            }

            .btn-primary {
                background-color: #d70018;
                border-color: #d70018;
            }

            .btn-primary:hover {
                background-color: #bb0015;
                border-color: #bb0015;
            }

            .empty-wishlist {
                text-align: center;
                padding: 60px 30px;
                color: #777;
                font-size: 17px;
            }

            .continue-shopping {
                display: flex;
                justify-content: center; 
                margin-top: 30px;
            }

            .continue-shopping .btn {
                background-color: #007bff; 
                color: white;
                padding: 10px 25px;
                font-size: 16px;
                border-radius: 4px;
                transition: background-color 0.3s;
                font-weight: 500;
                border: none;
                text-decoration: none;
            }

            .continue-shopping .btn:hover {
                background-color: #0056b3;
            }
            .pagination .page-link {
                color: #d70018;
                font-weight: 500;
                border-radius: 4px !important;
            }

            .pagination .page-item.active .page-link {
                background-color: #d70018;
                border-color: #d70018;
                color: white;
            }

            .pagination .page-item.disabled .page-link {
                color: #ccc;
            }

            .alert-info {
                background-color: #e6f0ff;
                color: #004085;
                border-color: #b8daff;
                font-size: 15px;
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
                                        <button onclick="addtocart(${laptop.laptopID}, ${laptop.price})" class="btn btn-success btn-custom ms-2">Thêm vào giỏ</button>
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