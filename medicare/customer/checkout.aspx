<%@ Page Title="Checkout — MediCare Pharmacy" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="checkout.aspx.cs" Inherits="medicare.customer.checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
    <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navCo">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navCo">
      <ul class="navbar-nav mx-auto gap-1" id="navLinks"></ul>
      <div class="d-flex align-items-center gap-3">
        <div class="search-bar d-none d-lg-block" style="max-width:220px">
          <i class="bi bi-search"></i>
          <input type="text" class="form-control nav-search-input" placeholder="Search medicines...">
        </div>
        <small class="text-muted d-none d-xl-block"><i class="bi bi-lock-fill text-success me-1"></i>Secure</small>
        <a href="cart.aspx" class="cart-btn" title="Cart"><i class="bi bi-cart3"></i><span class="cart-count" id="navCartCount">0</span></a>
        <div id="navAccountArea"></div>
      </div>
    </div>
  </div>
</nav>

<div class="container py-4">
  <!-- Steps -->
  <div class="checkout-steps mb-4">
    <div class="step-item done"><div class="step-circle"><i class="bi bi-check-lg"></i></div><span class="step-label">Cart</span></div>
    <div class="step-item active"><div class="step-circle">2</div><span class="step-label">Address</span></div>
    <div class="step-item"><div class="step-circle">3</div><span class="step-label">Payment</span></div>
    <div class="step-item"><div class="step-circle">4</div><span class="step-label">Confirm</span></div>
  </div>

  <div class="row g-4">
    <!-- LEFT -->
    <div class="col-lg-7">
      <!-- Delivery Address -->
      <div class="card-custom p-4 mb-3">
        <h6 class="fw-700 mb-3"><i class="bi bi-geo-alt-fill text-primary me-2"></i>Delivery Address</h6>
        <div class="row g-2 mb-3">
          <div class="col-12">
            <label class="card-custom p-3 d-flex gap-3 align-items-start cursor-pointer" style="border:2px solid var(--primary)">
              <input type="radio" name="addr" class="mt-1" checked>
              <div>
                <div class="fw-600" style="font-size:.9rem">Home <span class="badge-custom badge-success ms-1">Default</span></div>
                <div style="font-size:.85rem;color:var(--dark-3)">Priya Sharma, 123 Park Street, Bandra West, Mumbai - 400050, Maharashtra</div>
                <div class="text-muted" style="font-size:.8rem"><i class="bi bi-telephone me-1"></i>+91 98765 43210</div>
              </div>
            </label>
          </div>
          <div class="col-12">
            <label class="card-custom p-3 d-flex gap-3 align-items-start cursor-pointer" style="border:1.5px solid var(--gray-300)">
              <input type="radio" name="addr" class="mt-1">
              <div>
                <div class="fw-600" style="font-size:.9rem">Office</div>
                <div style="font-size:.85rem;color:var(--dark-3)">Tower B, 5th Floor, BKC Complex, Bandra Kurla Complex, Mumbai - 400051</div>
                <div class="text-muted" style="font-size:.8rem"><i class="bi bi-telephone me-1"></i>+91 98765 43210</div>
              </div>
            </label>
          </div>
        </div>
        <button type="button" class="btn btn-outline-primary-custom btn-sm fw-600" data-bs-toggle="collapse" data-bs-target="#newAddr">
          <i class="bi bi-plus-circle me-1"></i>Add New Address
        </button>
        <div class="collapse mt-3" id="newAddr">
          <div class="row g-2">
            <div class="col-6"><asp:TextBox ID="txtShipName" runat="server" CssClass="form-control form-control-custom" placeholder="Full Name" ClientIDMode="Static" /></div>
            <div class="col-6"><asp:TextBox ID="txtShipPhone" runat="server" TextMode="Phone" CssClass="form-control form-control-custom" placeholder="Phone Number" ClientIDMode="Static" /></div>
            <div class="col-12"><asp:TextBox ID="txtShipAddr1" runat="server" CssClass="form-control form-control-custom" placeholder="Address Line 1" ClientIDMode="Static" /></div>
            <div class="col-12"><asp:TextBox ID="txtShipAddr2" runat="server" CssClass="form-control form-control-custom" placeholder="Address Line 2 (Optional)" ClientIDMode="Static" /></div>
            <div class="col-4"><asp:TextBox ID="txtShipCity" runat="server" CssClass="form-control form-control-custom" placeholder="City" ClientIDMode="Static" /></div>
            <div class="col-4"><asp:TextBox ID="txtShipState" runat="server" CssClass="form-control form-control-custom" placeholder="State" ClientIDMode="Static" /></div>
            <div class="col-4"><asp:TextBox ID="txtShipPin" runat="server" CssClass="form-control form-control-custom" placeholder="PIN Code" ClientIDMode="Static" /></div>
            <div class="col-12">
              <asp:DropDownList ID="ddlShipAddrType" runat="server" CssClass="form-control form-control-custom" ClientIDMode="Static">
                <asp:ListItem>Address Type: Home</asp:ListItem>
                <asp:ListItem>Office</asp:ListItem>
                <asp:ListItem>Other</asp:ListItem>
              </asp:DropDownList>
            </div>
            <div class="col-12"><asp:Button ID="btnSaveShipAddress" runat="server" Text="Save Address" CssClass="btn btn-primary-custom btn-sm fw-600" OnClick="btnSaveShipAddress_Click" ClientIDMode="Static" /></div>
          </div>
        </div>
      </div>

      <!-- Payment Method -->
      <div class="card-custom p-4 mb-3">
        <h6 class="fw-700 mb-3"><i class="bi bi-credit-card-fill text-primary me-2"></i>Payment Method</h6>
        <asp:RadioButtonList ID="rblPaymentMethod" runat="server" CssClass="d-flex flex-column gap-2 rbl-payment" ClientIDMode="Static">
          <asp:ListItem Value="UPI" Selected="True"> UPI Payment (Google Pay, PhonePe, Paytm)</asp:ListItem>
          <asp:ListItem Value="Card"> Credit / Debit Card (Visa, Mastercard, RuPay)</asp:ListItem>
          <asp:ListItem Value="NetBanking"> Net Banking (All major banks supported)</asp:ListItem>
          <asp:ListItem Value="COD"> Cash on Delivery (Available for orders under ₹5,000)</asp:ListItem>
        </asp:RadioButtonList>
      </div>

      <!-- Prescription Upload -->
      <div class="card-custom p-4">
        <h6 class="fw-700 mb-2"><i class="bi bi-file-medical-fill text-primary me-2"></i>Prescription <small class="text-muted fw-400">(if required)</small></h6>
        <p class="text-muted mb-3" style="font-size:.85rem">Some items in your cart require a valid prescription. Please upload it here.</p>
        <div class="dropzone" id="dropzone" onclick="document.getElementById('rxFile').click()">
          <i class="bi bi-cloud-upload"></i>
          <p class="mb-1 fw-600">Drag & drop your prescription here</p>
          <p class="text-muted" style="font-size:.82rem">Supports JPG, PNG, PDF up to 5MB</p>
          <asp:FileUpload ID="rxFile" runat="server" ClientIDMode="Static" style="display:none" />
        </div>
        <div id="rxPreview"></div>
      </div>
    </div>

    <!-- RIGHT: Order Summary -->
    <div class="col-lg-5">
      <div class="order-summary">
        <h6 class="fw-700 mb-3">Order Summary</h6>
        <div id="checkoutItems" class="mb-3"></div>
        <hr>
        <div class="summary-row"><span class="text-muted">Subtotal</span><span class="fw-600" id="coSubtotal">₹260.00</span></div>
        <div class="summary-row"><span class="text-muted">Delivery</span><span class="text-success fw-600">FREE</span></div>
        <div class="summary-row"><span class="text-muted">GST (18%)</span><span class="fw-600" id="coGst">₹46.80</span></div>
        <div class="summary-total"><span>Total Payable</span><span class="text-primary" id="coTotal">₹306.80</span></div>
        <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" CssClass="btn btn-primary-custom w-100 mt-3 py-2 fw-600" OnClick="btnPlaceOrder_Click" ClientIDMode="Static" />
        <div class="mt-2 text-center"><small class="text-muted" style="font-size:.75rem"><i class="bi bi-shield-check text-success me-1"></i>By placing this order you agree to our <a href="#" class="text-primary">Terms & Conditions</a></small></div>
      </div>
    </div>
  </div>
</div>

<!-- Order Placed Modal -->
<div class="modal fade modal-custom" id="orderModal" tabindex="-1" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-body text-center p-5">
        <div style="font-size:4rem;margin-bottom:1rem;animation:fadeInUp .5s ease">🎉</div>
        <h4 class="fw-800 text-success">Order Placed!</h4>
        <p class="text-muted">Your order <strong><asp:Label ID="lblOrderCodeConfirm" runat="server" Text="#ORD-20260904" /></strong> has been placed successfully. You'll receive a confirmation shortly.</p>
        <div class="d-flex gap-2 justify-content-center mt-3">
          <a href="orders.aspx" class="btn btn-primary-custom fw-600">Track Order</a>
          <a href="../index.aspx" class="btn btn-outline-primary-custom fw-600">Continue Shopping</a>
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
document.addEventListener('DOMContentLoaded', () => {
  const items = Cart.get();
  const sub = Cart.subtotal();
  const gst = Math.round(sub * 0.18);
  const total = sub + gst;

  document.getElementById('coSubtotal').textContent = '₹' + sub.toFixed(2);
  document.getElementById('coGst').textContent = '₹' + gst.toFixed(2);
  document.getElementById('coTotal').textContent = '₹' + total.toFixed(2);

  document.getElementById('checkoutItems').innerHTML = items.length ? items.map(i => `
    <div class="d-flex align-items-center gap-2 mb-2">
      <div style="width:36px;height:36px;border-radius:8px;overflow:hidden;flex-shrink:0;">${typeof renderMedicineImage === 'function' ? renderMedicineImage(i.img, i.name, '', 'width:36px;height:36px;object-fit:contain;border-radius:8px;') : `<span style="font-size:1.5rem">${i.img||'💊'}</span>`}</div>
      <div class="flex-1" style="font-size:.85rem;font-weight:500">${i.name} × ${i.qty}</div>
      <div class="fw-600" style="font-size:.85rem">₹${i.price * i.qty}</div>
    </div>`).join('') : '<p class="text-muted small">No items in cart</p>';

  if (typeof initDropzone === 'function') {
    initDropzone('dropzone', 'rxFile', 'rxPreview');
  }
});

function placeOrder() {
  showLoader();
  setTimeout(() => {
    hideLoader();
    new bootstrap.Modal(document.getElementById('orderModal')).show();
    Cart.save([]);
  }, 1200);
}
</script>
</body>
</asp:Content>
