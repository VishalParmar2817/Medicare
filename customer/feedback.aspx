<%@ Page Title="Feedback & Reviews — MediCare Pharmacy" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="feedback.aspx.cs" Inherits="medicare.customer.feedback" %>

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
    <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navFb">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navFb">
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

<div class="container py-4">
  <div class="row g-4">
    <!-- Write Review -->
    <div class="col-lg-5">
      <div class="card-custom p-4 mb-4">
        <h5 class="fw-700 mb-3"><i class="bi bi-star-fill text-warning me-2"></i>Write a Review</h5>
        <div class="mb-3">
          <label class="form-label fw-600 small">Select Medicine</label>
          <asp:DropDownList ID="ddlMedicine" runat="server" CssClass="form-control form-control-custom">
            <asp:ListItem>Select a purchased medicine...</asp:ListItem>
            <asp:ListItem>Paracetamol 500mg</asp:ListItem>
            <asp:ListItem>Vitamin D3 1000IU</asp:ListItem>
            <asp:ListItem>Cetirizine 10mg</asp:ListItem>
          </asp:DropDownList>
        </div>
        <div class="mb-3">
          <label class="form-label fw-600 small">Your Rating</label>
          <asp:RadioButtonList ID="rblRating" runat="server" RepeatDirection="Horizontal" CssClass="d-flex gap-2 star-rating-rbl">
            <asp:ListItem Value="1"> 1 Star</asp:ListItem>
            <asp:ListItem Value="2"> 2 Stars</asp:ListItem>
            <asp:ListItem Value="3"> 3 Stars</asp:ListItem>
            <asp:ListItem Value="4"> 4 Stars</asp:ListItem>
            <asp:ListItem Value="5" Selected="True"> 5 Stars</asp:ListItem>
          </asp:RadioButtonList>
        </div>
        <div class="mb-3">
          <label class="form-label fw-600 small">Review Title</label>
          <asp:TextBox ID="txtReviewTitle" runat="server" CssClass="form-control form-control-custom" placeholder="Summarize your experience" ClientIDMode="Static" />
        </div>
        <div class="mb-3">
          <label class="form-label fw-600 small">Your Review</label>
          <asp:TextBox ID="txtReviewComments" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control form-control-custom" placeholder="Share your detailed experience with this medicine..." ClientIDMode="Static" />
        </div>
        <asp:Button ID="btnSubmitReview" runat="server" Text="Submit Review" CssClass="btn btn-primary-custom w-100 fw-600" OnClick="btnSubmitReview_Click" />
      </div>
      <!-- Overall Stats -->
      <div class="card-custom p-4">
        <h6 class="fw-700 mb-3">Overall Ratings</h6>
        <div class="text-center mb-3">
          <div style="font-size:3rem;font-weight:800;color:var(--primary)">4.6</div>
          <div class="star-rating mb-1"><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-half"></i></div>
          <small class="text-muted">Based on 2,847 reviews</small>
        </div>
        <div class="d-flex flex-column gap-2">
          <div class="d-flex align-items-center gap-2"><span style="font-size:.8rem;width:20px">5★</span><div class="flex-1 rounded" style="height:8px;background:var(--gray-200);overflow:hidden"><div style="width:72%;height:100%;background:#22c55e;border-radius:99px"></div></div><span style="font-size:.8rem;width:30px;text-align:right">72%</span></div>
          <div class="d-flex align-items-center gap-2"><span style="font-size:.8rem;width:20px">4★</span><div class="flex-1 rounded" style="height:8px;background:var(--gray-200);overflow:hidden"><div style="width:18%;height:100%;background:#22c55e;border-radius:99px"></div></div><span style="font-size:.8rem;width:30px;text-align:right">18%</span></div>
          <div class="d-flex align-items-center gap-2"><span style="font-size:.8rem;width:20px">3★</span><div class="flex-1 rounded" style="height:8px;background:var(--gray-200);overflow:hidden"><div style="width:6%;height:100%;background:#f59e0b;border-radius:99px"></div></div><span style="font-size:.8rem;width:30px;text-align:right">6%</span></div>
          <div class="d-flex align-items-center gap-2"><span style="font-size:.8rem;width:20px">2★</span><div class="flex-1 rounded" style="height:8px;background:var(--gray-200);overflow:hidden"><div style="width:2%;height:100%;background:#f59e0b;border-radius:99px"></div></div><span style="font-size:.8rem;width:30px;text-align:right">2%</span></div>
          <div class="d-flex align-items-center gap-2"><span style="font-size:.8rem;width:20px">1★</span><div class="flex-1 rounded" style="height:8px;background:var(--gray-200);overflow:hidden"><div style="width:2%;height:100%;background:#ef4444;border-radius:99px"></div></div><span style="font-size:.8rem;width:30px;text-align:right">2%</span></div>
        </div>
      </div>
    </div>
    <!-- Review List -->
    <div class="col-lg-7">
      <div class="d-flex align-items-center justify-content-between mb-3">
        <h5 class="fw-700 mb-0">Customer Reviews</h5>
        <select class="form-select form-select-sm" style="width:150px;font-family:var(--font-main)">
          <option>Most Recent</option><option>Highest Rated</option><option>Lowest Rated</option>
        </select>
      </div>
      <div id="reviewList"></div>
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
const reviews = [
  { name:'Priya Sharma', rating:5, date:'15 Dec 2024', medicine:'Paracetamol 500mg', title:'Works perfectly!', text:'Excellent quality medicine. Got relief from fever within 30 minutes. Packaging was intact and delivery was super fast.', helpful:24 },
  { name:'Rahul Mehta', rating:4, date:'10 Dec 2024', medicine:'Vitamin D3 1000IU', title:'Good quality, fast delivery', text:'Good quality vitamins. The price is much better than local pharmacy. Will definitely order again.', helpful:18 },
  { name:'Anita Singh', rating:5, date:'05 Dec 2024', medicine:'Cetirizine 10mg', title:'Best allergy medicine', text:'Finally found a reliable source for Cetirizine. Non-drowsy formula really works! Same day delivery was a bonus.', helpful:31 },
  { name:'Vikram Patel', rating:3, date:'01 Dec 2024', medicine:'Amoxicillin 250mg', title:'Good but slow delivery', text:'Medicine quality is good, but delivery took longer than expected. Customer support was helpful in tracking.', helpful:9 },
  { name:'Neha Gupta', rating:5, date:'28 Nov 2024', medicine:'Multivitamin Daily', title:'Great value for money!', text:'Love this multivitamin! Feel much more energetic since I started taking it. Great packaging and authentic product.', helpful:42 },
];
const avatarColors = ['#1a6bcc','#22c55e','#8b5cf6','#f59e0b','#ec4899'];

function renderReviews() {
  document.getElementById('reviewList').innerHTML = reviews.map((r, i) => `
    <div class="card-custom p-4 mb-3">
      <div class="d-flex align-items-start gap-3 mb-2">
        <div class="avatar avatar-md" style="background:${avatarColors[i % avatarColors.length]};flex-shrink:0">${r.name.split(' ').map(w=>w[0]).join('')}</div>
        <div class="flex-1">
          <div class="d-flex align-items-center justify-content-between flex-wrap gap-1">
            <div><span class="fw-700" style="font-size:.9rem">${r.name}</span><span class="badge-custom badge-info ms-2" style="font-size:.68rem">${r.medicine}</span></div>
            <small class="text-muted">${r.date}</small>
          </div>
          <div class="star-rating" style="font-size:.85rem">
            ${'<i class="bi bi-star-fill"></i>'.repeat(r.rating)}${'<i class="bi bi-star"></i>'.repeat(5-r.rating)}
          </div>
        </div>
      </div>
      <h6 class="fw-700 mb-1" style="font-size:.9rem">${r.title}</h6>
      <p style="font-size:.87rem;color:var(--dark-3);margin-bottom:.75rem">${r.text}</p>
      <div class="d-flex align-items-center gap-3">
        <button type="button" class="btn btn-sm border py-0 px-2" onclick="markHelpful(this, ${i})" style="font-size:.78rem"><i class="bi bi-hand-thumbs-up me-1"></i>Helpful (${r.helpful})</button>
        <button type="button" class="btn btn-sm border py-0 px-2" style="font-size:.78rem"><i class="bi bi-flag me-1"></i>Report</button>
      </div>
    </div>`).join('');
}

function markHelpful(btn, i) {
  reviews[i].helpful++;
  btn.innerHTML = `<i class="bi bi-hand-thumbs-up-fill me-1 text-primary"></i>Helpful (${reviews[i].helpful})`;
  btn.disabled = true;
}

function submitReview() {
  showLoader();
  setTimeout(() => { hideLoader(); showToast('Review submitted! Thank you.', 'success'); }, 1200);
}

document.addEventListener('DOMContentLoaded', renderReviews);
</script>
</body>
</asp:Content>
