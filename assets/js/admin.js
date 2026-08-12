/* ============================================================
   ADMIN JS — Sidebar & Header templates for admin portal
   ============================================================ */
const ADMIN_SIDEBAR = (activePage) => `
<aside class="ph-sidebar admin-sidebar" id="adminSidebar">
  <div class="sidebar-brand">
    <div class="sidebar-brand-icon"><i class="bi bi-capsule-pill"></i></div>
    <div class="sidebar-brand-text">MediCare<span>Admin Panel</span></div>
  </div>
  <div class="sidebar-user">
    <div class="avatar avatar-sm" style="background:linear-gradient(135deg,#8B5CF6,#7C3AED)">SA</div>
    <div class="sidebar-user-info">
      <div class="sidebar-user-name">Super Admin</div>
      <div class="sidebar-user-role">System Administrator</div>
    </div>
  </div>
  <nav class="sidebar-nav">
    <div class="sidebar-label">Overview</div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link ${activePage==='dashboard'?'active':''}" href="Dashboard.aspx">
        <i class="bi bi-speedometer2"></i>Dashboard
      </a>
    </div>

    <div class="sidebar-label">User Management</div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link ${activePage==='customers'?'active':''}" href="Customers.aspx">
        <i class="bi bi-people"></i>Customers
        <span class="nav-badge">${DummyData.customers.length}</span>
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link ${activePage==='pharmacists'?'active':''}" href="Pharmacists.aspx">
        <i class="bi bi-person-badge"></i>Pharmacists
        <span class="nav-badge">${DummyData.pharmacists.length}</span>
      </a>
    </div>

    <div class="sidebar-label">Catalog</div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link ${activePage==='medicines'?'active':''}" href="Medicines.aspx">
        <i class="bi bi-capsule"></i>Medicines
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link ${activePage==='brands'?'active':''}" href="Brands.aspx">
        <i class="bi bi-building"></i>Brands
      </a>
    </div>

    <div class="sidebar-label">Operations</div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link ${activePage==='orders'?'active':''}" href="Orders.aspx">
        <i class="bi bi-bag-check"></i>All Orders
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link ${activePage==='reports'?'active':''}" href="Reports.aspx">
        <i class="bi bi-graph-up-arrow"></i>Reports
      </a>
    </div>

    <div class="sidebar-label">System</div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link ${activePage==='settings'?'active':''}" href="Settings.aspx">
        <i class="bi bi-gear-wide-connected"></i>Settings
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link" href="../Customer/Login.aspx">
        <i class="bi bi-box-arrow-right"></i>Logout
      </a>
    </div>

    <div class="sidebar-label">Portal Access</div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link portal-link" href="../Pharmacist/Dashboard.aspx">
        <i class="bi bi-person-badge-fill"></i>Pharmacist Portal
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link portal-link" href="../Default.aspx">
        <i class="bi bi-shop"></i>Customer Portal
      </a>
    </div>
  </nav>
  <div class="sidebar-footer">
    <div class="sidebar-version">MediCare Admin v2.4.1</div>
  </div>
</aside>
<div class="sidebar-overlay" id="adminOverlay"></div>`;

const ADMIN_HEADER = (title, breadcrumb) => `
<header class="ph-header">
  <div class="ph-header-left">
    <button class="sidebar-toggle" onclick="document.getElementById('adminSidebar').classList.toggle('open');document.getElementById('adminOverlay').classList.toggle('visible')">
      <i class="bi bi-list"></i>
    </button>
    <div>
      <div class="page-title">${title}</div>
      <ol class="breadcrumb-custom">
        <li><a href="Dashboard.aspx"><i class="bi bi-house-door me-1"></i>Admin</a></li>
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
    <div class="header-icon-btn" title="Help">
      <i class="bi bi-question-circle"></i>
    </div>
    <div class="dropdown">
      <div class="d-flex align-items-center gap-2 cursor-pointer" data-bs-toggle="dropdown" style="cursor:pointer">
        <div class="avatar avatar-sm" style="background:linear-gradient(135deg,#8B5CF6,#7C3AED)">SA</div>
        <div class="d-none d-md-block">
          <div style="font-size:.82rem;font-weight:700;font-family:var(--font-main);color:var(--dark)">Super Admin</div>
          <div style="font-size:.7rem;color:var(--gray-400);font-family:var(--font-main)">admin@medicare.com</div>
        </div>
        <i class="bi bi-chevron-down text-muted small"></i>
      </div>
      <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2" style="border-radius:14px;min-width:200px;border:1px solid var(--gray-200) !important">
        <li><div class="px-3 py-2 border-bottom"><strong style="font-size:.88rem">Super Admin</strong><br><small class="text-muted">admin@medicare.com</small></div></li>
        <li><a class="dropdown-item py-2" href="Settings.aspx"><i class="bi bi-gear me-2 text-primary"></i>Settings</a></li>
        <li><hr class="dropdown-divider"></li>
        <li><a class="dropdown-item py-2 text-danger" href="../Customer/Login.aspx"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
      </ul>
    </div>
  </div>
</header>`;

window.ADMIN_SIDEBAR = ADMIN_SIDEBAR;
window.ADMIN_HEADER = ADMIN_HEADER;

/* Lock viewport scroll for admin layout pages */
document.documentElement.classList.add('layout-locked');
document.body.classList.add('layout-locked');

