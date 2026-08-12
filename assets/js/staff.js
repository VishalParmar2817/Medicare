/* ============================================================
   STYLE HUB STAFF JS — Sidebar & Header for Store Operations Portal
   ============================================================ */
const STAFF_SIDEBAR = (activePage) => `
<aside class="ph-sidebar" id="phSidebar">
  <div class="sidebar-brand">
    <div class="sidebar-brand-icon"><i class="bi bi-bag-heart-fill"></i></div>
    <div class="sidebar-brand-text">STYLE HUB<span>Operations Portal</span></div>
  </div>
  <div class="sidebar-user">
    <div class="avatar avatar-sm" style="background:linear-gradient(135deg,#4F46E5,#7C3AED);color:#fff">AK</div>
    <div class="sidebar-user-info">
      <div class="sidebar-user-name">Amit Kumar</div>
      <div class="sidebar-user-role">Store Manager</div>
    </div>
  </div>
  <nav class="sidebar-nav">
    <div class="sidebar-label">Main</div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link ${activePage==='dashboard'?'active':''}" href="dashboard.html">
        <i class="bi bi-speedometer2"></i>Operations Dashboard
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link ${activePage==='products'?'active':''}" href="product-management.html">
        <i class="bi bi-tag-fill"></i>Product Management
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link ${activePage==='categories'?'active':''}" href="category-management.html">
        <i class="bi bi-grid-3x3-gap"></i>Category Management
      </a>
    </div>

    <div class="sidebar-label">Inventory & Orders</div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link ${activePage==='inventory'?'active':''}" href="inventory.html">
        <i class="bi bi-boxes"></i>Inventory & Sizes
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link ${activePage==='stock-alerts'?'active':''}" href="stock-alerts.html">
        <i class="bi bi-exclamation-triangle-fill"></i>Low Stock Alerts
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link ${activePage==='orders'?'active':''}" href="order-management.html">
        <i class="bi bi-bag-check-fill"></i>Order Fulfillment
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link ${activePage==='billing'?'active':''}" href="billing.html">
        <i class="bi bi-receipt"></i>Counter POS Billing
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link ${activePage==='suppliers'?'active':''}" href="supplier-management.html">
        <i class="bi bi-truck"></i>Garment Suppliers
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link ${activePage==='returns'?'active':''}" href="returns-management.html">
        <i class="bi bi-arrow-counterclockwise"></i>Returns & Exchanges
      </a>
    </div>

    <div class="sidebar-label">Portal Access</div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link portal-link" href="../admin/dashboard.html">
        <i class="bi bi-shield-lock-fill"></i>Admin Portal
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link portal-link" href="../index.html">
        <i class="bi bi-shop"></i>Customer Store
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link text-danger" href="../customer/login.html" onclick="Auth.logout()">
        <i class="bi bi-box-arrow-right"></i>Logout
      </a>
    </div>
  </nav>
  <div class="sidebar-footer"><div class="sidebar-version">STYLE HUB Operations v3.0</div></div>
</aside>
<div class="sidebar-overlay" id="phOverlay"></div>`;

const STAFF_HEADER = (title, breadcrumb) => `
<header class="ph-header">
  <div class="ph-header-left">
    <button class="sidebar-toggle" onclick="document.getElementById('phSidebar').classList.toggle('open');document.getElementById('phOverlay').classList.toggle('visible')">
      <i class="bi bi-list"></i>
    </button>
    <div>
      <div class="page-title">${title}</div>
      <ol class="breadcrumb-custom">
        <li><a href="dashboard.html"><i class="bi bi-house-door me-1"></i>Operations</a></li>
        <li><i class="bi bi-chevron-right small"></i></li>
        <li>${breadcrumb}</li>
      </ol>
    </div>
  </div>
  <div class="ph-header-right">
    <div class="search-bar d-none d-md-block" style="max-width:200px">
      <i class="bi bi-search"></i>
      <input type="text" class="form-control" placeholder="Search orders or products...">
    </div>
    <div class="header-icon-btn" title="Notifications">
      <i class="bi bi-bell"></i>
      <span class="notif-dot"></span>
    </div>
    <div class="dropdown">
      <div class="d-flex align-items-center gap-2" data-bs-toggle="dropdown" style="cursor:pointer">
        <div class="avatar avatar-sm" style="background:linear-gradient(135deg,#4F46E5,#7C3AED);color:#fff">AK</div>
        <div class="d-none d-md-block">
          <div style="font-size:.82rem;font-weight:700;font-family:var(--font-main);color:var(--dark)">Amit Kumar</div>
          <div style="font-size:.7rem;color:var(--gray-400);font-family:var(--font-main)">Store Manager</div>
        </div>
        <i class="bi bi-chevron-down text-muted small"></i>
      </div>
      <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2" style="border-radius:14px;min-width:200px">
        <li><div class="px-3 py-2 border-bottom"><strong style="font-size:.88rem">Amit Kumar</strong><br><small class="text-muted">amit@stylehub.com</small></div></li>
        <li><a class="dropdown-item py-2" href="../admin/dashboard.html"><i class="bi bi-shield me-2 text-primary"></i>Admin Portal</a></li>
        <li><hr class="dropdown-divider"></li>
        <li><a class="dropdown-item py-2 text-danger" href="../customer/login.html" onclick="Auth.logout()"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
      </ul>
    </div>
  </div>
</header>`;

window.STAFF_SIDEBAR = STAFF_SIDEBAR;
window.STAFF_HEADER  = STAFF_HEADER;
// Provide backward compatibility aliases
window.PH_SIDEBAR    = STAFF_SIDEBAR;
window.PH_HEADER     = STAFF_HEADER;

document.documentElement.classList.add('layout-locked');
document.body.classList.add('layout-locked');
