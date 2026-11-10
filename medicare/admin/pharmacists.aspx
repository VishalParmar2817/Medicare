<%@ Page Title="Pharmacist Management — Admin Panel | MediCare" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="pharmacists.aspx.cs" Inherits="medicare.admin.pharmacists" %>

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
                        <a class="sidebar-nav-link active" href="pharmacists.aspx">
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
                        <a class="sidebar-nav-link" href="inventory.aspx"><i
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
            <div class="sidebar-overlay" id="adminOverlay"></div>
            <div class="admin-main">
                <div id="headerMount"></div>
                <div class="admin-content">

                    <!-- Stats -->
                    <div class="row g-3 mb-4">
                        <div class="col-6 col-lg-3">
                            <div class="stat-card stat-blue">
                                <div class="stat-icon mb-2">🔬</div>
                                <div class="stat-value">
                                    <asp:Label ID="lblTotalPh" runat="server" Text="0" ClientIDMode="Static" /></div>
                                <div class="stat-label">Total Pharmacists</div>
                            </div>
                        </div>
                        <div class="col-6 col-lg-3">
                            <div class="stat-card stat-green">
                                <div class="stat-icon mb-2">✅</div>
                                <div class="stat-value">
                                    <asp:Label ID="lblActivePh" runat="server" Text="0" ClientIDMode="Static" /></div>
                                <div class="stat-label">Active</div>
                            </div>
                        </div>
                        <div class="col-6 col-lg-3">
                            <div class="stat-card stat-red">
                                <div class="stat-icon mb-2">🚫</div>
                                <div class="stat-value">
                                    <asp:Label ID="lblInactivePh" runat="server" Text="0" ClientIDMode="Static" /></div>
                                <div class="stat-label">Inactive</div>
                            </div>
                        </div>
                        <div class="col-6 col-lg-3">
                            <div class="stat-card stat-purple">
                                <div class="stat-icon mb-2">⭐</div>
                                <div class="stat-value">4.6</div>
                                <div class="stat-label">Avg Performance</div>
                            </div>
                        </div>
                    </div>

                    <!-- Pharmacists DataList -->
                    <div class="data-card">
                        <div class="data-card-header">
                            <div class="data-card-title">All Pharmacists</div>
                            <div class="d-flex gap-2 flex-wrap">
                                <div class="search-bar" style="max-width: 220px">
                                    <i class="bi bi-search"></i>
                                    <asp:TextBox ID="searchPh" runat="server" CssClass="form-control" placeholder="Search pharmacists..." ClientIDMode="Static" />
                                </div>
                                <asp:LinkButton ID="btnOpenAddPhModal" runat="server" CssClass="btn btn-primary-custom fw-600"
                                    OnClientClick="return false;" data-bs-toggle="modal" data-bs-target="#addPhModal" ClientIDMode="Static">
            <i class="bi bi-plus me-1"></i>Add Pharmacist
                                </asp:LinkButton>
                            </div>
                        </div>
                        <div class="table-wrap">
                            <asp:GridView ID="gvPharmacists" runat="server"
                                AutoGenerateColumns="False"
                                OnRowCommand="gvPharmacists_RowCommand"
                                CssClass="table table-bordered table-striped"
                                ClientIDMode="Static">
                                <Columns>
                                    <asp:TemplateField HeaderText="Pharmacist ID">
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server"
                                                Text='<%# Eval("PharmacistID") %>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Pharmacist Name">
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server"
                                                Text='<%# Eval("FirstName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Email">
                                        <ItemTemplate>
                                            <asp:Label ID="Label3" runat="server"
                                                Text='<%# Eval("Email") %>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Phone">
                                        <ItemTemplate>
                                            <asp:Label ID="Label4" runat="server"
                                                Text='<%# Eval("PhoneNumber") %>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="License No.">
                                        <ItemTemplate>
                                            <asp:Label ID="Label5" runat="server"
                                                Text='<%# Eval("LicenseNumber") %>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <asp:Label ID="Label6" runat="server"
                                                Text='<%# Eval("Status") %>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Edit">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton1"
                                                runat="server"
                                                CommandName="cmd_edt"
                                                CommandArgument='<%# Eval("PharmacistID") %>'>
                  Edit
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Delete">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton2"
                                                runat="server"
                                                CommandName="cmd_del"
                                                CommandArgument='<%# Eval("PharmacistID") %>'
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

        <!-- Add Pharmacist Modal -->
        <div class="modal fade modal-custom" id="addPhModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title fw-700"><i class="bi bi-person-badge me-2"></i>Add New Pharmacist</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-600">Full Name</label><asp:TextBox ID="txtPhName" runat="server" CssClass="form-control form-control-custom" placeholder="Dr. Full Name" ClientIDMode="Static" /></div>
                            <div class="col-md-6">
                                <label class="form-label fw-600">Email</label><asp:TextBox ID="txtPhEmail" runat="server" TextMode="Email" CssClass="form-control form-control-custom" placeholder="email@pharma.com" ClientIDMode="Static" /></div>
                            <div class="col-md-6">
                                <label class="form-label fw-600">Phone</label><asp:TextBox ID="txtPhPhone" runat="server" TextMode="Phone" CssClass="form-control form-control-custom" placeholder="9876543210" ClientIDMode="Static" /></div>
                            <div class="col-md-6">
                                <label class="form-label fw-600">License Number</label><asp:TextBox ID="txtPhLicense" runat="server" CssClass="form-control form-control-custom" placeholder="PH-XX-YYYY-NNN" ClientIDMode="Static" /></div>
                            <div class="col-md-6">
                                <label class="form-label fw-600">Specialization</label><asp:TextBox ID="txtPhSpec" runat="server" CssClass="form-control form-control-custom" placeholder="e.g. Clinical Pharmacy" ClientIDMode="Static" /></div>
                            <div class="col-md-6">
                                <label class="form-label fw-600">Status</label>
                                <asp:DropDownList ID="ddlPhStatus" runat="server" CssClass="form-select form-control-custom" ClientIDMode="Static">
                                    <asp:ListItem>Active</asp:ListItem>
                                    <asp:ListItem>Inactive</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-600">Password</label><asp:TextBox ID="txtPhPassword" runat="server" TextMode="Password" CssClass="form-control form-control-custom" placeholder="••••••••" ClientIDMode="Static" /></div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary-custom" data-bs-dismiss="modal">Cancel</button>
                        <asp:LinkButton ID="btnAddPhSubmit" runat="server" CssClass="btn btn-primary-custom fw-600"
                            OnClick="btnAddPhSubmit_Click" ClientIDMode="Static">
          <i class="bi bi-check-lg me-1"></i>Add Pharmacist
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>

        <!-- Edit Pharmacist Modal -->
        <div class="modal fade modal-custom" id="editPhModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title fw-700"><i class="bi bi-pencil me-2"></i>Edit Pharmacist</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-600">Full Name</label><asp:TextBox ID="txtEditPhName" runat="server" CssClass="form-control form-control-custom" placeholder="Dr. Full Name" ClientIDMode="Static" /></div>
                            <div class="col-md-6">
                                <label class="form-label fw-600">Email</label><asp:TextBox ID="txtEditPhEmail" runat="server" TextMode="Email" CssClass="form-control form-control-custom" placeholder="email@pharma.com" ClientIDMode="Static" /></div>
                            <div class="col-md-6">
                                <label class="form-label fw-600">Phone</label><asp:TextBox ID="txtEditPhPhone" runat="server" TextMode="Phone" CssClass="form-control form-control-custom" placeholder="9876543210" ClientIDMode="Static" /></div>
                            <div class="col-md-6">
                                <label class="form-label fw-600">License Number</label><asp:TextBox ID="txtEditPhLicense" runat="server" CssClass="form-control form-control-custom" placeholder="PH-XX-YYYY-NNN" ClientIDMode="Static" /></div>
                            <div class="col-md-6">
                                <label class="form-label fw-600">Specialization</label><asp:TextBox ID="txtEditPhSpec" runat="server" CssClass="form-control form-control-custom" placeholder="e.g. Clinical Pharmacy" ClientIDMode="Static" /></div>
                            <div class="col-md-6">
                                <label class="form-label fw-600">Status</label>
                                <asp:DropDownList ID="ddlEditPhStatus" runat="server" CssClass="form-select form-control-custom" ClientIDMode="Static">
                                    <asp:ListItem>Active</asp:ListItem>
                                    <asp:ListItem>Inactive</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary-custom" data-bs-dismiss="modal">Cancel</button>
                        <asp:LinkButton ID="btnEditPhSubmit" runat="server" CssClass="btn btn-primary-custom fw-600"
                            OnClick="btnEditPhSubmit_Click" ClientIDMode="Static">
          <i class="bi bi-check-lg me-1"></i>Update Pharmacist
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
                document.getElementById('headerMount').innerHTML = ADMIN_HEADER('Pharmacist Management', 'Pharmacists');
                initSidebar('adminSidebar', 'adminOverlay');
               
            });
        </script>
    </body>
</asp:Content>
