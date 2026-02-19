:root{
  --bg: #0b1220;
  --panel: #0f1a2f;
  --panel2: #111f39;
  --text: #e9eefc;
  --muted: #b8c2e3;
  --line: rgba(255,255,255,.10);
  --accent: #6ea8fe;
  --danger: #ff6b6b;
  --shadow: 0 10px 30px rgba(0,0,0,.35);
  --radius: 18px;
}

*{ box-sizing:border-box; }
body{
  margin:0;
  font-family: system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif;
  background: radial-gradient(1000px 600px at 20% 0%, rgba(110,168,254,.18), transparent 60%),
              radial-gradient(900px 700px at 90% 20%, rgba(255,107,107,.12), transparent 60%),
              var(--bg);
  color: var(--text);
}

.topbar{
  display:flex;
  align-items:center;
  justify-content:space-between;
  padding: 18px 22px;
  border-bottom: 1px solid var(--line);
  position: sticky;
  top: 0;
  backdrop-filter: blur(10px);
  background: rgba(11,18,32,.7);
  z-index: 5;
}

.brand{ display:flex; align-items:center; gap:12px; }
.logo{
  width: 42px; height: 42px;
  border-radius: 14px;
  display:grid; place-items:center;
  background: linear-gradient(135deg, rgba(110,168,254,.9), rgba(110,168,254,.35));
  box-shadow: var(--shadow);
  font-weight: 800;
}
.title{ font-weight: 800; font-size: 18px; }
.subtitle{ color: var(--muted); font-size: 12px; margin-top: 2px; }

.layout{
  display:grid;
  grid-template-columns: 420px 1fr;
  gap: 16px;
  padding: 16px;
  max-width: 1200px;
  margin: 0 auto;
}

.panel{
  background: linear-gradient(180deg, var(--panel), var(--panel2));
  border: 1px solid var(--line);
  border-radius: var(--radius);
  box-shadow: var(--shadow);
  padding: 16px;
  min-height: calc(100vh - 120px);
}

.panel-header{
  display:flex;
  align-items:center;
  justify-content:space-between;
  gap:12px;
  margin-bottom: 12px;
}

h2{ margin:0; font-size: 18px; }
h3{ margin:0; }

.section-title{
  font-size: 14px;
  letter-spacing: .08em;
  text-transform: uppercase;
  color: var(--muted);
  margin: 0 0 10px;
}

.search-wrap{ flex: 1; display:flex; justify-content:flex-end; }
.input, .textarea{
  width: 100%;
  background: rgba(255,255,255,.06);
  border: 1px solid rgba(255,255,255,.10);
  color: var(--text);
  border-radius: 14px;
  padding: 10px 12px;
  outline: none;
}
.input::placeholder, .textarea::placeholder{ color: rgba(233,238,252,.55); }

.btn{
  border: 1px solid rgba(255,255,255,.14);
  background: rgba(255,255,255,.06);
  color: var(--text);
  padding: 10px 12px;
  border-radius: 14px;
  cursor: pointer;
  font-weight: 700;
}
.btn:hover{ background: rgba(255,255,255,.10); }
.btn.primary{
  background: linear-gradient(135deg, rgba(110,168,254,.95), rgba(110,168,254,.45));
  border-color: rgba(110,168,254,.6);
}
.btn.primary:hover{ filter: brightness(1.05); }
.btn.danger{
  background: linear-gradient(135deg, rgba(255,107,107,.95), rgba(255,107,107,.35));
  border-color: rgba(255,107,107,.6);
}
.btn.danger:hover{ filter: brightness(1.05); }

.state{
  color: var(--muted);
  padding: 12px 6px;
}

.set-list{
  display:flex;
  flex-direction: column;
  gap: 10px;
}

.set-card{
  border: 1px solid rgba(255,255,255,.10);
  background: rgba(255,255,255,.05);
  border-radius: 16px;
  padding: 12px;
  cursor: pointer;
  display:flex;
  justify-content:space-between;
  gap: 12px;
}
.set-card:hover{ background: rgba(255,255,255,.08); }
.set-card.active{
  border-color: rgba(110,168,254,.55);
  box-shadow: 0 0 0 3px rgba(110,168,254,.15);
}
.set-title{ font-weight: 800; margin:0; }
.set-sub{ color: var(--muted); font-size: 12px; margin-top: 4px; }
.pill{
  font-size: 12px;
  padding: 6px 10px;
  border-radius: 999px;
  border: 1px solid rgba(255,255,255,.14);
  color: var(--muted);
  height: fit-content;
}

.divider{
  height: 1px;
  background: var(--line);
  margin: 14px 0;
}

.hidden{ display:none !important; }

.empty-wrap{
  display:grid;
  place-items: center;
  text-align:center;
  height: calc(100vh - 170px);
  color: var(--muted);
  padding: 10px;
}
.empty-wrap h2{ color: var(--text); }

.view-header{
  display:flex;
  justify-content:space-between;
  align-items:flex-start;
  gap: 12px;
}

.meta{
  color: var(--muted);
  display:flex;
  align-items:center;
  gap: 8px;
  margin-top: 6px;
  font-size: 12px;
}
.dot{ opacity: .6; }

.view-actions{ display:flex; gap: 10px; }

.card-list{
  display:grid;
  grid-template-columns: 1fr;
  gap: 10px;
}
.term-card{
  border: 1px solid rgba(255,255,255,.10);
  background: rgba(255,255,255,.05);
  border-radius: 16px;
  padding: 12px;
}
.term{ font-weight: 800; }
.def{ color: var(--muted); margin-top: 6px; }

.create-header{
  display:flex;
  align-items:center;
  justify-content:space-between;
}

.form-grid{
  display:grid;
  grid-template-columns: 1fr 180px;
  gap: 12px;
  margin-top: 10px;
}

.field{ display:flex; flex-direction:column; gap: 6px; margin-top: 10px; }
.field span{ color: var(--muted); font-size: 12px; }

.cards-builder-header{
  display:flex;
  align-items:center;
  justify-content:space-between;
  margin-bottom: 10px;
}

.builder-rows{
  display:flex;
  flex-direction:column;
  gap: 10px;
}

.builder-row{
  display:grid;
  grid-template-columns: 1fr 1fr 80px;
  gap: 10px;
  align-items:start;
  border: 1px solid rgba(255,255,255,.10);
  background: rgba(255,255,255,.05);
  padding: 10px;
  border-radius: 16px;
}
.builder-row .input{ padding: 10px 10px; }
.builder-row .btn{ padding: 10px 10px; }

.builder-footer{
  display:flex;
  align-items:center;
  gap: 12px;
  margin-top: 14px;
}
.msg{ color: var(--muted); font-size: 12px; }

.study-wrap{ margin-top: 14px; }
.study-top{
  display:flex;
  align-items:center;
  justify-content:space-between;
  gap: 12px;
  margin-bottom: 10px;
}
.study-controls{ display:flex; gap: 10px; }

.flashcard{
  width: 100%;
  height: 260px;
  perspective: 1000px;
  border-radius: 22px;
  outline: none;
}
.flashcard-inner{
  width: 100%;
  height: 100%;
  position: relative;
  transform-style: preserve-3d;
  transition: transform .35s ease;
}
.flashcard.flipped .flashcard-inner{
  transform: rotateY(180deg);
}

.flashcard-face{
  position:absolute;
  inset:0;
  backface-visibility: hidden;
  border-radius: 22px;
  border: 1px solid rgba(255,255,255,.10);
  background: rgba(255,255,255,.06);
  display:flex;
  flex-direction:column;
  padding: 18px;
  justify-content:center;
  gap: 10px;
}
.flashcard-back{ transform: rotateY(180deg); }

.label{
  font-size: 12px;
  color: var(--muted);
  letter-spacing:.12em;
  text-transform: uppercase;
}
.fc-text{
  font-size: 22px;
  font-weight: 800;
  line-height: 1.2;
}

.study-footer{
  display:flex;
  justify-content:space-between;
  margin-top: 10px;
  color: var(--muted);
  font-size: 12px;
}
.hint{ opacity: .85; }

@media (max-width: 980px){
  .layout{ grid-template-columns: 1fr; }
  .panel{ min-height: auto; }
  .form-grid{ grid-template-columns: 1fr; }
  .builder-row{ grid-template-columns: 1fr; }
}
