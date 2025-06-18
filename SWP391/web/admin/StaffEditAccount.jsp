<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chỉnh sửa nhân viên</title>
    <style>
        body {
            font-family: Arial;
            padding: 20px;
            background-color: #f8f9fa;
        }
        .form-container {
            max-width: 500px;
            background-color: #fff;
            padding: 25px;
            margin: auto;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 8px;
        }
        .form-container h2 {
            text-align: center;
        }
        label {
            display: block;
            margin-top: 15px;
        }
        input, select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
        }
        .btn-submit {
            margin-top: 20px;
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px;
            width: 100%;
            cursor: pointer;
            border-radius: 5px;
        }
        .btn-submit:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Chỉnh sửa nhân viên</h2>
        <form method="post" action="staffEditAccount">
            <input type="hidden" name="action" value="save"/>
            <input type="hidden" name="userId" value="${user.userID}"/>

            <label>Họ và tên:</label>
            <input type="text" name="fullName" value="${user.fullName}" required/>

            <label>Số điện thoại:</label>
            <input type="text" name="phoneNumber" value="${user.phoneNumber}" required/>

            <label>Mật khẩu:</label>
            <input type="text" name="password" value="${user.password}" required/>

            <label>Trạng thái:</label>
            <select name="statusId">
                <option value="1" ${user.statusID == 1 ? 'selected' : ''}>Đang hoạt động</option>
                <option value="2" ${user.statusID == 2 ? 'selected' : ''}>Đã khóa</option>
            </select>

            <label>Vai trò:</label>
            <select name="roleId">
                <option value="1" ${user.roleID == 1 ? 'selected' : ''}>Admin</option>
                <option value="2" ${user.roleID == 2 ? 'selected' : ''}>Staff</option>
            </select>
            <button type="submit" class="btn-submit">Lưu thay đổi</button>
        </form>
    </div>
</body>
</html>
