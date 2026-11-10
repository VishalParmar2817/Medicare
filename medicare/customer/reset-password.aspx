<%@ Page Title="Reset Password — MediCare Pharmacy" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="reset-password.aspx.cs" Inherits="medicare.customer.resetPassword" %>

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
            <div class="brand-icon"><i class="bi bi-key-fill"></i></div>
            <div class="auth-title">Reset Password</div>
            <div class="auth-subtitle">Create a new strong password for your account</div>
          </div>
          <div class="mb-3">
            <label class="form-label fw-600 small">New Password</label>
            <div class="input-group-custom position-relative">
              <i class="bi bi-lock input-icon"></i>
              <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="form-control form-control-custom" placeholder="Min 8 characters" style="padding-left:2.5rem;padding-right:2.5rem" ClientIDMode="Static" />
              <button type="button" class="btn p-0 position-absolute" style="right:.9rem;top:50%;transform:translateY(-50%);border:none;background:none;color:var(--gray-400)" onclick="togglePwd('txtNewPassword',this)"><i class="bi bi-eye"></i></button>
            </div>
            <!-- Strength indicator -->
            <div class="mt-2">
              <div class="d-flex gap-1 mb-1" id="strengthBars">
                <div class="flex-1 rounded" style="height:4px;background:var(--gray-300)" id="sb1"></div>
                <div class="flex-1 rounded" style="height:4px;background:var(--gray-300)" id="sb2"></div>
                <div class="flex-1 rounded" style="height:4px;background:var(--gray-300)" id="sb3"></div>
                <div class="flex-1 rounded" style="height:4px;background:var(--gray-300)" id="sb4"></div>
              </div>
              <small id="strengthLabel" class="text-muted" style="font-size:.75rem">Password strength</small>
            </div>
          </div>
          <div class="mb-4">
            <label class="form-label fw-600 small">Confirm New Password</label>
            <div class="input-group-custom position-relative">
              <i class="bi bi-lock input-icon"></i>
              <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control form-control-custom" placeholder="Repeat password" style="padding-left:2.5rem;padding-right:2.5rem" ClientIDMode="Static" />
              <button type="button" class="btn p-0 position-absolute" style="right:.9rem;top:50%;transform:translateY(-50%);border:none;background:none;color:var(--gray-400)" onclick="togglePwd('txtConfirmPassword',this)"><i class="bi bi-eye"></i></button>
            </div>
          </div>
          <ul class="list-unstyled mb-4" style="font-size:.8rem;color:var(--gray-400)">
            <li id="r1"><i class="bi bi-circle me-1"></i>At least 8 characters</li>
            <li id="r2"><i class="bi bi-circle me-1"></i>One uppercase letter</li>
            <li id="r3"><i class="bi bi-circle me-1"></i>One number</li>
            <li id="r4"><i class="bi bi-circle me-1"></i>One special character</li>
          </ul>
          <asp:Button ID="btnResetPassword" runat="server" Text="Reset Password" CssClass="btn btn-primary-custom w-100 py-2 fw-600" OnClick="btnResetPassword_Click" ClientIDMode="Static" />
          
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
function togglePwd(id, btn) {
  const inp = document.getElementById(id);
  if (!inp) return;
  const isText = inp.type === 'text';
  inp.type = isText ? 'password' : 'text';
  btn.querySelector('i').className = isText ? 'bi bi-eye' : 'bi bi-eye-slash';
}

document.getElementById('txtNewPassword').addEventListener('input', function() {
  const v = this.value;
  const checks = [v.length >= 8, /[A-Z]/.test(v), /[0-9]/.test(v), /[^A-Za-z0-9]/.test(v)];
  const score = checks.filter(Boolean).length;
  const colors = ['','#ef4444','#f59e0b','#22c55e','#16a34a'];
  const labels = ['','Weak','Fair','Good','Strong'];
  ['sb1','sb2','sb3','sb4'].forEach((id,i) => {
    const el = document.getElementById(id);
    if (el) el.style.background = i < score ? colors[score] : 'var(--gray-300)';
  });
  const lbl = document.getElementById('strengthLabel');
  if (lbl) {
    lbl.textContent = labels[score] || 'Password strength';
    lbl.style.color = colors[score] || 'var(--gray-400)';
  }
  const rules = ['r1','r2','r3','r4'];
  rules.forEach((id,i) => {
    const el = document.getElementById(id);
    if (el) {
      if (checks[i]) {
        el.style.color = '#22c55e';
        el.querySelector('i').className = 'bi bi-check-circle-fill me-1';
      } else {
        el.style.color = 'var(--gray-400)';
        el.querySelector('i').className = 'bi bi-circle me-1';
      }
    }
  });
});

function handleResetPassword() {
  const p1 = document.getElementById('txtNewPassword').value;
  const p2 = document.getElementById('txtConfirmPassword').value;
  if (!p1 || p1.length < 8) {
    showToast('Password must be at least 8 characters.', 'error');
    return;
  }
  if (p1 !== p2) {
    showToast('Passwords do not match!', 'error');
    return;
  }
  showLoader();
  setTimeout(() => {
    hideLoader();
    showToast('Password reset successfully!', 'success');
    setTimeout(() => window.location.href = 'login.aspx', 1200);
  }, 1000);
}
</script>
</body>
</asp:Content>
