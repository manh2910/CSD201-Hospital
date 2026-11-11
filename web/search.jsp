<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dto.Patient"%>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String adminName = (String) session.getAttribute("admin");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm kiếm — Hospital Management</title>
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
            <a class="nav-item" href="ListPatientController?type=waiting"><span class="ni">☰</span> Hàng chờ</a>
            <a class="nav-item" href="ListPatientController?type=admitted"><span class="ni">▣</span> Đang điều trị</a>
            <a class="nav-item" href="ListPatientController?type=all"><span class="ni">☰</span> Tất cả bệnh nhân</a>
            <div class="nav-section">Thao tác</div>
            <a class="nav-item active" href="search.jsp"><span class="ni">⌕</span> Tìm kiếm (BST)</a>
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
            <div class="topbar-title">Tìm kiếm bệnh nhân</div>
            <form action="SearchPatientController" method="get" class="topbar-search">
                <span class="icon">⌕</span>
                <input type="text" name="id" placeholder="Tìm theo mã bệnh nhân…" required>
            </form>
        </header>

        <div class="content">
            <div class="page-head">
                <h1>Tìm kiếm theo ID</h1>
                <p>Sử dụng Binary Search Tree — độ phức tạp trung bình O(log n).</p>
            </div>

            <div class="panel" style="max-width:560px;">
                <div class="panel-header">
                    <h2>Tra cứu</h2>
                </div>
                <div class="panel-body">
                    <form action="SearchPatientController" method="get" style="display:flex; gap:10px; margin-bottom:20px;">
                        <div class="form-group" style="flex:1; margin:0;">
                            <input type="text" name="id" required placeholder="Nhập mã bệnh nhân (VD: BN001)"
                                   value="<%= request.getAttribute("searchedId") != null ? request.getAttribute("searchedId") : "" %>">
                        </div>
                        <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                    </form>

                    <%
                        Patient p = (Patient) request.getAttribute("patient");
                        String searchedId = (String) request.getAttribute("searchedId");
                        if (searchedId != null) {
                            if (p != null) {
                                String st = p.getStatus() != null ? p.getStatus() : "";
                                String badgeClass = "badge-discharged";
                                if ("Waiting".equalsIgnoreCase(st)) badgeClass = "badge-waiting";
                                else if ("Admitted".equalsIgnoreCase(st)) badgeClass = "badge-admitted";
                    %>
                        <div class="result-card">
                            <div class="row"><span class="k">ID</span><span class="v"><%= p.getId() %></span></div>
                            <div class="row"><span class="k">Họ tên</span><span class="v"><%= p.getName() %></span></div>
                            <div class="row"><span class="k">Tuổi</span><span class="v"><%= p.getAge() %></span></div>
                            <div class="row"><span class="k">Giới tính</span><span class="v"><%= p.getGender() %></span></div>
                            <div class="row"><span class="k">Bệnh lý</span><span class="v"><%= p.getDisease() %></span></div>
                            <div class="row"><span class="k">Trạng thái</span><span class="v"><span class="badge <%= badgeClass %>"><%= st %></span></span></div>
                            <div class="row"><span class="k">Số điện thoại</span><span class="v"><%= p.getPhone() != null ? p.getPhone() : "—" %></span></div>
                        </div>
                    <%
                            } else {
                    %>
                        <div class="alert alert-error">Không tìm thấy bệnh nhân có ID: <strong><%= searchedId %></strong></div>
                    <%
                            }
                        }
                    %>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
