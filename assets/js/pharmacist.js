/* Shared pharmacist sidebar snippet for all sub-pages — injected via JS */
const PH_SIDEBAR = (activePage) => `
<aside class="ph-sidebar" id="phSidebar">
  <div class="sidebar-brand">
    <div class="sidebar-brand-icon"><i class="bi bi-capsule-pill"></i></div>
    <div class="sidebar-brand-text">MediCare<span>Pharmacist Portal</span></div>
  </div>
  <div class="sidebar-user">
    <div class="avatar avatar-sm" style="background:linear-gradient(135deg,var(--primary),var(--secondary))">AK</div>
    <div class="sidebar-user-info">
      <div class="sidebar-user-name">Dr. Amit Kumar</div>
      <div class="sidebar-user-role">Senior Pharmacist</div>
    </div>
  </div>
  <nav class="sidebar-nav">
    <div class="sidebar-label">Main</div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link ${activePage==='dashboard'?'active':''}" href="Dashboard.aspx">
        <i class="bi bi-speedometer2"></i>Dashboard
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link ${activePage==='medicine'?'active':''}" href="MedicineManagement.aspx">
        <i class="bi bi-capsule"></i>Medicine Management
      </a>
    </div>

    <div class="sidebar-label">Operations</div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link ${activePage==='inventory'?'active':''}" href="Inventory.aspx">
        <i class="bi bi-boxes"></i>Inventory & Alerts
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link ${activePage==='orders'?'active':''}" href="OrderManagement.aspx">
        <i class="bi bi-bag-check"></i>Order Management
        <span class="nav-badge">5</span>
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link ${activePage==='rxbilling'?'active':''}" href="PrescriptionBilling.aspx">
        <i class="bi bi-file-medical-fill"></i>Rx & Billing
        <span class="nav-badge">3</span>
      </a>
    </div>

    <div class="sidebar-label">Account</div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link" href="#">
        <i class="bi bi-person-circle"></i>My Profile
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link" href="../Customer/Login.aspx">
        <i class="bi bi-box-arrow-right"></i>Logout
      </a>
    </div>

    <div class="sidebar-label">Portal Access</div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link portal-link" href="../Admin/Dashboard.aspx">
        <i class="bi bi-shield-lock-fill"></i>Admin Portal
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link portal-link" href="../Default.aspx">
        <i class="bi bi-shop"></i>Customer Portal
      </a>
    </div>
  </nav>
  <div class="sidebar-footer"><div class="sidebar-version">MediCare PMS v2.4.1</div></div>
</aside>
<div class="sidebar-overlay" id="phOverlay"></div>`;

const PH_HEADER = (title, breadcrumb) => `
<header class="ph-header">
  <div class="ph-header-left">
    <button class="sidebar-toggle" onclick="document.getElementById('phSidebar').classList.toggle('open');document.getElementById('phOverlay').classList.toggle('visible')">
      <i class="bi bi-list"></i>
    </button>
    <div>
      <div class="page-title">${title}</div>
      <ol class="breadcrumb-custom">
        <li><a href="Dashboard.aspx"><i class="bi bi-house-door me-1"></i>Home</a></li>
        <li><i class="bi bi-chevron-right small"></i></li>
        <li>${breadcrumb}</li>
      </ol>
    </div>
  </div>
  <div class="ph-header-right">
    <div class="search-bar d-none d-md-block" style="max-width:200px">
      <i class="bi bi-search"></i>
      <input type="text" class="form-control" placeholder="Search...">
    </div>
    <div class="header-icon-btn" title="Notifications">
      <i class="bi bi-bell"></i>
      <span class="notif-dot"></span>
    </div>
    <div class="dropdown">
      <div class="d-flex align-items-center gap-2" data-bs-toggle="dropdown" style="cursor:pointer">
        <div class="avatar avatar-sm" style="background:linear-gradient(135deg,var(--primary),var(--secondary))">AK</div>
        <div class="d-none d-md-block">
          <div style="font-size:.82rem;font-weight:700;font-family:var(--font-main);color:var(--dark)">Dr. Amit Kumar</div>
          <div style="font-size:.7rem;color:var(--gray-400);font-family:var(--font-main)">Senior Pharmacist</div>
        </div>
        <i class="bi bi-chevron-down text-muted small"></i>
      </div>
      <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2" style="border-radius:14px;min-width:200px;border:1px solid var(--gray-200) !important">
        <li><div class="px-3 py-2 border-bottom"><strong style="font-size:.88rem">Dr. Amit Kumar</strong><br><small class="text-muted">amit@medicare.com</small></div></li>
        <li><a class="dropdown-item py-2" href="#"><i class="bi bi-person me-2 text-primary"></i>My Profile</a></li>
        <li><hr class="dropdown-divider"></li>
        <li><a class="dropdown-item py-2 text-danger" href="../Customer/Login.aspx"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
      </ul>
    </div>
  </div>
</header>`;

window.PH_SIDEBAR = PH_SIDEBAR;
window.PH_HEADER  = PH_HEADER;

/* Lock viewport scroll for pharmacist layout pages */
document.documentElement.classList.add('layout-locked');
document.body.classList.add('layout-locked');

