<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            .form-group {
                margin-bottom: 15px;
            }
            .form-group label {
                display: block;
                margin-bottom: 5px;
            }
            .form-group input, .form-group select {
                width: 100%;
                padding: 8px;
                box-sizing: border-box;
            }
            .product-row {
                display: flex;
                gap: 10px;
                margin-bottom: 10px;
                align-items: center;
            }
            .product-row select, .product-row input {
                flex: 1;
            }
            .product-row button {
                padding: 8px;
                background-color: #ff4d4f;
                color: white;
                border: none;
                cursor: pointer;
            }
            .product-row button:hover {
                background-color: #d9363e;
            }
            #add-product {
                padding: 10px;
                background-color: #1890ff;
                color: white;
                border: none;
                cursor: pointer;
                width: 100%;
                margin-bottom: 15px;
            }
            #add-product:hover {
                background-color: #40a9ff;
            }
            #submit-btn {
                padding: 10px 20px;
                background-color: #28a745;
                color: white;
                border: none;
                cursor: pointer;
            }
            #submit-btn:hover {
                background-color: #218838;
            }
        </style>
    </head>
    <body>
        <div class="d-flex">
            <jsp:include page="/components/AdminSidebar.jsp"></jsp:include>
            <div class="container">
                <h2>Create Promotion</h2>
                <form id="promotion-form" action="/your-web-app/PromotionServlet" method="POST">
                    <div class="form-group">
                        <label for="image">Ảnh</label>
                        <input type="text" id="image" name="image" required>
                    </div>
                    <div class="form-group">
                        <label for="title">Tiêu đề</label>
                        <input type="text" id="title" name="title" required>
                    </div>
                    <div class="form-group">
                        <label for="startDate">Start Date</label>
                        <input type="date" id="startDate" name="startDate" required>
                    </div>
                    <div class="form-group">
                        <label for="endDate">End Date</label>
                        <input type="date" id="endDate" name="endDate" required>
                    </div>
                    <div id="product-list">
                        <!-- Danh sách sản phẩm sẽ được thêm động bằng JavaScript -->
                    </div>
                    <button type="button" id="add-product" class="btn btn-primary">Add Product</button>
                    <div class="form-group">
                        <div class="d-flex justify-content-start" style="margin-bottom: 30px">
                            <button 
                                type="button"
                                class="btn btn-outline-primary" 
                                style="margin-right: 12px"
                                onclick="handleRedirect()"
                                >
                                Trở lại
                            </button>
                            <button type="submit" id="submit-btn" class="btn btn-primary">Thêm mới</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <script>
            // Lấy danh sách sản phẩm từ ProductServlet
            let products = [];
            fetch('/swp391/getAllLaptop')
                    .then(response => response.json())
                    .then(data => {
                        products = data.products;
                        console.log("products", products);
                        // Thêm sản phẩm đầu tiên khi trang tải
                        addProductRow();
                    })
                    .catch(error => console.error('Error fetching products:', error));

            // Hàm thêm một hàng sản phẩm
            function addProductRow() {
                const productList = document.getElementById('product-list');
                const row = document.createElement('div');
                row.className = 'product-row';
                let options = '<option value="">Select product</option>';
                if (Array.isArray(products)) {
                    products.forEach(product => {
                        options += '<option value="' + product.laptopID + '">' + product.laptopName + ' (Original: ' + product.price + ')</option>';
                    });
                } else {
                    options += '<option value="">No products available</option>';
                }
                console.log("options", options);
                const innerHTML = '<select name="productId" required>'
                        + options +
                        '</select>\n\
<input type="number" name="discountPrice" min="0" step="10" placeholder="Discount price" required>\n\
<button type="button" class="btn btn-danger" onclick="removeProductRow(this)">Remove</button>';
                row.innerHTML = innerHTML;
                productList.appendChild(row);
            }

            // Hàm xóa một hàng sản phẩm
            function removeProductRow(button) {
                if (document.querySelectorAll('.product-row').length > 1) {
                    button.parentElement.remove();
                } else {
                    alert('At least one product is required.');
                }
            }

            // Sự kiện nhấn nút Add Product
            document.getElementById('add-product').addEventListener('click', addProductRow);

            // Sự kiện submit form
            document.getElementById('promotion-form').addEventListener('submit', function (event) {
                event.preventDefault();
                const formData = new FormData(this);
                const data = {
                    title: formData.get('title'),
                    image: formData.get('image'),
                    startDate: formData.get('startDate'),
                    endDate: formData.get('endDate'),
                    status: formData.get('status'),
                    products: []
                };

                // Lấy danh sách sản phẩm
                const rows = document.querySelectorAll('.product-row');
                rows.forEach(row => {
                    const productId = row.querySelector('select[name="productId"]').value;
                    const discountPrice = row.querySelector('input[name="discountPrice"]').value;
                    if (productId && discountPrice) {
                        data.products.push({productId: parseInt(productId), discountPrice: parseFloat(discountPrice)});
                    }
                });

                // Gửi dữ liệu tới PromotionServlet
                fetch('/swp391/createPromotion', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify(data)
                })
                        .then(response => response.json())
                        .then(result => {
                            if (result.success) {
                                window.location.href = "getListPromotion";
                            } else {
                                alert('Error: ' + result.message);
                            }
                        })
                        .catch(error => console.error('Error:', error));
            });
            function handleRedirect() {
                window.location.href = "getListPromotion";
            }
        </script>
    </body>
</html>