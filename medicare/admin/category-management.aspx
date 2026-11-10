<%@ Page Title="Category Management" Language="C#" MasterPageFile="~/Site1.Master"
  AutoEventWireup="true" CodeBehind="category-management.aspx.cs" Inherits="medicare.admin.categoryManagement" %>

  <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  </asp:Content>
  <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  </asp:Content>
  <asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
  </asp:Content>
  <asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">

    <body>
      <div class="ph-layout">
        <!-- â•â• ADMIN SIDEBAR â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â• -->
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
              <a class="sidebar-nav-link" href="dashboard.aspx">
                <i class="bi bi-speedometer2"></i>Dashboard
              </a>
            </div>

            <div class="sidebar-nav-item">
              <a class="sidebar-nav-link" href="customers.aspx">
                <i class="bi bi-people"></i>Customers
              </a>
            </div>
            <div class="sidebar-nav-item">
              <a class="sidebar-nav-link" href="pharmacists.aspx">
                <i class="bi bi-person-badge"></i>Pharmacists/Staff
              </a>
            </div>

            <div class="sidebar-label">Catalog</div>
            <div class="sidebar-nav-item">
              <a class="sidebar-nav-link active" href="category-management.aspx"><i
                  class="bi bi-grid-3x3-gap"></i>Categories</a>
            </div>

            <div class="sidebar-nav-item">
              <a class="sidebar-nav-link" href="medicines.aspx">
                <i class="bi bi-capsule"></i>Medicine Management
              </a>
            </div>
            <div class="sidebar-nav-item">
              <a class="sidebar-nav-link" href="inventory.aspx"><i class="bi bi-boxes"></i>Inventory</a>
            </div>

            <div class="sidebar-nav-item">
              <a class="sidebar-nav-link" href="supplier-management.aspx"><i class="bi bi-truck"></i>Suppliers</a>
            </div>

            <div class="sidebar-nav-item">
              <a class="sidebar-nav-link" href="brands.aspx">
                <i class="bi bi-building"></i>Brands
              </a>
            </div>

            <div class="sidebar-label">Operations</div>
            <div class="sidebar-nav-item">
              <a class="sidebar-nav-link" href="orders.aspx">
                <i class="bi bi-bag-check"></i>Orders
              </a>
            </div>
            <div class="sidebar-nav-item">
              <a class="sidebar-nav-link" href="reports.aspx">
                <i class="bi bi-graph-up-arrow"></i>Reports <span class="nav-badge">Sales / Inventory / Revenue</span>
              </a>
            </div>

            <div class="sidebar-label">System</div>
            <div class="sidebar-nav-item">
              <a class="sidebar-nav-link" href="profile.aspx">
                <i class="bi bi-person-circle"></i>My Profile
              </a>
            </div>
            <div class="sidebar-nav-item">
              <a class="sidebar-nav-link" href="settings.aspx">
                <i class="bi bi-gear-wide-connected"></i>Settings
              </a>
            </div>
            <div class="sidebar-nav-item">
              <a class="sidebar-nav-link" href="audit-logs.aspx"><i class="bi bi-journal-text"></i>Audit Logs</a>
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

        <div class="ph-main">
          <div id="headerMount"></div>
          <main class="ph-content">
            <!-- Stats -->
            <div class="row g-3 mb-4">
              <div class="col-6 col-md-3">
                <div class="stat-card stat-blue">
                  <div class="stat-value">
                    <asp:Label ID="lblTotalCategories" runat="server" Text="0" />
                  </div>
                  <div class="stat-label">Total Categories</div>
                </div>
              </div>
              <div class="col-6 col-md-3">
                <div class="stat-card stat-green">
                  <div class="stat-value">
                    <asp:Label ID="lblActiveCategories" runat="server" Text="0" />
                  </div>
                  <div class="stat-label">Active</div>
                </div>
              </div>
              <div class="col-6 col-md-3">
                <div class="stat-card stat-orange">
                  <div class="stat-value">
                    <asp:Label ID="lblInactiveCategories" runat="server" Text="0" />
                  </div>
                  <div class="stat-label">Inactive</div>
                </div>
              </div>
              <div class="col-6 col-md-3">
                <div class="stat-card stat-cyan">
                  <div class="stat-value">
                    <asp:Label ID="lblTotalProducts" runat="server" Text="0" />
                  </div>
                  <div class="stat-label">Total Products</div>
                </div>
              </div>
            </div>

            <!-- Category GridView -->
            <div class="data-card">
              <div class="data-card-header">
                <div class="data-card-title"><i class="bi bi-grid-3x3-gap me-2 text-primary"></i>Category List</div>
                <div class="d-flex gap-2 flex-wrap">
                  <div class="search-bar" style="max-width:220px">
                    <i class="bi bi-search"></i>
                    <asp:TextBox ID="searchCat" runat="server" CssClass="form-control"
                      placeholder="Search categories..." ClientIDMode="Static" />
                  </div>
                  <button type="button" class="btn btn-primary-custom fw-600" data-bs-toggle="modal"
                    data-bs-target="#addCatModal">
                    <i class="bi bi-plus me-1"></i>Add Category
                  </button>
                </div>
              </div>
              <div class="table-wrap">
                <asp:GridView ID="gvCategories" runat="server" AutoGenerateColumns="False"
                  OnRowCommand="gvCategories_RowCommand" CssClass="table table-bordered table-striped"
                  ClientIDMode="Static">
                  <Columns>
                    <asp:TemplateField HeaderText="ID">
                      <ItemTemplate>
                        <span class="text-muted small">#<%# Eval("CategoryID") %></span>
                      </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Icon">
                      <ItemTemplate>
                        <span style="font-size:1.3rem">
                          <%# Eval("Icon") %>
                        </span>
                      </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Category Name">
                      <ItemTemplate>
                        <span class="fw-600">
                          <%# Eval("Name") %>
                        </span>
                      </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Description">
                      <ItemTemplate>
                        <span class="text-muted small">
                          <%# Eval("Description") %>
                        </span>
                      </ItemTemplate>
                    </asp:TemplateField>

                   
                    <asp:TemplateField HeaderText="Status">
                      <ItemTemplate>
                        <span
                          class='badge-custom <%# Eval("Status") != null && Eval("Status").ToString() == "Active" ? "badge-success" : "badge-danger" %>'>
                          <%# Eval("Status") %>
                        </span>
                      </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Edit">
                      <ItemTemplate>
                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="cmd_edt"
                          CommandArgument='<%# Eval("CategoryID") %>'
                          CssClass="btn btn-sm btn-outline-primary-custom py-1 px-2">
                          <i class="bi bi-pencil me-1"></i>Edit
                        </asp:LinkButton>
                      </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Delete">
                      <ItemTemplate>
                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="cmd_del"
                          CommandArgument='<%# Eval("CategoryID") %>' CssClass="btn btn-sm btn-danger-custom py-1 px-2"
                          OnClientClick="return confirm('Are you sure you want to delete this category?');">
                          <i class="bi bi-trash me-1"></i>Delete
                        </asp:LinkButton>
                      </ItemTemplate>
                    </asp:TemplateField>
                  </Columns>
                  <EmptyDataTemplate>
                    <div class="text-center py-4 text-muted">
                      <i class="bi bi-inbox fs-2 d-block mb-2"></i>
                      No categories found. Click "Add Category" above to create one.
                    </div>
                  </EmptyDataTemplate>
                </asp:GridView>
              </div>
            </div>
          </main>
        </div>
      </div>

      <!-- Add Category Modal -->
      <div class="modal fade modal-custom" id="addCatModal" tabindex="-1" aria-labelledby="addCatModalTitle"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title fw-700" id="addCatModalTitle"><i
                  class="bi bi-plus-circle me-2 text-primary"></i>Add New Category</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <div class="mb-3">
                <label class="form-label fw-600 small">Category Name*</label>
                <asp:TextBox ID="catName" runat="server" CssClass="form-control form-control-custom"
                  placeholder="e.g. Antibiotics" ClientIDMode="Static" />
              </div>
              <div class="mb-3">
                <label class="form-label fw-600 small">Icon (Emoji or text)</label>
                <asp:TextBox ID="catIcon" runat="server" CssClass="form-control form-control-custom" placeholder="ðŸ’Š"
                  ClientIDMode="Static" />
              </div>
              <div class="mb-3">
                <label class="form-label fw-600 small">Description</label>
                <asp:TextBox ID="txtCatDesc" runat="server" TextMode="MultiLine" Rows="2"
                  CssClass="form-control form-control-custom" placeholder="Brief category description"
                  ClientIDMode="Static" />
              </div>
              <div class="mb-3">
                <label class="form-label fw-600 small">Status</label>
                <asp:DropDownList ID="ddlCatStatus" runat="server" CssClass="form-select form-control-custom"
                  ClientIDMode="Static">
                  <asp:ListItem Selected="True">Active</asp:ListItem>
                  <asp:ListItem>Inactive</asp:ListItem>
                </asp:DropDownList>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary-custom" data-bs-dismiss="modal">Cancel</button>
              <asp:Button ID="btnSaveCat" runat="server" Text="Save Category" CssClass="btn btn-primary-custom fw-600"
                OnClick="btnSaveCat_Click" ClientIDMode="Static" />
            </div>
          </div>
        </div>
      </div>

      <!-- Edit Category Modal -->
      <div class="modal fade modal-custom" id="editCatModal" tabindex="-1" aria-labelledby="editCatModalTitle"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title fw-700" id="editCatModalTitle"><i
                  class="bi bi-pencil-square me-2 text-primary"></i>Edit Category</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <div class="mb-3">
                <label class="form-label fw-600 small">Category Name*</label>
                <asp:TextBox ID="txtEditCatName" runat="server" CssClass="form-control form-control-custom"
                  placeholder="e.g. Antibiotics" ClientIDMode="Static" />
              </div>
              <div class="mb-3">
                <label class="form-label fw-600 small">Icon (Emoji or text)</label>
                <asp:TextBox ID="txtEditCatIcon" runat="server" CssClass="form-control form-control-custom"
                  placeholder="ðŸ’Š" ClientIDMode="Static" />
              </div>
              <div class="mb-3">
                <label class="form-label fw-600 small">Description</label>
                <asp:TextBox ID="txtEditCatDesc" runat="server" TextMode="MultiLine" Rows="2"
                  CssClass="form-control form-control-custom" placeholder="Brief category description"
                  ClientIDMode="Static" />
              </div>
              <div class="mb-3">
                <label class="form-label fw-600 small">Status</label>
                <asp:DropDownList ID="ddlEditCatStatus" runat="server" CssClass="form-select form-control-custom"
                  ClientIDMode="Static">
                  <asp:ListItem>Active</asp:ListItem>
                  <asp:ListItem>Inactive</asp:ListItem>
                </asp:DropDownList>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary-custom" data-bs-dismiss="modal">Cancel</button>
              <asp:Button ID="btnUpdateCat" runat="server" Text="Update Category"
                CssClass="btn btn-primary-custom fw-600" OnClick="btnUpdateCat_Click" ClientIDMode="Static" />
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
          document.getElementById('headerMount').innerHTML = ADMIN_HEADER('Category Management', 'Categories');
          initSidebar('adminSidebar', 'adminOverlay');
          if (typeof filterTable === 'function') {
            filterTable('searchCat', 'gvCategories');
          }
        });
      </script>
    </body>
  </asp:Content>
