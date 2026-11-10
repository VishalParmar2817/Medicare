<%@ Page Title="Invoices — Pharmacist Portal | MediCare" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="invoices.aspx.cs" Inherits="medicare.pharmacist.invoices" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link rel="stylesheet" href="<%= ResolveUrl("~/assets/css/pharmacist.css") %>" />
  <style>
    .invoice-page-intro { display:flex; align-items:flex-end; justify-content:space-between; gap:1rem; margin-bottom:1.5rem; }
    .invoice-page-intro h1 { font-size:1.45rem; margin:0 0 .3rem; font-weight:800; color:var(--dark); }
    .invoice-page-intro p { color:var(--gray-400); margin:0; font-size:.88rem; }
    .invoice-filter-bar { display:grid; grid-template-columns:minmax(210px,1.5fr) repeat(2,minmax(140px,1fr)) minmax(230px,1.3fr) minmax(155px,1fr) auto auto; gap:.75rem; align-items:end; padding:1rem; }
    .invoice-filter-field label { display:block; color:var(--gray-400); font-size:.72rem; font-weight:700; margin-bottom:.35rem; }
    .invoice-filter-field .form-control-custom, .invoice-filter-field input { width:100%; min-height:39px; }
    .invoice-date-range { display:flex; gap:.35rem; }
    .invoice-date-range input { width:50%; min-width:135px; flex:1 1 0; }
    .invoice-filter-actions { display:flex; gap:.5rem; align-items:stretch; }
    .invoice-filter-actions .btn { white-space:nowrap; }
    .invoice-table th { white-space:nowrap; }
    .invoice-table td { vertical-align:middle; white-space:nowrap; }
    .invoice-table .customer-cell { white-space:normal; min-width:150px; }
    .invoice-action { width:31px; height:31px; padding:0; display:inline-flex; align-items:center; justify-content:center; }
    .invoice-empty { padding:2.5rem 1rem !important; text-align:center; color:var(--gray-400); }
    .invoice-detail-header { background:linear-gradient(135deg,var(--primary),#1557a6); color:#fff; }
    .invoice-detail-header .btn-close { filter:brightness(0) invert(1); }
    .invoice-detail-meta { background:var(--gray-100); border-radius:var(--radius-sm); padding:.85rem 1rem; }
    .invoice-detail-meta dt { color:var(--gray-400); font-size:.7rem; font-weight:700; text-transform:uppercase; margin-bottom:.15rem; }
    .invoice-detail-meta dd { margin:0; font-size:.84rem; font-weight:600; }
    .invoice-detail-table { font-size:.78rem; }
    .invoice-detail-table th { background:var(--gray-100); color:var(--dark-2); font-size:.68rem; text-transform:uppercase; white-space:nowrap; }
    .invoice-detail-table td, .invoice-detail-table th { padding:.65rem .55rem; }
    .invoice-summary { max-width:290px; margin-left:auto; }
    .invoice-payment { border:1px solid rgba(34,197,94,.25); background:rgba(34,197,94,.06); border-radius:var(--radius-sm); padding:.8rem 1rem; }
    @media (max-width: 1100px) { .invoice-filter-bar { grid-template-columns:repeat(3,1fr); } .invoice-filter-search, .invoice-filter-field:has(.invoice-date-range) { grid-column:span 3; } .invoice-date-range input { min-width:0; } }
    @media (max-width: 767px) { .invoice-page-intro { align-items:flex-start; flex-direction:column; } .invoice-filter-bar { grid-template-columns:1fr 1fr; } .invoice-filter-search, .invoice-filter-field:has(.invoice-date-range) { grid-column:span 2; } .invoice-filter-actions { grid-column:span 2; display:flex; gap:.5rem; } .invoice-filter-actions .btn { flex:1; } .invoice-summary { max-width:none; } }
    .invoice-detail-modal .modal-dialog { width:calc(100% - 2rem); max-width:880px; margin-left:auto; margin-right:auto; }
    @media print { body > *:not(#invoiceDrawer) { display:none !important; } #invoiceDrawer { position:static !important; display:block !important; } #invoiceDrawer .modal-dialog { max-width:none; margin:0; } #invoiceDrawer .modal-content { border:0; box-shadow:none; } #invoiceDrawer .modal-header, #invoiceDrawer .modal-body { display:block !important; } #invoiceDrawer .btn-close, .no-print { display:none !important; } }
  </style>
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
        <a class="sidebar-subnav-link " href="prescription-verification.aspx"><i class="bi bi-file-earmark-check"></i>Prescription Verification</a>
        <a class="sidebar-subnav-link " href="prescription-billing.aspx"><i class="bi bi-calculator"></i>Billing</a>
        <a class="sidebar-subnav-link active" href="invoices.aspx"><i class="bi bi-receipt"></i>Invoices</a>
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
      <div class="invoice-page-intro">
        <div>
          <h1>Invoices</h1>
          <p>View, manage and download customer invoices.</p>
        </div>
        <asp:LinkButton ID="btnOpenCreateInv" runat="server" CssClass="btn btn-primary-custom fw-600" ClientIDMode="Static" OnClientClick="var m = new bootstrap.Modal(document.getElementById('createInvoiceModal')); m.show(); return false;">
          <i class="bi bi-plus-lg me-1"></i>Create Invoice
        </asp:LinkButton>
      </div>

      <div class="row g-3 mb-4">
        <div class="col-6 col-xl-3"><div class="stat-card stat-blue"><div class="stat-icon mb-2"><i class="bi bi-receipt"></i></div><div class="stat-value"><asp:Label ID="lblTotalInvoices" runat="server" Text="1,248" ClientIDMode="Static" /></div><div class="stat-label">Total Invoices</div></div></div>
        <div class="col-6 col-xl-3"><div class="stat-card stat-green"><div class="stat-icon mb-2"><i class="bi bi-check-circle"></i></div><div class="stat-value"><asp:Label ID="lblPaidAmount" runat="server" Text="₹4,85,600" ClientIDMode="Static" /></div><div class="stat-label">Paid</div></div></div>
        <div class="col-6 col-xl-3"><div class="stat-card stat-orange"><div class="stat-icon mb-2"><i class="bi bi-hourglass-split"></i></div><div class="stat-value"><asp:Label ID="lblPendingAmount" runat="server" Text="₹32,450" ClientIDMode="Static" /></div><div class="stat-label">Pending</div></div></div>
        <div class="col-6 col-xl-3"><div class="stat-card stat-cyan"><div class="stat-icon mb-2"><i class="bi bi-arrow-counterclockwise"></i></div><div class="stat-value"><asp:Label ID="lblRefundedAmount" runat="server" Text="₹8,200" ClientIDMode="Static" /></div><div class="stat-label">Refunded</div></div></div>
      </div>

      <div class="data-card invoice-filter-bar mb-4">
        <div class="invoice-filter-field invoice-filter-search">
          <label for="invoiceSearch">Search invoice / customer</label>
          <div class="search-bar"><i class="bi bi-search"></i><asp:TextBox ID="invoiceSearch" runat="server" CssClass="form-control-custom" placeholder="INV-2026-00125 or customer" ClientIDMode="Static" /></div>
        </div>
        <div class="invoice-filter-field">
          <label for="paymentStatus">Payment status</label>
          <asp:DropDownList ID="paymentStatus" runat="server" CssClass="form-control-custom" ClientIDMode="Static">
            <asp:ListItem Value="">All payments</asp:ListItem>
            <asp:ListItem Value="Paid">Paid</asp:ListItem>
            <asp:ListItem Value="Pending">Pending</asp:ListItem>
            <asp:ListItem Value="Refunded">Refunded</asp:ListItem>
          </asp:DropDownList>
        </div>
        <div class="invoice-filter-field">
          <label for="invoiceStatus">Invoice status</label>
          <asp:DropDownList ID="invoiceStatus" runat="server" CssClass="form-control-custom" ClientIDMode="Static">
            <asp:ListItem Value="">All statuses</asp:ListItem>
            <asp:ListItem Value="Paid">Paid</asp:ListItem>
            <asp:ListItem Value="Pending">Pending</asp:ListItem>
            <asp:ListItem Value="Refunded">Refunded</asp:ListItem>
            <asp:ListItem Value="Cancelled">Cancelled</asp:ListItem>
          </asp:DropDownList>
        </div>
        <div class="invoice-filter-field">
          <label>Date range</label>
          <div class="invoice-date-range">
            <asp:TextBox ID="dateFrom" runat="server" TextMode="Date" CssClass="form-control-custom" aria-label="From date" ClientIDMode="Static" />
            <asp:TextBox ID="dateTo" runat="server" TextMode="Date" CssClass="form-control-custom" aria-label="To date" ClientIDMode="Static" />
          </div>
        </div>
        <div class="invoice-filter-field">
          <label for="paymentMethod">Payment method</label>
          <asp:DropDownList ID="paymentMethod" runat="server" CssClass="form-control-custom" ClientIDMode="Static">
            <asp:ListItem Value="">All methods</asp:ListItem>
            <asp:ListItem Value="UPI">UPI</asp:ListItem>
            <asp:ListItem Value="Card">Card</asp:ListItem>
            <asp:ListItem Value="Cash">Cash</asp:ListItem>
            <asp:ListItem Value="Net Banking">Net Banking</asp:ListItem>
          </asp:DropDownList>
        </div>
        <div class="invoice-filter-actions">
          <asp:LinkButton ID="filterInvoices" runat="server" CssClass="btn btn-primary-custom fw-600" ClientIDMode="Static" OnClick="filterInvoices_Click">
            <i class="bi bi-funnel me-1"></i>Filter
          </asp:LinkButton>
          <asp:LinkButton ID="clearFilters" runat="server" CssClass="btn btn-outline-primary-custom fw-600" ClientIDMode="Static" OnClick="clearFilters_Click">
            Clear
          </asp:LinkButton>
        </div>
      </div>

      <section class="data-card">
        <div class="data-card-header">
          <div>
            <h2 class="data-card-title mb-1"><i class="bi bi-file-earmark-text text-primary me-2"></i>Customer invoices</h2>
            <asp:Label ID="invoiceCount" runat="server" CssClass="text-muted small" ClientIDMode="Static" Text="Showing 8 of 1,248 invoices" />
          </div>
          <asp:LinkButton ID="exportInvoices" runat="server" CssClass="btn btn-outline-primary-custom fw-600" ClientIDMode="Static" OnClick="exportInvoices_Click">
            <i class="bi bi-download me-1"></i>Export
          </asp:LinkButton>
        </div>
        <div class="table-wrap">
          <asp:GridView ID="gvInvoices" runat="server"
              AutoGenerateColumns="False"
              OnRowCommand="gvInvoices_RowCommand"
              CssClass="table-custom invoice-table"
              ClientIDMode="Static">
            <Columns>
              <asp:TemplateField HeaderText="Invoice No.">
                <ItemTemplate>
                  <span class="fw-700 text-primary"><%# Eval("InvoiceNo") %></span>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Order ID">
                <ItemTemplate>
                  <span class="text-muted small"><%# Eval("OrderCode") %></span>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Customer" ItemStyle-CssClass="customer-cell">
                <ItemTemplate>
                  <div class="fw-600"><%# Eval("CustomerName") %></div>
                  <small class="text-muted"><%# Eval("CustomerPhone") %></small>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Date">
                <ItemTemplate>
                  <span class="text-muted small"><%# Eval("InvoiceDate", "{0:dd MMM yyyy}") %></span>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:BoundField DataField="ItemsCount" HeaderText="Items" />

              <asp:TemplateField HeaderText="Amount">
                <ItemTemplate>
                  <span class="fw-700">₹<%# Eval("TotalAmount", "{0:N2}") %></span>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Payment">
                <ItemTemplate>
                  <span class="badge-custom badge-info"><%# Eval("PaymentMethod") %></span>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                  <span class="badge-custom"><%# Eval("Status") %></span>
                </ItemTemplate>
              </asp:TemplateField>

              <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                  <div class="d-flex gap-1">
                    <asp:LinkButton ID="btnViewInv" runat="server" CommandName="cmd_view" CommandArgument='<%# Eval("InvoiceId") %>' CssClass="btn btn-sm btn-outline-primary-custom invoice-action" ToolTip="View">
                      <i class="bi bi-eye"></i>
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnPrintInv" runat="server" CommandName="cmd_print" CommandArgument='<%# Eval("InvoiceId") %>' CssClass="btn btn-sm btn-outline-primary-custom invoice-action" ToolTip="Print">
                      <i class="bi bi-printer"></i>
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnDownloadInv" runat="server" CommandName="cmd_download" CommandArgument='<%# Eval("InvoiceId") %>' CssClass="btn btn-sm btn-outline-primary-custom invoice-action" ToolTip="Download">
                      <i class="bi bi-download"></i>
                    </asp:LinkButton>
                  </div>
                </ItemTemplate>
              </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
              <div class="invoice-empty">
                <i class="bi bi-search fs-3 d-block mb-2"></i>No invoices match the selected filters.
              </div>
            </EmptyDataTemplate>
          </asp:GridView>
        </div>
        <div class="data-card-footer d-flex justify-content-between align-items-center gap-2 flex-wrap">
          <span class="text-muted small">Showing invoices</span>
        </div>
      </section>
    </main>
  </div>
</div>

<!-- Invoice Drawer Modal -->
<div class="modal fade modal-custom invoice-detail-modal" tabindex="-1" id="invoiceDrawer" aria-labelledby="invoiceDrawerLabel">
  <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header invoice-detail-header">
        <div><div class="small opacity-75">Invoice details</div><h2 class="h5 mb-0" id="invoiceDrawerLabel">INV-2026-00125</h2></div>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="invoiceDetailBody"></div>
    </div>
  </div>
</div>

<!-- Create Invoice Modal -->
<div class="modal fade modal-custom" id="createInvoiceModal" tabindex="-1" aria-labelledby="createInvoiceTitle">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h2 class="modal-title h5 fw-700" id="createInvoiceTitle"><i class="bi bi-receipt-cutoff text-primary me-2"></i>Create Invoice</h2>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="alert alert-light border small mb-3"><i class="bi bi-info-circle text-primary me-2"></i>Complete customer and order details to generate an invoice.</div>
        <div class="row g-3">
          <div class="col-md-6">
            <label class="form-label fw-600 small" for="newCustomer">Customer name <span class="text-danger">*</span></label>
            <asp:TextBox ID="newCustomer" runat="server" CssClass="form-control form-control-custom" ClientIDMode="Static" />
          </div>
          <div class="col-md-6">
            <label class="form-label fw-600 small" for="newOrder">Order ID <span class="text-danger">*</span></label>
            <asp:TextBox ID="newOrder" runat="server" CssClass="form-control form-control-custom" placeholder="ORD-2026-00000" ClientIDMode="Static" />
          </div>
          <div class="col-md-6">
            <label class="form-label fw-600 small" for="newAmount">Amount (₹) <span class="text-danger">*</span></label>
            <div class="input-group">
              <span class="input-group-text">₹</span>
              <asp:TextBox ID="newAmount" runat="server" TextMode="Number" CssClass="form-control form-control-custom" ClientIDMode="Static" />
            </div>
          </div>
          <div class="col-md-6">
            <label class="form-label fw-600 small" for="newPayment">Payment method</label>
            <asp:DropDownList ID="newPayment" runat="server" CssClass="form-control form-control-custom" ClientIDMode="Static">
              <asp:ListItem>UPI</asp:ListItem>
              <asp:ListItem>Card</asp:ListItem>
              <asp:ListItem>Cash</asp:ListItem>
              <asp:ListItem>Net Banking</asp:ListItem>
            </asp:DropDownList>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <asp:Button ID="btnCreateInvoiceSubmit" runat="server" Text="Create Invoice" CssClass="btn btn-primary-custom fw-600" ClientIDMode="Static" OnClick="btnCreateInvoiceSubmit_Click" />
      </div>
    </div>
  </div>
</div>

<div id="toast-container"></div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="../assets/js/main.js"></script>
<script src="../assets/js/pharmacist.js"></script>
<script>
const invoiceRows = [
  { id:'INV-2026-00125', order:'ORD-2026-00482', customer:'Priya Sharma', date:'04 Sep 2026', items:3, amount:215, payment:'UPI', status:'Paid', phone:'+91 98765 43210' },
  { id:'INV-2026-00124', order:'ORD-2026-00481', customer:'Rahul Mehta', date:'04 Sep 2026', items:2, amount:1240, payment:'Card', status:'Paid', phone:'+91 91234 56789' },
  { id:'INV-2026-00123', order:'ORD-2026-00479', customer:'Anita Singh', date:'03 Sep 2026', items:4, amount:860, payment:'UPI', status:'Pending', phone:'+91 98760 12345' },
  { id:'INV-2026-00122', order:'ORD-2026-00475', customer:'Vikram Patel', date:'02 Sep 2026', items:1, amount:450, payment:'Cash', status:'Refunded', phone:'+91 90001 23456' },
  { id:'INV-2026-00121', order:'ORD-2026-00471', customer:'Neha Gupta', date:'01 Sep 2026', items:5, amount:2180, payment:'Card', status:'Paid', phone:'+91 99887 76655' },
  { id:'INV-2026-00120', order:'ORD-2026-00468', customer:'Arjun Rao', date:'31 Aug 2026', items:2, amount:675, payment:'UPI', status:'Cancelled', phone:'+91 88776 65544' },
  { id:'INV-2026-00119', order:'ORD-2026-00465', customer:'Sunita Desai', date:'30 Aug 2026', items:3, amount:980, payment:'Net Banking', status:'Paid', phone:'+91 77665 54433' },
  { id:'INV-2026-00118', order:'ORD-2026-00461', customer:'Kiran Joshi', date:'29 Aug 2026', items:2, amount:520, payment:'UPI', status:'Pending', phone:'+91 66554 43322' }
];
const statusClasses = { Paid:'badge-success', Pending:'badge-warning', Refunded:'badge-info', Cancelled:'badge-danger' };
const money = value => '₹' + Number(value).toLocaleString('en-IN');
const safe = value => String(value).replace(/[&<>"']/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));

function renderInvoices(rows) {
  const tbody = document.getElementById('invoiceTableBody');
  if (tbody) {
    tbody.innerHTML = rows.length ? rows.map(invoice => `
      <tr>
        <td class="fw-700 text-primary">${safe(invoice.id)}</td>
        <td class="text-muted small">${safe(invoice.order)}</td>
        <td class="customer-cell"><div class="fw-600">${safe(invoice.customer)}</div><small class="text-muted">${safe(invoice.phone)}</small></td>
        <td class="text-muted small">${safe(invoice.date)}</td>
        <td>${invoice.items}</td>
        <td class="fw-700">${money(invoice.amount)}</td>
        <td><span class="badge-custom badge-info">${safe(invoice.payment)}</span></td>
        <td><span class="badge-custom ${statusClasses[invoice.status]}">${safe(invoice.status)}</span></td>
        <td>
          <div class="d-flex gap-1">
            <button type="button" class="btn btn-sm btn-outline-primary-custom invoice-action" title="View" onclick="viewInvoice('${safe(invoice.id)}')"><i class="bi bi-eye"></i></button>
            <button type="button" class="btn btn-sm btn-outline-primary-custom invoice-action" title="Print" onclick="printInvoice('${safe(invoice.id)}')"><i class="bi bi-printer"></i></button>
            <button type="button" class="btn btn-sm btn-outline-primary-custom invoice-action" title="Download" onclick="downloadInvoice('${safe(invoice.id)}')"><i class="bi bi-download"></i></button>
          </div>
        </td>
      </tr>`).join('') : '<tr><td colspan="9" class="invoice-empty"><i class="bi bi-search fs-3 d-block mb-2"></i>No invoices match the selected filters.</td></tr>';
  }
  const countEl = document.getElementById('invoiceCount');
  if (countEl) {
    countEl.textContent = `Showing ${rows.length} of 1,248 invoices`;
  }
}

function getFilteredInvoices() {
  const query = document.getElementById('invoiceSearch').value.trim().toLowerCase();
  const payment = document.getElementById('paymentStatus').value;
  const status = document.getElementById('invoiceStatus').value;
  const method = document.getElementById('paymentMethod').value;
  const from = document.getElementById('dateFrom').value;
  const to = document.getElementById('dateTo').value;
  return invoiceRows.filter(invoice => {
    const invoiceDate = new Date(invoice.date);
    const dateMatches = (!from || invoiceDate >= new Date(from)) && (!to || invoiceDate <= new Date(to + 'T23:59:59'));
    return dateMatches && (!query || [invoice.id, invoice.order, invoice.customer].some(value => value.toLowerCase().includes(query))) && (!payment || invoice.status === payment) && (!status || invoice.status === status) && (!method || invoice.payment === method);
  });
}

function applyInvoiceFilters() {
  const rows = getFilteredInvoices();
  renderInvoices(rows);
  showToast(`${rows.length} invoice${rows.length === 1 ? '' : 's'} found`, 'info');
}

function viewInvoice(id) {
  const invoice = invoiceRows.find(row => row.id === id);
  if (!invoice) return;
  document.getElementById('invoiceDrawerLabel').textContent = invoice.id;
  document.getElementById('invoiceDetailBody').innerHTML = `
    <div id="invoicePrintArea">
      <div class="d-flex justify-content-between align-items-start mb-3">
        <div>
          <span class="badge-custom ${statusClasses[invoice.status]} mb-2">${safe(invoice.status.toUpperCase())}</span>
          <div class="small text-muted">${safe(invoice.date)} · ${safe(invoice.order)}</div>
        </div>
        <div class="text-end">
          <div class="fw-800 text-primary fs-5">${money(invoice.amount)}</div>
          <small class="text-muted">Grand total</small>
        </div>
      </div>
      <div class="invoice-detail-meta mb-4">
        <div class="row g-3">
          <div class="col-6"><dl class="mb-0"><dt>Pharmacy</dt><dd>MediCare Pharmacy</dd></dl></div>
          <div class="col-6"><dl class="mb-0"><dt>GSTIN</dt><dd>27AABCU9603R1ZN</dd></dl></div>
          <div class="col-6"><dl class="mb-0"><dt>Customer</dt><dd>${safe(invoice.customer)}</dd></dl></div>
          <div class="col-6"><dl class="mb-0"><dt>Phone</dt><dd>${safe(invoice.phone)}</dd></dl></div>
        </div>
      </div>
      <div class="table-wrap mb-3">
        <table class="table invoice-detail-table mb-0">
          <thead><tr><th>Medicine</th><th>Batch</th><th>Qty</th><th>MRP</th><th>Discount</th><th>Tax</th><th class="text-end">Amount</th></tr></thead>
          <tbody>
            <tr><td class="fw-600">Paracetamol 500mg</td><td>PCM26A04</td><td>2</td><td>₹90</td><td>-₹10</td><td>₹4</td><td class="text-end">₹84</td></tr>
            <tr><td class="fw-600">Vitamin D3 1000IU</td><td>VD26B11</td><td>1</td><td>₹135</td><td>-₹10</td><td>₹6</td><td class="text-end">₹131</td></tr>
          </tbody>
        </table>
      </div>
      <div class="invoice-summary mb-3">
        <div class="d-flex justify-content-between small mb-2"><span class="text-muted">Subtotal</span><span>₹225</span></div>
        <div class="d-flex justify-content-between small mb-2"><span class="text-muted">Discount</span><span class="text-success">-₹20</span></div>
        <div class="d-flex justify-content-between small mb-2"><span class="text-muted">Tax / GST</span><span>₹10</span></div>
        <hr>
        <div class="d-flex justify-content-between fw-800"><span>Grand Total</span><span class="text-primary">${money(invoice.amount)}</span></div>
      </div>
    </div>
    <div class="d-flex gap-2 mt-4 no-print">
      <button type="button" class="btn btn-outline-primary-custom flex-fill" onclick="printInvoice('${safe(invoice.id)}')"><i class="bi bi-printer me-1"></i>Print</button>
      <button type="button" class="btn btn-primary-custom flex-fill" onclick="downloadInvoice('${safe(invoice.id)}')"><i class="bi bi-download me-1"></i>Download</button>
    </div>`;
  new bootstrap.Modal(document.getElementById('invoiceDrawer')).show();
}

function printInvoice(id) { window.print(); }
function downloadInvoice(id) { showToast(`Invoice ${id} download started`, 'success'); }

document.addEventListener('DOMContentLoaded', () => {
  document.getElementById('headerMount').innerHTML = PH_HEADER('Invoices', 'Rx & Billing / Invoices');
  initSidebar('phSidebar', 'phOverlay');

  renderInvoices(invoiceRows);
  document.getElementById('filterInvoices').addEventListener('click', applyInvoiceFilters);
  document.getElementById('invoiceSearch').addEventListener('input', applyInvoiceFilters);
  document.getElementById('clearFilters').addEventListener('click', () => {
    document.getElementById('invoiceSearch').value = '';
    document.getElementById('paymentStatus').value = '';
    document.getElementById('invoiceStatus').value = '';
    document.getElementById('paymentMethod').value = '';
    document.getElementById('dateFrom').value = '';
    document.getElementById('dateTo').value = '';
    renderInvoices(invoiceRows);
    showToast('Filters cleared', 'info');
  });
  document.getElementById('exportInvoices').addEventListener('click', () => showToast('Invoice export prepared', 'success'));
});
</script>
</body>
</asp:Content>
