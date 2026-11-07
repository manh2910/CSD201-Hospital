<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dto.Patient"%>
<!DOCTYPE html>
<html>
<head>
    <title>Danh sách bệnh nhân</title>
    <meta charset="UTF-8">
    <style>
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background: #2874a6; color: white; }
    </style>
</head>
<body>
    <h2>${title}</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Họ tên</th>
            <th>Tuổi</th>
            <th>Giới tính</th>
            <th>Bệnh lý</th>
            <th>Trạng thái</th>
            <th>SĐT</th>
        </tr>
        <%
            Patient[] list = (Patient[]) request.getAttribute("list");
            if (list != null) {
                for (Patient p : list) {
                    if (p != null) {
        %>
        <tr>
            <td><%= p.getId() %></td>
            <td><%= p.getName() %></td>
            <td><%= p.getAge() %></td>
            <td><%= p.getGender() %></td>
            <td><%= p.getDisease() %></td>
            <td><%= p.getStatus() %></td>
            <td><%= p.getPhone() %></td>
        </tr>
        <%
                    }
                }
            }
        %>
    </table>

    <br><a href="index.html">← Về trang chủ</a>
</body>
</html>