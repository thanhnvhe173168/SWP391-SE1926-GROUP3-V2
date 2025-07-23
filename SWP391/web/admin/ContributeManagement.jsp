<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Góp ý của khách hàng</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .container {
                padding: 30px 20px;
            }

            .table {
                background-color: #ffffff;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 4px 12px rgba(0,0,0,0.06);
            }

            thead th {
                background-color: #dd3726;
                color: white;
                font-weight: bold;
            }

            tbody tr:hover {
                background-color: #ffeae8;
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

            .btn-icon {
                border-radius: 50px;
                padding: 6px 12px;
                font-size: 14px;
            }

            .btn-update {
                color: #ffc107;
                border: 1px solid #ffc107;
            }

            .btn-update:hover {
                background-color: #ffc107;
                color: white;
            }

            .btn-delete {
                color: #dc3545;
                border: 1px solid #dc3545;
            }

            .btn-delete:hover {
                background-color: #dc3545;
                color: white;
            }

            .toolbar input,
            .toolbar select {
                padding: 8px 12px;
                border: 1px solid #d1d5db;
                border-radius: 8px;
                background-color: #ffffff;
                width: 100%;
            }
        </style>
    </head>
    <body>
        <%
            ResultSet rsContribute = (ResultSet) request.getAttribute("rsContribute");
        %>
        <div class="d-flex">
            <jsp:include page="/components/AdminSidebar.jsp"></jsp:include>
                <div style="width: 100%; height: calc(100dvh - 100px); overflow-y: auto" class="container">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <p style="color: #dd3726; font-size: 40px; font-weight: 700;">Góp ý của khách hàng</p>
                    </div>
                    <div class="row">
                        <div class="col-8 toolbar mb-4">
                            <input 
                                type="text" 
                                id="authorName" 
                                placeholder="Tìm kiếm tên khách hàng" 
                                value="<%=request.getParameter("authorName") != null ? request.getParameter("authorName") : ""%>" 
                            />
                    </div>
                    <div class="col-2 toolbar mb-4">
                        <select name="orderBy" id="orderBy">
                            <option value="0" <%="0".equals(request.getParameter("orderBy")) ? "selected" : "" %>>Sắp xếp theo ngày tạo</option>
                            <option 
                                value="DESC"
                                <%=(request.getParameter("orderBy") != null && request.getParameter("orderBy").equals("DESC")) ? "selected" : "" %>>
                                Giảm dần
                            </option>
                            <option 
                                value="ASC"
                                <%=(request.getParameter("orderBy") != null && request.getParameter("orderBy").equals("ASC")) ? "selected" : "" %>>
                                Tăng dần
                            </option>
                            <option 
                                value="draft"
                                <%=(request.getParameter("blogStatus") != null && request.getParameter("blogStatus").equals("draft")) ? "selected" : "" %>>
                                Draft
                            </option>
                        </select>
                    </div>
                    <div class="col-2 toolbar mb-4">
                        <button type="submit" class="btn btn-primary" onclick="console.log('Button clicked'); handleFilter()">
                            <i class="fas fa-search me-1"></i> Tìm kiếm
                        </button>
                    </div>
                    <div class="col-12 table-responsive">
                        <table class="table table-bordered text-center">
                            <thead>
                                <tr>
                                    <th style="width: 10%">STT</th>
                                    <th>Tên khách hàng</th>
                                    <th>Nội dung</th>
                                    <th>Ngày tạo</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (rsContribute != null) {
                                        int index = 0;
                                        while (rsContribute.next()) {
                                            index++;
                                %>
                                <tr>
                                    <th><%= index %></th>
                                    <td><%= rsContribute.getString("AuthorName") %></td>
                                    <td><%= rsContribute.getString("Content") %></td>
                                    <td><%= rsContribute.getString("CreatedAt") %></td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="3">
                                        <div class="text-center">Không có dữ liệu</div>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <script>
            const params = new URLSearchParams(window.location.search);

            function handleRedirect() {
                window.location.href = "createBrand";
            }

            function handleFilter() {
                var authorName = document.getElementById("authorName").value;
                var orderBy = document.getElementById("orderBy").value;
                if (!authorName || +orderBy === 0) {
                    params.delete("authorName");
                    params.delete("orderBy");
                }
                if (!!authorName) {
                    params.set("authorName", authorName);
                }
                if (+orderBy !== 0) {
                    params.set("orderBy", orderBy);
                }
                window.location.href = "getListContribute?" + params.toString();
            }
        </script>
    </body>
</html>
