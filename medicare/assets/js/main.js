/* ============================================================
   PHARMACY MANAGEMENT SYSTEM — MAIN JS
   Global utilities, dummy data, toast, modals, animations
   ============================================================ */




/* ── Toast Notification System ─────────────────────────────── */
function showToast(message, type = 'success', duration = 3500) {
  const container = document.getElementById('toast-container') || createToastContainer();
  const icons = { success: 'bi-check-circle-fill', error: 'bi-x-circle-fill', warning: 'bi-exclamation-triangle-fill', info: 'bi-info-circle-fill' };
  const toast = document.createElement('div');
  toast.className = `toast-custom toast-${type}`;
  toast.innerHTML = `
    <i class="bi ${icons[type]} toast-icon"></i>
    <span>${message}</span>
    <button class="toast-close" onclick="dismissToast(this.parentElement)"><i class="bi bi-x"></i></button>
  `;
  container.appendChild(toast);
  setTimeout(() => dismissToast(toast), duration);
}

function dismissToast(toast) {
  if (!toast) return;
  toast.classList.add('toast-exit');
  setTimeout(() => toast.remove(), 300);
}

function createToastContainer() {
  const c = document.createElement('div');
  c.id = 'toast-container';
  document.body.appendChild(c);
  return c;
}

/* ── Confirmation Dialog ────────────────────────────────────── */
function showConfirm(opts = {}) {
  const {
    title = 'Are you sure?',
    message = 'This action cannot be undone.',
    icon = 'bi-exclamation-triangle-fill',
    iconColor = '#ef4444',
    confirmText = 'Confirm',
    cancelText = 'Cancel',
    onConfirm = () => { },
  } = opts;

  let modal = document.getElementById('confirmModal');
  if (!modal) {
    modal = document.createElement('div');
    modal.id = 'confirmModal';
    modal.className = 'modal fade modal-custom';
    modal.tabIndex = -1;
    modal.innerHTML = `
      <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content">
          <div class="modal-body text-center" style="padding:2rem">
            <i id="confirmIcon" class="bi confirm-icon" style="display:block;font-size:3.5rem;margin-bottom:1rem"></i>
            <h5 id="confirmTitle" class="fw-700 mb-2"></h5>
            <p id="confirmMsg" class="text-muted mb-3" style="font-size:.9rem"></p>
            <div class="d-flex gap-2 justify-content-center">
              <button class="btn btn-secondary-custom" data-bs-dismiss="modal" id="confirmCancel"></button>
              <button class="btn btn-danger-custom" id="confirmOk"></button>
            </div>
          </div>
        </div>
      </div>`;
    document.body.appendChild(modal);
  }
  document.getElementById('confirmIcon').className = `bi ${icon}`;
  document.getElementById('confirmIcon').style.color = iconColor;
  document.getElementById('confirmTitle').textContent = title;
  document.getElementById('confirmMsg').textContent = message;
  document.getElementById('confirmCancel').textContent = cancelText;
  document.getElementById('confirmOk').textContent = confirmText;

  const bsModal = new bootstrap.Modal(modal);
  bsModal.show();
  const okBtn = document.getElementById('confirmOk');
  const newOk = okBtn.cloneNode(true);
  okBtn.parentNode.replaceChild(newOk, okBtn);
  newOk.addEventListener('click', () => { onConfirm(); bsModal.hide(); });
}

/* ── Loading Spinner ────────────────────────────────────────── */
function showLoader() {
  if (document.getElementById('global-loader')) return;
  const overlay = document.createElement('div');
  overlay.className = 'spinner-overlay';
  overlay.id = 'global-loader';
  overlay.innerHTML = `<div class="spinner-ring"></div>`;
  document.body.appendChild(overlay);
}
function hideLoader() {
  const el = document.getElementById('global-loader');
  if (el) el.remove();
}

/* ── Animate on Scroll ──────────────────────────────────────── */
function initScrollAnimations() {
  const els = document.querySelectorAll('.anim-fade-up');
  if (!els.length) return;
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(e => { if (e.isIntersecting) { e.target.classList.add('visible'); observer.unobserve(e.target); } });
  }, { threshold: 0.12 });
  els.forEach(el => observer.observe(el));
}

/* ── Sidebar Toggle (Pharmacist / Admin) ───────────────────── */
function initSidebar(sidebarId, overlayId) {
  const sidebar = document.getElementById(sidebarId);
  const overlay = document.getElementById(overlayId);
  const toggle = document.querySelectorAll('.sidebar-toggle');
  if (!sidebar || !overlay) return;

  toggle.forEach(btn => btn.addEventListener('click', () => {
    sidebar.classList.toggle('open');
    overlay.classList.toggle('visible');
  }));
  overlay.addEventListener('click', () => {
    sidebar.classList.remove('open');
    overlay.classList.remove('visible');
  });
}

/* ── Sidebar Subnav Expand / Collapse ──────────────────────── */
function initSubnav(sidebarId) {
  const root = sidebarId ? document.getElementById(sidebarId) : document;
  if (!root) return;

  const currentFile = window.location.pathname.split('/').pop().toLowerCase();

  root.querySelectorAll('.sidebar-nav-item').forEach(item => {
    const subnav = item.querySelector('.sidebar-subnav');
    if (!subnav) return;

    const parentLink = item.querySelector(':scope > .sidebar-nav-link');
    if (!parentLink) return;

    // Inject chevron arrow into the parent link (once only)
    if (!parentLink.querySelector('.subnav-chevron')) {
      const chevron = document.createElement('i');
      chevron.className = 'bi bi-chevron-down subnav-chevron';
      parentLink.appendChild(chevron);
    }

    // Auto-expand if any child link matches current page
    const childLinks = subnav.querySelectorAll('a');
    let hasActive = false;
    childLinks.forEach(a => {
      const href = (a.getAttribute('href') || '').split('/').pop().toLowerCase();
      if (href && href === currentFile) {
        a.classList.add('active');
        hasActive = true;
      }
    });
    if (hasActive) item.classList.add('expanded');

    // Toggle on parent link click (prevent default navigation)
    parentLink.addEventListener('click', e => {
      e.preventDefault();
      item.classList.toggle('expanded');
    });
  });
}

/* ── Search + Filter Table ──────────────────────────────────── */
function filterTable(inputId, tableId, cols = null) {
  const input = document.getElementById(inputId);
  if (!input) return;
  input.addEventListener('input', function () {
    const q = this.value.toLowerCase();
    const rows = document.querySelectorAll(`#${tableId} tbody tr`);
    rows.forEach(row => {
      const text = (cols ? [...cols].map(c => row.cells[c]?.textContent || '').join(' ') : row.textContent).toLowerCase();
      row.style.display = text.includes(q) ? '' : 'none';
    });
  });
}

/* ── Simple Pagination ──────────────────────────────────────── */
function initPagination(tableId, rowsPerPage = 10) {
  const table = document.querySelector(`#${tableId} tbody`);
  if (!table) return;
  const rows = [...table.querySelectorAll('tr')];
  if (rows.length <= rowsPerPage) return;
  const pages = Math.ceil(rows.length / rowsPerPage);
  const container = document.getElementById(`${tableId}-pagination`);
  if (!container) return;

  let current = 1;
  function render() {
    rows.forEach((r, i) => r.style.display = (i >= (current - 1) * rowsPerPage && i < current * rowsPerPage) ? '' : 'none');
    container.innerHTML = '';
    for (let p = 1; p <= pages; p++) {
      const li = document.createElement('li');
      li.className = `page-item ${p === current ? 'active' : ''}`;
      li.innerHTML = `<a class="page-link" href="#">${p}</a>`;
      li.addEventListener('click', e => { e.preventDefault(); current = p; render(); });
      container.appendChild(li);
    }
  }
  render();
}

/* ── Drag & Drop Upload ─────────────────────────────────────── */
function initDropzone(dropId, inputId, previewId) {
  const zone = document.getElementById(dropId);
  const input = document.getElementById(inputId);
  const prev = document.getElementById(previewId);
  if (!zone || !input) return;

  zone.addEventListener('click', () => input.click());
  zone.addEventListener('dragover', e => { e.preventDefault(); zone.classList.add('drag-over'); });
  zone.addEventListener('dragleave', () => zone.classList.remove('drag-over'));
  zone.addEventListener('drop', e => { e.preventDefault(); zone.classList.remove('drag-over'); handleFiles(e.dataTransfer.files); });
  input.addEventListener('change', e => handleFiles(e.target.files));

  function handleFiles(files) {
    if (!files.length) return;
    const file = files[0];
    if (prev) {
      if (file.type.startsWith('image/')) {
        const reader = new FileReader();
        reader.onload = ev => {
          prev.innerHTML = `<div class="prescription-preview"><img src="${ev.target.result}" class="prescription-thumb" alt="Preview"><div><strong>${file.name}</strong><br><small class="text-muted">${(file.size / 1024).toFixed(1)} KB</small></div></div>`;
        };
        reader.readAsDataURL(file);
      } else {
        prev.innerHTML = `<div class="prescription-preview"><i class="bi bi-file-earmark-pdf-fill text-danger" style="font-size:2rem"></i><div><strong>${file.name}</strong><br><small class="text-muted">${(file.size / 1024).toFixed(1)} KB</small></div></div>`;
      }
    }
    zone.querySelector('p') && (zone.querySelector('p').textContent = file.name);
  }
}

/* ── Authentication handled server-side via ASP.NET Session ── */

/* ── Cart Management ──────────────────────────────────────── */
const Cart = {
  key: 'pharma_cart',
  get() { try { return JSON.parse(localStorage.getItem(this.key)) || []; } catch { return []; } },
  save(items) { localStorage.setItem(this.key, JSON.stringify(items)); this.updateBadge(); },
  add(item) {
    const items = this.get();
    const ex = items.find(i => i.id === item.id);
    if (ex) ex.qty = (ex.qty || 1) + 1;
    else items.push({ ...item, qty: 1 });
    this.save(items);
    showToast(`${item.name} added to cart!`, 'success');
  },
  remove(id) { this.save(this.get().filter(i => i.id !== id)); },
  updateQty(id, qty) { const items = this.get(); const it = items.find(i => i.id === id); if (it) it.qty = qty; this.save(items); },
  count() { return this.get().reduce((s, i) => s + (i.qty || 1), 0); },
  total() { return this.get().reduce((s, i) => s + i.price * (i.qty || 1), 0); },
  updateBadge() {
    document.querySelectorAll('.cart-count').forEach(el => {
      const c = this.count();
      el.textContent = c;
      el.style.display = c > 0 ? 'flex' : 'none';
    });
  }
};

/* ── Image Helpers ───────────────────────────────────────────── */
function getImgPath(img) {
  if (!img) return '';
  if (img.startsWith('data:') || img.startsWith('http://') || img.startsWith('https://')) return img;
  let file = img.replace(/^(\.\.\/)*assets\/img\//, '');
  const isSubdir = window.location.pathname.includes('/customer/') ||
    window.location.pathname.includes('/pharmacist/') ||
    window.location.pathname.includes('/admin/');
  return (isSubdir ? '../assets/img/' : 'assets/img/') + file;
}

function renderMedicineImage(img, alt = '', className = '', style = '') {
  if (!img) return `<span class="med-emoji-fallback" style="${style}">💊</span>`;
  if (img.length <= 4 && !img.includes('.')) {
    return `<span class="med-emoji-fallback" style="${style}">${img}</span>`;
  }
  const src = getImgPath(img);
  const safeAlt = (alt || '').replace(/"/g, '&quot;');
  return `<img src="${src}" alt="${safeAlt}" class="${className}" style="${style}" onerror="this.onerror=null; this.outerHTML='<span class=\\'med-emoji-fallback\\'>💊</span>';">`;
}

/* ── Dummy Data ─────────────────────────────────────────────── */
const DummyData = {
  availableImages: [
    { filename: '01_Paracetamol_Tablets.png', label: '01 - Paracetamol Tablets' },
    { filename: '02_Ibuprofen_Tablets.png', label: '02 - Ibuprofen Tablets' },
    { filename: '03_Amoxicillin_Capsules.png', label: '03 - Amoxicillin Capsules' },
    { filename: '04_Azithromycin_Tablets.png', label: '04 - Azithromycin Tablets' },
    { filename: '05_Cetirizine_Tablets.png', label: '05 - Cetirizine Tablets' },
    { filename: '06_Omeprazole_Capsules.png', label: '06 - Omeprazole Capsules' },
    { filename: '07_Pantoprazole_Tablets.png', label: '07 - Pantoprazole Tablets' },
    { filename: '08_Metformin_Tablets.png', label: '08 - Metformin Tablets' },
    { filename: '09_Amlodipine_Tablets.png', label: '09 - Amlodipine Tablets' },
    { filename: '10_Atorvastatin_Tablets.png', label: '10 - Atorvastatin Tablets' },
    { filename: '11_Vitamin_C_Tablets.png', label: '11 - Vitamin C Tablets' },
    { filename: '12_Vitamin_D3_Tablets.png', label: '12 - Vitamin D3 Tablets' },
    { filename: '13_Calcium_Tablets.png', label: '13 - Calcium Tablets' },
    { filename: '14_ORS_Sachet.png', label: '14 - ORS Sachet' },
    { filename: '15_Cough_Syrup.png', label: '15 - Cough Syrup' },
    { filename: '16_Antacid_Syrup.png', label: '16 - Antacid Syrup' },
    { filename: '17_Multivitamin_Syrup.png', label: '17 - Multivitamin Syrup' },
    { filename: '18_Eye_Drops.png', label: '18 - Eye Drops' },
    { filename: '19_Nasal_Spray.png', label: '19 - Nasal Spray' },
    { filename: '20_Antiseptic_Cream.png', label: '20 - Antiseptic Cream' },
    { filename: '21_Antibiotic_Cream.png', label: '21 - Antibiotic Cream' },
    { filename: '22_Pain_Relief_Gel.png', label: '22 - Pain Relief Gel' },
    { filename: '23_Insulin_Vial.png', label: '23 - Insulin Vial' },
    { filename: '24_Ceftriaxone_Injection.png', label: '24 - Ceftriaxone Injection' },
    { filename: '25_Mupirocin_Ointment.png', label: '25 - Mupirocin Ointment' },
    { filename: '26_Hand_Sanitizer.png', label: '26 - Hand Sanitizer' },
    { filename: '27_Bandage_Pack.png', label: '27 - Bandage Pack' },
    { filename: '28_Thermometer.png', label: '28 - Thermometer' },
    { filename: '29_Surgical_Mask.png', label: '29 - Surgical Mask' },
    { filename: '30_First_Aid_Kit.png', label: '30 - First Aid Kit' }
  ],
  medicines: [
    { id: 1, name: 'Paracetamol 500mg', genericName: 'Paracetamol', brand: 'MedCure', category: 'Pain Relief', price: 45, oldPrice: 60, img: '01_Paracetamol_Tablets.png', stock: 120, rating: 4.5, reviewCount: 128, rxRequired: false, discount: 25, description: 'Paracetamol (acetaminophen) is an effective medication for relieving pain and reducing fever.', dosageForm: 'Tablet', strength: '500 mg', packSize: '10 Tablets', uses: 'Mild to moderate pain relief, fever reduction.', dosage: '1-2 tablets every 4-6 hours as needed.', sideEffects: 'Nausea, rare stomach upset.', interactions: 'May interact with warfarin and alcohol.', composition: 'Paracetamol 500mg per tablet.', storage: 'Store below 25°C.', manufacturer: 'MedCure Pharmaceuticals', batchNo: 'BT-2024-001', manufacturingDate: '01 Jan 2024', expiryDate: '31 Dec 2026', countryOfOrigin: 'India', medicineType: 'Analgesic & Antipyretic', inactiveIngredients: 'Microcrystalline cellulose, stearic acid' },
    { id: 2, name: 'Ibuprofen 400mg', genericName: 'Ibuprofen', brand: 'PainGone', category: 'Pain Relief', price: 55, oldPrice: 70, img: '02_Ibuprofen_Tablets.png', stock: 180, rating: 4.3, reviewCount: 141, rxRequired: false, discount: 21, description: 'Ibuprofen is an NSAID that reduces pain, fever, and inflammation.', dosageForm: 'Tablet', strength: '400 mg', packSize: '10 Tablets', uses: 'Relief of mild to moderate pain, headaches, muscle pain.', dosage: 'One tablet every 4-6 hours as needed.', sideEffects: 'Stomach upset, heartburn.', interactions: 'Avoid with other NSAIDs.', composition: 'Ibuprofen 400mg per tablet.', storage: 'Store below 25°C.', manufacturer: 'PainGone Healthcare', batchNo: 'BT-2024-167', manufacturingDate: '15 Sep 2024', expiryDate: '14 Sep 2027', countryOfOrigin: 'India', medicineType: 'NSAID', inactiveIngredients: 'Croscarmellose sodium, magnesium stearate' },
    { id: 3, name: 'Amoxicillin 250mg', genericName: 'Amoxicillin Trihydrate', brand: 'BioPharma', category: 'Antibiotics', price: 180, oldPrice: 220, img: '03_Amoxicillin_Capsules.png', stock: 85, rating: 4.2, reviewCount: 92, rxRequired: true, discount: 18, description: 'Amoxicillin is a broad-spectrum antibiotic used to treat bacterial infections.', dosageForm: 'Capsule', strength: '250 mg', packSize: '10 Capsules', uses: 'Treatment of respiratory, urinary, and skin bacterial infections.', dosage: '250-500mg three times daily as prescribed.', sideEffects: 'Nausea, diarrhea, allergic reaction.', interactions: 'May reduce oral contraceptive effectiveness.', composition: 'Amoxicillin trihydrate 250mg.', storage: 'Store below 25°C in dry place.', manufacturer: 'BioPharma Ltd.', batchNo: 'BT-2024-045', manufacturingDate: '15 Feb 2024', expiryDate: '14 Feb 2027', countryOfOrigin: 'India', medicineType: 'Antibiotic', inactiveIngredients: 'Magnesium stearate, gelatin' },
    { id: 4, name: 'Azithromycin 500mg', genericName: 'Azithromycin Dihydrate', brand: 'BioPharma', category: 'Antibiotics', price: 240, oldPrice: 300, img: '04_Azithromycin_Tablets.png', stock: 40, rating: 4.1, reviewCount: 73, rxRequired: true, discount: 20, description: 'Azithromycin is a macrolide antibiotic effective against respiratory and skin infections.', dosageForm: 'Tablet', strength: '500 mg', packSize: '5 Tablets', uses: 'Treatment of respiratory tract and skin infections.', dosage: '500mg once daily for 3 days as prescribed.', sideEffects: 'Nausea, abdominal pain, diarrhea.', interactions: 'Inform doctor about all current medications.', composition: 'Azithromycin 500mg.', storage: 'Protect from light and moisture.', manufacturer: 'BioPharma Ltd.', batchNo: 'BT-2024-298', manufacturingDate: '22 Oct 2024', expiryDate: '21 Oct 2027', countryOfOrigin: 'India', medicineType: 'Macrolide Antibiotic', inactiveIngredients: 'Croscarmellose sodium, magnesium stearate' },
    { id: 5, name: 'Cetirizine 10mg', genericName: 'Cetirizine Hydrochloride', brand: 'AllerFree', category: 'Allergy', price: 35, oldPrice: 45, img: '05_Cetirizine_Tablets.png', stock: 200, rating: 4.7, reviewCount: 156, rxRequired: false, discount: 22, description: 'Cetirizine provides fast, non-drowsy relief from allergy symptoms.', dosageForm: 'Tablet', strength: '10 mg', packSize: '10 Tablets', uses: 'Relief from allergic rhinitis, sneezing, and itching.', dosage: 'One tablet daily in the evening.', sideEffects: 'Mild drowsiness, dry mouth.', interactions: 'Avoid with central nervous system depressants.', composition: 'Cetirizine HCl 10mg.', storage: 'Store below 30°C.', manufacturer: 'AllerFree Healthcare', batchNo: 'BT-2024-078', manufacturingDate: '10 Mar 2024', expiryDate: '09 Mar 2027', countryOfOrigin: 'UK', medicineType: 'Antihistamine', inactiveIngredients: 'Lactose monohydrate, magnesium stearate' },
    { id: 6, name: 'Omeprazole 20mg', genericName: 'Omeprazole', brand: 'GastroCare', category: 'Gastro', price: 75, oldPrice: 95, img: '06_Omeprazole_Capsules.png', stock: 150, rating: 4.4, reviewCount: 118, rxRequired: false, discount: 21, description: 'Omeprazole reduces stomach acid for treating GERD and acid reflux.', dosageForm: 'Capsule', strength: '20 mg', packSize: '10 Capsules', uses: 'Treatment of GERD, acid reflux, heartburn.', dosage: '20mg once daily in morning before food.', sideEffects: 'Headache, abdominal pain, nausea.', interactions: 'Should not be taken with clopidogrel.', composition: 'Omeprazole 20mg.', storage: 'Store below 25°C in dry place.', manufacturer: 'GastroCare Pharma', batchNo: 'BT-2024-089', manufacturingDate: '08 Jul 2024', expiryDate: '07 Jul 2027', countryOfOrigin: 'India', medicineType: 'Proton Pump Inhibitor', inactiveIngredients: 'Sucrose, croscarmellose sodium' },
    { id: 7, name: 'Pantoprazole 40mg', genericName: 'Pantoprazole Sodium', brand: 'GastroCare', category: 'Gastro', price: 120, oldPrice: 150, img: '07_Pantoprazole_Tablets.png', stock: 90, rating: 4.4, reviewCount: 102, rxRequired: false, discount: 20, description: 'Pantoprazole is a proton pump inhibitor that treats acid reflux and GERD.', dosageForm: 'Tablet', strength: '40 mg', packSize: '10 Tablets', uses: 'GERD and acid reflux management.', dosage: '40mg once daily in morning.', sideEffects: 'Headache, diarrhea.', interactions: 'May alter absorption of certain antifungals.', composition: 'Pantoprazole sodium 40mg.', storage: 'Store below 25°C.', manufacturer: 'GastroCare Pharma', batchNo: 'BT-2024-345', manufacturingDate: '10 Nov 2024', expiryDate: '09 Nov 2027', countryOfOrigin: 'India', medicineType: 'Proton Pump Inhibitor', inactiveIngredients: 'Mannitol, magnesium stearate' },
    { id: 8, name: 'Metformin 500mg', genericName: 'Metformin Hydrochloride', brand: 'DiaCare', category: 'Diabetes', price: 95, oldPrice: 120, img: '08_Metformin_Tablets.png', stock: 60, rating: 4.3, reviewCount: 84, rxRequired: true, discount: 21, description: 'Metformin controls blood sugar levels in type 2 diabetes.', dosageForm: 'Tablet', strength: '500 mg', packSize: '20 Tablets', uses: 'Management of type 2 diabetes mellitus.', dosage: '500mg 1-2 times daily with meals as prescribed.', sideEffects: 'Gastrointestinal upset, nausea.', interactions: 'Avoid with contrast dye procedures.', composition: 'Metformin HCl 500mg.', storage: 'Store below 25°C.', manufacturer: 'DiaCare Pharma', batchNo: 'BT-2024-112', manufacturingDate: '05 Apr 2024', expiryDate: '04 Apr 2027', countryOfOrigin: 'India', medicineType: 'Antidiabetic', inactiveIngredients: 'Croscarmellose sodium, magnesium stearate' },
    { id: 9, name: 'Amlodipine 5mg', genericName: 'Amlodipine Besylate', brand: 'CardioHealth', category: 'Cardiology', price: 85, oldPrice: 110, img: '09_Amlodipine_Tablets.png', stock: 110, rating: 4.5, reviewCount: 98, rxRequired: true, discount: 22, description: 'Amlodipine is a calcium channel blocker used to treat high blood pressure.', dosageForm: 'Tablet', strength: '5 mg', packSize: '10 Tablets', uses: 'Hypertension and angina treatment.', dosage: '5mg once daily or as directed by doctor.', sideEffects: 'Swelling of ankles, dizziness.', interactions: 'Consult doctor if taking blood pressure meds.', composition: 'Amlodipine besylate 5mg.', storage: 'Store below 25°C.', manufacturer: 'CardioHealth Pharmaceuticals', batchNo: 'BT-2024-180', manufacturingDate: '18 May 2024', expiryDate: '17 May 2027', countryOfOrigin: 'India', medicineType: 'Antihypertensive', inactiveIngredients: 'Microcrystalline cellulose, magnesium stearate' },
    { id: 10, name: 'Atorvastatin 20mg', genericName: 'Atorvastatin Calcium', brand: 'CardioHealth', category: 'Cardiology', price: 220, oldPrice: 280, img: '10_Atorvastatin_Tablets.png', stock: 45, rating: 4.6, reviewCount: 110, rxRequired: true, discount: 21, description: 'Atorvastatin reduces bad cholesterol (LDL) and triglycerides.', dosageForm: 'Tablet', strength: '20 mg', packSize: '10 Tablets', uses: 'High cholesterol treatment and cardiovascular protection.', dosage: '10-20mg once daily in the evening.', sideEffects: 'Muscle pain, mild headache.', interactions: 'Avoid grapefruit juice and certain antibiotics.', composition: 'Atorvastatin calcium 20mg.', storage: 'Store below 25°C.', manufacturer: 'CardioHealth Pharmaceuticals', batchNo: 'BT-2024-156', manufacturingDate: '12 May 2024', expiryDate: '11 May 2027', countryOfOrigin: 'Germany', medicineType: 'Lipid-Lowering Agent', inactiveIngredients: 'Croscarmellose sodium, magnesium stearate' },
    { id: 11, name: 'Vitamin C 500mg', genericName: 'Ascorbic Acid', brand: 'VitaBoost', category: 'Vitamins', price: 150, oldPrice: 190, img: '11_Vitamin_C_Tablets.png', stock: 220, rating: 4.8, reviewCount: 180, rxRequired: false, discount: 21, description: 'Vitamin C chewable tablets for immunity enhancement and antioxidant support.', dosageForm: 'Chewable Tablet', strength: '500 mg', packSize: '30 Tablets', uses: 'Immunity boosting, antioxidant supplement.', dosage: '1 tablet chewable daily.', sideEffects: 'None at recommended dosage.', interactions: 'None significant.', composition: 'Ascorbic acid 500mg.', storage: 'Store in cool dry place.', manufacturer: 'VitaBoost Nutrition', batchNo: 'BT-2024-210', manufacturingDate: '01 Jun 2024', expiryDate: '31 May 2027', countryOfOrigin: 'USA', medicineType: 'Vitamin Supplement', inactiveIngredients: 'Sucrose, orange flavor' },
    { id: 12, name: 'Vitamin D3 1000IU', genericName: 'Cholecalciferol', brand: 'VitaBoost', category: 'Vitamins', price: 299, oldPrice: 399, img: '12_Vitamin_D3_Tablets.png', stock: 300, rating: 4.8, reviewCount: 205, rxRequired: false, discount: 25, description: 'Vitamin D3 supports calcium absorption, bone strength, and immunity.', dosageForm: 'Softgel Capsule', strength: '1000 IU', packSize: '30 Capsules', uses: 'Bone health and immune support.', dosage: 'One capsule daily with food.', sideEffects: 'Safe at recommended doses.', interactions: 'May interact with certain calcium medications.', composition: 'Cholecalciferol 1000 IU.', storage: 'Store below 25°C.', manufacturer: 'VitaBoost Nutrition', batchNo: 'BT-2024-201', manufacturingDate: '20 Jun 2024', expiryDate: '19 Jun 2027', countryOfOrigin: 'USA', medicineType: 'Vitamin Supplement', inactiveIngredients: 'Soybean oil, gelatin' },
    { id: 13, name: 'Calcium Carbonate 500mg', genericName: 'Calcium + Vitamin D3', brand: 'VitaBoost', category: 'Vitamins', price: 180, oldPrice: 230, img: '13_Calcium_Tablets.png', stock: 140, rating: 4.6, reviewCount: 115, rxRequired: false, discount: 21, description: 'Calcium carbonate supplement with Vitamin D3 for bone density.', dosageForm: 'Tablet', strength: '500 mg', packSize: '30 Tablets', uses: 'Calcium deficiency prevention and bone health.', dosage: '1 tablet twice daily after meals.', sideEffects: 'Mild constipation.', interactions: 'Take 2 hours apart from iron supplements.', composition: 'Elemental Calcium 500mg + Vit D3 250IU.', storage: 'Store in cool place.', manufacturer: 'VitaBoost Nutrition', batchNo: 'BT-2024-220', manufacturingDate: '10 Jul 2024', expiryDate: '09 Jul 2027', countryOfOrigin: 'India', medicineType: 'Mineral Supplement', inactiveIngredients: 'Starch, magnesium stearate' },
    { id: 14, name: 'ORS Electrolyte Powder', genericName: 'Oral Rehydration Salts', brand: 'MedCure', category: 'Wellness', price: 25, oldPrice: 30, img: '14_ORS_Sachet.png', stock: 350, rating: 4.9, reviewCount: 240, rxRequired: false, discount: 16, description: 'WHO recommended ORS formula for rapid rehydration.', dosageForm: 'Powder Sachet', strength: '21.8g Sachet', uses: 'Dehydration recovery from fever, heat, or diarrhea.', dosage: 'Dissolve 1 sachet in 1 liter of clean water.', sideEffects: 'None.', interactions: 'None.', composition: 'Sodium chloride, Potassium chloride, Dextrose.', storage: 'Keep sachet sealed until use.', manufacturer: 'MedCure Pharmaceuticals', batchNo: 'BT-2024-310', manufacturingDate: '15 Aug 2024', expiryDate: '14 Aug 2027', countryOfOrigin: 'India', medicineType: 'Electrolyte Rehydration', inactiveIngredients: 'Flavoring agents' },
    { id: 15, name: 'Herbal Cough Syrup 100ml', genericName: 'Herbal Expectorant', brand: 'BreathEasy', category: 'Respiratory', price: 110, oldPrice: 140, img: '15_Cough_Syrup.png', stock: 130, rating: 4.5, reviewCount: 95, rxRequired: false, discount: 21, description: 'Natural soothing cough syrup for dry and wet cough relief.', dosageForm: 'Syrup', strength: '100 ml', packSize: '1 Bottle', uses: 'Soothes throat irritation and clears cough.', dosage: '10ml 3 times daily after meals.', sideEffects: 'Drowsiness (mild).', interactions: 'Avoid alcohol while taking.', composition: 'Tulsi, Vasaka, Honey, Mulethi extract.', storage: 'Store at room temperature.', manufacturer: 'BreathEasy Respiratory', batchNo: 'BT-2024-320', manufacturingDate: '20 Aug 2024', expiryDate: '19 Aug 2026', countryOfOrigin: 'India', medicineType: 'Cough Suppressant', inactiveIngredients: 'Flavored syrup base' },
    { id: 16, name: 'Antacid Liquid 200ml', genericName: 'Magaldrate + Simethicone', brand: 'GastroCare', category: 'Gastro', price: 135, oldPrice: 165, img: '16_Antacid_Syrup.png', stock: 160, rating: 4.7, reviewCount: 142, rxRequired: false, discount: 18, description: 'Fast-acting liquid antacid for heartburn, gas, and acidity.', dosageForm: 'Syrup', strength: '200 ml', packSize: '1 Bottle', uses: 'Instant relief from acidity, bloating, and gas.', dosage: '1-2 teaspoons after meals and at bedtime.', sideEffects: 'Mild laxative effect if overused.', interactions: 'Take 2 hours apart from antibiotics.', composition: 'Magaldrate 400mg + Simethicone 20mg per 5ml.', storage: 'Shake well before use.', manufacturer: 'GastroCare Pharma', batchNo: 'BT-2024-330', manufacturingDate: '01 Sep 2024', expiryDate: '31 Aug 2026', countryOfOrigin: 'India', medicineType: 'Antacid & Antiflatulent', inactiveIngredients: 'Mint flavor base' },
    { id: 17, name: 'Multivitamin Syrup 200ml', genericName: 'Multivitamin & Minerals Liquid', brand: 'VitaBoost', category: 'Vitamins', price: 210, oldPrice: 260, img: '17_Multivitamin_Syrup.png', stock: 190, rating: 4.6, reviewCount: 130, rxRequired: false, discount: 19, description: 'Delicious multivitamin syrup for growing children and adults.', dosageForm: 'Syrup', strength: '200 ml', packSize: '1 Bottle', uses: 'General nutritional deficiency and vitality.', dosage: '5-10ml daily after food.', sideEffects: 'None expected.', interactions: 'None significant.', composition: 'Vitamins A, B-Complex, C, D3, Zinc, Iron.', storage: 'Keep in cool place.', manufacturer: 'VitaBoost Nutrition', batchNo: 'BT-2024-340', manufacturingDate: '05 Sep 2024', expiryDate: '04 Sep 2026', countryOfOrigin: 'India', medicineType: 'Nutritional Supplement', inactiveIngredients: 'Fruit flavor syrup base' },
    { id: 18, name: 'Lubricant Eye Drops 10ml', genericName: 'Carboxymethylcellulose 0.5%', brand: 'MedCure', category: 'Eye Care', price: 140, oldPrice: 175, img: '18_Eye_Drops.png', stock: 115, rating: 4.6, reviewCount: 88, rxRequired: false, discount: 20, description: 'Soothing eye drops for dry, tired, or irritated eyes.', dosageForm: 'Drops', strength: '10 ml', packSize: '1 Bottle', uses: 'Relief from eye dryness and strain from screens.', dosage: '1-2 drops in affected eye(s) as needed.', sideEffects: 'Temporary mild stinging.', interactions: 'Wait 10 mins before using other eye drops.', composition: 'Carboxymethylcellulose sodium 0.5% w/v.', storage: 'Discard 1 month after opening.', manufacturer: 'MedCure Pharmaceuticals', batchNo: 'BT-2024-350', manufacturingDate: '10 Sep 2024', expiryDate: '09 Sep 2026', countryOfOrigin: 'India', medicineType: 'Ophthalmic Lubricant', inactiveIngredients: 'Purified water, preservative' },
    { id: 19, name: 'Saline Nasal Spray 50ml', genericName: 'Sodium Chloride 0.65%', brand: 'BreathEasy', category: 'Respiratory', price: 160, oldPrice: 200, img: '19_Nasal_Spray.png', stock: 95, rating: 4.5, reviewCount: 76, rxRequired: false, discount: 20, description: 'Gentle nasal saline mist for clearing blocked nasal passages.', dosageForm: 'Spray', strength: '50 ml', packSize: '1 Spray Bottle', uses: 'Nasal congestion relief, moisturizing nasal passages.', dosage: '2-3 sprays per nostril as needed.', sideEffects: 'None.', interactions: 'Safe to use with oral medicines.', composition: 'Sodium chloride 0.65% isotonic solution.', storage: 'Store upright below 25°C.', manufacturer: 'BreathEasy Respiratory', batchNo: 'BT-2024-360', manufacturingDate: '15 Sep 2024', expiryDate: '14 Sep 2026', countryOfOrigin: 'USA', medicineType: 'Nasal Decongestant', inactiveIngredients: 'Purified water, benzalkonium chloride' },
    { id: 20, name: 'Antiseptic Cream 50g', genericName: 'Chlorhexidine + Cetrimide', brand: 'MedCure', category: 'First Aid', price: 75, oldPrice: 95, img: '20_Antiseptic_Cream.png', stock: 210, rating: 4.8, reviewCount: 165, rxRequired: false, discount: 21, description: 'First aid cream for minor cuts, burns, scrapes, and skin infections.', dosageForm: 'Cream', strength: '50 g', packSize: '1 Tube', uses: 'Disinfection and healing of minor skin wounds.', dosage: 'Apply gently to clean affected area 2-3 times daily.', sideEffects: 'Rare mild skin irritation.', interactions: 'External use only.', composition: 'Chlorhexidine gluconate 0.5% + Cetrimide 0.5%.', storage: 'Store in cool place.', manufacturer: 'MedCure Pharmaceuticals', batchNo: 'BT-2024-370', manufacturingDate: '20 Sep 2024', expiryDate: '19 Sep 2027', countryOfOrigin: 'India', medicineType: 'Antiseptic', inactiveIngredients: 'Emulsifying wax, purified water' },
    { id: 21, name: 'Neomycin Antibiotic Cream 20g', genericName: 'Neomycin + Bacitracin', brand: 'BioPharma', category: 'Antibiotics', price: 90, oldPrice: 115, img: '21_Antibiotic_Cream.png', stock: 80, rating: 4.3, reviewCount: 62, rxRequired: true, discount: 22, description: 'Topical antibiotic cream for treating bacterial skin infections.', dosageForm: 'Cream', strength: '20 g', packSize: '1 Tube', uses: 'Topical treatment of infected wounds and skin conditions.', dosage: 'Apply thin layer 1-3 times daily as prescribed.', sideEffects: 'Skin sensitivity.', interactions: 'Avoid extensive open wound application.', composition: 'Neomycin sulfate 5mg + Bacitracin 500IU per g.', storage: 'Store below 25°C.', manufacturer: 'BioPharma Ltd.', batchNo: 'BT-2024-380', manufacturingDate: '25 Sep 2024', expiryDate: '24 Sep 2026', countryOfOrigin: 'India', medicineType: 'Topical Antibiotic', inactiveIngredients: 'White soft paraffin' },
    { id: 22, name: 'Fast Pain Relief Gel 30g', genericName: 'Diclofenac + Menthol Gel', brand: 'PainGone', category: 'Pain Relief', price: 125, oldPrice: 155, img: '22_Pain_Relief_Gel.png', stock: 175, rating: 4.7, reviewCount: 148, rxRequired: false, discount: 19, description: 'Targeted deep-penetrating gel for joint and muscle pain relief.', dosageForm: 'Gel', strength: '30 g', packSize: '1 Tube', uses: 'Relief from backache, sprains, joint pain, and strain.', dosage: 'Gently massage 3-4 times daily on painful spot.', sideEffects: 'Mild redness at site.', interactions: 'External use only.', composition: 'Diclofenac diethylamine 1.16% + Linseed oil + Menthol.', storage: 'Keep tube tightly closed.', manufacturer: 'PainGone Healthcare', batchNo: 'BT-2024-390', manufacturingDate: '01 Oct 2024', expiryDate: '30 Sep 2027', countryOfOrigin: 'India', medicineType: 'Topical Analgesic', inactiveIngredients: 'Carbomer, propylene glycol' },
    { id: 23, name: 'Human Insulin Injection 100IU', genericName: 'Human Insulin (rDNA origin)', brand: 'DiaCare', category: 'Diabetes', price: 450, oldPrice: 550, img: '23_Insulin_Vial.png', stock: 40, rating: 4.9, reviewCount: 72, rxRequired: true, discount: 18, description: 'Short-acting human insulin vial for diabetes management.', dosageForm: 'Injection', strength: '100 IU/ml (10ml)', packSize: '1 Vial', uses: 'Glycemic control in type 1 and type 2 diabetes.', dosage: 'Subcutaneous injection as directed by endocrinologist.', sideEffects: 'Hypoglycemia (low blood sugar).', interactions: 'Beta blockers may mask hypoglycemia symptoms.', composition: 'Human Insulin 100 IU per ml.', storage: 'Refrigerate at 2°C - 8°C. Do not freeze.', manufacturer: 'DiaCare Pharma', batchNo: 'BT-2024-400', manufacturingDate: '05 Oct 2024', expiryDate: '04 Oct 2026', countryOfOrigin: 'India', medicineType: 'Insulin', inactiveIngredients: 'm-cresol, glycerol' },
    { id: 24, name: 'Ceftriaxone 1g Injection', genericName: 'Ceftriaxone Sodium', brand: 'BioPharma', category: 'Antibiotics', price: 320, oldPrice: 390, img: '24_Ceftriaxone_Injection.png', stock: 35, rating: 4.4, reviewCount: 45, rxRequired: true, discount: 18, description: 'Injectable cephalosporin antibiotic for severe bacterial infections.', dosageForm: 'Injection', strength: '1000 mg', packSize: '1 Vial + WFI', uses: 'Hospital treatment of severe systemic bacterial infections.', dosage: '1-2g IV/IM daily as prescribed by doctor.', sideEffects: 'Injection site pain, rash.', interactions: 'Avoid mixing with calcium-containing IV solutions.', composition: 'Ceftriaxone sodium 1g.', storage: 'Store protected from light below 25°C.', manufacturer: 'BioPharma Ltd.', batchNo: 'BT-2024-410', manufacturingDate: '10 Oct 2024', expiryDate: '09 Oct 2026', countryOfOrigin: 'India', medicineType: 'Cephalosporin Antibiotic', inactiveIngredients: 'Sterile water for injection' },
    { id: 25, name: 'Mupirocin Ointment 2% 5g', genericName: 'Mupirocin 2% w/w', brand: 'BioPharma', category: 'First Aid', price: 110, oldPrice: 140, img: '25_Mupirocin_Ointment.png', stock: 90, rating: 4.8, reviewCount: 82, rxRequired: true, discount: 21, description: 'Targeted antibacterial ointment for impetigo and skin infections.', dosageForm: 'Ointment', strength: '2% w/w (5g)', packSize: '1 Tube', uses: 'Treatment of bacterial skin infections such as impetigo.', dosage: 'Apply small amount to area 3 times daily.', sideEffects: 'Local burning sensation.', interactions: 'External use only.', composition: 'Mupirocin 2% w/w.', storage: 'Store below 25°C.', manufacturer: 'BioPharma Ltd.', batchNo: 'BT-2024-420', manufacturingDate: '15 Oct 2024', expiryDate: '14 Oct 2026', countryOfOrigin: 'India', medicineType: 'Topical Antibacterial', inactiveIngredients: 'Polyethylene glycol base' },
    { id: 26, name: 'Alcohol Hand Sanitizer 500ml', genericName: '70% Isopropyl Alcohol', brand: 'MedCure', category: 'Hygiene', price: 199, oldPrice: 250, img: '26_Hand_Sanitizer.png', stock: 280, rating: 4.8, reviewCount: 195, rxRequired: false, discount: 20, description: 'Instant hand sanitizer with 70% alcohol and moisturizing Aloe Vera.', dosageForm: 'Liquid', strength: '500 ml Pump', packSize: '1 Bottle', uses: 'Kills 99.9% of germs instantly without water.', dosage: 'Rub 3-5ml over hands until dry.', sideEffects: 'Dry skin if overused.', interactions: 'Flammable. Keep away from fire.', composition: 'Isopropyl alcohol 70% v/v + Aloe Vera.', storage: 'Store in cool dry place.', manufacturer: 'MedCure Pharmaceuticals', batchNo: 'BT-2024-430', manufacturingDate: '20 Oct 2024', expiryDate: '19 Oct 2027', countryOfOrigin: 'India', medicineType: 'Hand Antiseptic', inactiveIngredients: 'Glycerin, Fragrance' },
    { id: 27, name: 'Elastic Adhesive Bandage Pack', genericName: 'Cotton Elastic Bandage', brand: 'MedCure', category: 'First Aid', price: 85, oldPrice: 110, img: '27_Bandage_Pack.png', stock: 310, rating: 4.7, reviewCount: 120, rxRequired: false, discount: 22, description: 'Flexible, breathable adhesive bandages for cuts and joint support.', dosageForm: 'Pack', strength: '10cm x 4m', packSize: 'Pack of 5', uses: 'Support for sprains, muscle injuries, and dressing support.', dosage: 'Wrap firmly around affected limb.', sideEffects: 'None.', interactions: 'None.', composition: '100% elastic cotton fabric.', storage: 'Store clean and dry.', manufacturer: 'MedCure Pharmaceuticals', batchNo: 'BT-2024-440', manufacturingDate: '25 Oct 2024', expiryDate: '24 Oct 2029', countryOfOrigin: 'India', medicineType: 'Medical Dressing', inactiveIngredients: 'Hypoallergenic adhesive' },
    { id: 28, name: 'Digital Medical Thermometer', genericName: 'Digital Fever Thermometer', brand: 'MedCure', category: 'Devices', price: 299, oldPrice: 399, img: '28_Thermometer.png', stock: 120, rating: 4.8, reviewCount: 160, rxRequired: false, discount: 25, description: 'Fast 10-second digital fever thermometer with LCD screen and fever alarm.', dosageForm: 'Device', strength: 'Battery Operated', packSize: '1 Unit', uses: 'Oral, axillary, or rectal temperature measurement.', dosage: 'Place tip under tongue or armpit until beep.', sideEffects: 'None.', interactions: 'None.', composition: 'Medical grade ABS plastic + digital sensor.', storage: 'Clean tip with alcohol swab after use.', manufacturer: 'MedCure Electronics', batchNo: 'BT-2024-450', manufacturingDate: '01 Nov 2024', expiryDate: '31 Oct 2029', countryOfOrigin: 'India', medicineType: 'Diagnostic Device', inactiveIngredients: 'LR41 battery included' },
    { id: 29, name: '3-Ply Surgical Mask (Pack of 10)', genericName: 'Meltblown 3-Layer Filter Mask', brand: 'MedCure', category: 'Hygiene', price: 150, oldPrice: 200, img: '29_Surgical_Mask.png', stock: 400, rating: 4.9, reviewCount: 230, rxRequired: false, discount: 25, description: 'Certified 3-ply protective medical face masks with soft earloops.', dosageForm: 'Pack', strength: 'BFE >= 98%', packSize: 'Pack of 10', uses: 'Protection against airborne droplets, dust, and pathogens.', dosage: 'Single-use. Replace when damp.', sideEffects: 'None.', interactions: 'None.', composition: 'Non-woven fabric + Meltblown filter layer.', storage: 'Store in dry hygienic place.', manufacturer: 'MedCure Safety Products', batchNo: 'BT-2024-460', manufacturingDate: '05 Nov 2024', expiryDate: '04 Nov 2027', countryOfOrigin: 'India', medicineType: 'Personal Protective Equipment', inactiveIngredients: 'Elastic earloops, nose wire' },
    { id: 30, name: 'Emergency First Aid Medical Kit', genericName: 'Complete First Aid Kit', brand: 'MedCure', category: 'First Aid', price: 850, oldPrice: 1100, img: '30_First_Aid_Kit.png', stock: 75, rating: 5.0, reviewCount: 145, rxRequired: false, discount: 23, description: 'Comprehensive medical emergency kit for homes, offices, and travel.', dosageForm: 'Kit', strength: '45 Items Included', packSize: '1 Compact Case', uses: 'Emergency handling of cuts, burns, sprains, and minor injuries.', dosage: 'Use components as needed per emergency manual.', sideEffects: 'None.', interactions: 'None.', composition: 'Includes bandages, antiseptic, scissors, tape, gloves, burn gel, etc.', storage: 'Keep in easily accessible location.', manufacturer: 'MedCure Safety Products', batchNo: 'BT-2024-470', manufacturingDate: '10 Nov 2024', expiryDate: '09 Nov 2027', countryOfOrigin: 'India', medicineType: 'Emergency Kit', inactiveIngredients: 'Waterproof nylon pouch' },
  ],
  categories: [
    { id: 1, name: 'Pain Relief', icon: '🩹', color: '#ef4444', count: 34 },
    { id: 2, name: 'Antibiotics', icon: '🧪', color: '#f59e0b', count: 28 },
    { id: 3, name: 'Vitamins', icon: '💊', color: '#22c55e', count: 45 },
    { id: 4, name: 'Cardiology', icon: '❤️', color: '#ef4444', count: 22 },
    { id: 5, name: 'Diabetes', icon: '🩸', color: '#8b5cf6', count: 18 },
    { id: 6, name: 'Allergy', icon: '🌿', color: '#14b8a6', count: 31 },
    { id: 7, name: 'Gastro', icon: '🫁', color: '#f97316', count: 25 },
    { id: 8, name: 'Respiratory', icon: '💨', color: '#06b6d4', count: 20 },
  ],
  orders: [
    { id: 'ORD-20241201', date: '01 Dec 2024', status: 'Delivered', total: 545, items: 3 },
    { id: 'ORD-20241118', date: '18 Nov 2024', status: 'Delivered', total: 380, items: 2 },
    { id: 'ORD-20241205', date: '05 Dec 2024', status: 'Processing', total: 720, items: 4 },
    { id: 'ORD-20241210', date: '10 Dec 2024', status: 'Pending', total: 299, items: 1 },
    { id: 'ORD-20241215', date: '15 Dec 2024', status: 'Cancelled', total: 460, items: 2 },
  ],
  customers: [
    { id: 'C001', name: 'Priya Sharma', email: 'priya@example.com', phone: '9876543210', orders: 12, status: 'Active', joined: 'Mar 2024' },
    { id: 'C002', name: 'Rahul Mehta', email: 'rahul@example.com', phone: '9123456789', orders: 5, status: 'Active', joined: 'Jun 2024' },
    { id: 'C003', name: 'Anita Singh', email: 'anita@example.com', phone: '9876012345', orders: 8, status: 'Inactive', joined: 'Jan 2024' },
    { id: 'C004', name: 'Vikram Patel', email: 'vikram@example.com', phone: '9000123456', orders: 20, status: 'Active', joined: 'Nov 2023' },
    { id: 'C005', name: 'Neha Gupta', email: 'neha@example.com', phone: '9988776655', orders: 3, status: 'Active', joined: 'Aug 2024' },
    { id: 'C006', name: 'Arjun Rao', email: 'arjun@example.com', phone: '8877665544', orders: 15, status: 'Active', joined: 'Feb 2024' },
    { id: 'C007', name: 'Sunita Desai', email: 'sunita@example.com', phone: '7766554433', orders: 7, status: 'Inactive', joined: 'May 2024' },
    { id: 'C008', name: 'Kiran Joshi', email: 'kiran@example.com', phone: '6655443322', orders: 11, status: 'Active', joined: 'Apr 2024' },
  ],
  pharmacists: [
    { id: 'PH001', name: 'Dr. Amit Kumar', email: 'amit@pharma.com', phone: '9876543210', license: 'PH-MH-2021-001', status: 'Active', joined: 'Jan 2022' },
    { id: 'PH002', name: 'Dr. Sneha Iyer', email: 'sneha@pharma.com', phone: '9123456789', license: 'PH-DL-2020-045', status: 'Active', joined: 'Mar 2021' },
    { id: 'PH003', name: 'Dr. Rohan Verma', email: 'rohan@pharma.com', phone: '8765432109', license: 'PH-GJ-2019-112', status: 'Inactive', joined: 'Jun 2020' },
    { id: 'PH004', name: 'Dr. Meera Shah', email: 'meera@pharma.com', phone: '7654321098', license: 'PH-MH-2022-078', status: 'Active', joined: 'Aug 2022' },
  ],
  brands: [
    { id: 'B001', name: 'BioPharma', country: 'India', products: 45, status: 'Active' },
    { id: 'B002', name: 'MedCure', country: 'India', products: 32, status: 'Active' },
    { id: 'B003', name: 'VitaBoost', country: 'USA', products: 28, status: 'Active' },
    { id: 'B004', name: 'GastroCare', country: 'India', products: 19, status: 'Active' },
    { id: 'B005', name: 'AllerFree', country: 'UK', products: 22, status: 'Inactive' },
    { id: 'B006', name: 'CardioHealth', country: 'Germany', products: 15, status: 'Active' },
    { id: 'B007', name: 'PainGone', country: 'India', products: 38, status: 'Active' },
    { id: 'B008', name: 'BreathEasy', country: 'USA', products: 12, status: 'Active' },
  ],
  suppliers: [
    { id: 'S001', name: 'Sun Pharma Distributors', contact: 'Ramesh Patel', phone: '9876543210', city: 'Mumbai', status: 'Active' },
    { id: 'S002', name: 'Cipla Wholesale', contact: 'Kavita Singh', phone: '9123456789', city: 'Pune', status: 'Active' },
    { id: 'S003', name: 'Abbott Logistics', contact: 'Deepak Sharma', phone: '8765432109', city: 'Delhi', status: 'Active' },
    { id: 'S004', name: 'Lupin Direct', contact: 'Priya Mehta', phone: '7654321098', city: 'Hyderabad', status: 'Inactive' },
    { id: 'S005', name: 'Dr. Reddy\'s Supply', contact: 'Anil Kumar', phone: '6543210987', city: 'Bangalore', status: 'Active' },
  ],
  stockAlerts: {
    low: [
      { name: 'Salbutamol Inhaler', current: 30, min: 50, category: 'Respiratory' },
      { name: 'Atorvastatin 20mg', current: 45, min: 60, category: 'Cardiology' },
      { name: 'Metformin 500mg', current: 60, min: 80, category: 'Diabetes' },
      { name: 'Azithromycin 500mg', current: 40, min: 70, category: 'Antibiotics' },
    ],
    expired: [
      { name: 'Penicillin 250mg', batch: 'BT-2024-001', expiry: '2024-10-31', category: 'Antibiotics', qty: 120 },
      { name: 'Ranitidine 150mg', batch: 'BT-2024-005', expiry: '2024-09-15', category: 'Gastro', qty: 80 },
    ],
    nearExpiry: [
      { name: 'Doxycycline 100mg', batch: 'BT-2024-102', expiry: '2025-01-15', category: 'Antibiotics', qty: 60, daysLeft: 21 },
      { name: 'Clarithromycin', batch: 'BT-2024-089', expiry: '2025-02-01', category: 'Antibiotics', qty: 45, daysLeft: 38 },
      { name: 'Furosemide 40mg', batch: 'BT-2024-074', expiry: '2025-01-28', category: 'Cardiology', qty: 90, daysLeft: 34 },
    ],
  },
};

/* ── Helper Functions ───────────────────────────────────────── */
function formatCurrency(amount) { return '₹' + parseFloat(amount).toFixed(2); }
function formatDate(dateStr) {
  const d = new Date(dateStr);
  return d.toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: 'numeric' });
}
function getStatusBadge(status) {
  const map = {
    'Active': 'badge-success', 'Inactive': 'badge-danger', 'Pending': 'badge-warning',
    'Delivered': 'badge-success', 'Processing': 'badge-info', 'Cancelled': 'badge-danger',
    'Approved': 'badge-success', 'Rejected': 'badge-danger', 'Verified': 'badge-success',
    'Low Stock': 'badge-warning', 'Expired': 'badge-danger', 'In Stock': 'badge-success',
  };
  const cls = map[status] || 'badge-info';
  return `<span class="badge-custom ${cls}">${status}</span>`;
}
function starRating(rating) {
  const full = Math.floor(rating);
  const half = rating % 1 >= 0.5;
  let html = '<span class="star-rating">';
  for (let i = 0; i < full; i++) html += '<i class="bi bi-star-fill"></i>';
  if (half) html += '<i class="bi bi-star-half"></i>';
  for (let i = full + (half ? 1 : 0); i < 5; i++) html += '<i class="bi bi-star"></i>';
  html += `</span> <small class="text-muted-sm">(${rating})</small>`;
  return html;
}
function randomAvatar(name, size = 'md') {
  const colors = ['#1a6bcc', '#00b4d8', '#22c55e', '#f59e0b', '#ef4444', '#8b5cf6', '#ec4899', '#14b8a6'];
  const color = colors[name.charCodeAt(0) % colors.length];
  const initials = name.split(' ').map(w => w[0]).join('').toUpperCase().slice(0, 2);
  return `<div class="avatar avatar-${size}" style="background:${color}">${initials}</div>`;
}

/* ── Nav Account Area ───────────────────────────────────────── */
function getSessionUser() {
  if (window.sessionUser && window.sessionUser.trim() !== '') {
    const email = window.sessionUser.trim();
    const name = email.split('@')[0].replace(/[._]/g, ' ').replace(/\b\w/g, l => l.toUpperCase());
    return { email: email, name: name, role: window.sessionRole || 'customer' };
  }
  return null;
}

function renderNavAccount() {
  const slots = ['navAccountArea', 'homeAccountArea'].map(id => document.getElementById(id)).filter(Boolean);
  if (!slots.length) return;

  const path = window.location.pathname;
  const inCustomer = path.includes('/customer/');
  const user = getSessionUser();
  
  const profileUrl = inCustomer ? 'profile.aspx' : 'customer/profile.aspx';
  const dashboardUrl = inCustomer ? 'dashboard.aspx' : 'customer/dashboard.aspx';
  const ordersUrl = inCustomer ? 'orders.aspx' : 'customer/orders.aspx';
  const prescriptionUrl = inCustomer ? 'prescription.aspx' : 'customer/prescription.aspx';
  const logoutUrl = inCustomer ? '../Logout.aspx' : 'Logout.aspx';

  slots.forEach(slot => {
    if (user) {
      const initials = user.name ? user.name.split(' ').map(w => w[0]).join('').toUpperCase().slice(0, 2) : 'U';
      const colors = ['#1a6bcc', '#00b4d8', '#22c55e', '#8b5cf6', '#ec4899'];
      const bg = colors[(initials.charCodeAt(0) || 0) % colors.length];
      slot.innerHTML = `
        <div class="dropdown">
          <div class="d-flex align-items-center gap-2 cursor-pointer" data-bs-toggle="dropdown" style="cursor:pointer">
            <div class="avatar avatar-sm" style="background:${bg}">${initials}</div>
            <span class="d-none d-md-block fw-600" style="font-size:.82rem">${user.name || 'My Account'}</span>
            <i class="bi bi-chevron-down text-muted small"></i>
          </div>
          <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2" style="border-radius:12px;min-width:190px">
            <li><div class="px-3 py-2 border-bottom"><div class="fw-700 small">${user.name || 'Customer'}</div><div class="text-muted" style="font-size:.75rem">${user.email || ''}</div></div></li>
            <li><a class="dropdown-item py-2" href="${dashboardUrl}"><i class="bi bi-speedometer2 me-2 text-primary"></i>Dashboard</a></li>
            <li><a class="dropdown-item py-2" href="${profileUrl}"><i class="bi bi-person me-2"></i>My Profile</a></li>
            <li><a class="dropdown-item py-2" href="${ordersUrl}"><i class="bi bi-bag me-2"></i>My Orders</a></li>
            <li><a class="dropdown-item py-2" href="${prescriptionUrl}"><i class="bi bi-file-medical me-2"></i>Prescriptions</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item py-2 text-danger" href="${logoutUrl}"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
          </ul>
        </div>`;
    } else {
      const loginHref = inCustomer ? 'login.aspx' : 'customer/login.aspx';
      slot.innerHTML = `
        <a href="${loginHref}" class="btn btn-primary-custom btn-sm fw-600" style="padding:.45rem 1rem;border-radius:8px">
          <i class="bi bi-person me-1"></i>Login
        </a>`;
    }
  });
}

/* ── Nav Links (dynamic guest vs logged-in) ─────────────────── */
function renderNavLinks() {
  const navList = document.getElementById('navLinks');
  if (!navList) return;

  const path = window.location.pathname;
  const inCustomer = path.includes('/customer/');
  const base = inCustomer ? '' : 'customer/';
  const rootBase = inCustomer ? '../' : '';
  const user = getSessionUser();

  // Determine active page
  const page = path.split('/').pop() || 'index.aspx';
  const isActive = (p) => (page === p || page === p.replace('.html', '.aspx')) ? 'active' : '';

  let links = '';
  if (user) {
    // Logged-in nav: Dashboard, Medicines, Orders, Prescription, Feedback
    links = `
      <li class="nav-item"><a class="nav-link nav-link-custom ${isActive('dashboard.aspx')}" href="${base}dashboard.aspx"><i class="bi bi-speedometer2 me-1"></i>Dashboard</a></li>
      <li class="nav-item"><a class="nav-link nav-link-custom ${isActive('medicines.aspx')}" href="${base}medicines.aspx"><i class="bi bi-capsule me-1"></i>Medicines</a></li>
      <li class="nav-item"><a class="nav-link nav-link-custom ${isActive('orders.aspx')}" href="${base}orders.aspx"><i class="bi bi-bag-check me-1"></i>Orders</a></li>
      <li class="nav-item"><a class="nav-link nav-link-custom ${isActive('prescription.aspx')}" href="${base}prescription.aspx"><i class="bi bi-file-medical me-1"></i>Prescription</a></li>
      <li class="nav-item"><a class="nav-link nav-link-custom ${isActive('feedback.aspx')}" href="${base}feedback.aspx"><i class="bi bi-star me-1"></i>Feedback</a></li>`;
  } else {
    // Guest nav: Home, Medicines, About, Contact
    links = `
      <li class="nav-item"><a class="nav-link nav-link-custom ${isActive('index.aspx')}" href="${rootBase}index.aspx"><i class="bi bi-house-door me-1"></i>Home</a></li>
      <li class="nav-item"><a class="nav-link nav-link-custom ${isActive('medicines.aspx')}" href="${base}medicines.aspx"><i class="bi bi-capsule me-1"></i>Medicines</a></li>
      <li class="nav-item"><a class="nav-link nav-link-custom ${isActive('about.aspx')}" href="${base}about.aspx"><i class="bi bi-info-circle me-1"></i>About</a></li>
      <li class="nav-item"><a class="nav-link nav-link-custom ${isActive('contact.aspx')}" href="${base}contact.aspx"><i class="bi bi-envelope me-1"></i>Contact</a></li>`;
  }
  navList.innerHTML = links;
}

/* ── Init on DOM Ready ──────────────────────────────────────── */
document.addEventListener('DOMContentLoaded', () => {
  initScrollAnimations();
  Cart.updateBadge();
  renderNavAccount();
  renderNavLinks();

  // Handle navbar search inputs
  document.querySelectorAll('.nav-search-input').forEach(input => {
    input.addEventListener('keydown', e => {
      if (e.key === 'Enter') {
        const query = input.value.trim();
        const inCustomer = window.location.pathname.includes('/customer/');
        const isAspx = window.location.pathname.endsWith('.aspx');
        const ext = isAspx ? '.aspx' : '.html';
        const target = (inCustomer ? '' : 'customer/') + `medicines${ext}` + (query ? '?search=' + encodeURIComponent(query) : '');
        window.location.href = target;
      }
    });
  });

  // Cart links — no login required

  // Add page enter animation
  document.body.classList.add('page-enter');
});

/* ── Export for modules ─────────────────────────────────────── */
window.showToast = showToast;
window.showConfirm = showConfirm;
window.showLoader = showLoader;
window.hideLoader = hideLoader;
window.Cart = Cart;
window.DummyData = DummyData;
window.initSidebar = initSidebar;
window.initSubnav  = initSubnav;
window.filterTable = filterTable;
window.initPagination = initPagination;
window.initDropzone = initDropzone;
window.formatCurrency = formatCurrency;
window.getStatusBadge = getStatusBadge;
window.starRating = starRating;
window.randomAvatar = randomAvatar;
window.renderNavAccount = renderNavAccount;
window.renderNavLinks = renderNavLinks;
window.Auth = Auth;

