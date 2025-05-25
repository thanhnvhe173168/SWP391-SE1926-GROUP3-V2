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
            ResultSet rsCategory = (ResultSet) request.getAttribute("rsCategory");
        %>
        <div class="d-flex">
            <jsp:include page="/components/AdminSidebar.jsp"></jsp:include>
                <div style="width: 100%; height: calc(100vh - 118px); overflow-y: auto" class="container">
                    <div class="d-flex justify-content-between align-items-center">
                        <p style="color: #dd3726; font-size: 40px; font-weight: 700">Quản lý danh mục sản phẩm</p>
                        <button type="button" class="btn btn-outline-primary" onclick="handleRedirect()">
                            Thêm danh mục sản phẩm
                        </button>
                    </div>
                    <div class="row">
                        <div class="col-12 table-responsive">
                            <table class="table table-bordered text-center">
                                <thead>
                                    <tr>
                                        <th class="col-1">STT</th>
                                        <th class="col-5">Tên danh mục sản phẩm</th>
                                        <th class="col-2">Chức năng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%if (rsCategory != null) {
                                     int index = 0;
                                     while (rsCategory.next()) {
                                       index++;
                                %>
                                <tr>
                                    <th><%=index%></th>
                                    <td><%=rsCategory.getString("CategoryName")%></td>
                                    <td>
                                        <a href="updateCategory?categoryId=<%=rsCategory.getInt("CategoryID")%>">Update</a>
                                        <a href="deleteCategory?categoryId=<%=rsCategory.getInt("CategoryID")%>">Delete</a>
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
                window.location.href = "createCategory";
            }
        </script>
    </body>
</html>
