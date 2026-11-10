<%@ Page Title="Shopping Cart — MediCare Pharmacy" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="cart.aspx.cs" Inherits="medicare.customer.cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
<asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg customer-navbar">
  <div class="container">
    <a class="navbar-brand navbar-brand-custom" href="../index.aspx">
      <div class="brand-icon"><i class="bi bi-capsule-pill"></i></div>
      <span>Medi<b>Care</b></span>
    </a>
    <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navCart">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navCart">
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

<div class="py-2 px-4 bg-white border-bottom">
  <ol class="breadcrumb-custom"><li><a href="../index.aspx">Home</a></li><li><i class="bi bi-chevron-right small"></i></li><li>Shopping Cart</li></ol>
</div>

<div class="container py-4">
  <!-- Checkout Steps -->
  <div class="checkout-steps mb-4">
    <div class="step-item active"><div class="step-circle"><i class="bi bi-cart-check"></i></div><span class="step-label">Cart</span></div>
    <div class="step-item"><div class="step-circle">2</div><span class="step-label">Address</span></div>
    <div class="step-item"><div class="step-circle">3</div><span class="step-label">Payment</span></div>
    <div class="step-item"><div class="step-circle">4</div><span class="step-label">Confirm</span></div>
  </div>

  <div class="row g-4">
    <div class="col-lg-8">
      <div class="d-flex align-items-center justify-content-between mb-3">
        <h5 class="fw-700 mb-0">Cart Items <span class="text-muted fw-400" id="cartItemCount" style="font-size:.85rem"></span></h5>
        <button type="button" class="btn btn-sm text-danger border-0 p-0" onclick="clearCart()"><i class="bi bi-trash me-1"></i>Clear Cart</button>
      </div>
      <div id="cartItems"></div>
      <!-- Coupon -->
      <div class="card-custom p-3 mt-3">
        <div class="fw-600 mb-2"><i class="bi bi-tag me-2 text-primary"></i>Apply Coupon</div>
        <div class="d-flex gap-2">
          <asp:TextBox ID="couponInput" runat="server" CssClass="form-control form-control-custom" placeholder="Enter coupon code (e.g. HEALTH25)" ClientIDMode="Static" />
          <asp:LinkButton ID="btnApplyCoupon" runat="server" CssClass="btn btn-primary-custom px-3 fw-600" OnClientClick="applyCoupon(); return false;" ClientIDMode="Static">Apply</asp:LinkButton>
        </div>
        <div id="couponMsg" class="mt-2"></div>
      </div>
    </div>

    <div class="col-lg-4">
      <div class="order-summary">
        <h6 class="fw-700 mb-3">Order Summary</h6>
        <div class="summary-row"><span class="text-muted">Subtotal</span><span id="summSubtotal" class="fw-600">₹0</span></div>
        <div class="summary-row"><span class="text-muted">Delivery</span><span class="text-success fw-600">FREE</span></div>
        <div class="summary-row" id="discRow" style="display:none"><span class="text-muted">Discount (25%)</span><span id="discAmt" class="text-danger fw-600">₹0</span></div>
        <div class="summary-row"><span class="text-muted">GST (18%)</span><span id="summGst" class="fw-600">₹0</span></div>
        <div class="summary-total"><span>Total Payable</span><span id="summTotal" class="text-primary">₹0</span></div>
        <a href="checkout.aspx" class="btn btn-primary-custom w-100 mt-3 py-2 fw-600"><i class="bi bi-shield-check me-2"></i>Proceed to Checkout</a>
        <div class="mt-3 text-center">
          <small class="text-muted"><i class="bi bi-lock-fill me-1 text-success"></i>Secure & Encrypted Checkout</small>
        </div>
        <div class="d-flex justify-content-center gap-2 mt-2 flex-wrap">
          <img src="https://img.shields.io/badge/Visa-1A1F71?style=flat&logo=visa&logoColor=white" style="height:22px" alt="Visa">
          <img src="https://img.shields.io/badge/Mastercard-EB001B?style=flat&logo=mastercard&logoColor=white" style="height:22px" alt="MC">
          <img src="https://img.shields.io/badge/UPI-success?style=flat" style="height:22px" alt="UPI">
          <img src="https://img.shields.io/badge/COD-333?style=flat" style="height:22px" alt="COD">
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
let discount = 0;

function renderCart() {
  const items = Cart.get();
  const c = document.getElementById('cartItems');
  document.getElementById('cartItemCount').textContent = `(${items.length} items)`;
  if (!items.length) {
    c.innerHTML = `
      <div class="card-custom p-5 text-center">
        <div style="font-size:3rem;margin-bottom:1rem">🛒</div>
        <h5 class="fw-700">Your cart is empty</h5>
        <p class="text-muted mb-3" style="font-size:.88rem">Explore thousands of genuine medicines and wellness products.</p>
        <a href="medicines.aspx" class="btn btn-primary-custom">Start Shopping</a>
      </div>`;
    updateSummary(0);
    return;
  }
  c.innerHTML = items.map(item => `
    <div class="cart-item-card">
      <div class="cart-item-img">${typeof renderMedicineImage === 'function' ? renderMedicineImage(item.img, item.name, 'cart-img') : `<span style="font-size:2rem">${item.img||'💊'}</span>`}</div>
      <div class="cart-item-details">
        <div class="cart-item-brand">${item.brand || 'MediCare'}</div>
        <div class="cart-item-name">${item.name}</div>
        <div class="cart-item-price">₹${item.price} <small class="text-muted fw-400">each</small></div>
      </div>
      <div class="cart-qty-ctrl">
        <button type="button" class="cart-qty-btn" onclick="changeQty(${item.id}, -1)">-</button>
        <span class="cart-qty-num">${item.qty}</span>
        <button type="button" class="cart-qty-btn" onclick="changeQty(${item.id}, 1)">+</button>
      </div>
      <div class="fw-700 text-end" style="min-width:70px">₹${item.price * item.qty}</div>
      <button type="button" class="btn btn-sm text-danger border-0 p-1" onclick="removeItem(${item.id})"><i class="bi bi-trash"></i></button>
    </div>`).join('');
  const sub = Cart.subtotal();
  updateSummary(sub);
}

function changeQty(id, delta) {
  const items = Cart.get();
  const item = items.find(x => x.id === id);
  if (item) {
    item.qty += delta;
    if (item.qty <= 0) Cart.remove(id);
    else Cart.save(items);
    renderCart();
  }
}

function removeItem(id) {
  Cart.remove(id);
  renderCart();
  showToast('Item removed from cart', 'info');
}

function clearCart() {
  Cart.clear();
  renderCart();
  showToast('Cart cleared', 'info');
}

function updateSummary(sub) {
  const discAmt = discount ? Math.round(sub * discount) : 0;
  const gst = Math.round((sub - discAmt) * 0.18);
  const total = sub - discAmt + gst;
  document.getElementById('summSubtotal').textContent = '₹' + sub;
  document.getElementById('summGst').textContent = '₹' + gst;
  document.getElementById('summTotal').textContent = '₹' + Math.max(0, total);
  if (discount) {
    document.getElementById('discRow').style.display = 'flex';
    document.getElementById('discAmt').textContent = '-₹' + discAmt;
  } else {
    document.getElementById('discRow').style.display = 'none';
  }
}

function applyCoupon() {
  const code = document.getElementById('couponInput').value.trim().toUpperCase();
  const msg = document.getElementById('couponMsg');
  if (code === 'HEALTH25') {
    discount = 0.25;
    msg.innerHTML = '<span class="text-success small fw-600"><i class="bi bi-check-circle-fill me-1"></i>Coupon HEALTH25 applied! 25% discount</span>';
    showToast('Coupon applied: 25% OFF', 'success');
  } else {
    msg.innerHTML = '<span class="text-danger small"><i class="bi bi-x-circle-fill me-1"></i>Invalid coupon code</span>';
  }
  updateSummary(Cart.subtotal());
}

document.addEventListener('DOMContentLoaded', () => {
  renderCart();
});
</script>
</body>
</asp:Content>
