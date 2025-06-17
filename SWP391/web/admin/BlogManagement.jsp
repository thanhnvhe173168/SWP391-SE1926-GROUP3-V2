<%-- 
    Document   : ListBrand
    Created on : May 24, 2025, 11:22:14 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            ResultSet rsBlog = (ResultSet) request.getAttribute("rsBlog");
        %>
        <div class="d-flex">
            <jsp:include page="/components/AdminSidebar.jsp"></jsp:include>
                <div style="width: 100%; height: calc(100dvh - 100px); overflow-y: auto" class="container">
                    <div class="d-flex justify-content-between align-items-center">
                        <p style="color: #dd3726; font-size: 40px; font-weight: 700">Quản lý blog</p>
                        <button type="button" class="btn btn-outline-primary" onclick="handleRedirect()">
                            Thêm blog
                        </button>
                    </div>
                    <div class="row">
                        <div class="col-12 table-responsive">
                            <table class="table table-bordered text-center">
                                <thead>
                                    <tr>
                                        <th class="col-1">STT</th>
                                        <th class="col-2">Ảnh</th>
                                        <th class="col-5">Tiêu đề</th>
                                        <th class="col-2">Chức năng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%if (rsBlog != null) {
                                     int index = 0;
                                     while (rsBlog.next()) {
                                       index++;
                                %>
                                <tr>
                                    <th><%=index%></th>
                                    <th>
                                        <img src="<%=rsBlog.getString("Avatar")%>" alt="" style="width: 40px; height: 40px"/>
                                    </th>
                                    <td><%=rsBlog.getString("Title")%></td>
                                    <td>
                                        <a href="updateBlog?blogId=<%=rsBlog.getInt("BlogID")%>">Update</a>
                                        <a href="deleteBlog?blogId=<%=rsBlog.getInt("BlogID")%>">Delete</a>
                                    </td>
                                    <%}
                                    } else {%>
                                <tr>
                                    <td colspan="3">
                                        <div class="text-center">Không có dữ liệu</div>
                                    </td>
                                </tr>
                                <%}%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <script>
            function handleRedirect() {
                window.location.href = "createBlog";
            }
        </script>
    </body>
</html>
