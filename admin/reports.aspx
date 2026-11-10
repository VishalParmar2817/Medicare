<%@ Page Title="Reports &amp; Analytics — Admin Panel | MediCare" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="reports.aspx.cs" Inherits="medicare.admin.reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
<asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
<body>
<div class="admin-layout">
<!-- ══ ADMIN SIDEBAR ════════════════════════════════════════════ -->
<aside class="ph-sidebar admin-sidebar" id="adminSidebar">
    <div class="sidebar-brand">
        <div class="sidebar-brand-icon"><i class="bi bi-capsule-pill"></i></div>
        <div class="sidebar-brand-text">MediCare<span>Admin Panel</span></div>
    </div>
    <div class="sidebar-user">
        <div class="avatar avatar-sm" style="background: linear-gradient(135deg,#8B5CF6,#7C3AED)">SA</div>
        <div class="sidebar-user-info">
            <div class="sidebar-user-name">Super Admin</div>
            <div class="sidebar-user-role">System Administrator</div>
        </div>
    </div>
    <nav class="sidebar-nav">
        <div class="sidebar-label">Overview</div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link " href="dashboard.aspx">
                <i class="bi bi-speedometer2"></i>Dashboard
            </a>
        </div>

        <%-- <div class="sidebar-label">User Management</div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link " href="users.aspx"><i
                class="bi bi-person-gear"></i>Users</a>
        </div>--%>

        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link" href="customers.aspx">
                <i class="bi bi-people"></i>Customers
            </a>
        </div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link " href="pharmacists.aspx">
                <i class="bi bi-person-badge"></i>Pharmacists/Staff
            </a>
        </div>

        <div class="sidebar-label">Catalog</div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link" href="category-management.aspx"><i
                class="bi bi-grid-3x3-gap"></i>Categories</a>
        </div>

        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link " href="medicines.aspx">
                <i class="bi bi-capsule"></i>Medicine Management
            </a>
        </div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link" href="inventory.aspx"><i
                class="bi bi-boxes"></i>Inventory</a>
        </div>
        <%-- <div class="sidebar-nav-item">
            <a class="sidebar-nav-link" href="../pharmacist/prescription-billing.aspx"><i
                class="bi bi-file-medical-fill"></i>Rx &amp; Billing</a>
        </div>--%>

        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link" href="supplier-management.aspx"><i
                class="bi bi-truck"></i>Suppliers</a>
        </div>

        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link " href="brands.aspx">
                <i class="bi bi-building"></i>Brands
            </a>
        </div>

        <div class="sidebar-label">Operations</div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link " href="orders.aspx">
                <i class="bi bi-bag-check"></i>Orders
            </a>
        </div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link active" href="reports.aspx">
                <i class="bi bi-graph-up-arrow"></i>Reports <span class="nav-badge">Sales / Inventory / Revenue</span>
            </a>
        </div>

        <div class="sidebar-label">System</div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link " href="profile.aspx">
                <i class="bi bi-person-circle"></i>My Profile
            </a>
        </div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link " href="settings.aspx">
                <i class="bi bi-gear-wide-connected"></i>Settings
            </a>
        </div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link " href="audit-logs.aspx"><i
                class="bi bi-journal-text"></i>Audit Logs</a>
        </div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link" href="settings.aspx#backup"><i
                class="bi bi-cloud-arrow-up"></i>Backup &amp; Restore</a>
        </div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link" href="../Logout.aspx">
                <i class="bi bi-box-arrow-right"></i>Logout
            </a>
        </div>

        <div class="sidebar-label">Portal Access</div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link portal-link" href="../pharmacist/dashboard.aspx">
                <i class="bi bi-person-badge-fill"></i>Pharmacist Portal
            </a>
        </div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link portal-link" href="../index.aspx">
                <i class="bi bi-shop"></i>Customer Portal
            </a>
        </div>
    </nav>
    <div class="sidebar-footer">
        <div class="sidebar-version">MediCare Admin v2.4.1</div>
    </div>
</aside>
<div class="sidebar-overlay" id="adminOverlay"></div>
<div class="admin-main">
  <div id="headerMount"></div>
  <div class="admin-content">

    <!-- Header -->
    <div class="d-flex align-items-center justify-content-between mb-4 flex-wrap gap-2">
      <div><h5 class="fw-700 mb-1">Reports &amp; Analytics</h5><p class="text-muted mb-0" style="font-size:.88rem">Detailed insights into your pharmacy operations</p></div>
      <div class="d-flex gap-2">
        <asp:LinkButton ID="btnExportCsvReports" runat="server" CssClass="btn btn-outline-primary-custom fw-600"
          OnClientClick="showToast('Exporting CSV...','info'); return false;" ClientIDMode="Static">
          <i class="bi bi-file-earmark-spreadsheet me-1"></i>Export CSV
        </asp:LinkButton>
        <asp:LinkButton ID="btnExportPdfReports" runat="server" CssClass="btn btn-primary-custom fw-600"
          OnClientClick="showToast('Generating PDF report...','info'); return false;" ClientIDMode="Static">
          <i class="bi bi-file-pdf me-1"></i>Export PDF
        </asp:LinkButton>
      </div>
    </div>

    <!-- Report Tabs -->
    <div class="data-card mb-4">
      <ul class="nav nav-tabs px-3 pt-3" id="reportTabs">
        <li class="nav-item"><a class="nav-link active" data-bs-toggle="tab" href="#salesTab">Sales</a></li>
        <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#inventoryTab">Inventory</a></li>
        <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#customerTab">Customers</a></li>
      </ul>
      <div class="tab-content p-3">
        <!-- Sales Tab -->
        <div class="tab-pane fade show active" id="salesTab">
          <div class="row g-3 mb-3">
            <div class="col-6 col-lg-3"><div class="stat-card stat-green"><div class="stat-label">Total Revenue</div><div class="stat-value">₹<asp:Label ID="lblTotalRevenue" runat="server" Text="0" ClientIDMode="Static" /></div></div></div>
            <div class="col-6 col-lg-3"><div class="stat-card stat-blue"><div class="stat-label">Orders This Month</div><div class="stat-value"><asp:Label ID="lblMonthOrders" runat="server" Text="0" ClientIDMode="Static" /></div></div></div>
            <div class="col-6 col-lg-3"><div class="stat-card stat-purple"><div class="stat-label">Avg Order Value</div><div class="stat-value">₹<asp:Label ID="lblAvgOrder" runat="server" Text="0" ClientIDMode="Static" /></div></div></div>
            <div class="col-6 col-lg-3"><div class="stat-card stat-orange"><div class="stat-label">Pending Revenue</div><div class="stat-value">₹<asp:Label ID="lblPendingRev" runat="server" Text="0" ClientIDMode="Static" /></div></div></div>
          </div>
          <canvas id="salesLineChart" height="80"></canvas>
        </div>
        <!-- Inventory Tab -->
        <div class="tab-pane fade" id="inventoryTab">
          <div class="row g-3 mb-3">
            <div class="col-6 col-lg-3"><div class="stat-card stat-green"><div class="stat-label">In Stock</div><div class="stat-value"><asp:Label ID="lblRptInStock" runat="server" Text="0" ClientIDMode="Static" /></div></div></div>
            <div class="col-6 col-lg-3"><div class="stat-card stat-orange"><div class="stat-label">Low Stock</div><div class="stat-value"><asp:Label ID="lblRptLowStock" runat="server" Text="0" ClientIDMode="Static" /></div></div></div>
            <div class="col-6 col-lg-3"><div class="stat-card stat-red"><div class="stat-label">Out of Stock</div><div class="stat-value"><asp:Label ID="lblRptOutStock" runat="server" Text="0" ClientIDMode="Static" /></div></div></div>
            <div class="col-6 col-lg-3"><div class="stat-card stat-blue"><div class="stat-label">Total Brands</div><div class="stat-value"><asp:Label ID="lblRptBrands" runat="server" Text="0" ClientIDMode="Static" /></div></div></div>
          </div>
          <canvas id="inventoryBarChart" height="80"></canvas>
        </div>
        <!-- Customers Tab -->
        <div class="tab-pane fade" id="customerTab">
          <div class="row g-3">
            <div class="col-6 col-lg-4"><div class="stat-card stat-purple"><div class="stat-label">Total Customers</div><div class="stat-value"><asp:Label ID="lblRptTotalCust" runat="server" Text="0" ClientIDMode="Static" /></div></div></div>
            <div class="col-6 col-lg-4"><div class="stat-card stat-green"><div class="stat-label">Active Customers</div><div class="stat-value"><asp:Label ID="lblRptActiveCust" runat="server" Text="0" ClientIDMode="Static" /></div></div></div>
            <div class="col-6 col-lg-4"><div class="stat-card stat-cyan"><div class="stat-label">New This Month</div><div class="stat-value"><asp:Label ID="lblRptNewCust" runat="server" Text="0" ClientIDMode="Static" /></div></div></div>
          </div>
        </div>
      </div>
    </div>

  </div>
</div>
</div>

<div id="toast-container"></div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="../assets/js/main.js"></script>
<script src="../assets/js/admin.js"></script>
<script>
document.addEventListener('DOMContentLoaded', () => {
  document.getElementById('headerMount').innerHTML = ADMIN_HEADER('Reports & Analytics', 'Reports');
  initSidebar('adminSidebar', 'adminOverlay');

  new Chart(document.getElementById('salesLineChart'), {
    type: 'line',
    data: {
      labels: ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep'],
      datasets: [{ label: 'Revenue (₹)', data: [45000,52000,48000,71000,63000,88000,75000,92000,85000],
        borderColor: '#22c55e', backgroundColor: 'rgba(34,197,94,.08)', fill: true, tension: 0.4 }]
    },
    options: { responsive: true, plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true } } }
  });

  new Chart(document.getElementById('inventoryBarChart'), {
    type: 'bar',
    data: {
      labels: ['Pain Relief','Vitamins','Antibiotics','Cardiology','Diabetes','Allergy'],
      datasets: [{ label: 'Stock Units', data: [340, 450, 280, 220, 180, 310],
        backgroundColor: ['#ef4444','#22c55e','#f59e0b','#2563eb','#8b5cf6','#14b8a6'], borderRadius: 6 }]
    },
    options: { responsive: true, plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true } } }
  });
});
</script>
</body>
</asp:Content>
