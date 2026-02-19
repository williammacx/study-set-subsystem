const API = "http://localhost:5000";

const qs = new URLSearchParams(location.search);
const setId = qs.get("id");

const frontText = document.getElementById("frontText");
const backText = document.getElementById("backText");
const counter = document.getElementById("counter");

const inner = document.getElementById("inner");
const prevBtn = document.getElementById("prevBtn");
const nextBtn = document.getElementById("nextBtn");

let cards = [];
let i = 0;

function render() {
  if (!cards.length) {
    frontText.textContent = "No cards";
    backText.textContent = "";
    counter.textContent = "0 / 0";
    return;
  }

  const c = cards[i];

  frontText.textContent = c.front_text;
  backText.textContent = c.back_text;
  counter.textContent = `${i + 1} / ${cards.length}`;

  inner.classList.remove("flipped");
}

function next() {
  i = (i + 1) % cards.length;
  render();
}

function prev() {
  i = (i - 1 + cards.length) % cards.length;
  render();
}

function flip() {
  inner.classList.toggle("flipped");
}

async function loadCards() {
  const res = await fetch(`${API}/study-sets/${setId}/items`);
  cards = await res.json();

  render();
}

// events
inner.addEventListener("click", flip);
prevBtn.addEventListener("click", prev);
nextBtn.addEventListener("click", next);

loadCards();
