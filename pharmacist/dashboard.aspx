<%@ Page Title="Dashboard — Pharmacist Portal | MediCare" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="medicare.pharmacist.dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link rel="stylesheet" href="<%= ResolveUrl("~/assets/css/pharmacist.css") %>" />
  <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
<asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
<body>
<div class="ph-layout">
  <!-- ══ PHARMACIST SIDEBAR ═══════════════════════════════════════ -->
<aside class="ph-sidebar" id="phSidebar">
  <div class="sidebar-brand">
    <div class="sidebar-brand-icon"><i class="bi bi-capsule-pill"></i></div>
    <div class="sidebar-brand-text">MediCare<span>Pharmacist Portal</span></div>
  </div>
  <div class="sidebar-user">
    <div class="avatar avatar-sm" style="background:linear-gradient(135deg,var(--primary),var(--secondary))">AK</div>
    <div class="sidebar-user-info">
      <div class="sidebar-user-name">Dr. Amit Kumar</div>
      <div class="sidebar-user-role">Senior Pharmacist</div>
    </div>
  </div>
  <nav class="sidebar-nav">
    <div class="sidebar-label">Main</div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link active" href="dashboard.aspx">
        <i class="bi bi-speedometer2"></i>Dashboard
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link " href="medicine-management.aspx">
        <i class="bi bi-capsule"></i>Medicine Management
      </a>
    </div>

    <div class="sidebar-label">Operations</div>
    <div class="sidebar-nav-item ">
      <a class="sidebar-nav-link " href="inventory.aspx"><i class="bi bi-boxes"></i>Inventory &amp; Alerts</a>
      <div class="sidebar-subnav">
        <a class="sidebar-subnav-link " href="stock-in.aspx"><i class="bi bi-box-arrow-in-down"></i>Stock In</a>
        <a class="sidebar-subnav-link " href="stock-out.aspx"><i class="bi bi-box-arrow-up"></i>Stock Out</a>
        <a class="sidebar-subnav-link " href="low-stock.aspx"><i class="bi bi-exclamation-triangle"></i>Low Stock</a>
        <a class="sidebar-subnav-link " href="expiring-soon.aspx"><i class="bi bi-clock-history"></i>Expiring Soon</a>
      </div>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link " href="order-management.aspx">
        <i class="bi bi-bag-check"></i>Order Management
        <span class="nav-badge">5</span>
      </a>
    </div>
    <div class="sidebar-nav-item ">
      <a class="sidebar-nav-link " href="prescription-billing.aspx">
        <i class="bi bi-file-medical-fill"></i>Rx &amp; Billing
        <span class="nav-badge">3</span>
      </a>
      <div class="sidebar-subnav">
        <a class="sidebar-subnav-link " href="prescription-verification.aspx"><i class="bi bi-file-earmark-check"></i>Prescription Verification</a>
        <a class="sidebar-subnav-link " href="prescription-billing.aspx"><i class="bi bi-calculator"></i>Billing</a>
        <a class="sidebar-subnav-link " href="invoices.aspx"><i class="bi bi-receipt"></i>Invoices</a>
      </div>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link " href="category-management.aspx">
        <i class="bi bi-grid-3x3-gap"></i>Categories
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link " href="supplier-management.aspx">
        <i class="bi bi-truck"></i>Suppliers
      </a>
    </div>

    <div class="sidebar-label">Account</div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link " href="profile.aspx">
        <i class="bi bi-person-circle"></i>My Profile
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link" href="../Logout.aspx">
        <i class="bi bi-box-arrow-right"></i>Logout
      </a>
    </div>

    <div class="sidebar-label">Portal Access</div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link portal-link" href="../admin/dashboard.aspx"><i class="bi bi-shield-lock-fill"></i>Admin Portal</a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link portal-link" href="../index.aspx"><i class="bi bi-shop"></i>Customer Portal</a>
    </div>
  </nav>
  <div class="sidebar-footer"><div class="sidebar-version">MediCare PMS v2.4.1</div></div>
</aside>
<div class="sidebar-overlay" id="phOverlay"></div>
  <div class="ph-main">
    <div id="headerMount"></div>
    <main class="ph-content">
      <!-- Welcome -->
      <div class="d-flex align-items-center justify-content-between mb-4 flex-wrap gap-2">
        <div>
          <h5 class="fw-700 mb-1">Good Day, <asp:Label ID="lblPharmacistName" runat="server" Text="Dr. Amit" ClientIDMode="Static" />! 👋</h5>
          <p class="text-muted mb-0" style="font-size:.88rem">Here's your pharmacy operational summary for today</p>
        </div>
        <div class="d-flex gap-2">
          <asp:LinkButton ID="btnAddMedDash" runat="server" CssClass="btn btn-primary-custom fw-600" ClientIDMode="Static" >
            <i class="bi bi-plus me-1"></i>Add Medicine
          </asp:LinkButton>
          <asp:LinkButton ID="btnExportDash" runat="server" CssClass="btn btn-outline-primary-custom fw-600" ClientIDMode="Static" >
            <i class="bi bi-download me-1"></i>Export
          </asp:LinkButton>
        </div>
      </div>

      <!-- Stat Cards -->
      <div class="row g-3 mb-4">
        <div class="col-6 col-lg-3"><div class="stat-card stat-blue"><div class="d-flex justify-content-between align-items-start mb-2"><div class="stat-icon">💊</div><span class="badge bg-white bg-opacity-25 text-white" style="font-size:.7rem">+8%</span></div><div class="stat-value"><asp:Label ID="lblTotalMeds" runat="server" Text="1,284" ClientIDMode="Static" /></div><div class="stat-label">Total Medicines</div></div></div>
        <div class="col-6 col-lg-3"><div class="stat-card stat-green"><div class="d-flex justify-content-between align-items-start mb-2"><div class="stat-icon">📦</div><span class="badge bg-white bg-opacity-25 text-white" style="font-size:.7rem">+12%</span></div><div class="stat-value"><asp:Label ID="lblOrdersToday" runat="server" Text="58" ClientIDMode="Static" /></div><div class="stat-label">Orders Today</div></div></div>
        <div class="col-6 col-lg-3"><div class="stat-card stat-orange"><div class="d-flex justify-content-between align-items-start mb-2"><div class="stat-icon">⚠️</div><span class="badge bg-white bg-opacity-25 text-white" style="font-size:.7rem">+3</span></div><div class="stat-value"><asp:Label ID="lblStockAlerts" runat="server" Text="7" ClientIDMode="Static" /></div><div class="stat-label">Stock Alerts</div></div></div>
        <div class="col-6 col-lg-3"><div class="stat-card stat-cyan"><div class="d-flex justify-content-between align-items-start mb-2"><div class="stat-icon">💰</div><span class="badge bg-white bg-opacity-25 text-white" style="font-size:.7rem">+18%</span></div><div class="stat-value"><asp:Label ID="lblRevenueToday" runat="server" Text="₹84K" ClientIDMode="Static" /></div><div class="stat-label">Revenue Today</div></div></div>
      </div>
      <div class="row g-3 mb-4">
        <div class="col-6 col-lg-3"><div class="stat-card stat-purple"><div class="stat-icon mb-2">📋</div><div class="stat-value"><asp:Label ID="lblPendingRx" runat="server" Text="3" ClientIDMode="Static" /></div><div class="stat-label">Pending Prescriptions</div></div></div>
        <div class="col-6 col-lg-3"><div class="stat-card stat-red"><div class="stat-icon mb-2">⏰</div><div class="stat-value"><asp:Label ID="lblExpiredMeds" runat="server" Text="2" ClientIDMode="Static" /></div><div class="stat-label">Expired Medicines</div></div></div>
        <div class="col-6 col-lg-3"><div class="stat-card stat-teal"><div class="stat-icon mb-2">👤</div><div class="stat-value"><asp:Label ID="lblActiveCustomers" runat="server" Text="342" ClientIDMode="Static" /></div><div class="stat-label">Active Customers</div></div></div>
        <div class="col-6 col-lg-3"><div class="stat-card stat-pink"><div class="stat-icon mb-2">⭐</div><div class="stat-value"><asp:Label ID="lblAvgRating" runat="server" Text="4.7" ClientIDMode="Static" /></div><div class="stat-label">Avg Rating</div></div></div>
      </div>

      <!-- Charts & Tables -->
      <div class="row g-3 mb-4">
        <div class="col-lg-8">
          <div class="chart-container">
            <div class="chart-title">Sales Revenue — Last 7 Days</div>
            <canvas id="salesChart" height="100"></canvas>
          </div>
        </div>
        <div class="col-lg-4">
          <div class="chart-container">
            <div class="chart-title">Sales by Category</div>
            <canvas id="catChart"></canvas>
          </div>
        </div>
      </div>

      <!-- Recent Orders & Stock Alerts -->
      <div class="row g-3">
        <div class="col-lg-8">
          <div class="data-card">
            <div class="data-card-header">
              <div class="data-card-title">Recent Orders</div>
              <a href="order-management.aspx" class="btn btn-sm btn-outline-primary-custom fw-600">View All</a>
            </div>
            <div class="table-wrap">
              <asp:GridView ID="gvRecentOrders" runat="server"
                  CssClass="table-custom"
                  AutoGenerateColumns="False"
                  ClientIDMode="Static"
                  >
                <Columns>
                  <asp:TemplateField HeaderText="Order ID">
                    <ItemTemplate>
                      <span class="fw-600 text-primary">#<%# Eval("OrderCode") %></span>
                    </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Customer">
                    <ItemTemplate>
                      <div class="d-flex align-items-center gap-2">
                        <div class="avatar avatar-sm" style="background:#1a6bcc;font-size:.7rem"><%# Eval("CustomerInitials") %></div>
                        <%# Eval("FullName") %>
                      </div>
                    </ItemTemplate>
                  </asp:TemplateField>
                  <asp:BoundField DataField="ItemsCount" HeaderText="Items" />
                  <asp:TemplateField HeaderText="Amount">
                    <ItemTemplate>
                      <span class="fw-600">₹<%# Eval("TotalAmount") %></span>
                    </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                      <span class="badge-custom"><%# Eval("Status") %></span>
                    </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                      <asp:LinkButton ID="btnViewRecentOrder" runat="server" CommandName="cmd_view" CommandArgument='<%# Eval("OrderID") %>' CssClass="btn btn-sm btn-primary-custom" Text="View" />
                    </ItemTemplate>
                  </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                  <div class="text-center py-3 text-muted">No recent orders found.</div>
                </EmptyDataTemplate>
              </asp:GridView>
            </div>
          </div>
        </div>
        <div class="col-lg-4">
          <div class="data-card">
            <div class="data-card-header"><div class="data-card-title">⚠️ Stock Alerts</div><a href="stock-alerts.aspx" class="btn btn-sm btn-outline-primary-custom">View All</a></div>
            <div class="p-3 d-flex flex-column gap-2">
              <div class="stock-alert-card low"><div><div class="fw-600" style="font-size:.85rem">Salbutamol Inhaler</div><small class="text-muted">Current: 30 | Min: 50</small></div><span class="badge-custom badge-warning">Low</span></div>
              <div class="stock-alert-card exp"><div><div class="fw-600" style="font-size:.85rem">Penicillin 250mg</div><small class="text-muted">Expired: Oct 2024</small></div><span class="badge-custom badge-danger">Expired</span></div>
              <div class="stock-alert-card near"><div><div class="fw-600" style="font-size:.85rem">Doxycycline 100mg</div><small class="text-muted">Expires in 21 days</small></div><span class="badge-custom badge-info">Near Expiry</span></div>
              <div class="stock-alert-card low"><div><div class="fw-600" style="font-size:.85rem">Atorvastatin 20mg</div><small class="text-muted">Current: 45 | Min: 60</small></div><span class="badge-custom badge-warning">Low</span></div>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</div>

<div id="toast-container"></div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="../assets/js/main.js"></script>
<script src="../assets/js/pharmacist.js"></script>
<script>
document.addEventListener('DOMContentLoaded', () => {
  document.getElementById('headerMount').innerHTML = PH_HEADER('Dashboard', 'Dashboard');
  initSidebar('phSidebar', 'phOverlay');

  // Sales Chart
  new Chart(document.getElementById('salesChart'), {
    type: 'line',
    data: {
      labels: ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'],
      datasets: [{
        label: 'Revenue (₹)',
        data: [42000, 58000, 51000, 74000, 63000, 89000, 84000],
        borderColor: '#1a6bcc',
        backgroundColor: 'rgba(26,107,204,.08)',
        borderWidth: 2.5,
        fill: true,
        tension: 0.4,
        pointBackgroundColor: '#1a6bcc',
        pointRadius: 4,
      }]
    },
    options: { responsive: true, plugins: { legend: { display: false } }, scales: { y: { grid: { color: 'rgba(0,0,0,.05)' }, ticks: { callback: v => '₹' + (v/1000) + 'K' } }, x: { grid: { display: false } } } }
  });

  // Category Chart
  new Chart(document.getElementById('catChart'), {
    type: 'doughnut',
    data: {
      labels: ['Pain Relief','Antibiotics','Vitamins','Cardiology','Diabetes','Others'],
      datasets: [{ data: [28, 22, 18, 14, 10, 8], backgroundColor: ['#1a6bcc','#22c55e','#f59e0b','#ef4444','#8b5cf6','#00b4d8'], borderWidth: 0 }]
    },
    options: { responsive: true, plugins: { legend: { position: 'bottom', labels: { font: { size: 11 }, padding: 12 } } }, cutout: '65%' }
  });
});
</script>
</body>
</asp:Content>
