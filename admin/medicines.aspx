<%@ Page Title="Medicine Catalog " Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="medicines.aspx.cs" Inherits="medicare.admin.medicines" %>

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
                        <a class="sidebar-nav-link active" href="medicines.aspx">
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
                            <div class="stat-card stat-green">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <div class="stat-icon"><i class="bi bi-capsule-pill"></i></div>
                                    <span class="stat-trend"><i class="bi bi-arrow-up me-1"></i>+8%</span>
                                </div>
                                <div class="stat-value">
                                    <asp:Label ID="lblTotalMed" runat="server" Text="0" ClientIDMode="Static" />
                                </div>
                                <div class="stat-label">Total Medicines</div>
                            </div>
                        </div>
                        <div class="col-6 col-lg-3">
                            <div class="stat-card stat-blue">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <div class="stat-icon"><i class="bi bi-boxes"></i></div>
                                    <span class="stat-trend">Available</span>
                                </div>
                                <div class="stat-value">
                                    <asp:Label ID="lblInStock" runat="server" Text="0" ClientIDMode="Static" />
                                </div>
                                <div class="stat-label">In Stock</div>
                            </div>
                        </div>
                        <div class="col-6 col-lg-3">
                            <div class="stat-card stat-orange">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <div class="stat-icon"><i class="bi bi-exclamation-triangle-fill"></i></div>
                                    <span class="stat-trend">Action Needed</span>
                                </div>
                                <div class="stat-value">
                                    <asp:Label ID="lblLowStock" runat="server" Text="0" ClientIDMode="Static" />
                                </div>
                                <div class="stat-label">Low Stock</div>
                            </div>
                        </div>
                        <div class="col-6 col-lg-3">
                            <div class="stat-card stat-red">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <div class="stat-icon"><i class="bi bi-file-medical-fill"></i></div>
                                    <span class="stat-trend">Rx-only</span>
                                </div>
                                <div class="stat-value">
                                    <asp:Label ID="lblRxRequired" runat="server" Text="0" ClientIDMode="Static" />
                                </div>
                                <div class="stat-label">Rx Required</div>
                            </div>
                        </div>
                    </div>

                    <!-- Medicine DataList -->
                    <div class="data-card">
                        <div class="data-card-header">
                            <div class="data-card-title"><i class="bi bi-capsule me-2 text-primary"></i>Medicine Catalog</div>
                            <div class="d-flex gap-2 flex-wrap">
                                <div class="search-bar" style="max-width: 220px">
                                    <i class="bi bi-search"></i>
                                    <asp:TextBox ID="searchMed" runat="server" CssClass="form-control" placeholder="Search medicines..." ClientIDMode="Static" />
                                </div>
                                <asp:DropDownList ID="catFilter" runat="server" CssClass="form-select form-control-custom" Style="max-width: 160px; height: 40px; font-size: .88rem" ClientIDMode="Static">
                                    <asp:ListItem Value="">All Categories</asp:ListItem>
                                </asp:DropDownList>
                                <asp:LinkButton ID="btnOpenAddMedAdmin" runat="server" CssClass="btn btn-primary-custom fw-600"
                                    OnClientClick="return false;" data-bs-toggle="modal" data-bs-target="#addMedModal" ClientIDMode="Static">
            <i class="bi bi-plus me-1"></i>Add Medicine
                                </asp:LinkButton>
                            </div>
                        </div>
                        <div class="table-wrap">
                            <asp:GridView ID="gvMedicines" runat="server"
                                AutoGenerateColumns="False"
                                OnRowCommand="gvMedicines_RowCommand"
                                CssClass="table table-bordered table-striped"
                                ClientIDMode="Static">
                                <Columns>
                                    <asp:TemplateField HeaderText="Medicine ID">
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server"
                                                Text='<%# Eval("MedicineID") %>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Medicine Name">
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server"
                                                Text='<%# Eval("Name") %>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Brand">
                                        <ItemTemplate>
                                            <asp:Label ID="Label3" runat="server"
                                                Text='<%# Eval("BrandName") %>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Category">
                                        <ItemTemplate>
                                            <asp:Label ID="Label4" runat="server"
                                                Text='<%# Eval("CategoryName") %>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Price">
                                        <ItemTemplate>
                                            <asp:Label ID="Label5" runat="server"
                                                Text='<%# Eval("Price") %>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Stock">
                                        <ItemTemplate>
                                            <asp:Label ID="Label6" runat="server"
                                                Text='<%# Eval("Stock") %>'>
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Edit">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton1"
                                                runat="server"
                                                CommandName="cmd_edt"
                                                CommandArgument='<%# Eval("MedicineID") %>'>
                  Edit
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Delete">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton2"
                                                runat="server"
                                                CommandName="cmd_del"
                                                CommandArgument='<%# Eval("MedicineID") %>'
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
        <!-- Add Medicine Modal -->
        <div class="modal fade modal-custom" id="addMedModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">

                    <div class="modal-header">
                        <h5 class="modal-title fw-700">
                            <i class="bi bi-capsule me-2"></i>Add New Medicine
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">
                        <div class="row g-3">

                            <!-- Name -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Medicine Name</label>
                                <asp:TextBox ID="txtMedName" runat="server"
                                    CssClass="form-control form-control-custom"
                                    placeholder="e.g. Paracetamol 500mg"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Generic Name -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Generic Name</label>
                                <asp:TextBox ID="txtGenericName" runat="server"
                                    CssClass="form-control form-control-custom"
                                    placeholder="e.g. Acetaminophen"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Brand -->
                            <div class="col-md-4">
                                <label class="form-label fw-600">Brand</label>
                                <asp:DropDownList ID="ddlMedBrand" runat="server"
                                    CssClass="form-select form-control-custom"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Category -->
                            <div class="col-md-4">
                                <label class="form-label fw-600">Category</label>
                                <asp:DropDownList ID="ddlMedCategory" runat="server"
                                    CssClass="form-select form-control-custom"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Medicine Type -->
                            <div class="col-md-4">
                                <label class="form-label fw-600">Medicine Type</label>
                                <asp:TextBox ID="txtMedType" runat="server"
                                    CssClass="form-control form-control-custom"
                                    placeholder="e.g. Tablet"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Dosage Form -->
                            <div class="col-md-4">
                                <label class="form-label fw-600">Dosage Form</label>
                                <asp:TextBox ID="txtMedDosageForm" runat="server"
                                    CssClass="form-control form-control-custom"
                                    placeholder="e.g. Oral"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Strength -->
                            <div class="col-md-4">
                                <label class="form-label fw-600">Strength</label>
                                <asp:TextBox ID="txtMedStrength" runat="server"
                                    CssClass="form-control form-control-custom"
                                    placeholder="e.g. 500mg"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Pack Size -->
                            <div class="col-md-4">
                                <label class="form-label fw-600">Pack Size</label>
                                <asp:TextBox ID="txtMedPackSize" runat="server"
                                    CssClass="form-control form-control-custom"
                                    placeholder="e.g. 10 Tablets"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Price -->
                            <div class="col-md-4">
                                <label class="form-label fw-600">Price (&#8377;)</label>
                                <asp:TextBox ID="txtMedPrice" runat="server"
                                    TextMode="Number"
                                    CssClass="form-control form-control-custom"
                                    placeholder="0.00"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- MRP -->
                            <div class="col-md-4">
                                <label class="form-label fw-600">MRP (&#8377;)</label>
                                <asp:TextBox ID="txtMedMRP" runat="server"
                                    TextMode="Number"
                                    CssClass="form-control form-control-custom"
                                    placeholder="0.00"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Stock -->
                            <div class="col-md-4">
                                <label class="form-label fw-600">Stock Qty</label>
                                <asp:TextBox ID="txtMedStock" runat="server"
                                    TextMode="Number"
                                    CssClass="form-control form-control-custom"
                                    placeholder="0"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Minimum Stock -->
                            <div class="col-md-4">
                                <label class="form-label fw-600">Minimum Stock Level</label>
                                <asp:TextBox ID="txtMedMinStockLevel" runat="server"
                                    TextMode="Number"
                                    CssClass="form-control form-control-custom"
                                    placeholder="20"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Discount -->
                            <div class="col-md-4">
                                <label class="form-label fw-600">Discount (%)</label>
                                <asp:TextBox ID="txtMedDiscount" runat="server"
                                    TextMode="Number"
                                    CssClass="form-control form-control-custom"
                                    placeholder="0"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Image Upload -->
                            <div class="col-md-8">
                                <label class="form-label fw-600">Image Upload</label>
                                <asp:FileUpload ID="FileUpload1" runat="server"
                                    CssClass="form-control form-control-custom"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Rx Required -->
                            <div class="col-md-4 d-flex align-items-end">
                                <div class="form-check">
                                    <asp:CheckBox ID="chkRxRequired" runat="server"
                                        CssClass="form-check-input"
                                        Text=" Rx Required"
                                        ClientIDMode="Static" />
                                </div>
                            </div>

                            <!-- Description -->
                            <div class="col-12">
                                <label class="form-label fw-600">Description</label>
                                <asp:TextBox ID="txtMedDesc" runat="server"
                                    TextMode="MultiLine"
                                    Rows="2"
                                    CssClass="form-control form-control-custom"
                                    placeholder="Brief description..."
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Uses -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Uses</label>
                                <asp:TextBox ID="txtMedUses" runat="server"
                                    TextMode="MultiLine"
                                    Rows="2"
                                    CssClass="form-control form-control-custom"
                                    placeholder="Medicine uses..."
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Dosage -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Dosage</label>
                                <asp:TextBox ID="txtMedDosage" runat="server"
                                    TextMode="MultiLine"
                                    Rows="2"
                                    CssClass="form-control form-control-custom"
                                    placeholder="Dosage information..."
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Side Effects -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Side Effects</label>
                                <asp:TextBox ID="txtMedSideEffects" runat="server"
                                    TextMode="MultiLine"
                                    Rows="2"
                                    CssClass="form-control form-control-custom"
                                    placeholder="Possible side effects..."
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Interactions -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Interactions</label>
                                <asp:TextBox ID="txtMedInteractions" runat="server"
                                    TextMode="MultiLine"
                                    Rows="2"
                                    CssClass="form-control form-control-custom"
                                    placeholder="Drug interactions..."
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Precautions -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Precautions</label>
                                <asp:TextBox ID="txtMedPrecautions" runat="server"
                                    TextMode="MultiLine"
                                    Rows="2"
                                    CssClass="form-control form-control-custom"
                                    placeholder="Precautions..."
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Composition -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Composition</label>
                                <asp:TextBox ID="txtMedComposition" runat="server"
                                    TextMode="MultiLine"
                                    Rows="2"
                                    CssClass="form-control form-control-custom"
                                    placeholder="Medicine composition..."
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Inactive Ingredients -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Inactive Ingredients</label>
                                <asp:TextBox ID="txtMedInactiveIngredients" runat="server"
                                    TextMode="MultiLine"
                                    Rows="2"
                                    CssClass="form-control form-control-custom"
                                    placeholder="Inactive ingredients..."
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Storage -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Storage</label>
                                <asp:TextBox ID="txtMedStorage" runat="server"
                                    TextMode="MultiLine"
                                    Rows="2"
                                    CssClass="form-control form-control-custom"
                                    placeholder="Storage instructions..."
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Manufacturer -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Manufacturer</label>
                                <asp:TextBox ID="txtMedManufacturer" runat="server"
                                    CssClass="form-control form-control-custom"
                                    placeholder="Manufacturer name"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Country -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Country of Origin</label>
                                <asp:TextBox ID="txtMedCountry" runat="server"
                                    CssClass="form-control form-control-custom"
                                    placeholder="e.g. India"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Status -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Status</label>
                                <asp:DropDownList ID="ddlMedStatus" runat="server"
                                    CssClass="form-select form-control-custom"
                                    ClientIDMode="Static">
                                    <asp:ListItem Text="Active" Value="Active" />
                                    <asp:ListItem Text="Inactive" Value="Inactive" />
                                </asp:DropDownList>
                            </div>

                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button"
                            class="btn btn-secondary-custom"
                            data-bs-dismiss="modal">
                            Cancel
                        </button>

                        <%--<asp:LinkButton ID="btnAddMedSubmit"
          runat="server"
          CssClass="btn btn-primary-custom fw-600"
          OnClientClick="bootstrap.Modal.getInstance(document.getElementById('addMedModal')).hide(); return false;"
          ClientIDMode="Static">
          <i class="bi bi-check-lg me-1"></i>Add Medicine
        </asp:LinkButton>--%>

                        <asp:LinkButton ID="btnAddMedSubmit"
                            runat="server"
                            CssClass="btn btn-primary-custom fw-600"
                            OnClick="btnAddMedSubmit_Click"
                            ClientIDMode="Static">
                            Add Medicine
                        </asp:LinkButton>
                    </div>

                </div>
            </div>
        </div>


        <!-- Edit Medicine Modal -->
        <div class="modal fade modal-custom" id="editMedModal" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">

                    <div class="modal-header">
                        <h5 class="modal-title fw-700">
                            <i class="bi bi-pencil me-2"></i>Edit Medicine
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">
                        <div class="row g-3">

                            <!-- Name -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Medicine Name</label>
                                <asp:TextBox ID="txtEditMedName" runat="server"
                                    CssClass="form-control form-control-custom"
                                    placeholder="e.g. Paracetamol 500mg"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Generic Name -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Generic Name</label>
                                <asp:TextBox ID="txtEditGenericName" runat="server"
                                    CssClass="form-control form-control-custom"
                                    placeholder="e.g. Acetaminophen"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Brand -->
                            <div class="col-md-4">
                                <label class="form-label fw-600">Brand</label>
                                <asp:DropDownList ID="ddlEditMedBrand" runat="server"
                                    CssClass="form-select form-control-custom"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Category -->
                            <div class="col-md-4">
                                <label class="form-label fw-600">Category</label>
                                <asp:DropDownList ID="ddlEditMedCategory" runat="server"
                                    CssClass="form-select form-control-custom"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Medicine Type -->
                            <div class="col-md-4">
                                <label class="form-label fw-600">Medicine Type</label>
                                <asp:TextBox ID="txtEditMedType" runat="server"
                                    CssClass="form-control form-control-custom"
                                    placeholder="e.g. Tablet"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Dosage Form -->
                            <div class="col-md-4">
                                <label class="form-label fw-600">Dosage Form</label>
                                <asp:TextBox ID="txtEditMedDosageForm" runat="server"
                                    CssClass="form-control form-control-custom"
                                    placeholder="e.g. Oral"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Strength -->
                            <div class="col-md-4">
                                <label class="form-label fw-600">Strength</label>
                                <asp:TextBox ID="txtEditMedStrength" runat="server"
                                    CssClass="form-control form-control-custom"
                                    placeholder="e.g. 500mg"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Pack Size -->
                            <div class="col-md-4">
                                <label class="form-label fw-600">Pack Size</label>
                                <asp:TextBox ID="txtEditMedPackSize" runat="server"
                                    CssClass="form-control form-control-custom"
                                    placeholder="e.g. 10 Tablets"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Price -->
                            <div class="col-md-4">
                                <label class="form-label fw-600">Price (&#8377;)</label>
                                <asp:TextBox ID="txtEditMedPrice" runat="server"
                                    TextMode="Number"
                                    CssClass="form-control form-control-custom"
                                    placeholder="0.00"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- MRP -->
                            <div class="col-md-4">
                                <label class="form-label fw-600">MRP (&#8377;)</label>
                                <asp:TextBox ID="txtEditMedMRP" runat="server"
                                    TextMode="Number"
                                    CssClass="form-control form-control-custom"
                                    placeholder="0.00"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Stock -->
                            <div class="col-md-4">
                                <label class="form-label fw-600">Stock Qty</label>
                                <asp:TextBox ID="txtEditMedStock" runat="server"
                                    TextMode="Number"
                                    CssClass="form-control form-control-custom"
                                    placeholder="0"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Minimum Stock -->
                            <div class="col-md-4">
                                <label class="form-label fw-600">Minimum Stock Level</label>
                                <asp:TextBox ID="txtEditMedMinStockLevel" runat="server"
                                    TextMode="Number"
                                    CssClass="form-control form-control-custom"
                                    placeholder="20"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Discount -->
                            <div class="col-md-4">
                                <label class="form-label fw-600">Discount (%)</label>
                                <asp:TextBox ID="txtEditMedDiscount" runat="server"
                                    TextMode="Number"
                                    CssClass="form-control form-control-custom"
                                    placeholder="0"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Image Upload -->
                            <div class="col-md-8">
                                <label class="form-label fw-600">Image Upload</label>
                                <asp:FileUpload ID="FileUpload2" runat="server"
                                    CssClass="form-control form-control-custom"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Rx Required -->
                            <div class="col-md-4 d-flex align-items-end">
                                <div class="form-check">
                                    <asp:CheckBox ID="chkEditRxRequired" runat="server"
                                        CssClass="form-check-input"
                                        Text=" Rx Required"
                                        ClientIDMode="Static" />
                                </div>
                            </div>

                            <!-- Description -->
                            <div class="col-12">
                                <label class="form-label fw-600">Description</label>
                                <asp:TextBox ID="txtEditMedDesc" runat="server"
                                    TextMode="MultiLine"
                                    Rows="2"
                                    CssClass="form-control form-control-custom"
                                    placeholder="Brief description..."
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Uses -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Uses</label>
                                <asp:TextBox ID="txtEditMedUses" runat="server"
                                    TextMode="MultiLine"
                                    Rows="2"
                                    CssClass="form-control form-control-custom"
                                    placeholder="Medicine uses..."
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Dosage -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Dosage</label>
                                <asp:TextBox ID="txtEditMedDosage" runat="server"
                                    TextMode="MultiLine"
                                    Rows="2"
                                    CssClass="form-control form-control-custom"
                                    placeholder="Dosage information..."
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Side Effects -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Side Effects</label>
                                <asp:TextBox ID="txtEditMedSideEffects" runat="server"
                                    TextMode="MultiLine"
                                    Rows="2"
                                    CssClass="form-control form-control-custom"
                                    placeholder="Possible side effects..."
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Interactions -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Interactions</label>
                                <asp:TextBox ID="txtEditMedInteractions" runat="server"
                                    TextMode="MultiLine"
                                    Rows="2"
                                    CssClass="form-control form-control-custom"
                                    placeholder="Drug interactions..."
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Precautions -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Precautions</label>
                                <asp:TextBox ID="txtEditMedPrecautions" runat="server"
                                    TextMode="MultiLine"
                                    Rows="2"
                                    CssClass="form-control form-control-custom"
                                    placeholder="Precautions..."
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Composition -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Composition</label>
                                <asp:TextBox ID="txtEditMedComposition" runat="server"
                                    TextMode="MultiLine"
                                    Rows="2"
                                    CssClass="form-control form-control-custom"
                                    placeholder="Medicine composition..."
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Inactive Ingredients -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Inactive Ingredients</label>
                                <asp:TextBox ID="txtEditMedInactiveIngredients" runat="server"
                                    TextMode="MultiLine"
                                    Rows="2"
                                    CssClass="form-control form-control-custom"
                                    placeholder="Inactive ingredients..."
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Storage -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Storage</label>
                                <asp:TextBox ID="txtEditMedStorage" runat="server"
                                    TextMode="MultiLine"
                                    Rows="2"
                                    CssClass="form-control form-control-custom"
                                    placeholder="Storage instructions..."
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Manufacturer -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Manufacturer</label>
                                <asp:TextBox ID="txtEditMedManufacturer" runat="server"
                                    CssClass="form-control form-control-custom"
                                    placeholder="Manufacturer name"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Country -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Country of Origin</label>
                                <asp:TextBox ID="txtEditMedCountry" runat="server"
                                    CssClass="form-control form-control-custom"
                                    placeholder="e.g. India"
                                    ClientIDMode="Static" />
                            </div>

                            <!-- Status -->
                            <div class="col-md-6">
                                <label class="form-label fw-600">Status</label>
                                <asp:DropDownList ID="ddlEditMedStatus" runat="server"
                                    CssClass="form-select form-control-custom"
                                    ClientIDMode="Static">
                                    <asp:ListItem Text="Active" Value="Active" />
                                    <asp:ListItem Text="Inactive" Value="Inactive" />
                                </asp:DropDownList>
                            </div>

                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button"
                            class="btn btn-secondary-custom"
                            data-bs-dismiss="modal">
                            Cancel
                        </button>

                        <asp:LinkButton ID="btnEditMedSubmit"
                            runat="server"
                            CssClass="btn btn-primary-custom fw-600"
                            OnClick="btnEditMedSubmit_Click"
                            ClientIDMode="Static">
    Update Medicine
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
                document.getElementById('headerMount').innerHTML = ADMIN_HEADER('Medicine Catalog', 'Medicines');
                initSidebar('adminSidebar', 'adminOverlay');
                filterTable('searchMed', 'gvMedicines');
            });
        </script>
    </body>
</asp:Content>
