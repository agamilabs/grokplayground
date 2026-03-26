/**
 * Grok Imagine Chat — Conversational Logic
 */

// ─── State ──────────────────────────────────────────────
let currentUser = null;
let idToken = null;
let uploadedImageBase64 = null;
let bdtPerCredit = 2;
let adminSettings = null;
let historyOffset = 0;
const historyLimit = 10;

// ─── Auth State Listener ────────────────────────────────
auth.onAuthStateChanged(async (user) => {
    if (user) {
        currentUser = user;
        idToken = await user.getIdToken();
        document.getElementById('userProfile').style.display = 'flex';
        document.getElementById('sidebarUserPhoto').src = user.photoURL || '';
        document.getElementById('navUserPhoto').src = user.photoURL || '';
        document.getElementById('sidebarUserName').textContent = user.displayName || 'User';
        
        // Fetch settings then initialize UI
        try {
            const res = await apiCall('/api/settings.php', 'GET');
            adminSettings = res.settings;
        } catch(e) {}
        
        await loadCredits();
        loadSidebarHistory();
        initChatHistory(); // Load last 2 generations into chat
        onModeChange(); // Initialize options and cost
    } else {
        currentUser = null;
        idToken = null;
        document.getElementById('userProfile').style.display = 'none';
        openModal('authModal');
    }
});

// ─── Chat Logic ─────────────────────────────────────────
function appendMessage(role, content, media = null, status = 'completed', id = null, position = 'append', thumbnail = null) {
    const container = document.getElementById('messagesContainer');
    const emptyState = container.querySelector('.empty-state');
    if (emptyState && position === 'append') emptyState.remove();

    const msgDiv = document.createElement('div');
    msgDiv.className = `message msg-${role}`;
    if (id) msgDiv.id = `msg-${id}`;

    // Avatars
    const avatar = document.createElement('div');
    avatar.className = 'message-avatar';
    if (role === 'ai') {
        avatar.innerHTML = `<img src="favicon.svg" alt="Grok" style="width:100%; height:100%; border-radius:inherit;">`;
    } else {
        const photo = currentUser?.photoURL || 'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y';
        avatar.innerHTML = `<img src="${photo}" alt="User" style="width:100%; height:100%; border-radius:inherit;">`;
    }

    const contentDiv = document.createElement('div');
    contentDiv.className = 'message-content';
    
    let text = (content && status !== 'failed') ? `<p>${escapeHtml(content)}</p>` : '';
    let mediaHtml = '';

    if (role === 'user' && media) {
        // Show input image for user
        const thumbSrc = thumbnail || media;
        mediaHtml = `<div class="user-media reveal-anim"><img src="${thumbSrc}" onclick="window.open('${media}', '_blank')" title="Click to view original"></div>`;
    } else if (status === 'processing') {
        mediaHtml = `<div class="ai-media processing">
            <div class="skeleton-loader">
                <div class="shimmer shimmer-media"></div>
                <div class="shimmer shimmer-text"></div>
                <div class="shimmer shimmer-text-short"></div>
            </div>
        </div>`;
    } else if (status === 'failed') {
        mediaHtml = `<div class="ai-media error"><p>${escapeHtml(content || 'Generation failed. Credits have been refunded.')}</p></div>`;
    } else if (media) {
        if (media.includes('.mp4') || media.includes('video')) {
            mediaHtml = `<div class="ai-media reveal-anim"><video src="${media}" controls loop autoplay></video></div>`;
        } else if (media.includes('.mp3') || media.includes('audio')) {
            mediaHtml = `<div class="ai-media reveal-anim"><audio src="${media}" controls autoplay></audio></div>`;
        } else {
            mediaHtml = `<div class="ai-media reveal-anim"><img src="${media}" onclick="window.open('${media}', '_blank')"></div>`;
        }
        
        mediaHtml += `
            <div class="message-actions">
                <button class="action-btn" title="Copy Link" onclick="copyToClipboard('${media}')">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg>
                </button>
                <button class="action-btn" title="Download" onclick="downloadFile('${media}')">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>
                </button>
            </div>`;
    }

    contentDiv.innerHTML = text + mediaHtml;
    msgDiv.appendChild(avatar);
    msgDiv.appendChild(contentDiv);
    
    if (position === 'append') {
        container.appendChild(msgDiv);
        container.scrollTop = container.scrollHeight;
    } else {
        container.insertBefore(msgDiv, document.getElementById('loadPreviousContainer').nextSibling);
    }
    
    return msgDiv;
}

async function initChatHistory() {
    // Load exactly 2 last generations into the chat view
    try {
        const res = await apiCall('/api/history.php?limit=1', 'GET');
        if (res.generations && res.generations.length > 0) {
            const emptyState = document.querySelector('.empty-state');
            if (emptyState) emptyState.remove();
            
            // Sort to show newest at bottom
            res.generations.reverse().forEach(gen => {
                const msgId = gen.status === 'processing' ? 'gen_' + gen.id : null;
                appendMessage('user', gen.prompt, gen.input_url, 'completed', null, gen.input_thumbnail);
                appendMessage('ai', '', gen.output_url, gen.status, msgId);
                
                if (gen.status === 'processing' && gen.xai_request_id) {
                    startPolling(gen.xai_request_id, msgId);
                }
            });
            historyOffset = 1;
            document.getElementById('loadPreviousContainer').style.display = 'block';
        }
    } catch (err) {}
}

async function loadMoreHistory() {
    try {
        const btn = document.querySelector('#loadPreviousContainer button');
        btn.textContent = 'Loading...';
        
        const res = await apiCall(`/api/history.php?limit=${historyLimit}&offset=${historyOffset}`, 'GET');
        
        if (res.generations && res.generations.length > 0) {
            res.generations.forEach(gen => {
                const msgId = gen.status === 'processing' ? 'gen_' + gen.id : null;
                // Prepend AI then User (since we're moving backwards)
                appendMessage('ai', '', gen.output_url, gen.status, msgId, 'prepend');
                appendMessage('user', gen.prompt, gen.input_url, 'completed', null, 'prepend', gen.input_thumbnail);
                
                if (gen.status === 'processing' && gen.xai_request_id) {
                    startPolling(gen.xai_request_id, msgId);
                }
            });
            historyOffset += res.generations.length;
        } else {
            document.getElementById('loadPreviousContainer').style.display = 'none';
        }
        btn.textContent = 'Load Previous Generations';
    } catch (err) {
        console.error(err);
    }
}

async function sendChat() {
    if (!currentUser) { alert('Please sign in'); return; }
    
    const input = document.getElementById('chatInput');
    const prompt = input.value.trim();
    if (!prompt) return;

    const type = document.getElementById('chatMode').value;
    const model = document.getElementById('chatModel').value;
    const aspect_ratio = document.getElementById('chatAspect').value;
    const resolution = document.getElementById('chatResolution').value;
    const duration = parseInt(document.getElementById('chatDuration').value);

    // Show user message
    appendMessage('user', prompt, uploadedImageBase64);
    
    // Clear input
    input.value = '';
    input.style.height = 'auto';
    const attachment = uploadedImageBase64;
    clearAttachment();

    // Show AI loading
    const aiMsgId = 'gen_' + Date.now();
    appendMessage('ai', '', null, 'processing', aiMsgId);

    try {
        const body = { type, prompt, model };
        
        if (type !== 'text_to_audio') {
            body.aspect_ratio = aspect_ratio;
            body.resolution = resolution;
        }

        if (type === 'text_to_video' || type === 'image_to_video') {
            body.duration = duration;
        }

        if (attachment) {
            body.image = attachment;
        }

        const res = await apiCall('/api/generate.php', 'POST', body);

        if (res.error) throw new Error(res.error);

        if (res.status === 'completed' && res.output_url) {
            // Immediate (Image/Audio)
            updateMessage(aiMsgId, '', res.output_url, 'completed');
            loadCredits();
        } else if (res.request_id) {
            // Video generation - start polling with xAI request_id
            startPolling(res.request_id, aiMsgId);
        } else if (res.generation_id) {
            // Fallback: poll by generation_id
            startPolling(null, aiMsgId, res.generation_id);
        } else {
            throw new Error('Unexpected API response');
        }
    } catch (err) {
        updateMessage(aiMsgId, 'Error: ' + err.message, null, 'failed');
    }
}

function updateMessage(id, content, media, status) {
    const msgDiv = document.getElementById(`msg-${id}`);
    if (!msgDiv) return;
    
    const contentDiv = msgDiv.querySelector('.message-content');
    let text = (content && status !== 'failed') ? `<p>${escapeHtml(content)}</p>` : '';
    let mediaHtml = '';

    if (status === 'processing') {
        mediaHtml = `<div class="ai-media processing">
            <div class="skeleton-loader">
                <div class="shimmer shimmer-media"></div>
                <div class="shimmer shimmer-text"></div>
                <div class="shimmer shimmer-text-short"></div>
            </div>
        </div>`;
    } else if (status === 'failed') {
        mediaHtml = `<div class="ai-media error"><p>${escapeHtml(content || 'Generation failed')}</p></div>`;
    } else if (media) {
        const isVideo = media.includes('.mp4') || media.includes('video');
        const isAudio = media.includes('.mp3') || media.includes('audio');
        if (isVideo) {
            mediaHtml = `<div class="ai-media reveal-anim"><video src="${media}" controls loop autoplay></video></div>`;
        } else if (isAudio) {
            mediaHtml = `<div class="ai-media reveal-anim"><audio src="${media}" controls autoplay></audio></div>`;
        } else {
            mediaHtml = `<div class="ai-media reveal-anim"><img src="${media}" onclick="window.open('${media}', '_blank')"></div>`;
        }

        mediaHtml += `
            <div class="message-actions">
                <button class="action-btn" title="Copy Link" onclick="copyToClipboard('${media}')">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg>
                </button>
                <button class="action-btn" title="Download" onclick="downloadFile('${media}')">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path><polyline points="7 10 12 15 17 10"></polyline><line x1="12" y1="15" x2="12" y2="3"></line></svg>
                </button>
            </div>`;
    }

    contentDiv.innerHTML = text + mediaHtml;
    document.getElementById('messagesContainer').scrollTop = document.getElementById('messagesContainer').scrollHeight;
}

// ─── Polling ─────────────────────────────────────────────
async function startPolling(requestId, msgId) {
    const pollInterval = setInterval(async () => {
        try {
            const res = await apiCall('/api/poll.php', 'POST', { request_id: requestId });
            if (res.status === 'completed') {
                clearInterval(pollInterval);
                updateMessage(msgId, '', res.output_url, 'completed');
                loadCredits();
            } else if (res.status === 'failed') {
                clearInterval(pollInterval);
                updateMessage(msgId, 'Generation failed: ' + (res.error || 'Unknown error'), null, 'failed');
            }
        } catch (err) {
            clearInterval(pollInterval);
            updateMessage(msgId, 'Polling error: ' + err.message, null, 'failed');
        }
    }, 3000);
}

// ─── Initialization ──────────────────────────────────────
async function loadCredits() {
    try {
        const res = await apiCall('/api/credits.php', 'GET');
        document.getElementById('sidebarCredits').textContent = res.credits;
        document.getElementById('headerCredits').textContent = res.credits;
        currentUser.credits = res.credits;
    } catch (err) {}
}

function getModeIcon(type) {
    const icons = {
        'text_to_image': `<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="18" height="18" rx="2" /><circle cx="8.5" cy="8.5" r="1.5" /><path d="M21 15l-5-5L5 21" /></svg>`,
        'image_edit': `<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7" /><path d="M18.5 2.5a2.121 2.121 0 1 1 3 3L12 15l-4 1 1-4 9.5-9.5z" /></svg>`,
        'image_to_video': `<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="2" width="20" height="20" rx="2.18" /><path d="M10 8l6 4-6 4V8z" /></svg>`,
        'text_to_video': `<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polygon points="23 7 16 12 23 17 23 7" /><rect x="1" y="5" width="15" height="14" rx="2" /></svg>`,
        'text_to_audio': `<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 5L6 9H2v6h4l5 4V5zM15.54 8.46a5 5 0 0 1 0 7.07M19.07 4.93a10 10 0 0 1 0 14.14" /></svg>`
    };
    return icons[type] || icons['text_to_image'];
}

async function loadSidebarHistory() {
    try {
        const res = await apiCall('/api/history.php?limit=25', 'GET');
        const list = document.getElementById('chatHistory');
        list.innerHTML = '';
        res.generations.forEach(gen => {
            const item = document.createElement('div');
            item.className = 'history-item';
            item.innerHTML = `
                <div class="history-icon">${getModeIcon(gen.type)}</div>
                <div class="history-text">${escapeHtml(gen.prompt)}</div>
            `;
            item.title = gen.prompt;
            item.onclick = () => showHistoryItem(gen);
            list.appendChild(item);
        });
    } catch (err) {}
}

function showHistoryItem(gen) {
    if (gen.status === 'completed') {
        appendMessage('user', gen.prompt);
        appendMessage('ai', '', gen.output_url);
    }
}

// ─── Compression Utility ────────────────────────────────
/**
 * Compresses an image file using Canvas.
 * @param {File} file The original file
 * @param {number} maxDim Maximum width/height
 * @param {number} quality JPEG quality (0 to 1)
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

// ─── UI Utils ───────────────────────────────────────────
async function handleChatFile(e) {
    const file = e.target.files[0];
    if (!file) return;

    try {
        // Show immediate loading if needed, but compression is usually fast
        uploadedImageBase64 = await compressImage(file);
        document.getElementById('previewImg').src = uploadedImageBase64;
        document.getElementById('attachmentPreview').style.display = 'block';
        
        const mode = document.getElementById('chatMode');
        if (mode.value === 'text_to_image') {
            mode.value = 'image_edit';
            onModeChange();
        }
    } catch (err) {
        showToast('Image processing failed: ' + err.message, 'error');
    }
}

function clearAttachment() {
    uploadedImageBase64 = null;
    document.getElementById('attachmentPreview').style.display = 'none';
    document.getElementById('chatFile').value = '';
}

function onModeChange() {
    const mode = document.getElementById('chatMode').value;
    
    // 1. Update Visibility
    document.getElementById('ctrl-aspect').style.display = mode.includes('audio') ? 'none' : 'flex';
    document.getElementById('ctrl-resolution').style.display = mode.includes('audio') ? 'none' : 'flex';
    document.getElementById('ctrl-duration').style.display = mode.includes('video') ? 'flex' : 'none';
    document.getElementById('ctrl-model').style.display = mode.includes('audio') ? 'none' : 'flex';

    // 2. Update Options
    updateOptions(mode);
    
    // 3. Update Cost
    updateCalculatedCost();
}

function updateOptions(mode) {
    const resSelect = document.getElementById('chatResolution');
    const modelSelect = document.getElementById('chatModel');
    
    // Clear & Rebuild Resolution
    resSelect.innerHTML = '';
    if (mode.includes('video')) {
        resSelect.innerHTML = '<option value="480p" selected>480p</option><option value="720p">720p</option>';
    } else if (mode.includes('image')) {
        resSelect.innerHTML = '<option value="1k" selected>1k</option><option value="2k">2k</option>';
    }

    // Adjust Model visibility/options if needed
    if (mode === 'text_to_audio') {
        modelSelect.innerHTML = '<option value="grok-imagine-audio" selected>Grok Audio</option>';
    } else if (mode.includes('video')) {
         modelSelect.innerHTML = '<option value="grok-imagine-video" selected>Grok Video</option>';
    } else {
         modelSelect.innerHTML = '<option value="grok-imagine-image" selected>Standard</option><option value="grok-imagine-image-pro">Pro</option>';
    }
}

function updateCalculatedCost() {
    const type = document.getElementById('chatMode').value;
    const model = document.getElementById('chatModel').value;
    const duration = parseInt(document.getElementById('chatDuration').value) || 5;
    const prompt = document.getElementById('chatInput').value;

    const settings = adminSettings || {};
    const bdtPerUsd = parseFloat(settings.bdt_per_usd || 145);
    const bdtPerCreditVal = parseFloat(settings.bdt_per_credit || 2);
    
    const markup = parseFloat(settings.global_markup || 1.5);

    if (type === 'text_to_image' || type === 'image_edit') {
        if (type === 'image_edit') {
            costUsd = parseFloat(settings.image_edit_cost || 0.08);
        } else {
            costUsd = model === 'grok-imagine-image-pro' ? parseFloat(settings.image_pro_cost || 0.14) : parseFloat(settings.text_to_image_cost || 0.04);
        }
    } else if (type === 'image_to_video' || type === 'text_to_video') {
        const duration = parseInt(document.getElementById('chatDuration')?.value) || 5;
        const resolution = document.getElementById('chatResolution')?.value || '480p';
        const videoBase = parseFloat(settings.video_per_sec_cost || 0.1);
        const resMultiplier = (resolution === '720p') ? parseFloat(settings.video_hd_multiplier || 1.8) : 1.0;
        costUsd = duration * videoBase * resMultiplier;
    } else if (type === 'text_to_audio') {
        costUsd = (prompt.length / 1000) * parseFloat(settings.audio_per_1k_chars_cost || 0.0084);
        if (prompt.length > 0 && costUsd < 0.01) costUsd = 0.01;
    }

    const credits = Math.ceil((costUsd * markup * bdtPerUsd) / bdtPerCreditVal);
    document.getElementById('chatCost').textContent = credits;
}

function autoExpand(el) {
    el.style.height = 'auto';
    el.style.height = el.scrollHeight + 'px';
    updateCalculatedCost();
}

function usePrompt(text) {
    document.getElementById('chatInput').value = text;
    sendChat();
}

function toggleSidebar() {
    document.getElementById('sidebar').classList.toggle('active');
}

function newChat() {
    document.getElementById('messagesContainer').innerHTML = `
        <div class="empty-state">
            <h1>What can I create for you today?</h1>
            <div class="suggestion-grid">
                <button class="suggestion" onclick="usePrompt('A cozy cabin in the woods at night with aurora borealis')">
                    <span>"A cozy cabin in the woods..."</span>
                    <small>Image Generation</small>
                </button>
                <button class="suggestion" onclick="usePrompt('A slow motion wave crashing on a golden beach')">
                    <span>"A slow motion wave..."</span>
                    <small>Video Generation</small>
                </button>
                <button class="suggestion" onclick="usePrompt('Synthwave music with heavy bass and retro vibes')">
                    <span>"Synthwave music..."</span>
                    <small>Audio Generation</small>
                </button>
            </div>
        </div>
    `;
    clearAttachment();
}

// ─── API Core ───────────────────────────────────────────
async function apiCall(endpoint, method = 'GET', body = null) {
    const headers = { 'Content-Type': 'application/json' };
    if (idToken) headers['Authorization'] = `Bearer ${idToken}`;
    const res = await fetch(endpoint, { method, headers, body: body ? JSON.stringify(body) : null });
    const data = await res.json();
    if (!res.ok) throw new Error(data.error || 'API Error');
    return data;
}

// ─── Credits & Pricing ──────────────────────────────────
async function loadCredits() {
    if (!currentUser) return;
    try {
        const res = await apiCall('/api/credits.php', 'GET');
        if (res.credits !== undefined) {
            document.getElementById('sidebarCredits').textContent = res.credits;
            document.getElementById('headerCredits').textContent = res.credits;
        }
    } catch (err) {}
}

async function signInWithGoogle() {
    const provider = new firebase.auth.GoogleAuthProvider();
    try {
        await auth.signInWithPopup(provider);
        closeModal('authModal');
        showToast('Successfully signed in!', 'success');
    } catch (error) {
        showToast(error.message, 'error');
    }
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
    const bdtPerCredit = parseFloat(adminSettings?.bdt_per_credit || 2);
    document.getElementById('sliderValue').textContent = `${credits} Credits`;
    document.getElementById('priceAmount').textContent = `৳${Math.round(credits * bdtPerCredit)}`;
}

async function buyCredits() {
    const credits = parseInt(document.getElementById('creditSlider').value);
    const btn = document.getElementById('btn-buy-bkash');
    const oldHtml = btn.innerHTML;

    try {
        btn.disabled = true;
        btn.innerHTML = '<div class="loading-spinner" style="width:20px;height:20px;"></div> Processing...';

        // Fix: Backend expects { credits: ... } not { amount: ... }
        const res = await apiCall('/api/bkash.php?action=create', 'POST', { credits: credits });
        if (res.bkashURL) {
            window.location.href = res.bkashURL;
        } else {
            throw new Error(res.error || 'Failed to initiate payment');
        }
    } catch (err) {
        showToast(err.message, 'error');
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
    if (!email || !amount || amount < 1) { showToast('Invalid input', 'warning'); return; }

    try {
        // Fix: Backend expects action: 'gift', email: ..., credits: ...
        await apiCall('/api/credits.php', 'POST', { action: 'gift', email, credits: amount });
        showToast('Credits gifted successfully!', 'success');
        closeModal('giftModal');
        loadCredits();
    } catch (err) {
        showToast(err.message, 'error');
    }
}

// ─── Utils ──────────────────────────────────────────────
function showToast(message, type = 'info') {
    const container = document.getElementById('toastContainer');
    if (!container) return;
    const toast = document.createElement('div');
    toast.className = `toast ${type}`;
    toast.style.cssText = `
        background: ${type === 'success' ? '#10b981' : type === 'error' ? '#ef4444' : '#2f2f2f'};
        color: white; padding: 12px 20px; border-radius: 8px; font-size: 14px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.3); margin-bottom: 10px; transition: opacity 0.3s;
    `;
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

function copyToClipboard(text) {
    navigator.clipboard.writeText(text).then(() => {
        showToast('Link copied to clipboard!', 'success');
    }).catch(() => {
        showToast('Failed to copy link', 'error');
    });
}

function downloadFile(url) {
    fetch(url)
        .then(response => response.blob())
        .then(blob => {
            const blobUrl = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = blobUrl;
            a.download = url.split('/').pop().split('?')[0];
            document.body.appendChild(a);
            a.click();
            window.URL.revokeObjectURL(blobUrl);
            document.body.removeChild(a);
        })
        .catch(() => window.open(url, '_blank'));
}

// ─── Showcase Logic ────────────────────────────────────
async function openShowcaseModal() {
    openModal('showcaseModal');
    loadShowcase();
}

async function loadShowcase(type = 'all') {
    const grid = document.getElementById('showcaseGrid');
    const loader = document.getElementById('showcaseLoading');
    
    grid.style.display = 'none';
    loader.style.display = 'block';
    
    try {
        const url = `/api/showcase.php?limit=20${type !== 'all' ? '&type='+type : ''}`;
        const res = await apiCall(url, 'GET');
        renderShowcase(res.items || []);
    } catch (err) {
        showToast('Failed to load showcase', 'error');
    } finally {
        loader.style.display = 'none';
        grid.style.display = 'grid';
    }
}

function renderShowcase(items) {
    const grid = document.getElementById('showcaseGrid');
    grid.innerHTML = '';
    
    if (items.length === 0) {
        grid.innerHTML = '<p style="grid-column:1/-1; text-align:center; padding:40px; color:var(--text-muted);">No items found</p>';
        return;
    }
    
    items.forEach(item => {
        const div = document.createElement('div');
        div.className = 'showcase-item';
        div.onclick = () => useShowcaseItem(item);
        
        let mediaTag = `<img src="${item.url}" alt="${item.title}" loading="lazy">`;
        if (item.type.includes('video')) {
            mediaTag = `<video src="${item.url}" muted loop onmouseover="this.play()" onmouseout="this.pause()"></video>`;
        }
        
        div.innerHTML = `
            <div class="showcase-thumb">${mediaTag}</div>
            <div class="showcase-info">
                <div class="showcase-title">${escapeHtml(item.title || 'Untitled')}</div>
                <div class="showcase-meta">${item.type.toUpperCase()} • ${item.category_name || 'General'}</div>
            </div>
        `;
        grid.appendChild(div);
    });
}

function filterShowcase(type, btn) {
    document.querySelectorAll('.showcase-tabs .tab-btn').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
    loadShowcase(type);
}

function useShowcaseItem(item) {
    closeModal('showcaseModal');
    
    // Populate Chat
    const input = document.getElementById('chatInput');
    input.value = item.prompt;
    autoExpand(input);
    
    // Match Mode
    const modeSelect = document.getElementById('chatMode');
    if (item.type === 'video') {
        modeSelect.value = 'text_to_video';
    } else if (item.type === 'image') {
        modeSelect.value = 'text_to_image';
    }
    onModeChange();
    
    showToast('Item loaded! You can now customize the prompt.', 'success');
}

// ─── Overlays & Init ────────────────────────────────────
document.addEventListener('DOMContentLoaded', () => {
    // Safeguard: Ensure all modals are closed on refresh
    document.querySelectorAll('.modal-overlay').forEach(m => m.classList.remove('show'));

    document.querySelectorAll('.modal-overlay').forEach(overlay => {
        overlay.addEventListener('click', (e) => {
            if (e.target === overlay) closeModal(overlay.id);
        });
    });
});

document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') {
        document.querySelectorAll('.modal-overlay.show').forEach(m => closeModal(m.id));
    }
});
