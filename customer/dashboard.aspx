<%@ Page Title="Customer Dashboard — MediCare Pharmacy" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="medicare.customer.dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <link rel="stylesheet" href="../assets/css/customer.css" />
  <style>
    .dash-hero {
      background: linear-gradient(135deg, #1a6bcc 0%, #00b4d8 100%);
      color: #fff;
      padding: 2rem;
      border-radius: 16px;
      margin-bottom: 2rem;
      box-shadow: 0 10px 25px rgba(26,107,204,0.15);
    }
    .stat-card {
      background: #fff;
      border-radius: 14px;
      padding: 1.25rem 1.5rem;
      border: 1px solid #e2e8f0;
      transition: all 0.25s ease;
      display: flex;
      align-items: center;
      gap: 1.1rem;
      box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
      text-decoration: none;
      color: inherit;
    }
    .stat-card:hover {
      transform: translateY(-3px);
      box-shadow: 0 12px 20px -3px rgba(0,0,0,0.08);
      color: inherit;
    }
    .stat-icon {
      width: 52px;
      height: 52px;
      border-radius: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.5rem;
      flex-shrink: 0;
    }
  </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>

<asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
<!-- CUSTOMER NAVBAR -->
<nav class="navbar navbar-expand-lg customer-navbar">
  <div class="container">
    <a class="navbar-brand navbar-brand-custom" href="../index.aspx">
      <div class="brand-icon"><i class="bi bi-capsule-pill"></i></div>
      <span>Medi<b>Care</b></span>
    </a>
    <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navDash">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navDash">
      <ul class="navbar-nav mx-auto gap-1" id="navLinks"></ul>

      <div class="d-flex align-items-center gap-3">
        <div class="search-bar d-none d-lg-block" style="max-width:220px">
          <i class="bi bi-search"></i>
          <input type="text" class="form-control nav-search-input" placeholder="Search medicines...">
        </div>
        <a href="cart.aspx" class="cart-btn" title="Cart">
          <i class="bi bi-cart3"></i>
          <span class="cart-count" id="navCartCount">0</span>
        </a>
        <div id="navAccountArea"></div>
      </div>
    </div>
  </div>
</nav>

<div class="container py-4">
  <!-- Hero Welcome Banner -->
  <div class="dash-hero">
    <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
      <div>
        <span class="badge bg-white text-primary mb-2 px-3 py-1 fw-600 rounded-pill">Customer Portal</span>
        <h2 class="fw-700 mb-1">Welcome back, <asp:Label ID="lblCustomerEmail" runat="server" /></h2>
        <p class="mb-0 opacity-90">Manage your pharmacy orders, upload prescriptions, and view your health profile.</p>
      </div>
      <div>
        <a href="medicines.aspx" class="btn btn-light fw-600 px-3 me-2"><i class="bi bi-capsule me-1"></i> Browse Medicines</a>
        <a href="../Logout.aspx" class="btn btn-outline-light fw-600 px-3"><i class="bi bi-box-arrow-right me-1"></i> Logout</a>
      </div>
    </div>
  </div>

  <!-- 4 Quick Stats -->
  <div class="row g-3 mb-4">
    <div class="col-md-3 col-sm-6">
      <a href="orders.aspx" class="stat-card">
        <div class="stat-icon bg-primary-subtle text-primary">
          <i class="bi bi-bag-check-fill"></i>
        </div>
        <div>
          <div class="fw-700 fs-4"><asp:Label ID="lblStatOrders" runat="server" Text="0" /></div>
          <div class="text-muted small">My Orders</div>
        </div>
      </a>
    </div>
    <div class="col-md-3 col-sm-6">
      <a href="prescription.aspx" class="stat-card">
        <div class="stat-icon bg-info-subtle text-info">
          <i class="bi bi-file-medical-fill"></i>
        </div>
        <div>
          <div class="fw-700 fs-4"><asp:Label ID="lblStatRx" runat="server" Text="0" /></div>
          <div class="text-muted small">Prescriptions</div>
        </div>
      </a>
    </div>
    <div class="col-md-3 col-sm-6">
      <a href="cart.aspx" class="stat-card">
        <div class="stat-icon bg-success-subtle text-success">
          <i class="bi bi-cart3"></i>
        </div>
        <div>
          <div class="fw-700 fs-4"><asp:Label ID="lblStatCart" runat="server" Text="0" /></div>
          <div class="text-muted small">Cart Items</div>
        </div>
      </a>
    </div>
    <div class="col-md-3 col-sm-6">
      <a href="profile.aspx" class="stat-card">
        <div class="stat-icon bg-warning-subtle text-warning">
          <i class="bi bi-person-circle"></i>
        </div>
        <div>
          <div class="fw-700 fs-5">My Profile</div>
          <div class="text-muted small">View & Edit Details</div>
        </div>
      </a>
    </div>
  </div>

  <!-- Main Section: Profile Details + Quick Actions -->
  <div class="row g-4">
    <!-- User Profile Overview Card -->
    <div class="col-lg-8">
      <div class="card border-0 shadow-sm rounded-4 p-4 mb-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
          <h5 class="fw-700 mb-0"><i class="bi bi-person-badge text-primary me-2"></i>My Profile Details</h5>
          <a href="profile.aspx" class="btn btn-outline-primary btn-sm fw-600 rounded-pill px-3">
            <i class="bi bi-pencil-square me-1"></i>Edit Profile
          </a>
        </div>
        
        <!-- Profile Banner inside card -->
        <div class="d-flex align-items-center gap-3 p-3 bg-light rounded-4 mb-3">
          <div class="avatar avatar-lg rounded-circle text-white fw-700 fs-4 d-flex align-items-center justify-content-center" style="width:60px;height:60px;background:linear-gradient(135deg,#1a6bcc,#00b4d8);box-shadow:0 4px 12px rgba(26,107,204,.25)">
            <asp:Label ID="lblAvatarInitials" runat="server" Text="CU" />
          </div>
          <div>
            <h5 class="fw-700 mb-0"><asp:Label ID="lblProfileFullName" runat="server" Text="Customer Name" /></h5>
            <div class="text-muted small"><i class="bi bi-envelope me-1"></i><asp:Label ID="lblProfileEmail" runat="server" /></div>
            <div class="mt-1">
              <span class="badge bg-primary-subtle text-primary fw-600 px-2 py-1 rounded-pill"><asp:Label ID="lblRoleDetail" runat="server" Text="Customer" /></span>
              <span class="badge bg-success-subtle text-success fw-600 px-2 py-1 rounded-pill ms-1"><i class="bi bi-check-circle me-1"></i>Active Account</span>
            </div>
          </div>
        </div>

        <!-- Information Grid -->
        <div class="row g-3">
          <div class="col-sm-6">
            <div class="p-3 border rounded-3 bg-white h-100">
              <small class="text-muted d-block mb-1"><i class="bi bi-telephone text-primary me-1"></i>Phone Number</small>
              <strong class="text-dark"><asp:Label ID="lblDetailPhone" runat="server" Text="Not provided" /></strong>
            </div>
          </div>
          <div class="col-sm-6">
            <div class="p-3 border rounded-3 bg-white h-100">
              <small class="text-muted d-block mb-1"><i class="bi bi-calendar3 text-primary me-1"></i>Date of Birth</small>
              <strong class="text-dark"><asp:Label ID="lblDetailDOB" runat="server" Text="Not provided" /></strong>
            </div>
          </div>
          <div class="col-sm-6">
            <div class="p-3 border rounded-3 bg-white h-100">
              <small class="text-muted d-block mb-1"><i class="bi bi-gender-ambiguous text-primary me-1"></i>Gender</small>
              <strong class="text-dark"><asp:Label ID="lblDetailGender" runat="server" Text="Not specified" /></strong>
            </div>
          </div>
          <div class="col-sm-6">
            <div class="p-3 border rounded-3 bg-white h-100">
              <small class="text-muted d-block mb-1"><i class="bi bi-shield-check text-primary me-1"></i>Security Status</small>
              <strong class="text-success"><i class="bi bi-check-circle-fill me-1"></i>Session Authenticated</strong>
            </div>
          </div>
          <div class="col-12">
            <div class="p-3 border rounded-3 bg-white">
              <small class="text-muted d-block mb-1"><i class="bi bi-geo-alt text-primary me-1"></i>Saved Delivery Address</small>
              <strong class="text-dark"><asp:Label ID="lblDetailAddress" runat="server" Text="No delivery address saved yet. Update your address in Profile settings." /></strong>
            </div>
          </div>
        </div>
      </div>

      <!-- Recent Orders Card -->
      <div class="card border-0 shadow-sm rounded-4 p-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
          <h5 class="fw-700 mb-0"><i class="bi bi-clock-history text-primary me-2"></i>Recent Orders</h5>
          <a href="orders.aspx" class="text-decoration-none fw-600 small">View All Orders <i class="bi bi-arrow-right"></i></a>
        </div>
        <div class="table-responsive">
          <asp:Repeater ID="rptRecentOrders" runat="server">
            <HeaderTemplate>
              <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                  <tr class="small text-muted">
                    <th>Order Code</th>
                    <th>Date</th>
                    <th>Amount</th>
                    <th>Payment</th>
                    <th>Status</th>
                  </tr>
                </thead>
                <tbody>
            </HeaderTemplate>
            <ItemTemplate>
              <tr>
                <td class="fw-700 text-primary"><%# Eval("OrderCode") %></td>
                <td class="small text-muted"><%# Eval("OrderDate", "{0:dd MMM yyyy}") %></td>
                <td class="fw-600">&#8377;<%# Eval("TotalAmount") %></td>
                <td><span class="badge bg-light text-dark border"><%# Eval("PaymentStatus") %></span></td>
                <td><span class="badge bg-primary-subtle text-primary"><%# Eval("Status") %></span></td>
              </tr>
            </ItemTemplate>
            <FooterTemplate>
                </tbody>
              </table>
            </FooterTemplate>
          </asp:Repeater>
          <asp:Panel ID="pnlNoOrders" runat="server" Visible="false" CssClass="text-center py-4">
            <i class="bi bi-bag-x text-muted fs-1 d-block mb-2"></i>
            <p class="text-muted small mb-3">You haven't placed any orders yet.</p>
            <a href="medicines.aspx" class="btn btn-primary-custom btn-sm fw-600 rounded-pill px-3">Start Shopping</a>
          </asp:Panel>
        </div>
      </div>
    </div>

    <!-- Quick Actions & Help (col-lg-4) -->
    <div class="col-lg-4">
      <div class="card border-0 shadow-sm rounded-4 p-4 mb-4">
        <h5 class="fw-700 mb-3"><i class="bi bi-lightning-charge text-warning me-2"></i>Quick Actions</h5>
        <div class="d-grid gap-2">
          <a href="profile.aspx" class="btn btn-outline-primary text-start"><i class="bi bi-person-gear me-2"></i>Edit My Profile</a>
          <a href="medicines.aspx" class="btn btn-outline-primary text-start"><i class="bi bi-search me-2"></i>Browse Medications</a>
          <a href="prescription.aspx" class="btn btn-outline-primary text-start"><i class="bi bi-cloud-arrow-up me-2"></i>Upload Prescription</a>
          <a href="orders.aspx" class="btn btn-outline-primary text-start"><i class="bi bi-truck me-2"></i>Track Orders</a>
          <a href="feedback.aspx" class="btn btn-outline-primary text-start"><i class="bi bi-star me-2"></i>Write Feedback</a>
          <a href="../Logout.aspx" class="btn btn-outline-danger text-start"><i class="bi bi-box-arrow-right me-2"></i>Sign Out</a>
        </div>
      </div>

      <div class="card border-0 shadow-sm rounded-4 p-4 bg-primary text-white">
        <h6 class="fw-700 mb-2"><i class="bi bi-shield-check me-2"></i>Need Help?</h6>
        <p class="small opacity-90 mb-3">Our customer support and licensed pharmacists are available 24/7 to assist you.</p>
        <a href="contact.aspx" class="btn btn-light text-primary btn-sm fw-600 rounded-pill w-100">Contact Support</a>
      </div>
    </div>
  </div>
</div>

<div id="toast-container"></div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
  window.sessionUser = '<%= Session["customer"] != null ? Session["customer"].ToString() : "" %>';
  window.sessionRole = 'customer';
</script><script src="../assets/js/main.js"></script>
</asp:Content>
