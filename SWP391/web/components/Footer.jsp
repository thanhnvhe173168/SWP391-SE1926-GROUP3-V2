<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <style>
            footer {
                background-color: #ffffff; /* ??ng b? v?i header n?n tr?ng */
                color: #333;
                padding: 40px 0 20px;
                font-family: 'Roboto', sans-serif;
                border-top: 1px solid #e0e0e0;
            }

            footer a {
                color: #005566; /* Gi? màu xanh d??ng ch? ??o */
                text-decoration: none;
                transition: color 0.3s ease;
            }

            footer a:hover {
                color: #003d4c;
            }

            .footer-title {
                font-size: 1.1rem;
                font-weight: 700;
                color: #005566;
                margin-bottom: 20px;
                text-transform: uppercase;
            }

            .footer-section p,
            .footer-section li {
                font-size: 0.95rem;
                line-height: 1.8;
                color: #555;
            }

            .footer-section ul {
                list-style: none;
                padding: 0;
            }

            .footer-section ul li {
                margin-bottom: 10px;
            }

            .footer-bottom {
                background-color: #005566; /* Gi? ph?n d??i footer màu xanh d??ng */
                color: #fff;
                padding: 15px 0;
                font-size: 0.9rem;
                margin-top: 20px;
            }

            .footer-bottom a {
                color: #17a2b8;
            }

            .footer-bottom a:hover {
                color: #fff;
            }

            hr.bg-light {
                border-color: #e0e0e0;
                margin: 20px 0;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .footer-section {
                    margin-bottom: 20px;
                    text-align: center;
                }
                .footer-title {
                    font-size: 1rem;
                }
                .footer-section p,
                .footer-section li {
                    font-size: 0.9rem;
                }
            }
        </style>
    </head>
    <body>
        <footer>
            <div class="container">
                <div class="row">
                    <!-- About Us -->
                    <div class="col-md-4">
                        <h5 class="footer-title">About Laptop Store</h5>
                        <p>We provide the best laptops for all your needs, from gaming to professional work. Quality and customer satisfaction are our top priorities.</p>
                    </div>
                    <!-- Quick Links -->
                    <div class="col-md-4">
                        <h5 class="footer-title">Quick Links</h5>
                        <ul class="list-unstyled">
                            <li><a href="home">Home</a></li>
                            <li><a href="productList">Products</a></li>
                            <li><a href="login">Login</a></li>
                            <li><a href="register">Register</a></li>
                        </ul>
                    </div>
                    <!-- Contact Info -->
                    <div class="col-md-4">
                        <h5 class="footer-title">Contact Us</h5>
                        <p>Email: laptop24h@gmail.com</p>
                        <p>Phone: +84 123 456 789</p>
                        <p>Address: Thach Hoa - Thach That - Ha Noi</p>
                    </div>
                </div>
                <hr class="bg-light">
                <div class="text-center">
                    <p>&copy; 2025 Laptop Store. All Rights Reserved.</p>
                </div>
            </div>
        </footer>
    </body>
</html>