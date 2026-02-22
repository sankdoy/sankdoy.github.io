// The Synth Moment - UI Controller

const synth = new SynthEngine();

// ============ Utils ============
const clamp = (v, a, b) => Math.max(a, Math.min(b, v));

function fmtDb(db) {
  const d = Number(db);
  if (!Number.isFinite(d)) return '— dB';
  return `${d.toFixed(1)} dB`;
}

function fmtFreq(hz) {
  const f = Number(hz);
  if (!Number.isFinite(f)) return '— Hz';
  if (f >= 1000) return `${(f / 1000).toFixed(1)} kHz`;
  if (f >= 100) return `${Math.round(f)} Hz`;
  if (f >= 10) return `${f.toFixed(1)} Hz`;
  return `${f.toFixed(2)} Hz`;
}

function fmtCents(c) {
  const v = Number(c);
  if (!Number.isFinite(v)) return '— cent';
  return `${Math.round(v)} cent`;
}

function evalWave(type, t) {
  t = ((t % 1) + 1) % 1;
  switch (type) {
    case 'sine': return Math.sin(t * Math.PI * 2);
    case 'triangle': return 1 - 4 * Math.abs(t - 0.5);
    case 'sawtooth': return 2 * t - 1;
    case 'square': return t < 0.5 ? 1 : -1;
    default: return Math.sin(t * Math.PI * 2);
  }
}

function divisionToBeats(div) {
  // div: "4/1", "2/1", "1/1", "1/2", "1/4", ...
  const m = String(div).match(/^(\d+)\s*\/\s*(\d+)$/);
  if (!m) return 4;
  const num = Number(m[1]);
  const den = Number(m[2]);
  if (!Number.isFinite(num) || !Number.isFinite(den) || den === 0) return 4;
  return (4 * num) / den; // beats per cycle (quarter-note BPM)
}

function logspace(min, max, n) {
  const out = new Float32Array(n);
  const a = Math.max(1e-6, min);
  const b = Math.max(a * 1.000001, max);
  const lnA = Math.log(a);
  const lnB = Math.log(b);
  for (let i = 0; i < n; i++) {
    const t = i / (n - 1);
    out[i] = Math.exp(lnA + (lnB - lnA) * t);
  }
  return out;
}

function randRange(min, max) {
  return min + Math.random() * (max - min);
}

function randInt(min, max) {
  const a = Math.ceil(min);
  const b = Math.floor(max);
  return Math.floor(randRange(a, b + 1));
}

function randLog(min, max) {
  const a = Math.log(Math.max(1e-6, min));
  const b = Math.log(Math.max(Math.exp(a) * 1.000001, max));
  return Math.exp(a + (b - a) * Math.random());
}

function pick(arr) {
  return arr[Math.floor(Math.random() * arr.length)];
}

// ============ Knob Component ============
function initKnob(knobEl, { format, onChange }) {
  const min = Number(knobEl.dataset.min);
  const max = Number(knobEl.dataset.max);
  const step = Number(knobEl.dataset.step || 0);
  const scale = (knobEl.dataset.scale || 'linear').toLowerCase();
  const indicator = knobEl.querySelector('.knob-indicator');
  const valueEl = knobEl.querySelector('.knob-value');
  // Capture default value BEFORE setValue() overwrites dataset.value
  const defaultValue = Number(knobEl.dataset.value ?? min);

  const toNorm = (value) => {
    const v = clamp(Number(value), min, max);
    if (scale === 'log') {
      const a = Math.max(1e-6, min);
      const b = Math.max(a * 1.000001, max);
      return clamp(Math.log(v / a) / Math.log(b / a), 0, 1);
    }
    return clamp((v - min) / (max - min), 0, 1);
  };

  const fromNorm = (norm) => {
    const n = clamp(Number(norm), 0, 1);
    let v;
    if (scale === 'log') {
      const a = Math.max(1e-6, min);
      const b = Math.max(a * 1.000001, max);
      v = a * Math.pow(b / a, n);
    } else {
      v = min + n * (max - min);
    }
    if (step > 0) v = Math.round(v / step) * step;
    return clamp(v, min, max);
  };

  const setValue = (value, { emit = true } = {}) => {
    const v = clamp(Number(value), min, max);
    knobEl.dataset.value = String(v);
    const norm = toNorm(v);
    const deg = -135 + norm * 270;
    if (indicator) indicator.style.setProperty('--angle', `${deg}deg`);
    if (valueEl) valueEl.textContent = format ? format(v) : String(v);
    if (emit && onChange) onChange(v);
  };

  // Init from dataset
  setValue(Number(knobEl.dataset.value ?? min), { emit: false });

  let dragging = false;
  let startY = 0;
  let startNorm = 0;

  knobEl.addEventListener('pointerdown', (e) => {
    dragging = true;
    startY = e.clientY;
    startNorm = toNorm(Number(knobEl.dataset.value ?? min));
    try { knobEl.setPointerCapture(e.pointerId); } catch (_) {}
    e.preventDefault();
  });

  knobEl.addEventListener('pointermove', (e) => {
    if (!dragging) return;
    const dy = startY - e.clientY;
    const sensitivity = e.shiftKey ? 800 : 220;
    const nextNorm = startNorm + dy / sensitivity;
    setValue(fromNorm(nextNorm));
    e.preventDefault();
  });

  const endDrag = (e) => {
    if (!dragging) return;
    dragging = false;
    try { knobEl.releasePointerCapture(e.pointerId); } catch (_) {}
  };
  knobEl.addEventListener('pointerup', endDrag);
  knobEl.addEventListener('pointercancel', endDrag);
  knobEl.addEventListener('pointerleave', (e) => { if (dragging) endDrag(e); });

  // Double-click resets to the original default value
  knobEl.addEventListener('dblclick', (e) => {
    e.preventDefault();
    setValue(defaultValue);
  });

  return { setValue, getValue: () => Number(knobEl.dataset.value ?? min) };
}

// ============ Envelope Editor ============
class EnvelopeEditor {
  constructor(canvas, adsr, onChange) {
    this.canvas = canvas;
    this.ctx = canvas.getContext('2d');
    this.adsr = {
      attackMs: 40,
      decayMs: 180,
      sustain: 0.62,
      releaseMs: 420,
      holdMs: 240,
      ...(adsr || {}),
    };
    this.onChange = onChange || (() => {});
    this.dragKey = null;
    this.pad = 10;
    this.r = 6;
    this._resizeCanvas();
    this._bind();
    this.draw();

    this._onResize = () => {
      this._resizeCanvas();
      this.draw();
    };
    window.addEventListener('resize', this._onResize);
    if (typeof ResizeObserver === 'function') {
      this._ro = new ResizeObserver(this._onResize);
      this._ro.observe(this.canvas);
    }
  }

  getADSR() {
    return { ...this.adsr };
  }

  setADSR(next, { emit = true } = {}) {
    if (!next) return;
    const prev = this.adsr;
    const attackMs = clamp(Number(next.attackMs ?? prev.attackMs) || 0, 0, 5000);
    const decayMs = clamp(Number(next.decayMs ?? prev.decayMs) || 0, 0, 8000);
    const sustain = clamp(Number(next.sustain ?? prev.sustain) || 0, 0, 1);
    const releaseMs = clamp(Number(next.releaseMs ?? prev.releaseMs) || 0, 5, 6000);
    const holdMs = clamp(Number(next.holdMs ?? prev.holdMs) || 0, 0, 5000);
    this.adsr = { attackMs, decayMs, sustain, releaseMs, holdMs };
    this.draw();
    if (emit) this.onChange(this.getADSR());
  }

  _resizeCanvas() {
    const rect = this.canvas.getBoundingClientRect();
    if (!rect.width || !rect.height) return;
    const dpr = Math.max(1, window.devicePixelRatio || 1);
    const w = Math.max(1, Math.round(rect.width * dpr));
    const h = Math.max(1, Math.round(rect.height * dpr));
    if (this.canvas.width !== w) this.canvas.width = w;
    if (this.canvas.height !== h) this.canvas.height = h;
    this.pad = 10 * dpr;
    this.r = 6 * dpr;
  }

  _cssToCanvas(e) {
    const rect = this.canvas.getBoundingClientRect();
    return {
      cx: (e.clientX - rect.left) * (this.canvas.width / rect.width),
      cy: (e.clientY - rect.top) * (this.canvas.height / rect.height),
    };
  }

  _totalMs() {
    const a = Number(this.adsr.attackMs) || 0;
    const d = Number(this.adsr.decayMs) || 0;
    const h = Number(this.adsr.holdMs) || 0;
    const r = Number(this.adsr.releaseMs) || 0;
    return Math.max(1, a + d + h + r);
  }

  _tToCanvas(tMs, level) {
    const w = this.canvas.width;
    const h = this.canvas.height;
    const total = this._totalMs();
    const x = this.pad + (clamp(Number(tMs) || 0, 0, total) / total) * (w - this.pad * 2);
    const y = this.pad + (1 - clamp(Number(level) || 0, 0, 1)) * (h - this.pad * 2);
    return { x, y };
  }

  _canvasToTL(cx, cy) {
    const w = this.canvas.width;
    const h = this.canvas.height;
    const total = this._totalMs();
    const t = clamp((cx - this.pad) / (w - this.pad * 2), 0, 1) * total;
    const level = clamp(1 - (cy - this.pad) / (h - this.pad * 2), 0, 1);
    return { t, level };
  }

  _handles() {
    const a = Number(this.adsr.attackMs) || 0;
    const d = Number(this.adsr.decayMs) || 0;
    const h = Number(this.adsr.holdMs) || 0;
    const r = Number(this.adsr.releaseMs) || 0;
    const s = clamp(Number(this.adsr.sustain) || 0, 0, 1);
    return [
      { key: 'A', t: a, level: 1 },
      { key: 'D', t: a + d, level: s },
      { key: 'S', t: a + d + h, level: s },
      { key: 'R', t: a + d + h + r, level: 0 },
    ];
  }

  _hitTest(cx, cy) {
    const handles = this._handles();
    for (let i = 0; i < handles.length; i++) {
      const hp = this._tToCanvas(handles[i].t, handles[i].level);
      const dx = cx - hp.x;
      const dy = cy - hp.y;
      if (dx * dx + dy * dy <= (this.r + 6) ** 2) return handles[i].key;
    }
    return null;
  }

  _bind() {
    this.canvas.addEventListener('pointerdown', (e) => {
      const { cx, cy } = this._cssToCanvas(e);
      const key = this._hitTest(cx, cy);
      if (!key) return;
      this.dragKey = key;
      try { this.canvas.setPointerCapture(e.pointerId); } catch (_) {}
      e.preventDefault();
    });

    this.canvas.addEventListener('pointermove', (e) => {
      if (!this.dragKey) return;
      const { cx, cy } = this._cssToCanvas(e);
      const { t, level } = this._canvasToTL(cx, cy);

      const key = this.dragKey;
      const prev = this.adsr;
      const a = Number(prev.attackMs) || 0;
      const d = Number(prev.decayMs) || 0;
      const h = Number(prev.holdMs) || 0;
      const s = clamp(Number(prev.sustain) || 0, 0, 1);

      if (key === 'A') {
        const nextA = clamp(t, 0, 5000);
        this.setADSR({ ...prev, attackMs: nextA }, { emit: false });
      } else if (key === 'D') {
        const end = Math.max(a, t);
        const nextD = clamp(end - a, 0, 8000);
        this.setADSR({ ...prev, decayMs: nextD }, { emit: false });
      } else if (key === 'S') {
        this.setADSR({ ...prev, sustain: clamp(level, 0, 1) }, { emit: false });
      } else if (key === 'R') {
        const start = a + d + h;
        const end = Math.max(start + 5, t);
        const nextR = clamp(end - start, 5, 6000);
        this.setADSR({ ...prev, releaseMs: nextR, sustain: s }, { emit: false });
      }
      this.draw();
      e.preventDefault();
    });

    const end = (e) => {
      if (!this.dragKey) return;
      this.dragKey = null;
      try { this.canvas.releasePointerCapture(e.pointerId); } catch (_) {}
      this.onChange(this.getADSR());
    };
    this.canvas.addEventListener('pointerup', end);
    this.canvas.addEventListener('pointercancel', end);
  }

  draw() {
    const ctx = this.ctx;
    const w = this.canvas.width;
    const h = this.canvas.height;
    ctx.clearRect(0, 0, w, h);

    const css = getComputedStyle(document.documentElement);

    // Background
    ctx.fillStyle = (css.getPropertyValue('--canvas-bg') || '#0d0d0d').trim();
    ctx.fillRect(0, 0, w, h);

    // Grid
    ctx.strokeStyle = (css.getPropertyValue('--canvas-grid') || 'rgba(255,255,255,0.10)').trim();
    ctx.lineWidth = 1;
    ctx.setLineDash([3, 4]);
    for (const frac of [0.25, 0.5, 0.75]) {
      const x = this.pad + frac * (w - this.pad * 2);
      ctx.beginPath();
      ctx.moveTo(x, 0);
      ctx.lineTo(x, h);
      ctx.stroke();
    }
    for (const frac of [0.25, 0.5, 0.75]) {
      const y = this.pad + frac * (h - this.pad * 2);
      ctx.beginPath();
      ctx.moveTo(0, y);
      ctx.lineTo(w, y);
      ctx.stroke();
    }
    ctx.setLineDash([]);

    // Curve
    ctx.strokeStyle = (css.getPropertyValue('--trace') || 'rgba(255,255,255,0.92)').trim();
    ctx.lineWidth = 2;
    ctx.beginPath();
    const a = Number(this.adsr.attackMs) || 0;
    const d = Number(this.adsr.decayMs) || 0;
    const hold = Number(this.adsr.holdMs) || 0;
    const rls = Number(this.adsr.releaseMs) || 0;
    const s = clamp(Number(this.adsr.sustain) || 0, 0, 1);
    const pts = [
      { t: 0, level: 0 },
      { t: a, level: 1 },
      { t: a + d, level: s },
      { t: a + d + hold, level: s },
      { t: a + d + hold + rls, level: 0 },
    ];
    for (let i = 0; i < pts.length; i++) {
      const p = this._tToCanvas(pts[i].t, pts[i].level);
      if (i === 0) ctx.moveTo(p.x, p.y);
      else ctx.lineTo(p.x, p.y);
    }
    ctx.stroke();

    // Handles
    const dpr = Math.max(1, window.devicePixelRatio || 1);
    ctx.font = `${Math.round(12 * dpr)}px ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial, sans-serif`;
    ctx.textAlign = 'center';
    ctx.textBaseline = 'middle';

    for (const hnd of this._handles()) {
      const p = this._tToCanvas(hnd.t, hnd.level);
      const active = this.dragKey === hnd.key;

      ctx.fillStyle = active ? '#fff' : '#e9e9e9';
      ctx.beginPath();
      ctx.arc(p.x, p.y, this.r, 0, Math.PI * 2);
      ctx.fill();
      ctx.strokeStyle = 'rgba(0,0,0,0.55)';
      ctx.lineWidth = 2;
      ctx.stroke();

      ctx.fillStyle = 'rgba(0,0,0,0.70)';
      ctx.fillText(hnd.key, p.x, p.y - (this.r + 10 * dpr));
      ctx.fillStyle = 'rgba(255,255,255,0.92)';
      ctx.fillText(hnd.key, p.x, p.y - (this.r + 10 * dpr));
    }
  }
}

// ============ DOM ============
const audioBtn = document.getElementById('audio-btn');
const randomiseBtn = document.getElementById('randomise-btn');
const resetBtn = document.getElementById('reset-btn');
const bpmInput = document.getElementById('bpm');
const mainGain = document.getElementById('main-gain');
const mainGainVal = document.getElementById('main-gain-val');

const oscGrid = document.getElementById('osc-grid');
const oscResetGainBtn = document.getElementById('osc-reset-gain');
const oscSetAllBtn = document.getElementById('osc-set-all');
const oscSetAllWave = document.getElementById('osc-set-all-wave');

const modToggleBtn = document.getElementById('mod-toggle');
const modWave = document.getElementById('mod-wave');

// Canvases
const meterCanvas = document.getElementById('meter-canvas');
const scopeCanvas = document.getElementById('scope-canvas');
const spectrumCanvas = document.getElementById('spectrum-canvas');

const notchCanvas = document.getElementById('notch-canvas');
const lpCanvas = document.getElementById('lp-canvas');
const hpCanvas = document.getElementById('hp-canvas');

// Distortion (post-filter)
const distToggleBtn = document.getElementById('dist-toggle');
const distTypeSel = document.getElementById('dist-type');

// ============ Controls ============

// Audio
audioBtn.addEventListener('click', async () => {
  const on = await synth.toggle();
  audioBtn.classList.toggle('on', on);
  audioBtn.setAttribute('aria-pressed', on ? 'true' : 'false');
  if (on) {
    // Once nodes exist, refresh graphs to match the active filters.
    drawFilter('notch', notchCanvas);
    drawFilter('lowpass', lpCanvas);
    drawFilter('highpass', hpCanvas);
  }
});

// BPM
bpmInput.addEventListener('change', () => synth.setBPM(Number(bpmInput.value) || 120));
bpmInput.addEventListener('input', () => synth.setBPM(Number(bpmInput.value) || 120));

// Main gain
mainGain.addEventListener('input', () => {
  const v = Number(mainGain.value);
  synth.setMainGainDb(v);
  mainGainVal.textContent = fmtDb(v);
});
synth.setMainGainDb(Number(mainGain.value));
mainGainVal.textContent = fmtDb(Number(mainGain.value));

// Overtone coefficient knob
const overtoneKnob = initKnob(document.getElementById('overtone-knob'), {
  format: v => Number(v).toFixed(2),
  onChange: v => synth.setOvertoneCoefficient(v),
});
document.getElementById('overtone-reset').addEventListener('click', () => overtoneKnob.setValue(1));

// ADSR knobs + envelope editor
const envCanvas = document.getElementById('env-canvas');
const attackKnob = initKnob(document.getElementById('adsr-attack-knob'), {
  format: v => `${Math.round(v)}ms`,
  onChange: () => syncADSRFromUI(),
});
const decayKnob = initKnob(document.getElementById('adsr-decay-knob'), {
  format: v => `${Math.round(v)}ms`,
  onChange: () => syncADSRFromUI(),
});
const sustainKnob = initKnob(document.getElementById('adsr-sustain-knob'), {
  format: v => `${Math.round(v)}%`,
  onChange: () => syncADSRFromUI(),
});
const releaseKnob = initKnob(document.getElementById('adsr-release-knob'), {
  format: v => `${Math.round(v)}ms`,
  onChange: () => syncADSRFromUI(),
});

function deriveInitialADSR() {
  const pts = Array.isArray(synth.envelopePoints) ? synth.envelopePoints : [];
  const domain = Math.max(100, Number(synth.noteDurationMs) || 100);
  const releaseMs = clamp(Number(synth.noteReleaseMs) || 420, 5, 6000);
  if (pts.length < 2) return { attackMs: 40, decayMs: 180, sustain: 0.62, releaseMs, holdMs: 240 };

  let peak = pts[0];
  for (const p of pts) {
    if ((Number(p.y) || 0) >= (Number(peak.y) || 0)) peak = p;
  }
  const last = pts[pts.length - 1];
  const attackMs = clamp((Number(peak.x) || 0) * domain, 0, 5000);
  const endMs = clamp((Number(last.x) || 1) * domain, 0, 20000);
  const decayMs = clamp(Math.max(0, endMs - attackMs), 0, 8000);
  const sustain = clamp(Number(last.y) || 0.62, 0, 1);
  return { attackMs, decayMs, sustain, releaseMs, holdMs: 240 };
}

let adsrState = deriveInitialADSR();
let envEditor = null;

function applyADSRToEngine(state) {
  const attackMs = clamp(Number(state.attackMs) || 0, 0, 5000);
  const decayMs = clamp(Number(state.decayMs) || 0, 0, 8000);
  const sustain = clamp(Number(state.sustain) || 0, 0, 1);
  const releaseMs = clamp(Number(state.releaseMs) || 0, 5, 6000);
  const holdMs = clamp(Number(state.holdMs) || 0, 0, 5000);

  const totalMsRaw = attackMs + decayMs + holdMs + releaseMs;
  const totalMs = clamp(totalMsRaw, 100, 20000);
  const t1 = clamp(attackMs, 0, totalMs);
  const t2 = clamp(attackMs + decayMs, 0, totalMs);
  const t3 = clamp(attackMs + decayMs + holdMs, 0, totalMs);

  synth.setNoteDurationMs(totalMs);
  synth.setNoteReleaseMs(releaseMs);
  synth.setEnvelopePoints([
    { x: 0, y: 0 },
    { x: t1 / totalMs, y: 1 },
    { x: t2 / totalMs, y: sustain },
    { x: t3 / totalMs, y: sustain },
    { x: 1, y: 0 },
  ]);
}

function setADSR(next, { updateUI = true, updateGraph = true, updateEngine = true } = {}) {
  adsrState = {
    ...adsrState,
    ...next,
  };
  // Clamp via editor logic for consistency
  if (updateGraph && envEditor) envEditor.setADSR(adsrState, { emit: false });
  if (updateEngine) applyADSRToEngine(adsrState);

  // Update note duration readout
  const totalMs = (Number(adsrState.attackMs) || 0) + (Number(adsrState.decayMs) || 0)
    + (Number(adsrState.holdMs) || 0) + (Number(adsrState.releaseMs) || 0);
  const noteDurEl = document.getElementById('note-duration-val');
  if (noteDurEl) noteDurEl.textContent = `${Math.round(clamp(totalMs, 100, 20000))} ms`;

  if (updateUI) {
    attackKnob.setValue(clamp(Number(adsrState.attackMs) || 0, 0, 5000), { emit: false });
    decayKnob.setValue(clamp(Number(adsrState.decayMs) || 0, 0, 8000), { emit: false });
    sustainKnob.setValue(clamp((Number(adsrState.sustain) || 0) * 100, 0, 100), { emit: false });
    releaseKnob.setValue(clamp(Number(adsrState.releaseMs) || 0, 5, 6000), { emit: false });
  }
}

function syncADSRFromUI() {
  setADSR({
    attackMs: attackKnob.getValue(),
    decayMs: decayKnob.getValue(),
    sustain: sustainKnob.getValue() / 100,
    releaseMs: releaseKnob.getValue(),
  }, { updateUI: false, updateGraph: true, updateEngine: true });
}

envEditor = new EnvelopeEditor(envCanvas, adsrState, (next) => {
  setADSR(next, { updateUI: true, updateGraph: false, updateEngine: true });
});

// Sync initial ADSR into UI + engine + graph
setADSR(adsrState, { updateUI: true, updateGraph: true, updateEngine: true });

// Oscillator grid
function buildOscGrid() {
  const waveOptions = [
    ['sine', 'Si'],
    ['sawtooth', 'Sa'],
    ['triangle', 'Tr'],
    ['square', 'Sq'],
  ];

  oscGrid.innerHTML = '';
  for (let i = 0; i < 16; i++) {
    const cfg = synth.oscConfigs[i];
    const el = document.createElement('div');
    el.className = 'osc';
    el.dataset.osc = String(i);

    const label = document.createElement('div');
    label.className = 'osc-label';
    label.textContent = String(i + 1);

    const sel = document.createElement('select');
    sel.className = 'osc-wave';
    for (const [val, txt] of waveOptions) {
      const opt = document.createElement('option');
      opt.value = val;
      opt.textContent = txt;
      if (cfg.waveform === val) opt.selected = true;
      sel.appendChild(opt);
    }
    sel.addEventListener('change', () => synth.setOscWaveform(i, sel.value));

    const fader = document.createElement('input');
    fader.type = 'range';
    fader.className = 'v-fader osc-gain';
    fader.min = '-70';
    fader.max = '6';
    fader.step = '0.1';
    fader.value = String(cfg.gainDb);

    const readout = document.createElement('div');
    readout.className = 'osc-db';
    readout.textContent = fmtDb(Number(fader.value));

    fader.addEventListener('input', () => {
      const v = Number(fader.value);
      synth.setOscGainDb(i, v);
      readout.textContent = fmtDb(v);
    });

    el.appendChild(label);
    el.appendChild(sel);
    el.appendChild(fader);
    el.appendChild(readout);
    oscGrid.appendChild(el);
  }
}
buildOscGrid();

oscResetGainBtn.addEventListener('click', () => {
  // Max patch "Reset gain" sets live.gain~ back to minimum.
  for (let i = 0; i < 16; i++) {
    synth.setOscGainDb(i, -70);
  }
  // Keep osc 1 audible as a default starting point.
  synth.setOscGainDb(0, -6);
  buildOscGrid();
});

oscSetAllBtn.addEventListener('click', () => {
  const wave = oscSetAllWave.value;
  for (let i = 0; i < 16; i++) synth.setOscWaveform(i, wave);
  buildOscGrid();
});

// Modulation (ring mod)
let modOn = false;
function setModOn(on) {
  modOn = !!on;
  modToggleBtn.classList.toggle('on', modOn);
  modToggleBtn.setAttribute('aria-pressed', modOn ? 'true' : 'false');
  modToggleBtn.textContent = modOn ? '✓' : '✕';
  synth.setRingModEnabled(modOn);
}
modToggleBtn.addEventListener('click', () => setModOn(!modOn));
modWave.addEventListener('change', () => synth.setRingModWaveform(modWave.value));

const pitchKnob = initKnob(document.getElementById('pitch-comp-knob'), {
  format: v => fmtCents(v),
  onChange: v => synth.setPitchCompCents(v),
});

const modFreqKnob = initKnob(document.getElementById('mod-freq-knob'), {
  format: v => fmtFreq(v),
  onChange: v => synth.setRingModFrequency(v),
});
synth.setRingModWaveform(modWave.value);
synth.setRingModFrequency(modFreqKnob.getValue());
synth.setPitchCompCents(pitchKnob.getValue());

// Distortion
let distOn = false;
function setDistOn(on) {
  distOn = !!on;
  if (!distToggleBtn) return;
  distToggleBtn.classList.toggle('on', distOn);
  distToggleBtn.setAttribute('aria-pressed', distOn ? 'true' : 'false');
  distToggleBtn.textContent = distOn ? '✓' : '✕';
  synth.setDistortionEnabled(distOn);
}
if (distToggleBtn) distToggleBtn.addEventListener('click', () => setDistOn(!distOn));

const distDriveKnob = initKnob(document.getElementById('dist-drive-knob'), {
  format: v => `${Math.round(Number(v) * 100)}%`,
  onChange: v => synth.setDistortionDrive(v),
});
const distMixKnob = initKnob(document.getElementById('dist-mix-knob'), {
  format: v => `${Math.round(Number(v) * 100)}%`,
  onChange: v => synth.setDistortionMix(v),
});
if (distTypeSel) {
  distTypeSel.addEventListener('change', () => synth.setDistortionType(distTypeSel.value));
  synth.setDistortionType(distTypeSel.value);
}
synth.setDistortionDrive(distDriveKnob.getValue());
synth.setDistortionMix(distMixKnob.getValue());
setDistOn(false);

// Filters
const filterFreqs = logspace(20, 20000, 384);

function drawFilter(which, canvas) {
  const ctx = canvas.getContext('2d');
  const w = canvas.width;
  const h = canvas.height;

  ctx.clearRect(0, 0, w, h);
  ctx.fillStyle = getComputedStyle(document.documentElement).getPropertyValue('--canvas-bg') || '#0d0d0d';
  ctx.fillRect(0, 0, w, h);

  // Grid
  ctx.strokeStyle = getComputedStyle(document.documentElement).getPropertyValue('--canvas-grid') || 'rgba(255,255,255,0.10)';
  ctx.lineWidth = 1;
  ctx.setLineDash([3, 4]);
  for (const frac of [0.25, 0.5, 0.75]) {
    const x = frac * w;
    ctx.beginPath();
    ctx.moveTo(x, 0);
    ctx.lineTo(x, h);
    ctx.stroke();
  }
  for (const frac of [0.25, 0.5, 0.75]) {
    const y = frac * h;
    ctx.beginPath();
    ctx.moveTo(0, y);
    ctx.lineTo(w, y);
    ctx.stroke();
  }
  ctx.setLineDash([]);

  const mag = synth.getFilterResponse(which, filterFreqs);
  if (!mag) return;

  const minDb = -30;
  const maxDb = 30;
  ctx.strokeStyle = getComputedStyle(document.documentElement).getPropertyValue('--trace') || '#e0c850';
  ctx.lineWidth = 2;
  ctx.beginPath();
  for (let i = 0; i < mag.length; i++) {
    const db = 20 * Math.log10(Math.max(1e-6, mag[i]));
    const x = (i / (mag.length - 1)) * w;
    const y = (1 - (db - minDb) / (maxDb - minDb)) * h;
    if (i === 0) ctx.moveTo(x, y);
    else ctx.lineTo(x, y);
  }
  ctx.stroke();
}

const notchFreqKnob = initKnob(document.getElementById('notch-freq-knob'), {
  format: v => fmtFreq(v),
  onChange: v => { synth.setNotchFrequency(v); drawFilter('notch', notchCanvas); },
});
const notchQKnob = initKnob(document.getElementById('notch-q-knob'), {
  format: v => Number(v).toFixed(2),
  onChange: v => { synth.setNotchQ(v); drawFilter('notch', notchCanvas); },
});
const notchGainKnob = initKnob(document.getElementById('notch-gain-knob'), {
  format: v => fmtDb(v),
  onChange: v => { synth.setNotchGainDb(v); drawFilter('notch', notchCanvas); },
});

const lpFreqKnob = initKnob(document.getElementById('lp-freq-knob'), {
  format: v => fmtFreq(v),
  onChange: v => { synth.setLowpassFrequency(v); drawFilter('lowpass', lpCanvas); },
});
const lpQKnob = initKnob(document.getElementById('lp-q-knob'), {
  format: v => Number(v).toFixed(2),
  onChange: v => { synth.setLowpassQ(v); drawFilter('lowpass', lpCanvas); },
});

const hpFreqKnob = initKnob(document.getElementById('hp-freq-knob'), {
  format: v => fmtFreq(v),
  onChange: v => { synth.setHighpassFrequency(v); drawFilter('highpass', hpCanvas); },
});
const hpQKnob = initKnob(document.getElementById('hp-q-knob'), {
  format: v => Number(v).toFixed(2),
  onChange: v => { synth.setHighpassQ(v); drawFilter('highpass', hpCanvas); },
});

// Initial filter draws (will only show once audio is initialised, but ok)
drawFilter('notch', notchCanvas);
drawFilter('lowpass', lpCanvas);
drawFilter('highpass', hpCanvas);

// LFO units
const lfoUnits = Array.from(document.querySelectorAll('.lfo-unit')).map((unit) => {
  const index = Number(unit.dataset.lfo);
  const scope = unit.querySelector('canvas.lfo-scope');
  const toggle = unit.querySelector('button.lfo-toggle');
  const rateSel = unit.querySelector('select.lfo-rate');
  const waveSel = unit.querySelector('select.lfo-wave');
  const strengthKnobEl = unit.querySelector('.knob.lfo-strength');

  let enabled = false;
  const setEnabled = (on) => {
    enabled = !!on;
    toggle.classList.toggle('on', enabled);
    toggle.setAttribute('aria-pressed', enabled ? 'true' : 'false');
    toggle.textContent = enabled ? '✓' : '✕';
    synth.updateLFO(index, 'enabled', enabled);
  };
  toggle.addEventListener('click', () => setEnabled(!enabled));

  rateSel.addEventListener('change', () => {
    const beats = divisionToBeats(rateSel.value);
    synth.updateLFO(index, 'rateBeats', beats);
  });
  waveSel.addEventListener('change', () => synth.updateLFO(index, 'waveform', waveSel.value));

  const strengthKnob = initKnob(strengthKnobEl, {
    format: v => String(Math.round(v)),
    onChange: v => synth.updateLFO(index, 'strength', v),
  });

  // Set defaults into engine
  synth.updateLFO(index, 'waveform', waveSel.value);
  synth.updateLFO(index, 'rateBeats', divisionToBeats(rateSel.value));
  synth.updateLFO(index, 'strength', strengthKnob.getValue());
  setEnabled(false);

  return {
    index,
    scope,
    toggle,
    rateSel,
    waveSel,
    strengthKnob,
    setEnabled,
    get enabled() { return enabled; },
    get waveform() { return waveSel.value; },
    get rateBeats() { return divisionToBeats(rateSel.value); },
  };
});

// ============ Randomise / Reset ============
function clonePoints(pts) {
  return (pts || []).map(p => ({ x: Number(p.x) || 0, y: Number(p.y) || 0 }));
}

const DEFAULT_STATE = (() => {
  return {
    bpm: Number(bpmInput.value) || 120,
    mainGainDb: Number(mainGain.value) || 0,
    overtoneCoefficient: overtoneKnob.getValue(),
    adsr: { ...adsrState },
    oscConfigs: synth.oscConfigs.map(cfg => ({ waveform: cfg.waveform, gainDb: cfg.gainDb })),
    filters: {
      notch: { ...synth.filterConfigs.notch },
      lowpass: { ...synth.filterConfigs.lowpass },
      highpass: { ...synth.filterConfigs.highpass },
    },
    distortion: {
      enabled: distOn,
      type: distTypeSel ? distTypeSel.value : 'soft',
      drive: distDriveKnob.getValue(),
      mix: distMixKnob.getValue(),
    },
    ringMod: { enabled: modOn, waveform: modWave.value, frequency: modFreqKnob.getValue() },
    pitchCompCents: pitchKnob.getValue(),
    lfos: lfoUnits.map(u => ({
      enabled: u.enabled,
      rateDiv: u.rateSel.value,
      waveform: u.waveSel.value,
      strength: u.strengthKnob.getValue(),
    })),
  };
})();

function applyState(state) {
  if (!state) return;

  bpmInput.value = String(state.bpm);
  synth.setBPM(Number(state.bpm));

  mainGain.value = String(state.mainGainDb);
  synth.setMainGainDb(Number(state.mainGainDb));
  mainGainVal.textContent = fmtDb(Number(state.mainGainDb));

  overtoneKnob.setValue(state.overtoneCoefficient);
  if (state.adsr) setADSR(state.adsr, { updateUI: true, updateGraph: true, updateEngine: true });

  // Oscillators
  if (Array.isArray(state.oscConfigs) && state.oscConfigs.length === 16) {
    for (let i = 0; i < 16; i++) {
      const cfg = state.oscConfigs[i];
      if (cfg && cfg.waveform) synth.setOscWaveform(i, cfg.waveform);
      if (cfg && Number.isFinite(Number(cfg.gainDb))) synth.setOscGainDb(i, Number(cfg.gainDb));
    }
    buildOscGrid();
  }

  // Distortion
  if (state.distortion) {
    if (distTypeSel && state.distortion.type) {
      distTypeSel.value = state.distortion.type;
      synth.setDistortionType(state.distortion.type);
    }
    if (Number.isFinite(Number(state.distortion.drive))) distDriveKnob.setValue(Number(state.distortion.drive));
    if (Number.isFinite(Number(state.distortion.mix))) distMixKnob.setValue(Number(state.distortion.mix));
    setDistOn(!!state.distortion.enabled);
  }

  // Ring mod
  setModOn(!!state.ringMod?.enabled);
  if (state.ringMod?.waveform) {
    modWave.value = state.ringMod.waveform;
    synth.setRingModWaveform(state.ringMod.waveform);
  }
  if (Number.isFinite(Number(state.ringMod?.frequency))) modFreqKnob.setValue(Number(state.ringMod.frequency));
  if (Number.isFinite(Number(state.pitchCompCents))) pitchKnob.setValue(Number(state.pitchCompCents));

  // Filters
  if (state.filters?.notch) {
    notchFreqKnob.setValue(state.filters.notch.frequency);
    notchQKnob.setValue(state.filters.notch.Q);
    notchGainKnob.setValue(state.filters.notch.gainDb);
  }
  if (state.filters?.lowpass) {
    lpFreqKnob.setValue(state.filters.lowpass.frequency);
    lpQKnob.setValue(state.filters.lowpass.Q);
  }
  if (state.filters?.highpass) {
    hpFreqKnob.setValue(state.filters.highpass.frequency);
    hpQKnob.setValue(state.filters.highpass.Q);
  }

  // LFOs
  if (Array.isArray(state.lfos) && state.lfos.length === lfoUnits.length) {
    for (let i = 0; i < lfoUnits.length; i++) {
      const u = lfoUnits[i];
      const cfg = state.lfos[i] || {};
      if (cfg.waveform) {
        u.waveSel.value = cfg.waveform;
        synth.updateLFO(u.index, 'waveform', cfg.waveform);
      }
      if (cfg.rateDiv) {
        u.rateSel.value = cfg.rateDiv;
        synth.updateLFO(u.index, 'rateBeats', divisionToBeats(cfg.rateDiv));
      }
      if (Number.isFinite(Number(cfg.strength))) u.strengthKnob.setValue(Number(cfg.strength));
      u.setEnabled(!!cfg.enabled);
    }
  }

  postHeight();
}

function randomiseState() {
  const waveforms = ['sine', 'triangle', 'sawtooth', 'square'];
  const lfoDivs = Array.from(lfoUnits[0]?.rateSel?.options || []).map(o => o.value).filter(Boolean);
  const safeLfoDivs = lfoDivs.length ? lfoDivs : ['4/1', '2/1', '1/1', '1/2', '1/4', '1/8', '1/16'];

  // Don't touch ADSR / Main Gain.
  const mainGainDb = Number(mainGain.value) || 0;
  const adsr = { ...adsrState };

  const oscConfigs = Array.from({ length: 16 }, (_, i) => {
    const waveform = pick(waveforms);
    const gainDb = i === 0
      ? randRange(-18, -6)
      : (Math.random() < 0.33 ? randRange(-45, -12) : randRange(-70, -50));
    return { waveform, gainDb };
  });

  const lfos = lfoUnits.map(() => {
    const enabled = Math.random() < 0.35;
    const rateDiv = pick(safeLfoDivs);
    const waveform = pick(waveforms);
    const strength = enabled ? randInt(80, 1600) : 0;
    return { enabled, rateDiv, waveform, strength };
  });

  return {
    bpm: randInt(60, 165),
    mainGainDb,
    overtoneCoefficient: clamp(1 + randRange(-0.7, 0.7), 0, 2),
    adsr,
    oscConfigs,
    filters: {
      notch: {
        frequency: randLog(80, 12000),
        Q: randRange(0.2, 10),
        gainDb: randRange(-12, 12),
      },
      lowpass: {
        frequency: randLog(180, 20000),
        Q: randRange(0.2, 10),
      },
      highpass: {
        frequency: randLog(20, 800),
        Q: randRange(0.2, 10),
      },
    },
    ringMod: {
      enabled: Math.random() < 0.25,
      waveform: pick(waveforms),
      frequency: randLog(0.1, 900),
    },
    distortion: {
      enabled: Math.random() < 0.55,
      type: Math.random() < 0.8 ? 'soft' : 'hard',
      drive: randRange(0.05, 0.95),
      mix: randRange(0.15, 0.9),
    },
    pitchCompCents: -randInt(0, 1200),
    lfos,
  };
}

if (randomiseBtn) randomiseBtn.addEventListener('click', () => applyState(randomiseState()));
if (resetBtn) resetBtn.addEventListener('click', () => applyState(DEFAULT_STATE));

// ============ Keyboard ============
const keyboardEl = document.getElementById('keyboard');
const BLACK_KEYS = new Set([1, 3, 6, 8, 10]);
let baseOctave = 4; // C4

function buildKeyboard() {
  const octaveEl = document.getElementById('octave-display');
  if (octaveEl) octaveEl.textContent = String(baseOctave);
  keyboardEl.innerHTML = '';
  for (let oct = 0; oct < 2; oct++) {
    for (let i = 0; i < 12; i++) {
      const note = (baseOctave + oct) * 12 + i;
      const key = document.createElement('div');
      const isBlack = BLACK_KEYS.has(i);
      key.className = `key ${isBlack ? 'key-black' : 'key-white'}`;
      key.dataset.note = String(note);
      const end = (e) => {
        try { key.releasePointerCapture(e.pointerId); } catch (_) {}
        synth.noteOff(note);
        key.classList.remove('active');
      };
      key.addEventListener('pointerdown', (e) => {
        e.preventDefault();
        try { key.setPointerCapture(e.pointerId); } catch (_) {}
        synth.noteOn(note);
        key.classList.add('active');
      });
      key.addEventListener('pointerup', end);
      key.addEventListener('pointercancel', end);
      keyboardEl.appendChild(key);
    }
  }
}
buildKeyboard();

const KEY_MAP = {
  'a': 0, 'w': 1, 's': 2, 'e': 3, 'd': 4,
  'f': 5, 't': 6, 'g': 7, 'y': 8, 'h': 9, 'u': 10, 'j': 11,
  'k': 12, 'o': 13, 'l': 14, 'p': 15, ';': 16,
};
const heldKeys = new Map(); // key -> MIDI note

function isTypingTarget(el) {
  if (!el) return false;
  if (el.isContentEditable) return true;
  const tag = el.tagName;
  if (tag === 'TEXTAREA') return true;
  if (tag !== 'INPUT') return false;
  const type = (el.getAttribute('type') || '').toLowerCase();
  return ['text', 'search', 'url', 'email', 'password', 'tel', 'number'].includes(type);
}

document.addEventListener('keydown', (e) => {
  if (e.repeat) return;
  if (e.metaKey || e.ctrlKey || e.altKey) return;
  if (isTypingTarget(document.activeElement)) return;

  const k = e.key.toLowerCase();
  if (k === 'z') { baseOctave = Math.max(0, baseOctave - 1); buildKeyboard(); return; }
  if (k === 'x') { baseOctave = Math.min(8, baseOctave + 1); buildKeyboard(); return; }
  if (!(k in KEY_MAP)) return;

  e.preventDefault();
  e.stopPropagation();

  const note = baseOctave * 12 + KEY_MAP[k];
  if (heldKeys.has(k)) return;
  heldKeys.set(k, note);

  synth.noteOn(note);
  const keyEl = keyboardEl.querySelector(`[data-note="${note}"]`);
  if (keyEl) keyEl.classList.add('active');
}, true);

document.addEventListener('keyup', (e) => {
  if (e.metaKey || e.ctrlKey || e.altKey) return;
  if (isTypingTarget(document.activeElement)) return;

  const k = e.key.toLowerCase();
  if (!(k in KEY_MAP)) return;
  const note = heldKeys.get(k);
  if (!Number.isFinite(note)) return;
  heldKeys.delete(k);

  synth.noteOff(note);
  const keyEl = keyboardEl.querySelector(`[data-note="${note}"]`);
  if (keyEl) keyEl.classList.remove('active');
}, true);

window.addEventListener('blur', () => {
  for (const note of heldKeys.values()) synth.noteOff(note);
  heldKeys.clear();
  keyboardEl.querySelectorAll('.key.active').forEach((el) => el.classList.remove('active'));
});

// ============ Visualizers ============
const meterCtx = meterCanvas.getContext('2d');
const scopeCtx = scopeCanvas.getContext('2d');
const specCtx = spectrumCanvas.getContext('2d');

function drawMeter(level) {
  const w = meterCanvas.width;
  const h = meterCanvas.height;
  meterCtx.clearRect(0, 0, w, h);
  meterCtx.fillStyle = '#0d0d0d';
  meterCtx.fillRect(0, 0, w, h);
  const v = clamp(level * 3.2, 0, 1); // boost for visibility
  const barH = v * (h - 12);
  meterCtx.fillStyle = '#3ddc84';
  meterCtx.fillRect(12, h - 6 - barH, w - 24, barH);
}

function drawScope(data) {
  const w = scopeCanvas.width;
  const h = scopeCanvas.height;
  scopeCtx.clearRect(0, 0, w, h);
  scopeCtx.fillStyle = '#0d0d0d';
  scopeCtx.fillRect(0, 0, w, h);
  if (!data) return;
  scopeCtx.strokeStyle = '#4a9eff';
  scopeCtx.lineWidth = 2;
  scopeCtx.beginPath();
  for (let i = 0; i < data.length; i++) {
    const x = (i / (data.length - 1)) * w;
    const y = (0.5 - data[i] * 0.45) * h;
    if (i === 0) scopeCtx.moveTo(x, y);
    else scopeCtx.lineTo(x, y);
  }
  scopeCtx.stroke();
}

function drawSpectrum(data) {
  const w = spectrumCanvas.width;
  const h = spectrumCanvas.height;
  specCtx.clearRect(0, 0, w, h);
  specCtx.fillStyle = '#0d0d0d';
  specCtx.fillRect(0, 0, w, h);
  if (!data) return;
  specCtx.fillStyle = '#e0c850';
  const n = data.length;
  const step = Math.max(1, Math.floor(n / 256));
  for (let i = 0; i < n; i += step) {
    const v = data[i] / 255;
    const x = (i / (n - 1)) * w;
    const bar = v * (h - 10);
    specCtx.fillRect(x, h - bar, Math.max(1, w / (n / step)), bar);
  }
}

// LFO scope draw
function drawLFOScope(canvas, cfg, tNowSec) {
  const ctx = canvas.getContext('2d');
  const w = canvas.width;
  const h = canvas.height;
  ctx.clearRect(0, 0, w, h);
  ctx.fillStyle = '#0d0d0d';
  ctx.fillRect(0, 0, w, h);

  // Grid
  ctx.strokeStyle = 'rgba(255,255,255,0.10)';
  ctx.setLineDash([3, 4]);
  ctx.beginPath();
  ctx.moveTo(0, h / 2);
  ctx.lineTo(w, h / 2);
  ctx.stroke();
  for (const frac of [0.25, 0.5, 0.75]) {
    const x = frac * w;
    ctx.beginPath();
    ctx.moveTo(x, 0);
    ctx.lineTo(x, h);
    ctx.stroke();
  }
  ctx.setLineDash([]);

  if (!cfg.enabled) {
    ctx.strokeStyle = 'rgba(255,255,255,0.14)';
    ctx.lineWidth = 6;
    ctx.beginPath();
    ctx.moveTo(w * 0.22, h * 0.22);
    ctx.lineTo(w * 0.78, h * 0.78);
    ctx.moveTo(w * 0.78, h * 0.22);
    ctx.lineTo(w * 0.22, h * 0.78);
    ctx.stroke();
    return;
  }

  const rateHz = (Number(bpmInput.value) || 120) / 60 / Math.max(0.001, cfg.rateBeats);
  const phase = (tNowSec * rateHz) % 1;
  ctx.strokeStyle = '#e0c850';
  ctx.lineWidth = 2;
  ctx.beginPath();
  for (let x = 0; x < w; x++) {
    const t = x / (w - 1);
    const yv = evalWave(cfg.waveform, t + phase);
    const y = (0.5 - yv * 0.42) * h;
    if (x === 0) ctx.moveTo(0, y);
    else ctx.lineTo(x, y);
  }
  ctx.stroke();
}

function raf() {
  const scope = synth.getScopeData();
  const spec = synth.getSpectrumData();
  const level = synth.getLevel();
  drawMeter(level);
  drawScope(scope);
  drawSpectrum(spec);

  const tNow = performance.now() / 1000;
  for (const u of lfoUnits) drawLFOScope(u.scope, u, tNow);

  requestAnimationFrame(raf);
}
requestAnimationFrame(raf);

// ============ Iframe Height ============
function postHeight() {
  const root = document.getElementById('max-synth');
  if (!root) return;
  const h = root.scrollHeight;
  try { window.parent.postMessage({ type: 'ej-synth-height', height: h }, '*'); } catch (_) {}
}
window.addEventListener('load', () => setTimeout(postHeight, 0));
window.addEventListener('resize', () => postHeight());
setTimeout(postHeight, 250);
setTimeout(postHeight, 800);

// ============ MIDI File Player ============

function parseMidiFile(buffer) {
  const bytes = new Uint8Array(buffer);
  let pos = 0;

  function read32() {
    const v = ((bytes[pos] << 24) | (bytes[pos+1] << 16) | (bytes[pos+2] << 8) | bytes[pos+3]) >>> 0;
    pos += 4; return v;
  }
  function read16() { const v = (bytes[pos] << 8) | bytes[pos+1]; pos += 2; return v; }
  function read8()  { return bytes[pos++]; }
  function readVar() {
    let v = 0, b;
    do { b = read8(); v = (v << 7) | (b & 0x7F); } while (b & 0x80);
    return v;
  }

  if (read32() !== 0x4D546864) throw new Error('Not a MIDI file');
  read32(); // header length = 6
  read16(); // format (0=single, 1=multi-track, 2=multi-song)
  const numTracks  = read16();
  const division   = read16();
  if (division & 0x8000) throw new Error('SMPTE timecode not supported');
  const ticksPerBeat = division;

  const tracks = [];
  for (let t = 0; t < numTracks; t++) {
    if (pos + 8 > bytes.length) break;
    if (read32() !== 0x4D54726B) break; // 'MTrk'
    const trackLen = read32();
    const trackEnd = pos + trackLen;
    const events   = [];
    let tick = 0, running = 0;

    while (pos < trackEnd) {
      const delta = readVar();
      tick += delta;

      let status = bytes[pos];
      if (status & 0x80) { running = status; pos++; }
      else status = running; // running status

      const type = status & 0xF0;

      if (type === 0x90) {
        const note = read8(), vel = read8();
        events.push({ tick, type: vel > 0 ? 'noteOn' : 'noteOff', note });
      } else if (type === 0x80) {
        const note = read8(); read8();
        events.push({ tick, type: 'noteOff', note });
      } else if (type === 0xA0 || type === 0xB0 || type === 0xE0) {
        pos += 2;
      } else if (type === 0xC0 || type === 0xD0) {
        pos += 1;
      } else if (status === 0xF0 || status === 0xF7) {
        pos += readVar();
      } else if (status === 0xFF) {
        const meta = read8();
        const len  = readVar();
        if (meta === 0x51 && len === 3) {
          const b1 = read8(), b2 = read8(), b3 = read8();
          events.push({ tick, type: 'tempo', uspb: (b1 << 16) | (b2 << 8) | b3 });
        } else {
          pos += len;
        }
      } else {
        pos = trackEnd; break; // unknown, bail on track
      }
    }

    pos = trackEnd;
    tracks.push(events);
  }

  // Merge all tracks and sort by tick (tempo events first within same tick)
  const all = [].concat(...tracks).sort((a, b) =>
    a.tick !== b.tick ? a.tick - b.tick : (a.type === 'tempo' ? -1 : 1)
  );

  // Convert ticks to milliseconds, tracking tempo changes
  let uspb = 500000; // default: 120 BPM
  let lastTick = 0, lastMs = 0;
  const timeline = [];

  for (const ev of all) {
    const ms = lastMs + ((ev.tick - lastTick) / ticksPerBeat) * (uspb / 1000);
    if (ev.type === 'tempo') {
      lastMs = ms; lastTick = ev.tick; uspb = ev.uspb;
    } else if (ev.type === 'noteOn' || ev.type === 'noteOff') {
      timeline.push({ ms, type: ev.type, note: ev.note });
    }
  }

  return timeline;
}

// Player state
let midiTimeline   = null;
let midiTimers     = [];
let midiPlaying    = false;
let midiActiveNotes = new Set();
let midiFileName   = null;

const midiFileInput = document.getElementById('midi-file');
const midiPlayBtn   = document.getElementById('midi-play');
const midiStopBtn   = document.getElementById('midi-stop');
const midiStatusEl  = document.getElementById('midi-status');

function updateMidiUI() {
  if (!midiStatusEl) return;
  if (!midiTimeline) {
    midiStatusEl.textContent = 'No file loaded';
    midiStatusEl.className = 'midi-status';
  } else if (midiPlaying) {
    midiStatusEl.textContent = '\u25B6 ' + midiFileName;
    midiStatusEl.className = 'midi-status playing';
  } else {
    midiStatusEl.textContent = midiFileName;
    midiStatusEl.className = 'midi-status';
  }
  if (midiPlayBtn) midiPlayBtn.disabled = !midiTimeline || midiPlaying;
  if (midiStopBtn) midiStopBtn.disabled = !midiPlaying;
}

function stopMidi() {
  midiPlaying = false;
  for (const t of midiTimers) clearTimeout(t);
  midiTimers = [];
  for (const note of midiActiveNotes) synth.noteOff(note);
  midiActiveNotes.clear();
  updateMidiUI();
}

function playMidi() {
  if (!midiTimeline || midiPlaying) return;
  if (!synth.running) {
    if (midiStatusEl) {
      midiStatusEl.textContent = 'Enable audio first!';
      midiStatusEl.className = 'midi-status error';
    }
    return;
  }
  midiPlaying = true;
  updateMidiUI();

  for (const ev of midiTimeline) {
    const t = setTimeout(() => {
      if (!midiPlaying) return;
      if (ev.type === 'noteOn') {
        synth.noteOn(ev.note);
        midiActiveNotes.add(ev.note);
      } else {
        synth.noteOff(ev.note);
        midiActiveNotes.delete(ev.note);
      }
    }, ev.ms);
    midiTimers.push(t);
  }

  // Auto-stop after last event + release tail
  const lastMs = midiTimeline.length ? midiTimeline[midiTimeline.length - 1].ms : 0;
  const releaseMs = clamp(Number(adsrState.releaseMs) || 500, 5, 6000);
  const endT = setTimeout(() => stopMidi(), lastMs + releaseMs + 500);
  midiTimers.push(endT);
}

if (midiFileInput) {
  midiFileInput.addEventListener('change', (e) => {
    const file = e.target.files[0];
    if (!file) return;
    stopMidi();
    midiFileName = file.name.replace(/\.(mid|midi)$/i, '');
    if (midiStatusEl) { midiStatusEl.textContent = 'Parsing\u2026'; midiStatusEl.className = 'midi-status'; }
    const reader = new FileReader();
    reader.onload = (evt) => {
      try {
        midiTimeline = parseMidiFile(evt.target.result);
        updateMidiUI();
      } catch (err) {
        midiTimeline = null;
        if (midiStatusEl) { midiStatusEl.textContent = 'Error: ' + err.message; midiStatusEl.className = 'midi-status error'; }
        if (midiPlayBtn) midiPlayBtn.disabled = true;
      }
    };
    reader.readAsArrayBuffer(file);
    e.target.value = ''; // allow re-loading same file
  });
}

if (midiPlayBtn) midiPlayBtn.addEventListener('click', playMidi);
if (midiStopBtn) midiStopBtn.addEventListener('click', stopMidi);

updateMidiUI();
