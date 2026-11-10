<%@ Page Title="Brand Management" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
  CodeBehind="brands.aspx.cs" Inherits="medicare.admin.brands" %>

  <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  </asp:Content>
  <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  </asp:Content>
  <asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
  </asp:Content>
  <asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">

    <body>
      <div class="admin-layout">
        <!-- ══ ADMIN SIDEBAR ════════════════════════════════════════════ -->
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

            <%-- <div class="sidebar-label">User Management
      </div>
      <div class="sidebar-nav-item">
        <a class="sidebar-nav-link " href="users.aspx"><i class="bi bi-person-gear"></i>Users</a>
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
        <a class="sidebar-nav-link" href="category-management.aspx"><i class="bi bi-grid-3x3-gap"></i>Categories</a>
      </div>

      <div class="sidebar-nav-item">
        <a class="sidebar-nav-link " href="medicines.aspx">
          <i class="bi bi-capsule"></i>Medicine Management
        </a>
      </div>
      <div class="sidebar-nav-item">
        <a class="sidebar-nav-link" href="inventory.aspx"><i class="bi bi-boxes"></i>Inventory</a>
      </div>
      <%-- <div class="sidebar-nav-item">
        <a class="sidebar-nav-link" href="../pharmacist/prescription-billing.aspx"><i
            class="bi bi-file-medical-fill"></i>Rx &amp; Billing</a>
        </div>--%>

        <div class="sidebar-nav-item">
          <a class="sidebar-nav-link" href="supplier-management.aspx"><i class="bi bi-truck"></i>Suppliers</a>
        </div>

        <div class="sidebar-nav-item">
          <a class="sidebar-nav-link active" href="brands.aspx">
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
          <a class="sidebar-nav-link " href="audit-logs.aspx"><i class="bi bi-journal-text"></i>Audit Logs</a>
        </div>
        <div class="sidebar-nav-item">
          <a class="sidebar-nav-link" href="settings.aspx#backup"><i class="bi bi-cloud-arrow-up"></i>Backup &amp;
            Restore</a>
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
        <div class="sidebar-overlay" id="adminOverlay"></div>
        <div class="admin-main">
          <div id="headerMount"></div>
          <div class="admin-content">

            <!-- Stats -->
            <div class="row g-3 mb-4">
              <div class="col-6 col-lg-3">
                <div class="stat-card stat-blue">
                  <div class="stat-icon mb-2"><i class="bi bi-award-fill"></i></div>
                  <div class="stat-value">
                    <asp:Label ID="lblTotalBrands" runat="server" Text="0" ClientIDMode="Static" />
                  </div>
                  <div class="stat-label">Total Brands</div>
                </div>
              </div>
              <div class="col-6 col-lg-3">
                <div class="stat-card stat-green">
                  <div class="stat-icon mb-2"><i class="bi bi-check-circle-fill"></i></div>
                  <div class="stat-value">
                    <asp:Label ID="lblActiveBrands" runat="server" Text="0" ClientIDMode="Static" />
                  </div>
                  <div class="stat-label">Active</div>
                </div>
              </div>
              <div class="col-6 col-lg-3">
                <div class="stat-card stat-red">
                  <div class="stat-icon mb-2"><i class="bi bi-x-circle-fill"></i></div>
                  <div class="stat-value">
                    <asp:Label ID="lblInactiveBrands" runat="server" Text="0" ClientIDMode="Static" />
                  </div>
                  <div class="stat-label">Inactive</div>
                </div>
              </div>
              <div class="col-6 col-lg-3">
                <div class="stat-card stat-purple">
                  <div class="stat-icon mb-2"><i class="bi bi-capsule-pill"></i></div>
                  <div class="stat-value">
                    <asp:Label ID="lblTotalProducts" runat="server" Text="0" ClientIDMode="Static" />
                  </div>
                  <div class="stat-label">Total Products</div>
                </div>
              </div>
            </div>

            <!-- Brands DataList -->
            <div class="data-card">
              <div class="data-card-header">
                <div class="data-card-title"><i class="bi bi-award me-2 text-primary"></i>All Brands</div>
                <div class="d-flex gap-2 flex-wrap">
                  <div class="search-bar" style="max-width:220px"><i class="bi bi-search"></i>
                    <asp:TextBox ID="searchBrands" runat="server" CssClass="form-control" placeholder="Search brands..."
                      ClientIDMode="Static" />
                  </div>
                  <asp:LinkButton ID="btnOpenAddBrandModal" runat="server" CssClass="btn btn-primary-custom fw-600"
                    OnClientClick="return false;" data-bs-toggle="modal" data-bs-target="#addBrandModal"
                    ClientIDMode="Static">
                    <i class="bi bi-plus me-1"></i>Add Brand
                  </asp:LinkButton>
                </div>
              </div>
              <div class="table-wrap">
                <asp:GridView ID="gvBrands" runat="server" AutoGenerateColumns="False"
                  OnRowCommand="gvBrands_RowCommand" CssClass="table table-bordered table-striped"
                  ClientIDMode="Static">
                  <Columns>
                    <asp:TemplateField HeaderText="Brand ID">
                      <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("BrandID") %>'>
                        </asp:Label>
                      </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Brand Code">
                      <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("BrandCode") %>'>
                        </asp:Label>
                      </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Name">
                      <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                      </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Country">
                      <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("Country") %>'>
                        </asp:Label>
                      </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Status">
                      <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("Status") %>'>
                        </asp:Label>
                      </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Edit">
                      <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="cmd_edt"
                          CommandArgument='<%# Eval("BrandID") %>'>
                          Edit
                        </asp:LinkButton>
                      </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Delete">
                      <ItemTemplate>
                        <asp:LinkButton ID="LinkButton2" runat="server" CommandName="cmd_del"
                          CommandArgument='<%# Eval("BrandID") %>'
                          OnClientClick="return confirm('Are you sure you want to delete this record?');">
                          Delete
                        </asp:LinkButton>
                      </ItemTemplate>
                    </asp:TemplateField>
                  </Columns>
                </asp:GridView>
              </div>
            </div>
          </div>
        </div>
        </div>

        <!-- Add Brand Modal -->
        <div class="modal fade modal-custom" id="addBrandModal" tabindex="-1">
          <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title fw-700"><i class="bi bi-award me-2"></i>Add New Brand</h5><button type="button"
                  class="btn-close" data-bs-dismiss="modal"></button>
              </div>
              <div class="modal-body">
                <div class="row g-3">
                  <div class="col-md-6"><label class="form-label fw-600">Brand Name</label>
                    <asp:TextBox ID="txtBrandName" runat="server" CssClass="form-control form-control-custom"
                      placeholder="e.g. BioPharma" ClientIDMode="Static" />
                  </div>
                  <div class="col-md-6"><label class="form-label fw-600">Country</label>
                    <asp:TextBox ID="txtBrandCountry" runat="server" CssClass="form-control form-control-custom"
                      placeholder="e.g. India" ClientIDMode="Static" />
                  </div>
                  <div class="col-12"><label class="form-label fw-600">Description</label>
                    <asp:TextBox ID="txtBrandDesc" runat="server" TextMode="MultiLine" Rows="2"
                      CssClass="form-control form-control-custom" placeholder="Brief description..."
                      ClientIDMode="Static" />
                  </div>
                  <div class="col-md-6"><label class="form-label fw-600">Status</label>
                    <asp:DropDownList ID="ddlBrandStatus" runat="server" CssClass="form-select form-control-custom"
                      ClientIDMode="Static">
                      <asp:ListItem>Active</asp:ListItem>
                      <asp:ListItem>Inactive</asp:ListItem>
                    </asp:DropDownList>
                  </div>
                </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary-custom" data-bs-dismiss="modal">Cancel</button>
                <asp:LinkButton ID="btnAddBrandSubmit" runat="server" CssClass="btn btn-primary-custom fw-600"
                  OnClick="btnAddBrandSubmit_Click"
                  OnClientClick="bootstrap.Modal.getInstance(document.getElementById('addBrandModal')).hide(); return true;"
                  ClientIDMode="Static">
                  <i class="bi bi-check-lg me-1"></i>Add Brand
                </asp:LinkButton>
              </div>
            </div>
          </div>
        </div>

        <!-- Edit Brand Modal -->
        <div class="modal fade modal-custom" id="editBrandModal" tabindex="-1">
          <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title fw-700"><i class="bi bi-pencil me-2"></i>Edit Brand</h5><button type="button"
                  class="btn-close" data-bs-dismiss="modal"></button>
              </div>
              <div class="modal-body">
                <div class="row g-3">
                  <div class="col-md-6"><label class="form-label fw-600">Brand Name</label>
                    <asp:TextBox ID="txtEditBrandName" runat="server" CssClass="form-control form-control-custom"
                      placeholder="e.g. BioPharma" ClientIDMode="Static" />
                  </div>
                  <div class="col-md-6"><label class="form-label fw-600">Country</label>
                    <asp:TextBox ID="txtEditBrandCountry" runat="server" CssClass="form-control form-control-custom"
                      placeholder="e.g. India" ClientIDMode="Static" />
                  </div>
                  <div class="col-12"><label class="form-label fw-600">Description</label>
                    <asp:TextBox ID="txtEditBrandDesc" runat="server" TextMode="MultiLine" Rows="2"
                      CssClass="form-control form-control-custom" placeholder="Brief description..."
                      ClientIDMode="Static" />
                  </div>
                  <div class="col-md-6"><label class="form-label fw-600">Status</label>
                    <asp:DropDownList ID="ddlEditBrandStatus" runat="server" CssClass="form-select form-control-custom"
                      ClientIDMode="Static">
                      <asp:ListItem>Active</asp:ListItem>
                      <asp:ListItem>Inactive</asp:ListItem>
                    </asp:DropDownList>
                  </div>
                </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary-custom" data-bs-dismiss="modal">Cancel</button>
                <asp:LinkButton ID="btnEditBrandSubmit" runat="server" CssClass="btn btn-primary-custom fw-600"
                  OnClick="btnEditBrandSubmit_Click" ClientIDMode="Static">
                  <i class="bi bi-check-lg me-1"></i>Update Brand
                </asp:LinkButton>
              </div>
            </div>
          </div>
        </div>

        <div id="toast-container"></div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="../assets/js/main.js"></script>
        <script src="../assets/js/admin.js"></script>
        <script>
          document.addEventListener('DOMContentLoaded', () => {
            document.getElementById('headerMount').innerHTML = ADMIN_HEADER('Brand Management', 'Brands');
            initSidebar('adminSidebar', 'adminOverlay');
            filterTable('searchBrands', 'brandsTable');
          });
        </script>
    </body>
  </asp:Content>