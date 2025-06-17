<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.Blog"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>${blog.title}</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                font-family: Arial, sans-serif;
            }
            .blog-content {
                line-height: 1.6;
                font-size: 16px;
            }
            .blog-content img {
                max-width: 100%;
                height: auto;
            }
        </style>
    </head>
    <body>
        <%
                Blog blog = (Blog) request.getAttribute("blog");
        %>
        <jsp:include page="/components/Header.jsp"></jsp:include>
            <div class="container my-5">
                <h1 class="mb-4"><%=blog.getTitle()%></h1>
            <div class="blog-content">
                <%=blog.getContent()%>
            </div>
            <a href="blogList" class="btn btn-secondary mt-3">Quay lại</a>
        </div>
        <jsp:include page="/components/Footer.jsp"></jsp:include>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>