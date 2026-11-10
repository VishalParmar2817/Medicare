<%@ Page Title="Browse Medicines — MediCare Pharmacy" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="medicines.aspx.cs" Inherits="medicare.customer.medicines" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../assets/css/customer.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
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
    <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navMedicines">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navMedicines">
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

<!-- BREADCRUMB -->
<div class="bg-white border-bottom py-2 px-4 d-flex justify-content-between align-items-center">
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb-custom mb-0">
      <li><a href="../index.aspx">Home</a></li>
      <li><i class="bi bi-chevron-right small"></i></li>
      <li class="active">Medicines</li>
    </ol>
  </nav>
</div>

<!-- PAGE HEADER BANNER -->
<div class="py-4 px-4 bg-light mb-4 border-bottom">
  <div class="container">
    <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
      <div>
        <h3 class="fw-700 mb-1"><i class="bi bi-capsule text-primary me-2"></i>Browse Medicines</h3>
        <p class="text-muted mb-0">Explore genuine prescription and wellness medications delivered safely to your door</p>
      </div>
      <div>
        <a href="prescription.aspx" class="btn btn-outline-primary-custom btn-sm fw-600"><i class="bi bi-file-medical me-1"></i>Upload Prescription</a>
      </div>
    </div>
  </div>
</div>

<!-- PRODUCT GRID CONTAINER -->
<div class="container pb-5">
  <div class="row pb-4">
    <div class="col-12 text-center mb-3">
        <asp:Label ID="Label2" runat="server" Font-Bold="True" ForeColor="#333333"></asp:Label>
    </div>
    <div class="col-12">
        <asp:DataList ID="DataList1" runat="server" RepeatColumns="4" RepeatDirection="Horizontal" CssClass="sh-datalist-table w-100" OnItemCommand="DataList1_ItemCommand">
            <ItemStyle VerticalAlign="Top" Width="25%" />
            <ItemTemplate>
                <div class="sh-product-card">
                    <div class="sh-product-image">
                        <asp:Image ID="Image1" runat="server"
                            ImageUrl='<%# Eval("ImageUrl") != null && !string.IsNullOrEmpty(Eval("ImageUrl").ToString()) ? Eval("ImageUrl") : "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=700&q=85" %>'
                            AlternateText='<%# Eval("Name") %>'
                            onerror="this.onerror=null;this.src='https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=700&q=85';" />
                        <span class="sh-badge"><%# Eval("CategoryName") != null && !string.IsNullOrEmpty(Eval("CategoryName").ToString()) ? Eval("CategoryName") : "Bestseller" %></span>
                        <button type="button" class="sh-wishlist-btn" title="Add to Wishlist" onclick="this.classList.toggle('active'); return false;">
                            <i class="fa-regular fa-heart"></i>
                        </button>
                        <div class="sh-product-actions">
                            <asp:LinkButton ID="LinkButton1" runat="server" CommandName="cmd_vd" CommandArgument='<%# Eval("MedicineID") %>' CssClass="sh-view-btn">View Details</asp:LinkButton>
                            <asp:LinkButton ID="LinkButton2" runat="server" CommandName="cmd_cart" CommandArgument='<%# Eval("MedicineID") %>' CssClass="sh-cart-btn">
                                <i class="fa-solid fa-bag-shopping"></i> Add
                            </asp:LinkButton>
                        </div>
                    </div>
                    <div class="sh-product-info">
                        <h5 class="sh-product-name"><%# Eval("Name") %></h5>
                        <div class="sh-product-rating">
                            <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
                            <i class="fa-solid fa-star"></i>
                        </div>
                        <div class="sh-product-price">
                            &#8377;<%# string.Format("{0:N0}", Eval("Price")) %>
                            <span class="sh-old-price">
                                <%# Convert.ToDouble(Eval("MRP")) > Convert.ToDouble(Eval("Price"))
                                    ? "&#8377;" + string.Format("{0:N0}", Eval("MRP"))
                                    : "" %>
                            </span>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:DataList>
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
