/**
 * Grok Imagine Playground — Main Application Logic
 */

// ─── State ──────────────────────────────────────────────
let currentUser = null;
let idToken = null;
let activeTab = 'text_to_image';
let uploadedImageBase64 = null;
let creditCosts = { text_to_image: 5, image_to_video: 20, text_to_video: 25, text_to_audio: 10 };
let bdtPerCredit = 1;
let pollingInterval = null;
const tabNames = ['text_to_image', 'image_to_video', 'text_to_video', 'text_to_audio'];
let adminSettings = null;

// ─── Auth State Listener ────────────────────────────────
auth.onAuthStateChanged(async (user) => {
    if (user) {
        currentUser = user;
        idToken = await user.getIdToken();

        // Update UI
        document.getElementById('authBtnText').textContent = 'Sign Out';
        document.getElementById('userAvatar').style.display = 'block';
        document.getElementById('userPhoto').src = user.photoURL || '';
        document.getElementById('creditsDisplay').style.display = 'flex';
        document.getElementById('buyCreditsBtn').style.display = 'inline-flex';
        document.getElementById('historySection').style.display = 'block';

        // Refresh token periodically
        setInterval(async () => {
            idToken = await user.getIdToken(true);
        }, 50 * 60 * 1000); // every 50 min

        // Load credits & history
        await loadCredits();
        loadHistory();
        tabNames.forEach(t => updateCalculatedCost(t));
    } else {
        currentUser = null;
        idToken = null;
        document.getElementById('authBtnText').textContent = 'Sign In';
        document.getElementById('userAvatar').style.display = 'none';
        document.getElementById('creditsDisplay').style.display = 'none';
        document.getElementById('buyCreditsBtn').style.display = 'none';
        document.getElementById('historySection').style.display = 'none';
    }
});

// ─── Auth Handlers ──────────────────────────────────────
function handleAuth() {
    if (currentUser) {
        auth.signOut();
        showToast('Signed out successfully', 'info');
    } else {
        openModal('authModal');
    }
}

async function signInWithGoogle() {
    try {
        await auth.signInWithPopup(googleProvider);
        closeModal('authModal');
        showToast('Welcome! Signed in successfully', 'success');
    } catch (err) {
        console.error('Sign in error:', err);
        showToast('Sign in failed: ' + err.message, 'error');
    }
}

// ─── Tab Switching ──────────────────────────────────────────
function switchTab(tabName, pushState = true) {
    if (!tabNames.includes(tabName) || tabName === activeTab) return;

    activeTab = tabName;

    // Update tab styles
    document.querySelectorAll('.tab').forEach(t => {
        t.classList.remove('active');
        t.setAttribute('aria-selected', 'false');
    });
    const activeTabEl = document.querySelector(`.tab[data-tab="${tabName}"]`);
    if (activeTabEl) {
        activeTabEl.classList.add('active');
        activeTabEl.setAttribute('aria-selected', 'true');
        updateIndicator(activeTabEl);
    }

    // Show panel
    document.querySelectorAll('.gen-panel').forEach(p => p.classList.remove('active'));
    document.getElementById(`panel-${tabName}`).classList.add('active');

    // Hide output
    document.getElementById('outputArea').style.display = 'none';
    document.getElementById('loadingArea').style.display = 'none';

    // Update URL hash
    if (pushState) {
        history.replaceState(null, '', '#' + tabName);
    }
}

function updateIndicator(tab) {
    const indicator = document.getElementById('tabIndicator');
    if (!tab || !indicator) return;
    const rect = tab.getBoundingClientRect();
    const containerRect = tab.parentElement.getBoundingClientRect();
    indicator.style.width = `${rect.width}px`;
    indicator.style.left = `${rect.left - containerRect.left}px`;
}

document.querySelectorAll('.tab').forEach(tab => {
    tab.addEventListener('click', () => switchTab(tab.dataset.tab));
});

// Restore tab from URL hash on load
window.addEventListener('load', () => {
    const hash = window.location.hash.replace('#', '');
    if (tabNames.includes(hash)) {
        switchTab(hash, false);
    } else {
        updateIndicator(document.querySelector('.tab.active'));
    }
    tabNames.forEach(t => updateCalculatedCost(t));
});

// Handle browser back/forward
window.addEventListener('popstate', () => {
    const hash = window.location.hash.replace('#', '');
    if (tabNames.includes(hash)) {
        switchTab(hash, false);
    }
});

// ─── Image Upload ───────────────────────────────────────
function handleImageUpload(input) {
    const file = input.files[0];
    if (!file) return;

    if (!file.type.startsWith('image/')) {
        showToast('Please upload an image file', 'error');
        return;
    }

    if (file.size > 10 * 1024 * 1024) {
        showToast('Image must be under 10MB', 'error');
        return;
    }

    const reader = new FileReader();
    reader.onload = (e) => {
        uploadedImageBase64 = e.target.result;
        document.getElementById('uploadPreview').src = uploadedImageBase64;
        document.getElementById('uploadPreview').style.display = 'block';
        document.getElementById('uploadPlaceholder').style.display = 'none';
        document.getElementById('uploadZone').classList.add('has-image');
    };
    reader.readAsDataURL(file);
}

// Drag and drop
const uploadZone = document.getElementById('uploadZone');
if (uploadZone) {
    uploadZone.addEventListener('dragover', (e) => {
        e.preventDefault();
        uploadZone.style.borderColor = 'var(--accent-1)';
    });
    uploadZone.addEventListener('dragleave', () => {
        uploadZone.style.borderColor = '';
    });
    uploadZone.addEventListener('drop', (e) => {
        e.preventDefault();
        uploadZone.style.borderColor = '';
        const file = e.dataTransfer.files[0];
        if (file) {
            document.getElementById('imageUpload').files = e.dataTransfer.files;
            handleImageUpload(document.getElementById('imageUpload'));
        }
    });
}

// ─── Generation ─────────────────────────────────────────
async function handleGenerate(type) {
    if (!currentUser) {
        openModal('authModal');
        return;
    }

    const promptId = type === 'text_to_image' ? 'prompt-t2i' :
        type === 'image_to_video' ? 'prompt-i2v' :
            type === 'text_to_video' ? 'prompt-t2v' : 'prompt-t2a';
    const prompt = document.getElementById(promptId).value.trim();

    if (!prompt) {
        showToast('Please enter a prompt', 'error');
        return;
    }

    if (type === 'image_to_video' && !uploadedImageBase64) {
        showToast('Please upload an image first', 'error');
        return;
    }

    // Show loading
    const btnId = `genBtn-${type === 'text_to_image' ? 't2i' : type === 'image_to_video' ? 'i2v' : type === 'text_to_video' ? 't2v' : 't2a'}`;
    const btn = document.getElementById(btnId);
    btn.disabled = true;
    const oldHtml = btn.innerHTML;
    btn.innerHTML = '<span class="btn-loading"></span> Generating...';

    document.getElementById('outputArea').style.display = 'none';
    document.getElementById('loadingArea').style.display = 'block';
    document.getElementById('loadingText').textContent = 'Creating your creation...';

    try {
        const body = { type, prompt };
        if (type === 'image_to_video' && uploadedImageBase64) {
            body.image = uploadedImageBase64;
        }

        // Gather customization options
        if (type === 'text_to_image') {
            body.model = document.getElementById('opt-t2i-model').value;
            body.aspect_ratio = document.getElementById('opt-t2i-ratio').value;
            body.resolution = document.getElementById('opt-t2i-quality').value;
        } else if (type === 'image_to_video') {
            body.model = document.getElementById('opt-i2v-model').value;
            body.aspect_ratio = document.getElementById('opt-i2v-ratio').value;
            body.resolution = document.getElementById('opt-i2v-resolution').value;
            body.duration = parseInt(document.getElementById('opt-i2v-duration').value);
        } else if (type === 'text_to_video') {
            body.model = document.getElementById('opt-t2v-model').value;
            body.aspect_ratio = document.getElementById('opt-t2v-ratio').value;
            body.resolution = document.getElementById('opt-t2v-resolution').value;
            body.duration = parseInt(document.getElementById('opt-t2v-duration').value);
        } else if (type === 'text_to_audio') {
            body.model = document.getElementById('opt-t2a-model').value;
            body.voice = document.getElementById('opt-t2a-voice').value;
        }

        const res = await apiCall('/api/generate.php', 'POST', body);

        if (res.error) throw new Error(res.error);

        await loadCredits();

        if (res.status === 'completed' && res.output_url) {
            showOutput(res.output_url, type);
        } else if (res.request_id) {
            startPolling(res.request_id, res.generation_id, type);
        }

    } catch (err) {
        showToast(err.message || 'Generation failed', 'error');
        document.getElementById('loadingArea').style.display = 'none';
    } finally {
        btn.disabled = false;
        btn.innerHTML = oldHtml;
    }
}

// ─── Polling ────────────────────────────────────────────
function startPolling(requestId, generationId, type) {
    if (pollingInterval) clearInterval(pollingInterval);
    let attempts = 0;
    pollingInterval = setInterval(async () => {
        attempts++;
        if (attempts >= 60) {
            clearInterval(pollingInterval);
            document.getElementById('loadingArea').style.display = 'none';
            showToast('Generation timed out', 'error');
            return;
        }
        try {
            const res = await apiCall(`/api/poll.php?request_id=${encodeURIComponent(requestId)}&generation_id=${encodeURIComponent(generationId)}`, 'GET');
            if (res.status === 'completed' && res.output_url) {
                clearInterval(pollingInterval);
                showOutput(res.output_url, type);
            } else if (res.status === 'failed') {
                clearInterval(pollingInterval);
                document.getElementById('loadingArea').style.display = 'none';
                showToast('Generation failed', 'error');
            }
        } catch (err) { }
    }, 5000);
}

// ─── Output Display ─────────────────────────────────────
function showOutput(url, type) {
    document.getElementById('loadingArea').style.display = 'none';
    const outputArea = document.getElementById('outputArea');
    const outputContent = document.getElementById('outputContent');
    outputArea.style.display = 'block';

    if (type === 'text_to_image') {
        outputContent.innerHTML = `<img src="${url}" alt="Generated image" id="outputMedia" />`;
    } else if (type === 'text_to_audio') {
        outputContent.innerHTML = `<audio src="${url}" controls autoplay id="outputMedia"></audio>`;
    } else {
        outputContent.innerHTML = `<video src="${url}" controls autoplay id="outputMedia"></video>`;
    }

    outputArea.dataset.url = url;
    outputArea.dataset.type = type;
    showToast('Generation complete!', 'success');
    loadHistory();
}

function downloadOutput() {
    const url = document.getElementById('outputArea').dataset.url;
    if (!url) return;
    const a = document.createElement('a');
    a.href = url;
    a.download = `grok-${Date.now()}`;
    a.target = '_blank';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
}

// ─── Credits & Pricing ──────────────────────────────────
async function loadCredits() {
    if (!currentUser) return;
    try {
        const res = await apiCall('/api/credits.php', 'GET');
        if (res.credits !== undefined) {
            document.getElementById('creditsCount').textContent = res.credits;
            ['t2i', 'i2v', 't2v', 't2a'].forEach(id => {
                const el = document.getElementById(`balance-${id}`);
                if (el) {
                    el.style.display = 'block';
                    el.innerHTML = `Available: <strong>${res.credits}</strong> credits`;
                }
            });
        }
    } catch (err) { }
}

async function fetchAdminSettings() {
    try {
        const res = await apiCall('/api/admin.php', 'GET');
        if (res.settings) {
            adminSettings = res.settings;
            tabNames.forEach(t => updateCalculatedCost(t));
        }
    } catch (err) { }
}

function updateCalculatedCost(type) {
    const settings = adminSettings || {};
    const bdtPerUsd = parseFloat(settings.bdt_per_usd || 120);
    const bdtPerCredit = parseFloat(settings.bdt_per_credit || 1);
    let costUsd = 0;
    let costElId = '';

    if (type === 'text_to_image') {
        const model = document.getElementById('opt-t2i-model')?.value || 'grok-imagine-image';
        costUsd = model === 'grok-imagine-image-pro' ? parseFloat(settings.image_pro_cost || 0.07) : parseFloat(settings.text_to_image_cost || 0.02);
        costElId = 'cost-t2i';
    } else if (type === 'image_to_video' || type === 'text_to_video') {
        const el = document.getElementById(type === 'image_to_video' ? 'opt-i2v-duration' : 'opt-t2v-duration');
        const duration = el ? parseInt(el.value) : 5;
        costUsd = duration * parseFloat(settings.video_per_sec_cost || 0.05);
        costElId = type === 'image_to_video' ? 'cost-i2v' : 'cost-t2v';
    } else if (type === 'text_to_audio') {
        const text = document.getElementById('prompt-t2a')?.value || '';
        costUsd = (text.length / 1000000) * parseFloat(settings.audio_per_1k_chars_cost || 4.20);
        if (text.length > 0 && costUsd < 0.01) costUsd = 0.01;
        costElId = 'cost-t2a';
    }

    const credits = Math.ceil((costUsd * bdtPerUsd) / bdtPerCredit);
    const el = document.getElementById(costElId);
    if (el) el.innerHTML = `Cost: <strong>${credits}</strong> credits`;

    if (!adminSettings) fetchAdminSettings();
}

// ─── Modals ─────────────────────────────────────────────
function openModal(id) {
    const el = document.getElementById(id);
    if (el) el.classList.add('show');
    document.body.style.overflow = 'hidden';
}

function closeModal(id) {
    const el = document.getElementById(id);
    if (el) el.classList.remove('show');
    document.body.style.overflow = '';
}

function openBuyModal() {
    if (!currentUser) { openModal('authModal'); return; }
    updateSlider();
    openModal('buyModal');
}

function updateSlider() {
    const slider = document.getElementById('creditSlider');
    const credits = parseInt(slider.value);
    document.getElementById('sliderValue').textContent = `${credits} Credits`;
    document.getElementById('priceAmount').textContent = `৳${Math.round(credits * bdtPerCredit)}`;
}

async function buyCredits() {
    const credits = parseInt(document.getElementById('creditSlider').value);
    const btn = document.getElementById('btn-buy-bkash');
    const oldHtml = btn.innerHTML;

    try {
        // Show loading state
        btn.disabled = true;
        btn.innerHTML = '<span class="btn-loading"></span> Processing...';

        const res = await apiCall('/api/bkash.php?action=create', 'POST', { credits });
        if (res.bkashURL) {
            window.location.href = res.bkashURL;
        } else {
            throw new Error(res.error || 'Payment failed');
        }
    } catch (err) {
        showToast(err.message, 'error');
        // Revert button state on error
        btn.disabled = false;
        btn.innerHTML = oldHtml;
    }
}

function openGiftModal() {
    if (!currentUser) { openModal('authModal'); return; }
    openModal('giftModal');
}

async function giftCredits() {
    const email = document.getElementById('giftEmail').value.trim();
    const amount = parseInt(document.getElementById('giftAmount').value);
    if (!email || !amount || amount < 1) { showToast('Invalid input', 'error'); return; }
    try {
        const res = await apiCall('/api/credits.php', 'POST', { action: 'gift', email, credits: amount });
        if (res.success) {
            closeModal('giftModal');
            loadCredits();
            showToast(res.message, 'success');
        } else throw new Error(res.error);
    } catch (err) { showToast(err.message, 'error'); }
}

// ─── History ────────────────────────────────────────────
let historyPage = 1;
async function loadHistory(page) {
    if (!currentUser) return;
    if (page) historyPage = page;
    const type = document.getElementById('historyFilterType')?.value || '';
    const from = document.getElementById('historyFilterFrom')?.value || '';
    const to = document.getElementById('historyFilterTo')?.value || '';
    let url = `/api/history.php?page=${historyPage}&limit=12`;
    if (type) url += `&type=${type}`;
    if (from) url += `&date_from=${from}`;
    if (to) url += `&date_to=${to}`;

    try {
        const res = await apiCall(url, 'GET');
        const grid = document.getElementById('historyGrid');
        if (!res.generations?.length) {
            grid.innerHTML = '<p style="text-align:center;padding:24px;">No creations yet</p>';
            document.getElementById('historyPagination').innerHTML = '';
            return;
        }
        grid.innerHTML = res.generations.map(gen => {
            const isVideo = gen.type !== 'text_to_image';
            const media = (gen.status === 'completed' && gen.output_url)
                ? (isVideo ? `<video src="${gen.output_url}" muted></video>` : `<img src="${gen.output_url}" loading="lazy" />`)
                : `<div class="history-item-placeholder">${gen.status}</div>`;
            return `<div class="history-item" onclick="showOutput('${gen.output_url}', '${gen.type}')">
                ${media}
                <div class="history-item-info">
                    <span class="history-item-type">${gen.type.replace(/_/g, ' ')}</span>
                    <div class="history-item-prompt">${escapeHtml(gen.prompt)}</div>
                </div>
            </div>`;
        }).join('');
    } catch (err) { }
}

// ─── API & Utils ────────────────────────────────────────
async function apiCall(endpoint, method = 'GET', body = null) {
    const headers = { 'Content-Type': 'application/json' };
    if (idToken) headers['Authorization'] = `Bearer ${idToken}`;
    const res = await fetch(endpoint, { method, headers, body: body ? JSON.stringify(body) : null });
    const data = await res.json();
    if (!res.ok) throw new Error(data.error || 'API Error');
    return data;
}

function showToast(message, type = 'info') {
    const container = document.getElementById('toastContainer');
    const toast = document.createElement('div');
    toast.className = `toast ${type}`;
    toast.textContent = message;
    container.appendChild(toast);
    setTimeout(() => {
        toast.style.opacity = '0';
        setTimeout(() => toast.remove(), 300);
    }, 4000);
}

function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

// ─── Overlay Listeners ──────────────────────────────────
document.querySelectorAll('.modal-overlay').forEach(overlay => {
    overlay.addEventListener('click', (e) => {
        if (e.target === overlay) closeModal(overlay.id);
    });
});

document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') {
        document.querySelectorAll('.modal-overlay.show').forEach(m => closeModal(m.id));
    }
});
