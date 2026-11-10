/* ============================================================
   PHARMACIST JS — Header templates for pharmacist portal
   (Sidebar HTML is directly embedded into each individual page)
   ============================================================ */
const PH_SIDEBAR = (activePage) => '';


const PH_HEADER = (title, breadcrumb) => `
<header class="ph-header">
  <div class="ph-header-left">
    <button class="sidebar-toggle" onclick="document.getElementById('phSidebar').classList.toggle('open');document.getElementById('phOverlay').classList.toggle('visible')">
      <i class="bi bi-list"></i>
    </button>
    <div>
      <div class="page-title">${title}</div>
      <ol class="breadcrumb-custom">
        <li><a href="dashboard.html"><i class="bi bi-house-door me-1"></i>Home</a></li>
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
        <li><a class="dropdown-item py-2" href="profile.html"><i class="bi bi-person me-2 text-primary"></i>My Profile</a></li>
        <li><hr class="dropdown-divider"></li>
        <li><a class="dropdown-item py-2 text-danger" href="../Logout.aspx"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
      </ul>
    </div>
  </div>
</header>`;

window.PH_SIDEBAR = PH_SIDEBAR;
window.PH_HEADER  = PH_HEADER;

/* Lock viewport scroll for pharmacist layout pages */
document.documentElement.classList.add('layout-locked');
document.body.classList.add('layout-locked');

/* Auto-init subnav expand/collapse for all pharmacist pages */
document.addEventListener('DOMContentLoaded', () => {
  if (typeof initSubnav === 'function') initSubnav('phSidebar');
});
