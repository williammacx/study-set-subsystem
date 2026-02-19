// studysets/studysets.js
const API = "http://localhost:5000"; // change to http://localhost:5000/api if needed

const listEl = document.querySelector(".studyset-list");
const userSelect = document.getElementById("userSelect");

const titleInput = document.getElementById("titleInput");
const descInput = document.getElementById("descInput");
const visSelect = document.getElementById("visSelect");
const createBtn = document.getElementById("createBtn");

const createMsg = document.getElementById("createMsg");
const listMsg = document.getElementById("listMsg");

// ---------- HELPERS ----------
function escapeHtml(str) {
  return String(str ?? "").replace(/[&<>"']/g, (m) => ({
    "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;",
  }[m]));
}

function setText(el, text) {
  if (!el) return;
  el.textContent = text || "";
}

function setId(s) {
  return s.study_set_id ?? s.id ?? s.studySetId ?? s.studySetID;
}

// ---------- API ----------
async function fetchJSON(url, options) {
  const res = await fetch(url, {
    headers: { "Content-Type": "application/json" },
    ...options,
  });
  if (!res.ok) throw new Error(await res.text());
  return res.json();
}

async function listSets(userId) {
  return fetchJSON(`${API}/study-sets?createdBy=${encodeURIComponent(userId)}`);
}

async function createSet(payload) {
  return fetchJSON(`${API}/study-sets`, {
    method: "POST",
    body: JSON.stringify(payload),
  });
}

// ---------- TEMPLATE ----------
function setCardTemplate(s) {
  const id = setId(s);
  const vis = s.visibility || "private";
  const desc = s.description || "";

  return `
    <div class="studyset-card" data-id="${id}">
      <div class="studyset-left">
        <div class="studyset-top">
          <span class="badge">${escapeHtml(vis)}</span>
          <span class="badge">ID ${escapeHtml(id)}</span>
        </div>
        <p class="studyset-title">${escapeHtml(s.title || "Untitled")}</p>
        <p class="studyset-meta">${escapeHtml(desc)}</p>
      </div>

      <div class="studyset-right">
        <a class="open-link" href="./study.html?id=${encodeURIComponent(id)}">Study</a>
      </div>
    </div>
  `;
}

// ---------- RENDER ----------
async function render() {
  const userId = Number(userSelect.value);

  setText(listMsg, "Loading…");
  listEl.innerHTML = "";

  try {
    const sets = await listSets(userId);

    if (!sets || sets.length === 0) {
      listEl.innerHTML = `<p class="helper-text">No study sets yet.</p>`;
      setText(listMsg, "");
      return;
    }

    listEl.innerHTML = sets.map(setCardTemplate).join("");
    setText(listMsg, "");
  } catch (e) {
    setText(listMsg, e.message || "Failed to load sets.");
  }
}

// ---------- EVENTS ----------
userSelect.addEventListener("change", render);

createBtn.addEventListener("click", async () => {
  const userId = Number(userSelect.value);
  const title = titleInput.value.trim();
  const description = descInput.value.trim();
  const visibility = visSelect.value;

  if (!title) {
    setText(createMsg, "Title is required.");
    return;
  }

  setText(createMsg, "Creating…");

  try {
    await createSet({
      title,
      description,
      visibility,
      created_by: userId, // matches your DB column name
    });

    titleInput.value = "";
    descInput.value = "";
    visSelect.value = "private";
    setText(createMsg, "Created!");

    await render();
  } catch (e) {
    setText(createMsg, e.message || "Create failed.");
  }
});

// ---------- INIT ----------
render();
