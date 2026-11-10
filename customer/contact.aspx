<%@ Page Title="Contact Us — MediCare Pharmacy" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="contact.aspx.cs" Inherits="medicare.customer.contact" %>

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
    <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navContact">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navContact">
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
  <section class="info-hero">
    <div class="hero-kicker">CONTACT US</div>
    <h1>We are here to help.</h1>
    <p class="mb-0">Questions about an order, prescription, or product? Send us a note and our support team will get back to you.</p>
  </section>
  <div class="row g-4">
    <div class="col-lg-7">
      <div class="info-card">
        <h4 class="fw-700 mb-4">Send us a message</h4>
        <div class="info-form" id="contactForm">
          <div class="row g-3">
            <div class="col-md-6">
              <label for="txtContactName" class="form-label">Your name</label>
              <asp:TextBox ID="txtContactName" runat="server" CssClass="form-control" ClientIDMode="Static" />
            </div>
            <div class="col-md-6">
              <label for="txtContactEmail" class="form-label">Email address</label>
              <asp:TextBox ID="txtContactEmail" runat="server" TextMode="Email" CssClass="form-control" ClientIDMode="Static" />
            </div>
            <div class="col-12">
              <label for="ddlContactTopic" class="form-label">Topic</label>
              <asp:DropDownList ID="ddlContactTopic" runat="server" CssClass="form-select" ClientIDMode="Static">
                <asp:ListItem>Order support</asp:ListItem>
                <asp:ListItem>Prescription help</asp:ListItem>
                <asp:ListItem>Product question</asp:ListItem>
                <asp:ListItem>Other</asp:ListItem>
              </asp:DropDownList>
            </div>
            <div class="col-12">
              <label for="txtContactMessage" class="form-label">Message</label>
              <asp:TextBox ID="txtContactMessage" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control" ClientIDMode="Static" />
            </div>
          </div>
          <asp:Button ID="btnSendContact" runat="server" Text="Send message" CssClass="btn btn-primary-custom mt-4 px-4" OnClick="btnSendContact_Click" />
          <div id="contactStatus" class="alert alert-success mt-3 d-none">Thanks. Your message has been received.</div>
        </div>
      </div>
    </div>
    <div class="col-lg-5">
      <div class="info-card mb-4">
        <i class="bi bi-headset"></i>
        <h5>Customer support</h5>
        <p class="mb-2">Mon-Sun, 8:00 AM - 10:00 PM</p>
        <a href="tel:+18001234567">1800 123 4567</a><br>
        <a href="mailto:care@medicare.example">care@medicare.example</a>
      </div>
      <div class="info-card">
        <i class="bi bi-geo-alt-fill"></i>
        <h5>Our pharmacy team</h5>
        <p>Serving customers across India with secure online pharmacy support.</p>
      </div>
    </div>
  </div>
</main>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
  window.sessionUser = '<%= Session["customer"] != null ? Session["customer"].ToString() : "" %>';
  window.sessionRole = 'customer';
</script><script src="../assets/js/main.js"></script>
<script>
function submitContact() {
  document.getElementById('contactStatus').classList.remove('d-none');
  const n = document.getElementById('txtContactName'); if(n) n.value='';
  const e = document.getElementById('txtContactEmail'); if(e) e.value='';
  const m = document.getElementById('txtContactMessage'); if(m) m.value='';
}
</script>
</body>
</asp:Content>
