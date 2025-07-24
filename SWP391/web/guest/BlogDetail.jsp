<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi Tiết Blog</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom CSS -->
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
            }
            .blog-container {
                width: 900px;
                margin: 50px auto;
                padding: 20px;
            }
            .blog-body {
                width: 800px;
                margin: auto;
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                padding: 20px;
            }

            .blog-title {
                font-size: 2.5rem;
                font-weight: bold;
                margin-bottom: 10px;
            }
            .blog-meta {
                color: #6c757d;
                font-size: 0.9rem;
                margin-bottom: 20px;
            }
            .blog-content {
                line-height: 1.6;
                font-size: 1.1rem;
                margin-bottom: 30px;
            }
            .comment-section {
                margin-top: 40px;
            }
            .comment-form {
                margin-top: 20px;
            }
            .comment {
                border-bottom: 1px solid #dee2e6;
                padding: 15px 0;
            }
        </style>
    </head>
    <body>
        <%
               ResultSet rsBlog = (ResultSet) request.getAttribute("rsBlog");
        %>
        <jsp:include page="/components/Header.jsp"></jsp:include>
            <div class="container">
                <div class="blog-container">
                    <!-- Blog Title -->
                <%if(rsBlog != null) {
            while(rsBlog.next()) {%>
                <img style="width: 100%; border-radius: 12px" src="<%=rsBlog.getString("Avatar")%>" />
                <div class="blog-body">
                    <h1 class="blog-title"><%=rsBlog.getString("Title")%></h1>
                    <div class="blog-meta">
                        <span>Đăng bởi: <%=rsBlog.getString("AuthorName")%></span> | 
                        <span>Ngày đăng: <%=rsBlog.getString("CreatedAt")%></span>
                    </div>
                    <div class="blog-content">
                        <%=rsBlog.getString("Content")%>
                    </div>
                </div>
                <%  }
        } else {%>
                <h3>Blog không tồn tại</h3>
                <%}%>
            </div>
        </div>
        <jsp:include page="/components/Footer.jsp"></jsp:include>
        <!-- Bootstrap JS and Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>