<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="medicare.customer.register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
<asp:Content ID="Content5" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <body>
<div class="auth-wrapper auth-wrapper-register">
  <div class="container py-4 py-lg-5 position-relative" style="z-index:1">
    <div class="row justify-content-center g-4 align-items-stretch">
      <div class="col-lg-5 col-xl-4 d-none d-lg-block">
        <div class="auth-side-panel h-100">
          <div class="auth-side-badge"><i class="bi bi-shield-check me-2"></i> Secure checkout and verified medicines</div>
          <h2 class="auth-side-title">A premium pharmacy experience starts here.</h2>
          <p class="auth-side-text">Create your account to get faster ordering, prescription tracking, and a smoother delivery experience built around your health needs.</p>

          <div class="auth-metric-grid">
            <div class="auth-metric-card">
              <div class="auth-metric-value">24/7</div>
              <div class="auth-metric-label">Pharmacist support</div>
            </div>
            <div class="auth-metric-card">
              <div class="auth-metric-value">1 hr</div>
              <div class="auth-metric-label">Fast delivery slots</div>
            </div>
            <div class="auth-metric-card">
              <div class="auth-metric-value">100%</div>
              <div class="auth-metric-label">Genuine products</div>
            </div>
          </div>

          <div class="auth-side-list">
            <div><i class="bi bi-check2-circle"></i> Save addresses and reorder in seconds</div>
            <div><i class="bi bi-check2-circle"></i> Upload prescriptions securely from any device</div>
            <div><i class="bi bi-check2-circle"></i> Get order updates and refill reminders</div>
          </div>
        </div>
      </div>

      <div class="col-lg-7 col-xl-8">
        <div class="auth-card auth-card-register">
          <div class="auth-logo">
            <div class="brand-icon"><i class="bi bi-capsule-pill"></i></div>
            <div class="auth-title">Create Account</div>
            <div class="auth-subtitle">Join MediCare and get medicines delivered with confidence</div>
          </div>

          <div id="regForm">
            <div class="row g-3">
              <div class="col-6">
                <label class="form-label fw-600 small">First Name</label>
                <asp:TextBox ID="regFirstName" runat="server" CssClass="form-control form-control-custom"  />
              </div>
              <div class="col-6">
                <label class="form-label fw-600 small">Last Name</label>
                <asp:TextBox ID="regLastName" runat="server" CssClass="form-control form-control-custom"  />
              </div>
              <div class="col-12">
                <label class="form-label fw-600 small">Email Address</label>
                <div class="input-group-custom">
                  <i class="bi bi-envelope input-icon"></i>
                  <asp:TextBox ID="regEmail" runat="server" TextMode="Email" CssClass="form-control form-control-custom"  />
                </div>
              </div>
              <div class="col-12">
                <label class="form-label fw-600 small">Phone Number</label>
                <div class="input-group-custom">
                  <i class="bi bi-phone input-icon"></i>
                  <asp:TextBox ID="regPhone" runat="server" TextMode="Phone" CssClass="form-control form-control-custom"  />
                </div>
              </div>
              <div class="col-12">
                <label class="form-label fw-600 small">Date of Birth</label>
                <asp:TextBox ID="regDob" runat="server" TextMode="Date" CssClass="form-control form-control-custom" />
              </div>
              <div class="col-12">
                <label class="form-label fw-600 small">Gender</label>
                <asp:DropDownList ID="regGender" runat="server" CssClass="form-control form-control-custom" >
                  <asp:ListItem Value="" Selected="True" Disabled="True">Select Gender</asp:ListItem>
                  <asp:ListItem Value="Male">Male</asp:ListItem>
                  <asp:ListItem Value="Female">Female</asp:ListItem>
                  <asp:ListItem Value="Other">Other</asp:ListItem>
                </asp:DropDownList>
              </div>
              <div class="col-md-6">
                <label class="form-label fw-600 small">Password</label>
                <div class="input-group-custom position-relative">
                  <i class="bi bi-lock input-icon"></i>
                  <asp:TextBox ID="regPass" runat="server" TextMode="Password" CssClass="form-control form-control-custom"  placeholder="Min 8 characters" style="padding-left:2.5rem;padding-right:2.5rem" />
                  <button type="button" class="btn p-0 position-absolute" style="right:.9rem;top:50%;transform:translateY(-50%);border:none;background:none;color:var(--gray-400)" onclick="togglePwd('regPass',this)"><i class="bi bi-eye"></i></button>
                </div>
              </div>
              <div class="col-md-6">
                <label class="form-label fw-600 small">Confirm Password</label>
                <div class="input-group-custom position-relative">
                  <i class="bi bi-lock input-icon"></i>
                  <asp:TextBox ID="regPass2" runat="server" TextMode="Password" CssClass="form-control form-control-custom"  placeholder="Repeat password" style="padding-left:2.5rem;padding-right:2.5rem" />
                  <button type="button" class="btn p-0 position-absolute" style="right:.9rem;top:50%;transform:translateY(-50%);border:none;background:none;color:var(--gray-400)" onclick="togglePwd('regPass2',this)"><i class="bi bi-eye"></i></button>
                </div>
              </div>
              <div class="col-12">
                <div class="d-flex align-items-start gap-2">
                  <asp:CheckBox ID="CheckBox1" runat="server" CssClass="form-check-input mt-1"  />
                  <label class="form-check-label small" for="terms">I agree to the <a href="#" class="text-primary">Terms of Service</a> and <a href="#" class="text-primary">Privacy Policy</a></label>
                </div>
              </div>
              <div class="col-12">
                <asp:Button ID="btnRegister" runat="server" Text="Create Account" CssClass="btn btn-primary-custom w-100 py-2 fw-600" OnClick="btnRegister_Click" />
              </div>
            </div>
          </div>

          <div class="mt-4">
            <h5 class="fw-700 mb-3">Registered Accounts</h5>
            <div class="table-responsive">
              <asp:GridView ID="GridView1" runat="server" CssClass="table table-bordered table-striped" AutoGenerateColumns="False">
                  <Columns>
                      <asp:TemplateField HeaderText="Id">
                          <ItemTemplate>
                              <asp:Label ID="Label1" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="FirstName">
                          <ItemTemplate>
                              <asp:Label ID="Label2" runat="server" Text='<%# Eval("FirstName") %>'></asp:Label>
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="LastName">
                          <ItemTemplate>
                              <asp:Label ID="Label3" runat="server" Text='<%# Eval("LastName") %>'></asp:Label>
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="Email">
                          <ItemTemplate>
                              <asp:Label ID="Label4" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="Phone">
                          <ItemTemplate>
                              <asp:Label ID="Label5" runat="server" Text='<%# Eval("Phone") %>'></asp:Label>
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="Date of Birth">
                          <ItemTemplate>
                              <asp:Label ID="Label6" runat="server" Text='<%# Eval("DOB") %>'></asp:Label>
                          </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField HeaderText="Gender">
                          <ItemTemplate>
                              <asp:Label ID="Label7" runat="server" Text='<%# Eval("Gender") %>'></asp:Label>
                          </ItemTemplate>
                      </asp:TemplateField>
                  </Columns>
              </asp:GridView>
            </div>
          </div>
             

          <p class="text-center mt-4 mb-0" style="font-size:.88rem">
            Already have an account? <a href="login.html" class="text-primary fw-600">Sign In</a>
          </p>

        </div>
      </div>
    </div>
  </div>
</div>
<div id="toast-container"></div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="../assets/js/main.js"></script>
<script>
    function togglePwd(id, btn) {
        const inp = document.getElementById(id);
        const isText = inp.type === 'text';
        inp.type = isText ? 'password' : 'text';
        btn.querySelector('i').className = isText ? 'bi bi-eye' : 'bi bi-eye-slash';
    }
    document.getElementById('regForm').addEventListener('submit', function (e) {
        e.preventDefault();
        const firstName = document.getElementById('regFirstName').value.trim();
        const lastName = document.getElementById('regLastName').value.trim();
        const email = document.getElementById('regEmail').value.trim();
        const password = document.getElementById('regPass').value;
        const confirmPassword = document.getElementById('regPass2').value;
        const termsAccepted = document.getElementById('terms').checked;

        if (!termsAccepted) {
            showToast('Please accept the terms to continue.', 'error');
            return;
        }

        if (password !== confirmPassword) {
            showToast('Passwords do not match.', 'error');
            return;
        }

        showLoader();
        setTimeout(() => {
            localStorage.setItem('medicare_logged_in', 'true');
            localStorage.setItem('medicare_user_name', `${firstName || 'Priya'} ${lastName || 'Sharma'}`);
            localStorage.setItem('medicare_user_email', email || 'priya@example.com');
            hideLoader();
            showToast('Account created successfully! Welcome to MediCare!', 'success');
            setTimeout(() => window.location.href = '../index.html', 1200);
        }, 1500);
    });
</script>
</body>
</asp:Content>

