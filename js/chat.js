/**
 * Grok Imagine Chat — Conversational Logic
 */

// ─── State ──────────────────────────────────────────────
let currentUser = null;
let idToken = null;
let uploadedImageBase64 = null;
let bdtPerCredit = 2;
let adminSettings = null;

// ─── Auth State Listener ────────────────────────────────
auth.onAuthStateChanged(async (user) => {
    if (user) {
        currentUser = user;
        idToken = await user.getIdToken();
        document.getElementById('userProfile').style.display = 'flex';
        document.getElementById('sidebarUserPhoto').src = user.photoURL || '';
        document.getElementById('sidebarUserName').textContent = user.displayName || 'User';
        await loadCredits();
        loadHistory();
    } else {
        currentUser = null;
        idToken = null;
        document.getElementById('userProfile').style.display = 'none';
        openModal('authModal');
    }
});

// ─── Chat Logic ─────────────────────────────────────────
function appendMessage(role, content, media = null, status = 'completed', id = null) {
    const container = document.getElementById('messagesContainer');
    const emptyState = container.querySelector('.empty-state');
    if (emptyState) emptyState.remove();

    const msgDiv = document.createElement('div');
    msgDiv.className = `message msg-${role}`;
    if (id) msgDiv.id = `msg-${id}`;

    const avatar = document.createElement('div');
    avatar.className = 'message-avatar';
    avatar.innerHTML = role === 'ai' ? 'G' : 'U';

    const contentDiv = document.createElement('div');
    contentDiv.className = 'message-content';
    
    let text = content ? `<p>${escapeHtml(content)}</p>` : '';
    let mediaHtml = '';

    if (status === 'processing') {
        mediaHtml = `<div class="ai-media processing"><div class="loading-spinner"></div><p>Generating... please wait.</p></div>`;
    } else if (status === 'failed') {
        mediaHtml = `<div class="ai-media error"><p>Generation failed. Credits have been refunded.</p></div>`;
    } else if (media) {
        if (media.includes('.mp4') || media.includes('video')) {
            mediaHtml = `<div class="ai-media reveal-anim"><video src="${media}" controls loop></video></div>`;
        } else if (media.includes('.mp3') || media.includes('audio')) {
            mediaHtml = `<div class="ai-media reveal-anim"><audio src="${media}" controls></audio></div>`;
        } else {
            mediaHtml = `<div class="ai-media reveal-anim"><img src="${media}" onclick="window.open('${media}', '_blank')"></div>`;
        }
    }

    contentDiv.innerHTML = text + mediaHtml;
    msgDiv.appendChild(avatar);
    msgDiv.appendChild(contentDiv);
    container.appendChild(msgDiv);
    container.scrollTop = container.scrollHeight;
    
    return msgDiv;
}

async function sendChat() {
    if (!currentUser) { openModal('authModal'); return; }
    
    const input = document.getElementById('chatInput');
    const prompt = input.value.trim();
    if (!prompt) return;

    const type = document.getElementById('chatMode').value;
    const model = document.getElementById('chatModel').value;
    const aspect_ratio = document.getElementById('chatAspect').value;

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
        const body = { type, prompt, model, aspect_ratio };
        if (attachment) body.image = attachment;

        const res = await apiCall('/api/generate.php', 'POST', body);

        if (res.error) throw new Error(res.error);

        if (res.request_id) {
            // Video generation - start polling
            startPolling(res.request_id, aiMsgId);
        } else if (res.url) {
            // Immediate (Image/Audio)
            updateMessage(aiMsgId, '', res.url, 'completed');
            loadCredits();
        }
    } catch (err) {
        updateMessage(aiMsgId, 'Error: ' + err.message, null, 'failed');
    }
}

function updateMessage(id, content, media, status) {
    const msgDiv = document.getElementById(`msg-${id}`);
    if (!msgDiv) return;
    
    const contentDiv = msgDiv.querySelector('.message-content');
    let text = content ? `<p>${escapeHtml(content)}</p>` : '';
    let mediaHtml = '';

    if (status === 'processing') {
        mediaHtml = `<div class="ai-media processing"><div class="loading-spinner"></div><p>Generating... please wait.</p></div>`;
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
    }

    contentDiv.innerHTML = text + mediaHtml;
    document.getElementById('messagesContainer').scrollTop = document.getElementById('messagesContainer').scrollHeight;
}

// ─── Polling ─────────────────────────────────────────────
async function startPolling(requestId, msgId) {
    const pollInterval = setInterval(async () => {
        try {
            const res = await apiCall(`/api/poll.php?request_id=${requestId}`, 'GET');
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
    } catch (err) {}
}

async function loadHistory() {
    // Reusing the general history to populate sidebar for now
    try {
        const res = await apiCall('/api/history.php?limit=10', 'GET');
        const list = document.getElementById('chatHistory');
        list.innerHTML = '<div class="history-group">Recent Generations</div>';
        res.generations.forEach(gen => {
            const item = document.createElement('div');
            item.className = 'history-item';
            item.textContent = gen.prompt;
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

// ─── UI Utils ───────────────────────────────────────────
function handleChatFile(e) {
    const file = e.target.files[0];
    if (!file) return;
    const reader = new FileReader();
    reader.onload = (ev) => {
        uploadedImageBase64 = ev.target.result;
        document.getElementById('previewImg').src = uploadedImageBase64;
        document.getElementById('attachmentPreview').style.display = 'block';
        
        // Auto-switch to Image Edit if on T2I
        const mode = document.getElementById('chatMode');
        if (mode.value === 'text_to_image') {
            mode.value = 'image_edit';
            onModeChange();
        }
    };
    reader.readAsDataURL(file);
}

function clearAttachment() {
    uploadedImageBase64 = null;
    document.getElementById('attachmentPreview').style.display = 'none';
    document.getElementById('chatFile').value = '';
}

function onModeChange() {
    const mode = document.getElementById('chatMode').value;
    const ctrlAspect = document.getElementById('ctrl-aspect');
    const ctrlModel = document.getElementById('ctrl-model');
    
    ctrlAspect.style.display = (mode === 'text_to_audio') ? 'none' : 'flex';
    ctrlModel.style.display = (mode === 'text_to_audio') ? 'none' : 'flex';
}

function autoExpand(el) {
    el.style.height = 'auto';
    el.style.height = el.scrollHeight + 'px';
}

function usePrompt(text) {
    document.getElementById('chatInput').value = text;
    sendChat();
}

function toggleSidebar() {
    document.getElementById('sidebar').classList.toggle('active');
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

function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

function openModal(id) {
    // Implement or reuse from app.js
    alert('Please sign in to use Chat');
}
