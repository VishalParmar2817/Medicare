<%@ Page Title="Inventory Management — Pharmacist Portal | MediCare" Language="C#" MasterPageFile="~/Site1.Master"
  AutoEventWireup="true" CodeBehind="inventory.aspx.cs" Inherits="medicare.admin.inventory" %>

  <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  </asp:Content>
  <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  </asp:Content>
  <asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
  </asp:Content>
  <asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">

    <body>
      <div class="ph-layout">
        <!-- ══ PHARMACIST SIDEBAR ═══════════════════════════════════════ -->
       <aside class="ph-sidebar admin-sidebar" id="adminSidebar">
    <div class="sidebar-brand">
        <div class="sidebar-brand-icon"><i class="bi bi-capsule-pill"></i></div>
        <div class="sidebar-brand-text">MediCare<span>Admin Panel</span></div>
    </div>
    <div class="sidebar-user">
        <div class="avatar avatar-sm" style="background: linear-gradient(135deg,#8B5CF6,#7C3AED)">SA</div>
        <div class="sidebar-user-info">
            <div class="sidebar-user-name">Super Admin</div>
            <div class="sidebar-user-role">System Administrator</div>
        </div>
    </div>
    <nav class="sidebar-nav">
        <div class="sidebar-label">Overview</div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link " href="dashboard.aspx">
                <i class="bi bi-speedometer2"></i>Dashboard
            </a>
        </div>

        <%-- <div class="sidebar-label">User Management</div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link " href="users.aspx"><i
                class="bi bi-person-gear"></i>Users</a>
        </div>--%>

        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link" href="customers.aspx">
                <i class="bi bi-people"></i>Customers
            </a>
        </div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link " href="pharmacists.aspx">
                <i class="bi bi-person-badge"></i>Pharmacists/Staff
            </a>
        </div>

        <div class="sidebar-label">Catalog</div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link" href="category-management.aspx"><i
                class="bi bi-grid-3x3-gap"></i>Categories</a>
        </div>

        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link " href="medicines.aspx">
                <i class="bi bi-capsule"></i>Medicine Management
            </a>
        </div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link active" href="inventory.aspx"><i
                class="bi bi-boxes"></i>Inventory</a>
        </div>
        <%-- <div class="sidebar-nav-item">
            <a class="sidebar-nav-link" href="../pharmacist/prescription-billing.aspx"><i
                class="bi bi-file-medical-fill"></i>Rx &amp; Billing</a>
        </div>--%>

        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link" href="supplier-management.aspx"><i
                class="bi bi-truck"></i>Suppliers</a>
        </div>

        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link " href="brands.aspx">
                <i class="bi bi-building"></i>Brands
            </a>
        </div>

        <div class="sidebar-label">Operations</div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link " href="orders.aspx">
                <i class="bi bi-bag-check"></i>Orders
            </a>
        </div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link " href="reports.aspx">
                <i class="bi bi-graph-up-arrow"></i>Reports <span class="nav-badge">Sales / Inventory / Revenue</span>
            </a>
        </div>

        <div class="sidebar-label">System</div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link " href="profile.aspx">
                <i class="bi bi-person-circle"></i>My Profile
            </a>
        </div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link " href="settings.aspx">
                <i class="bi bi-gear-wide-connected"></i>Settings
            </a>
        </div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link " href="audit-logs.aspx"><i
                class="bi bi-journal-text"></i>Audit Logs</a>
        </div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link" href="settings.aspx#backup"><i
                class="bi bi-cloud-arrow-up"></i>Backup &amp; Restore</a>
        </div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link" href="../Logout.aspx">
                <i class="bi bi-box-arrow-right"></i>Logout
            </a>
        </div>

        <div class="sidebar-label">Portal Access</div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link portal-link" href="../pharmacist/dashboard.aspx">
                <i class="bi bi-person-badge-fill"></i>Pharmacist Portal
            </a>
        </div>
        <div class="sidebar-nav-item">
            <a class="sidebar-nav-link portal-link" href="../index.aspx">
                <i class="bi bi-shop"></i>Customer Portal
            </a>
        </div>
    </nav>
    <div class="sidebar-footer">
        <div class="sidebar-version">MediCare Admin v2.4.1</div>
    </div>
</aside>
 <div class="sidebar-overlay" id="phOverlay"></div>
        <div class="ph-main">
          <div id="headerMount"></div>
          <main class="ph-content">
            <!-- Stats -->
            <div class="row g-3 mb-4">
              <div class="col-6 col-lg-3">
                <div class="stat-card stat-blue">
                  <div class="d-flex justify-content-between align-items-start mb-2">
                    <div class="stat-icon"><i class="bi bi-boxes"></i></div><span class="stat-trend">Total</span>
                  </div>
                  <div class="stat-value" id="statTotalStock">0</div>
                  <div class="stat-label">Total Stock Units</div>
                </div>
              </div>
              <div class="col-6 col-lg-3">
                <div class="stat-card stat-green">
                  <div class="d-flex justify-content-between align-items-start mb-2">
                    <div class="stat-icon"><i class="bi bi-check-circle-fill"></i></div><span class="stat-trend"><i
                        class="bi bi-arrow-up me-1"></i>Good</span>
                  </div>
                  <div class="stat-value" id="statInStock">0</div>
                  <div class="stat-label">In Stock Items</div>
                </div>
              </div>
              <div class="col-6 col-lg-3">
                <div class="stat-card stat-orange">
                  <div class="d-flex justify-content-between align-items-start mb-2">
                    <div class="stat-icon"><i class="bi bi-exclamation-triangle-fill"></i></div><span
                      class="stat-trend">Action Needed</span>
                  </div>
                  <div class="stat-value" id="statLowStock">0</div>
                  <div class="stat-label">Low Stock Items</div>
                </div>
              </div>
              <div class="col-6 col-lg-3">
                <div class="stat-card stat-red">
                  <div class="d-flex justify-content-between align-items-start mb-2">
                    <div class="stat-icon"><i class="bi bi-x-circle-fill"></i></div><span
                      class="stat-trend">Critical</span>
                  </div>
                  <div class="stat-value" id="statOutStock">0</div>
                  <div class="stat-label">Out of Stock</div>
                </div>
              </div>
            </div>

            <!-- Inventory Table -->
            <div class="data-card">
              <div class="data-card-header">
                <div class="data-card-title"><i class="bi bi-boxes me-2 text-primary"></i>Inventory Overview</div>
                <div class="d-flex gap-2 flex-wrap">
                  <div class="search-bar" style="max-width:220px">
                    <i class="bi bi-search"></i>
                    <asp:TextBox ID="invSearch" runat="server" CssClass="form-control" placeholder="Search inventory..."
                      ClientIDMode="Static" />
                  </div>
                  <asp:DropDownList ID="invStockFilter" runat="server" CssClass="form-select form-control-custom"
                    style="width:130px;height:40px;font-size:.88rem" ClientIDMode="Static">
                    <asp:ListItem Text="All Stock" Value=""></asp:ListItem>
                    <asp:ListItem Text="Low Stock" Value="low"></asp:ListItem>
                    <asp:ListItem Text="Normal" Value="ok"></asp:ListItem>
                    <asp:ListItem Text="High Stock" Value="high"></asp:ListItem>
                  </asp:DropDownList>
                  <asp:LinkButton ID="btnExportInvCSV" runat="server" CssClass="btn btn-outline-primary-custom fw-600"
                    ClientIDMode="Static" OnClientClick="showToast('Exporting inventory CSV...','info'); return false;">
                    <i class="bi bi-download me-1"></i>Export CSV
                  </asp:LinkButton>
                </div>
              </div>
              <div class="table-wrap">
                <asp:GridView ID="gvInventory" runat="server" AutoGenerateColumns="False"
                  OnRowCommand="gvInventory_RowCommand" CssClass="table table-bordered table-striped"
                  ClientIDMode="Static">
                  <Columns>
                    <asp:TemplateField HeaderText="ID">
                      <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("MedicineID") %>'></asp:Label>
                      </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Medicine">
                      <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                      </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Category">
                      <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("CategoryName") %>'></asp:Label>
                      </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Stock">
                      <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("Stock") %>'></asp:Label>
                      </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Min Level">
                      <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("MinStockLevel") %>'></asp:Label>
                      </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Status">
                      <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                      </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Adjust">
                      <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="cmd_edt"
                          CommandArgument='<%# Eval("MedicineID") %>'>
                          Adjust Stock
                        </asp:LinkButton>
                      </ItemTemplate>
                    </asp:TemplateField>
                  </Columns>
                </asp:GridView>
              </div>
            </div>
          </main>
        </div>
      </div>

      <!-- Adjust Stock Modal -->
      <div class="modal fade modal-custom" id="adjustModal" tabindex="-1">
        <div class="modal-dialog modal-sm">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title fw-700">Adjust Stock</h5><button type="button" class="btn-close"
                data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
              <div class="mb-3"><label class="form-label fw-600 small">Medicine</label>
                <asp:TextBox ID="adjMedName" runat="server" CssClass="form-control form-control-custom" ReadOnly="true"
                  ClientIDMode="Static" />
              </div>
              <div class="mb-3"><label class="form-label fw-600 small">Current Stock</label>
                <asp:TextBox ID="adjCurrent" runat="server" CssClass="form-control form-control-custom" ReadOnly="true"
                  ClientIDMode="Static" />
              </div>
              <div class="mb-3"><label class="form-label fw-600 small">Adjustment Type</label>
                <asp:DropDownList ID="adjType" runat="server" CssClass="form-control form-control-custom"
                  ClientIDMode="Static">
                  <asp:ListItem>Add Stock</asp:ListItem>
                  <asp:ListItem>Remove Stock</asp:ListItem>
                  <asp:ListItem>Set Stock</asp:ListItem>
                </asp:DropDownList>
              </div>
              <div class="mb-3"><label class="form-label fw-600 small">Quantity</label>
                <asp:TextBox ID="adjQty" runat="server" TextMode="Number" CssClass="form-control form-control-custom"
                  placeholder="0" ClientIDMode="Static" />
              </div>
              <div class="mb-3"><label class="form-label fw-600 small">Reason</label>
                <asp:TextBox ID="txtAdjReason" runat="server" TextMode="MultiLine" Rows="2"
                  CssClass="form-control form-control-custom" placeholder="Reason for adjustment"
                  ClientIDMode="Static" />
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
              <asp:LinkButton ID="btnSaveAdjust" runat="server" CssClass="btn btn-primary-custom fw-600"
                OnClick="btnSaveAdjust_Click" ClientIDMode="Static"><i class="bi bi-check2 me-1"></i>Update Stock
              </asp:LinkButton>
            </div>
          </div>
        </div>
      </div>

      <div id="toast-container"></div>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
      <script src="../assets/js/main.js"></script>
      <script src="../assets/js/pharmacist.js"></script>
      <script>
        let invData = [];

        function getStockStatus(m) {
          if (m.stock === 0) return { cls: 'badge-danger', text: 'Out of Stock' };
          if (m.stock < 50) return { cls: 'badge-warning', text: 'Low Stock' };
          if (m.stock > 150) return { cls: 'badge-success', text: 'Well Stocked' };
          return { cls: 'badge-info', text: 'Normal' };
        }

        function renderInvTable(items) {
          document.getElementById('invCount').textContent = items.length;
          document.getElementById('invTableBody').innerHTML = items.map((m, i) => {
            const st = getStockStatus(m);
            const pct = Math.min((m.stock / 300) * 100, 100);
            return `
    <tr>
      <td class="text-muted small">${String(i + 1).padStart(3, '0')}</td>
      <td>
        <div class="d-flex align-items-center gap-2">
          ${typeof renderMedicineImage === 'function' ? renderMedicineImage(m.img, m.name, 'med-tb-img', 'width:36px;height:36px;border-radius:6px;object-fit:contain;') : `<span style="font-size:1.4rem">${m.img || '💊'}</span>`}
          <div><div class="fw-600" style="font-size:.88rem">${m.name}</div><small class="text-muted">${m.brand}</small></div>
        </div>
      </td>
      <td><span class="badge-custom badge-info">${m.category}</span></td>
      <td class="text-muted small">${m.batch}</td>
      <td style="min-width:120px">
        <div class="progress" style="height:8px;border-radius:4px">
          <div class="progress-bar ${m.stock > 100 ? 'bg-success' : m.stock > 50 ? 'bg-warning' : 'bg-danger'}" style="width:${pct}%;border-radius:4px"></div>
        </div>
      </td>
      <td class="fw-600">${m.stock}</td>
      <td class="text-muted">${m.minStock}</td>
      <td class="${new Date(m.expiry) < new Date('2026-10-15') ? 'expiry-warn' : 'expiry-ok'}">${typeof formatDate === 'function' ? formatDate(m.expiry) : m.expiry}</td>
      <td><span class="badge-custom ${st.cls}">${st.text}</span></td>
      <td class="text-muted small">${m.lastUpdated}</td>
      <td>
        <div class="d-flex gap-1">
          <button class="btn btn-sm btn-outline-primary-custom py-0 px-2" onclick="adjustStock(${m.id})" title="Adjust Stock"><i class="bi bi-arrow-repeat"></i></button>
          <button class="btn btn-sm btn-outline-primary-custom py-0 px-2" onclick="showToast('Stock history viewed','info')" title="History"><i class="bi bi-clock-history"></i></button>
        </div>
      </td>
    </tr>`;
          }).join('');
        }

        function adjustStock(id) {
          const m = invData.find(x => x.id === id);
          if (!m) return;
          document.getElementById('adjMedName').value = m.name;
          document.getElementById('adjCurrent').value = m.stock + ' units';
          new bootstrap.Modal(document.getElementById('adjustModal')).show();
        }

        function saveAdjust() {
          showLoader();
          setTimeout(() => {
            hideLoader();
            bootstrap.Modal.getInstance(document.getElementById('adjustModal')).hide();
            showToast('Stock updated successfully!', 'success');
          }, 700);
        }

        document.addEventListener('DOMContentLoaded', () => {
          document.getElementById('headerMount').innerHTML = PH_HEADER('Inventory Management', 'Inventory');
          initSidebar('phSidebar', 'phOverlay');

          const meds = (typeof DummyData !== 'undefined' && DummyData.medicines) ? DummyData.medicines : [];
          invData = meds.map((m, index) => ({
            ...m,
            batch: m.batchNo || `BT-2024-${String(index + 1).padStart(3, '0')}`,
            expiry: m.expiryDate || '2027-12-31',
            minStock: Math.floor(m.stock * 0.4) + 10,
            lastUpdated: ['2 hrs ago', '5 hrs ago', 'Yesterday', '3 days ago', '1 week ago'][index % 5]
          }));

          const totalStock = invData.reduce((s, m) => s + m.stock, 0);
          const lowStock = invData.filter(m => m.stock < 50).length;
          const inStock = invData.filter(m => m.stock > 0).length;
          const outOfStock = invData.filter(m => m.stock === 0).length;

          document.getElementById('statTotalStock').textContent = totalStock.toLocaleString();
          document.getElementById('statInStock').textContent = inStock;
          document.getElementById('statLowStock').textContent = lowStock;
          document.getElementById('statOutStock').textContent = outOfStock;

          renderInvTable(invData);

          document.getElementById('invSearch').addEventListener('input', function () {
            const q = this.value.toLowerCase();
            renderInvTable(invData.filter(m => m.name.toLowerCase().includes(q) || m.brand.toLowerCase().includes(q) || m.category.toLowerCase().includes(q)));
          });

          document.getElementById('invStockFilter').addEventListener('change', function () {
            const v = this.value;
            if (!v) return renderInvTable(invData);
            if (v === 'low') renderInvTable(invData.filter(m => m.stock < 50));
            else if (v === 'ok') renderInvTable(invData.filter(m => m.stock >= 50 && m.stock <= 150));
            else renderInvTable(invData.filter(m => m.stock > 150));
          });
        });
      </script>
    </body>
  </asp:Content>