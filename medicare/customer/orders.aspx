<%@ Page Title="My Orders — MediCare Pharmacy" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="orders.aspx.cs" Inherits="medicare.customer.orders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <link rel="stylesheet" href="../assets/css/customer.css">
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
    <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navO">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navO">
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

<div class="container py-4">
  <div class="row justify-content-center">
    <div class="col-12 col-xl-10">
      <div class="d-flex align-items-center justify-content-between mb-3 flex-wrap gap-2">
        <div>
          <h5 class="fw-700 mb-0">My Orders</h5>
          <small class="text-muted" id="orderCountLabel">All orders</small>
        </div>
        <div class="search-bar" style="max-width:200px">
          <i class="bi bi-search"></i>
          <input type="text" class="form-control" placeholder="Search orders..." oninput="filterOrders(this.value)">
        </div>
      </div>
      <!-- Status Filter Tabs -->
      <div class="order-filter-tabs mb-4">
        <button type="button" class="order-filter-tab active" onclick="setStatusFilter('all',this)">All <span class="ms-1 text-muted small" id="countAll"></span></button>
        <button type="button" class="order-filter-tab" onclick="setStatusFilter('Pending',this)"><i class="bi bi-clock me-1"></i>Pending <span class="ms-1 text-muted small" id="countPending"></span></button>
        <button type="button" class="order-filter-tab" onclick="setStatusFilter('Processing',this)"><i class="bi bi-arrow-repeat me-1"></i>Processing</button>
        <button type="button" class="order-filter-tab" onclick="setStatusFilter('Delivered',this)"><i class="bi bi-check-circle-fill me-1"></i>Delivered</button>
        <button type="button" class="order-filter-tab" onclick="setStatusFilter('Cancelled',this)"><i class="bi bi-x-circle me-1"></i>Cancelled</button>
      </div>
      <!-- Orders list -->
      <div id="ordersList"></div>
    </div>
  </div>
</div>

<!-- Order Detail Modal -->
<div class="modal fade modal-custom" id="orderDetailModal" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header"><h5 class="modal-title fw-700" id="orderDetailTitle">Order Details</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
      <div class="modal-body" id="orderDetailBody"></div>
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-primary-custom fw-600" onclick="window.print()"><i class="bi bi-printer me-1"></i>Print Invoice</button>
        <button type="button" class="btn btn-primary-custom fw-600"><i class="bi bi-download me-1"></i>Download PDF</button>
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
const statusColors = { Pending: 'warning', Processing: 'info', Delivered: 'success', Cancelled: 'danger' };
const statusIcons = { Pending: 'bi-clock', Processing: 'bi-arrow-repeat', Delivered: 'bi-check-circle-fill', Cancelled: 'bi-x-circle' };
const orders = <%= ordersJson %>;

let currentStatusFilter = 'all';

function setStatusFilter(status, btn) {
  currentStatusFilter = status;
  document.querySelectorAll('.order-filter-tab').forEach(b => b.classList.remove('active'));
  if (btn) btn.classList.add('active');
  renderOrders();
}

function filterOrders(query) {
  const q = query.toLowerCase();
  const filtered = orders.filter(o => o.id.toLowerCase().includes(q) ||
    o.items.some(i => i.name.toLowerCase().includes(q)));
  renderOrdersList(filtered);
}

function renderOrders() {
  const filtered = currentStatusFilter === 'all' ? orders : orders.filter(o => o.status === currentStatusFilter);
  document.getElementById('orderCountLabel').textContent = filtered.length + ' orders';
  renderOrdersList(filtered);
}

function renderOrdersList(list) {
  if (!list.length) {
    document.getElementById('ordersList').innerHTML = '<div class="empty-state"><i class="bi bi-bag-x"></i><h5>No orders found</h5><p>Try changing your filter</p><a href="medicines.aspx" class="btn btn-primary-custom mt-2">Shop Now</a></div>';
    return;
  }
  document.getElementById('ordersList').innerHTML = list.map(o => `
    <div class="order-card">
      <div class="order-card-header">
        <div>
          <span class="fw-700" style="font-size:.92rem">${o.id}</span>
          <span class="text-muted small ms-2"><i class="bi bi-calendar3 me-1"></i>${o.date}</span>
        </div>
        <div class="d-flex align-items-center gap-2">
          <span class="badge-custom badge-${statusColors[o.status] || 'info'}"><i class="bi ${statusIcons[o.status] || 'bi-info-circle'} me-1"></i>${o.status}</span>
          <strong class="text-primary" style="font-size:.9rem">₹${o.total.toFixed(2)}</strong>
        </div>
      </div>
      <div class="order-card-body">
        <div class="d-flex flex-wrap gap-2 mb-3">
          ${o.items.map(i => `<span class="info-chip"><i class="bi bi-capsule text-primary"></i>${i.name} ×${i.qty}</span>`).join('')}
        </div>
        <div class="d-flex gap-2 flex-wrap">
          <button type="button" class="btn btn-sm btn-primary-custom fw-600" onclick="viewOrder('${o.id}')"><i class="bi bi-eye me-1"></i>View Details</button>
          ${o.status === 'Delivered' ? '<button type="button" class="btn btn-sm btn-outline-primary-custom fw-600" onclick="reorder()"><i class="bi bi-arrow-repeat me-1"></i>Reorder</button>' : ''}
          ${o.status === 'Pending' || o.status === 'Processing' ? '<button type="button" class="btn btn-sm btn-danger-custom fw-600" onclick="cancelOrder()"><i class="bi bi-x-circle me-1"></i>Cancel</button>' : ''}
          <button type="button" class="btn btn-sm border fw-600" onclick="window.print()"><i class="bi bi-printer me-1"></i>Invoice</button>
        </div>
      </div>
    </div>`).join('');
}

function viewOrder(id) {
  const o = orders.find(x => x.id === id);
  if (!o) return;
  document.getElementById('orderDetailTitle').textContent = `Order ${o.id}`;
  const steps = [
    { label:'Order Placed', done: true },
    { label:'Confirmed', done: o.status !== 'Pending' && o.status !== 'Cancelled' },
    { label:'Preparing', done: o.status === 'Delivered' || o.status === 'Processing' },
    { label:'Dispatched', done: o.status === 'Delivered' },
    { label:'Delivered', done: o.status === 'Delivered' },
  ];
  const stepsHtml = steps.map(s => `<div class="timeline-item ${s.done ? 'done' : 'pending'}"><div class="fw-600" style="font-size:.88rem">${s.label}</div></div>`).join('');
  document.getElementById('orderDetailBody').innerHTML = `
    <div class="row g-3">
      <div class="col-md-7">
        <h6 class="fw-700 mb-3"><i class="bi bi-bag me-2 text-primary"></i>Items Ordered</h6>
        ${o.items.map(i => `
          <div class="d-flex align-items-center gap-3 mb-2 p-2 rounded" style="background:var(--gray-100)">
            <div style="width:40px;height:40px;border-radius:8px;overflow:hidden;flex-shrink:0;">${(() => { const med = (typeof DummyData !== 'undefined' && DummyData.medicines) ? DummyData.medicines.find(m => m.name === i.name) : null; return med ? renderMedicineImage(med.img, med.name, '', 'width:40px;height:40px;object-fit:contain;border-radius:8px;background:linear-gradient(135deg,#EFF6FF,#DBEAFE);') : '<i class="bi bi-capsule text-primary" style="font-size:1.4rem;margin:auto;display:flex;align-items:center;justify-content:center;height:100%;"></i>'; })()}</div>
            <div class="flex-1"><div class="fw-600" style="font-size:.88rem">${i.name}</div><small class="text-muted">Qty: ${i.qty}</small></div>
            <div class="fw-700 text-primary">₹${i.price * i.qty}</div>
          </div>`).join('')}
        <div class="summary-total mt-3 pt-2" style="border-top:2px dashed var(--gray-200);display:flex;justify-content:space-between;font-size:1rem;font-weight:700">
          <span>Total</span><span class="text-primary">₹${o.total.toFixed(2)}</span>
        </div>
      </div>
      <div class="col-md-5">
        <h6 class="fw-700 mb-3"><i class="bi bi-clock-history me-2 text-primary"></i>Order Timeline</h6>
        <div class="timeline">${stepsHtml}</div>
        <hr>
        <h6 class="fw-700 mb-2">Delivery Address</h6>
        <p style="font-size:.85rem;color:var(--dark-3)">Priya Sharma<br>123 Park Street, Bandra West<br>Mumbai - 400050, MH<br><i class="bi bi-telephone me-1"></i>+91 98765 43210</p>
      </div>
    </div>`;
  new bootstrap.Modal(document.getElementById('orderDetailModal')).show();
}
function reorder() { if (typeof DummyData !== 'undefined' && DummyData.medicines) { DummyData.medicines.slice(0,2).forEach(m => Cart.add({ id:m.id, name:m.name, price:m.price, img:m.img })); showToast('Items added to cart!', 'success'); } }
function cancelOrder() { showConfirm({ title:'Cancel Order?', message:'This action cannot be undone.', onConfirm:() => showToast('Order cancelled', 'error') }); }

document.addEventListener('DOMContentLoaded', () => {
  const cAll = document.getElementById('countAll');
  const cPen = document.getElementById('countPending');
  if (cAll) cAll.textContent = `(${orders.length})`;
  if (cPen) cPen.textContent = `(${orders.filter(o => o.status === 'Pending').length})`;
  renderOrders();
});
</script>
</body>
</asp:Content>
