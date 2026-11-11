<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <title>Thêm bệnh nhân — Hospital Management</title>
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
            <a class="nav-item active" href="addPatient.jsp"><span class="ni">＋</span> Thêm bệnh nhân</a>
            <a class="nav-item" href="ListPatientController?type=waiting"><span class="ni">☰</span> Hàng chờ</a>
            <a class="nav-item" href="ListPatientController?type=admitted"><span class="ni">▣</span> Đang điều trị</a>
            <a class="nav-item" href="ListPatientController?type=all"><span class="ni">☰</span> Tất cả bệnh nhân</a>
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
            <div class="topbar-title">Thêm bệnh nhân</div>
            <form action="SearchPatientController" method="get" class="topbar-search">
                <span class="icon">⌕</span>
                <input type="text" name="id" placeholder="Tìm theo mã bệnh nhân…" required>
            </form>
        </header>

        <div class="content">
            <div class="page-head">
                <h1>Thêm bệnh nhân vào hàng chờ</h1>
                <p>Bệnh nhân mới sẽ được đưa vào Queue (FIFO) với trạng thái Waiting.</p>
            </div>

            <div class="panel" style="max-width:640px;">
                <div class="panel-header">
                    <h2>Thông tin bệnh nhân</h2>
                </div>
                <div class="panel-body">
                    <% String msg = (String) request.getAttribute("message");
                       if (msg != null) {
                           boolean ok = msg.toLowerCase().contains("thành công");
                    %>
                        <div class="alert <%= ok ? "alert-success" : "alert-error" %>"><%= msg %></div>
                    <% } %>

                    <form action="AddPatientController" method="post">
                        <div class="form-grid">
                            <div class="form-group">
                                <label>Mã bệnh nhân (ID)</label>
                                <input type="text" name="id" required placeholder="BN001" autocomplete="off">
                            </div>
                            <div class="form-group">
                                <label>Họ và tên</label>
                                <input type="text" name="name" required placeholder="Nguyễn Văn A">
                            </div>
                            <div class="form-group">
                                <label>Tuổi</label>
                                <input type="number" name="age" required min="0" max="150" placeholder="25">
                            </div>
                            <div class="form-group">
                                <label>Giới tính</label>
                                <select name="gender">
                                    <option value="Nam">Nam</option>
                                    <option value="Nữ">Nữ</option>
                                </select>
                            </div>
                            <div class="form-group full">
                                <label>Bệnh lý</label>
                                <input type="text" name="disease" required placeholder="Sốt xuất huyết, Viêm phổi…">
                            </div>
                            <div class="form-group full">
                                <label>Số điện thoại</label>
                                <input type="text" name="phone" placeholder="09xxxxxxxx">
                            </div>
                        </div>
                        <div style="margin-top:22px; display:flex; gap:10px;">
                            <button type="submit" class="btn btn-primary btn-lg">Thêm vào hàng chờ</button>
                            <a href="dashboard.jsp" class="btn btn-secondary btn-lg">Hủy</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
