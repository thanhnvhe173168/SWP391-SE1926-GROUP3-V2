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
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.ckeditor.com/ckeditor5/41.4.2/classic/ckeditor.js"></script>
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
        <div class="d-flex">
            <jsp:include page="/components/AdminSidebar.jsp"></jsp:include>
            <div style="height: calc(100vh - 0px); overflow: hidden auto;" class="container">
                <p style="color: #dd3726; font-size: 40px; font-weight: 700">Thêm mới blog</p>
                <div class="container">
                    <form id="formCreateBlog" accept-charset="UTF-8">
                        <div class="mb-3">
                            <label for="name" class="form-label">Ảnh</label>
                            <input 
                                type="text" 
                                required 
                                class="form-control"
                                id="avatar" 
                                name="avatar" 
                                >
                        </div>
                        <div class="mb-3">
                            <label for="name" class="form-label">Tiêu đề</label>
                            <input 
                                type="text" 
                                required 
                                class="form-control"
                                id="title" 
                                name="title" 
                                >
                        </div>
                        <div class="mb-3">
                            <label for="name" class="form-label">Nội dung</label>
                            <textarea id="editor" name="content" style="height: 120px"></textarea>
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
                            <button type="button" style="margin-right: 12px" class="btn btn-primary" onclick="handleSubmit('draft')">Lưu nháp</button>
                            <button type="button" class="btn btn-primary" onclick="handleSubmit('active')">Lưu</button>
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
                        window.editor = editor;
                    })
                    .catch(error => {
                        console.error(error);
                    });

            function handleRedirect() {
                window.location.href = "getListBlog";
            }

            function handleSubmit(blogStatus) {
                if (window.editor) {
                    var content = window.editor.getData(); // Lấy nội dung từ CKEditor
                    document.getElementById('editor').value = content; // Gán vào <textarea>
                    console.log("Content synchronized:", content);
                } else {
                    console.warn("CKEditor instance not found");
                }
                var formData = $('#formCreateBlog').serialize();
                var data = formData + '&blogStatus=' + encodeURIComponent(blogStatus);

                $.ajax({
                    url: 'createBlog',
                    type: 'POST',
                    data: data,
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
                });
            }
        </script>
    </body>
</html>
