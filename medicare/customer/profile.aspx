<%@ Page Title="My Profile — MediCare Pharmacy" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="medicare.customer.profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <link rel="stylesheet" href="../assets/css/customer.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
<asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
<body>
<nav class="navbar navbar-expand-lg customer-navbar">
  <div class="container">
    <a class="navbar-brand navbar-brand-custom" href="../index.aspx">
      <div class="brand-icon"><i class="bi bi-capsule-pill"></i></div>
      <span>Medi<b>Care</b></span>
    </a>
    <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navPf">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navPf">
      <ul class="navbar-nav mx-auto gap-1" id="navLinks"></ul>

      <div class="d-flex align-items-center gap-3">
        <div class="search-bar d-none d-lg-block" style="max-width:220px">
          <i class="bi bi-search"></i>
          <input type="text" class="form-control nav-search-input" placeholder="Search medicines...">
        </div>
        <a href="cart.aspx" class="cart-btn" title="Cart"><i class="bi bi-cart3"></i><span class="cart-count" id="navCartCount">0</span></a>
        <div id="navAccountArea"></div>
      </div>
    </div>
  </div>
</nav>
<div class="container py-4">
  <!-- Profile Header -->
  <div class="profile-header mb-4">
    <div class="d-flex align-items-center gap-4 flex-wrap">
      <div class="position-relative">
        <div class="avatar avatar-xl" style="background:rgba(255,255,255,.25);font-size:2rem;border:3px solid rgba(255,255,255,.4)"><asp:Label ID="lblAvatarInitials" runat="server" Text="CU" /></div>
        <button type="button" class="btn btn-sm btn-light position-absolute" style="bottom:0;right:0;border-radius:50%;width:28px;height:28px;padding:0;font-size:.75rem"><i class="bi bi-camera"></i></button>
      </div>
      <div class="text-white flex-1">
        <h4 class="fw-800 mb-1"><asp:Label ID="lblProfileName" runat="server" Text="Customer Name" /></h4>
        <div class="opacity-75 mb-1"><i class="bi bi-envelope me-1"></i><asp:Label ID="lblProfileEmail" runat="server" Text="customer@example.com" /></div>
        <div class="opacity-75"><i class="bi bi-phone me-1"></i><asp:Label ID="lblProfilePhone" runat="server" Text="+91 00000 00000" /></div>
      </div>
      <div class="d-flex gap-2 flex-wrap">
        <div class="profile-stat-tile">
          <div class="profile-stat-value"><asp:Label ID="lblProfileOrderCount" runat="server" Text="0" /></div>
          <div class="profile-stat-label">Orders</div>
        </div>
        <div class="profile-stat-tile">
          <div class="profile-stat-value"><asp:Label ID="lblProfileRxCount" runat="server" Text="0" /></div>
          <div class="profile-stat-label">Prescriptions</div>
        </div>
      </div>
    </div>
  </div>

  <div class="row g-4">
    <div class="col-md-3">
      <div class="card-custom p-3">
        <nav class="d-flex flex-column gap-1">
          <a href="#info" class="nav-link nav-link-custom active"><i class="bi bi-person me-2"></i>Personal Info</a>
          <a href="#password" class="nav-link nav-link-custom"><i class="bi bi-lock me-2"></i>Change Password</a>
          <a href="#addresses" class="nav-link nav-link-custom"><i class="bi bi-geo-alt me-2"></i>Saved Addresses</a>
          <a href="orders.aspx" class="nav-link nav-link-custom"><i class="bi bi-bag me-2"></i>Order History</a>
          <a href="prescription.aspx" class="nav-link nav-link-custom"><i class="bi bi-file-medical me-2"></i>Prescriptions</a>
          <hr class="my-1">
          <a href="../Logout.aspx" class="nav-link text-danger"><i class="bi bi-box-arrow-right me-2"></i>Logout</a>
        </nav>
      </div>
    </div>
    <div class="col-md-9">
      <!-- Personal Info -->
      <div class="card-custom p-4 mb-4" id="info">
        <div class="d-flex align-items-center justify-content-between mb-3">
          <h6 class="fw-700 mb-0"><i class="bi bi-person-fill text-primary me-2"></i>Personal Information</h6>
        </div>
        <div class="row g-3">
          <div class="col-md-6"><label class="form-label fw-600 small">First Name</label><asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control form-control-custom" ClientIDMode="Static" /></div>
          <div class="col-md-6"><label class="form-label fw-600 small">Last Name</label><asp:TextBox ID="txtLastName" runat="server" CssClass="form-control form-control-custom" ClientIDMode="Static" /></div>
          <div class="col-md-6"><label class="form-label fw-600 small">Email</label><asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control form-control-custom" ReadOnly="true" ClientIDMode="Static" /></div>
          <div class="col-md-6"><label class="form-label fw-600 small">Phone</label><asp:TextBox ID="txtPhone" runat="server" TextMode="Phone" CssClass="form-control form-control-custom" ClientIDMode="Static" /></div>
          <div class="col-md-6"><label class="form-label fw-600 small">Date of Birth</label><asp:TextBox ID="txtDOB" runat="server" TextMode="Date" CssClass="form-control form-control-custom" ClientIDMode="Static" /></div>
          <div class="col-md-6"><label class="form-label fw-600 small">Gender</label><asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control form-control-custom" ClientIDMode="Static"><asp:ListItem>Female</asp:ListItem><asp:ListItem>Male</asp:ListItem><asp:ListItem>Other</asp:ListItem></asp:DropDownList></div>
          <div class="col-12" id="saveRow">
            <asp:Button ID="btnSaveProfile" runat="server" Text="Save Changes" CssClass="btn btn-primary-custom fw-600 me-2" OnClick="btnSaveProfile_Click" />
          </div>
        </div>
      </div>
      <!-- Change Password -->
      <div class="card-custom p-4 mb-4" id="password">
        <h6 class="fw-700 mb-3"><i class="bi bi-shield-lock-fill text-primary me-2"></i>Change Password</h6>
        <div class="row g-3">
          <div class="col-12"><label class="form-label fw-600 small">Current Password</label><asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password" CssClass="form-control form-control-custom" placeholder="••••••••" /></div>
          <div class="col-md-6"><label class="form-label fw-600 small">New Password</label><asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="form-control form-control-custom" placeholder="Min 8 characters" /></div>
          <div class="col-md-6"><label class="form-label fw-600 small">Confirm New Password</label><asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control form-control-custom" placeholder="Repeat new password" /></div>
          <div class="col-12"><asp:Button ID="btnUpdatePassword" runat="server" Text="Update Password" CssClass="btn btn-primary-custom fw-600" OnClick="btnUpdatePassword_Click" /></div>
        </div>
      </div>
      <!-- Saved Addresses -->
      <div class="card-custom p-4" id="addresses">
        <div class="d-flex align-items-center justify-content-between mb-3">
          <h6 class="fw-700 mb-0"><i class="bi bi-geo-alt-fill text-primary me-2"></i>Saved Addresses</h6>
          <button type="button" class="btn btn-sm btn-primary-custom fw-600" data-bs-toggle="modal" data-bs-target="#addAddrModal"><i class="bi bi-plus me-1"></i>Add New</button>
        </div>
        <div class="row g-3">
          <div class="col-12">
            <div class="card-custom p-3" style="border:2px solid var(--primary)">
              <div class="d-flex justify-content-between mb-1"><span class="fw-700 small">🏠 Current Address</span><span class="badge-custom badge-success">Primary</span></div>
              <p style="font-size:.84rem;color:var(--dark-3);margin-bottom:.5rem"><asp:Label ID="lblSavedAddress" runat="server" Text="No address on file. Click 'Add New' to add one." /></p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Add Address Modal -->
<div class="modal fade modal-custom" id="addAddrModal" tabindex="-1">
  <div class="modal-dialog"><div class="modal-content">
    <div class="modal-header"><h6 class="modal-title fw-700">Add New Address</h6><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
    <div class="modal-body">
      <div class="row g-2">
        <div class="col-6"><asp:TextBox ID="txtAddrFullName" runat="server" CssClass="form-control form-control-custom" placeholder="Full Name" /></div>
        <div class="col-6"><asp:TextBox ID="txtAddrPhone" runat="server" TextMode="Phone" CssClass="form-control form-control-custom" placeholder="Phone" /></div>
        <div class="col-12"><asp:TextBox ID="txtAddrLine1" runat="server" CssClass="form-control form-control-custom" placeholder="Address Line 1" /></div>
        <div class="col-12"><asp:TextBox ID="txtAddrLine2" runat="server" CssClass="form-control form-control-custom" placeholder="Address Line 2 (Optional)" /></div>
        <div class="col-4"><asp:TextBox ID="txtAddrCity" runat="server" CssClass="form-control form-control-custom" placeholder="City" /></div>
        <div class="col-4"><asp:TextBox ID="txtAddrState" runat="server" CssClass="form-control form-control-custom" placeholder="State" /></div>
        <div class="col-4"><asp:TextBox ID="txtAddrPinCode" runat="server" CssClass="form-control form-control-custom" placeholder="PIN Code" /></div>
        <div class="col-12"><asp:DropDownList ID="ddlAddrType" runat="server" CssClass="form-control form-control-custom"><asp:ListItem>Home</asp:ListItem><asp:ListItem>Office</asp:ListItem><asp:ListItem>Other</asp:ListItem></asp:DropDownList></div>
      </div>
    </div>
    <div class="modal-footer"><button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button><asp:Button ID="btnSaveAddress" runat="server" Text="Save Address" CssClass="btn btn-primary-custom fw-600" OnClick="btnSaveAddress_Click" /></div>
  </div></div>
</div>

<div id="toast-container"></div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
  window.sessionUser = '<%= Session["customer"] != null ? Session["customer"].ToString() : "" %>';
  window.sessionRole = 'customer';
</script><script src="../assets/js/main.js"></script>
<script>
function toggleEdit() {
  const fields = ['txtFirstName','txtLastName','txtPhone','txtDOB','ddlGender'];
  const btn = document.getElementById('editBtn');
  const sr = document.getElementById('saveRow');
  const isEdit = btn.textContent.includes('Edit');
  fields.forEach(id => { const el = document.getElementById(id); if (el) el.disabled = !isEdit; });
  btn.innerHTML = isEdit ? '<i class="bi bi-x me-1"></i>Cancel' : '<i class="bi bi-pencil me-1"></i>Edit';
  sr.style.display = isEdit ? '' : 'none';
}
function saveProfile() { showLoader(); setTimeout(() => { hideLoader(); showToast('Profile updated!', 'success'); toggleEdit(); }, 1000); }
function changePassword() { showLoader(); setTimeout(() => { hideLoader(); showToast('Password changed successfully!', 'success'); }, 1200); }
</script>
</body>
</asp:Content>
