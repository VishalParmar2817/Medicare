<%@ Page Title="Supplier Management — Pharmacist Portal | MediCare" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="supplier-management.aspx.cs" Inherits="medicare.pharmacist.supplierManagement" %>

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
      <a class="sidebar-nav-link active" href="supplier-management.aspx">
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
        <div class="col-6 col-md-3"><div class="stat-card stat-blue"><div class="stat-icon mb-2">🏭</div><div class="stat-value"><asp:Label ID="lblTotalSuppliers" runat="server" Text="0" ClientIDMode="Static" /></div><div class="stat-label">Total Suppliers</div></div></div>
        <div class="col-6 col-md-3"><div class="stat-card stat-green"><div class="stat-icon mb-2">✅</div><div class="stat-value"><asp:Label ID="lblActiveSuppliers" runat="server" Text="0" ClientIDMode="Static" /></div><div class="stat-label">Active Suppliers</div></div></div>
        <div class="col-6 col-md-3"><div class="stat-card stat-orange"><div class="stat-icon mb-2">⏸️</div><div class="stat-value"><asp:Label ID="lblInactiveSuppliers" runat="server" Text="0" ClientIDMode="Static" /></div><div class="stat-label">Inactive</div></div></div>
        <div class="col-6 col-md-3"><div class="stat-card stat-cyan"><div class="stat-icon mb-2">🏙️</div><div class="stat-value"><asp:Label ID="lblCitiesSuppliers" runat="server" Text="0" ClientIDMode="Static" /></div><div class="stat-label">Cities Covered</div></div></div>
      </div>

      <!-- Supplier Table -->
      <div class="data-card">
        <div class="data-card-header">
          <div class="data-card-title">All Suppliers</div>
          <div class="d-flex gap-2 flex-wrap">
            <div class="search-bar" style="max-width:220px">
              <i class="bi bi-search"></i>
              <asp:TextBox ID="supSearch" runat="server" CssClass="form-control" placeholder="Search suppliers..." ClientIDMode="Static" />
            </div>
            <asp:DropDownList ID="supStatusFilter" runat="server" CssClass="form-select form-control-custom" style="width:130px;height:40px;font-size:.88rem" ClientIDMode="Static">
              <asp:ListItem Value="">All Status</asp:ListItem>
              <asp:ListItem>Active</asp:ListItem>
              <asp:ListItem>Inactive</asp:ListItem>
            </asp:DropDownList>
            <asp:LinkButton ID="btnAddSupModal" runat="server" CssClass="btn btn-primary-custom fw-600" data-bs-toggle="modal" data-bs-target="#addSupModal" ClientIDMode="Static">
              <i class="bi bi-plus me-1"></i>Add Supplier
            </asp:LinkButton>
          </div>
        </div>
        <div class="table-wrap">
          <asp:GridView ID="gvSuppliers" runat="server" AutoGenerateColumns="False"
            OnRowCommand="gvSuppliers_RowCommand" CssClass="table table-bordered table-striped"
            ClientIDMode="Static">
            <Columns>
              <asp:TemplateField HeaderText="ID">
                <ItemTemplate>
                  <asp:Label ID="Label1" runat="server" Text='<%# Eval("SupplierID") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Supplier">
                <ItemTemplate>
                  <asp:Label ID="Label2" runat="server" Text='<%# Eval("CompanyName") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Contact Person">
                <ItemTemplate>
                  <asp:Label ID="Label3" runat="server" Text='<%# Eval("ContactPerson") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Phone">
                <ItemTemplate>
                  <asp:Label ID="Label4" runat="server" Text='<%# Eval("PhoneNumber") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="City">
                <ItemTemplate>
                  <asp:Label ID="Label5" runat="server" Text='<%# Eval("City") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                  <asp:Label ID="Label6" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Edit">
                <ItemTemplate>
                  <asp:LinkButton ID="LinkButton1" runat="server" CommandName="cmd_edt"
                    CommandArgument='<%# Eval("SupplierID") %>'>
                    Edit
                  </asp:LinkButton>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Delete">
                <ItemTemplate>
                  <asp:LinkButton ID="LinkButton2" runat="server" CommandName="cmd_del"
                    CommandArgument='<%# Eval("SupplierID") %>'
                    OnClientClick="return confirm('Are you sure you want to delete this record?');">
                    Delete
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

<!-- Add Supplier Modal -->
<div class="modal fade modal-custom" id="addSupModal" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header"><h5 class="modal-title fw-700" id="addSupModalTitle">Add Supplier</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
      <div class="modal-body">
        <div class="row g-3">
          <div class="col-md-6"><label class="form-label fw-600 small">Company Name*</label><asp:TextBox ID="supName" runat="server" CssClass="form-control form-control-custom" placeholder="e.g. Sun Pharma Distributors" ClientIDMode="Static" /></div>
          <div class="col-md-6"><label class="form-label fw-600 small">Contact Person*</label><asp:TextBox ID="supContact" runat="server" CssClass="form-control form-control-custom" placeholder="Full name" ClientIDMode="Static" /></div>
          <div class="col-md-6"><label class="form-label fw-600 small">Phone*</label><asp:TextBox ID="supPhone" runat="server" TextMode="Phone" CssClass="form-control form-control-custom" placeholder="9876543210" ClientIDMode="Static" /></div>
          <div class="col-md-6"><label class="form-label fw-600 small">Email</label><asp:TextBox ID="supEmail" runat="server" TextMode="Email" CssClass="form-control form-control-custom" placeholder="supplier@company.com" ClientIDMode="Static" /></div>
          <div class="col-md-6"><label class="form-label fw-600 small">City*</label><asp:TextBox ID="supCity" runat="server" CssClass="form-control form-control-custom" placeholder="Mumbai" ClientIDMode="Static" /></div>
          <div class="col-md-6"><label class="form-label fw-600 small">GST Number</label><asp:TextBox ID="txtSupGst" runat="server" CssClass="form-control form-control-custom" placeholder="27AABCU9603R1ZN" ClientIDMode="Static" /></div>
          <div class="col-md-6"><label class="form-label fw-600 small">Drug License No.</label><asp:TextBox ID="txtSupLicense" runat="server" CssClass="form-control form-control-custom" placeholder="DL-MH-2024-001" ClientIDMode="Static" /></div>
          <div class="col-md-6"><label class="form-label fw-600 small">Status</label><asp:DropDownList ID="supStatus" runat="server" CssClass="form-control form-control-custom" ClientIDMode="Static"><asp:ListItem>Active</asp:ListItem><asp:ListItem>Inactive</asp:ListItem></asp:DropDownList></div>
          <div class="col-12"><label class="form-label fw-600 small">Full Address</label><asp:TextBox ID="txtSupAddress" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control form-control-custom" placeholder="Complete supplier address" ClientIDMode="Static" /></div>
          <div class="col-12"><label class="form-label fw-600 small">Notes</label><asp:TextBox ID="txtSupNotes" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control form-control-custom" placeholder="Additional notes about this supplier" ClientIDMode="Static" /></div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <asp:LinkButton ID="btnSaveSup" runat="server" CssClass="btn btn-primary-custom fw-600" OnClick="btnSaveSup_Click" ClientIDMode="Static"><i class="bi bi-check2 me-1"></i>Save Supplier</asp:LinkButton>
      </div>
    </div>
  </div>
</div>

<!-- Edit Supplier Modal -->
<div class="modal fade modal-custom" id="editSupModal" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header"><h5 class="modal-title fw-700" id="editSupModalTitle">Edit Supplier</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
      <div class="modal-body">
        <div class="row g-3">
          <div class="col-md-6"><label class="form-label fw-600 small">Company Name*</label><asp:TextBox ID="txtEditSupName" runat="server" CssClass="form-control form-control-custom" placeholder="e.g. Sun Pharma Distributors" ClientIDMode="Static" /></div>
          <div class="col-md-6"><label class="form-label fw-600 small">Contact Person*</label><asp:TextBox ID="txtEditSupContact" runat="server" CssClass="form-control form-control-custom" placeholder="Full name" ClientIDMode="Static" /></div>
          <div class="col-md-6"><label class="form-label fw-600 small">Phone*</label><asp:TextBox ID="txtEditSupPhone" runat="server" TextMode="Phone" CssClass="form-control form-control-custom" placeholder="9876543210" ClientIDMode="Static" /></div>
          <div class="col-md-6"><label class="form-label fw-600 small">Email</label><asp:TextBox ID="txtEditSupEmail" runat="server" TextMode="Email" CssClass="form-control form-control-custom" placeholder="supplier@company.com" ClientIDMode="Static" /></div>
          <div class="col-md-6"><label class="form-label fw-600 small">City*</label><asp:TextBox ID="txtEditSupCity" runat="server" CssClass="form-control form-control-custom" placeholder="Mumbai" ClientIDMode="Static" /></div>
          <div class="col-md-6"><label class="form-label fw-600 small">GST Number</label><asp:TextBox ID="txtEditSupGst" runat="server" CssClass="form-control form-control-custom" placeholder="27AABCU9603R1ZN" ClientIDMode="Static" /></div>
          <div class="col-md-6"><label class="form-label fw-600 small">Drug License No.</label><asp:TextBox ID="txtEditSupLicense" runat="server" CssClass="form-control form-control-custom" placeholder="DL-MH-2024-001" ClientIDMode="Static" /></div>
          <div class="col-md-6"><label class="form-label fw-600 small">Status</label><asp:DropDownList ID="ddlEditSupStatus" runat="server" CssClass="form-control form-control-custom" ClientIDMode="Static"><asp:ListItem>Active</asp:ListItem><asp:ListItem>Inactive</asp:ListItem></asp:DropDownList></div>
          <div class="col-12"><label class="form-label fw-600 small">Full Address</label><asp:TextBox ID="txtEditSupAddress" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control form-control-custom" placeholder="Complete supplier address" ClientIDMode="Static" /></div>
          <div class="col-12"><label class="form-label fw-600 small">Notes</label><asp:TextBox ID="txtEditSupNotes" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control form-control-custom" placeholder="Additional notes about this supplier" ClientIDMode="Static" /></div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <asp:LinkButton ID="btnUpdateSup" runat="server" CssClass="btn btn-primary-custom fw-600" OnClick="btnUpdateSup_Click" ClientIDMode="Static"><i class="bi bi-check2 me-1"></i>Update Supplier</asp:LinkButton>
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
  document.getElementById('headerMount').innerHTML = PH_HEADER('Supplier Management', 'Suppliers');
  initSidebar('phSidebar', 'phOverlay');
  if (typeof filterTable === 'function') {
    filterTable('supSearch', 'gvSuppliers');
  }
});
</script>
</body>
</asp:Content>
