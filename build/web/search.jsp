<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dto.Patient"%>
<!DOCTYPE html>
<html>
<head>
    <title>Tìm kiếm bệnh nhân</title>
    <meta charset="UTF-8">
</head>
<body>
    <h2>Tìm kiếm bệnh nhân theo ID (BST)</h2>

    <form action="SearchPatientController" method="get">
        Nhập ID: <input type="text" name="id" required>
        <button type="submit">Tìm</button>
    </form>

    <%
        Patient p = (Patient) request.getAttribute("patient");
        String searchedId = (String) request.getAttribute("searchedId");
        if (searchedId != null) {
            if (p != null) {
    %>
                <h3>Kết quả tìm kiếm:</h3>
                <p><b>ID:</b> <%= p.getId() %></p>
                <p><b>Họ tên:</b> <%= p.getName() %></p>
                <p><b>Tuổi:</b> <%= p.getAge() %></p>
                <p><b>Giới tính:</b> <%= p.getGender() %></p>
                <p><b>Bệnh lý:</b> <%= p.getDisease() %></p>
                <p><b>Trạng thái:</b> <%= p.getStatus() %></p>
                <p><b>SĐT:</b> <%= p.getPhone() %></p>
    <%
            } else {
    %>
                <p style="color: red;">Không tìm thấy bệnh nhân có ID: <%= searchedId %></p>
    <%
            }
        }
    %>

    <br><a href="index.html">← Về trang chủ</a>
</body>
</html>