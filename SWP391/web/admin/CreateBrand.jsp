<%-- 
    Document   : addProduct
    Created on : Mar 20, 2025, 11:01:22 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            String message = (String) request.getAttribute("message");
            String brandName = (String) request.getAttribute("brandName");
        %>
        <div class="d-flex">
            <jsp:include page="/components/AdminSidebar.jsp"></jsp:include>
                <div style="height: calc(100vh - 86px); overflow: hidden auto;" class="container">
                    <p style="color: #dd3726; font-size: 40px; font-weight: 700">Thêm mới nhãn hiệu</p>
                    <div class="container">
                        <form method="post" action="createBrand" id="createBrand">
                            <div class="mb-3">
                                <label for="name" class="form-label">Tên nhãn hiệu</label>
                                <input 
                                    type="text" 
                                    required 
                                    class="form-control"
                                    id="brandName" 
                                    name="brandName" 
                                    value="<%=brandName!= null ? brandName : ""%>"
                                >
                        </div>
                        <%if(message != null) {%>
                        <p class="text-danger"><%=message%></p>
                        <%}%>
                        <div class="d-flex justify-content-end" style="margin-bottom: 30px">
                            <button 
                                type="button"
                                class="btn btn-outline-primary" 
                                style="margin-right: 12px"
                                onclick="handleRedirect()"
                                >
                                Trở lại
                            </button>
                            <button type="submit" class="btn btn-primary">Thêm mới</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script>
            function handleRedirect() {
                window.location.href = "getListBrand";
            }
        </script>
    </body>
</html>
