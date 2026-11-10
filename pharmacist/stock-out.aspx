<%@ Page Title="Stock Out — Pharmacist Portal | MediCare" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="stock-out.aspx.cs" Inherits="medicare.pharmacist.stockOut" %>

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
        <a class="sidebar-subnav-link active" href="stock-out.aspx"><i class="bi bi-box-arrow-up"></i>Stock Out</a>
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
      <!-- Stats -->
      <div class="row g-3 mb-4">
        <div class="col-6 col-lg-3">
          <div class="stat-card stat-red">
            <div class="d-flex justify-content-between align-items-start mb-2">
              <div class="stat-icon"><i class="bi bi-box-arrow-up"></i></div>
              <span class="badge-custom badge-danger">Today</span>
            </div>
            <div class="stat-value"><asp:Label ID="lblIssuesToday" runat="server" Text="0" ClientIDMode="Static" /></div>
            <div class="stat-label">Issues Today</div>
          </div>
        </div>
        <div class="col-6 col-lg-3">
          <div class="stat-card stat-orange">
            <div class="d-flex justify-content-between align-items-start mb-2">
              <div class="stat-icon"><i class="bi bi-bag-check-fill"></i></div>
              <span class="stat-trend">Orders</span>
            </div>
            <div class="stat-value"><asp:Label ID="lblDispensedToday" runat="server" Text="0" ClientIDMode="Static" /></div>
            <div class="stat-label">Dispensed Today</div>
          </div>
        </div>
        <div class="col-6 col-lg-3">
          <div class="stat-card stat-purple">
            <div class="d-flex justify-content-between align-items-start mb-2">
              <div class="stat-icon"><i class="bi bi-trash3"></i></div>
              <span class="stat-trend">Waste</span>
            </div>
            <div class="stat-value"><asp:Label ID="lblWastageToday" runat="server" Text="0" ClientIDMode="Static" /></div>
            <div class="stat-label">Wastage / Disposal</div>
          </div>
        </div>
        <div class="col-6 col-lg-3">
          <div class="stat-card stat-cyan">
            <div class="d-flex justify-content-between align-items-start mb-2">
              <div class="stat-icon"><i class="bi bi-boxes"></i></div>
              <span class="stat-trend">Units</span>
            </div>
            <div class="stat-value"><asp:Label ID="lblTotalUnitsIssued" runat="server" Text="0" ClientIDMode="Static" /></div>
            <div class="stat-label">Total Units Issued</div>
          </div>
        </div>
      </div>

      <div class="row g-3">
        <!-- Stock Out Form -->
        <div class="col-lg-7">
          <div class="data-card">
            <div class="data-card-header">
              <div>
                <div class="data-card-title"><i class="bi bi-box-arrow-up text-danger me-2"></i>Issue Stock</div>
                <div class="text-muted small mt-1">Record dispensing, wastage, or stock adjustment</div>
              </div>
              <button type="button" class="btn btn-outline-primary-custom fw-600" onclick="clearOutForm()">
                <i class="bi bi-x-circle me-1"></i>Clear
              </button>
            </div>
            <div class="p-4">
              <div class="row g-3">
                <div class="col-md-6">
                  <label class="form-label fw-600 small">Medicine <span class="text-danger">*</span></label>
                  <asp:DropDownList ID="outMedicine" runat="server" CssClass="form-control form-control-custom" ClientIDMode="Static" onchange="updateAvailable(this)">
                    <asp:ListItem Value="" data-available="">-- Select medicine --</asp:ListItem>
                  </asp:DropDownList>
                </div>
                <div class="col-md-6">
                  <label class="form-label fw-600 small">Batch Number <span class="text-danger">*</span></label>
                  <asp:TextBox ID="txtStockOutBatch" runat="server" CssClass="form-control form-control-custom" placeholder="BT-2024-001" ClientIDMode="Static" />
                </div>

                <!-- Stock availability bar -->
                <div class="col-12" id="stockIndicatorRow" style="display:none">
                  <div class="p-3 rounded-3" style="background:rgba(37,99,235,.06);border:1px solid rgba(37,99,235,.15)">
                    <div class="d-flex justify-content-between small fw-600 mb-1">
                      <span>Available Stock</span>
                      <span id="availableStock" class="text-primary">0 units</span>
                    </div>
                    <div style="height:6px;border-radius:3px;background:var(--gray-200);overflow:hidden">
                      <div id="stockBar" style="height:100%;border-radius:3px;background:#22c55e;width:100%;transition:width .3s"></div>
                    </div>
                  </div>
                </div>

                <div class="col-md-4">
                  <label class="form-label fw-600 small">Quantity <span class="text-danger">*</span></label>
                  <asp:TextBox ID="outQuantity" runat="server" TextMode="Number" CssClass="form-control form-control-custom" placeholder="1" ClientIDMode="Static" oninput="updateBar()" />
                </div>
                <div class="col-md-4">
                  <label class="form-label fw-600 small">Reason <span class="text-danger">*</span></label>
                  <asp:DropDownList ID="ddlStockOutReason" runat="server" CssClass="form-control form-control-custom" ClientIDMode="Static">
                    <asp:ListItem Value="">-- Select reason --</asp:ListItem>
                    <asp:ListItem>Customer order</asp:ListItem>
                    <asp:ListItem>Prescription dispensing</asp:ListItem>
                    <asp:ListItem>Damaged or wastage</asp:ListItem>
                    <asp:ListItem>Expired disposal</asp:ListItem>
                    <asp:ListItem>Sample / research</asp:ListItem>
                    <asp:ListItem>Manual correction</asp:ListItem>
                  </asp:DropDownList>
                </div>
                <div class="col-md-4">
                  <label class="form-label fw-600 small">Issue Date <span class="text-danger">*</span></label>
                  <asp:TextBox ID="txtStockOutDate" runat="server" TextMode="Date" CssClass="form-control form-control-custom" ClientIDMode="Static" />
                </div>
                <div class="col-md-6">
                  <label class="form-label fw-600 small">Reference / Order ID</label>
                  <asp:TextBox ID="txtStockOutRef" runat="server" CssClass="form-control form-control-custom" placeholder="Order ID, Rx No., or disposal ref" ClientIDMode="Static" />
                </div>
                <div class="col-md-6">
                  <label class="form-label fw-600 small">Authorized By</label>
                  <asp:DropDownList ID="ddlAuthorized" runat="server" CssClass="form-control form-control-custom" ClientIDMode="Static">
                    <asp:ListItem>Dr. Amit Kumar (Self)</asp:ListItem>
                    <asp:ListItem>Dr. Priya Sharma</asp:ListItem>
                    <asp:ListItem>Admin Approval</asp:ListItem>
                  </asp:DropDownList>
                </div>
                <div class="col-12">
                  <label class="form-label fw-600 small">Notes</label>
                  <asp:TextBox ID="txtStockOutNotes" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control form-control-custom" placeholder="Additional notes about this issue..." ClientIDMode="Static" />
                </div>
                <div class="col-12 d-flex justify-content-end gap-2 pt-2">
                  <button type="button" class="btn btn-secondary-custom" onclick="clearOutForm()">Clear Form</button>
                  <asp:LinkButton ID="btnStockOutSubmit" runat="server" CssClass="btn btn-danger-custom fw-600" ClientIDMode="Static" OnClick="btnStockOutSubmit_Click">
                    <i class="bi bi-box-arrow-up me-1"></i>Record Stock Out
                  </asp:LinkButton>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Recent Issues + Reason Breakdown -->
        <div class="col-lg-5">
          <div class="data-card mb-3">
            <div class="data-card-header">
              <div class="data-card-title"><i class="bi bi-clock-history text-primary me-2"></i>Recent Issues</div>
              <a href="inventory.aspx" class="btn btn-sm btn-outline-primary-custom">View All</a>
            </div>
            <div class="table-wrap p-2">
              <asp:GridView ID="gvStockOut" runat="server" AutoGenerateColumns="False" CssClass="table table-sm table-bordered mb-0" ClientIDMode="Static">
                <Columns>
                  <asp:BoundField DataField="MedicineName" HeaderText="Medicine" />
                  <asp:BoundField DataField="Quantity" HeaderText="Qty" />
                  <asp:BoundField DataField="Reason" HeaderText="Reason" />
                  <asp:BoundField DataField="ReferenceNo" HeaderText="Ref #" />
                </Columns>
                <EmptyDataTemplate>
                  <div class="text-center py-3 text-muted small">No recent stock-out records found.</div>
                </EmptyDataTemplate>
              </asp:GridView>
            </div>
          </div>

          <div class="data-card">
            <div class="data-card-header">
              <div class="data-card-title"><i class="bi bi-pie-chart-fill text-primary me-2"></i>Issue Reasons Today</div>
            </div>
            <div class="p-4">
              <div class="d-flex flex-column gap-2">
                <div class="d-flex justify-content-between align-items-center">
                  <span class="small fw-600">Customer Orders</span>
                  <span class="fw-700">9 <small class="text-muted fw-400">(75%)</small></span>
                </div>
                <div style="height:8px;border-radius:4px;background:var(--gray-200)">
                  <div style="height:100%;border-radius:4px;background:#22c55e;width:75%"></div>
                </div>
                <div class="d-flex justify-content-between align-items-center mt-1">
                  <span class="small fw-600">Wastage / Disposal</span>
                  <span class="fw-700">2 <small class="text-muted fw-400">(17%)</small></span>
                </div>
                <div style="height:8px;border-radius:4px;background:var(--gray-200)">
                  <div style="height:100%;border-radius:4px;background:#ef4444;width:17%"></div>
                </div>
                <div class="d-flex justify-content-between align-items-center mt-1">
                  <span class="small fw-600">Adjustments</span>
                  <span class="fw-700">1 <small class="text-muted fw-400">(8%)</small></span>
                </div>
                <div style="height:8px;border-radius:4px;background:var(--gray-200)">
                  <div style="height:100%;border-radius:4px;background:#8b5cf6;width:8%"></div>
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
let maxAvailable = 0;

document.addEventListener('DOMContentLoaded', () => {
  document.getElementById('headerMount').innerHTML = PH_HEADER('Stock Out', 'Inventory / Stock Out');
  initSidebar('phSidebar', 'phOverlay');

  const dateField = document.getElementById('txtStockOutDate');
  if (dateField && !dateField.value) dateField.value = new Date().toISOString().split('T')[0];
});

function updateAvailable(sel) {
  const opt = sel.options[sel.selectedIndex];
  const avail = parseInt(opt.getAttribute('data-available') || opt.dataset.available || '0');
  maxAvailable = avail;
  const row = document.getElementById('stockIndicatorRow');
  if (avail > 0) {
    row.style.display = 'block';
    document.getElementById('availableStock').textContent = avail + ' units';
    document.getElementById('stockBar').style.width = '100%';
  } else {
    row.style.display = 'none';
  }
}

function updateBar() {
  if (!maxAvailable) return;
  const qty = parseInt(document.getElementById('outQuantity').value) || 0;
  const pct = Math.max(0, Math.min(100, ((maxAvailable - qty) / maxAvailable) * 100));
  const bar = document.getElementById('stockBar');
  bar.style.width = pct + '%';
  bar.style.background = pct < 20 ? '#ef4444' : pct < 50 ? '#f59e0b' : '#22c55e';
  document.getElementById('availableStock').textContent = (maxAvailable - qty) + ' units remaining';
}

function submitStockOut() {
  const med = document.getElementById('outMedicine').value;
  const batch = document.getElementById('txtStockOutBatch').value;
  const qty = parseInt(document.getElementById('outQuantity').value);
  const reason = document.getElementById('ddlStockOutReason').value;

  if (!med || !batch || !qty || !reason) {
    showToast('Please fill in all required fields', 'error');
    return;
  }
  if (qty > maxAvailable && maxAvailable > 0) {
    showToast('Quantity exceeds available stock (' + maxAvailable + ' units)', 'error');
    return;
  }
  showToast('Stock-out recorded: ' + qty + ' units', 'success');
  clearOutForm();
}

function clearOutForm() {
  ['outMedicine','ddlStockOutReason','ddlAuthorized'].forEach(id => {
    const el = document.getElementById(id);
    if (el) el.selectedIndex = 0;
  });
  ['txtStockOutBatch','outQuantity','txtStockOutRef','txtStockOutNotes'].forEach(id => {
    const el = document.getElementById(id);
    if (el) el.value = '';
  });
  const dateField = document.getElementById('txtStockOutDate');
  if (dateField) dateField.value = new Date().toISOString().split('T')[0];
  const row = document.getElementById('stockIndicatorRow');
  if (row) row.style.display = 'none';
  maxAvailable = 0;
}
</script>
</body>
</asp:Content>
