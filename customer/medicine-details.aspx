<%@ Page Title="Medicine Details — MediCare Pharmacy" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="medicine-details.aspx.cs" Inherits="medicare.customer.medicine_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <link rel="stylesheet" href="../assets/css/customer.css">
  <link rel="stylesheet" href="../assets/css/medicine-details.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
<asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
<body>
<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg customer-navbar">
  <div class="container">
    <a class="navbar-brand navbar-brand-custom" href="../index.aspx">
      <div class="brand-icon"><i class="bi bi-capsule-pill"></i></div>
      <span>Medi<b>Care</b></span>
    </a>
    <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navMain3">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navMain3">
      <ul class="navbar-nav mx-auto gap-1" id="navLinks"></ul>

      <div class="d-flex align-items-center gap-3">
        <div class="search-bar d-none d-lg-block" style="max-width:220px">
          <i class="bi bi-search"></i>
          <input type="text" class="form-control nav-search-input" id="globalSearch" placeholder="Search medicines...">
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
      <li><a href="medicines.aspx">Medicines</a></li>
      <li><i class="bi bi-chevron-right small"></i></li>
      <li id="breadcrumbMedicine">Medicine Details</li>
    </ol>
  </nav>
  <asp:Label ID="Label1" runat="server" CssClass="fw-600 text-primary small"></asp:Label>
</div>

<!-- MAIN CONTENT -->
<div class="container-fluid px-4 py-4">
  <!-- ERROR / NOT FOUND STATE -->
  <asp:Panel ID="pnlNotFound" runat="server" Visible="false" CssClass="text-center py-5">
    <div class="empty-state">
      <i class="bi bi-exclamation-triangle fs-1 text-warning mb-2 d-block"></i>
      <h5>Medicine Not Found</h5>
      <p class="text-muted">The medicine you're looking for doesn't exist or has been removed.</p>
      <a href="medicines.aspx" class="btn btn-primary-custom">Browse All Medicines</a>
    </div>
  </asp:Panel>

  <!-- CONTENT VIA DATALIST -->
  <div id="medContent">
    <asp:DataList ID="DataList1" runat="server" Width="100%" OnItemCommand="DataList1_ItemCommand">
      <ItemTemplate>
        <!-- PRODUCT SECTION -->
        <div class="row g-4 mb-5">
          <!-- Left: Image Gallery -->
          <div class="col-lg-5">
            <div class="medicine-detail-image">
              <div class="med-image-main" id="medImageMain">
                <asp:Image ID="Image1" runat="server"
                  ImageUrl='<%# Eval("ImageUrl") != null && !string.IsNullOrEmpty(Eval("ImageUrl").ToString()) ? Eval("ImageUrl") : "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=700&q=85" %>'
                  AlternateText='<%# Eval("Name") %>'
                  CssClass="img-fluid med-detail-main-img"
                  onerror="this.onerror=null;this.src='https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=700&q=85';" />
              </div>
              
              <button type="button" class="medicine-wishlist-detail" id="wishlistBtn" onclick="toggleWishlist(this); return false;">
                <i class="bi bi-heart"></i>
              </button>
              <!-- Thumbnail gallery -->
              <div class="med-image-gallery mt-3" id="medImageGallery">
                <div class="med-image-thumb active">
                  <img src='<%# Eval("ImageUrl") %>' alt="thumb" style="max-height:45px;max-width:45px;object-fit:contain" onerror="this.src='https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=100&q=85';" />
                </div>
              </div>
            </div>
          </div>

          <!-- Right: Product Info -->
          <div class="col-lg-7">
            <!-- Badges -->
            <div class="mb-3">
              <span class="badge-custom badge-primary"><%# Eval("CategoryName") != null && !string.IsNullOrEmpty(Eval("CategoryName").ToString()) ? Eval("CategoryName") : "General" %></span>
              <span class="badge-custom badge-info ms-1"><%# Eval("BrandName") != null && !string.IsNullOrEmpty(Eval("BrandName").ToString()) ? Eval("BrandName") : "Brand" %></span>
              <span class="badge-custom badge-warning ms-1" style='<%# Eval("RxRequired") != null && Eval("RxRequired") != DBNull.Value && Convert.ToBoolean(Eval("RxRequired")) ? "display:inline-block;" : "display:none;" %>'><i class="bi bi-exclamation-circle-fill me-1"></i>Prescription Required</span>
            </div>

            <!-- Name & Meta -->
            <h1 class="fw-700 mb-2"><%# Eval("Name") %></h1>
            <p class="text-muted mb-3"><%# Eval("GenericName") != null && !string.IsNullOrEmpty(Eval("GenericName").ToString()) ? Eval("GenericName") : Eval("Name") %></p>

            <!-- Rating & Reviews -->
            <div class="mb-3 d-flex align-items-center gap-2">
              <div class="star-rating text-warning">
                <i class="bi bi-star-fill"></i>
                <i class="bi bi-star-fill"></i>
                <i class="bi bi-star-fill"></i>
                <i class="bi bi-star-fill"></i>
                <i class="bi bi-star-half"></i>
              </div>
            </div>

            <!-- Pricing -->
           
            <!-- Stock & Availability -->
            <div class="stock-section mb-4">
              <p class="mb-2">
                <span class='<%# Eval("Stock") != null && Eval("Stock") != DBNull.Value && Convert.ToInt32(Eval("Stock")) > 50 ? "stock-indicator-detail stock-in-stock" : (Eval("Stock") != null && Eval("Stock") != DBNull.Value && Convert.ToInt32(Eval("Stock")) > 0 ? "stock-indicator-detail stock-low-stock" : "stock-indicator-detail stock-out") %>'>
                  <span class="stock-dot"></span><%# Eval("Stock") != null && Eval("Stock") != DBNull.Value && Convert.ToInt32(Eval("Stock")) > 50 ? "In Stock" : (Eval("Stock") != null && Eval("Stock") != DBNull.Value && Convert.ToInt32(Eval("Stock")) > 0 ? "Low Stock" : "Out of Stock") %>
                </span>
                <span class="text-muted ms-2">(<%# Eval("Stock") %> units available)</span>
              </p>
            </div>

            <!-- Medicine Properties -->
            <div class="med-properties mb-4">
              <div class="property-item">
                <span class="property-label">Dosage Form</span>
                <span class="property-value"><%# Eval("DosageForm") != null && !string.IsNullOrEmpty(Eval("DosageForm").ToString()) ? Eval("DosageForm") : "Tablet" %></span>
              </div>
              <div class="property-item">
                <span class="property-label">Strength</span>
                <span class="property-value"><%# Eval("Strength") != null && !string.IsNullOrEmpty(Eval("Strength").ToString()) ? Eval("Strength") : "500 mg" %></span>
              </div>
              <div class="property-item">
                <span class="property-label">Pack Size</span>
                <span class="property-value"><%# Eval("PackSize") != null && !string.IsNullOrEmpty(Eval("PackSize").ToString()) ? Eval("PackSize") : "10 Tablets" %></span>
              </div>
            </div>

            <!-- Prescription Warning (if needed) -->
            <div class="alert alert-warning-custom mb-4" style='<%# Eval("RxRequired") != null && Eval("RxRequired") != DBNull.Value && Convert.ToBoolean(Eval("RxRequired")) ? "display:block;" : "display:none;" %>'>
              <i class="bi bi-exclamation-triangle-fill"></i>
              <strong>Prescription Required:</strong> This medicine requires a valid prescription. Please upload your prescription before purchasing.
            </div>

            <!-- PURCHASE SECTION -->
            <div class="purchase-section">
              <!-- Quantity Selector -->
              <div class="qty-section mb-3">
                <label class="d-block mb-2" style="font-weight:600; font-size:.9rem">Quantity</label>
                <div class="qty-control-detail">
                  <button type="button" class="qty-btn-detail" onclick="changeQty(-1); return false;">
                    <i class="bi bi-dash"></i>
                  </button>
                  <asp:TextBox ID="txtQty" runat="server" Text="1" TextMode="Number" CssClass="qty-input-detail" ClientIDMode="Static" style="width:60px;text-align:center;" />
                  <button type="button" class="qty-btn-detail" onclick="changeQty(1); return false;">
                    <i class="bi bi-plus"></i>
                  </button>
                </div>
              </div>

              <!-- Action Buttons -->
              <div class="d-grid gap-2 mb-3">
                <asp:LinkButton ID="LinkButton1" runat="server"
                  CommandName="cmd_cart"
                  CommandArgument='<%# Eval("MedicineID") %>'
                  CssClass="btn btn-primary-custom btn-lg">
                  <i class="bi bi-cart-plus me-2"></i>Add to Cart
                </asp:LinkButton>
                <asp:LinkButton ID="btnBuyNow" runat="server"
                  CommandName="cmd_buynow"
                  CommandArgument='<%# Eval("MedicineID") %>'
                  CssClass="btn btn-outline-primary-custom btn-lg">
                  <i class="bi bi-lightning-charge me-2"></i>Buy Now
                </asp:LinkButton>
              </div>
            </div>

            <!-- Disclaimer -->
            <div class="disclaimer-note mt-4 p-3" style="background:#f8f9fa; border-radius:8px; border-left:4px solid var(--primary)">
              <small style="color:#666; font-size:.8rem">
                <strong>&#9432; Disclaimer:</strong> Medicine information is provided for general informational purposes only. Always follow your doctor's or pharmacist's advice and read the product label carefully. Do not self-medicate.
              </small>
            </div>
          </div>
        </div>

        <!-- DIVIDER -->
        <hr class="my-5">

        <!-- PRODUCT DETAILS -->
        <div class="product-details-panel">
          <h4 class="fw-700 mb-4">Product Details</h4>

          <section class="product-info-section">
            <button class="product-info-heading" type="button" aria-expanded="true" aria-controls="otherInformationContent" onclick="toggleProductInfo(this, 'otherInformationContent')">
              <span>Other Information</span>
              <i class="bi bi-chevron-up" aria-hidden="true"></i>
            </button>

            <div class="product-info-content" id="otherInformationContent">
              <div class="product-info-group">
                <h6><i class="bi bi-file-earmark-text"></i>Description</h6>
                <p><%# Eval("Description") != null && !string.IsNullOrEmpty(Eval("Description").ToString()) ? Eval("Description") : "High-quality pharmaceutical product formulated for effective relief and recovery." %></p>
              </div>

              <div class="product-info-group">
                <h6><i class="bi bi-heart-pulse-fill"></i>Benefits</h6>
                <p><%# Eval("Uses") != null && !string.IsNullOrEmpty(Eval("Uses").ToString()) ? Eval("Uses") : "Used as directed by a healthcare professional." %></p>
              </div>

              <div class="product-info-group">
                <h6><i class="bi bi-leaf-fill"></i>Ingredients</h6>
                <p><span><%# Eval("Composition") != null && !string.IsNullOrEmpty(Eval("Composition").ToString()) ? Eval("Composition") : Eval("Name") %></span> <span><%# Eval("Strength") %></span>.</p>
                <p><%# Eval("InactiveIngredients") != null && !string.IsNullOrEmpty(Eval("InactiveIngredients").ToString()) ? Eval("InactiveIngredients") : "Pharmaceutical grade excipients." %></p>
              </div>

              <div class="product-info-group">
                <h6><i class="bi bi-file-earmark-text"></i>Uses</h6>
                <p><%# Eval("Uses") != null && !string.IsNullOrEmpty(Eval("Uses").ToString()) ? Eval("Uses") : "Refer to packaging for complete therapeutic uses." %></p>
              </div>

              <div class="product-info-group">
                <h6><i class="bi bi-person-exclamation"></i>Side Effects</h6>
                <div class="sideeffects-content">
                  <p><%# Eval("SideEffects") != null && !string.IsNullOrEmpty(Eval("SideEffects").ToString()) ? Eval("SideEffects") : "Generally well tolerated when taken as prescribed. Consult doctor if unusual symptoms occur." %></p>
                </div>
              </div>

              <div class="product-info-group">
                <h6><i class="bi bi-file-earmark-text"></i>How to Use</h6>
                <div class="dosage-content">
                  <p><%# Eval("Dosage") != null && !string.IsNullOrEmpty(Eval("Dosage").ToString()) ? Eval("Dosage") : "Take as prescribed by your physician, with water after meals." %></p>
                </div>
                <div class="storage-content">
                  <p><strong>Storage:</strong> <%# Eval("Storage") != null && !string.IsNullOrEmpty(Eval("Storage").ToString()) ? Eval("Storage") : "Store in a cool, dry place away from direct sunlight." %></p>
                </div>
              </div>
            </div>
          </section>

          <section class="product-info-section">
            <button class="product-info-heading" type="button" aria-expanded="true" aria-controls="manufacturerInformationContent" onclick="toggleProductInfo(this, 'manufacturerInformationContent')">
              <span>Brand and Manufacturer Details</span>
              <i class="bi bi-chevron-up" aria-hidden="true"></i>
            </button>

            <div class="manufacturer-details" id="manufacturerInformationContent">
              <div>
                <strong>Brand</strong>
                <p><%# Eval("BrandName") != null && !string.IsNullOrEmpty(Eval("BrandName").ToString()) ? Eval("BrandName") : "MediCare Healthcare" %></p>
                <strong>Country of Origin</strong>
                <p><%# Eval("CountryOfOrigin") != null && !string.IsNullOrEmpty(Eval("CountryOfOrigin").ToString()) ? Eval("CountryOfOrigin") : "India" %></p>
              </div>
              <div>
                <strong>Manufacturer Details</strong>
                <p><%# Eval("Manufacturer") != null && !string.IsNullOrEmpty(Eval("Manufacturer").ToString()) ? Eval("Manufacturer") : "Certified GMP Pharmaceutical Laboratories" %></p>
              </div>
            </div>
          </section>
        </div>
      </ItemTemplate>
    </asp:DataList>

    <hr class="my-5">

    <!-- RELATED MEDICINES -->
    <div class="row">
      <div class="col-12">
        <h4 class="fw-700 mb-4">Related Medicines</h4>
        <div class="row g-3">
          <asp:Repeater ID="rptRelated" runat="server">
            <ItemTemplate>
              <div class="col-md-4 col-lg-2 col-6">
                <a href='medicine-details.aspx?id=<%# Eval("MedicineID") %>' class="text-decoration-none text-dark">
                  <div class="card h-100 p-2 text-center border shadow-sm" style="border-radius:var(--radius-md);">
                    <img src='<%# Eval("ImageUrl") != null && !string.IsNullOrEmpty(Eval("ImageUrl").ToString()) ? Eval("ImageUrl") : "https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=700&q=85" %>' alt='<%# Eval("Name") %>' class="img-fluid mb-2" style="max-height:80px;object-fit:contain" onerror="this.src='https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?auto=format&fit=crop&w=700&q=85';" />
                    <div class="fw-600 small text-truncate" title='<%# Eval("Name") %>'><%# Eval("Name") %></div>
                    <div class="text-primary fw-700">&#8377;<%# string.Format("{0:N0}", Eval("Price")) %></div>
                  </div>
                </a>
              </div>
            </ItemTemplate>
          </asp:Repeater>
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
function toggleProductInfo(button, contentId) {
  const content = document.getElementById(contentId);
  if (!content) return;
  const isExpanded = button.getAttribute('aria-expanded') === 'true';
  button.setAttribute('aria-expanded', String(!isExpanded));
  if (isExpanded) {
    content.style.display = 'none';
    const icon = button.querySelector('i');
    if (icon) { icon.classList.remove('bi-chevron-up'); icon.classList.add('bi-chevron-down'); }
  } else {
    content.style.display = 'block';
    const icon = button.querySelector('i');
    if (icon) { icon.classList.remove('bi-chevron-down'); icon.classList.add('bi-chevron-up'); }
  }
}

function changeQty(delta) {
  const txt = document.getElementById('txtQty');
  if (!txt) return;
  let val = parseInt(txt.value) || 1;
  val += delta;
  if (val < 1) val = 1;
  txt.value = val;
}

function toggleWishlist(btn) {
  btn.classList.toggle('active');
  const icon = btn.querySelector('i');
  if (btn.classList.contains('active')) {
    if (icon) { icon.classList.remove('bi-heart'); icon.classList.add('bi-heart-fill'); icon.style.color = '#ef4444'; }
    if (typeof showToast === 'function') showToast('Added to wishlist!', 'info');
  } else {
    if (icon) { icon.classList.remove('bi-heart-fill'); icon.classList.add('bi-heart'); icon.style.color = ''; }
    if (typeof showToast === 'function') showToast('Removed from wishlist', 'warning');
  }
}

document.addEventListener('DOMContentLoaded', () => {
  if (typeof Cart !== 'undefined' && Cart.count) {
    const el = document.getElementById('navCartCount');
    if (el) el.textContent = Cart.count();
  }
  if (typeof initCustomerNav === 'function') initCustomerNav();
});
</script>
</body>
</asp:Content>
