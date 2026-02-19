// frontend/studyset/studysets.js
// Implements: Create Study Set, View Study Set, Delete Study Set (+ simple flashcard study mode)
//
// IMPORTANT: This file does NOT modify any other part of your project.
// You can link to this page directly: /frontend/studyset/index.html
//
// Update API_BASE and endpoints to match your teammate's backend.

const API_BASE = "http://localhost:5000"; // change if needed
const CURRENT_USER_ID = 1; // replace with real logged-in user id when available

// Expected minimal endpoints (adjust as needed):
// GET    /api/studysets?user_id=1               -> [{ id, title, description, visibility, card_count }]
// GET    /api/studysets/:id?user_id=1           -> { id, title, description, visibility, cards:[{id,term,definition}] }
// POST   /api/studysets                         -> { id, ... }
// DELETE /api/studysets/:id?user_id=1           -> { ok:true }

const els = {
  btnNew: document.getElementById("btnNew"),
  btnNew2: document.getElementById("btnNew2"),
  searchInput: document.getElementById("searchInput"),

  listState: document.getElementById("listState"),
  setList: document.getElementById("setList"),

  emptyWrap: document.getElementById("emptyWrap"),
  viewWrap: document.getElementById("viewWrap"),
  createWrap: document.getElementById("createWrap"),

  viewTitle: document.getElementById("viewTitle"),
  viewCount: document.getElementById("viewCount"),
  viewVisibility: document.getElementById("viewVisibility"),
  cardList: document.getElementById("cardList"),

  btnStudy: document.getElementById("btnStudy"),
  btnDelete: document.getElementById("btnDelete"),

  studyWrap: document.getElementById("studyWrap"),
  btnPrev: document.getElementById("btnPrev"),
  btnFlip: document.getElementById("btnFlip"),
  btnNext: document.getElementById("btnNext"),
  flashcard: document.getElementById("flashcard"),
  fcFront: document.getElementById("fcFront"),
  fcBack: document.getElementById("fcBack"),
  studyCounter: document.getElementById("studyCounter"),

  btnCancelCreate: document.getElementById("btnCancelCreate"),
  createTitle: document.getElementById("createTitle"),
  createVisibility: document.getElementById("createVisibility"),
  createDesc: document.getElementById("createDesc"),
  btnAddCardRow: document.getElementById("btnAddCardRow"),
  builderRows: document.getElementById("builderRows"),
  btnCreateSubmit: document.getElementById("btnCreateSubmit"),
  createMsg: document.getElementById("createMsg"),
};

let state = {
  sets: [],
  filteredSets: [],
  activeSetId: null,
  activeSet: null,
  studyIndex: 0,
};

async function fetchJSON(url, options = {}) {
  const res = await fetch(url, {
    headers: { "Content-Type": "application/json" },
    ...options,
  });
  if (!res.ok) {
    const text = await res.text().catch(() => "");
    throw new Error(text || `Request failed: ${res.status}`);
  }
  if (res.status === 204) return null;
  return res.json();
}

function show(el) { el.classList.remove("hidden"); }
function hide(el) { el.classList.add("hidden"); }

function setViewMode(mode) {
  // mode: "empty" | "view" | "create"
  if (mode === "empty") {
    show(els.emptyWrap); hide(els.viewWrap); hide(els.createWrap);
  } else if (mode === "view") {
    hide(els.emptyWrap); show(els.viewWrap); hide(els.createWrap);
  } else if (mode === "create") {
    hide(els.emptyWrap); hide(els.viewWrap); show(els.createWrap);
  }
}

function escapeHtml(s) {
  return String(s ?? "")
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#039;");
}

function applySearchFilter() {
  const q = els.searchInput.value.trim().toLowerCase();
  state.filteredSets = !q
    ? [...state.sets]
    : state.sets.filter(s => (s.title ?? "").toLowerCase().includes(q));
  renderSetList();
}

function renderSetList() {
  els.setList.innerHTML = "";

  if (!state.filteredSets.length) {
    els.listState.textContent = "No study sets found.";
    show(els.listState);
    return;
  }
  hide(els.listState);

  for (const set of state.filteredSets) {
    const div = document.createElement("div");
    div.className = "set-card" + (set.id === state.activeSetId ? " active" : "");
    div.dataset.id = set.id;

    div.innerHTML = `
      <div>
        <div class="set-title">${escapeHtml(set.title)}</div>
        <div class="set-sub">${escapeHtml(set.card_count ?? 0)} cards • ${escapeHtml(set.visibility ?? "private")}</div>
      </div>
      <div class="pill">View</div>
    `;

    div.addEventListener("click", () => openSet(set.id));
    els.setList.appendChild(div);
  }
}

function renderActiveSet() {
  const s = state.activeSet;
  if (!s) return setViewMode("empty");

  els.viewTitle.textContent = s.title ?? "Untitled";
  els.viewCount.textContent = `${(s.cards?.length ?? 0)} cards`;
  els.viewVisibility.textContent = s.visibility ?? "private";

  els.cardList.innerHTML = "";
  for (const c of (s.cards ?? [])) {
    const card = document.createElement("div");
    card.className = "term-card";
    card.innerHTML = `
      <div class="term">${escapeHtml(c.term)}</div>
      <div class="def">${escapeHtml(c.definition)}</div>
    `;
    els.cardList.appendChild(card);
  }

  hide(els.studyWrap);
  state.studyIndex = 0;
  els.flashcard.classList.remove("flipped");

  setViewMode("view");
}

async function loadSets() {
  show(els.listState);
  els.listState.textContent = "Loading…";
  try {
    const data = await fetchJSON(`${API_BASE}/api/studysets?user_id=${CURRENT_USER_ID}`);
    state.sets = Array.isArray(data) ? data : [];
    state.filteredSets = [...state.sets];
    renderSetList();
    if (!state.activeSetId) setViewMode("empty");
  } catch (err) {
    els.listState.textContent = `Failed to load sets: ${err.message}`;
  }
}

async function openSet(id) {
  state.activeSetId = id;
  try {
    const set = await fetchJSON(`${API_BASE}/api/studysets/${id}?user_id=${CURRENT_USER_ID}`);
    state.activeSet = set;
    renderSetList();
    renderActiveSet();
  } catch (err) {
    alert(`Could not open set: ${err.message}`);
  }
}

async function deleteActiveSet() {
  if (!state.activeSetId) return;

  const ok = confirm("Delete this study set? This cannot be undone.");
  if (!ok) return;

  try {
    await fetchJSON(`${API_BASE}/api/studysets/${state.activeSetId}?user_id=${CURRENT_USER_ID}`, {
      method: "DELETE",
    });
    // refresh list
    state.activeSetId = null;
    state.activeSet = null;
    setViewMode("empty");
    await loadSets();
  } catch (err) {
    alert(`Delete failed: ${err.message}`);
  }
}

// ---------- create flow ----------
function clearCreateForm() {
  els.createTitle.value = "";
  els.createVisibility.value = "private";
  els.createDesc.value = "";
  els.builderRows.innerHTML = "";
  els.createMsg.textContent = "";
}

function addBuilderRow(term = "", definition = "") {
  const row = document.createElement("div");
  row.className = "builder-row";
  row.innerHTML = `
    <input class="input termInput" placeholder="Term" value="${escapeHtml(term)}" />
    <input class="input defInput" placeholder="Definition" value="${escapeHtml(definition)}" />
    <button class="btn danger btnRemove" type="button">X</button>
  `;
  row.querySelector(".btnRemove").addEventListener("click", () => row.remove());
  els.builderRows.appendChild(row);
}

function getBuilderCards() {
  const rows = [...els.builderRows.querySelectorAll(".builder-row")];
  const cards = rows.map(r => {
    const term = r.querySelector(".termInput").value.trim();
    const definition = r.querySelector(".defInput").value.trim();
    return { term, definition };
  }).filter(c => c.term && c.definition);
  return cards;
}

async function submitCreate() {
  els.createMsg.textContent = "";
  const title = els.createTitle.value.trim();
  const visibility = els.createVisibility.value;
  const description = els.createDesc.value.trim();
  const cards = getBuilderCards();

  if (!title) {
    els.createMsg.textContent = "Title is required.";
    return;
  }
  if (cards.length === 0) {
    els.createMsg.textContent = "Add at least 1 card (term + definition).";
    return;
  }

  try {
    els.btnCreateSubmit.disabled = true;
    await fetchJSON(`${API_BASE}/api/studysets`, {
      method: "POST",
      body: JSON.stringify({
        user_id: CURRENT_USER_ID,
        title,
        description,
        visibility,
        cards,
      }),
    });

    clearCreateForm();
    setViewMode("empty");
    await loadSets();
    els.createMsg.textContent = "Created!";
  } catch (err) {
    els.createMsg.textContent = `Create failed: ${err.message}`;
  } finally {
    els.btnCreateSubmit.disabled = false;
  }
}

// ---------- study mode ----------
function ensureStudyOpen() {
  const cards = state.activeSet?.cards ?? [];
  if (!cards.length) return;

  show(els.studyWrap);
  state.studyIndex = Math.max(0, Math.min(state.studyIndex, cards.length - 1));
  renderFlashcard();
}

function renderFlashcard() {
  const cards = state.activeSet?.cards ?? [];
  if (!cards.length) return;

  const c = cards[state.studyIndex];
  els.fcFront.textContent = c.term ?? "—";
  els.fcBack.textContent = c.definition ?? "—";
  els.studyCounter.textContent = `${state.studyIndex + 1} / ${cards.length}`;
  els.flashcard.classList.remove("flipped");
}

function flipFlashcard() {
  els.flashcard.classList.toggle("flipped");
}

function prevCard() {
  const cards = state.activeSet?.cards ?? [];
  if (!cards.length) return;
  state.studyIndex = (state.studyIndex - 1 + cards.length) % cards.length;
  renderFlashcard();
}

function nextCard() {
  const cards = state.activeSet?.cards ?? [];
  if (!cards.length) return;
  state.studyIndex = (state.studyIndex + 1) % cards.length;
  renderFlashcard();
}

// ---------- events ----------
els.btnNew.addEventListener("click", () => {
  clearCreateForm();
  addBuilderRow();
  addBuilderRow();
  setViewMode("create");
});
els.btnNew2.addEventListener("click", () => els.btnNew.click());
els.btnCancelCreate.addEventListener("click", () => {
  clearCreateForm();
  setViewMode(state.activeSet ? "view" : "empty");
});

els.btnAddCardRow.addEventListener("click", () => addBuilderRow());
els.btnCreateSubmit.addEventListener("click", submitCreate);

els.searchInput.addEventListener("input", applySearchFilter);

els.btnDelete.addEventListener("click", deleteActiveSet);

els.btnStudy.addEventListener("click", ensureStudyOpen);
els.btnPrev.addEventListener("click", prevCard);
els.btnNext.addEventListener("click", nextCard);
els.btnFlip.addEventListener("click", flipFlashcard);

els.flashcard.addEventListener("click", flipFlashcard);
els.flashcard.addEventListener("keydown", (e) => {
  if (e.code === "Space") {
    e.preventDefault();
    flipFlashcard();
  }
});

// ---------- init ----------
setViewMode("empty");
loadSets();
