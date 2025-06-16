<%-- 
    Document   : addProduct
    Created on : Mar 20, 2025, 11:01:22 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Brand"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <title>JSP Page</title>
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    </head>
    <body>
        <%
            Brand brand = (Brand) request.getAttribute("brand");
        %>
        <div class="d-flex">
            <jsp:include page="/components/AdminSidebar.jsp"></jsp:include>
                <div style="height: calc(100vh - 86px); overflow: hidden auto;" class="container">
                    <p style="color: #dd3726; font-size: 40px; font-weight: 700">Chỉnh sửa nhãn hiệu</p>
                    <div class="container">
                        <form id="formUpdateBrand">
                            <input 
                                type="hidden" 
                                class="form-control"
                                id="brandId" 
                                name="brandId" 
                                value="<%=brand.getBrandID()%>"
                            >
                        <div class="mb-3">
                            <label for="name" class="form-label">Tên nhãn hiệu</label>
                            <input 
                                type="text" 
                                required 
                                class="form-control"
                                id="brandName" 
                                name="brandName" 
                                value="<%=brand.getBrandName()%>"
                                >
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

            function handleRedirect() {
                window.location.href = "getListBrand";
            }

            $(document).ready(function () {
                $('#formUpdateBrand').submit((function (e) {
                    e.preventDefault();
                    $.ajax(({
                        url: "updateBrand",
                        type: 'POST',
                        data: $('#formUpdateBrand').serialize(),
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
