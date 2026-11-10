<%@ Page Title="Access Restricted - MediCare" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="access-denied.aspx.cs" Inherits="medicare.customer.access_denied" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <link rel="stylesheet" href="../assets/css/customer.css">
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
      <div class="col-md-6">
        <div class="auth-card text-center">
          <div class="brand-icon mx-auto mb-3"><i class="bi bi-lock-fill"></i></div>
          <h1 class="h3 fw-700" id="accessDeniedTitle">Access restricted</h1>
          <p class="text-muted" id="accessDeniedMessage">You do not have permission to view this page.</p>
          <a id="dashboardLink" href="login.aspx" class="btn btn-primary-custom px-4"><i class="bi bi-speedometer2 me-2"></i>Go to Dashboard</a>
          <a href="../index.aspx" class="btn btn-link d-block mt-2">Return to MediCare</a>
        </div>
      </div>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
  window.sessionUser = '<%= Session["customer"] != null ? Session["customer"].ToString() : "" %>';
  window.sessionRole = 'customer';
</script><script src="../assets/js/main.js"></script>
<script>
  const userEmail = window.sessionUser || '';
  const userRole = (window.sessionRole || '').toLowerCase();
  const required = new URLSearchParams(window.location.search).get('required') || 'authorized';
  const msgEl = document.getElementById('accessDeniedMessage');
  const dashLink = document.getElementById('dashboardLink');
  if (userEmail) {
    if (msgEl) msgEl.textContent = `This area requires the ${required} role. You are signed in as ${userEmail} (${userRole || 'customer'}).`;
    if (dashLink) dashLink.href = (userRole === 'admin' ? '../admin/dashboard.aspx' : (userRole === 'pharmacist' ? '../pharmacist/dashboard.aspx' : 'dashboard.aspx'));
  } else {
    if (msgEl) msgEl.textContent = 'Please sign in with an authorized account to continue.';
    if (dashLink) dashLink.href = 'login.aspx';
  }
</script>
</body>
</asp:Content>
