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
            .latest-news {
                font-size: 36px; /* Kích thước chữ */
                font-weight: bold; /* Chữ đậm */
                color: #1a1a1a; /* Màu chữ (đen đậm) */
                position: relative; /* Để định vị đường kẻ */
                padding-bottom: 10px; /* Khoảng cách giữa chữ và đường kẻ */
            }

            .latest-news::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 30px;
                transform: translateX(-50%); /* Căn giữa đường kẻ */
                width: 50px; /* Độ dài đường kẻ */
                height: 3px; /* Độ dày đường kẻ */
                background-color: #ff0000; /* Màu đỏ */
            }
            input {
                padding: 8px 12px;
                border: 1px solid #d1d5db;
                border-radius: 8px;
                background-color: #ffffff;
                width: 60%;
                margin-bottom: 12px;
            }
        </style>
    </head>
    <body>
        <%
            ResultSet rsBlog = (ResultSet) request.getAttribute("rsBlog");
        %>
        <jsp:include page="/components/Header.jsp"></jsp:include>
            <div class="container my-5">
                <div class="d-flex justify-content-between align-items-center" style="margin-bottom: 30px">
                    <h1 class="latest-news">Tin tức mới nhất</h1>
                    <input 
                        type="text" 
                        id="title" 
                        placeholder="Tìm kiếm" 
                        value="<%=request.getParameter("title") != null ? request.getParameter("title") : ""%>" 
                    />
            </div>
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
        <script>
            document.getElementById('title').addEventListener('keypress', function (event) {
                if (event.key === 'Enter') {
                    const inputValue = this.value;
                    if(!!inputValue) {
                        window.location.href = "blogList?title=" + inputValue;
                    } else {
                        window.location.href = "blogList";
                    }
                }
            });
        </script>
    </body>
</html>