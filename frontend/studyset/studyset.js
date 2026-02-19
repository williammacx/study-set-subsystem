const API = "http://localhost:5000";

const listEl = document.querySelector(".studyset-list");
const userSelect = document.getElementById("userSelect");

const titleInput = document.getElementById("titleInput");
const descInput = document.getElementById("descInput");
const visSelect = document.getElementById("visSelect");
const createBtn = document.getElementById("createBtn");
const createMsg = document.getElementById("createMsg");

// ---------- helpers ----------
function setText(el, text) {
  if (el) el.textContent = text || "";
}

function getId(s) {
  return s.study_set_id ?? s.id;
}

function escapeHtml(str) {
  return String(str ?? "").replace(/[&<>"']/g, m =>
    ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[m])
  );
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

async function loadSets() {
  const userId = userSelect.value;

  listEl.innerHTML = "Loading...";

  try {
    const sets = await fetchJSON(`${API}/study-sets?createdBy=${userId}`);

    if (!sets.length) {
      listEl.innerHTML = `<p class="helper-text">No study sets yet.</p>`;
      return;
    }

    listEl.innerHTML = sets.map(s => {
      const id = getId(s);

      return `
        <div class="studyset-card">
          <div>
            <p class="studyset-title">${escapeHtml(s.title)}</p>
            <p class="studyset-meta">${escapeHtml(s.description || "")}</p>
          </div>

          <a class="open-link" href="./flashcard.html?id=${id}">
            Study
          </a>
        </div>
      `;
    }).join("");

  } catch (err) {
    listEl.innerHTML = err.message;
  }
}

async function createSet() {
  const userId = userSelect.value;

  const title = titleInput.value.trim();
  if (!title) {
    setText(createMsg, "Title required");
    return;
  }

  setText(createMsg, "Creating...");

  try {
    await fetchJSON(`${API}/study-sets`, {
      method: "POST",
      body: JSON.stringify({
        title,
        description: descInput.value,
        visibility: visSelect.value,
        created_by: userId
      })
    });

    titleInput.value = "";
    descInput.value = "";
    visSelect.value = "private";

    setText(createMsg, "Created!");
    loadSets();

  } catch (err) {
    setText(createMsg, err.message);
  }
}

// ---------- events ----------
userSelect.addEventListener("change", loadSets);
createBtn.addEventListener("click", createSet);

// ---------- init ----------
loadSets();
