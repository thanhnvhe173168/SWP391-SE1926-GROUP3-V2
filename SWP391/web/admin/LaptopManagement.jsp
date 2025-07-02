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
        <title>Quản lý sản phẩm</title>
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .container {
                padding: 30px 20px;
            }

            p {
                margin-bottom: 20px;
            }

            select {
                padding: 8px;
                border-radius: 8px;
                border: 1px solid #ccc;
                background-color: #fff;
                transition: box-shadow 0.3s ease;
            }

            select:focus {
                outline: none;
                border-color: #dd3726;
                box-shadow: 0 0 8px rgba(221, 55, 38, 0.4);
            }

            table {
                background-color: #ffffff;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 4px 12px rgba(0,0,0,0.06);
                transition: all 0.3s ease-in-out;
            }

            th, td {
                vertical-align: middle !important;
            }

            thead th {
                background-color: #dd3726;
                color: #ffffff;
                font-weight: bold;
            }

            tbody tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            tbody tr:hover {
                background-color: #ffeae8;
            }

            img {
                border-radius: 6px;
                object-fit: cover;
            }

            .btn-outline-primary {
                font-weight: 600;
                border-radius: 8px;
                border-color: #dd3726;
                color: #dd3726;
                transition: all 0.3s ease;
            }

            .btn-outline-primary:hover {
                background-color: #dd3726;
                color: white;
            }

            .pagination .page-item.active .page-link {
                background-color: #dd3726;
                border-color: #dd3726;
                color: white;
            }

            .pagination .page-link {
                color: #dd3726;
                font-weight: 500;
                transition: background-color 0.3s ease;
            }

            .pagination .page-item.disabled .page-link {
                color: #6c757d;
            }

            .table td a {
                margin: 0 5px;
                text-decoration: none;
                font-weight: 500;
                color: #0d6efd;
                transition: color 0.3s ease;
            }

            .table td a:hover {
                color: #dd3726;
                text-decoration: underline;
            }

            .text-center {
                font-style: italic;
                color: gray;
            }

            p[style*="font-size"] {
                transition: all 0.3s ease;
            }

            p[style*="font-size"]:hover {
                color: #bb2c1c;
                transform: scale(1.02);
            }
        </style>
    </head>
    <body>
        <%
            ResultSet rsLaptop = (ResultSet) request.getAttribute("rsLaptop");
            ResultSet rsBrand = (ResultSet) request.getAttribute("rsBrand");
            ResultSet rsCategory = (ResultSet) request.getAttribute("rsCategory");
            ResultSet rsCPU = (ResultSet) request.getAttribute("rsCPU");
            ResultSet rsScreen = (ResultSet) request.getAttribute("rsScreen");
            int currentPage = (int) request.getAttribute("currentPage");
            int totalPage = (int) request.getAttribute("totalPage");
        %>
        <div class="d-flex">
            <jsp:include page="/components/AdminSidebar.jsp"></jsp:include>
            <div class="container">
                <div class="d-flex justify-content-between align-items-center">
                    <p style="color: #dd3726; font-size: 40px; font-weight: 700">Quản lý sản phẩm</p>
                    <button type="button" class="btn btn-outline-primary" onclick="handleRedirect()">
                        <i class="fa-solid fa-plus"></i> Thêm sản phẩm
                    </button>
                </div>
                <div class="row mb-4">
                    <div class="col-md-3">
                        <select name="brandId" id="brandId" onchange="handleFilter('brandId', this.value)">
                            <option value="0" <%="0".equals(request.getParameter("brandId")) ? "selected" : "" %>>Nhãn hiệu</option>
                            <%while(rsBrand.next()) {%>
                                <option 
                                    value="<%=rsBrand.getInt("BrandID")%>"
                                    <%=(request.getParameter("brandId") != null && request.getParameter("brandId").equals(String.valueOf(rsBrand.getInt("BrandID")))) ? "selected" : "" %>>
                                    <%=rsBrand.getString("BrandName")%>
                                </option>
                            <%}%>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select name="categoryId" id="categoryId" onchange="handleFilter('categoryId', this.value)">
                            <option value="0" <%="0".equals(request.getParameter("categoryId")) ? "selected" : "" %>>Loại laptop</option>
                            <%while(rsCategory.next()) {%>
                                <option
                                    value="<%=rsCategory.getInt("CategoryID")%>"
                                    <%=(request.getParameter("categoryId") != null && request.getParameter("categoryId").equals(String.valueOf(rsCategory.getInt("CategoryID")))) ? "selected" : "" %>>
                                    <%=rsCategory.getString("CategoryName")%>
                                </option>
                            <%}%>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select name="cpuId" id="cpuId" onchange="handleFilter('cpuId', this.value)">
                            <option value="0" <%="0".equals(request.getParameter("cpuId")) ? "selected" : "" %>>CPU</option>
                            <%while(rsCPU.next()) {%>
                                <option 
                                    value="<%=rsCPU.getInt("CPUID")%>"
                                    <%=(request.getParameter("cpuId") != null && request.getParameter("cpuId").equals(String.valueOf(rsCPU.getInt("CPUID")))) ? "selected" : "" %>>
                                    <%=rsCPU.getString("CPUInfo")%>
                                </option>
                            <%}%>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select name="screenId" id="screenId" onchange="handleFilter('screenId', this.value)">
                            <option value="0" <%="0".equals(request.getParameter("screenId")) ? "selected" : "" %>>Màn hình</option>
                            <%while(rsScreen.next()) {%>
                                <option 
                                    value="<%=rsScreen.getInt("ScreenID")%>"
                                    <%=(request.getParameter("screenId") != null && request.getParameter("screenId").equals(String.valueOf(rsScreen.getInt("ScreenID")))) ? "selected" : "" %>>
                                    <%=rsScreen.getString("Size")%>
                                </option>
                            <%}%>
                        </select>
                    </div>
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
                                <%if (rsLaptop != null && rsLaptop.isBeforeFirst()) {
                                    int index = 0;
                                    while (rsLaptop.next()) {
                                        index++;
                                %>
                                <tr>
                                    <th><%=index%></th>
                                    <td>
                                     <img src="images/<%=rsLaptop.getString("ImageURL")%>" alt="<%=rsLaptop.getString("LaptopName")%>" style="width: 40px; height: 40px"/>

                                    </td>
                                    <td><%=rsLaptop.getString("LaptopName")%></td>
                                    <td><%=rsLaptop.getString("Price")%></td>
                                    <td><%=rsLaptop.getString("HardDrive")%></td>
                                    <td><%=rsLaptop.getString("WarrantyPeriod")%></td>
                                    <td><%=rsLaptop.getString("CPUInfo")%></td>
                                    <td><%=rsLaptop.getString("Size")%></td>
                                    <td><%=rsLaptop.getString("RAM")%></td>
                                    <td><%=rsLaptop.getInt("Stock")%></td>
<td>
    <a href="updateLaptop?laptopId=<%=rsLaptop.getInt("LaptopID")%>" class="btn btn-sm btn-warning me-1">
        <i class="fa-solid fa-pen-to-square"></i> Sửa
    </a>
    <a href="deleteLaptop?laptopId=<%=rsLaptop.getInt("LaptopID")%>" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này không?');">
        <i class="fa-solid fa-trash"></i> Xóa
    </a>
</td>

                                </tr>
                                <%}
                                } else {%>
                                <tr>
                                    <td colspan="11">
                                        <div class="text-center">Không có dữ liệu</div>
                                    </td>
                                </tr>
                                <%}%>
                            </tbody>
                        </table>
                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-center">
                                <li class="page-item <%=currentPage == 1 ? "disabled" : ""%>" onclick="handleFilter('currentPage', <%=currentPage-1%>)" style="cursor: pointer">
                                    <a class="page-link">Previous</a>
                                </li>
                                <%for (int i = 1; i <= totalPage; i++) {%>
                                <li class="page-item <%=i == currentPage ? "active" : ""%>" onclick="handleFilter('currentPage', <%=i%>)" style="cursor: pointer">
                                    <a class="page-link"><%=i%></a>
                                </li>
                                <%}%>
                                <li class="page-item <%=currentPage == totalPage ? "disabled" : ""%>" onclick="handleFilter('currentPage', <%=currentPage+1%>)" style="cursor: pointer">
                                    <a class="page-link">Next</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
        <script>
            const params = new URLSearchParams(window.location.search);
            const totalPage = <%=totalPage%>;

            function handleRedirect() {
                window.location.href = "createLaptop";
            }

            function handleFilter(key, value) {
                var intValue = +value;
                if (key === 'currentPage') {
                    if (intValue < 1 || intValue > totalPage) return;
                }
                if (intValue === 0) {
                    params.delete(key);
                } else {
                    params.set(key, value);
                }
                window.location.href = "getListLaptop?" + params.toString();
            }
        </script>
    </body>
</html>
