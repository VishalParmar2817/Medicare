<%@ Page Title="Stock In — Pharmacist Portal | MediCare" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="stock-in.aspx.cs" Inherits="medicare.pharmacist.stockIn" %>

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
        <a class="sidebar-subnav-link active" href="stock-in.aspx"><i class="bi bi-box-arrow-in-down"></i>Stock In</a>
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
      <!-- Stats -->
      <div class="row g-3 mb-4">
        <div class="col-6 col-lg-3">
          <div class="stat-card stat-green">
            <div class="d-flex justify-content-between align-items-start mb-2">
              <div class="stat-icon"><i class="bi bi-box-arrow-in-down"></i></div>
              <span class="badge-custom badge-success">Today</span>
            </div>
            <div class="stat-value"><asp:Label ID="lblBatchesReceived" runat="server" Text="0" ClientIDMode="Static" /></div>
            <div class="stat-label">Batches Received</div>
          </div>
        </div>
        <div class="col-6 col-lg-3">
          <div class="stat-card stat-blue">
            <div class="d-flex justify-content-between align-items-start mb-2">
              <div class="stat-icon"><i class="bi bi-boxes"></i></div>
              <span class="stat-trend">+18%</span>
            </div>
            <div class="stat-value"><asp:Label ID="lblUnitsAdded" runat="server" Text="0" ClientIDMode="Static" /></div>
            <div class="stat-label">Units Added Today</div>
          </div>
        </div>
        <div class="col-6 col-lg-3">
          <div class="stat-card stat-purple">
            <div class="d-flex justify-content-between align-items-start mb-2">
              <div class="stat-icon"><i class="bi bi-truck"></i></div>
              <span class="stat-trend">Active</span>
            </div>
            <div class="stat-value"><asp:Label ID="lblSuppliersWeek" runat="server" Text="0" ClientIDMode="Static" /></div>
            <div class="stat-label">Suppliers This Week</div>
          </div>
        </div>
        <div class="col-6 col-lg-3">
          <div class="stat-card stat-cyan">
            <div class="d-flex justify-content-between align-items-start mb-2">
              <div class="stat-icon"><i class="bi bi-currency-rupee"></i></div>
              <span class="stat-trend">This Month</span>
            </div>
            <div class="stat-value"><asp:Label ID="lblPurchaseValue" runat="server" Text="₹0" ClientIDMode="Static" /></div>
            <div class="stat-label">Purchase Value</div>
          </div>
        </div>
      </div>

      <div class="row g-3">
        <!-- Stock In Form -->
        <div class="col-lg-7">
          <div class="data-card">
            <div class="data-card-header">
              <div>
                <div class="data-card-title"><i class="bi bi-box-arrow-in-down text-success me-2"></i>Receive New Stock</div>
                <div class="text-muted small mt-1">Record a new supplier batch delivery</div>
              </div>
              <button type="button" class="btn btn-outline-primary-custom fw-600" onclick="clearForm()">
                <i class="bi bi-x-circle me-1"></i>Clear
              </button>
            </div>
            <div class="p-4">
              <div class="row g-3" id="stockInForm">
                <div class="col-md-6">
                  <label class="form-label fw-600 small">Medicine <span class="text-danger">*</span></label>
                  <asp:DropDownList ID="ddlStockInMed" runat="server" CssClass="form-control form-control-custom" ClientIDMode="Static">
                    <asp:ListItem Value="">-- Select medicine --</asp:ListItem>
                  </asp:DropDownList>
                </div>
                <div class="col-md-6">
                  <label class="form-label fw-600 small">Supplier <span class="text-danger">*</span></label>
                  <asp:DropDownList ID="ddlStockInSupplier" runat="server" CssClass="form-control form-control-custom" ClientIDMode="Static">
                    <asp:ListItem Value="">-- Select supplier --</asp:ListItem>
                  </asp:DropDownList>
                </div>
                <div class="col-md-4">
                  <label class="form-label fw-600 small">Batch Number <span class="text-danger">*</span></label>
                  <asp:TextBox ID="txtStockInBatch" runat="server" CssClass="form-control form-control-custom" placeholder="e.g. BT-2026-044" ClientIDMode="Static" />
                </div>
                <div class="col-md-4">
                  <label class="form-label fw-600 small">Quantity Received <span class="text-danger">*</span></label>
                  <asp:TextBox ID="txtStockInQty" runat="server" TextMode="Number" CssClass="form-control form-control-custom" placeholder="100" ClientIDMode="Static" />
                </div>
                <div class="col-md-4">
                  <label class="form-label fw-600 small">Expiry Date <span class="text-danger">*</span></label>
                  <asp:TextBox ID="txtStockInExpiry" runat="server" TextMode="Date" CssClass="form-control form-control-custom" ClientIDMode="Static" />
                </div>
                <div class="col-md-6">
                  <label class="form-label fw-600 small">Purchase Price (₹) <span class="text-danger">*</span></label>
                  <div class="input-group">
                    <span class="input-group-text" style="background:var(--gray-100);border-color:var(--gray-200);color:var(--gray-400)">₹</span>
                    <asp:TextBox ID="txtStockInPrice" runat="server" TextMode="Number" CssClass="form-control form-control-custom" placeholder="0.00" ClientIDMode="Static" />
                  </div>
                </div>
                <div class="col-md-6">
                  <label class="form-label fw-600 small">Received Date <span class="text-danger">*</span></label>
                  <asp:TextBox ID="txtStockInReceivedDate" runat="server" TextMode="Date" CssClass="form-control form-control-custom" ClientIDMode="Static" />
                </div>
                <div class="col-md-6">
                  <label class="form-label fw-600 small">Manufacturing Date</label>
                  <asp:TextBox ID="txtStockInMfgDate" runat="server" TextMode="Date" CssClass="form-control form-control-custom" ClientIDMode="Static" />
                </div>
                <div class="col-md-6">
                  <label class="form-label fw-600 small">Invoice Number</label>
                  <asp:TextBox ID="txtInvoiceNo" runat="server" CssClass="form-control form-control-custom" placeholder="INV-2026-XXXX" ClientIDMode="Static" />
                </div>
                <div class="col-12">
                  <label class="form-label fw-600 small">Notes</label>
                  <asp:TextBox ID="txtStockInNotes" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control form-control-custom" placeholder="Any notes about this batch..." ClientIDMode="Static" />
                </div>
                <div class="col-12 d-flex justify-content-end gap-2 pt-2">
                  <button type="button" class="btn btn-secondary-custom" onclick="clearForm()">Clear Form</button>
                  <asp:LinkButton ID="btnStockInSubmit" runat="server" CssClass="btn btn-primary-custom fw-600" ClientIDMode="Static" OnClick="btnStockInSubmit_Click">
                    <i class="bi bi-box-arrow-in-down me-1"></i>Record Stock In
                  </asp:LinkButton>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Recent Receipts + Guidelines -->
        <div class="col-lg-5">
          <div class="data-card mb-3">
            <div class="data-card-header">
              <div class="data-card-title"><i class="bi bi-clock-history text-primary me-2"></i>Recent Stock-In</div>
              <a href="inventory.aspx" class="btn btn-sm btn-outline-primary-custom">View All</a>
            </div>
            <div class="table-wrap p-2">
              <asp:GridView ID="gvStockIn" runat="server" AutoGenerateColumns="False" CssClass="table table-sm table-bordered mb-0" ClientIDMode="Static">
                <Columns>
                  <asp:BoundField DataField="MedicineName" HeaderText="Medicine" />
                  <asp:BoundField DataField="BatchNumber" HeaderText="Batch" />
                  <asp:BoundField DataField="Quantity" HeaderText="Qty" />
                  <asp:BoundField DataField="SupplierName" HeaderText="Supplier" />
                </Columns>
                <EmptyDataTemplate>
                  <div class="text-center py-3 text-muted small">No recent stock-in records found.</div>
                </EmptyDataTemplate>
              </asp:GridView>
            </div>
          </div>

          <div class="data-card">
            <div class="data-card-header">
              <div class="data-card-title"><i class="bi bi-info-circle text-primary me-2"></i>Guidelines</div>
            </div>
            <div class="p-4">
              <ul class="list-unstyled mb-0 d-flex flex-column gap-3">
                <li class="d-flex align-items-start gap-2">
                  <i class="bi bi-1-circle-fill text-primary mt-1"></i>
                  <span class="small text-muted">Verify batch number and expiry date against supplier invoice before recording.</span>
                </li>
                <li class="d-flex align-items-start gap-2">
                  <i class="bi bi-2-circle-fill text-primary mt-1"></i>
                  <span class="small text-muted">Inspect physical condition of medicines before updating stock levels.</span>
                </li>
                <li class="d-flex align-items-start gap-2">
                  <i class="bi bi-3-circle-fill text-primary mt-1"></i>
                  <span class="small text-muted">Store temperature-sensitive medicines immediately per storage requirements.</span>
                </li>
                <li class="d-flex align-items-start gap-2">
                  <i class="bi bi-4-circle-fill text-primary mt-1"></i>
                  <span class="small text-muted">Report any discrepancies to the admin before confirming stock-in.</span>
                </li>
              </ul>
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
  document.getElementById('headerMount').innerHTML = PH_HEADER('Stock In', 'Inventory / Stock In');
  initSidebar('phSidebar', 'phOverlay');

  const today = new Date().toISOString().split('T')[0];
  const dateField = document.getElementById('txtStockInReceivedDate');
  if (dateField && !dateField.value) dateField.value = today;
});

function submitStockIn() {
  const med = document.getElementById('ddlStockInMed').value;
  const supplier = document.getElementById('ddlStockInSupplier').value;
  const batch = document.getElementById('txtStockInBatch').value;
  const qty = document.getElementById('txtStockInQty').value;
  const expiry = document.getElementById('txtStockInExpiry').value;

  if (!med || !supplier || !batch || !qty || !expiry) {
    showToast('Please fill in all required fields', 'error');
    return;
  }
  showToast(`Stock-in recorded: ${qty} units of ${med}`, 'success');
  clearForm();
}

function clearForm() {
  ['ddlStockInMed','ddlStockInSupplier','txtStockInBatch','txtStockInQty',
   'txtStockInExpiry','txtStockInPrice','txtStockInMfgDate','txtInvoiceNo','txtStockInNotes']
    .forEach(id => {
      const el = document.getElementById(id);
      if (el) { el.tagName === 'SELECT' ? (el.selectedIndex = 0) : (el.value = ''); }
    });
  const today = new Date().toISOString().split('T')[0];
  const dateField = document.getElementById('txtStockInReceivedDate');
  if (dateField) dateField.value = today;
}
</script>
</body>
</asp:Content>
