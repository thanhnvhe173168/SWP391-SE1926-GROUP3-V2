<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Laptop Store - Wishlist</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
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

            <%
                ResultSet rsWishlist = (ResultSet) request.getAttribute("rsWishlist");
                boolean hasData = false;
                if (rsWishlist != null && rsWishlist.next()) {
                    hasData = true;
            %>
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
                    <%
                        do {
                    %>
                    <tr>
                        <td><img src="images/<%= rsWishlist.getString("ImageURL") %>" alt="<%= rsWishlist.getString("LaptopName") %>"></td>
                        <td><%= rsWishlist.getString("LaptopName") %></td>
                        <td><%= rsWishlist.getInt("Price") %> VNĐ</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/productDetail?productId=<%= rsWishlist.getInt("LaptopID") %>" class="btn btn-primary btn-custom">Xem chi tiết</a>
                            <a href="${pageContext.request.contextPath}/AddToCart?id=<%= rsWishlist.getInt("LaptopID") %>" class="btn btn-success btn-custom ms-2">Thêm vào giỏ</a>
                            <a href="${pageContext.request.contextPath}/removeWishList?id=<%= rsWishlist.getInt("WishlistID") %>" class="btn btn-danger btn-custom ms-2" onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">
                                <i class="fas fa-trash"></i> Xóa
                            </a>
                        </td>
                    </tr>
                    <%
                        } while (rsWishlist.next());
                    %>
                </tbody>
            </table>
            <% } else { %>
            <div class="empty-wishlist">
                <h4>Danh sách yêu thích của bạn đang trống!</h4>
                <p>Thêm các sản phẩm yêu thích để theo dõi chúng.</p>
            </div>
            <% } %>

            <div class="continue-shopping">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-lg">Tiếp tục mua sắm</a>
            </div>
        </div>

        <jsp:include page="/components/Footer.jsp"></jsp:include>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>