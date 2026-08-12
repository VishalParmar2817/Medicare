/* ============================================================
   PHARMACY MANAGEMENT SYSTEM — MAIN JS
   Global utilities, dummy data, toast, modals, animations
   ============================================================ */

/* ── Toast Notification System ─────────────────────────────── */
function showToast(message, type = 'success', duration = 3500) {
  const container = document.getElementById('toast-container') || createToastContainer();
  const icons = { success: 'bi-check-circle-fill', error: 'bi-x-circle-fill', warning: 'bi-exclamation-triangle-fill', info: 'bi-info-circle-fill' };
  const toast = document.createElement('div');
  toast.className = `toast-custom toast-${type}`;
  toast.innerHTML = `
    <i class="bi ${icons[type]} toast-icon"></i>
    <span>${message}</span>
    <button class="toast-close" onclick="dismissToast(this.parentElement)"><i class="bi bi-x"></i></button>
  `;
  container.appendChild(toast);
  setTimeout(() => dismissToast(toast), duration);
}

function dismissToast(toast) {
  if (!toast) return;
  toast.classList.add('toast-exit');
  setTimeout(() => toast.remove(), 300);
}

function createToastContainer() {
  const c = document.createElement('div');
  c.id = 'toast-container';
  document.body.appendChild(c);
  return c;
}

/* ── Confirmation Dialog ────────────────────────────────────── */
function showConfirm(opts = {}) {
  const {
    title = 'Are you sure?',
    message = 'This action cannot be undone.',
    icon = 'bi-exclamation-triangle-fill',
    iconColor = '#ef4444',
    confirmText = 'Confirm',
    cancelText = 'Cancel',
    onConfirm = () => {},
  } = opts;

  let modal = document.getElementById('confirmModal');
  if (!modal) {
    modal = document.createElement('div');
    modal.id = 'confirmModal';
    modal.className = 'modal fade modal-custom';
    modal.tabIndex = -1;
    modal.innerHTML = `
      <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content">
          <div class="modal-body text-center" style="padding:2rem">
            <i id="confirmIcon" class="bi confirm-icon" style="display:block;font-size:3.5rem;margin-bottom:1rem"></i>
            <h5 id="confirmTitle" class="fw-700 mb-2"></h5>
            <p id="confirmMsg" class="text-muted mb-3" style="font-size:.9rem"></p>
            <div class="d-flex gap-2 justify-content-center">
              <button class="btn btn-secondary-custom" data-bs-dismiss="modal" id="confirmCancel"></button>
              <button class="btn btn-danger-custom" id="confirmOk"></button>
            </div>
          </div>
        </div>
      </div>`;
    document.body.appendChild(modal);
  }
  document.getElementById('confirmIcon').className = `bi ${icon}`;
  document.getElementById('confirmIcon').style.color = iconColor;
  document.getElementById('confirmTitle').textContent = title;
  document.getElementById('confirmMsg').textContent = message;
  document.getElementById('confirmCancel').textContent = cancelText;
  document.getElementById('confirmOk').textContent = confirmText;

  const bsModal = new bootstrap.Modal(modal);
  bsModal.show();
  const okBtn = document.getElementById('confirmOk');
  const newOk = okBtn.cloneNode(true);
  okBtn.parentNode.replaceChild(newOk, okBtn);
  newOk.addEventListener('click', () => { onConfirm(); bsModal.hide(); });
}

/* ── Loading Spinner ────────────────────────────────────────── */
function showLoader() {
  if (document.getElementById('global-loader')) return;
  const overlay = document.createElement('div');
  overlay.className = 'spinner-overlay';
  overlay.id = 'global-loader';
  overlay.innerHTML = `<div class="spinner-ring"></div>`;
  document.body.appendChild(overlay);
}
function hideLoader() {
  const el = document.getElementById('global-loader');
  if (el) el.remove();
}

/* ── Animate on Scroll ──────────────────────────────────────── */
function initScrollAnimations() {
  const els = document.querySelectorAll('.anim-fade-up');
  if (!els.length) return;
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(e => { if (e.isIntersecting) { e.target.classList.add('visible'); observer.unobserve(e.target); } });
  }, { threshold: 0.12 });
  els.forEach(el => observer.observe(el));
}

/* ── Sidebar Toggle (Pharmacist / Admin) ───────────────────── */
function initSidebar(sidebarId, overlayId) {
  const sidebar  = document.getElementById(sidebarId);
  const overlay  = document.getElementById(overlayId);
  const toggle   = document.querySelectorAll('.sidebar-toggle');
  if (!sidebar || !overlay) return;

  toggle.forEach(btn => btn.addEventListener('click', () => {
    sidebar.classList.toggle('open');
    overlay.classList.toggle('visible');
  }));
  overlay.addEventListener('click', () => {
    sidebar.classList.remove('open');
    overlay.classList.remove('visible');
  });
}

/* ── Search + Filter Table ──────────────────────────────────── */
function filterTable(inputId, tableId, cols = null) {
  const input = document.getElementById(inputId);
  if (!input) return;
  input.addEventListener('input', function () {
    const q = this.value.toLowerCase();
    const rows = document.querySelectorAll(`#${tableId} tbody tr`);
    rows.forEach(row => {
      const text = (cols ? [...cols].map(c => row.cells[c]?.textContent || '').join(' ') : row.textContent).toLowerCase();
      row.style.display = text.includes(q) ? '' : 'none';
    });
  });
}

/* ── Simple Pagination ──────────────────────────────────────── */
function initPagination(tableId, rowsPerPage = 10) {
  const table = document.querySelector(`#${tableId} tbody`);
  if (!table) return;
  const rows = [...table.querySelectorAll('tr')];
  if (rows.length <= rowsPerPage) return;
  const pages = Math.ceil(rows.length / rowsPerPage);
  const container = document.getElementById(`${tableId}-pagination`);
  if (!container) return;

  let current = 1;
  function render() {
    rows.forEach((r, i) => r.style.display = (i >= (current-1)*rowsPerPage && i < current*rowsPerPage) ? '' : 'none');
    container.innerHTML = '';
    for (let p = 1; p <= pages; p++) {
      const li = document.createElement('li');
      li.className = `page-item ${p === current ? 'active' : ''}`;
      li.innerHTML = `<a class="page-link" href="#">${p}</a>`;
      li.addEventListener('click', e => { e.preventDefault(); current = p; render(); });
      container.appendChild(li);
    }
  }
  render();
}

/* ── Drag & Drop Upload ─────────────────────────────────────── */
function initDropzone(dropId, inputId, previewId) {
  const zone  = document.getElementById(dropId);
  const input = document.getElementById(inputId);
  const prev  = document.getElementById(previewId);
  if (!zone || !input) return;

  zone.addEventListener('click', () => input.click());
  zone.addEventListener('dragover', e => { e.preventDefault(); zone.classList.add('drag-over'); });
  zone.addEventListener('dragleave', () => zone.classList.remove('drag-over'));
  zone.addEventListener('drop', e => { e.preventDefault(); zone.classList.remove('drag-over'); handleFiles(e.dataTransfer.files); });
  input.addEventListener('change', e => handleFiles(e.target.files));

  function handleFiles(files) {
    if (!files.length) return;
    const file = files[0];
    if (prev) {
      if (file.type.startsWith('image/')) {
        const reader = new FileReader();
        reader.onload = ev => {
          prev.innerHTML = `<div class="prescription-preview"><img src="${ev.target.result}" class="prescription-thumb" alt="Preview"><div><strong>${file.name}</strong><br><small class="text-muted">${(file.size/1024).toFixed(1)} KB</small></div></div>`;
        };
        reader.readAsDataURL(file);
      } else {
        prev.innerHTML = `<div class="prescription-preview"><i class="bi bi-file-earmark-pdf-fill text-danger" style="font-size:2rem"></i><div><strong>${file.name}</strong><br><small class="text-muted">${(file.size/1024).toFixed(1)} KB</small></div></div>`;
      }
    }
    zone.querySelector('p') && (zone.querySelector('p').textContent = file.name);
  }
}

/* ── Auth Guard ─────────────────────────────────────────── */
const Auth = {
  isLoggedIn() {
    return !!localStorage.getItem('mcUser');
  },
  // Redirect to login, saving where to return + optional pending cart item
  requireLogin(returnUrl, pendingItem = null) {
    sessionStorage.setItem('mc_return_url', returnUrl || window.location.href);
    if (pendingItem) sessionStorage.setItem('mc_pending_cart', JSON.stringify(pendingItem));
    // Build login URL relative to current page depth
    const inCustomer = window.location.pathname.includes('/customer/');
    const loginUrl = inCustomer ? 'login.html' : 'customer/login.html';
    window.location.href = loginUrl;
  },
  // Called after login — replay pending cart item and redirect back
  afterLogin() {
    const returnUrl = sessionStorage.getItem('mc_return_url');
    const pending   = sessionStorage.getItem('mc_pending_cart');
    sessionStorage.removeItem('mc_return_url');
    sessionStorage.removeItem('mc_pending_cart');
    if (pending) {
      try { Cart.add(JSON.parse(pending)); } catch(e) {}
    }
    window.location.href = returnUrl || '../index.html';
  }
};

/* ── Cart Management ──────────────────────────────────────── */
const Cart = {
  key: 'pharma_cart',
  get() { try { return JSON.parse(localStorage.getItem(this.key)) || []; } catch { return []; } },
  save(items) { localStorage.setItem(this.key, JSON.stringify(items)); this.updateBadge(); },
  add(item) {
    // Guard: require login before adding to cart
    if (!Auth.isLoggedIn()) {
      Auth.requireLogin(window.location.href, item);
      return;
    }
    const items = this.get();
    const ex = items.find(i => i.id === item.id);
    if (ex) ex.qty = (ex.qty || 1) + 1;
    else items.push({ ...item, qty: 1 });
    this.save(items);
    showToast(`${item.name} added to cart!`, 'success');
  },
  remove(id) { this.save(this.get().filter(i => i.id !== id)); },
  updateQty(id, qty) { const items = this.get(); const it = items.find(i => i.id === id); if (it) it.qty = qty; this.save(items); },
  count() { return this.get().reduce((s, i) => s + (i.qty || 1), 0); },
  total() { return this.get().reduce((s, i) => s + i.price * (i.qty || 1), 0); },
  updateBadge() {
    document.querySelectorAll('.cart-count').forEach(el => {
      const c = this.count();
      el.textContent = c;
      el.style.display = c > 0 ? 'flex' : 'none';
    });
  }
};

/* ── Dummy Data ─────────────────────────────────────────────── */
const DummyData = {
  medicines: [
    { id:1, name:'Paracetamol 500mg', brand:'MedCure', category:'Pain Relief', price:45, oldPrice:60, img:'💊', stock:120, rating:4.5, rxRequired:false, discount:25, description:'Effective pain and fever relief.' },
    { id:2, name:'Amoxicillin 250mg', brand:'BioPharma', category:'Antibiotics', price:180, oldPrice:220, img:'💊', stock:85, rating:4.2, rxRequired:true, discount:18, description:'Broad-spectrum antibiotic.' },
    { id:3, name:'Cetirizine 10mg',   brand:'AllerFree', category:'Allergy', price:35, oldPrice:45, img:'💊', stock:200, rating:4.7, rxRequired:false, discount:22, description:'Non-drowsy allergy relief.' },
    { id:4, name:'Metformin 500mg',   brand:'DiaCare', category:'Diabetes', price:95, oldPrice:120, img:'💊', stock:60, rating:4.3, rxRequired:true, discount:21, description:'Manages blood sugar levels.' },
    { id:5, name:'Atorvastatin 20mg', brand:'CardioHealth', category:'Cardiology', price:220, oldPrice:280, img:'💊', stock:45, rating:4.6, rxRequired:true, discount:21, description:'Reduces bad cholesterol.' },
    { id:6, name:'Vitamin D3 1000IU', brand:'VitaBoost', category:'Vitamins', price:299, oldPrice:399, img:'💊', stock:300, rating:4.8, rxRequired:false, discount:25, description:'Supports bone and immune health.' },
    { id:7, name:'Omeprazole 20mg',   brand:'GastroCare', category:'Gastro', price:75, oldPrice:95, img:'💊', stock:150, rating:4.4, rxRequired:false, discount:21, description:'Reduces stomach acid.' },
    { id:8, name:'Salbutamol Inhaler',brand:'BreathEasy', category:'Respiratory', price:350, oldPrice:420, img:'💊', stock:30, rating:4.5, rxRequired:true, discount:17, description:'Relief from asthma symptoms.' },
    { id:9, name:'Ibuprofen 400mg',   brand:'PainGone', category:'Pain Relief', price:55, oldPrice:70, img:'💊', stock:180, rating:4.3, rxRequired:false, discount:21, description:'Anti-inflammatory pain reliever.' },
    { id:10,name:'Azithromycin 500mg',brand:'BioPharma', category:'Antibiotics', price:240, oldPrice:300, img:'💊', stock:40, rating:4.1, rxRequired:true, discount:20, description:'Treats bacterial infections.' },
    { id:11,name:'Pantoprazole 40mg', brand:'GastroCare', category:'Gastro', price:120, oldPrice:150, img:'💊', stock:90, rating:4.4, rxRequired:false, discount:20, description:'Acid reflux & heartburn relief.' },
    { id:12,name:'Multivitamin Daily', brand:'VitaBoost',category:'Vitamins', price:450, oldPrice:550, img:'💊', stock:250, rating:4.9, rxRequired:false, discount:18, description:'Complete daily nutrition.' },
  ],
  categories: [
    { id:1, name:'Pain Relief',  icon:'🩹', color:'#ef4444', count:34 },
    { id:2, name:'Antibiotics',  icon:'🧪', color:'#f59e0b', count:28 },
    { id:3, name:'Vitamins',     icon:'💊', color:'#22c55e', count:45 },
    { id:4, name:'Cardiology',   icon:'❤️', color:'#ef4444', count:22 },
    { id:5, name:'Diabetes',     icon:'🩸', color:'#8b5cf6', count:18 },
    { id:6, name:'Allergy',      icon:'🌿', color:'#14b8a6', count:31 },
    { id:7, name:'Gastro',       icon:'🫁', color:'#f97316', count:25 },
    { id:8, name:'Respiratory',  icon:'💨', color:'#06b6d4', count:20 },
  ],
  orders: [
    { id:'ORD-20241201', date:'01 Dec 2024', status:'Delivered', total:545, items:3 },
    { id:'ORD-20241118', date:'18 Nov 2024', status:'Delivered', total:380, items:2 },
    { id:'ORD-20241205', date:'05 Dec 2024', status:'Processing',total:720, items:4 },
    { id:'ORD-20241210', date:'10 Dec 2024', status:'Pending',   total:299, items:1 },
    { id:'ORD-20241215', date:'15 Dec 2024', status:'Cancelled', total:460, items:2 },
  ],
  customers: [
    { id:'C001', name:'Priya Sharma',   email:'priya@example.com',   phone:'9876543210', orders:12, status:'Active',   joined:'Mar 2024' },
    { id:'C002', name:'Rahul Mehta',    email:'rahul@example.com',   phone:'9123456789', orders:5,  status:'Active',   joined:'Jun 2024' },
    { id:'C003', name:'Anita Singh',    email:'anita@example.com',   phone:'9876012345', orders:8,  status:'Inactive', joined:'Jan 2024' },
    { id:'C004', name:'Vikram Patel',   email:'vikram@example.com',  phone:'9000123456', orders:20, status:'Active',   joined:'Nov 2023' },
    { id:'C005', name:'Neha Gupta',     email:'neha@example.com',    phone:'9988776655', orders:3,  status:'Active',   joined:'Aug 2024' },
    { id:'C006', name:'Arjun Rao',      email:'arjun@example.com',   phone:'8877665544', orders:15, status:'Active',   joined:'Feb 2024' },
    { id:'C007', name:'Sunita Desai',   email:'sunita@example.com',  phone:'7766554433', orders:7,  status:'Inactive', joined:'May 2024' },
    { id:'C008', name:'Kiran Joshi',    email:'kiran@example.com',   phone:'6655443322', orders:11, status:'Active',   joined:'Apr 2024' },
  ],
  pharmacists: [
    { id:'PH001', name:'Dr. Amit Kumar',  email:'amit@pharma.com',  phone:'9876543210', license:'PH-MH-2021-001', status:'Active',   joined:'Jan 2022' },
    { id:'PH002', name:'Dr. Sneha Iyer',  email:'sneha@pharma.com', phone:'9123456789', license:'PH-DL-2020-045', status:'Active',   joined:'Mar 2021' },
    { id:'PH003', name:'Dr. Rohan Verma', email:'rohan@pharma.com', phone:'8765432109', license:'PH-GJ-2019-112', status:'Inactive', joined:'Jun 2020' },
    { id:'PH004', name:'Dr. Meera Shah',  email:'meera@pharma.com', phone:'7654321098', license:'PH-MH-2022-078', status:'Active',   joined:'Aug 2022' },
  ],
  brands: [
    { id:'B001', name:'BioPharma',   country:'India',  products:45, status:'Active'   },
    { id:'B002', name:'MedCure',     country:'India',  products:32, status:'Active'   },
    { id:'B003', name:'VitaBoost',   country:'USA',    products:28, status:'Active'   },
    { id:'B004', name:'GastroCare',  country:'India',  products:19, status:'Active'   },
    { id:'B005', name:'AllerFree',   country:'UK',     products:22, status:'Inactive' },
    { id:'B006', name:'CardioHealth',country:'Germany',products:15, status:'Active'   },
    { id:'B007', name:'PainGone',    country:'India',  products:38, status:'Active'   },
    { id:'B008', name:'BreathEasy',  country:'USA',    products:12, status:'Active'   },
  ],
  suppliers: [
    { id:'S001', name:'Sun Pharma Distributors', contact:'Ramesh Patel',   phone:'9876543210', city:'Mumbai',    status:'Active' },
    { id:'S002', name:'Cipla Wholesale',         contact:'Kavita Singh',   phone:'9123456789', city:'Pune',      status:'Active' },
    { id:'S003', name:'Abbott Logistics',        contact:'Deepak Sharma',  phone:'8765432109', city:'Delhi',     status:'Active' },
    { id:'S004', name:'Lupin Direct',            contact:'Priya Mehta',    phone:'7654321098', city:'Hyderabad', status:'Inactive'},
    { id:'S005', name:'Dr. Reddy\'s Supply',     contact:'Anil Kumar',     phone:'6543210987', city:'Bangalore', status:'Active' },
  ],
  stockAlerts: {
    low: [
      { name:'Salbutamol Inhaler', current:30, min:50, category:'Respiratory' },
      { name:'Atorvastatin 20mg',  current:45, min:60, category:'Cardiology'  },
      { name:'Metformin 500mg',    current:60, min:80, category:'Diabetes'    },
      { name:'Azithromycin 500mg', current:40, min:70, category:'Antibiotics' },
    ],
    expired: [
      { name:'Penicillin 250mg',   batch:'BT-2024-001', expiry:'2024-10-31', category:'Antibiotics', qty:120 },
      { name:'Ranitidine 150mg',   batch:'BT-2024-005', expiry:'2024-09-15', category:'Gastro',      qty:80  },
    ],
    nearExpiry: [
      { name:'Doxycycline 100mg',  batch:'BT-2024-102', expiry:'2025-01-15', category:'Antibiotics', qty:60, daysLeft:21 },
      { name:'Clarithromycin',     batch:'BT-2024-089', expiry:'2025-02-01', category:'Antibiotics', qty:45, daysLeft:38 },
      { name:'Furosemide 40mg',    batch:'BT-2024-074', expiry:'2025-01-28', category:'Cardiology',  qty:90, daysLeft:34 },
    ],
  },
};

/* ── Helper Functions ───────────────────────────────────────── */
function formatCurrency(amount) { return '₹' + parseFloat(amount).toFixed(2); }
function formatDate(dateStr) {
  const d = new Date(dateStr);
  return d.toLocaleDateString('en-IN', { day:'2-digit', month:'short', year:'numeric' });
}
function getStatusBadge(status) {
  const map = {
    'Active':'badge-success', 'Inactive':'badge-danger', 'Pending':'badge-warning',
    'Delivered':'badge-success', 'Processing':'badge-info', 'Cancelled':'badge-danger',
    'Approved':'badge-success', 'Rejected':'badge-danger', 'Verified':'badge-success',
    'Low Stock':'badge-warning', 'Expired':'badge-danger', 'In Stock':'badge-success',
  };
  const cls = map[status] || 'badge-info';
  return `<span class="badge-custom ${cls}">${status}</span>`;
}
function starRating(rating) {
  const full = Math.floor(rating);
  const half = rating % 1 >= 0.5;
  let html = '<span class="star-rating">';
  for (let i = 0; i < full; i++) html += '<i class="bi bi-star-fill"></i>';
  if (half) html += '<i class="bi bi-star-half"></i>';
  for (let i = full + (half?1:0); i < 5; i++) html += '<i class="bi bi-star"></i>';
  html += `</span> <small class="text-muted-sm">(${rating})</small>`;
  return html;
}
function randomAvatar(name, size='md') {
  const colors = ['#1a6bcc','#00b4d8','#22c55e','#f59e0b','#ef4444','#8b5cf6','#ec4899','#14b8a6'];
  const color = colors[name.charCodeAt(0) % colors.length];
  const initials = name.split(' ').map(w=>w[0]).join('').toUpperCase().slice(0,2);
  return `<div class="avatar avatar-${size}" style="background:${color}">${initials}</div>`;
}

/* ── Nav Account Area ───────────────────────────────────────── */
function renderNavAccount() {
  // Render the account area in any navbar placeholder (navAccountArea or homeAccountArea)
  const slots = ['navAccountArea', 'homeAccountArea'].map(id => document.getElementById(id)).filter(Boolean);
  if (!slots.length) return;

  // Detect depth: pages inside customer/ or pharmacist/ subdirs are one level deep
  const path = window.location.pathname;
  const inCustomer = path.includes('/customer/');
  
  // Build correct relative URLs from current page context
  const profileUrl      = inCustomer ? 'profile.html'      : 'customer/profile.html';
  const ordersUrl       = inCustomer ? 'orders.html'       : 'customer/orders.html';
  const prescriptionUrl = inCustomer ? 'prescription.html' : 'customer/prescription.html';
  const logoutUrl       = inCustomer ? 'login.html'        : 'customer/login.html';

  // Simple session check via localStorage (set on login page)
  const user = JSON.parse(localStorage.getItem('mcUser') || 'null');

  slots.forEach(slot => {
    if (user) {
      const initials = user.name ? user.name.split(' ').map(w => w[0]).join('').toUpperCase().slice(0, 2) : 'U';
      const colors = ['#1a6bcc','#00b4d8','#22c55e','#8b5cf6','#ec4899'];
      const bg = colors[(initials.charCodeAt(0)||0) % colors.length];
      slot.innerHTML = `
        <div class="dropdown">
          <div class="d-flex align-items-center gap-2 cursor-pointer" data-bs-toggle="dropdown" style="cursor:pointer">
            <div class="avatar avatar-sm" style="background:${bg}">${initials}</div>
            <span class="d-none d-md-block fw-600" style="font-size:.82rem">${user.name || 'My Account'}</span>
            <i class="bi bi-chevron-down text-muted small"></i>
          </div>
          <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2" style="border-radius:12px;min-width:180px">
            <li><div class="px-3 py-2 border-bottom"><div class="fw-700 small">${user.name || 'Customer'}</div><div class="text-muted" style="font-size:.75rem">${user.email || ''}</div></div></li>
            <li><a class="dropdown-item py-2" href="${profileUrl}"><i class="bi bi-person me-2"></i>My Profile</a></li>
            <li><a class="dropdown-item py-2" href="${ordersUrl}"><i class="bi bi-bag me-2"></i>My Orders</a></li>
            <li><a class="dropdown-item py-2" href="${prescriptionUrl}"><i class="bi bi-file-medical me-2"></i>Prescriptions</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item py-2 text-danger" href="${logoutUrl}" onclick="localStorage.removeItem('mcUser')"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
          </ul>
        </div>`;
    } else {
      const loginHref = inCustomer ? 'login.html' : 'customer/login.html';
      slot.innerHTML = `
        <a href="${loginHref}" class="btn btn-primary-custom btn-sm fw-600" style="padding:.45rem 1rem;border-radius:8px">
          <i class="bi bi-person me-1"></i>Login
        </a>`;
    }
  });
}

/* ── Init on DOM Ready ──────────────────────────────────────── */
document.addEventListener('DOMContentLoaded', () => {
  initScrollAnimations();
  Cart.updateBadge();
  renderNavAccount();

  // Guard: intercept cart icon links — redirect to login if not logged in
  document.querySelectorAll('a.cart-btn').forEach(link => {
    link.addEventListener('click', e => {
      if (!Auth.isLoggedIn()) {
        e.preventDefault();
        Auth.requireLogin(link.href);
      }
    });
  });

  // Add page enter animation
  document.body.classList.add('page-enter');
});

/* ── Export for modules ─────────────────────────────────────── */
window.showToast    = showToast;
window.showConfirm  = showConfirm;
window.showLoader   = showLoader;
window.hideLoader   = hideLoader;
window.Cart         = Cart;
window.DummyData    = DummyData;
window.initSidebar  = initSidebar;
window.filterTable  = filterTable;
window.initPagination = initPagination;
window.initDropzone = initDropzone;
window.formatCurrency = formatCurrency;
window.getStatusBadge = getStatusBadge;
window.starRating   = starRating;
window.randomAvatar = randomAvatar;
window.renderNavAccount = renderNavAccount;
window.Auth = Auth;

