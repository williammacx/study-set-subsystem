// studysets/study.js
const API = "http://localhost:5000"; // change to http://localhost:5000/api if needed

const qs = new URLSearchParams(location.search);
const setId = qs.get("id");

const setTitle = document.getElementById("setTitle");
const setMeta = document.getElementById("setMeta");

const flashcard = document.getElementById("flashcard");
const inner = document.getElementById("inner");
const frontText = document.getElementById("frontText");
const backText = document.getElementById("backText");

const prevBtn = document.getElementById("prevBtn");
const nextBtn = document.getElementById("nextBtn");
const counter = document.getElementById("counter");

let cards = [];
let i = 0;

// ---------- HELPERS ----------
function setText(el, text) {
  if (!el) return;
  el.textContent = text || "";
}

function flip() {
  inner.classList.toggle("flipped");
}

function normalizeCard(c) {
  // Supports either DB-ish names OR generic names
  return {
    front: c.front_text ?? c.term ?? "",
    back: c.back_text ?? c.definition ?? "",
    order: c.order_index ?? c.position ?? 0,
  };
}

function renderCard() {
  if (!cards.length) {
    setText(frontText, "No cards yet");
    setText(backText, "This set has no flashcards.");
    setText(counter, "0 / 0");
    inner.classList.remove("flipped");
    return;
  }

  const c = normalizeCard(cards[i]);
  setText(frontText, c.front);
  setText(backText, c.back);
  setText(counter, `${i + 1} / ${cards.length}`);
  inner.classList.remove("flipped");
}

function next() {
  if (!cards.length) return;
  i = (i + 1) % cards.length;
  renderCard();
}

function prev() {
  if (!cards.length) return;
  i = (i - 1 + cards.length) % cards.length;
  renderCard();
}

// ---------- API ----------
async function fetchJSON(url) {
  const res = await fetch(url);
  if (!res.ok) throw new Error(await res.text());
  return res.json();
}

async function load() {
  if (!setId) {
    setText(setTitle, "Missing set id");
    return;
  }

  // set details
  const set = await fetchJSON(`${API}/study-sets/${encodeURIComponent(setId)}`);
  setText(setTitle, set.title || "Study Set");
  setText(setMeta, `Visibility: ${set.visibility || "private"} • Set ID: ${setId}`);

  // items
  cards = await fetchJSON(`${API}/study-sets/${encodeURIComponent(setId)}/items`);
  cards.sort((a, b) => (normalizeCard(a).order) - (normalizeCard(b).order));
  renderCard();
}

// ---------- EVENTS ----------
flashcard.addEventListener("click", flip);
flashcard.addEventListener("keydown", (e) => {
  if (e.code === "Space") { e.preventDefault(); flip(); }
  if (e.code === "ArrowRight") next();
  if (e.code === "ArrowLeft") prev();
});

nextBtn.addEventListener("click", next);
prevBtn.addEventListener("click", prev);

// ---------- INIT ----------
load().catch((e) => {
  setText(setTitle, "Error loading set");
  setText(setMeta, e.message || "Unknown error");
});
