<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Thêm bệnh nhân</title>
    <meta charset="UTF-8">
    <style>
        body { font-family: Arial; margin: 40px; }
        input, select { padding: 8px; margin: 5px 0; width: 300px; }
        button { padding: 10px 20px; background: #2874a6; color: white; border: none; cursor: pointer; }
    </style>
</head>
<body>
    <h2>Thêm bệnh nhân vào hàng chờ</h2>

    <% String msg = (String) request.getAttribute("message");
       if (msg != null) { %>
        <p style="color: green;"><%= msg %></p>
    <% } %>

    <form action="AddPatientController" method="post">
        ID: <br><input type="text" name="id" required><br>
        Họ tên: <br><input type="text" name="name" required><br>
        Tuổi: <br><input type="number" name="age" required><br>
        Giới tính: <br>
        <select name="gender">
            <option value="Nam">Nam</option>
            <option value="Nữ">Nữ</option>
        </select><br>
        Bệnh lý: <br><input type="text" name="disease" required><br>
        Số điện thoại: <br><input type="text" name="phone"><br><br>
        <button type="submit">Thêm vào hàng chờ</button>
    </form>

    <br><a href="index.html">← Về trang chủ</a>
</body>
</html>