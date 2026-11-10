<%@ Page Title="Expiring Soon — Pharmacist Portal | MediCare" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="expiring-soon.aspx.cs" Inherits="medicare.pharmacist.expiringSoon" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link rel="stylesheet" href="<%= ResolveUrl("~/assets/css/pharmacist.css") %>" />
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
      <a class="sidebar-nav-link " href="dashboard.aspx">
        <i class="bi bi-speedometer2"></i>Dashboard
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link " href="medicine-management.aspx">
        <i class="bi bi-capsule"></i>Medicine Management
      </a>
    </div>

    <div class="sidebar-label">Operations</div>
    <div class="sidebar-nav-item expanded">
      <a class="sidebar-nav-link " href="inventory.aspx"><i class="bi bi-boxes"></i>Inventory &amp; Alerts</a>
      <div class="sidebar-subnav">
        <a class="sidebar-subnav-link " href="stock-in.aspx"><i class="bi bi-box-arrow-in-down"></i>Stock In</a>
        <a class="sidebar-subnav-link " href="stock-out.aspx"><i class="bi bi-box-arrow-up"></i>Stock Out</a>
        <a class="sidebar-subnav-link " href="low-stock.aspx"><i class="bi bi-exclamation-triangle"></i>Low Stock</a>
        <a class="sidebar-subnav-link active" href="expiring-soon.aspx"><i class="bi bi-clock-history"></i>Expiring Soon</a>
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
      <!-- Stats Row -->
      <div class="row g-3 mb-4">
        <div class="col-6 col-lg-3">
          <div class="stat-card stat-orange">
            <div class="d-flex justify-content-between align-items-start mb-2">
              <div class="stat-icon"><i class="bi bi-clock-history"></i></div>
              <span class="badge-custom badge-warning">Action</span>
            </div>
            <div class="stat-value"><asp:Label ID="lblWithin30" runat="server" Text="0" ClientIDMode="Static" /></div>
            <div class="stat-label">Expiring ≤ 30 Days</div>
          </div>
        </div>
        <div class="col-6 col-lg-3">
          <div class="stat-card stat-red">
            <div class="d-flex justify-content-between align-items-start mb-2">
              <div class="stat-icon"><i class="bi bi-exclamation-triangle-fill"></i></div>
              <span class="badge-custom badge-danger">Critical</span>
            </div>
            <div class="stat-value"><asp:Label ID="lblWithin14" runat="server" Text="0" ClientIDMode="Static" /></div>
            <div class="stat-label">Critical (≤ 14 Days)</div>
          </div>
        </div>
        <div class="col-6 col-lg-3">
          <div class="stat-card stat-cyan">
            <div class="d-flex justify-content-between align-items-start mb-2">
              <div class="stat-icon"><i class="bi bi-calendar-range"></i></div>
              <span class="stat-trend">Review</span>
            </div>
            <div class="stat-value"><asp:Label ID="lblWithin60" runat="server" Text="0" ClientIDMode="Static" /></div>
            <div class="stat-label">Expiring ≤ 60 Days</div>
          </div>
        </div>
        <div class="col-6 col-lg-3">
          <div class="stat-card stat-blue">
            <div class="d-flex justify-content-between align-items-start mb-2">
              <div class="stat-icon"><i class="bi bi-box-seam"></i></div>
              <span class="stat-trend">Total</span>
            </div>
            <div class="stat-value"><asp:Label ID="lblTotalQty" runat="server" Text="0" ClientIDMode="Static" /></div>
            <div class="stat-label">Units at Risk</div>
          </div>
        </div>
      </div>

      <!-- Alert Banner -->
      <div class="admin-alert-strip danger mb-4" id="criticalBanner" style="display:none">
        <i class="bi bi-exclamation-octagon-fill"></i>
        <span id="criticalBannerText">Critical: medicines expiring within 14 days require immediate review.</span>
      </div>

      <!-- Expiring Table -->
      <div class="data-card mb-4">
        <div class="data-card-header">
          <div>
            <div class="data-card-title"><i class="bi bi-clock-history text-danger me-2"></i>Upcoming Expiry Batches</div>
            <div class="text-muted small mt-1">Items expiring within the next 60 days</div>
          </div>
          <div class="d-flex gap-2 flex-wrap">
            <asp:DropDownList ID="expiryFilter" runat="server" CssClass="form-select form-control-custom" style="max-width:160px;height:40px;font-size:.88rem" ClientIDMode="Static">
              <asp:ListItem Value="all">All Items</asp:ListItem>
              <asp:ListItem Value="14">≤ 14 Days</asp:ListItem>
              <asp:ListItem Value="30">≤ 30 Days</asp:ListItem>
              <asp:ListItem Value="60">≤ 60 Days</asp:ListItem>
            </asp:DropDownList>
            <asp:LinkButton ID="btnExportExpiry" runat="server" CssClass="btn btn-outline-primary-custom fw-600" ClientIDMode="Static" OnClientClick="showToast('Expiry report exported','info'); return false;">
              <i class="bi bi-download me-1"></i>Export
            </asp:LinkButton>
          </div>
        </div>
        <div class="table-wrap">
          <asp:GridView ID="gvExpiring" runat="server" AutoGenerateColumns="False"
            OnRowCommand="gvExpiring_RowCommand" CssClass="table table-bordered table-striped"
            ClientIDMode="Static">
            <Columns>
              <asp:TemplateField HeaderText="Medicine">
                <ItemTemplate>
                  <asp:Label ID="Label1" runat="server" Text='<%# Eval("MedicineName") %>' CssClass="fw-600"></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Batch No.">
                <ItemTemplate>
                  <code><%# Eval("BatchNumber") %></code>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Expiry Date">
                <ItemTemplate>
                  <span class="expiry-warn"><%# Eval("ExpiryDate", "{0:dd-MMM-yyyy}") %></span>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Units">
                <ItemTemplate>
                  <asp:Label ID="Label2" runat="server" Text='<%# Eval("Quantity") %>' CssClass="fw-600"></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Days Left">
                <ItemTemplate>
                  <span class="fw-700 text-danger"><%# Eval("DaysLeft") %> days</span>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                  <asp:LinkButton ID="btnReview" runat="server" CommandName="cmd_review" CommandArgument='<%# Eval("BatchID") %>'
                    CssClass="btn btn-sm btn-outline-primary-custom">
                    <i class="bi bi-tag me-1"></i>Review
                  </asp:LinkButton>
                </ItemTemplate>
              </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
              <div class="text-center py-4 text-muted">
                <i class="bi bi-check-circle-fill text-success fs-3 d-block mb-2"></i>
                No items near expiry found!
              </div>
            </EmptyDataTemplate>
          </asp:GridView>
        </div>
      </div>

      <!-- Recommended Actions -->
      <div class="data-card">
        <div class="data-card-header">
          <div class="data-card-title"><i class="bi bi-lightbulb text-warning me-2"></i>Recommended Actions</div>
        </div>
        <div class="p-4">
          <div class="row g-3">
            <div class="col-md-4">
              <div class="d-flex align-items-start gap-3 p-3 rounded-3" style="background:rgba(239,68,68,.06);border:1px solid rgba(239,68,68,.15)">
                <div class="mt-1" style="color:#ef4444;font-size:1.3rem"><i class="bi bi-tag-fill"></i></div>
                <div>
                  <div class="fw-700 mb-1" style="font-size:.9rem">Apply Discounts</div>
                  <p class="text-muted mb-0" style="font-size:.82rem">Offer discounts on near-expiry items to accelerate sales and reduce waste.</p>
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="d-flex align-items-start gap-3 p-3 rounded-3" style="background:rgba(245,158,11,.06);border:1px solid rgba(245,158,11,.15)">
                <div class="mt-1" style="color:#d97706;font-size:1.3rem"><i class="bi bi-arrow-repeat"></i></div>
                <div>
                  <div class="fw-700 mb-1" style="font-size:.9rem">Return to Supplier</div>
                  <p class="text-muted mb-0" style="font-size:.82rem">Contact suppliers about return or exchange policies before expiry date.</p>
                </div>
              </div>
            </div>
            <div class="col-md-4">
              <div class="d-flex align-items-start gap-3 p-3 rounded-3" style="background:rgba(6,182,212,.06);border:1px solid rgba(6,182,212,.15)">
                <div class="mt-1" style="color:#0891b2;font-size:1.3rem"><i class="bi bi-clipboard2-pulse"></i></div>
                <div>
                  <div class="fw-700 mb-1" style="font-size:.9rem">Audit &amp; Document</div>
                  <p class="text-muted mb-0" style="font-size:.82rem">Record disposal of expired items with proper documentation for compliance.</p>
                </div>
              </div>
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
  document.getElementById('headerMount').innerHTML = PH_HEADER('Expiring Soon', 'Inventory / Expiring Soon');
  initSidebar('phSidebar', 'phOverlay');

  const items = (typeof DummyData !== 'undefined' && DummyData.stockAlerts && DummyData.stockAlerts.nearExpiry)
    ? DummyData.stockAlerts.nearExpiry
    : [
        { name: 'Penicillin 250mg', batch: 'PEN-8812', category: 'Antibiotics', expiry: '2026-10-05', qty: 25, daysLeft: 14 },
        { name: 'Doxycycline 100mg', batch: 'DOX-4091', category: 'Antibiotics', expiry: '2026-10-12', qty: 40, daysLeft: 21 },
        { name: 'Cefixime 200mg', batch: 'CEF-3321', category: 'Antibiotics', expiry: '2026-10-25', qty: 15, daysLeft: 34 },
        { name: 'Insulin Glargine', batch: 'INS-0098', category: 'Diabetes', expiry: '2026-11-10', qty: 12, daysLeft: 50 }
      ];

  const within14 = items.filter(i => i.daysLeft <= 14);
  const within30 = items.filter(i => i.daysLeft <= 30);
  document.getElementById('statWithin14').textContent = within14.length;
  document.getElementById('statWithin30').textContent = within30.length;
  document.getElementById('statWithin60').textContent = items.length;
  document.getElementById('statTotalQty').textContent = items.reduce((s,i) => s + (i.qty||0), 0);

  if (within14.length > 0) {
    document.getElementById('criticalBanner').style.display = 'flex';
    document.getElementById('criticalBannerText').textContent =
      `Critical: ${within14.length} medicine batch(es) expiring within 14 days require immediate review.`;
  }

  function renderExpiry(filtered) {
    const tbody = document.getElementById('expiryBody');
    tbody.innerHTML = '';
    filtered.forEach(item => {
      const urgent = item.daysLeft <= 14;
      const warn   = item.daysLeft <= 30;
      const rowBg  = urgent ? 'rgba(239,68,68,.04)' : warn ? 'rgba(245,158,11,.03)' : '';
      const badge  = urgent ? 'badge-danger' : warn ? 'badge-warning' : 'badge-info';
      const label  = urgent ? 'Critical' : warn ? 'Warning' : 'Monitor';
      tbody.innerHTML += `<tr style="background:${rowBg}">
        <td class="fw-600">${item.name}</td>
        <td><code style="font-size:.82rem;background:rgba(139,92,246,.08);color:#7c3aed;padding:.2em .5em;border-radius:4px">${item.batch}</code></td>
        <td><span class="badge-custom badge-info">${item.category}</span></td>
        <td class="${urgent ? 'expiry-exp' : 'expiry-warn'}">${item.expiry}</td>
        <td class="fw-600">${item.qty || '-'}</td>
        <td><span class="fw-700 ${urgent ? 'text-danger' : warn ? 'text-warning' : 'text-info'}">${item.daysLeft} days</span></td>
        <td><span class="badge-custom ${badge}">${label}</span></td>
        <td>
          <div class="d-flex gap-1">
            <button class="btn btn-sm btn-outline-primary-custom" onclick="showToast('Review opened for ${item.name}','info')"><i class="bi bi-tag me-1"></i>Review</button>
            <button class="btn btn-sm btn-danger-custom" onclick="showToast('Disposal logged for ${item.name}','warning')"><i class="bi bi-trash3"></i></button>
          </div>
        </td>
      </tr>`;
    });
    if (!filtered.length) {
      tbody.innerHTML = '<tr><td colspan="8" class="text-center text-muted py-4"><i class="bi bi-check-circle-fill text-success me-2"></i>No expiring items found</td></tr>';
    }
  }

  renderExpiry(items);

  document.getElementById('expiryFilter').addEventListener('change', function() {
    const val = this.value;
    renderExpiry(val === 'all' ? items : items.filter(i => i.daysLeft <= parseInt(val)));
  });
});
</script>
</body>
</asp:Content>
