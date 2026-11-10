<%@ Page Title="Stock Alerts — Pharmacist Portal | MediCare" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="stock-alerts.aspx.cs" Inherits="medicare.pharmacist.stockAlerts" %>

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
      <a class="sidebar-nav-link active" href="inventory.aspx"><i class="bi bi-boxes"></i>Inventory &amp; Alerts</a>
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
      <!-- Alert Summary -->
      <div class="row g-3 mb-4">
        <div class="col-6 col-lg-3"><div class="stat-card stat-orange"><div class="d-flex justify-content-between align-items-start mb-2"><div class="stat-icon">⚠️</div><span class="badge bg-white bg-opacity-25 text-white" style="font-size:.7rem">Alert</span></div><div class="stat-value"><asp:Label ID="lblTotalAlerts" runat="server" Text="0" ClientIDMode="Static" /></div><div class="stat-label">Total Alerts</div></div></div>
        <div class="col-6 col-lg-3"><div class="stat-card stat-red"><div class="stat-icon mb-2">📉</div><div class="stat-value"><asp:Label ID="lblLowStockCount" runat="server" Text="0" ClientIDMode="Static" /></div><div class="stat-label">Low Stock Items</div></div></div>
        <div class="col-6 col-lg-3"><div class="stat-card stat-purple"><div class="stat-icon mb-2">⏰</div><div class="stat-value"><asp:Label ID="lblNearExpiryCount" runat="server" Text="0" ClientIDMode="Static" /></div><div class="stat-label">Near Expiry</div></div></div>
        <div class="col-6 col-lg-3"><div class="stat-card stat-red"><div class="stat-icon mb-2">🚫</div><div class="stat-value"><asp:Label ID="lblExpiredCount" runat="server" Text="0" ClientIDMode="Static" /></div><div class="stat-label">Expired Items</div></div></div>
      </div>

      <!-- Critical Alert Banner -->
      <div class="alert d-flex align-items-start gap-3 mb-4" id="expiredBanner" style="border-radius:12px;border:none;background:rgba(239,68,68,.08);border-left:4px solid #ef4444;display:none">
        <i class="bi bi-exclamation-octagon-fill text-danger" style="font-size:1.5rem;margin-top:2px"></i>
        <div>
          <h6 class="fw-700 text-danger mb-1" id="expiredBannerTitle">🚨 Critical Expired Medicines Found</h6>
          <p class="mb-0 text-muted" style="font-size:.88rem">These medicines must be removed from stock immediately and cannot be dispensed.</p>
        </div>
      </div>

      <!-- Expired Medicines -->
      <div class="data-card mb-4">
        <div class="data-card-header">
          <div class="data-card-title"><i class="bi bi-x-octagon-fill text-danger me-2"></i>Expired Medicines</div>
          <button type="button" class="btn btn-danger-custom fw-600 btn-sm" onclick="removeAllExpired()"><i class="bi bi-trash me-1"></i>Remove All</button>
        </div>
        <div class="table-wrap">
          <asp:GridView ID="gvExpired" runat="server" AutoGenerateColumns="False"
            OnRowCommand="gvExpired_RowCommand" CssClass="table table-bordered table-striped"
            ClientIDMode="Static">
            <Columns>
              <asp:BoundField DataField="MedicineName" HeaderText="Medicine" />
              <asp:BoundField DataField="BatchNumber" HeaderText="Batch" />
              <asp:BoundField DataField="CategoryName" HeaderText="Category" />
              <asp:BoundField DataField="ExpiryDate" HeaderText="Expiry Date" DataFormatString="{0:dd-MMM-yyyy}" />
              <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
              <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                  <span class="badge-custom badge-danger">Expired</span>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                  <asp:LinkButton ID="btnRemoveExpired" runat="server" CommandName="cmd_remove" CommandArgument='<%# Eval("BatchID") %>'
                    CssClass="btn btn-sm btn-danger-custom">
                    <i class="bi bi-trash me-1"></i>Remove
                  </asp:LinkButton>
                </ItemTemplate>
              </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
              <div class="text-center py-4 text-muted">
                <i class="bi bi-check-circle-fill text-success fs-3 d-block mb-2"></i>
                No expired medicines found.
              </div>
            </EmptyDataTemplate>
          </asp:GridView>
        </div>
      </div>

      <!-- Low Stock Table -->
      <div class="data-card">
        <div class="data-card-header">
          <div class="data-card-title"><i class="bi bi-exclamation-triangle-fill text-warning me-2"></i>Low Stock Medicines</div>
          <button type="button" class="btn btn-primary-custom fw-600 btn-sm" onclick="showToast('Bulk reorders initiated','info')"><i class="bi bi-truck me-1"></i>Reorder All</button>
        </div>
        <div class="table-wrap">
          <asp:GridView ID="gvAlerts" runat="server" AutoGenerateColumns="False"
            OnRowCommand="gvAlerts_RowCommand" CssClass="table table-bordered table-striped"
            ClientIDMode="Static">
            <Columns>
              <asp:BoundField DataField="MedicineName" HeaderText="Medicine" />
              <asp:BoundField DataField="Stock" HeaderText="Current Stock" />
              <asp:BoundField DataField="MinStockLevel" HeaderText="Min Required" />
              <asp:BoundField DataField="Shortage" HeaderText="Deficit" />
              <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                  <span class="badge-custom badge-warning">Low Stock</span>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                  <asp:LinkButton ID="btnReorderAlert" runat="server" CommandName="cmd_reorder" CommandArgument='<%# Eval("MedicineID") %>'
                    CssClass="btn btn-sm btn-primary-custom">
                    <i class="bi bi-truck me-1"></i>Reorder
                  </asp:LinkButton>
                </ItemTemplate>
              </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
              <div class="text-center py-4 text-muted">
                <i class="bi bi-check-circle-fill text-success fs-3 d-block mb-2"></i>
                No low stock medicines found.
              </div>
            </EmptyDataTemplate>
          </asp:GridView>
        </div>
      </div>
    </main>
  </div>
</div>

<!-- Reorder Modal -->
<div class="modal fade modal-custom" id="reorderModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header"><h5 class="modal-title fw-700">Reorder Stock</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
      <div class="modal-body">
        <div class="mb-3"><label class="form-label fw-600 small">Medicine</label><asp:TextBox ID="reorderMed" runat="server" CssClass="form-control form-control-custom" ReadOnly="true" ClientIDMode="Static" /></div>
        <div class="mb-3"><label class="form-label fw-600 small">Supplier</label>
          <asp:DropDownList ID="ddlSupplierAlerts" runat="server" CssClass="form-control form-control-custom" ClientIDMode="Static">
            <asp:ListItem>Apex Pharma Labs</asp:ListItem>
            <asp:ListItem>Sun Pharma Distributors</asp:ListItem>
            <asp:ListItem>Cipla Logistics</asp:ListItem>
          </asp:DropDownList>
        </div>
        <div class="row g-3">
          <div class="col-6"><label class="form-label fw-600 small">Quantity to Order</label><asp:TextBox ID="txtOrderQtyAlerts" runat="server" TextMode="Number" CssClass="form-control form-control-custom" placeholder="100" ClientIDMode="Static" /></div>
          <div class="col-6"><label class="form-label fw-600 small">Priority</label>
            <asp:DropDownList ID="ddlPriorityAlerts" runat="server" CssClass="form-control form-control-custom" ClientIDMode="Static">
              <asp:ListItem>Normal</asp:ListItem>
              <asp:ListItem>Urgent</asp:ListItem>
              <asp:ListItem>Emergency</asp:ListItem>
            </asp:DropDownList>
          </div>
        </div>
        <div class="mt-3"><label class="form-label fw-600 small">Notes</label><asp:TextBox ID="txtNotesAlerts" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control form-control-custom" placeholder="Additional notes" ClientIDMode="Static" /></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <asp:LinkButton ID="btnPlaceReorderAlerts" runat="server" CssClass="btn btn-primary-custom fw-600" OnClick="btnPlaceReorderAlerts_Click" ClientIDMode="Static"><i class="bi bi-truck me-1"></i>Place Order</asp:LinkButton>
      </div>
    </div>
  </div>
</div>

<div id="toast-container"></div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="../assets/js/main.js"></script>
<script src="../assets/js/pharmacist.js"></script>
<script>
let alertsData = {
  low: [
    { name: 'Salbutamol Inhaler', current: 15, min: 50 },
    { name: 'Atorvastatin 20mg', current: 20, min: 60 }
  ],
  expired: [
    { name: 'Penicillin 250mg', batch: 'PEN-8812', category: 'Antibiotics', expiry: '2026-08-15', qty: 25 }
  ],
  nearExpiry: [
    { name: 'Doxycycline 100mg', batch: 'DOX-4091', category: 'Antibiotics', expiry: '2026-10-15', qty: 40 }
  ]
};

function renderAlerts() {
  if (typeof DummyData !== 'undefined' && DummyData.stockAlerts) {
    alertsData = DummyData.stockAlerts;
  }
  const low = alertsData.low || [];
  const exp = alertsData.expired || [];
  const near = alertsData.nearExpiry || [];
  const total = low.length + exp.length + near.length;

  document.getElementById('statTotalAlerts').textContent = total;
  document.getElementById('statLowStockCount').textContent = low.length;
  document.getElementById('statNearExpiryCount').textContent = near.length;
  document.getElementById('statExpiredCount').textContent = exp.length;

  if (exp.length > 0) {
    document.getElementById('expiredBanner').style.display = 'flex';
    document.getElementById('expiredBannerTitle').textContent = `🚨 Critical: ${exp.length} Expired Medicine(s) Found`;
  }

  document.getElementById('expiredTableBody').innerHTML = exp.length ? exp.map(e => `
    <tr style="background:rgba(239,68,68,.03)">
      <td class="fw-600">${e.name}</td>
      <td class="text-muted small">${e.batch}</td>
      <td><span class="badge-custom badge-info">${e.category}</span></td>
      <td class="text-danger fw-600">${e.expiry}</td>
      <td>${e.qty} units</td>
      <td><span class="badge-custom badge-danger">Expired</span></td>
      <td>
        <div class="d-flex gap-1">
          <button type="button" class="btn btn-sm btn-danger-custom py-0 px-2" onclick="showToast('Batch flagged for disposal','success')"><i class="bi bi-trash"></i></button>
          <button type="button" class="btn btn-sm btn-outline-primary-custom py-0 px-2" onclick="reorder('${e.name}')" title="Reorder"><i class="bi bi-truck"></i></button>
        </div>
      </td>
    </tr>`).join('') : '<tr><td colspan="7" class="text-center text-muted py-3">No expired medicines</td></tr>';

  document.getElementById('lowTableBody').innerHTML = low.length ? low.map(l => `
    <tr>
      <td class="fw-600">${l.name}</td>
      <td class="fw-700 text-danger">${l.current}</td>
      <td class="text-muted">${l.min}</td>
      <td class="text-danger fw-600">-${l.min - l.current}</td>
      <td><span class="badge-custom badge-warning">Low</span></td>
      <td>
        <button type="button" class="btn btn-sm btn-outline-primary-custom py-0 px-2" onclick="reorder('${l.name}')"><i class="bi bi-truck me-1"></i>Reorder</button>
      </td>
    </tr>`).join('') : '<tr><td colspan="6" class="text-center text-muted py-3">All stocks healthy</td></tr>';
}

function reorder(name) {
  document.getElementById('reorderMed').value = name;
  new bootstrap.Modal(document.getElementById('reorderModal')).show();
}

function placeReorder() {
  const name = document.getElementById('reorderMed').value;
  bootstrap.Modal.getInstance(document.getElementById('reorderModal')).hide();
  showToast('Reorder successfully placed for ' + name, 'success');
}

function removeAllExpired() {
  showConfirm({
    title: 'Remove All Expired?',
    message: 'This will flag all expired batches for disposal.',
    onConfirm: () => {
      alertsData.expired = [];
      renderAlerts();
      showToast('Expired medicines flagged for disposal', 'success');
    }
  });
}

document.addEventListener('DOMContentLoaded', () => {
  document.getElementById('headerMount').innerHTML = PH_HEADER('Stock Alerts', 'Inventory / Stock Alerts');
  initSidebar('phSidebar', 'phOverlay');
  renderAlerts();
});
</script>
</body>
</asp:Content>
