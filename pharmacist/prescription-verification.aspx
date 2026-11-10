<%@ Page Title="Prescription Verification — Pharmacist Portal | MediCare" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="prescription-verification.aspx.cs" Inherits="medicare.pharmacist.prescriptionVerification" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link rel="stylesheet" href="<%= ResolveUrl("~/assets/css/pharmacist.css") %>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
<asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
<body>
<div class="ph-layout">
  <!-- ══ PHARMACIST SIDEBAR ═══════════════════════════════════════ -->
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
      <a class="sidebar-nav-link " href="dashboard.aspx">
        <i class="bi bi-speedometer2"></i>Dashboard
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link " href="medicine-management.aspx">
        <i class="bi bi-capsule"></i>Medicine Management
      </a>
    </div>

    <div class="sidebar-label">Operations</div>
    <div class="sidebar-nav-item ">
      <a class="sidebar-nav-link " href="inventory.aspx"><i class="bi bi-boxes"></i>Inventory &amp; Alerts</a>
      <div class="sidebar-subnav">
        <a class="sidebar-subnav-link " href="stock-in.aspx"><i class="bi bi-box-arrow-in-down"></i>Stock In</a>
        <a class="sidebar-subnav-link " href="stock-out.aspx"><i class="bi bi-box-arrow-up"></i>Stock Out</a>
        <a class="sidebar-subnav-link " href="low-stock.aspx"><i class="bi bi-exclamation-triangle"></i>Low Stock</a>
        <a class="sidebar-subnav-link " href="expiring-soon.aspx"><i class="bi bi-clock-history"></i>Expiring Soon</a>
      </div>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link " href="order-management.aspx">
        <i class="bi bi-bag-check"></i>Order Management
        <span class="nav-badge">5</span>
      </a>
    </div>
    <div class="sidebar-nav-item expanded">
      <a class="sidebar-nav-link " href="prescription-billing.aspx">
        <i class="bi bi-file-medical-fill"></i>Rx &amp; Billing
        <span class="nav-badge">3</span>
      </a>
      <div class="sidebar-subnav">
        <a class="sidebar-subnav-link active" href="prescription-verification.aspx"><i class="bi bi-file-earmark-check"></i>Prescription Verification</a>
        <a class="sidebar-subnav-link " href="prescription-billing.aspx"><i class="bi bi-calculator"></i>Billing</a>
        <a class="sidebar-subnav-link " href="invoices.aspx"><i class="bi bi-receipt"></i>Invoices</a>
      </div>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link " href="category-management.aspx">
        <i class="bi bi-grid-3x3-gap"></i>Categories
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link " href="supplier-management.aspx">
        <i class="bi bi-truck"></i>Suppliers
      </a>
    </div>

    <div class="sidebar-label">Account</div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link " href="profile.aspx">
        <i class="bi bi-person-circle"></i>My Profile
      </a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link" href="../Logout.aspx">
        <i class="bi bi-box-arrow-right"></i>Logout
      </a>
    </div>

    <div class="sidebar-label">Portal Access</div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link portal-link" href="../admin/dashboard.aspx"><i class="bi bi-shield-lock-fill"></i>Admin Portal</a>
    </div>
    <div class="sidebar-nav-item">
      <a class="sidebar-nav-link portal-link" href="../index.aspx"><i class="bi bi-shop"></i>Customer Portal</a>
    </div>
  </nav>
  <div class="sidebar-footer"><div class="sidebar-version">MediCare PMS v2.4.1</div></div>
</aside>
<div class="sidebar-overlay" id="phOverlay"></div>
  <div class="ph-main">
    <div id="headerMount"></div>
    <main class="ph-content">
      <div class="rx-page-intro">
        <div>
          <div class="rx-eyebrow">Clinical operations</div>
          <h1>Prescription Verification</h1>
          <p>Review submitted prescriptions and approve them for safe dispensing.</p>
        </div>
        <span class="rx-queue-chip"><i class="bi bi-shield-check"></i> Verification queue</span>
      </div>

      <div class="row g-3 mb-4 rx-summary-row">
        <div class="col-6 col-xl-3"><div class="stat-card stat-orange"><div class="rx-stat-top"><div class="stat-icon"><i class="bi bi-hourglass-split"></i></div><span class="stat-trend">Action Needed</span></div><div class="stat-value"><asp:Label ID="lblPendingRx" runat="server" Text="0" ClientIDMode="Static" /></div><div class="stat-label">Pending Prescriptions</div></div></div>
        <div class="col-6 col-xl-3"><div class="stat-card stat-blue"><div class="rx-stat-top"><div class="stat-icon"><i class="bi bi-search"></i></div><span class="stat-trend">In Progress</span></div><div class="stat-value"><asp:Label ID="lblReviewRx" runat="server" Text="0" ClientIDMode="Static" /></div><div class="stat-label">Under Review</div></div></div>
        <div class="col-6 col-xl-3"><div class="stat-card stat-green"><div class="rx-stat-top"><div class="stat-icon"><i class="bi bi-check2-circle"></i></div><span class="stat-trend">This Month</span></div><div class="stat-value"><asp:Label ID="lblApprovedRx" runat="server" Text="0" ClientIDMode="Static" /></div><div class="stat-label">Approved</div></div></div>
        <div class="col-6 col-xl-3"><div class="stat-card stat-red"><div class="rx-stat-top"><div class="stat-icon"><i class="bi bi-x-circle"></i></div><span class="stat-trend">This Month</span></div><div class="stat-value"><asp:Label ID="lblRejectedRx" runat="server" Text="0" ClientIDMode="Static" /></div><div class="stat-label">Rejected</div></div></div>
      </div>

      <div class="rx-filter-bar data-card mb-4">
        <div class="rx-filter-field rx-filter-search">
          <label for="rxSearch">Search prescription or customer</label>
          <div class="search-bar">
            <i class="bi bi-search"></i>
            <asp:TextBox runat="server" ID="rxSearch" TextMode="Search" placeholder="e.g. RX-2025-001 or Priya Sharma" ClientIDMode="Static" />
          </div>
        </div>
        <div class="rx-filter-field">
          <label for="rxStatus">Status</label>
          <asp:DropDownList runat="server" ID="rxStatus" CssClass="form-control-custom" ClientIDMode="Static">
            <asp:ListItem Value="">All statuses</asp:ListItem>
            <asp:ListItem>Pending</asp:ListItem>
            <asp:ListItem>Under Review</asp:ListItem>
            <asp:ListItem>Approved</asp:ListItem>
            <asp:ListItem>Rejected</asp:ListItem>
          </asp:DropDownList>
        </div>
        <div class="rx-filter-field">
          <label for="rxDate">Date</label>
          <asp:DropDownList runat="server" ID="rxDate" CssClass="form-control-custom" ClientIDMode="Static">
            <asp:ListItem Value="">All dates</asp:ListItem>
            <asp:ListItem>Today</asp:ListItem>
            <asp:ListItem>Last 7 days</asp:ListItem>
            <asp:ListItem>This month</asp:ListItem>
          </asp:DropDownList>
        </div>
        <asp:LinkButton runat="server" ID="applyFilters" CssClass="btn btn-primary-custom rx-filter-button" ClientIDMode="Static" OnClick="applyFilters_Click">
          <i class="bi bi-funnel me-1"></i>Filter
        </asp:LinkButton>
      </div>

      <div class="rx-workspace">
        <section class="data-card rx-list-card">
          <div class="data-card-header">
            <div>
              <h2 class="rx-section-title">Verification queue</h2>
              <span class="text-muted small" id="rxCountLabel"></span>
            </div>
            <span class="rx-table-caption"><i class="bi bi-arrow-down-up"></i> Sorted by newest</span>
          </div>
          <div class="table-wrap">
            <asp:GridView ID="gvRx" runat="server" AutoGenerateColumns="False"
              OnRowCommand="gvRx_RowCommand" CssClass="table table-bordered table-striped"
              ClientIDMode="Static">
              <Columns>
                <asp:TemplateField HeaderText="Rx ID">
                  <ItemTemplate>
                    <span class="fw-700 text-primary"><%# Eval("PrescriptionCode") != null ? Eval("PrescriptionCode") : ("#RX-" + Eval("PrescriptionID")) %></span>
                  </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Customer">
                  <ItemTemplate>
                    <div><strong><%# Eval("CustomerName") %></strong></div>
                    <small class="text-muted"><%# Eval("PhoneNumber") %></small>
                  </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Date">
                  <ItemTemplate>
                    <span class="text-muted small"><%# Eval("CreatedAt", "{0:dd-MMM-yyyy}") %></span>
                  </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Status">
                  <ItemTemplate>
                    <span class='badge-custom <%# Eval("Status") != null && Eval("Status").ToString() == "Approved" ? "badge-success" : Eval("Status") != null && Eval("Status").ToString() == "Rejected" ? "badge-danger" : "badge-warning" %>'>
                      <%# Eval("Status") %>
                    </span>
                  </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Approve">
                  <ItemTemplate>
                    <asp:LinkButton ID="btnApprove" runat="server" CommandName="cmd_approve"
                      CommandArgument='<%# Eval("PrescriptionID") %>' CssClass="btn btn-sm btn-success-custom py-1 px-2">
                      <i class="bi bi-check-lg me-1"></i>Approve
                    </asp:LinkButton>
                  </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Reject">
                  <ItemTemplate>
                    <asp:LinkButton ID="btnReject" runat="server" CommandName="cmd_reject"
                      CommandArgument='<%# Eval("PrescriptionID") %>' CssClass="btn btn-sm btn-danger-custom py-1 px-2"
                      OnClientClick="return confirm('Are you sure you want to reject this prescription?');">
                      <i class="bi bi-x-lg me-1"></i>Reject
                    </asp:LinkButton>
                  </ItemTemplate>
                </asp:TemplateField>
              </Columns>
              <EmptyDataTemplate>
                <div class="text-center py-4 text-muted">
                  <i class="bi bi-inbox fs-2 d-block mb-2"></i>
                  No prescriptions in verification queue.
                </div>
              </EmptyDataTemplate>
            </asp:GridView>
          </div>
        </section>

        <!-- Rx Details Card -->
        <aside class="data-card rx-details-card" id="rxDetails">
          <div class="p-4 text-center text-muted">
            <i class="bi bi-file-earmark-medical fs-1 d-block mb-2 text-primary"></i>
            Select a prescription from the list to view full clinical details and take action.
          </div>
        </aside>
      </div>
    </main>
  </div>
</div>

<div id="toast-container"></div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="../assets/js/main.js"></script>
<script src="../assets/js/pharmacist.js"></script>
<script>
const prescriptions = [
  { id:'RX-1025', customer:'Rahul Patel', phone:'9876543210', age:28, gender:'Male', doctor:'Dr. Sandeep Mehta', qualification:'MBBS, MD', registration:'12345', hospital:'Apollo Hospital, Mumbai', date:'04 Sep 2026', time:'11:30 AM', status:'Pending', medicines:['Amoxicillin 500mg - 10 Capsules','Paracetamol 650mg - 10 Tablets','Cetirizine 10mg - 10 Tablets'], notes:'', urgent:true },
  { id:'RX-1024', customer:'Priya Sharma', phone:'9000123456', doctor:'Dr. Sneha Iyer', qualification:'MBBS, MD', registration:'23456', hospital:'Max Hospital, Delhi', date:'04 Sep 2026', status:'Under Review', medicines:['Azithromycin 250mg - 6 Tablets'], notes:'Review dosage and duration.', urgent:false },
  { id:'RX-2025-003', customer:'Neha Gupta', phone:'9988776655', doctor:'Dr. Rohan Verma', hospital:'Fortis Clinic, Pune', date:'24 Jul 2025', status:'Pending', medicines:['Salbutamol Inhaler (x1)','Montelukast 10mg (x30)'], notes:'Asthma management', urgent:true },
  { id:'RX-2025-004', customer:'Rahul Mehta', phone:'9123456789', age:39, gender:'Male', doctor:'Dr. Amit Kumar', qualification:'MBBS MD', registration:'MCI-2013-11111', hospital:'Medanta, Gurgaon', date:'23 Jul 2025', status:'Approved', medicines:['Pantoprazole 40mg (x14)','Domperidone 10mg (x14)'], notes:'GERD treatment', urgent:false },
  { id:'RX-2025-005', customer:'Anita Singh', phone:'9876012345', age:46, gender:'Female', doctor:'Dr. Meera Shah', qualification:'MBBS MD', registration:'MCI-2011-86420', hospital:'KEM Hospital, Mumbai', date:'23 Jul 2025', status:'Approved', medicines:['Amlodipine 5mg (x30)','Telmisartan 40mg (x30)'], notes:'Hypertension control', urgent:false },
  { id:'RX-2025-006', customer:'Arjun Rao', phone:'8877665544', age:38, gender:'Male', doctor:'Dr. Priya Mehta', qualification:'MBBS DNB', registration:'MCI-2016-75319', hospital:'Manipal Hospital, Bangalore', date:'22 Jul 2025', status:'Rejected', medicines:['Tramadol 50mg (x20)'], notes:'Expired prescription', urgent:false }
];

let selectedRxId = null;

function renderRxTable(data) {
  document.getElementById('rxCountLabel').textContent = `Showing ${data.length} prescription${data.length === 1 ? '' : 's'}`;
  document.getElementById('rxEmptyState').hidden = data.length > 0;
  const statusMap = { Pending:'badge-warning', 'Under Review':'badge-info', Approved:'badge-success', Rejected:'badge-danger' };

  document.getElementById('rxTableBody').innerHTML = data.map(p => {
    const medicine = p.medicines[0].split(' - ')[0];
    return `
    <tr class="${p.id === selectedRxId ? 'is-selected' : ''}" style="cursor:pointer" onclick="selectRx('${p.id}')">
      <td class="fw-700 text-primary">${p.id}</td>
      <td><div><strong>${p.customer}</strong></div><small class="text-muted">${p.phone}</small></td>
      <td><div>${medicine}</div><small class="text-muted">${p.medicines.length} items</small></td>
      <td class="text-muted small">${p.date}</td>
      <td><span class="badge-custom ${statusMap[p.status]||'badge-info'}">${p.status}</span></td>
      <td><button type="button" class="btn btn-sm btn-outline-primary-custom" onclick="event.stopPropagation(); selectRx('${p.id}')">Review <i class="bi bi-arrow-right ms-1"></i></button></td>
    </tr>`;
  }).join('');
}

function selectRx(id) {
  selectedRxId = id;
  const p = prescriptions.find(x => x.id === id);
  if (!p) return;
  renderRxTable(prescriptions);

  document.getElementById('rxDetails').innerHTML = `
    <div class="p-3 border-bottom d-flex justify-content-between align-items-center">
      <div>
        <span class="badge-custom badge-primary mb-1">${p.id}</span>
        <h5 class="fw-700 mb-0">${p.customer}</h5>
      </div>
      <span class="badge-custom ${p.status==='Approved'?'badge-success':p.status==='Rejected'?'badge-danger':'badge-warning'}">${p.status}</span>
    </div>
    <div class="p-3">
      <div class="mb-3">
        <label class="text-muted small fw-600">Prescribing Doctor</label>
        <div class="fw-600">${p.doctor} (${p.qualification||'MBBS'})</div>
        <small class="text-muted">${p.hospital}</small>
      </div>
      <div class="mb-3">
        <label class="text-muted small fw-600">Medicines</label>
        <div class="d-flex flex-column gap-2 mt-1">
          ${p.medicines.map(m => `<div class="p-2 rounded bg-light border small"><i class="bi bi-capsule me-2 text-primary"></i><strong>${m}</strong></div>`).join('')}
        </div>
      </div>
      <div class="d-flex gap-2 mt-4">
        <button type="button" class="btn btn-success-custom flex-fill fw-600" onclick="updateRxStatus('${p.id}','Approved')"><i class="bi bi-check-lg me-1"></i>Approve</button>
        <button type="button" class="btn btn-danger-custom flex-fill fw-600" onclick="updateRxStatus('${p.id}','Rejected')"><i class="bi bi-x-lg me-1"></i>Reject</button>
      </div>
    </div>`;
}

function updateRxStatus(id, newStatus) {
  const p = prescriptions.find(x => x.id === id);
  if (p) {
    p.status = newStatus;
    renderRxTable(prescriptions);
    selectRx(id);
    showToast(`Prescription ${id} marked as ${newStatus}`, 'success');
  }
}

function filterRx() {
  const q = document.getElementById('rxSearch').value.toLowerCase();
  const st = document.getElementById('rxStatus').value;
  renderRxTable(prescriptions.filter(p => (!q || p.id.toLowerCase().includes(q) || p.customer.toLowerCase().includes(q)) && (!st || p.status === st)));
}

document.addEventListener('DOMContentLoaded', () => {
  document.getElementById('headerMount').innerHTML = PH_HEADER('Prescription Verification', 'Rx & Billing / Prescription Verification');
  initSidebar('phSidebar', 'phOverlay');
  renderRxTable(prescriptions);
});
</script>
</body>
</asp:Content>
