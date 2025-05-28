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
            ResultSet rsLaptop = (ResultSet) request.getAttribute("rsLaptop");
        %>
        <div class="d-flex">
            <jsp:include page="/components/AdminSidebar.jsp"></jsp:include>
                <div style="width: 100%; height: calc(100vh - 118px); overflow-y: auto" class="container">
                    <div class="d-flex justify-content-between align-items-center">
                        <p style="color: #dd3726; font-size: 40px; font-weight: 700">Quản lý sản phẩm</p>
                        <button type="button" class="btn btn-outline-primary" onclick="handleRedirect()">
                            Thêm sản phẩm
                        </button>
                    </div>
                    <div class="row">
                        <div class="col-12 table-responsive-lg">
                            <table class="table table-bordered text-center">
                                <thead>
                                    <tr>
                                        <th>STT</th>
                                        <th>Ảnh</th>
                                        <th>Tên</th>
                                        <th>Giá</th>
                                        <th>Ổ cứng</th>
                                        <th>Bảo hành</th>
                                        <th>CPU</th>
                                        <th>Màn hình</th>
                                        <th>RAM</th>
                                        <th>Số lượng</th>
                                        <th>Chức năng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%if (rsLaptop != null) {
                                     int index = 0;
                                     while (rsLaptop.next()) {
                                       index++;
                                %>
                                <tr>
                                    <th><%=index%></th>
                                    <th>
                                        <img src="<%=rsLaptop.getString("ImageURL")%>" alt="" style="width: 40px; height: 40px"/>
                                    </th>
                                    <td><%=rsLaptop.getString("LaptopName")%></td>
                                    <td><%=rsLaptop.getString("Price")%></td>
                                    <td><%=rsLaptop.getString("HardDrive")%></td>
                                    <td><%=rsLaptop.getString("WarrantyPeriod")%></td>
                                    <td><%=rsLaptop.getString("CPUInfo")%></td>
                                    <td><%=rsLaptop.getString("Size")%></td>
                                    <td><%=rsLaptop.getString("RAM")%></td>
                                    <td><%=rsLaptop.getInt("Stock")%></td>
                                    <td>
                                        <a href="updateLaptop?laptopId=<%=rsLaptop.getInt("LaptopID")%>">Update</a>
                                        <a href="deleteLaptop?laptopId=<%=rsLaptop.getInt("LaptopID")%>">Delete</a>
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
                window.location.href = "createLaptop";
            }
        </script>
    </body>
</html>
