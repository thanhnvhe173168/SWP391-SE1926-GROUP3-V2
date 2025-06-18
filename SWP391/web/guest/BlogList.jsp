<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách Blog</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                font-family: Arial, sans-serif;
            }
            .blog-card {
                transition: transform 0.2s;
            }
            .blog-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }
            .blog-image {
                height: 200px;
                object-fit: cover;
                width: 100%;
            }
            .card-title {
                font-size: 1.25rem;
                font-weight: bold;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }
        </style>
    </head>
    <body>
        <%
            ResultSet rsBlog = (ResultSet) request.getAttribute("rsBlog");
        %>
        <jsp:include page="/components/Header.jsp"></jsp:include>
            <div class="container my-5">
                <h1 class="text-center mb-4">Danh sách Blog</h1>
                <div class="row">
                <%if (rsBlog != null) {
                                 int index = 0;
                                 while (rsBlog.next()) {
                                   index++;
                %>
                <div class="col-md-4 mb-4">
                    <div class="card blog-card">
                        <img src="<%=rsBlog.getString("Avatar")%>" class="card-img-top blog-image" alt="<%=rsBlog.getString("Title")%>">
                        <div class="card-body">
                            <h5 class="card-title"><%=rsBlog.getString("Title")%></h5>
                            <a href="blogDetail?blogId=<%=rsBlog.getInt("BlogID")%>" class="btn btn-primary">Xem chi tiết</a>
                        </div>
                    </div>
                </div>
                <%}
                                    } else {%>
                <div class="text-center">Không có dữ liệu</div>
                <%}%>
            </div>
        </div>
        <jsp:include page="/components/Footer.jsp"></jsp:include>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>