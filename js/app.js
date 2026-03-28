/**
 * Grok Imagine Playground — Main Application Logic
 */

// ─── State ──────────────────────────────────────────────
let currentUser = null;
let idToken = null;
let activeTab = 'image';
let uploadedImageBase64 = null;
let creditCosts = { text_to_image: 5, image_edit: 10, image_to_video: 20, text_to_video: 25, text_to_audio: 10 };
let bdtPerCredit = 2;
let pollingInterval = null;
const tabNames = ['image', 'video', 'text_to_audio'];
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
        document.getElementById('earnCreditsBtn').style.display = 'inline-flex';
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
        document.getElementById('earnCreditsBtn').style.display = 'none';
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
    uploadedImageBase64 = null;
    
    // Clear all previews
    ['image', 'video'].forEach(prefix => {
        const preview = document.getElementById(`preview-${prefix}`);
        const placeholder = document.getElementById(`placeholder-${prefix}`);
        const zone = document.getElementById(`upload-${prefix}`);
        const container = document.getElementById(`preview-container-${prefix}`);
        if (preview) preview.src = '';
        if (container) container.style.display = 'none';
        if (placeholder) placeholder.style.display = 'flex';
        if (zone) zone.classList.remove('has-image');
    });

    // CRITICAL: Clear global state for upload when switching mode
    uploadedImageBase64 = null;
    tabNames.forEach(t => {
        const input = document.getElementById(`file-${t}`);
        if(input) input.value = '';
    });

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
/**
 * Compresses an image file using Canvas.
 */
function compressImage(file, maxDim = 2048, quality = 0.8) {
    return new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = (e) => {
            const img = new Image();
            img.onload = () => {
                let width = img.width;
                let height = img.height;
                if (width > maxDim || height > maxDim) {
                    const ratio = width / height;
                    if (ratio > 1) {
                        width = maxDim;
                        height = Math.round(maxDim / ratio);
                    } else {
                        height = maxDim;
                        width = Math.round(maxDim * ratio);
                    }
                }
                const canvas = document.createElement('canvas');
                canvas.width = width;
                canvas.height = height;
                const ctx = canvas.getContext('2d');
                ctx.drawImage(img, 0, 0, width, height);
                resolve(canvas.toDataURL('image/jpeg', quality));
            };
            img.onerror = (err) => reject(err);
            img.src = e.target.result;
        };
        reader.onerror = (err) => reject(err);
    });
}
function handleImageUpload(e, type) {
    const input = e.target || e;
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

    (async () => {
        try {
            uploadedImageBase64 = await compressImage(file);
            const preview = document.getElementById(`preview-${type}`);
            const placeholder = document.getElementById(`placeholder-${type}`);
            const zone = document.getElementById(`upload-${type}`);
            const container = document.getElementById(`preview-container-${type}`);
            
            preview.src = uploadedImageBase64;
            preview.style.display = 'block'; // Ensure it's visible even if it was hidden by a previous onerror
            container.style.display = 'block';
            placeholder.style.display = 'none';
            zone.classList.add('has-image');
            updateCalculatedCost(type);
        } catch (err) {
            showToast('Image processing failed: ' + err.message, 'error');
        }
    })();
}

function clearImage(e, type) {
    if (e) e.stopPropagation();
    uploadedImageBase64 = null;
    document.getElementById(`file-${type}`).value = '';
    
    document.getElementById(`preview-container-${type}`).style.display = 'none';
    document.getElementById(`preview-${type}`).src = '';
    document.getElementById(`placeholder-${type}`).style.display = 'flex';
    document.getElementById(`upload-${type}`).classList.remove('has-image');
    updateCalculatedCost(type);
}

// Drag and drop
['image', 'video'].forEach(type => {
    const zone = document.getElementById(`upload-${type}`);
    if (zone) {
        zone.addEventListener('dragover', (e) => {
            e.preventDefault();
            zone.style.borderColor = 'var(--accent-1)';
        });
        zone.addEventListener('dragleave', () => {
            zone.style.borderColor = '';
        });
        zone.addEventListener('drop', (e) => {
            e.preventDefault();
            zone.style.borderColor = '';
            const file = e.dataTransfer.files[0];
            if (file) {
                const input = document.getElementById(`file-${type}`);
                input.files = e.dataTransfer.files;
                handleImageUpload(input, type);
            }
        });
    }
});

// ─── Generation ─────────────────────────────────────────
async function handleGenerate(tabType) {
    if (!currentUser) {
        openModal('authModal');
        return;
    }

    const promptId = tabType === 'text_to_audio' ? 'prompt-t2a' : `prompt-${tabType}`;
    const prompt = document.getElementById(promptId)?.value.trim() || '';

    // Map UI tab to backend type
    let type = tabType;
    if (tabType === 'image') {
        type = uploadedImageBase64 ? 'image_edit' : 'text_to_image';
    } else if (tabType === 'video') {
        type = uploadedImageBase64 ? 'image_to_video' : 'text_to_video';
    }

    if (!prompt) {
        showToast('Please enter a prompt', 'error');
        return;
    }

    // Show loading
    const btnId = tabType === 'text_to_audio' ? 'genBtn-t2a' : `genBtn-${tabType}`;
    const btn = document.getElementById(btnId);
    if(btn) btn.disabled = true;
    const oldHtml = btn ? btn.innerHTML : '';
    if(btn) btn.innerHTML = '<span class="btn-loading"></span> Generating...';

    document.getElementById('outputArea').style.display = 'none';
    document.getElementById('loadingArea').style.display = 'block';
    document.getElementById('loadingText').textContent = type.includes('video') ? 'Generating video... (usually 20-90 seconds)' : 'Generating your creation...';

    try {
        const body = { type, prompt };
        if (uploadedImageBase64 && (type === 'image_edit' || type === 'image_to_video')) {
            body.image = uploadedImageBase64;
        }

        // Gather customization options
        if (tabType === 'image') {
            body.model = document.getElementById('opt-image-model').value;
            body.aspect_ratio = document.getElementById('opt-image-ratio').value;
            body.resolution = document.getElementById('opt-image-quality').value;
        } else if (tabType === 'video') {
            body.model = document.getElementById('opt-video-model').value;
            body.aspect_ratio = document.getElementById('opt-video-ratio').value;
            body.resolution = document.getElementById('opt-video-resolution').value;
            body.duration = parseInt(document.getElementById('opt-video-duration').value);
        } else if (tabType === 'text_to_audio') {
            if (prompt.length > 15000) {
                showToast('Text is too long. Please keep it under 15,000 characters.', 'error');
                return;
            }
            body.model = document.getElementById('opt-t2a-model').value;
            body.voice = document.getElementById('opt-t2a-voice').value;
            body.quality = document.getElementById('opt-t2a-quality').value;
        }

        const res = await apiCall('/api/generate.php', 'POST', body);

        if (res.error) {
            const msg = typeof res.error === 'object' ? (res.error.message || 'Generation failed') : res.error;
            throw new Error(msg);
        }

        await loadCredits();

        if (res.status === 'completed' && res.output_url) {
            clearImage(null, tabType); 
            showOutput(res.output_url, type);
        } else if (res.generation_id) {
            clearImage(null, tabType); 
            startPolling(res.generation_id, type);
        }

    } catch (err) {
        showToast(err.message || 'Generation failed', 'error');
        document.getElementById('loadingArea').style.display = 'none';
    } finally {
        if(btn) {
            btn.disabled = false;
            btn.innerHTML = oldHtml;
        }
    }
}

// ─── Polling ────────────────────────────────────────────
const activePools = new Map();
function startPolling(generationId, type) {
    if (activePools.has(generationId)) return;
    
    let attempts = 0;
    const maxAttempts = 60; 

    const interval = setInterval(async () => {
        attempts++;
        if (attempts > maxAttempts) {
            clearInterval(interval);
            activePools.delete(generationId);
            return;
        }

        try {
            const res = await apiCall('/api/poll.php', 'POST', { generation_id: generationId });

            if (res.status === 'completed' && res.output_url) {
                clearInterval(interval);
                activePools.delete(generationId);
                showOutput(res.output_url, type);
            } else if (res.status === 'failed' || res.status === 'expired') {
                clearInterval(interval);
                activePools.delete(generationId);
                showToast(`Generation failed: ${res.error || 'Unknown error'}`, 'error');
                loadHistory(historyPage);
            }
        } catch (err) {
            console.error('Poll error:', err);
        }
    }, 5000);
    
    activePools.set(generationId, interval);
}

// ─── Output Display ─────────────────────────────────────
function showOutput(url, type) {
    document.getElementById('loadingArea').style.display = 'none';
    const outputArea = document.getElementById('outputArea');
    const outputContent = document.getElementById('outputContent');
    
    // Smooth transition
    outputArea.style.opacity = '0';
    outputArea.style.display = 'block';
    
    let html = '';
    if (type === 'text_to_image' || type === 'image_edit') {
        html = `<div class="output-wrapper">
                    <img src="${url}" alt="Generated image" id="outputMedia" class="reveal-anim" onerror="this.style.display='none'" />
                </div>`;
    } else if (type === 'text_to_audio') {
        html = `<div class="output-wrapper audio-player">
                    <audio src="${url}" controls autoplay id="outputMedia"></audio>
                </div>`;
    } else {
        html = `<div class="output-wrapper">
                    <video src="${url}" controls autoplay loop playsinline id="outputMedia" class="reveal-anim" onerror="this.parentElement.innerHTML='<p class=\'error\'>Failed to load video</p>'"></video>
                </div>`;
    }

    outputContent.innerHTML = html;
    
    // Add Share button if not present
    const header = document.querySelector('.output-header');
    if (!document.getElementById('shareBtn')) {
        const shareBtn = document.createElement('button');
        shareBtn.id = 'shareBtn';
        shareBtn.className = 'btn btn-ghost btn-sm';
        shareBtn.style.marginLeft = '8px';
        shareBtn.innerHTML = `<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 12v8a2 2 0 002 2h12a2 2 0 002-2v-8M16 6l-4-4-4 4M12 2v13"/></svg> Share`;
        shareBtn.onclick = () => {
            navigator.clipboard.writeText(url);
            showToast('Link copied to clipboard!', 'success');
        };
        header.appendChild(shareBtn);
    }

    setTimeout(() => {
        outputArea.style.transition = 'opacity 0.5s ease';
        outputArea.style.opacity = '1';
    }, 50);

    outputArea.dataset.url = url;
    outputArea.dataset.type = type;
    showToast('Generation complete!', 'success');
    loadHistory(1);
}

function downloadOutput() {
    const url = document.getElementById('outputArea').dataset.url;
    if (!url) return;
    
    // For cloud storage URLs, we might need to fetch and blob to force download
    fetch(url)
        .then(response => response.blob())
        .then(blob => {
            const blobUrl = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = blobUrl;
            const outputType = document.getElementById('outputArea').dataset.type || '';
            a.download = `grok-${Date.now()}.${outputType.includes('image') ? 'png' : outputType.includes('audio') ? 'mp3' : 'mp4'}`;
            document.body.appendChild(a);
            a.click();
            window.URL.revokeObjectURL(blobUrl);
            document.body.removeChild(a);
        })
        .catch(() => {
            // Fallback to simple link
            window.open(url, '_blank');
        });
}

// ─── Credits & Pricing ──────────────────────────────────
async function loadCredits() {
    if (!currentUser) return;
    try {
        const res = await apiCall('/api/credits.php', 'GET');
        if (res.credits !== undefined) {
            document.getElementById('creditsCount').textContent = res.credits;
            ['t2i', 'edit', 'i2v', 't2v', 't2a'].forEach(id => {
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
        const res = await apiCall('/api/settings.php', 'GET');
        if (res.settings) {
            adminSettings = res.settings;
            tabNames.forEach(t => updateCalculatedCost(t));
            updateSlider(); // Update UI with latest bdtPerCredit value
            switchTab(activeTab); // Ensure selected tab blur is rendered on load

            // Sync site name if available
            if (res.settings.site_name) {
                document.title = `${res.settings.site_name} — AI Image & Video Generator`;
            }
        }
    } catch (err) { }
}

function updateCalculatedCost(tabType) {
    const s = adminSettings || {};
    const markup = parseFloat(s.global_markup || 1.5);
    const bdtUsd = parseFloat(s.bdt_per_usd || 145);
    const bdtCr = parseFloat(s.bdt_per_credit || 2);
    let costUsd = 0;
    let costElId = '';

    if (tabType === 'image') {
        const model = document.getElementById('opt-image-model')?.value || 'grok-imagine-image';
        costUsd = model === 'grok-imagine-image-pro' ? parseFloat(s.image_pro_cost || 0.08) : parseFloat(s.text_to_image_cost || 0.04);
        costElId = 'cost-image';
    } else if (tabType === 'video') {
        const dEl = document.getElementById('opt-video-duration');
        const duration = dEl ? parseInt(dEl.value) : 5;
        const resEl = document.getElementById('opt-video-resolution');
        const resolution = resEl ? resEl.value : '480p';
        
        const perSec = (resolution === '720p') ? parseFloat(s.video_720p_cost || 0.18) : parseFloat(s.video_480p_cost || 0.10);
        costUsd = duration * perSec;
        costElId = 'cost-video';
    } else if (tabType === 'text_to_audio') {
        const text = document.getElementById('prompt-t2a')?.value || '';
        costUsd = (text.length / 1000) * parseFloat(s.audio_per_1k_chars_cost || 0.0045);
        if (text.length > 0 && costUsd < 0.01) costUsd = 0.01;
        costElId = 'cost-t2a';
    }

    const credits = Math.ceil((costUsd * markup * bdtUsd) / bdtCr);
    const el = document.getElementById(costElId);
    if (el) el.innerHTML = `Cost: <strong>${credits}</strong> credits`;
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

// ─── Referral System ────────────────────────────────────
async function openReferralModal() {
    openModal('referralModal');
    
    // Load fresh stats and code
    try {
        const res = await apiCall('api/referrals.php');
        if (res.success) {
            document.getElementById('refCount').textContent = res.total_referrals || 0;
            document.getElementById('refEarned').textContent = res.total_earned || 0;
            
            // Use custom referral code if set, otherwise fallback to UID
            const code = res.referral_code || (currentUser ? currentUser.uid : '');
            const refLink = `${window.location.origin}${window.location.pathname}?ref=${code}`;
            document.getElementById('refLinkInput').value = refLink;
        }
    } catch (err) {
        console.error('Failed to load referral stats:', err);
        // Fallback to UID if API fails
        if (currentUser) {
            const refLink = `${window.location.origin}${window.location.pathname}?ref=${currentUser.uid}`;
            document.getElementById('refLinkInput').value = refLink;
        }
    }
    
    // Referral rewards display
    const referrerReward = adminSettings?.referral_reward_referrer || 10;
    const inviteeReward = adminSettings?.referral_reward_invitee || 5;
    document.getElementById('refReferrerReward').textContent = referrerReward;
    document.getElementById('refInviteeReward').textContent = inviteeReward;

    loadReferralStats();
    openModal('referralModal');
}

async function loadReferralStats() {
    try {
        const res = await apiCall('/api/referrals.php', 'GET');
        if (res.count !== undefined) {
            document.getElementById('refCount').textContent = res.count;
            document.getElementById('refEarned').textContent = res.earned;
        }
    } catch (err) { }
}

function copyReferralLink() {
    const input = document.getElementById('refLinkInput');
    input.select();
    navigator.clipboard.writeText(input.value);
    showToast('Referral link copied!', 'success');
}

function shareReferral(platform) {
    const link = document.getElementById('refLinkInput').value;
    const text = `Join Grok Playground and get bonus AI credits! 🚀\n\n${link}`;
    let url = '';

    switch(platform) {
        case 'twitter':
            url = `https://twitter.com/intent/tweet?text=${encodeURIComponent(text)}`;
            break;
        case 'whatsapp':
            url = `https://wa.me/?text=${encodeURIComponent(text)}`;
            break;
        case 'facebook':
            url = `https://www.facebook.com/sharer/sharer.php?u=${encodeURIComponent(link)}`;
            break;
    }

    if (url) window.open(url, '_blank');
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
            const isVideo = gen.type === 'image_to_video' || gen.type === 'text_to_video';
            const isAudio = gen.type === 'text_to_audio';
            
            let media = '';
            const thumb = gen.input_thumbnail || gen.output_url;

            if (gen.status === 'completed' && gen.output_url) {
                if (isVideo) {
                    media = `<video src="${gen.output_url}" poster="${gen.input_thumbnail || ''}" muted onerror="this.style.display='none'"></video>`;
                } else if (isAudio) {
                    media = `<div class="history-item-placeholder audio-bg">🎵 Audio</div>`;
                } else {
                    media = `<img src="${gen.output_url}" loading="lazy" onerror="this.style.display='none'" />`;
                }
            } else {
                // Show thumbnail even if not completed (for video/edit)
                if (thumb && !isAudio) {
                    media = `<div class="history-item-preview">
                                <img src="${thumb}" loading="lazy" style="opacity: 0.6;" onerror="this.style.display='none'">
                                <div class="status-overlay">${gen.status}</div>
                             </div>`;
                } else {
                    media = `<div class="history-item-placeholder">${gen.status}</div>`;
                }
            }
            
            if (gen.status === 'processing' || gen.status === 'pending') {
                startPolling(gen.id, gen.type);
            }

            return `<div class="history-item" onclick="${gen.status === 'completed' ? `showOutput('${gen.output_url}', '${gen.type}')` : `showToast('Generation is ${gen.status}.', 'info')`}">
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
    
    // Add referral code if present in localStorage
    const refCode = localStorage.getItem('grok_ref_code');
    if (refCode) {
        headers['X-Referral-Code'] = refCode;
    }

    const res = await fetch(endpoint, { method, headers, body: body ? JSON.stringify(body) : null });
    const data = await res.json();
    if (!res.ok) {
        const msg = typeof data.error === 'object' ? (data.error.message || 'API Error') : (data.error || 'API Error');
        throw new Error(msg);
    }
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

// ─── Initialization ───────────────────────────────────────
document.addEventListener('DOMContentLoaded', () => {
    fetchAdminSettings();

    // Referral Tracking: Check for ?ref= in URL
    const urlParams = new URLSearchParams(window.location.search);
    const ref = urlParams.get('ref');
    if (ref) {
        localStorage.setItem('grok_ref_code', ref);
        // Clean URL without reloading
        const newUrl = window.location.origin + window.location.pathname + window.location.hash;
        window.history.replaceState({}, document.title, newUrl);
        showToast('Referral code applied!', 'success');
    }
});

