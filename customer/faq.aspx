<%@ Page Title="FAQ & Help — MediCare Pharmacy" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="faq.aspx.cs" Inherits="medicare.customer.faq" %>

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
    <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navFaq">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navFaq">
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
    <div class="hero-kicker">FAQ / HELP</div>
    <h1>Answers for a smoother pharmacy experience.</h1>
    <p class="mb-0">Find quick answers about orders, prescriptions, delivery, payments, and returns.</p>
  </section>
  <div class="row g-4">
    <div class="col-lg-8">
      <div class="faq-list accordion" id="faqList">
        <div class="accordion-item">
          <h2 class="accordion-header"><button type="button" class="accordion-button" data-bs-toggle="collapse" data-bs-target="#faq1">How do I place an order?</button></h2>
          <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#faqList">
            <div class="accordion-body">Browse Medicines, add your products to the cart, enter your delivery details, and complete checkout.</div>
          </div>
        </div>
        <div class="accordion-item">
          <h2 class="accordion-header"><button type="button" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#faq2">How do I upload a prescription?</button></h2>
          <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#faqList">
            <div class="accordion-body">Open Prescription from the navigation, choose your file, add any notes for the pharmacist, and submit it for verification.</div>
          </div>
        </div>
        <div class="accordion-item">
          <h2 class="accordion-header"><button type="button" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#faq3">How long does delivery take?</button></h2>
          <div id="faq3" class="accordion-collapse collapse" data-bs-parent="#faqList">
            <div class="accordion-body">Delivery timing depends on your location. Your order confirmation will include the latest estimated delivery time.</div>
          </div>
        </div>
        <div class="accordion-item">
          <h2 class="accordion-header"><button type="button" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#faq4">Can I cancel or return an order?</button></h2>
          <div id="faq4" class="accordion-collapse collapse" data-bs-parent="#faqList">
            <div class="accordion-body">Contact our support team as soon as possible. Returns depend on the product type, condition, and applicable pharmacy rules.</div>
          </div>
        </div>
        <div class="accordion-item">
          <h2 class="accordion-header"><button type="button" class="accordion-button collapsed" data-bs-toggle="collapse" data-bs-target="#faq5">How can I contact a pharmacist?</button></h2>
          <div id="faq5" class="accordion-collapse collapse" data-bs-parent="#faqList">
            <div class="accordion-body">Use our Contact Us page or call customer support during service hours for help with your order or medicine questions.</div>
          </div>
        </div>
      </div>
    </div>
    <div class="col-lg-4">
      <div class="info-card">
        <i class="bi bi-question-circle-fill"></i>
        <h5>Still need help?</h5>
        <p class="mb-3">Our support team can help with orders, prescriptions, and account questions.</p>
        <a class="btn btn-primary-custom" href="contact.aspx">Contact us</a>
      </div>
    </div>
  </div>
</main>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
  window.sessionUser = '<%= Session["customer"] != null ? Session["customer"].ToString() : "" %>';
  window.sessionRole = 'customer';
</script><script src="../assets/js/main.js"></script>
</body>
</asp:Content>
