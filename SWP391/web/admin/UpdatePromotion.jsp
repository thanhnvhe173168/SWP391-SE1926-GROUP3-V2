<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <title>Update Promotion</title>
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
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
                color: white;
                border: none;
                cursor: pointer;
            }
            .product-row .btn-edit {
                background-color: #ffc107;
            }
            .product-row .btn-edit:hover {
                background-color: #e0a800;
            }
            .product-row .btn-save {
                background-color: #28a745;
            }
            .product-row .btn-save:hover {
                background-color: #218838;
            }
            .product-row .btn-remove {
                background-color: #ff4d4f;
            }
            .product-row .btn-remove:hover {
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
                    <h2>Update Promotion</h2>
                    <form id="promotion-form" action="/swp391/updatePromotion" method="POST">
                        <input type="hidden" id="promotionId" name="promotionId" value="<%= request.getParameter("promotionId") %>">
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
                    <div class="form-group">
                        <label for="status">Status</label>
                        <select id="status" name="status" required>
                            <option value="active">Active</option>
                            <option value="inactive">Inactive</option>
                        </select>
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
                </form>
            </div>
        </div>

        <script>
            var products = [];
            var promotionProducts = [];

            // Lấy danh sách sản phẩm từ getAllLaptop
            fetch('/swp391/getAllLaptop')
                    .then(function (response) {
                        return response.json();
                    })
                    .then(function (data) {
                        products = data.products;
                        // Lấy thông tin chương trình khuyến mãi
                        fetch('/swp391/getDetailPromotion?promotionId=' + document.getElementById('promotionId').value)
                                .then(function (response) {
                                    return response.json();
                                })
                                .then(function (data) {
                                    if (data.promotion) {
                                        // Điền dữ liệu chương trình khuyến mãi
                                        document.getElementById('image').value = data.promotion.image;
                                        document.getElementById('title').value = data.promotion.title;
                                        document.getElementById('startDate').value = data.promotion.startDate;
                                        document.getElementById('endDate').value = data.promotion.endDate;
                                        document.getElementById('status').value = data.promotion.status;
                                        // Điền danh sách sản phẩm
                                        promotionProducts = data.products;
                                        promotionProducts.forEach(function (product) {
                                            addProductRow(product);
                                        });
                                    } else {
                                        alert('Error: ' + data.message);
                                    }
                                })
                                .catch(function (error) {
                                    console.error('Error fetching promotion:', error);
                                    alert('Error fetching promotion: ' + error.message);
                                });
                    })
                    .catch(function (error) {
                        console.error('Error fetching products:', error);
                        alert('Error fetching products: ' + error.message);
                    });

            // Hàm thêm một hàng sản phẩm
            function addProductRow(product) {
                var productList = document.getElementById('product-list');
                var row = document.createElement('div');
                row.className = 'product-row';
                var isNew = !product;
                var productId = product ? product.laptopId : '';
                var discountPrice = product ? product.discountPrice : '';

                // Tạo chuỗi options cho dropdown
                var options = '<option value="">Select product</option>';
                if (Array.isArray(products)) {
                    products.forEach(function (p) {
                        var selected = p.laptopID === productId ? ' selected' : '';
                        // Thoát ký tự đặc biệt trong laptopName
                        var safeName = p.laptopName.replace(/"/g, '&quot;');
                        options += '<option value="' + p.laptopID + '"' + selected + '>' + safeName + ' (Original: $' + p.price + ')</option>';
                    });
                } else {
                    options += '<option value="">No products available</option>';
                }

                // Tạo HTML cho hàng sản phẩm
                var innerHTML = '<select name="productId" ' + (isNew ? '' : 'disabled') + ' required>' + options + '</select>' +
                        '<input type="number" name="discountPrice" value="' + discountPrice + '" min="0" step="10" placeholder="Discount price" ' + (isNew ? '' : 'disabled') + ' required>' +
                        '<button type="button" class="btn ' + (isNew ? 'btn-remove btn-danger' : 'btn-edit btn-warning') + '" onclick="' + (isNew ? 'removeProductRow(this)' : 'editProductRow(this)') + '">' + (isNew ? 'Remove' : 'Edit') + '</button>';
                if (!isNew) {
                    innerHTML += '<button type="button" class="btn btn-save btn-success" style="display: none;" onclick="saveProductRow(this)">Save</button>' +
                            '<button type="button" class="btn btn-remove btn-danger" onclick="deleteProductRow(this, ' + productId + ')">Remove</button>';
                }
                row.innerHTML = innerHTML;
                productList.appendChild(row);
            }

            // Hàm chỉnh sửa một hàng sản phẩm
            function editProductRow(button) {
                var row = button.parentElement;
                row.querySelector('select[name="productId"]').disabled = false;
                row.querySelector('input[name="discountPrice"]').disabled = false;
                button.style.display = 'none';
                row.querySelector('.btn-save').style.display = 'inline-block';
            }

            // Hàm lưu một hàng sản phẩm
            function saveProductRow(button) {
                var row = button.parentElement;
                var productId = row.querySelector('select[name="productId"]').value;
                var discountPrice = row.querySelector('input[name="discountPrice"]').value;

                if (!productId || !discountPrice) {
                    alert('Please select a product and enter a discount price.');
                    return;
                }

                // Gửi cập nhật sản phẩm tới Servlet
                fetch('/swp391/updatePromotionProduct', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify({
                        promotionId: document.getElementById('promotionId').value,
                        productId: parseInt(productId),
                        discountPrice: parseFloat(discountPrice)
                    })
                })
                        .then(function (response) {
                            return response.json();
                        })
                        .then(function (result) {
                            if (result.success) {
                                window.location.reload();
                            } else {
                                alert('Error: ' + result.message);
                            }
                        })
                        .catch(function (error) {
                            console.error('Error updating product:', error.message);
                            alert('Error updating product: ' + error.message);
                        });
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
            document.getElementById('add-product').addEventListener('click', function () {
                addProductRow();
            });

            // Sự kiện submit form
            document.getElementById('promotion-form').addEventListener('submit', function (event) {
                event.preventDefault();
                var formData = new FormData(this);
                var data = {
                    promotionId: formData.get('promotionId'),
                    title: formData.get('title'),
                    image: formData.get('image'),
                    startDate: formData.get('startDate'),
                    endDate: formData.get('endDate'),
                    status: formData.get('status'),
                    products: []
                };

                // Lấy danh sách sản phẩm mới (chưa có trong promotionProducts)
                var rows = document.querySelectorAll('.product-row');
                rows.forEach(function (row) {
                    var productId = row.querySelector('select[name="productId"]').value;
                    var discountPrice = row.querySelector('input[name="discountPrice"]').value;
                    if (productId && discountPrice && !row.querySelector('.btn-edit')) {
                        data.products.push({
                            productId: parseInt(productId),
                            discountPrice: parseFloat(discountPrice)
                        });
                    }
                });

                // Gửi dữ liệu tới UpdatePromotionServlet
                fetch('/swp391/updatePromotion', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify(data)
                })
                        .then(function (response) {
                            return response.json();
                        })
                        .then(function (result) {
                            if (result.success) {
                                window.location.href = "getListPromotion";
                            } else {
                                alert('Error: ' + result.message);
                            }
                        })
                        .catch(function (error) {
                            console.error('Error:', error.message);
                            alert('Error updating promotion: ' + error.message);
                        });
            });

            function deleteProductRow(button, productId) {
                if (document.querySelectorAll('.product-row').length <= 1) {
                    alert('At least one product is required.');
                    return;
                }

                if (confirm('Are you sure you want to remove this product from the promotion?')) {
                    fetch('/swp391/deletePromotionProduct', {
                        method: 'POST',
                        headers: {'Content-Type': 'application/json'},
                        body: JSON.stringify({
                            promotionId: document.getElementById('promotionId').value,
                            productId: parseInt(productId)
                        })
                    })
                            .then(function (response) {
                                return response.json();
                            })
                            .then(function (result) {
                                if (result.success) {
                                   window.location.reload();
                                } else {
                                    alert('Error: ' + result.message);
                                }
                            })
                            .catch(function (error) {
                                console.error('Error deleting product:', error);
                                alert('Error deleting product: ' + error.message);
                            });
                }
            }
            
             function handleRedirect() {
                window.location.href = "getListPromotion";
            }
        </script>
    </body>
</html>