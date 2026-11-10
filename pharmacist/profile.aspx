<%@ Page Title="My Profile — Pharmacist Portal | MediCare" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="medicare.pharmacist.profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link rel="stylesheet" href="<%= ResolveUrl("~/assets/css/pharmacist.css") %>" />
  <link rel="stylesheet" href="../assets/css/portal-profile.css">
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
      <a class="sidebar-nav-link " href="supplier-management.aspx">
        <i class="bi bi-truck"></i>Suppliers
      </a>
    </div>

    <div class="sidebar-label">Account</div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link active" href="profile.aspx">
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
    <main class="ph-content portal-profile">
      <section class="profile-hero">
        <div class="profile-avatar"><asp:Label ID="lblInitials" runat="server" Text="AK" ClientIDMode="Static" /></div>
        <div>
          <h2><asp:Label ID="lblProfileName" runat="server" Text="Dr. Amit Kumar" ClientIDMode="Static" /></h2>
          <p>Senior Pharmacist · MediCare Pharmacy</p>
          <p><i class="bi bi-envelope me-1"></i><asp:Label ID="lblProfileEmail" runat="server" Text="amit@medicare.com" ClientIDMode="Static" /></p>
        </div>
      </section>

      <div id="pharmacistProfileForm">
        <div class="row g-4">
          <div class="col-lg-8">
            <div class="profile-card">
              <h5><i class="bi bi-person-badge-fill me-2 text-primary"></i>Personal Information</h5>
              <div class="row g-3">
                <div class="col-md-6"><label class="form-label fw-600 small">First Name</label><asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control form-control-custom" Text="Amit" ClientIDMode="Static" /></div>
                <div class="col-md-6"><label class="form-label fw-600 small">Last Name</label><asp:TextBox ID="txtLastName" runat="server" CssClass="form-control form-control-custom" Text="Kumar" ClientIDMode="Static" /></div>
                <div class="col-md-6"><label class="form-label fw-600 small">Email Address</label><asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control form-control-custom" Text="amit@medicare.com" ClientIDMode="Static" /></div>
                <div class="col-md-6"><label class="form-label fw-600 small">Phone Number</label><asp:TextBox ID="txtPhone" runat="server" CssClass="form-control form-control-custom" Text="+91 98765 43210" ClientIDMode="Static" /></div>
                <div class="col-md-6"><label class="form-label fw-600 small">Date of Birth</label><asp:TextBox ID="txtDob" runat="server" TextMode="Date" CssClass="form-control form-control-custom" Text="1988-06-15" ClientIDMode="Static" /></div>
                <div class="col-md-6"><label class="form-label fw-600 small">Department</label>
                  <asp:DropDownList ID="ddlDept" runat="server" CssClass="form-select form-control-custom" ClientIDMode="Static">
                    <asp:ListItem>Pharmacy Operations</asp:ListItem>
                    <asp:ListItem>Prescription Verification</asp:ListItem>
                    <asp:ListItem>Inventory Management</asp:ListItem>
                  </asp:DropDownList>
                </div>
              </div>
            </div>
          </div>

          <div class="col-lg-4">
            <div class="profile-card">
              <h5><i class="bi bi-patch-check-fill me-2 text-primary"></i>Professional Details</h5>
              <div class="mb-3">
                <label class="form-label fw-600 small">License Number</label>
                <asp:TextBox ID="txtLicense" runat="server" CssClass="form-control form-control-custom" Text="PH-MH-2014-0847" ClientIDMode="Static" />
              </div>
              <div class="mb-3">
                <label class="form-label fw-600 small">License Expiry</label>
                <asp:TextBox ID="txtLicenseExp" runat="server" TextMode="Date" CssClass="form-control form-control-custom" Text="2027-12-31" ClientIDMode="Static" />
              </div>
              <div class="mb-3">
                <label class="form-label fw-600 small">Experience</label>
                <asp:TextBox ID="txtExp" runat="server" CssClass="form-control form-control-custom" Text="10 years" ReadOnly="true" ClientIDMode="Static" />
              </div>
              <span class="badge-custom badge-success"><i class="bi bi-check-circle-fill me-1"></i>License Verified</span>
            </div>
          </div>

          <div class="col-12">
            <div class="profile-card">
              <h5><i class="bi bi-shield-lock-fill me-2 text-primary"></i>Security & Activity</h5>
              <div class="row g-3">
                <div class="col-md-4"><div class="profile-stat"><strong>Last login</strong><span><asp:Label ID="lblLastLogin" runat="server" Text="Today, 09:42 AM" ClientIDMode="Static" /></span></div></div>
                <div class="col-md-4"><div class="profile-stat"><strong>Two-factor authentication</strong><span class="text-success">Enabled</span></div></div>
                <div class="col-md-4"><div class="profile-stat"><strong>Password status</strong><span>Last changed 30 days ago</span></div></div>
              </div>
              <asp:LinkButton ID="btnChangePassword" runat="server" CssClass="btn btn-outline-primary-custom mt-3"
                OnClientClick="showToast('Password reset link sent to your email','info'); return false;" ClientIDMode="Static">
                <i class="bi bi-key me-1"></i>Change Password
              </asp:LinkButton>
            </div>
          </div>

          <div class="col-12 text-end">
            <asp:LinkButton ID="btnSaveProfile" runat="server" CssClass="btn btn-primary-custom fw-600"
              OnClick="btnSaveProfile_Click" ClientIDMode="Static">
              <i class="bi bi-check2 me-1"></i>Save Changes
            </asp:LinkButton>
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
  document.getElementById('headerMount').innerHTML = PH_HEADER('My Profile', 'Account / Profile');
  initSidebar('phSidebar', 'phOverlay');
});
</script>
</body>
</asp:Content>
