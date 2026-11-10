/* ============================================================
   MEDICINE DETAILS PAGE - JAVASCRIPT
   Handles dynamic content loading, interactions, and state management
   ============================================================ */

let currentMedicine = null;
let currentQuantity = 1;
let maxQuantity = 1;

/* ── Initialize Page on Load ───────────────────────────────── */
document.addEventListener('DOMContentLoaded', () => {
  renderNavAccount();
  Cart.updateBadge();
  
  const urlParams = new URLSearchParams(window.location.search);
  const medicineId = parseInt(urlParams.get('id'));

  if (!medicineId) {
    showErrorState();
    return;
  }

  // Find medicine in data
  currentMedicine = DummyData.medicines.find(m => m.id === medicineId);

  if (!currentMedicine) {
    showErrorState();
    return;
  }

  // Populate page with medicine data
  populateMedicineData();
  populateRelatedMedicines();

  // Show content
  document.getElementById('loadingState').style.display = 'none';
  document.getElementById('medContent').style.display = 'block';

  // Scroll animations
  initScrollAnimations();
});

/* ── Populate Main Medicine Data ───────────────────────────── */
function populateMedicineData() {
  if (!currentMedicine) return;

  // Update page title
  document.title = `${currentMedicine.name} — MediCare Pharmacy`;

  // Breadcrumb
  document.getElementById('breadcrumbMedicine').textContent = currentMedicine.name;

  // Image Section
  const imgWrap = document.getElementById('medImageMain');
  if (imgWrap) {
    imgWrap.innerHTML = renderMedicineImage(currentMedicine.img, currentMedicine.name, 'img-fluid med-detail-main-img');
  }
  
  // Discount badge
  if (currentMedicine.discount) {
    document.getElementById('discountBadge').style.display = 'block';
    document.getElementById('discountPercent').textContent = `-${currentMedicine.discount}%`;
  }

  // Badges
  document.getElementById('medCategoryBadge').textContent = currentMedicine.category || 'General';
  document.getElementById('medBrandBadge').textContent = currentMedicine.brand || 'Brand';
  
  if (currentMedicine.rxRequired) {
    document.getElementById('rxBadge').style.display = 'inline-block';
    document.getElementById('prescriptionWarning').style.display = 'block';
  }

  // Name and info
  document.getElementById('medName').textContent = currentMedicine.name;
  document.getElementById('medGenericName').textContent = currentMedicine.genericName || currentMedicine.name.split(' ')[0];

  // Rating
  const ratingHtml = starRating(currentMedicine.rating);
  document.getElementById('medRating').innerHTML = ratingHtml;
  document.getElementById('medRatingText').textContent = `(${currentMedicine.reviewCount || 0} Reviews)`;

  // Price
  document.getElementById('medPrice').textContent = `₹${currentMedicine.price}`;
  document.getElementById('medOldPrice').textContent = `₹${currentMedicine.oldPrice || currentMedicine.price}`;
  document.getElementById('medDiscountBadge').textContent = `-${currentMedicine.discount || 0}%`;
  
  // Calculate savings
  const savings = (currentMedicine.oldPrice || currentMedicine.price) - currentMedicine.price;
  document.getElementById('savings').textContent = `₹${savings}`;

  // Stock information
  maxQuantity = currentMedicine.stock || 0;
  const stockStatus = maxQuantity > 50 ? 'In Stock' : maxQuantity > 0 ? 'Low Stock' : 'Out of Stock';
  const stockClass = maxQuantity > 50 ? 'stock-in-stock' : maxQuantity > 0 ? 'stock-low-stock' : 'stock-out';
  
  const stockEl = document.getElementById('medStockStatus');
  stockEl.className = `stock-indicator-detail ${stockClass}`;
  stockEl.innerHTML = `<span class="stock-dot"></span>${stockStatus}`;
  document.getElementById('medStockQty').textContent = `(${maxQuantity} units available)`;

  // Medicine properties
  document.getElementById('medDosageForm').textContent = currentMedicine.dosageForm || 'Tablet';
  document.getElementById('medStrength').textContent = currentMedicine.strength || '500 mg';
  document.getElementById('medPackSize').textContent = currentMedicine.packSize || '10 Tablets';

  // Product description
  document.getElementById('medDescription').textContent = currentMedicine.description || 'High-quality medicine for general use.';

  // Uses and benefits
  const usesText = currentMedicine.uses || `${currentMedicine.name} is used for relieving pain, fever, and related conditions. Always follow your doctor's advice.`;
  document.getElementById('medUses').textContent = usesText;
  document.getElementById('medUsesDetails').textContent = usesText;

  // Dosage tab
  const dosageHtml = `
    <strong>Recommended Usage:</strong>
    <p>${currentMedicine.dosage || 'Take 1-2 tablets as prescribed by your physician, twice or thrice daily after meals.'}</p>
    
    <strong>How to Take:</strong>
    <p>Swallow the tablet whole with a glass of water. Do not chew or crush.</p>
    
    <strong>Frequency:</strong>
    <p>Follow the dosage as recommended by your healthcare provider or as mentioned on the label.</p>
    
    <strong>Missed Dose:</strong>
    <p>If you miss a dose, take it as soon as you remember. However, if it is almost time for the next dose, skip the missed dose and continue with the regular schedule.</p>
    
    <strong>Overdose Warning:</strong>
    <p>In case of overdose, seek immediate medical attention or contact poison control center.</p>
  `;
  document.getElementById('medDosage').innerHTML = dosageHtml;

  // Safety tab
  const safetyHtml = `
    <strong>Warnings:</strong>
    <ul>
      <li>Do not use if allergic to any component of this medicine.</li>
      <li>${currentMedicine.rxRequired ? 'This is a prescription medicine. Use only on medical advice.' : 'Use only as directed.'}</li>
      <li>Keep out of reach of children.</li>
    </ul>
    
    <strong>Precautions:</strong>
    <ul>
      <li>Inform your doctor if you have liver or kidney disease.</li>
      <li>Avoid consuming alcohol while taking this medicine.</li>
      <li>Not recommended during pregnancy without medical supervision.</li>
    </ul>
    
    <strong>Contraindications:</strong>
    <p>Should not be used in patients with known hypersensitivity to the active ingredients.</p>
    
    <strong>Drug Interactions:</strong>
    <p>${currentMedicine.interactions || 'May interact with certain other medicines. Inform your doctor about all medicines you are taking.'}</p>
  `;
  document.getElementById('medSafety').innerHTML = safetyHtml;

  // Side Effects tab
  const sideEffectsHtml = `
    <strong>Common Side Effects:</strong>
    <p>${currentMedicine.sideEffects || 'Nausea, headache, dizziness, or mild stomach upset (usually temporary and resolve on their own).'}</p>
    
    <strong>Serious Side Effects:</strong>
    <p>Allergic reactions, severe rash, breathing difficulties, or chest pain. Seek immediate medical attention if experienced.</p>
    
    <strong>When to Contact a Doctor:</strong>
    <p>If side effects persist or worsen, contact your healthcare provider immediately.</p>
  `;
  document.getElementById('medSideEffects').innerHTML = sideEffectsHtml;

  // Composition tab
  document.getElementById('medActiveIngredient').textContent = currentMedicine.genericName || currentMedicine.name.split(' ')[0];
  document.getElementById('medCompositionStrength').textContent = currentMedicine.strength || '500 mg';
  document.getElementById('medInactiveIngredients').textContent = currentMedicine.inactiveIngredients || 'Microcrystalline cellulose, stearic acid, silicon dioxide, and other pharmaceutical excipients.';

  // Storage tab
  const storageHtml = `
    <strong>Storage Temperature:</strong>
    <p>${currentMedicine.storage || 'Store below 25°C (room temperature).'}</p>
    
    <strong>Protection:</strong>
    <ul>
      <li>Protect from light and direct sunlight.</li>
      <li>Keep away from moisture and humidity.</li>
      <li>Store in a cool, dry place.</li>
    </ul>
    
    <strong>Safety Precautions:</strong>
    <ul>
      <li>Keep away from children and pets.</li>
      <li>Do not store in bathroom or near sources of heat.</li>
      <li>Keep in original packaging if possible.</li>
    </ul>
  `;
  document.getElementById('medStorage').innerHTML = storageHtml;

  // Brand and manufacturer details
  document.getElementById('detailManufacturer').textContent = currentMedicine.manufacturer || currentMedicine.brand;
  document.getElementById('detailBrand').textContent = currentMedicine.brand;
  document.getElementById('detailExpiryDate').textContent = currentMedicine.expiryDate || '31 Dec 2026';
  document.getElementById('detailCountry').textContent = currentMedicine.countryOfOrigin || 'India';

  // Update quantity controls
  updateQuantityControls();
}

/* ── Quantity Controls ─────────────────────────────────────── */
function updateQuantity(change) {
  const newQty = currentQuantity + change;
  if (newQty >= 1 && newQty <= maxQuantity) {
    currentQuantity = newQty;
    updateQuantityControls();
  }
}

function updateQuantityControls() {
  document.getElementById('qtyInput').value = currentQuantity;
  
  // Update button states
  const minusBtn = document.getElementById('qtyMinusBtn');
  const plusBtn = document.getElementById('qtyPlusBtn');
  
  minusBtn.disabled = currentQuantity <= 1;
  plusBtn.disabled = currentQuantity >= maxQuantity;

  // Show warning if stock is running out
  const warningEl = document.getElementById('qtyWarning');
  if (maxQuantity <= 0) {
    warningEl.textContent = 'Out of stock';
    warningEl.style.display = 'block';
  } else if (maxQuantity < 10) {
    warningEl.textContent = `Only ${maxQuantity} units left!`;
    warningEl.style.display = 'block';
  } else {
    warningEl.style.display = 'none';
  }

  // Disable add to cart button if out of stock
  document.getElementById('addToCartBtn').disabled = maxQuantity <= 0;
  document.getElementById('buyNowBtn').disabled = maxQuantity <= 0;
}

/* ── Add to Cart ───────────────────────────────────────────── */
function addToCart() {
  if (!currentMedicine || maxQuantity <= 0) return;

  const items = Cart.get();
  const existing = items.find(i => i.id === currentMedicine.id);
  
  if (existing) {
    existing.qty = (existing.qty || 1) + currentQuantity;
  } else {
    items.push({
      id: currentMedicine.id,
      name: currentMedicine.name,
      price: currentMedicine.price,
      img: currentMedicine.img,
      brand: currentMedicine.brand,
      qty: currentQuantity
    });
  }

  Cart.save(items);
  showToast(`${currentMedicine.name} (${currentQuantity}x) added to cart!`, 'success');
  currentQuantity = 1;
  updateQuantityControls();
}

/* ── Buy Now ───────────────────────────────────────────────── */
function buyNow() {
  addToCart();
  setTimeout(() => {
    window.location.href = 'cart.html';
  }, 500);
}

/* ── Wishlist Toggle ───────────────────────────────────────── */
function toggleWishlist() {
  const btn = document.getElementById('wishlistBtn');
  btn.classList.toggle('active');
  const isActive = btn.classList.contains('active');
  
  if (isActive) {
    btn.innerHTML = '<i class="bi bi-heart-fill"></i>';
    showToast(`${currentMedicine.name} added to wishlist!`, 'info');
  } else {
    btn.innerHTML = '<i class="bi bi-heart"></i>';
    showToast(`${currentMedicine.name} removed from wishlist`, 'warning');
  }
}

/* ── Related Medicines ─────────────────────────────────────── */
function populateRelatedMedicines() {
  if (!currentMedicine) return;

  // Find related medicines (same category or brand)
  let related = DummyData.medicines.filter(m => 
    m.id !== currentMedicine.id && 
    (m.category === currentMedicine.category || m.brand === currentMedicine.brand)
  );

  // If not enough, add medicines from same category, then any medicine
  if (related.length < 6) {
    related = DummyData.medicines.filter(m => m.id !== currentMedicine.id);
  }

  // Limit to 6
  related = related.slice(0, 6);

  const relatedContainer = document.getElementById('relatedMedicines');
  relatedContainer.innerHTML = related.map(med => `
    <div class="col-md-4 col-lg-2">
      <div class="related-med-card" onclick="goToMedicine(${med.id})">
        <div class="related-med-img">${renderMedicineImage(med.img, med.name, '', 'max-height:80px;object-fit:contain')}</div>
        <div class="related-med-body">
          <div class="related-med-brand">${med.brand}</div>
          <div class="related-med-name">${med.name}</div>
          <div class="related-med-rating">
            ${Array.from({length: Math.floor(med.rating)}, () => '<i class="bi bi-star-fill"></i>').join('')}
            <small>(${med.rating})</small>
          </div>
          <div class="related-med-price">
            ₹${med.price}
            <span class="related-med-old-price">₹${med.oldPrice}</span>
          </div>
          <div class="related-med-stock">
            ${med.stock > 50 ? '✓ In Stock' : med.stock > 0 ? '⚠ Low Stock' : '✗ Out of Stock'}
          </div>
          <button class="related-med-button">View Details</button>
        </div>
      </div>
    </div>
  `).join('');
}

function goToMedicine(id) {
  window.location.href = `medicine-details.html?id=${id}`;
}

function toggleProductInfo(button, contentId) {
  const content = document.getElementById(contentId);
  const isExpanded = button.getAttribute('aria-expanded') === 'true';

  button.setAttribute('aria-expanded', String(!isExpanded));
  content.hidden = isExpanded;
}

/* ── Error State ───────────────────────────────────────────── */
function showErrorState() {
  document.getElementById('loadingState').style.display = 'none';
  document.getElementById('errorState').style.display = 'block';
  document.getElementById('medContent').style.display = 'none';
}

/* ── Helper Functions ──────────────────────────────────────── */
function starRating(rating) {
  const full = Math.floor(rating);
  const half = rating % 1 >= 0.5;
  let html = '<span class="star-rating">';
  
  for (let i = 0; i < full; i++) {
    html += '<i class="bi bi-star-fill"></i>';
  }
  
  if (half) {
    html += '<i class="bi bi-star-half"></i>';
  }
  
  for (let i = full + (half ? 1 : 0); i < 5; i++) {
    html += '<i class="bi bi-star"></i>';
  }
  
  html += '</span>';
  return html;
}

/* ── Initialize on every page load ─────────────────────────── */
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', () => {
    Cart.updateBadge();
  });
} else {
  Cart.updateBadge();
}
