<%@ Page Title="My Profile — Admin Panel | MediCare" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="medicare.admin.profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../assets/css/portal-profile.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
<asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
<body>
<div class="admin-layout">
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
            <a class="sidebar-nav-link " href="dashboard.aspx">
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
            <a class="sidebar-nav-link active" href="profile.aspx">
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
<div class="admin-main">
  <div id="headerMount"></div>
  <main class="admin-content portal-profile">

    <!-- Profile Hero -->
    <section class="profile-hero" style="background:linear-gradient(135deg,#8b5cf6,#2563eb)">
      <div class="profile-avatar"><asp:Label ID="lblInitials" runat="server" Text="SA" ClientIDMode="Static" /></div>
      <div>
        <h2><asp:Label ID="lblProfileName" runat="server" Text="Super Admin" ClientIDMode="Static" /></h2>
        <p>System Administrator · MediCare Pharmacy</p>
        <p><i class="bi bi-envelope me-1"></i><asp:Label ID="lblProfileEmail" runat="server" Text="admin@medicare.com" ClientIDMode="Static" /></p>
      </div>
    </section>

    <div class="row g-4">
      <!-- Account Info -->
      <div class="col-lg-8">
        <div class="profile-card">
          <h5><i class="bi bi-person-fill"></i> Account Information</h5>
          <div class="row g-3">
            <div class="col-md-6"><label class="form-label">First Name</label>
              <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control form-control-custom" ClientIDMode="Static" />
            </div>
            <div class="col-md-6"><label class="form-label">Last Name</label>
              <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control form-control-custom" ClientIDMode="Static" />
            </div>
            <div class="col-md-6"><label class="form-label">Email Address</label>
              <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control form-control-custom" ClientIDMode="Static" />
            </div>
            <div class="col-md-6"><label class="form-label">Phone Number</label>
              <asp:TextBox ID="txtPhone" runat="server" TextMode="Phone" CssClass="form-control form-control-custom" ClientIDMode="Static" />
            </div>
            <div class="col-md-6"><label class="form-label">Time Zone</label>
              <asp:DropDownList ID="ddlTimeZone" runat="server" CssClass="form-select form-control-custom" ClientIDMode="Static">
                <asp:ListItem Text="India Standard Time (IST)" />
                <asp:ListItem Text="UTC" />
                <asp:ListItem Text="Eastern Time" />
              </asp:DropDownList>
            </div>
            <div class="col-md-6"><label class="form-label">Preferred Language</label>
              <asp:DropDownList ID="ddlLanguage" runat="server" CssClass="form-select form-control-custom" ClientIDMode="Static">
                <asp:ListItem Text="English" />
                <asp:ListItem Text="Hindi" />
              </asp:DropDownList>
            </div>
          </div>
        </div>
      </div>

      <!-- Access & Role -->
      <div class="col-lg-4">
        <div class="profile-card">
          <h5><i class="bi bi-shield-lock-fill"></i> Access &amp; Role</h5>
          <label class="form-label">Role</label>
          <asp:TextBox ID="txtRole" runat="server" CssClass="form-control form-control-custom mb-3" ReadOnly="true" ClientIDMode="Static" />
          <label class="form-label">Account ID</label>
          <asp:TextBox ID="txtAccountId" runat="server" CssClass="form-control form-control-custom mb-3" ReadOnly="true" ClientIDMode="Static" />
          <label class="form-label">Access Level</label>
          <asp:TextBox ID="txtAccessLevel" runat="server" CssClass="form-control form-control-custom mb-3" ReadOnly="true" ClientIDMode="Static" />
          <span class="badge-custom badge-success"><i class="bi bi-check-circle-fill me-1"></i>Account Active</span>
        </div>
      </div>

      <!-- Security -->
      <div class="col-12">
        <div class="profile-card">
          <h5><i class="bi bi-activity"></i> Account Security</h5>
          <div class="row g-3">
            <div class="col-md-4"><div class="profile-stat"><strong>Last login</strong><span><asp:Label ID="lblLastLogin" runat="server" Text="—" ClientIDMode="Static" /></span></div></div>
            <div class="col-md-4"><div class="profile-stat"><strong>Two-factor authentication</strong><span class="text-success">Enabled</span></div></div>
            <div class="col-md-4"><div class="profile-stat"><strong>Active sessions</strong><span>2 trusted devices</span></div></div>
          </div>
          <asp:LinkButton ID="btnChangePassword" runat="server" CssClass="btn btn-outline-primary-custom mt-3"
            OnClientClick="showToast('Password reset link sent to your email','info'); return false;" ClientIDMode="Static">
            <i class="bi bi-key me-1"></i>Change Password
          </asp:LinkButton>
        </div>
      </div>

      <!-- Save -->
      <div class="col-12 text-end">
        <asp:LinkButton ID="btnSaveChanges" runat="server" CssClass="btn btn-primary-custom fw-600"
          OnClick="btnSaveChanges_Click" ClientIDMode="Static">
          <i class="bi bi-check2 me-1"></i>Save Changes
        </asp:LinkButton>
      </div>
    </div>
  </main>
</div>
</div>
<div id="toast-container"></div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="../assets/js/main.js"></script>
<script src="../assets/js/admin.js"></script>
<script>
document.addEventListener('DOMContentLoaded', () => {
  document.getElementById('headerMount').innerHTML = ADMIN_HEADER('My Profile', 'My Profile');
  initSidebar('adminSidebar', 'adminOverlay');
});
</script>
</body>
</asp:Content>
