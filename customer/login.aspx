<%@ Page Title="Login — MediCare Pharmacy" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="medicare.customer.login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
<asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
<body>
<div class="auth-wrapper">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-5">
        <div class="auth-card">
          <div class="auth-logo">
            <div class="brand-icon"><i class="bi bi-capsule-pill"></i></div>
            <div class="auth-title">Welcome Back</div>
            <div class="auth-subtitle" id="loginSubtitle">Sign in to your MediCare account</div>
          </div>
          <!-- Social Login -->
          <div class="d-flex gap-2 mb-4">
            <button type="button" class="btn border flex-1 d-flex align-items-center justify-content-center gap-2" style="font-size:.85rem;font-weight:500;flex:1">
              <img src="https://www.google.com/favicon.ico" width="16" alt="G"> Google
            </button>
            <button type="button" class="btn border flex-1 d-flex align-items-center justify-content-center gap-2" style="font-size:.85rem;font-weight:500;flex:1">
              <i class="bi bi-facebook text-primary"></i> Facebook
            </button>
          </div>
          <div class="d-flex align-items-center gap-2 mb-4">
            <hr class="flex-1 m-0"><span class="text-muted small">or sign in with email</span><hr class="flex-1 m-0">
          </div>
          <div class="mb-3">
            <label class="form-label fw-600 small">Email Address</label>
            <div class="input-group-custom">
              <i class="bi bi-envelope input-icon"></i>
              <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control form-control-custom" placeholder="user@example.com" ClientIDMode="Static" />
            </div>
          </div>
          <div class="mb-3">
            <div class="d-flex justify-content-between align-items-center mb-1">
              <label class="form-label fw-600 small mb-0">Password</label>
              <a href="forgot-password.aspx" class="text-primary small">Forgot Password?</a>
            </div>
            <div class="input-group-custom position-relative">
              <i class="bi bi-lock input-icon"></i>
              <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control form-control-custom" placeholder="Enter your password" style="padding-left:2.5rem;padding-right:2.5rem" ClientIDMode="Static" />
              <button type="button" class="btn p-0 position-absolute" style="right:.9rem;top:50%;transform:translateY(-50%);border:none;background:none;color:var(--gray-400)" onclick="togglePwd('txtLoginPass',this)"><i class="bi bi-eye"></i></button>
            </div>
          </div>
          <div class="d-flex align-items-center gap-2 mb-4">
            <asp:CheckBox ID="chkRememberMe" runat="server" CssClass="form-check-input m-0" ClientIDMode="Static" />
            <label class="form-check-label small" for="chkRememberMe">Remember me for 30 days</label>
          </div>
          <asp:Button ID="btnLogin" runat="server" Text="Sign In" CssClass="btn btn-primary-custom w-100 py-2 fw-600" OnClick="btnLogin_Click" ClientIDMode="Static" />
          <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger d-block mt-3 mb-0" Visible="false" />
          
          <p class="text-center mt-4 mb-0" style="font-size:.88rem">
            Don't have an account? <a href="register.aspx" class="text-primary fw-600">Create Account</a>
          </p>
          <!-- Portal Links -->
          <div class="alert-custom alert-info-custom mt-4" style="border-radius:8px;font-size:.8rem">
            <i class="bi bi-info-circle-fill"></i>
            <div><strong>Role-Based Access:</strong> Sign in with your registered account. You will automatically be routed to your authorized portal (Customer, Pharmacist, or Admin).</div>
          </div>
        </div>
        <p class="text-center text-white opacity-50 mt-3" style="font-size:.8rem">
          <a href="../index.aspx" class="text-white">← Back to Home</a> &nbsp;|&nbsp; 
          <a href="../pharmacist/dashboard.aspx" class="text-white">Pharmacist Portal</a> &nbsp;|&nbsp;
          <a href="../admin/dashboard.aspx" class="text-white">Admin Portal</a>
        </p>
      </div>
    </div>
  </div>
</div>

<div id="toast-container"></div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="../assets/js/main.js"></script>
<script>
function togglePwd(id, btn) {
  const inp = document.getElementById(id);
  if (!inp) return;
  const isText = inp.type === 'text';
  inp.type = isText ? 'password' : 'text';
  btn.querySelector('i').className = isText ? 'bi bi-eye' : 'bi bi-eye-slash';
}
</script>
</body>
</asp:Content>
