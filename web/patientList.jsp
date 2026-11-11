<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dto.Patient"%>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String adminName = (String) session.getAttribute("admin");
    String title = (String) request.getAttribute("title");
    if (title == null) title = "Danh sách bệnh nhân";
    String activeNav = "all";
    String t = title.toLowerCase();
    if (t.contains("chờ") || t.contains("waiting")) activeNav = "waiting";
    else if (t.contains("điều trị") || t.contains("admitted")) activeNav = "admitted";
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= title %> — Hospital Management</title>
    <link rel="stylesheet" href="common.css">
</head>
<body>
<div class="app">
    <aside class="sidebar">
        <div class="sidebar-brand">
            <div class="logo">
                <div class="logo-mark">H</div>
                <span>Hospital System</span>
            </div>
            <div class="sub">CSD201 · Data Structures</div>
        </div>
        <nav class="sidebar-nav">
            <div class="nav-section">Tổng quan</div>
            <a class="nav-item" href="dashboard.jsp"><span class="ni">▦</span> Dashboard</a>
            <div class="nav-section">Quản lý bệnh nhân</div>
            <a class="nav-item" href="addPatient.jsp"><span class="ni">＋</span> Thêm bệnh nhân</a>
            <a class="nav-item <%= "waiting".equals(activeNav) ? "active" : "" %>" href="ListPatientController?type=waiting"><span class="ni">☰</span> Hàng chờ</a>
            <a class="nav-item <%= "admitted".equals(activeNav) ? "active" : "" %>" href="ListPatientController?type=admitted"><span class="ni">▣</span> Đang điều trị</a>
            <a class="nav-item <%= "all".equals(activeNav) ? "active" : "" %>" href="ListPatientController?type=all"><span class="ni">☰</span> Tất cả bệnh nhân</a>
            <div class="nav-section">Thao tác</div>
            <a class="nav-item" href="search.jsp"><span class="ni">⌕</span> Tìm kiếm (BST)</a>
            <a class="nav-item" href="CallNextController"><span class="ni">→</span> Gọi bệnh nhân tiếp theo</a>
        </nav>
        <div class="sidebar-footer">
            <div class="user">
                <div class="avatar"><%= adminName != null && adminName.length() > 0 ? adminName.substring(0,1).toUpperCase() : "A" %></div>
                <div class="user-meta">
                    <div class="user-name"><%= adminName != null ? adminName : "Admin" %></div>
                    <div class="user-role">Administrator</div>
                </div>
            </div>
            <a class="btn-logout" href="LogoutController">Đăng xuất</a>
        </div>
    </aside>

    <div class="main">
        <header class="topbar">
            <div class="topbar-title"><%= title %></div>
            <form action="SearchPatientController" method="get" class="topbar-search">
                <span class="icon">⌕</span>
                <input type="text" name="id" placeholder="Tìm theo mã bệnh nhân…" required>
            </form>
        </header>

        <div class="content">
            <div class="page-head">
                <h1><%= title %></h1>
                <p>Dữ liệu lấy từ cấu trúc dữ liệu tương ứng trong bộ nhớ.</p>
            </div>

            <div class="panel">
                <div class="panel-header">
                    <h2>Danh sách</h2>
                </div>
                <div class="table-wrap">
                    <table class="data">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Họ tên</th>
                                <th>Tuổi</th>
                                <th>Giới tính</th>
                                <th>Bệnh lý</th>
                                <th>Trạng thái</th>
                                <th>SĐT</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            Patient[] list = (Patient[]) request.getAttribute("list");
                            boolean hasData = false;
                            if (list != null) {
                                for (Patient p : list) {
                                    if (p != null) {
                                        hasData = true;
                                        String st = p.getStatus() != null ? p.getStatus() : "";
                                        String badgeClass = "badge-discharged";
                                        if ("Waiting".equalsIgnoreCase(st)) badgeClass = "badge-waiting";
                                        else if ("Admitted".equalsIgnoreCase(st)) badgeClass = "badge-admitted";
                        %>
                            <tr>
                                <td><strong><%= p.getId() %></strong></td>
                                <td><%= p.getName() %></td>
                                <td><%= p.getAge() %></td>
                                <td><%= p.getGender() %></td>
                                <td><%= p.getDisease() %></td>
                                <td><span class="badge <%= badgeClass %>"><%= st %></span></td>
                                <td><%= p.getPhone() != null ? p.getPhone() : "—" %></td>
                            </tr>
                        <%
                                    }
                                }
                            }
                            if (!hasData) {
                        %>
                            <tr><td colspan="7" class="empty">Không có dữ liệu</td></tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
