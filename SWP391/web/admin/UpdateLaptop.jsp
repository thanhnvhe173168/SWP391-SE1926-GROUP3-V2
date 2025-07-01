<%-- 
    Document   : CreateLaptop
    Created on : Jun 12, 2025, 3:45:15 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="model.Laptop"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.ckeditor.com/ckeditor5/41.4.2/classic/ckeditor.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <style>
            /* Tùy chỉnh kích thước CKEditor */
            .ck-editor__editable_inline {
                min-height: 400px; /* Chiều cao tối thiểu */
                max-height: 600px; /* Chiều cao tối đa */
                width: 100%; /* Chiều rộng full */
                font-size: 16px; /* Cỡ chữ */
            }

            /* Đảm bảo container không giới hạn kích thước */
            .ck-editor__main {
                width: 100%;
            }
        </style>
    </head>
    <body>
        <%
            Laptop laptop = (Laptop) request.getAttribute("laptop");
            ResultSet rsBrand = (ResultSet) request.getAttribute("rsBrand");
            ResultSet rsCategory = (ResultSet) request.getAttribute("rsCategory");
            ResultSet rsCPU = (ResultSet) request.getAttribute("rsCPU");
            ResultSet rsScreen = (ResultSet) request.getAttribute("rsScreen");
        %>
        <div class="d-flex">
            <jsp:include page="/components/AdminSidebar.jsp"></jsp:include>
                <div style="height: calc(100vh - 86px); overflow: hidden auto;" class="container">
                    <p style="color: #dd3726; font-size: 40px; font-weight: 700">Chỉnh sửa laptop</p>
                    <div class="container">
                        <form id="formUpdateLaptop">
                            <input 
                                type="hidden" 
                                required 
                                class="form-control"
                                id="laptopId" 
                                name="laptopId" 
                                value="<%=laptop.getLaptopID()%>"
                            >
                        <div class="row">
                            <div class="col-12 mb-3">
                                <label for="name" class="form-label">Tên laptop</label>
                                <input 
                                    type="text" 
                                    required 
                                    class="form-control"
                                    id="laptopName" 
                                    name="laptopName" 
                                    value="<%=laptop.getLaptopName()%>"
                                    >
                            </div>
                            <div class="col-6 mb-3">
                                <label for="name" class="form-label">Số lượng</label>
                                <input 
                                    type="number" 
                                    required 
                                    class="form-control"
                                    id="stock" 
                                    name="stock" 
                                    value="<%=laptop.getStock()%>"
                                    >
                            </div>
                            <div class="col-6">
                                <label for="name" class="form-label">Giá</label>
                                <input 
                                    type="number" 
                                    required 
                                    class="form-control"
                                    id="price" 
                                    name="price" 
                                    value="<%=laptop.getPrice()%>"
                                    >
                            </div>
                            <div class="col-12 mb-3">
                                <label for="name" class="form-label">Ảnh laptop</label>
                                <input 
                                    type="text" 
                                    required 
                                    class="form-control"
                                    id="imageUrl" 
                                    name="imageUrl" 
                                    value="<%=laptop.getImageURL()%>"
                                    >
                            </div>
                            <div class="col-12 mb-3">
                                <label for="name" class="form-label">Mô tả</label>
                                <textarea  id="editor" name="description" rows="5" style="width: 100%">
                                    <%=laptop.getDescription()%>
                                </textarea>
                            </div>
                            <div class="col-4 mb-3">
                                <label for="name" class="form-label">Ổ cứng</label>
                                <input 
                                    type="text" 
                                    required 
                                    class="form-control"
                                    id="hardDrive" 
                                    name="hardDrive" 
                                    value="<%=laptop.getHardDrive()%>"
                                    >
                            </div>
                            <div class="col-4 mb-3">
                                <label for="name" class="form-label">Bảo hành</label>
                                <input 
                                    type="text" 
                                    required 
                                    class="form-control"
                                    id="warrantyPeriod" 
                                    name="warrantyPeriod" 
                                    value="<%=laptop.getWarrantyPeriod()%>"
                                    >
                            </div>
                            <div class="col-4 mb-3">
                                <label for="name" class="form-label">RAM</label>
                                <input 
                                    type="text" 
                                    required 
                                    class="form-control"
                                    id="ram" 
                                    name="ram" 
                                    value="<%=laptop.getRam()%>"
                                    >
                            </div>
                            <div class="col-6 mb-3">
                                <label for="name" class="form-label">Nhãn hiệu</label>
                                <select name="brandId" id="brandId" style="width: 100%" required>
                                    <option value="0">Chọn nhãn hiệu</option>
                                    <%while(rsBrand.next()) {%>
                                    <option
                                        value="<%=rsBrand.getInt("BrandID")%>"
                                        <%=rsBrand.getInt("BrandID") == laptop.getBrand() ? "selected" : ""%>
                                        >
                                        <%=rsBrand.getString("BrandName")%>
                                    </option>
                                    <%}%>
                                </select>
                            </div>
                            <div class="col-6 mb-3">
                                <label for="name" class="form-label">Loại laptop</label>
                                <select name="categoryId" id="categoryId" style="width: 100%" required value="<%=laptop.getCategory()%>">
                                    <option value="0">Chọn loại laptop</option>
                                    <%while(rsCategory.next()) {%>
                                    <option
                                        value="<%=rsCategory.getInt("CategoryID")%>"
                                        <%=rsCategory.getInt("CategoryID") == laptop.getCategory() ? "selected" : ""%>
                                        >
                                        <%=rsCategory.getString("CategoryName")%>
                                    </option>
                                    <%}%>
                                </select>
                            </div>
                            <div class="col-6 mb-3">
                                <label for="name" class="form-label">CPU</label>
                                <select name="cpuId" id="cpuId" style="width: 100%" required value="<%=laptop.getCpu()%>">
                                    <option value="0">Chọn CPU</option>
                                    <%while(rsCPU.next()) {%>
                                    <option 
                                        value="<%=rsCPU.getInt("CPUID")%>"
                                        <%=rsCPU.getInt("CPUID") == laptop.getCpu() ? "selected" : ""%>
                                        >
                                        <%=rsCPU.getString("CPUInfo")%>
                                    </option>
                                    <%}%>
                                </select>
                            </div>
                            <div class="col-6 mb-3">
                                <label for="name" class="form-label">Màn hình</label>
                                <select name="screenId" id="screenId" style="width: 100%" required value="<%=laptop.getScreen()%>">
                                    <option value="0">Chọn màn hình</option>
                                    <%while(rsScreen.next()) {%>
                                    <option 
                                        value="<%=rsScreen.getInt("ScreenID")%>"
                                        <%=rsScreen.getInt("ScreenID") == laptop.getScreen() ? "selected" : ""%>
                                        >
                                        <%=rsScreen.getString("Size")%>
                                    </option>
                                    <%}%>
                                </select>
                            </div>
                        </div>
                        <p class="text-danger" id="message"></p>
                        <div class="d-flex justify-content-end" style="margin-bottom: 30px">
                            <button 
                                type="button"
                                class="btn btn-outline-primary" 
                                style="margin-right: 12px"
                                onclick="handleRedirect()"
                                >
                                Trở lại
                            </button>
                            <button type="submit" class="btn btn-primary">Cập nhật</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script>

            ClassicEditor
                    .create(document.querySelector('#editor'))
                    .then(editor => {
                        console.log('Editor was initialized', editor);
                    })
                    .catch(error => {
                        console.error(error);
                    });

            function handleRedirect() {
                window.location.href = "getListLaptop";
            }

            $(document).ready(function () {
                $('#formUpdateLaptop').submit((function (e) {
                    e.preventDefault();
                    $.ajax(({
                        url: "updateLaptop",
                        type: 'POST',
                        data: $('#formUpdateLaptop').serialize(),
                        success: function (data) {
                            if (data.message) {
                                $("#message").text(data.message);
                            } else {
                                handleRedirect();
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error('Error:', error.toString());
                            $("#result").text('Có lỗi xảy ra!');
                        }
                    }));
                }));
            });
        </script>
    </body>
</html>
