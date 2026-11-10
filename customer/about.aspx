<%@ Page Title="About Us — MediCare Pharmacy" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="about.aspx.cs" Inherits="medicare.customer.about" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <link rel="stylesheet" href="../assets/css/customer.css">
  <link rel="stylesheet" href="../assets/css/info-pages.css">
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
    <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navAbout">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navAbout">
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
<main class="container info-page">
  <section class="info-hero"><div class="hero-kicker">ABOUT MEDICARE</div><h1>Better access to everyday healthcare.</h1><p class="mb-0">MediCare helps families find genuine medicines, upload prescriptions securely, and get dependable pharmacist support from one trusted place.</p></section>
  <div class="row g-4 mb-4"><div class="col-md-4"><div class="info-card"><i class="bi bi-shield-check-fill"></i><h5>Trusted products</h5><p>Every product is sourced through verified pharmacy partners and handled with care.</p></div></div><div class="col-md-4"><div class="info-card"><i class="bi bi-person-badge-fill"></i><h5>Expert guidance</h5><p>Our licensed pharmacists help you make informed choices and understand your medicines.</p></div></div><div class="col-md-4"><div class="info-card"><i class="bi bi-truck"></i><h5>Reliable delivery</h5><p>Simple ordering and clear updates help your essentials arrive when you need them.</p></div></div></div>
  <section class="info-card"><h4 class="fw-700 mb-3">Care that fits real life</h4><p>From everyday wellness products to prescription support, we keep the experience clear, secure, and human. Your health information is treated with confidentiality, and our team is here to make pharmacy care easier to access.</p></section>
</main>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
  window.sessionUser = '<%= Session["customer"] != null ? Session["customer"].ToString() : "" %>';
  window.sessionRole = 'customer';
</script><script src="../assets/js/main.js"></script>
</body>
</asp:Content>
