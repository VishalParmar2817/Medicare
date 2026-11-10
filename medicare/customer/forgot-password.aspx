<%@ Page Title="Forgot Password — MediCare Pharmacy" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="forgot-password.aspx.cs" Inherits="medicare.customer.forgotPassword" %>

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
            <div class="brand-icon"><i class="bi bi-lock-fill"></i></div>
            <div class="auth-title">Forgot Password?</div>
            <div class="auth-subtitle">Enter your email and we'll send you a reset link</div>
          </div>
          <div id="step1">
            <div class="mb-4">
              <label class="form-label fw-600 small">Registered Email</label>
              <div class="input-group-custom">
                <i class="bi bi-envelope input-icon"></i>
                <asp:TextBox ID="txtResetEmail" runat="server" TextMode="Email" CssClass="form-control form-control-custom" placeholder="user@example.com" ClientIDMode="Static" />
              </div>
            </div>
            <asp:Button ID="btnSendResetLink" runat="server" Text="Send Reset Link" CssClass="btn btn-primary-custom w-100 py-2 fw-600" OnClick="btnSendResetLink_Click" ClientIDMode="Static" />
          </div>
          <div id="step2" style="display:none;text-align:center">
            <div style="font-size:3.5rem;margin-bottom:1rem">📧</div>
            <h5 class="fw-700">Check Your Email</h5>
            <p class="text-muted" style="font-size:.88rem">We've sent a password reset link to your email address. Please check your inbox and spam folder.</p>
            <a href="reset-password.aspx" class="btn btn-primary-custom w-100 mt-3">Go to Reset Password</a>
            <p class="mt-3 text-muted small">Didn't receive the email? <a href="#" class="text-primary" onclick="resend(); return false;">Resend in <span id="timer">60</span>s</a></p>
          </div>
          <p class="text-center mt-4 mb-0" style="font-size:.88rem">
            <a href="login.aspx" class="text-primary fw-600"><i class="bi bi-arrow-left me-1"></i>Back to Login</a>
          </p>
        </div>
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
<script>
function handleForgotSubmit() {
  const email = document.getElementById('txtResetEmail').value.trim();
  if (!email) {
    showToast('Please enter your email address.', 'error');
    return;
  }
  showLoader();
  setTimeout(() => {
    hideLoader();
    document.getElementById('step1').style.display = 'none';
    document.getElementById('step2').style.display = 'block';
    let t = 60;
    const interval = setInterval(() => {
      t--;
      const el = document.getElementById('timer');
      if (el) el.textContent = t;
      if (t <= 0) clearInterval(interval);
    }, 1000);
  }, 1000);
}
function resend() { showToast('Reset link resent!', 'info'); }
</script>
</body>
</asp:Content>
