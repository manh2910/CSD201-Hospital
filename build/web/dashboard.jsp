<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="service.HospitalService"%>
<%@page import="dto.Patient"%>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    HospitalService service = (HospitalService) application.getAttribute("hospitalService");
    int waitingCount = service != null ? service.getWaitingCount() : 0;
    int admittedCount = service != null ? service.getAdmittedCount() : 0;
    int totalCount = service != null ? service.getTotalPatients() : 0;
    String adminName = (String) session.getAttribute("admin");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard — Hospital Management</title>
    <link rel="stylesheet" href="common.css">
</head>
<body>
<div class="app">
    <!-- SIDEBAR -->
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
            <a class="nav-item active" href="dashboard.jsp"><span class="ni">▦</span> Dashboard</a>
            <div class="nav-section">Quản lý bệnh nhân</div>
            <a class="nav-item" href="addPatient.jsp"><span class="ni">＋</span> Thêm bệnh nhân</a>
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

    <!-- MAIN -->
    <div class="main">
        <header class="topbar">
            <div class="topbar-title">Dashboard</div>
            <form action="SearchPatientController" method="get" class="topbar-search">
                <span class="icon">⌕</span>
                <input type="text" name="id" placeholder="Tìm theo mã bệnh nhân…" required>
            </form>
        </header>

        <div class="content">
            <div class="page-head">
                <h1>Tổng quan hệ thống</h1>
                <p>Theo dõi hàng chờ, bệnh nhân đang điều trị và tổng số hồ sơ.</p>
            </div>

            <div class="stats-grid">
                <div class="stat-card waiting">
                    <div class="label">Đang chờ khám</div>
                    <div class="value"><%= waitingCount %></div>
                    <div class="hint">Queue · FIFO</div>
                </div>
                <div class="stat-card admitted">
                    <div class="label">Đang điều trị</div>
                    <div class="value"><%= admittedCount %></div>
                    <div class="hint">Linked List</div>
                </div>
                <div class="stat-card total">
                    <div class="label">Tổng bệnh nhân</div>
                    <div class="value"><%= totalCount %></div>
                    <div class="hint">BST index</div>
                </div>
            </div>

            <div class="section-label">Thao tác nhanh</div>
            <div class="actions-grid">
                <a href="addPatient.jsp" class="action-card">
                    <h4>Thêm bệnh nhân</h4>
                    <p>Đưa vào hàng chờ khám (enqueue)</p>
                </a>
                <a href="CallNextController" class="action-card">
                    <h4>Gọi bệnh nhân tiếp theo</h4>
                    <p>Dequeue → chuyển sang điều trị</p>
                </a>
                <a href="ListPatientController?type=waiting" class="action-card">
                    <h4>Xem hàng chờ</h4>
                    <p>Danh sách trạng thái Waiting</p>
                </a>
                <a href="ListPatientController?type=admitted" class="action-card">
                    <h4>Đang điều trị</h4>
                    <p>Danh sách trạng thái Admitted</p>
                </a>
                <a href="search.jsp" class="action-card">
                    <h4>Tìm kiếm theo ID</h4>
                    <p>Tra cứu O(log n) bằng BST</p>
                </a>
                <a href="ListPatientController?type=all" class="action-card">
                    <h4>Tất cả bệnh nhân</h4>
                    <p>Danh sách sắp xếp theo ID</p>
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
