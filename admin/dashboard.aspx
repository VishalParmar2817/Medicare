<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="medicare.admin.dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
<asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
<body>
<div class="admin-layout">

<!-- ══ SIDEBAR ═══════════════════════════════════════════════ -->
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
            <a class="sidebar-nav-link active" href="dashboard.aspx">
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
            <a class="sidebar-nav-link " href="reports.aspx">
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

<!-- ══ MAIN ══════════════════════════════════════════════════ -->
<div class="admin-main">
  <div id="headerMount"></div>

  <div class="admin-content">

    <!-- Welcome Banner -->
    <div class="admin-welcome-banner mb-4">
      <div class="row align-items-center">
        <div class="col welcome-text">
          <div class="welcome-time" id="welcomeTime">Good Morning</div>
          <div class="welcome-name">Welcome back, <asp:Label ID="lblAdminName" runat="server" Text="Super Admin" ClientIDMode="Static" />! 👋</div>
          <div class="welcome-sub">Here's your pharmacy system overview for today</div>
        </div>
        <div class="col-auto d-flex gap-2 position-relative" style="z-index:1">
          <asp:LinkButton ID="btnExportReportDash" runat="server" CssClass="btn btn-light fw-700" style="border-radius:var(--radius-sm);font-size:.85rem" OnClientClick="showToast('Generating report...','info'); return false;" ClientIDMode="Static"><i class="bi bi-download me-1"></i>Export Report</asp:LinkButton>
          <asp:LinkButton ID="btnTodayDash" runat="server" CssClass="btn btn-sm" style="background:rgba(255,255,255,.15);color:#fff;border:1px solid rgba(255,255,255,.2);border-radius:var(--radius-sm);font-size:.85rem" ClientIDMode="Static"><i class="bi bi-calendar3 me-1"></i>Today</asp:LinkButton>
        </div>
      </div>
    </div>

    <!-- Quick Actions -->
    <div class="row g-3 mb-4">
      <div class="col-12">
        <div class="d-flex align-items-center gap-2 mb-2">
          <span class="fw-700" style="font-size:.88rem;color:var(--dark-3)">QUICK ACTIONS</span>
        </div>
        <div class="row g-2">
          <div class="col-6 col-md-3 col-lg"><a href="medicines.aspx" class="quick-action-btn w-100"><i class="bi bi-plus-circle-fill" style="color:var(--primary)"></i>Add Medicine</a></div>
          <div class="col-6 col-md-3 col-lg"><a href="customers.aspx" class="quick-action-btn w-100"><i class="bi bi-person-plus-fill" style="color:var(--success)"></i>New Customer</a></div>
          <div class="col-6 col-md-3 col-lg"><a href="orders.aspx" class="quick-action-btn w-100"><i class="bi bi-bag-check-fill" style="color:var(--warning)"></i>View Orders</a></div>
          <div class="col-6 col-md-3 col-lg"><a href="reports.aspx" class="quick-action-btn w-100"><i class="bi bi-bar-chart-fill" style="color:var(--info)"></i>Reports</a></div>
          <div class="col-6 col-md-3 col-lg"><a href="pharmacists.aspx" class="quick-action-btn w-100"><i class="bi bi-person-badge-fill" style="color:#8b5cf6"></i>Pharmacists</a></div>
        </div>
      </div>
    </div>

    <!-- KPI Stats -->
    <div class="row g-3 mb-4">
      <div class="col-6 col-lg-3">
        <div class="stat-card stat-blue">
          <div class="d-flex justify-content-between align-items-start mb-2">
            <div class="stat-icon"><i class="bi bi-bag-check-fill"></i></div>
            <span class="stat-trend"><i class="bi bi-arrow-up me-1"></i>+12%</span>
          </div>
          <div class="stat-value"><asp:Label ID="lblTotalOrders" runat="server" Text="0" ClientIDMode="Static" /></div>
          <div class="stat-label">Total Orders</div>
        </div>
      </div>
      <div class="col-6 col-lg-3">
        <div class="stat-card stat-green">
          <div class="d-flex justify-content-between align-items-start mb-2">
            <div class="stat-icon"><i class="bi bi-currency-rupee"></i></div>
            <span class="stat-trend"><i class="bi bi-arrow-up me-1"></i>+8%</span>
          </div>
          <div class="stat-value">₹<asp:Label ID="lblRevenue" runat="server" Text="0" ClientIDMode="Static" /></div>
          <div class="stat-label">Revenue</div>
        </div>
      </div>
      <div class="col-6 col-lg-3">
        <div class="stat-card stat-purple">
          <div class="d-flex justify-content-between align-items-start mb-2">
            <div class="stat-icon"><i class="bi bi-people-fill"></i></div>
            <span class="stat-trend"><i class="bi bi-arrow-up me-1"></i>+5%</span>
          </div>
          <div class="stat-value"><asp:Label ID="lblTotalCustomers" runat="server" Text="0" ClientIDMode="Static" /></div>
          <div class="stat-label">Total Customers</div>
        </div>
      </div>
      <div class="col-6 col-lg-3">
        <div class="stat-card stat-orange">
          <div class="d-flex justify-content-between align-items-start mb-2">
            <div class="stat-icon"><i class="bi bi-capsule-pill"></i></div>
            <span class="stat-trend">Catalog</span>
          </div>
          <div class="stat-value"><asp:Label ID="lblTotalMedicines" runat="server" Text="0" ClientIDMode="Static" /></div>
          <div class="stat-label">Total Medicines</div>
        </div>
      </div>
    </div>

    <!-- Charts Row -->
    <div class="row g-3 mb-4">
      <div class="col-lg-8">
        <div class="data-card">
          <div class="data-card-header">
            <div class="data-card-title"><i class="bi bi-bar-chart-line me-2 text-primary"></i>Sales Overview</div>
            <div class="d-flex gap-1">
              <button class="btn btn-sm period-btn active" style="font-size:.78rem">7D</button>
              <button class="btn btn-sm period-btn" style="font-size:.78rem">30D</button>
              <button class="btn btn-sm period-btn" style="font-size:.78rem">90D</button>
            </div>
          </div>
          <canvas id="salesChart" height="120"></canvas>
        </div>
      </div>
      <div class="col-lg-4">
        <div class="data-card h-100">
          <div class="data-card-header">
            <div class="data-card-title"><i class="bi bi-pie-chart me-2 text-primary"></i>Order Status</div>
          </div>
          <canvas id="orderPieChart" height="160"></canvas>
        </div>
      </div>
    </div>

    <!-- Recent Orders -->
    <div class="data-card mb-4">
      <div class="data-card-header">
        <div class="data-card-title"><i class="bi bi-clock-history me-2 text-primary"></i>Recent Orders</div>
        <a href="orders.aspx" class="btn btn-outline-primary-custom btn-sm fw-600">View All</a>
      </div>
      <div class="table-wrap">
        <asp:GridView ID="gvRecentOrders" runat="server" CssClass="table table-bordered table-striped" AutoGenerateColumns="False" ClientIDMode="Static">
          <Columns>
            <asp:TemplateField HeaderText="Order ID">
              <ItemTemplate>
                <asp:Label ID="Label1" runat="server" Text='<%# Eval("OrderCode") %>' CssClass="fw-600" />
              </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Customer">
              <ItemTemplate>
                <asp:Label ID="Label2" runat="server" Text='<%# Eval("FullName") %>' />
              </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Date">
              <ItemTemplate>
                <asp:Label ID="Label3" runat="server" Text='<%# Eval("OrderDate", "{0:dd MMM yyyy}") %>' CssClass="text-muted small" />
              </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Amount">
              <ItemTemplate>
                <asp:Label ID="Label4" runat="server" Text='<%# "₹" + Eval("TotalAmount") %>' CssClass="fw-600" />
              </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status">
              <ItemTemplate>
                <asp:Label ID="Label5" runat="server" Text='<%# Eval("Status") %>' CssClass="badge-custom" />
              </ItemTemplate>
            </asp:TemplateField>
          </Columns>
        </asp:GridView>
      </div>
    </div>

  </div>
</div>
</div>
<div id="toast-container"></div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script src="../assets/js/main.js"></script>
<script src="../assets/js/admin.js"></script>
<script>
document.addEventListener('DOMContentLoaded', () => {
  document.getElementById('headerMount').innerHTML = ADMIN_HEADER('Dashboard', 'Dashboard');
  initSidebar('adminSidebar', 'adminOverlay');

  // Welcome time
  const h = new Date().getHours();
  document.getElementById('welcomeTime').textContent = h < 12 ? 'Good Morning' : h < 17 ? 'Good Afternoon' : 'Good Evening';

  // Sales Chart
  new Chart(document.getElementById('salesChart'), {
    type: 'line',
    data: {
      labels: ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'],
      datasets: [{
        label: 'Revenue (₹)',
        data: [12400, 18200, 15600, 22100, 19800, 28400, 24600],
        borderColor: 'var(--primary)', backgroundColor: 'rgba(37,99,235,.08)',
        fill: true, tension: 0.4, pointRadius: 4
      }]
    },
    options: { responsive: true, plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true } } }
  });

  // Order Pie Chart
  new Chart(document.getElementById('orderPieChart'), {
    type: 'doughnut',
    data: {
      labels: ['Delivered','Pending','Processing','Cancelled'],
      datasets: [{ data: [65, 15, 12, 8], backgroundColor: ['#22c55e','#f59e0b','#2563eb','#ef4444'], borderWidth: 0 }]
    },
    options: { responsive: true, plugins: { legend: { position: 'bottom', labels: { font: { size: 11 } } } } }
  });

  // Period selector
  document.querySelectorAll('.period-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      document.querySelectorAll('.period-btn').forEach(b => b.classList.remove('active'));
      btn.classList.add('active');
    });
  });
});
</script>
</body>
</asp:Content>
