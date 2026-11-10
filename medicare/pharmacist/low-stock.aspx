<%@ Page Title="Low Stock Alerts — Pharmacist Portal | MediCare" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="low-stock.aspx.cs" Inherits="medicare.pharmacist.lowStock" %>

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
        <a class="sidebar-subnav-link active" href="low-stock.aspx"><i class="bi bi-exclamation-triangle"></i>Low Stock</a>
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
      <!-- Stats -->
      <div class="row g-3 mb-4">
        <div class="col-6 col-lg-3">
          <div class="stat-card stat-orange">
            <div class="d-flex justify-content-between align-items-start mb-2">
              <div class="stat-icon"><i class="bi bi-exclamation-triangle-fill"></i></div>
              <span class="badge-custom badge-warning">Low</span>
            </div>
            <div class="stat-value"><asp:Label ID="lblLowCount" runat="server" Text="0" ClientIDMode="Static" /></div>
            <div class="stat-label">Low Stock Items</div>
          </div>
        </div>
        <div class="col-6 col-lg-3">
          <div class="stat-card stat-red">
            <div class="d-flex justify-content-between align-items-start mb-2">
              <div class="stat-icon"><i class="bi bi-dash-circle-fill"></i></div>
              <span class="badge-custom badge-danger">Critical</span>
            </div>
            <div class="stat-value"><asp:Label ID="lblCritical" runat="server" Text="0" ClientIDMode="Static" /></div>
            <div class="stat-label">Critical (Deficit &gt; 50%)</div>
          </div>
        </div>
        <div class="col-6 col-lg-3">
          <div class="stat-card stat-blue">
            <div class="d-flex justify-content-between align-items-start mb-2">
              <div class="stat-icon"><i class="bi bi-boxes"></i></div>
              <span class="stat-trend">Deficit</span>
            </div>
            <div class="stat-value"><asp:Label ID="lblTotalDeficit" runat="server" Text="0" ClientIDMode="Static" /></div>
            <div class="stat-label">Total Units Needed</div>
          </div>
        </div>
        <div class="col-6 col-lg-3">
          <div class="stat-card stat-cyan">
            <div class="d-flex justify-content-between align-items-start mb-2">
              <div class="stat-icon"><i class="bi bi-truck"></i></div>
              <span class="stat-trend">Pending</span>
            </div>
            <div class="stat-value"><asp:Label ID="lblPendingPO" runat="server" Text="0" ClientIDMode="Static" /></div>
            <div class="stat-label">Open Purchase Orders</div>
          </div>
        </div>
      </div>

      <!-- Alert Banner -->
      <div class="admin-alert-strip warning mb-4" id="lowStockBanner" style="display:none">
        <i class="bi bi-exclamation-triangle-fill"></i>
        <span id="lowStockBannerText">Stock levels below minimum safety threshold.</span>
      </div>

      <!-- Low Stock Table -->
      <div class="data-card mb-4">
        <div class="data-card-header">
          <div>
            <div class="data-card-title"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>Items Below Minimum Level</div>
            <div class="text-muted small mt-1" id="countLabel">Medicines needing attention</div>
          </div>
          <div class="d-flex gap-2 flex-wrap">
            <div class="search-bar" style="max-width:220px">
              <i class="bi bi-search"></i>
              <asp:TextBox ID="searchLowStock" runat="server" CssClass="form-control" placeholder="Search medicines..." ClientIDMode="Static" />
            </div>
            <asp:LinkButton ID="btnReorderAll" runat="server" CssClass="btn btn-primary-custom fw-600" ClientIDMode="Static" OnClick="btnReorderAll_Click">
              <i class="bi bi-truck me-1"></i>Reorder All
            </asp:LinkButton>
            <asp:LinkButton ID="btnExportLowStock" runat="server" CssClass="btn btn-outline-primary-custom fw-600" ClientIDMode="Static" OnClientClick="showToast('Low stock report exported','info'); return false;">
              <i class="bi bi-download me-1"></i>Export
            </asp:LinkButton>
          </div>
        </div>
        <div class="table-wrap">
          <asp:GridView ID="gvLowStock" runat="server" AutoGenerateColumns="False"
            OnRowCommand="gvLowStock_RowCommand" CssClass="table table-bordered table-striped"
            ClientIDMode="Static">
            <Columns>
              <asp:TemplateField HeaderText="Medicine ID">
                <ItemTemplate>
                  <asp:Label ID="Label1" runat="server" Text='<%# Eval("MedicineID") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Medicine">
                <ItemTemplate>
                  <asp:Label ID="Label2" runat="server" Text='<%# Eval("Name") %>' CssClass="fw-600"></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Current Stock">
                <ItemTemplate>
                  <span class="fw-700 text-danger"><%# Eval("Stock") %></span>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Minimum Required">
                <ItemTemplate>
                  <span class="text-muted"><%# Eval("MinStockLevel") %></span>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Shortage">
                <ItemTemplate>
                  <span class="fw-700 text-danger">-<%# Eval("Shortage") %></span>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                  <asp:LinkButton ID="btnReorder" runat="server" CommandName="cmd_reorder" CommandArgument='<%# Eval("MedicineID") %>'
                    CssClass="btn btn-sm btn-primary-custom">
                    <i class="bi bi-truck me-1"></i>Reorder
                  </asp:LinkButton>
                </ItemTemplate>
              </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
              <div class="text-center py-4 text-muted">
                <i class="bi bi-check-circle-fill text-success fs-3 d-block mb-2"></i>
                All medicines are adequately stocked!
              </div>
            </EmptyDataTemplate>
          </asp:GridView>
        </div>
      </div>

      <!-- Category Breakdown -->
      <div class="data-card">
        <div class="data-card-header">
          <div class="data-card-title"><i class="bi bi-grid-1x2-fill text-primary me-2"></i>Stock Status by Category</div>
        </div>
        <div class="p-4">
          <div class="row g-3" id="categoryBreakdown"></div>
        </div>
      </div>
    </main>
  </div>
</div>

<!-- Reorder Modal -->
<div class="modal fade modal-custom" id="reorderModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title fw-700"><i class="bi bi-truck me-2"></i>Reorder Stock</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <div class="mb-3">
          <label class="form-label fw-600 small">Medicine</label>
          <asp:TextBox ID="modalMedName" runat="server" CssClass="form-control form-control-custom" ReadOnly="true" ClientIDMode="Static" />
        </div>
        <div class="mb-3">
          <label class="form-label fw-600 small">Supplier</label>
          <asp:DropDownList ID="modalSupplier" runat="server" CssClass="form-control form-control-custom" ClientIDMode="Static">
            <asp:ListItem>Apex Pharma Labs</asp:ListItem>
            <asp:ListItem>Sun Pharma Distributors</asp:ListItem>
            <asp:ListItem>Cipla Logistics</asp:ListItem>
          </asp:DropDownList>
        </div>
        <div class="row g-3">
          <div class="col-6">
            <label class="form-label fw-600 small">Quantity to Order</label>
            <asp:TextBox ID="modalQty" runat="server" TextMode="Number" CssClass="form-control form-control-custom" placeholder="100" ClientIDMode="Static" />
          </div>
          <div class="col-6">
            <label class="form-label fw-600 small">Priority</label>
            <asp:DropDownList ID="modalPriority" runat="server" CssClass="form-control form-control-custom" ClientIDMode="Static">
              <asp:ListItem>Normal</asp:ListItem>
              <asp:ListItem>Urgent</asp:ListItem>
              <asp:ListItem>Emergency</asp:ListItem>
            </asp:DropDownList>
          </div>
        </div>
        <div class="mt-3">
          <label class="form-label fw-600 small">Notes</label>
          <asp:TextBox ID="modalNotes" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control form-control-custom" placeholder="Any special instructions..." ClientIDMode="Static" />
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary-custom" data-bs-dismiss="modal">Cancel</button>
        <asp:LinkButton ID="btnSubmitReorder" runat="server" CssClass="btn btn-primary-custom fw-600" ClientIDMode="Static" OnClick="btnSubmitReorder_Click">
          <i class="bi bi-check-lg me-1"></i>Place Reorder
        </asp:LinkButton>
      </div>
    </div>
  </div>
</div>

<div id="toast-container"></div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="../assets/js/main.js"></script>
<script src="../assets/js/pharmacist.js"></script>
<script>
document.addEventListener('DOMContentLoaded', () => {
  document.getElementById('headerMount').innerHTML = PH_HEADER('Low Stock', 'Inventory / Low Stock');
  initSidebar('phSidebar', 'phOverlay');

  const items = (typeof DummyData !== 'undefined' && DummyData.stockAlerts && DummyData.stockAlerts.low)
    ? DummyData.stockAlerts.low
    : [
        { name: 'Salbutamol Inhaler', category: 'Respiratory', current: 15, min: 50 },
        { name: 'Atorvastatin 20mg', category: 'Cardiology', current: 20, min: 60 },
        { name: 'Amoxicillin 500mg', category: 'Antibiotics', current: 30, min: 80 }
      ];

  const lastReorders = ['3 days ago', '1 week ago', '5 days ago', '2 weeks ago', 'Never'];

  document.getElementById('statLowCount').textContent = items.length;
  const critical = items.filter(i => (i.min - i.current) / i.min > 0.5);
  document.getElementById('statCritical').textContent = critical.length;
  document.getElementById('statTotalDeficit').textContent = items.reduce((s, i) => s + (i.min - i.current), 0);
  document.getElementById('countLabel').textContent = `${items.length} item${items.length !== 1 ? 's' : ''} need attention`;

  if (items.length > 0) {
    document.getElementById('lowStockBanner').style.display = 'flex';
    document.getElementById('lowStockBannerText').textContent =
      `${items.length} medicine(s) are below minimum stock level. Reorder as soon as possible.`;
  }

  const tbody = document.getElementById('lowStockBody');
  items.forEach((item, idx) => {
    const deficit = item.min - item.current;
    const pct = Math.round((deficit / item.min) * 100);
    const isCrit = pct > 50;
    tbody.innerHTML += `<tr style="${isCrit ? 'background:rgba(239,68,68,.04)' : ''}">
      <td class="fw-600">${item.name}</td>
      <td><span class="badge-custom badge-info">${item.category || 'General'}</span></td>
      <td>
        <span class="fw-700 ${isCrit ? 'text-danger' : 'text-warning'}">${item.current}</span>
        <div class="mt-1" style="height:4px;border-radius:2px;background:var(--gray-200);width:80px">
          <div style="height:100%;border-radius:2px;background:${isCrit ? '#ef4444' : '#f59e0b'};width:${Math.max(5, Math.round((item.current/item.min)*100))}%"></div>
        </div>
      </td>
      <td class="text-muted">${item.min}</td>
      <td class="fw-700 text-danger">-${deficit} <small class="text-muted fw-400">(${pct}%)</small></td>
      <td><span class="badge-custom ${isCrit ? 'badge-danger' : 'badge-warning'}">${isCrit ? 'Critical' : 'Low Stock'}</span></td>
      <td class="text-muted small">${lastReorders[idx % lastReorders.length]}</td>
      <td>
        <div class="d-flex gap-1">
          <button type="button" class="btn btn-sm btn-primary-custom" onclick="openReorder('${item.name}')">
            <i class="bi bi-truck me-1"></i>Reorder
          </button>
          <button type="button" class="btn btn-sm btn-outline-primary-custom" onclick="showToast('Stock history for ${item.name}','info')">
            <i class="bi bi-clock-history"></i>
          </button>
        </div>
      </td>
    </tr>`;
  });

  if (!items.length) {
    tbody.innerHTML = '<tr><td colspan="8" class="text-center text-muted py-4"><i class="bi bi-check-circle-fill text-success me-2"></i>All medicines are adequately stocked!</td></tr>';
  }

  // Category breakdown
  const cats = [...new Set(items.map(i => i.category || 'General'))];
  const catDiv = document.getElementById('categoryBreakdown');
  cats.forEach(cat => {
    const count = items.filter(i => (i.category || 'General') === cat).length;
    catDiv.innerHTML += `
      <div class="col-6 col-md-3">
        <div class="p-3 rounded-3 text-center" style="background:rgba(245,158,11,.08);border:1px solid rgba(245,158,11,.2)">
          <div class="fw-700" style="font-size:1.5rem;color:#d97706">${count}</div>
          <div class="small text-muted mt-1">${cat}</div>
        </div>
      </div>`;
  });
  if (!cats.length) catDiv.innerHTML = '<div class="col-12 text-muted text-center py-2">No category data available</div>';

  filterTable('searchLowStock', 'lowStockTable');
});

function openReorder(name) {
  document.getElementById('modalMedName').value = name;
  new bootstrap.Modal(document.getElementById('reorderModal')).show();
}

function submitReorder() {
  const med = document.getElementById('modalMedName').value;
  bootstrap.Modal.getInstance(document.getElementById('reorderModal')).hide();
  showToast('Reorder placed for ' + med, 'success');
}

function reorderAll() {
  showToast('Bulk reorder initiated for all low-stock items', 'success');
}
</script>
</body>
</asp:Content>
