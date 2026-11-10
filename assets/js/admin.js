/* ============================================================
   ADMIN JS — Header templates for admin portal
   (Sidebar HTML is directly embedded into each individual page)
   ============================================================ */
const ADMIN_SIDEBAR = (activePage) => '';


const ADMIN_HEADER = (title, breadcrumb) => `
<header class="ph-header">
  <div class="ph-header-left">
    <button class="sidebar-toggle" onclick="document.getElementById('adminSidebar').classList.toggle('open');document.getElementById('adminOverlay').classList.toggle('visible')">
      <i class="bi bi-list"></i>
    </button>
    <div>
      <div class="page-title">${title}</div>
      <ol class="breadcrumb-custom">
        <li><a href="dashboard.html"><i class="bi bi-house-door me-1"></i>Admin</a></li>
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
        <li><a class="dropdown-item py-2" href="profile.html"><i class="bi bi-person me-2 text-primary"></i>My Profile</a></li>
        <li><a class="dropdown-item py-2" href="settings.html"><i class="bi bi-gear me-2 text-primary"></i>Settings</a></li>
        <li><hr class="dropdown-divider"></li>
        <li><a class="dropdown-item py-2 text-danger" href="../Logout.aspx"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
      </ul>
    </div>
  </div>
</header>`;

window.ADMIN_SIDEBAR = ADMIN_SIDEBAR;
window.ADMIN_HEADER = ADMIN_HEADER;

/* Lock viewport scroll for admin layout pages */
document.documentElement.classList.add('layout-locked');
document.body.classList.add('layout-locked');

