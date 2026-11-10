<%@ Page Title="Rx & Billing — Pharmacist Portal | MediCare" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="prescription-billing.aspx.cs" Inherits="medicare.pharmacist.prescriptionBilling" %>

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
      <a class="sidebar-nav-link active" href="prescription-billing.aspx">
        <i class="bi bi-file-medical-fill"></i>Rx &amp; Billing
        <span class="nav-badge">3</span>
      </a>
      <div class="sidebar-subnav">
        <a class="sidebar-subnav-link " href="prescription-verification.aspx"><i class="bi bi-file-earmark-check"></i>Prescription Verification</a>
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
      <!-- Workflow Steps -->
      <div class="rx-workflow-steps mb-4">
        <div class="rx-workflow-step done" id="ws1">
          <div class="rx-step-circle"><i class="bi bi-check-lg"></i></div>
          <div class="rx-step-label">Queue</div>
        </div>
        <div class="rx-workflow-step active" id="ws2">
          <div class="rx-step-circle"><i class="bi bi-file-medical"></i></div>
          <div class="rx-step-label">Verify Rx</div>
        </div>
        <div class="rx-workflow-step" id="ws3">
          <div class="rx-step-circle"><i class="bi bi-capsule"></i></div>
          <div class="rx-step-label">Select Medicines</div>
        </div>
        <div class="rx-workflow-step" id="ws4">
          <div class="rx-step-circle"><i class="bi bi-receipt"></i></div>
          <div class="rx-step-label">Generate Bill</div>
        </div>
        <div class="rx-workflow-step" id="ws5">
          <div class="rx-step-circle"><i class="bi bi-printer"></i></div>
          <div class="rx-step-label">Print Invoice</div>
        </div>
      </div>

      <!-- Main Two-Column View -->
      <div class="row g-3">
        <!-- Prescription Queue & Viewer -->
        <div class="col-lg-6">
          <div class="data-card mb-3">
            <div class="data-card-header">
              <div class="data-card-title"><i class="bi bi-file-medical text-primary me-2"></i>Active Prescriptions</div>
              <span class="badge-custom badge-warning" id="pendingBadge">3 Pending</span>
            </div>
            <div class="table-wrap">
              <asp:GridView ID="gvPrescriptions" runat="server" AutoGenerateColumns="False"
                OnRowCommand="gvPrescriptions_RowCommand" CssClass="table table-bordered table-striped"
                ClientIDMode="Static">
                <Columns>
                  <asp:TemplateField HeaderText="Rx ID">
                    <ItemTemplate>
                      <span class="fw-700 text-primary"><%# Eval("PrescriptionCode") != null ? Eval("PrescriptionCode") : ("#RX-" + Eval("PrescriptionID")) %></span>
                    </ItemTemplate>
                  </asp:TemplateField>

                  <asp:TemplateField HeaderText="Customer">
                    <ItemTemplate>
                      <%# Eval("CustomerName") %>
                    </ItemTemplate>
                  </asp:TemplateField>

                  <asp:TemplateField HeaderText="Date">
                    <ItemTemplate>
                      <span class="text-muted small"><%# Eval("CreatedAt", "{0:dd-MMM-yyyy}") %></span>
                    </ItemTemplate>
                  </asp:TemplateField>

                  <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                      <span class='badge-custom <%# Eval("Status") != null && Eval("Status").ToString() == "Approved" ? "badge-success" : "badge-warning" %>'>
                        <%# Eval("Status") %>
                      </span>
                    </ItemTemplate>
                  </asp:TemplateField>

                  <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>
                      <asp:LinkButton ID="btnSelectRx" runat="server" CommandName="cmd_select"
                        CommandArgument='<%# Eval("PrescriptionID") %>' CssClass="btn btn-sm btn-outline-primary-custom">
                        Select
                      </asp:LinkButton>
                    </ItemTemplate>
                  </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                  <div class="text-center py-3 text-muted small">No pending prescriptions in queue.</div>
                </EmptyDataTemplate>
              </asp:GridView>
            </div>
          </div>

          <!-- Rx Document Viewer -->
          <div class="data-card" id="rxViewerCard">
            <div class="data-card-header">
              <div class="data-card-title" id="activeRxTitle">Prescription Details</div>
              <div class="d-flex gap-2">
                <asp:LinkButton ID="btnApproveCurrentRx" runat="server" CssClass="btn btn-sm btn-success-custom fw-600" OnClick="btnApproveCurrentRx_Click" ClientIDMode="Static">
                  <i class="bi bi-check-lg me-1"></i>Approve
                </asp:LinkButton>
                <button type="button" class="btn btn-sm btn-danger-custom fw-600" data-bs-toggle="modal" data-bs-target="#rejectModal"><i class="bi bi-x-lg me-1"></i>Reject</button>
              </div>
            </div>
            <div class="p-4" id="rxDetailsBox"></div>
          </div>
        </div>

        <!-- Billing Itemization Box -->
        <div class="col-lg-6">
          <div class="data-card">
            <div class="data-card-header">
              <div class="data-card-title"><i class="bi bi-calculator text-primary me-2"></i>Billing & Medicine Allocation</div>
              <button type="button" class="btn btn-sm btn-outline-primary-custom" onclick="addCustomBillItem()"><i class="bi bi-plus me-1"></i>Add Item</button>
            </div>
            <div class="p-4">
              <div class="table-wrap mb-3">
                <table class="table-custom">
                  <thead><tr><th>Medicine</th><th>Batch</th><th>Qty</th><th>Price</th><th>Total</th><th></th></tr></thead>
                  <tbody id="billItemsBody"></tbody>
                </table>
              </div>
              <div class="d-flex justify-content-between align-items-center border-top pt-3 mb-4">
                <div class="text-muted small">Total Billing Amount (incl. taxes)</div>
                <div class="fw-800 fs-4 text-primary" id="billTotalAmount">₹0.00</div>
              </div>
              <div class="d-flex gap-2 justify-content-end">
                <button type="button" class="btn btn-outline-primary-custom fw-600" onclick="previewInvoice()"><i class="bi bi-eye me-1"></i>Preview Invoice</button>
                <asp:LinkButton ID="btnFinalizeBill" runat="server" CssClass="btn btn-primary-custom fw-600" OnClick="btnFinalizeBill_Click" ClientIDMode="Static">
                  <i class="bi bi-receipt me-1"></i>Finalize & Generate
                </asp:LinkButton>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</div>

<!-- Reject Reason Modal -->
<div class="modal fade modal-custom" id="rejectModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered modal-sm">
    <div class="modal-content">
      <div class="modal-header"><h5 class="modal-title fw-700"><i class="bi bi-x-circle-fill text-danger me-2"></i>Reject Prescription</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
      <div class="modal-body">
        <label class="form-label fw-600 small mb-1">Reason for Rejection</label>
        <asp:DropDownList ID="rejectReason" runat="server" CssClass="form-control form-control-custom mb-2" ClientIDMode="Static">
          <asp:ListItem Text="Prescription expired"></asp:ListItem>
          <asp:ListItem Text="Illegible handwriting"></asp:ListItem>
          <asp:ListItem Text="Incorrect dosage"></asp:ListItem>
          <asp:ListItem Text="Controlled substance – needs verification"></asp:ListItem>
          <asp:ListItem Text="Other"></asp:ListItem>
        </asp:DropDownList>
        <asp:TextBox ID="txtRejectNotes" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control form-control-custom" placeholder="Additional notes (optional)..." ClientIDMode="Static" />
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <asp:LinkButton ID="btnRejectRx" runat="server" CssClass="btn btn-danger-custom fw-600" OnClick="btnRejectRx_Click" ClientIDMode="Static">
          <i class="bi bi-x-circle me-1"></i>Reject
        </asp:LinkButton>
      </div>
    </div>
  </div>
</div>

<!-- Print Invoice Modal -->
<div class="modal fade modal-custom" id="invoiceModal" tabindex="-1" style="--bs-modal-width:860px">
  <div class="modal-dialog modal-dialog-centered modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title fw-700"><i class="bi bi-receipt me-2"></i>Invoice Preview</h5>
        <div class="ms-auto d-flex gap-2 me-3">
          <button type="button" class="btn btn-sm btn-outline-primary-custom" onclick="window.print()"><i class="bi bi-printer me-1"></i>Print</button>
          <button type="button" class="btn btn-sm btn-secondary-custom" onclick="showToast('Invoice saved as PDF','success')"><i class="bi bi-download me-1"></i>Save PDF</button>
        </div>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body p-4" id="invoiceContent"></div>
    </div>
  </div>
</div>

<div id="toast-container"></div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="../assets/js/main.js"></script>
<script src="../assets/js/pharmacist.js"></script>
<script>
const rxQueue = [
  { id:'RX-0087', date:'2026-09-04', time:'10:30 AM', customer:'Priya Sharma', phone:'+91 98765 43210', age:32, doctor:'Dr. Ramesh Gupta', hospital:'City General Hospital', medicines:['Amoxicillin 500mg (×2)','Paracetamol 500mg (×3)','Cetirizine 10mg (×1)'], status:'Pending', notes:'Patient has mild penicillin sensitivity.' },
  { id:'RX-0088', date:'2026-09-04', time:'11:15 AM', customer:'Rahul Mehta', phone:'+91 87654 32109', age:45, doctor:'Dr. Sunita Rao', hospital:'Apollo Clinic', medicines:['Atorvastatin 20mg (×1)','Metformin 500mg (×2)'], status:'Pending', notes:'Routine monthly prescription refill.' },
  { id:'RX-0089', date:'2026-09-03', time:'01:48 PM', customer:'Anita Singh', phone:'+91 76543 21098', age:28, doctor:'Dr. Vikram Patel', hospital:'LifeCare Hospital', medicines:['Doxycycline 100mg (×1)','Ibuprofen 400mg (×2)'], status:'Approved', notes:'' }
];

let currentRx = rxQueue[0];
let billItems = [
  { name: 'Paracetamol 500mg', batch: 'PCM26A04', qty: 2, price: 45 },
  { name: 'Amoxicillin 500mg', batch: 'AMX26B01', qty: 2, price: 120 }
];

function renderRxQueue() {
  document.getElementById('rxQueueBody').innerHTML = rxQueue.map(r => `
    <tr style="cursor:pointer" onclick="selectRx('${r.id}')">
      <td class="fw-700 text-primary">${r.id}</td>
      <td><div><strong>${r.customer}</strong></div><small class="text-muted">${r.phone}</small></td>
      <td class="text-muted small">${r.date}</td>
      <td><span class="badge-custom ${r.status==='Approved'?'badge-success':'badge-warning'}">${r.status}</span></td>
      <td><button type="button" class="btn btn-sm btn-outline-primary-custom" onclick="event.stopPropagation(); selectRx('${r.id}')">View</button></td>
    </tr>`).join('');
}

function selectRx(id) {
  const r = rxQueue.find(x => x.id === id);
  if (!r) return;
  currentRx = r;
  document.getElementById('activeRxTitle').textContent = 'Prescription #' + r.id;
  document.getElementById('rxDetailsBox').innerHTML = `
    <div class="mb-3">
      <h6 class="fw-700 text-primary"><i class="bi bi-person me-1"></i>Patient: ${r.customer} (${r.age} yrs)</h6>
      <small class="text-muted">Doctor: ${r.doctor} | ${r.hospital}</small>
    </div>
    <div class="mb-3">
      <label class="fw-600 small text-muted">Prescribed Items:</label>
      <div class="d-flex flex-column gap-1 mt-1">
        ${r.medicines.map(m => `<div class="p-2 bg-light rounded border small">💊 ${m}</div>`).join('')}
      </div>
    </div>
    ${r.notes ? `<div class="alert alert-warning small mb-0"><i class="bi bi-exclamation-triangle me-1"></i>${r.notes}</div>` : ''}
  `;
}

function renderBill() {
  const tbody = document.getElementById('billItemsBody');
  let total = 0;
  tbody.innerHTML = billItems.map((item, idx) => {
    const sub = item.qty * item.price;
    total += sub;
    return `
      <tr>
        <td class="fw-600">${item.name}</td>
        <td><code>${item.batch}</code></td>
        <td>${item.qty}</td>
        <td>₹${item.price}</td>
        <td class="fw-700">₹${sub}</td>
        <td><button type="button" class="btn btn-sm btn-danger-custom py-0 px-1" onclick="removeBillItem(${idx})"><i class="bi bi-trash"></i></button></td>
      </tr>`;
  }).join('');
  document.getElementById('billTotalAmount').textContent = '₹' + total.toFixed(2);
}

function removeBillItem(idx) {
  billItems.splice(idx, 1);
  renderBill();
}

function addCustomBillItem() {
  billItems.push({ name: 'Cetirizine 10mg', batch: 'CTZ26C08', qty: 1, price: 35 });
  renderBill();
  showToast('Item added to bill', 'info');
}

function approveCurrentRx() {
  if (currentRx) {
    currentRx.status = 'Approved';
    renderRxQueue();
    selectRx(currentRx.id);
    showToast('Prescription approved for billing', 'success');
  }
}

function rejectRx() {
  if (currentRx) {
    currentRx.status = 'Rejected';
    renderRxQueue();
    bootstrap.Modal.getInstance(document.getElementById('rejectModal')).hide();
    showToast('Prescription rejected', 'warning');
  }
}

function previewInvoice() {
  let total = billItems.reduce((s,i) => s + (i.qty * i.price), 0);
  document.getElementById('invoiceContent').innerHTML = `
    <div class="text-center pb-3 border-bottom mb-3">
      <h4 class="fw-800 text-primary mb-1">MediCare Pharmacy</h4>
      <p class="text-muted small mb-0">123 Health Street, Mumbai | GSTIN: 27AABCU9603R1ZN</p>
    </div>
    <div class="d-flex justify-content-between small mb-3">
      <div><strong>Customer:</strong> ${currentRx.customer}<br><strong>Ref Rx:</strong> ${currentRx.id}</div>
      <div class="text-end"><strong>Date:</strong> ${new Date().toLocaleDateString()}<br><strong>Invoice:</strong> INV-${Date.now().toString().slice(-6)}</div>
    </div>
    <table class="table-custom mb-3">
      <thead><tr><th>Medicine</th><th>Batch</th><th>Qty</th><th>Rate</th><th>Total</th></tr></thead>
      <tbody>${billItems.map(b => `<tr><td>${b.name}</td><td>${b.batch}</td><td>${b.qty}</td><td>₹${b.price}</td><td>₹${b.qty*b.price}</td></tr>`).join('')}</tbody>
    </table>
    <div class="text-end fw-800 fs-5">Total: ₹${total.toFixed(2)}</div>
  `;
  new bootstrap.Modal(document.getElementById('invoiceModal')).show();
}

function finalizeBill() {
  showToast('Bill finalized and invoice generated!', 'success');
}

document.addEventListener('DOMContentLoaded', () => {
  document.getElementById('headerMount').innerHTML = PH_HEADER('Prescription & Billing', 'Rx & Billing');
  initSidebar('phSidebar', 'phOverlay');

  renderRxQueue();
  selectRx('RX-0087');
  renderBill();
});
</script>
</body>
</asp:Content>
