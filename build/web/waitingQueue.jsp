<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String adminName = (String) session.getAttribute("admin");
    String message = (String) request.getAttribute("message");
    if (message == null) message = (String) pageContext.findAttribute("message");
    if (message == null) {
        Object m = request.getAttribute("message");
        if (m != null) message = m.toString();
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gọi bệnh nhân — Hospital Management</title>
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
            <a class="nav-item" href="search.jsp"><span class="ni">⌕</span> Tìm kiếm (BST)</a>
            <a class="nav-item active" href="CallNextController"><span class="ni">→</span> Gọi bệnh nhân tiếp theo</a>
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
            <div class="topbar-title">Gọi bệnh nhân tiếp theo</div>
        </header>

        <div class="content">
            <div class="page-head">
                <h1>Kết quả thao tác</h1>
                <p>Dequeue từ Queue → cập nhật trạng thái Admitted → thêm vào Linked List.</p>
            </div>

            <div class="panel" style="max-width:480px;">
                <div class="panel-body" style="text-align:center; padding:36px 28px;">
                    <div style="font-size:28px; margin-bottom:12px; color:var(--primary);">→</div>
                    <p style="font-size:15px; color:var(--text); margin-bottom:24px; line-height:1.5;">
                        ${empty message ? 'Không có thông báo.' : message}
                    </p>
                    <div style="display:flex; gap:10px; justify-content:center; flex-wrap:wrap;">
                        <a href="ListPatientController?type=waiting" class="btn btn-primary">Xem hàng chờ</a>
                        <a href="ListPatientController?type=admitted" class="btn btn-secondary">Đang điều trị</a>
                        <a href="dashboard.jsp" class="btn btn-ghost">Dashboard</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
