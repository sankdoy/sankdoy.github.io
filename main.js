// --------- CONFIG YOU MUST EDIT ----------
const BANKS = [
  "Master.bank",
  "Master.strings.bank",
  // add others if you have them
];

const TEST_EVENT = "event:/Main"; // MUST match exactly (copy event path in FMOD Studio)
// ----------------------------------------

const DEFAULT_INTENSITY = 0;
const DEFAULT_HEALTH = 100;

let FMOD = null;
let studioSystem = null;
let eventDesc = null;
let eventInstance = null;
let started = false;
let isPaused = false;
let currentIntensity = DEFAULT_INTENSITY;
let currentHealth = DEFAULT_HEALTH;
let analyzerState = {
  canvas: null,
  ctx: null,
  analyser: null,
  data: null,
  rafId: 0,
  connected: false
};

function check(result, label) {
  const OK = typeof FMOD.OK === "number"
    ? FMOD.OK
    : (typeof FMOD.FMOD_OK === "number" ? FMOD.FMOD_OK : 0);
  if (result !== OK) throw new Error(`${label} failed (err ${result})`);
}

function setEventParameter(name, value) {
  if (!eventInstance) return;
  if (typeof eventInstance.setParameterByName === "function") {
    const result = eventInstance.setParameterByName(name, value, false);
    if (typeof result === "number") check(result, `setParameter(${name})`);
    return;
  }
  if (typeof eventInstance.setParameterByNameWithLabel === "function") {
    const result = eventInstance.setParameterByNameWithLabel(name, String(value));
    if (typeof result === "number") check(result, `setParameter(${name})`);
    return;
  }
  console.warn(`[FMOD] Missing parameter setter for ${name}`);
}

function applyParameters() {
  setEventParameter("Intensity", currentIntensity);
  setEventParameter("Health", currentHealth);
}

function setPaused(nextPaused) {
  if (!eventInstance || typeof eventInstance.setPaused !== "function") return;
  const result = eventInstance.setPaused(nextPaused);
  if (typeof result === "number") check(result, "eventInstance.setPaused");
  isPaused = nextPaused;
}

function stopAndReleaseEvent() {
  if (!eventInstance) return;
  if (typeof eventInstance.stop === "function") {
    const mode = typeof FMOD.STUDIO_STOP_IMMEDIATE === "number"
      ? FMOD.STUDIO_STOP_IMMEDIATE
      : 0;
    const result = eventInstance.stop(mode);
    if (typeof result === "number") check(result, "eventInstance.stop");
  }
  if (typeof eventInstance.release === "function") {
    const result = eventInstance.release();
    if (typeof result === "number") check(result, "eventInstance.release");
  }
  eventInstance = null;
}

function getAudioContext() {
  return FMOD && (FMOD.mContext || FMOD.context);
}

function getAudioNode() {
  return FMOD && (FMOD.mWorkletNode || FMOD._as_script_node);
}

function setupAnalyzer() {
  if (analyzerState.canvas) return;
  const canvas = document.getElementById("fmodAnalyzer");
  if (!canvas) return;
  const ctx = canvas.getContext("2d");
  if (!ctx) return;

  analyzerState.canvas = canvas;
  analyzerState.ctx = ctx;

  const resize = () => {
    const rect = canvas.getBoundingClientRect();
    const dpr = window.devicePixelRatio || 1;
    const width = Math.max(1, Math.floor(rect.width * dpr));
    const height = Math.max(1, Math.floor(rect.height * dpr));
    if (canvas.width !== width || canvas.height !== height) {
      canvas.width = width;
      canvas.height = height;
    }
    ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
  };

  resize();
  window.addEventListener("resize", resize);

  const connect = () => {
    if (analyzerState.connected) return true;
    const audioContext = getAudioContext();
    const sourceNode = getAudioNode();
    if (!audioContext || !sourceNode || typeof audioContext.createAnalyser !== "function") {
      return false;
    }

    if (!analyzerState.analyser) {
      analyzerState.analyser = audioContext.createAnalyser();
      analyzerState.analyser.fftSize = 4096;
      analyzerState.analyser.smoothingTimeConstant = 0.8;
      analyzerState.analyser.minDecibels = -96;
      analyzerState.analyser.maxDecibels = -20;
      analyzerState.data = new Float32Array(analyzerState.analyser.frequencyBinCount);
    }

    try {
      sourceNode.disconnect();
    } catch (_) {}

    try {
      analyzerState.analyser.disconnect();
    } catch (_) {}

    sourceNode.connect(analyzerState.analyser);
    analyzerState.analyser.connect(audioContext.destination);
    analyzerState.connected = true;
    return true;
  };

  const draw = () => {
    const rect = canvas.getBoundingClientRect();
    const width = rect.width;
    const height = rect.height;
    ctx.clearRect(0, 0, width, height);
    ctx.lineWidth = 2;
    ctx.strokeStyle = "rgba(255, 255, 255, 0.9)";
    ctx.beginPath();

    if (analyzerState.analyser && analyzerState.data && analyzerState.connected) {
      analyzerState.analyser.getFloatFrequencyData(analyzerState.data);
      const len = analyzerState.data.length;
      const minDb = analyzerState.analyser.minDecibels;
      const maxDb = analyzerState.analyser.maxDecibels;
      const nyquist = (getAudioContext()?.sampleRate || 44100) / 2;
      const minFreq = 20;
      const maxFreq = Math.min(20000, nyquist);
      const logMax = Math.log10(maxFreq / minFreq);
      const slopeDbPerOct = 3;

      for (let i = 0; i <= width; i += 1) {
        const pct = width === 0 ? 0 : i / width;
        const freq = minFreq * Math.pow(10, logMax * pct);
        const index = Math.min(len - 1, Math.max(0, Math.round((freq / nyquist) * (len - 1))));
        const db = analyzerState.data[index];
        const slope = slopeDbPerOct * Math.log2(freq / 1000);
        const displayDb = db + slope;
        let norm = (displayDb - minDb) / (maxDb - minDb);
        norm = Math.max(0, Math.min(1, norm));
        norm = Math.pow(norm, 0.8);
        const x = i;
        const y = height - (norm * height * 0.9 + height * 0.05);
        if (i === 0) {
          ctx.moveTo(x, y);
        } else {
          ctx.lineTo(x, y);
        }
      }
    } else {
      ctx.moveTo(0, height * 0.6);
      ctx.lineTo(width, height * 0.6);
    }

    ctx.stroke();
    analyzerState.rafId = requestAnimationFrame(draw);
  };

  if (!connect()) {
    let tries = 0;
    const timer = setInterval(() => {
      tries += 1;
      if (connect() || tries > 20) clearInterval(timer);
    }, 150);
  }

  if (!analyzerState.rafId) draw();
}

function createEventInstance() {
  if (!eventDesc) throw new Error("Event description is not ready.");
  const instOut = { val: 0 };
  check(eventDesc.createInstance(instOut), "createInstance");
  eventInstance = instOut.val;
  if (!eventInstance) throw new Error("createInstance returned 0 handle.");
  check(eventInstance.start(), "eventInstance.start");
  isPaused = false;
  applyParameters();
  setupAnalyzer();
}

async function fetchArrayBuffer(url) {
  const res = await fetch(url, { cache: "no-store" });
  if (!res.ok) throw new Error(`HTTP ${res.status} fetching ${url}`);
  return await res.arrayBuffer();
}

function ensureDir(path) {
  try {
    const clean = path.replace(/^\/+/, "");
    FMOD.FS_createPath("/", clean, true, true);
  } catch (_) {
    // Already exists.
  }
}

async function preloadToFS(fsPath, webUrl) {
  const dir = fsPath.slice(0, fsPath.lastIndexOf("/")) || "/";
  const name = fsPath.slice(fsPath.lastIndexOf("/") + 1);

  await new Promise((resolve, reject) => {
    try {
      FMOD.FS_createPreloadedFile(dir, name, webUrl, true, false, resolve, reject);
    } catch (err) {
      resolve();
    }
  });
}

async function loadBankFromFile(bankName) {
  ensureDir("/banks");
  const fsPath = `/banks/${bankName}`;
  const webUrl = `banks/${bankName}`;

  await preloadToFS(fsPath, webUrl);

  const bankOut = { val: 0 };
  const flags = typeof FMOD.STUDIO_LOAD_BANK_NORMAL === "number" ? FMOD.STUDIO_LOAD_BANK_NORMAL : 0;

  check(studioSystem.loadBankFile(fsPath, flags, bankOut), `loadBankFile(${bankName})`);
  console.log("[FMOD] Loaded bank:", bankName, "handle:", bankOut.val);
}

function waitForRuntime(moduleObj) {
  if (moduleObj && moduleObj.calledRun) return Promise.resolve(moduleObj);

  return new Promise((resolve, reject) => {
    moduleObj.onRuntimeInitialized = () => resolve(moduleObj);
    moduleObj.onAbort = (what) => reject(new Error("FMOD abort: " + what));
  });
}

async function getFMOD() {
  if (window.__fmodPromise) return await window.__fmodPromise;
  if (typeof window.FMODModule !== "function") {
    throw new Error("FMODModule not found. Check that fmod/fmodstudio.js loaded (no 404).");
  }

  const cfg = window.Module || {};
  const maybe = window.FMODModule(cfg);
  window.__fmodPromise = maybe && typeof maybe.then === "function"
    ? maybe
    : waitForRuntime(maybe);
  return await window.__fmodPromise;
}

async function startFMOD() {
  if (started) return;
  started = true;

  FMOD = await getFMOD();

  console.log("[FMOD] Ready. Has Studio_System_Create:", typeof FMOD.Studio_System_Create);

  if (typeof FMOD.Studio_System_Create !== "function") {
    throw new Error(
      "Studio wrappers still missing. This usually means the wrong JS/WASM pair is being served or cached."
    );
  }

  const systemOut = { val: 0 };
  check(FMOD.Studio_System_Create(systemOut), "Studio_System_Create");
  studioSystem = systemOut.val;
  if (!studioSystem) throw new Error("Studio_System_Create returned 0 handle (wrong build or init).");

  const maxChannels = 1024;
  const studioFlags = typeof FMOD.STUDIO_INIT_NORMAL === "number" ? FMOD.STUDIO_INIT_NORMAL : 0;
  const coreFlags = typeof FMOD.INIT_NORMAL === "number" ? FMOD.INIT_NORMAL : 0;
  check(studioSystem.initialize(maxChannels, studioFlags, coreFlags, null), "system.initialize");

  console.log("[FMOD] Studio initialized");

  for (const b of BANKS) {
    await loadBankFromFile(b);
  }

  const eventDescOut = { val: 0 };
  check(studioSystem.getEvent(TEST_EVENT, eventDescOut), `getEvent(${TEST_EVENT})`);
  eventDesc = eventDescOut.val;
  createEventInstance();
  console.log("[FMOD] Playing:", TEST_EVENT);

  const tick = () => {
    studioSystem.update();
    requestAnimationFrame(tick);
  };
  tick();
}

window.addEventListener("DOMContentLoaded", () => {
  const startBtn = document.getElementById("startAudio");
  const toggleBtn = document.getElementById("toggleAudio");
  const resetBtn = document.getElementById("resetAudio");
  const intensitySlider = document.getElementById("intensitySlider");
  const healthSlider = document.getElementById("healthSlider");
  const intensityValue = document.getElementById("intensityValue");
  const healthValue = document.getElementById("healthValue");

  if (!startBtn) {
    console.warn('Missing button with id="startAudio"');
    return;
  }

  function updateValue(el, value) {
    if (el) el.textContent = String(value);
  }

  if (intensitySlider) {
    currentIntensity = Number(intensitySlider.value);
    updateValue(intensityValue, currentIntensity);
    intensitySlider.addEventListener("input", () => {
      currentIntensity = Number(intensitySlider.value);
      updateValue(intensityValue, currentIntensity);
      setEventParameter("Intensity", currentIntensity);
    });
  }

  if (healthSlider) {
    currentHealth = Number(healthSlider.value);
    updateValue(healthValue, currentHealth);
    healthSlider.addEventListener("input", () => {
      currentHealth = Number(healthSlider.value);
      updateValue(healthValue, currentHealth);
      setEventParameter("Health", currentHealth);
    });
  }

  startBtn.addEventListener("click", () => {
    startFMOD().then(() => {
      startBtn.disabled = true;
      startBtn.textContent = "Audio ready";
      if (toggleBtn) toggleBtn.disabled = false;
      if (resetBtn) resetBtn.disabled = false;
      if (toggleBtn) toggleBtn.textContent = "Pause";
    }).catch((err) => {
      console.error(err);
      alert(err.message);
      started = false;
    });
  });

  if (toggleBtn) {
    toggleBtn.addEventListener("click", () => {
      if (!eventInstance) return;
      const nextPaused = !isPaused;
      setPaused(nextPaused);
      toggleBtn.textContent = nextPaused ? "Play" : "Pause";
    });
  }

  if (resetBtn) {
    resetBtn.addEventListener("click", () => {
      currentIntensity = DEFAULT_INTENSITY;
      currentHealth = DEFAULT_HEALTH;
      if (intensitySlider) intensitySlider.value = String(currentIntensity);
      if (healthSlider) healthSlider.value = String(currentHealth);
      updateValue(intensityValue, currentIntensity);
      updateValue(healthValue, currentHealth);

      (async () => {
        if (!started) {
          await startFMOD();
        } else {
          stopAndReleaseEvent();
          createEventInstance();
        }
        if (toggleBtn) toggleBtn.textContent = "Pause";
      })().catch((err) => {
        console.error(err);
        alert(err.message);
        started = false;
      });
    });
  }
});
