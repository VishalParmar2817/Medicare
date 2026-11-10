<%@ Page Title="Inventory Management — Pharmacist Portal | MediCare" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="inventory.aspx.cs" Inherits="medicare.pharmacist.inventory" %>

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
      <!-- Stats -->
      <div class="row g-3 mb-4">
        <div class="col-6 col-lg-3"><div class="stat-card stat-blue"><div class="d-flex justify-content-between align-items-start mb-2"><div class="stat-icon"><i class="bi bi-boxes"></i></div><span class="stat-trend">Total</span></div><div class="stat-value"><asp:Label ID="lblTotalStock" runat="server" Text="0" ClientIDMode="Static" /></div><div class="stat-label">Total Stock Units</div></div></div>
        <div class="col-6 col-lg-3"><div class="stat-card stat-green"><div class="d-flex justify-content-between align-items-start mb-2"><div class="stat-icon"><i class="bi bi-check-circle-fill"></i></div><span class="stat-trend"><i class="bi bi-arrow-up me-1"></i>Good</span></div><div class="stat-value"><asp:Label ID="lblInStock" runat="server" Text="0" ClientIDMode="Static" /></div><div class="stat-label">In Stock Items</div></div></div>
        <div class="col-6 col-lg-3"><div class="stat-card stat-orange"><div class="d-flex justify-content-between align-items-start mb-2"><div class="stat-icon"><i class="bi bi-exclamation-triangle-fill"></i></div><span class="stat-trend">Action Needed</span></div><div class="stat-value"><asp:Label ID="lblLowStock" runat="server" Text="0" ClientIDMode="Static" /></div><div class="stat-label">Low Stock Items</div></div></div>
        <div class="col-6 col-lg-3"><div class="stat-card stat-red"><div class="d-flex justify-content-between align-items-start mb-2"><div class="stat-icon"><i class="bi bi-x-circle-fill"></i></div><span class="stat-trend">Critical</span></div><div class="stat-value"><asp:Label ID="lblOutStock" runat="server" Text="0" ClientIDMode="Static" /></div><div class="stat-label">Out of Stock</div></div></div>
      </div>

      <!-- Inventory Table -->
      <div class="data-card">
        <div class="data-card-header">
          <div class="data-card-title"><i class="bi bi-boxes me-2 text-primary"></i>Inventory Overview</div>
          <div class="d-flex gap-2 flex-wrap">
            <div class="search-bar" style="max-width:220px">
              <i class="bi bi-search"></i>
              <asp:TextBox ID="invSearch" runat="server" CssClass="form-control" placeholder="Search inventory..." ClientIDMode="Static" />
            </div>
            <asp:DropDownList ID="invStockFilter" runat="server" CssClass="form-select form-control-custom" style="width:130px;height:40px;font-size:.88rem" ClientIDMode="Static">
              <asp:ListItem Text="All Stock" Value=""></asp:ListItem>
              <asp:ListItem Text="Low Stock" Value="low"></asp:ListItem>
              <asp:ListItem Text="Normal" Value="ok"></asp:ListItem>
              <asp:ListItem Text="High Stock" Value="high"></asp:ListItem>
            </asp:DropDownList>
            <asp:LinkButton ID="btnExportInvCSV" runat="server" CssClass="btn btn-outline-primary-custom fw-600" ClientIDMode="Static" OnClientClick="showToast('Exporting inventory CSV...','info'); return false;">
              <i class="bi bi-download me-1"></i>Export CSV
            </asp:LinkButton>
          </div>
        </div>
        <div class="table-wrap">
          <asp:GridView ID="gvInventory" runat="server" AutoGenerateColumns="False"
            OnRowCommand="gvInventory_RowCommand" CssClass="table table-bordered table-striped"
            ClientIDMode="Static">
            <Columns>
              <asp:TemplateField HeaderText="ID">
                <ItemTemplate>
                  <asp:Label ID="Label1" runat="server" Text='<%# Eval("MedicineID") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Medicine">
                <ItemTemplate>
                  <asp:Label ID="Label2" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Category">
                <ItemTemplate>
                  <asp:Label ID="Label3" runat="server" Text='<%# Eval("CategoryName") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Stock">
                <ItemTemplate>
                  <asp:Label ID="Label4" runat="server" Text='<%# Eval("Stock") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Min Level">
                <ItemTemplate>
                  <asp:Label ID="Label5" runat="server" Text='<%# Eval("MinStockLevel") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                  <asp:Label ID="Label6" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Adjust">
                <ItemTemplate>
                  <asp:LinkButton ID="LinkButton1" runat="server" CommandName="cmd_edt"
                    CommandArgument='<%# Eval("MedicineID") %>'>
                    Adjust Stock
                  </asp:LinkButton>
                </ItemTemplate>
              </asp:TemplateField>
            </Columns>
          </asp:GridView>
        </div>
      </div>
    </main>
  </div>
</div>

<!-- Adjust Stock Modal -->
<div class="modal fade modal-custom" id="adjustModal" tabindex="-1">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header"><h5 class="modal-title fw-700">Adjust Stock</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
      <div class="modal-body">
        <div class="mb-3"><label class="form-label fw-600 small">Medicine</label><asp:TextBox ID="adjMedName" runat="server" CssClass="form-control form-control-custom" ReadOnly="true" ClientIDMode="Static" /></div>
        <div class="mb-3"><label class="form-label fw-600 small">Current Stock</label><asp:TextBox ID="adjCurrent" runat="server" CssClass="form-control form-control-custom" ReadOnly="true" ClientIDMode="Static" /></div>
        <div class="mb-3"><label class="form-label fw-600 small">Adjustment Type</label><asp:DropDownList ID="adjType" runat="server" CssClass="form-control form-control-custom" ClientIDMode="Static"><asp:ListItem>Add Stock</asp:ListItem><asp:ListItem>Remove Stock</asp:ListItem><asp:ListItem>Set Stock</asp:ListItem></asp:DropDownList></div>
        <div class="mb-3"><label class="form-label fw-600 small">Quantity</label><asp:TextBox ID="adjQty" runat="server" TextMode="Number" CssClass="form-control form-control-custom" placeholder="0" ClientIDMode="Static" /></div>
        <div class="mb-3"><label class="form-label fw-600 small">Reason</label><asp:TextBox ID="txtAdjReason" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control form-control-custom" placeholder="Reason for adjustment" ClientIDMode="Static" /></div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <asp:LinkButton ID="btnSaveAdjust" runat="server" CssClass="btn btn-primary-custom fw-600" OnClick="btnSaveAdjust_Click" ClientIDMode="Static"><i class="bi bi-check2 me-1"></i>Update Stock</asp:LinkButton>
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
  document.getElementById('headerMount').innerHTML = PH_HEADER('Inventory Management', 'Inventory');
  initSidebar('phSidebar', 'phOverlay');
  if (typeof filterTable === 'function') {
    filterTable('invSearch', 'gvInventory');
  }
});
</script>
</body>
</asp:Content>
