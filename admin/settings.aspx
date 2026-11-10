<%@ Page Title="System Settings - Admin Panel | MediCare" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="settings.aspx.cs" Inherits="medicare.admin.settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../assets/css/admin.css" />
    <style>
        .settings-nav {
            background: #ffffff !important;
            border-radius: 12px !important;
            box-shadow: 0 1px 4px rgba(0,0,0,.08) !important;
            overflow: hidden !important;
            border: 1px solid #e2e8f0 !important;
        }
        .settings-nav-sticky {
            position: sticky !important;
            top: 1rem !important;
        }
        .settings-nav-item {
            display: flex !important;
            align-items: center !important;
            gap: .75rem !important;
            padding: .95rem 1.3rem !important;
            cursor: pointer !important;
            font-size: .9rem !important;
            font-weight: 500 !important;
            color: #334155 !important;
            border-bottom: 1px solid #f1f5f9 !important;
            transition: all .2s ease !important;
            user-select: none !important;
        }
        .settings-nav-item:last-child {
            border-bottom: none !important;
        }
        .settings-nav-item:hover {
            background: #f8fafc !important;
            color: #2563eb !important;
            padding-left: 1.5rem !important;
        }
        .settings-nav-item.active {
            background: rgba(37,99,235,.08) !important;
            color: #2563eb !important;
            border-right: 3px solid #2563eb !important;
            font-weight: 600 !important;
        }
        .settings-nav-item i {
            font-size: 1.15rem !important;
            width: 24px !important;
            text-align: center !important;
            color: inherit !important;
        }
        .settings-section {
            display: none !important;
        }
        .settings-section.active {
            display: block !important;
        }
    </style>
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
            <a class="sidebar-nav-link " href="profile.aspx">
                <i class="bi bi-person-circle"></i>My Profile
            </a>
        </div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link active" href="settings.aspx">
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
  <div class="admin-content">
    <div class="row g-4">
      <!-- Settings Navigation -->
      <div class="col-lg-3">
        <div class="settings-nav settings-nav-sticky">
          <div class="settings-nav-item active" onclick="switchSettings(this,'general')"><i class="bi bi-gear"></i>General</div>
          <div class="settings-nav-item" onclick="switchSettings(this,'notifications')"><i class="bi bi-bell"></i>Notifications</div>
          <div class="settings-nav-item" onclick="switchSettings(this,'security')"><i class="bi bi-shield-lock"></i>Security</div>
          <div class="settings-nav-item" onclick="switchSettings(this,'payment')"><i class="bi bi-credit-card"></i>Payment</div>
          <div class="settings-nav-item" onclick="switchSettings(this,'appearance')"><i class="bi bi-palette"></i>Appearance</div>
        </div>
      </div>

      <!-- General Settings -->
      <div class="col-lg-9">
        <asp:HiddenField ID="hdnActiveTab" runat="server" Value="general" ClientIDMode="Static" />

        <div class="settings-section active" id="settingsGeneral">
          <div class="data-card">
            <div class="data-card-header"><div class="data-card-title">General Settings</div></div>
            <div class="p-3">
              <div class="row g-3">
                <div class="col-md-6"><label class="form-label fw-600">Pharmacy Name</label>
                  <asp:TextBox ID="txtPharmacyName" runat="server" CssClass="form-control form-control-custom" ClientIDMode="Static" />
                </div>
                <div class="col-md-6"><label class="form-label fw-600">Tagline</label>
                  <asp:TextBox ID="txtTagline" runat="server" CssClass="form-control form-control-custom" ClientIDMode="Static" />
                </div>
                <div class="col-md-6"><label class="form-label fw-600">Contact Email</label>
                  <asp:TextBox ID="txtContactEmail" runat="server" TextMode="Email" CssClass="form-control form-control-custom" ClientIDMode="Static" />
                </div>
                <div class="col-md-6"><label class="form-label fw-600">Contact Phone</label>
                  <asp:TextBox ID="txtContactPhone" runat="server" TextMode="Phone" CssClass="form-control form-control-custom" ClientIDMode="Static" />
                </div>
                <div class="col-12"><label class="form-label fw-600">Address</label>
                  <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control form-control-custom" ClientIDMode="Static" />
                </div>
                <div class="col-md-6"><label class="form-label fw-600">GSTIN</label>
                  <asp:TextBox ID="txtGSTIN" runat="server" CssClass="form-control form-control-custom" ClientIDMode="Static" />
                </div>
                <div class="col-md-6"><label class="form-label fw-600">Drug License No.</label>
                  <asp:TextBox ID="txtDrugLicense" runat="server" CssClass="form-control form-control-custom" ClientIDMode="Static" />
                </div>
                <div class="col-12 text-end mt-2">
                  <asp:LinkButton ID="btnSaveGeneral" runat="server" CssClass="btn btn-primary-custom fw-600"
                    OnClick="btnSaveGeneral_Click" ClientIDMode="Static">
                    <i class="bi bi-check2 me-1"></i>Save General Settings
                  </asp:LinkButton>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="settings-section" id="settingsNotifications">
          <div class="data-card">
            <div class="data-card-header"><div class="data-card-title">Notification Settings</div></div>
            <div class="p-3">
              <div class="row g-3">
                <div class="col-12 d-flex align-items-center gap-2">
                  <asp:CheckBox ID="chkEmailNotif" runat="server" CssClass="form-check-input" ClientIDMode="Static" />
                  <label class="form-check-label fw-600">Email Notifications</label>
                </div>
                <div class="col-12 d-flex align-items-center gap-2">
                  <asp:CheckBox ID="chkSMSNotif" runat="server" CssClass="form-check-input" ClientIDMode="Static" />
                  <label class="form-check-label fw-600">SMS Notifications</label>
                </div>
                <div class="col-12 d-flex align-items-center gap-2">
                  <asp:CheckBox ID="chkLowStockAlert" runat="server" CssClass="form-check-input" ClientIDMode="Static" />
                  <label class="form-check-label fw-600">Low Stock Alerts</label>
                </div>
                <div class="col-12 d-flex align-items-center gap-2">
                  <asp:CheckBox ID="chkExpiryAlert" runat="server" CssClass="form-check-input" ClientIDMode="Static" />
                  <label class="form-check-label fw-600">Expiry Alerts</label>
                </div>
                <div class="col-12 text-end mt-2">
                  <asp:LinkButton ID="btnSaveNotif" runat="server" CssClass="btn btn-primary-custom fw-600"
                    OnClick="btnSaveNotif_Click" ClientIDMode="Static">
                    <i class="bi bi-check2 me-1"></i>Save Notification Settings
                  </asp:LinkButton>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="settings-section" id="settingsSecurity">
          <div class="data-card">
            <div class="data-card-header"><div class="data-card-title">Security Settings</div></div>
            <div class="p-3">
              <div class="row g-3">
                <div class="col-12 d-flex align-items-center gap-2">
                  <asp:CheckBox ID="chkTwoFA" runat="server" CssClass="form-check-input" ClientIDMode="Static" />
                  <label class="form-check-label fw-600">Enable Two-Factor Authentication</label>
                </div>
                <div class="col-md-6"><label class="form-label fw-600">Min Password Length</label>
                  <asp:TextBox ID="txtMinPwdLen" runat="server" TextMode="Number" CssClass="form-control form-control-custom" ClientIDMode="Static" />
                </div>
                <div class="col-md-6"><label class="form-label fw-600">Session Timeout (mins)</label>
                  <asp:TextBox ID="txtSessionTimeout" runat="server" TextMode="Number" CssClass="form-control form-control-custom" ClientIDMode="Static" />
                </div>
                <div class="col-12 text-end mt-2">
                  <asp:LinkButton ID="btnSaveSecurity" runat="server" CssClass="btn btn-primary-custom fw-600"
                    OnClick="btnSaveSecurity_Click" ClientIDMode="Static">
                    <i class="bi bi-check2 me-1"></i>Save Security Settings
                  </asp:LinkButton>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="settings-section" id="settingsPayment">
          <div class="data-card">
            <div class="data-card-header"><div class="data-card-title">Payment Settings</div></div>
            <div class="p-3">
              <div class="row g-3">
                <div class="col-md-6"><label class="form-label fw-600">Default Tax Rate (%)</label>
                  <asp:TextBox ID="txtTaxRate" runat="server" TextMode="Number" CssClass="form-control form-control-custom" ClientIDMode="Static" />
                </div>
                <div class="col-md-6"><label class="form-label fw-600">Currency</label>
                  <asp:DropDownList ID="ddlCurrency" runat="server" CssClass="form-select form-control-custom" ClientIDMode="Static">
                    <asp:ListItem>INR</asp:ListItem><asp:ListItem>USD</asp:ListItem><asp:ListItem>EUR</asp:ListItem>
                  </asp:DropDownList>
                </div>
                <div class="col-12 d-flex align-items-center gap-2"><asp:CheckBox ID="chkCOD" runat="server" CssClass="form-check-input" ClientIDMode="Static" /><label class="form-check-label fw-600">Cash on Delivery</label></div>
                <div class="col-12 d-flex align-items-center gap-2"><asp:CheckBox ID="chkCard" runat="server" CssClass="form-check-input" ClientIDMode="Static" /><label class="form-check-label fw-600">Card Payment</label></div>
                <div class="col-12 d-flex align-items-center gap-2"><asp:CheckBox ID="chkUPI" runat="server" CssClass="form-check-input" ClientIDMode="Static" /><label class="form-check-label fw-600">UPI</label></div>
                <div class="col-12 text-end mt-2">
                  <asp:LinkButton ID="btnSavePayment" runat="server" CssClass="btn btn-primary-custom fw-600"
                    OnClick="btnSavePayment_Click" ClientIDMode="Static">
                    <i class="bi bi-check2 me-1"></i>Save Payment Settings
                  </asp:LinkButton>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="settings-section" id="settingsAppearance">
          <div class="data-card">
            <div class="data-card-header"><div class="data-card-title">Appearance Settings</div></div>
            <div class="p-3">
              <div class="row g-3">
                <div class="col-md-6"><label class="form-label fw-600">Font Family</label>
                  <asp:TextBox ID="txtFontFamily" runat="server" CssClass="form-control form-control-custom" ClientIDMode="Static" />
                </div>
                <div class="col-md-6"><label class="form-label fw-600">Primary Color</label>
                  <asp:TextBox ID="txtPrimaryColor" runat="server" TextMode="Color" CssClass="form-control form-control-custom" ClientIDMode="Static" />
                </div>
                <div class="col-md-6"><label class="form-label fw-600">Accent Color</label>
                  <asp:TextBox ID="txtAccentColor" runat="server" TextMode="Color" CssClass="form-control form-control-custom" ClientIDMode="Static" />
                </div>
                <div class="col-md-6"><label class="form-label fw-600">Sidebar Style</label>
                  <asp:DropDownList ID="ddlSidebarStyle" runat="server" CssClass="form-select form-control-custom" ClientIDMode="Static">
                    <asp:ListItem>Dark</asp:ListItem><asp:ListItem>Light</asp:ListItem>
                  </asp:DropDownList>
                </div>
                <div class="col-12 text-end mt-2">
                  <asp:LinkButton ID="btnSaveAppearance" runat="server" CssClass="btn btn-primary-custom fw-600"
                    OnClick="btnSaveAppearance_Click" ClientIDMode="Static">
                    <i class="bi bi-check2 me-1"></i>Save Appearance Settings
                  </asp:LinkButton>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</div>

<div id="toast-container"></div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="../assets/js/main.js"></script>
<script src="../assets/js/admin.js"></script>
<script>
document.addEventListener('DOMContentLoaded', () => {
  document.getElementById('headerMount').innerHTML = ADMIN_HEADER('System Settings', 'Settings');
  initSidebar('adminSidebar', 'adminOverlay');

  // Restore active tab after postback
  const saved = document.getElementById('hdnActiveTab').value || 'general';
  const navItems = document.querySelectorAll('.settings-nav-item');
  const sectionMap = ['general','notifications','security','payment','appearance'];
  navItems.forEach((item, i) => {
    if (sectionMap[i] === saved) {
      item.classList.add('active');
      const sec = document.getElementById('settings' + saved.charAt(0).toUpperCase() + saved.slice(1));
      if (sec) { sec.classList.add('active'); }
    } else {
      item.classList.remove('active');
    }
  });
});
function switchSettings(el, section) {
  document.querySelectorAll('.settings-nav-item').forEach(i => i.classList.remove('active'));
  el.classList.add('active');
  document.querySelectorAll('.settings-section').forEach(s => s.classList.remove('active'));
  const target = document.getElementById('settings' + section.charAt(0).toUpperCase() + section.slice(1));
  if (target) target.classList.add('active');
  // Persist active tab
  document.getElementById('hdnActiveTab').value = section;
}
</script>
</body>
</asp:Content>
