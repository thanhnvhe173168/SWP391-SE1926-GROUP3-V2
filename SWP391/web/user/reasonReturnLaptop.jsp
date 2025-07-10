<%@page import="model.*" %>
<%@page import="dao.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Hoàn sản phẩm</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
  <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background-color: #f5f5f5;
      margin: 0;
      padding: 0;
    }
    .return-container {
      max-width: 600px;
      margin: 50px auto;
      background: white;
      padding: 40px 30px;
      border-radius: 12px;
      box-shadow: 0 5px 20px rgba(0,0,0,0.1);
    }
    h2 {
      text-align: center;
      color: #ff4d4f;
      margin-bottom: 20px;
    }
    .order-info {
      text-align: center;
      margin-bottom: 20px;
      font-weight: 500;
    }
    label {
      display: block;
      margin-bottom: 8px;
      font-weight: bold;
    }
    textarea {
      width: 100%;
      height: 120px;
      padding: 12px;
      border: 1px solid #ccc;
      border-radius: 8px;
      resize: vertical;
      font-size: 14px;
      margin-bottom: 20px;
    }
    input[type="file"] {
      margin-top: 8px;
      display: block;
    }
    .file-note {
      font-size: 12px;
      color: #888;
      margin-top: 4px;
    }
    button {
      background-color: #ff4d4f;
      color: white;
      border: none;
      padding: 14px 30px;
      font-size: 16px;
      border-radius: 8px;
      cursor: pointer;
      width: 100%;
      transition: background-color 0.3s ease;
    }
    button:hover {
      background-color: #e04344;
    }
  </style>

  <%
    String lapids = request.getParameter("lapid");
    int laptopid = Integer.parseInt(lapids);
    String orderids = request.getParameter("orderid");
    int orderid = Integer.parseInt(orderids);

    // Nếu bạn có tên sản phẩm thì lấy luôn:
    LaptopDAO ldao = new LaptopDAO();
    Laptop laptop = ldao.getLaptopById(laptopid);
  %>
</head>
<body>
  <jsp:include page="/components/Header.jsp"></jsp:include>
  
  <div class="return-container">
    <h2>Hoàn sản phẩm</h2>
    <div class="order-info">
      Đơn hàng: <strong>#<%= orderid %></strong> <br/>
      Sản phẩm: <strong><%= laptop.getLaptopName() %></strong>
    </div>

    <form action="${pageContext.request.contextPath}/returnLaptop" method="post" enctype="multipart/form-data">
      <input type="hidden" name="laptopID" value="<%= laptopid %>">
      <input type="hidden" name="orderID" value="<%= orderid %>">

      <label for="reason">Lý do hoàn sản phẩm:</label>
      <textarea name="reason" id="reason" required placeholder="Ví dụ: Sản phẩm bị lỗi, giao nhầm..."></textarea>

      <label for="imageUpload">Đính kèm hình ảnh (nếu có):</label>
      <input type="file" id="imageUpload" name="imageUpload" multiple accept="image/*">
      <div class="file-note">Hỗ trợ JPG, PNG, JPEG - có thể chọn nhiều ảnh</div>

      <button type="submit">Gửi yêu cầu hoàn sản phẩm</button>
    </form>
  </div>
  
  <jsp:include page="/components/Footer.jsp"></jsp:include>
</body>
</html>
