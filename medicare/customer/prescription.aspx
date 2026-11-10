<%@ Page Title="Upload Prescription — MediCare Pharmacy" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="prescription.aspx.cs" Inherits="medicare.customer.prescription" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <link rel="stylesheet" href="../assets/css/customer.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
<asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
<body>
<nav class="navbar navbar-expand-lg customer-navbar">
  <div class="container">
    <a class="navbar-brand navbar-brand-custom" href="../index.aspx">
      <div class="brand-icon"><i class="bi bi-capsule-pill"></i></div>
      <span>Medi<b>Care</b></span>
    </a>
    <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navRx">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navRx">
      <ul class="navbar-nav mx-auto gap-1" id="navLinks"></ul>

      <div class="d-flex align-items-center gap-3">
        <div class="search-bar d-none d-lg-block" style="max-width:220px">
          <i class="bi bi-search"></i>
          <input type="text" class="form-control nav-search-input" placeholder="Search medicines...">
        </div>
        <a href="cart.aspx" class="cart-btn" title="Cart"><i class="bi bi-cart3"></i><span class="cart-count" id="navCartCount">0</span></a>
        <div id="navAccountArea"></div>
      </div>
    </div>
  </div>
</nav>

<div class="page-hero mb-4">
  <div class="container" style="position:relative;z-index:1">
    <div class="hero-kicker mb-2"><i class="bi bi-file-medical-fill me-2"></i>Prescription Service</div>
    <h1 style="font-size:2rem;font-weight:800;color:#fff;margin-bottom:.5rem">Upload Your Prescription</h1>
    <p style="color:rgba(255,255,255,.75);font-size:.95rem">Our licensed pharmacists will verify your prescription within 30 minutes and prepare your order.</p>
  </div>
</div>

<div class="container pb-5">
  <div class="row g-4">
    <div class="col-lg-7">
      <div id="rxFormWrap">
        <!-- Upload Form -->
        <div class="card-custom p-4 mb-4">
          <h6 class="fw-700 mb-3"><i class="bi bi-cloud-upload-fill text-primary me-2"></i>Upload Prescription</h6>
          <div class="dropzone" id="mainDropzone" onclick="document.getElementById('rxUpload').click()">
            <i class="bi bi-file-medical-fill" style="color:var(--primary)"></i>
            <div class="dropzone-title">Drop your prescription here</div>
            <p class="dropzone-sub">Supports JPG, PNG, PDF &bull; Max size 5MB</p>
            <button type="button" class="btn btn-primary-custom btn-sm px-4 mt-2" onclick="event.stopPropagation(); document.getElementById('rxUpload').click();">Choose File</button>
            <asp:FileUpload ID="rxUpload" runat="server" ClientIDMode="Static" style="display:none" />
          </div>
          <div id="rxPreviewBox"></div>
        </div>
        <!-- Notes -->
        <div class="card-custom p-4 mb-4">
          <h6 class="fw-700 mb-3"><i class="bi bi-chat-text-fill text-primary me-2"></i>Notes for Pharmacist</h6>
          <asp:TextBox ID="txtRxNotes" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control form-control-custom" placeholder="Any specific notes? (e.g. generic substitute preferred, allergies, dosage instructions)" ClientIDMode="Static" />
        </div>
        <asp:Button ID="btnSubmitRx" runat="server" Text="Submit for Verification" CssClass="btn btn-primary-custom w-100 py-2 fw-700" OnClick="btnSubmitRx_Click" />
      </div>
      <div class="trust-seals mt-3">
        <div class="trust-seal"><i class="bi bi-shield-check-fill"></i>100% Confidential</div>
        <div class="trust-seal"><i class="bi bi-clock-fill" style="color:var(--primary)"></i>Verified in 30 min</div>
        <div class="trust-seal"><i class="bi bi-patch-check-fill" style="color:#8B5CF6"></i>Licensed Pharmacists</div>
      </div>
    </div>
    <div class="col-lg-5">
      <!-- Guidelines -->
      <div class="rx-tip-card mb-4">
        <div class="fw-700 mb-3" style="font-size:.95rem"><i class="bi bi-info-circle-fill text-primary me-2"></i>Prescription Guidelines</div>
        <div class="rx-tip-item"><i class="bi bi-check-circle-fill text-success"></i><span>Prescription must be from a registered MCI doctor</span></div>
        <div class="rx-tip-item"><i class="bi bi-check-circle-fill text-success"></i><span>Date of prescription must be within last 6 months</span></div>
        <div class="rx-tip-item"><i class="bi bi-check-circle-fill text-success"></i><span>Patient name &amp; doctor's signature must be clearly visible</span></div>
        <div class="rx-tip-item"><i class="bi bi-check-circle-fill text-success"></i><span>Image must be clear, not blurry or cropped</span></div>
        <div class="rx-tip-item" style="border-bottom:none"><i class="bi bi-x-circle-fill text-danger"></i><span>Handwritten prescriptions without doctor stamp not accepted</span></div>
      </div>
      <!-- Previous Prescriptions -->
      <div class="card-custom p-4">
        <h6 class="fw-700 mb-3"><i class="bi bi-clock-history text-primary me-2"></i>Previous Prescriptions</h6>
        <div class="d-flex flex-column gap-2">
          <asp:Repeater ID="rptPrescriptions" runat="server">
            <ItemTemplate>
              <div class="prescription-preview">
                <div style="width:48px;height:48px;background:rgba(26,107,204,.1);border-radius:10px;display:flex;align-items:center;justify-content:center;flex-shrink:0">
                  <i class="bi bi-file-medical-fill" style="font-size:1.2rem;color:var(--primary)"></i>
                </div>
                <div class="flex-1">
                  <div class="fw-600" style="font-size:.88rem"><%# Eval("PrescriptionCode") %></div>
                  <small class="text-muted"><i class="bi bi-calendar3 me-1"></i><%# Eval("CreatedAt", "{0:dd MMM yyyy}") %></small>
                </div>
                <span class='badge-custom badge-<%# Eval("Status").ToString() == "Approved" || Eval("Status").ToString() == "Verified" ? "success" : (Eval("Status").ToString() == "Rejected" ? "danger" : "warning") %>'>
                  <%# Eval("Status") %>
                </span>
              </div>
            </ItemTemplate>
          </asp:Repeater>
          <asp:Label ID="lblNoRx" runat="server" Text="No previous prescriptions found." Visible="false" CssClass="text-muted small" />
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Success Modal -->
<div class="modal fade modal-custom" id="successModal" tabindex="-1" data-bs-backdrop="static">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-body text-center p-5">
        <div style="font-size:3.5rem;margin-bottom:1rem">✅</div>
        <h5 class="fw-800 text-success">Prescription Submitted!</h5>
        <p class="text-muted">Your prescription has been submitted for verification. Our pharmacist will review it within 30 minutes.</p>
        <div class="alert-custom alert-info-custom mt-3"><i class="bi bi-info-circle-fill"></i>Ref: <strong>RX-20241220</strong></div>
        <a href="medicines.aspx" class="btn btn-primary-custom mt-3 fw-600">Browse Medicines</a>
      </div>
    </div>
  </div>
</div>

<div id="toast-container"></div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
  window.sessionUser = '<%= Session["customer"] != null ? Session["customer"].ToString() : "" %>';
  window.sessionRole = 'customer';
</script><script src="../assets/js/main.js"></script>
<script>
initDropzone('mainDropzone', 'rxUpload', 'rxPreviewBox');
function submitPrescription() {
  showLoader();
  setTimeout(() => { hideLoader(); new bootstrap.Modal(document.getElementById('successModal')).show(); }, 1800);
}
</script>
</body>
</asp:Content>
