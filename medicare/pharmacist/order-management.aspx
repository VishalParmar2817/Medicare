<%@ Page Title="Order Management — Pharmacist Portal | MediCare" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="order-management.aspx.cs" Inherits="medicare.pharmacist.orderManagement" %>

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
      <a class="sidebar-nav-link active" href="order-management.aspx">
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
        <div class="col-6 col-lg-3"><div class="stat-card stat-orange"><div class="d-flex justify-content-between align-items-start mb-2"><div class="stat-icon"><i class="bi bi-clock-fill"></i></div><span class="stat-trend">Action Needed</span></div><div class="stat-value"><asp:Label ID="lblPending" runat="server" Text="0" ClientIDMode="Static" /></div><div class="stat-label">Pending Orders</div></div></div>
        <div class="col-6 col-lg-3"><div class="stat-card stat-blue"><div class="d-flex justify-content-between align-items-start mb-2"><div class="stat-icon"><i class="bi bi-arrow-repeat"></i></div><span class="stat-trend">In Progress</span></div><div class="stat-value"><asp:Label ID="lblProcessing" runat="server" Text="0" ClientIDMode="Static" /></div><div class="stat-label">Processing</div></div></div>
        <div class="col-6 col-lg-3"><div class="stat-card stat-green"><div class="d-flex justify-content-between align-items-start mb-2"><div class="stat-icon"><i class="bi bi-check-circle-fill"></i></div><span class="stat-trend">Fulfilled</span></div><div class="stat-value"><asp:Label ID="lblDelivered" runat="server" Text="0" ClientIDMode="Static" /></div><div class="stat-label">Delivered</div></div></div>
        <div class="col-6 col-lg-3"><div class="stat-card stat-cyan"><div class="d-flex justify-content-between align-items-start mb-2"><div class="stat-icon"><i class="bi bi-currency-rupee"></i></div><span class="stat-trend"><i class="bi bi-arrow-up me-1"></i>+15%</span></div><div class="stat-value"><asp:Label ID="lblRevenue" runat="server" Text="₹0" ClientIDMode="Static" /></div><div class="stat-label">Total Revenue</div></div></div>
      </div>

      <!-- Order Tabs & List -->
      <div class="data-card">
        <div class="data-card-header">
          <div class="d-flex gap-2 flex-wrap">
            <asp:DropDownList ID="ddlStatusFilter" runat="server"
              CssClass="form-select form-control-custom"
              style="max-width:150px;height:40px;font-size:.88rem"
              AutoPostBack="True"
              OnSelectedIndexChanged="ddlStatusFilter_SelectedIndexChanged"
              ClientIDMode="Static">
              <asp:ListItem Value="">All Status</asp:ListItem>
              <asp:ListItem>Pending</asp:ListItem>
              <asp:ListItem>Processing</asp:ListItem>
              <asp:ListItem>Delivered</asp:ListItem>
              <asp:ListItem>Cancelled</asp:ListItem>
            </asp:DropDownList>
          </div>
          <div class="d-flex gap-2">
            <div class="search-bar" style="max-width:220px">
              <i class="bi bi-search"></i>
              <asp:TextBox ID="orderSearch" runat="server" CssClass="form-control" placeholder="Search orders..." ClientIDMode="Static" />
            </div>
          </div>
        </div>
        <div class="table-wrap">
          <asp:GridView ID="gvOrders" runat="server"
              AutoGenerateColumns="False"
              OnRowCommand="gvOrders_RowCommand"
              CssClass="table table-bordered table-striped"
              ClientIDMode="Static">
            <Columns>
              <asp:TemplateField HeaderText="Order ID">
                <ItemTemplate>
                  <asp:Label ID="Label1" runat="server" Text='<%# Eval("OrderID") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Order Code">
                <ItemTemplate>
                  <asp:Label ID="Label2" runat="server" Text='<%# Eval("OrderCode") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Customer">
                <ItemTemplate>
                  <asp:Label ID="Label3" runat="server" Text='<%# Eval("FullName") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Total">
                <ItemTemplate>
                  <asp:Label ID="Label4" runat="server" Text='<%# Eval("TotalAmount", "₹{0:N2}") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                  <asp:Label ID="Label5" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Edit">
                <ItemTemplate>
                  <asp:LinkButton ID="LinkButton1" runat="server" CommandName="cmd_edt" CommandArgument='<%# Eval("OrderID") %>'>
                    Edit
                  </asp:LinkButton>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Delete">
                <ItemTemplate>
                  <asp:LinkButton ID="LinkButton2" runat="server" CommandName="cmd_del" CommandArgument='<%# Eval("OrderID") %>'
                    OnClientClick="return confirm('Are you sure you want to delete this order?');">
                    Delete
                  </asp:LinkButton>
                </ItemTemplate>
              </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
              <div class="text-center py-4 text-muted">
                <i class="bi bi-inbox fs-2 d-block mb-2"></i>
                No orders found.
              </div>
            </EmptyDataTemplate>
          </asp:GridView>
        </div>
      </div>
    </main>
  </div>
</div>

<!-- Edit Order Modal -->
<div class="modal fade modal-custom" id="editOrderModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header"><h5 class="modal-title fw-700"><i class="bi bi-pencil me-2"></i>Update Order Status</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
      <div class="modal-body">
        <div class="row g-3">
          <div class="col-12">
            <label class="form-label fw-600">Order Status</label>
            <asp:DropDownList ID="ddlEditOrderStatus" runat="server" CssClass="form-select form-control-custom" ClientIDMode="Static">
              <asp:ListItem>Pending</asp:ListItem>
              <asp:ListItem>Processing</asp:ListItem>
              <asp:ListItem>Delivered</asp:ListItem>
              <asp:ListItem>Cancelled</asp:ListItem>
            </asp:DropDownList>
          </div>
          <div class="col-12">
            <label class="form-label fw-600">Pharmacist Remarks / Notes</label>
            <asp:TextBox ID="txtEditOrderNotes" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control form-control-custom" placeholder="Add status update notes..." ClientIDMode="Static" />
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary-custom" data-bs-dismiss="modal">Cancel</button>
        <asp:LinkButton ID="btnEditOrderSubmit" runat="server" CssClass="btn btn-primary-custom fw-600"
          OnClick="btnEditOrderSubmit_Click" ClientIDMode="Static">
          <i class="bi bi-check-lg me-1"></i>Update Status
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
  document.getElementById('headerMount').innerHTML = PH_HEADER('Order Management', 'Orders');
  initSidebar('phSidebar', 'phOverlay');
  if (typeof filterTable === 'function') {
    filterTable('orderSearch', 'gvOrders');
  }
});
</script>
</body>
</asp:Content>
