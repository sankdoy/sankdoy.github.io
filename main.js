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
const AB_FILES = {
  original: "assets/audio/Before.wav",
  restored: "assets/audio/After.wav"
};
const AB_SWITCH_DEFAULT = 50;
const AB_CROSSFADE_SECONDS = 0.012;
const AB_FADE_SECONDS = 0.2;

let FMOD = null;
let studioSystem = null;
let eventDesc = null;
let eventInstance = null;
let started = false;
let isPaused = false;
let soundCloudWidgets = [];
let isCoordinatingAudio = false;
const audioUi = {
  toggleBtn: null
};
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
let abState = {
  audioCtx: null,
  bufferA: null,
  bufferB: null,
  duration: 0,
  startTime: 0,
  offset: 0,
  switchPct: AB_SWITCH_DEFAULT,
  switchTime: 0,
  isPlaying: false,
  activeB: null,
  sourceA: null,
  sourceB: null,
  gainA: null,
  gainB: null,
  canvas: null,
  ctx: null,
  wrap: null,
  handle: null,
  status: null,
  playBtn: null,
  playheadHandle: null,
  peaks: null,
  lastWidth: 0,
  rafId: 0,
  dragging: false,
  draggingPlayhead: false,
  wasPlayingBeforeDrag: false
};

function pauseFMOD() {
  if (!eventInstance || isPaused) return;
  setPaused(true);
  if (audioUi.toggleBtn) audioUi.toggleBtn.textContent = "Play";
}

function pauseAbPlayback() {
  if (!abState.isPlaying || !abState.audioCtx) return;
  abState.offset = Math.min(
    abState.duration,
    Math.max(0, abState.audioCtx.currentTime - abState.startTime + AB_FADE_SECONDS)
  );
  abState.isPlaying = false;
  fadeOutAndStop();
  updateAbPlayhead(abState.offset);
  if (abState.playBtn) abState.playBtn.textContent = "Play";
}

let synthState = {
  audioCtx: null,
  voiceBus: null,
  filter: null,
  drive: null,
  delay: null,
  delayFeedback: null,
  dryGain: null,
  wetGain: null,
  master: null,
  analyser: null,
  splitter: null,
  analyserL: null,
  analyserR: null,
  lfo: null,
  lfoGain: null,
  voices: new Map(),
  voiceOrder: [],
  heldNotes: new Set(),
  arp: {
    enabled: false,
    rate: 8,
    timerId: 0,
    index: 0,
    activeVoice: null
  },
  ui: {
    root: null,
    startBtn: null,
    stopBtn: null,
    randomBtn: null,
    wave: null,
    cutoff: null,
    res: null,
    attack: null,
    release: null,
    drive: null,
    delayMix: null,
    lfoRate: null,
    arpToggle: null,
    arpRate: null,
    keysWrap: null,
    tabs: null,
    canvases: null
  },
  vis: {
    rafId: 0,
    mode: "scope",
    timeData: null,
    freqData: null,
    timeL: null,
    timeR: null
  },
  keyboard: {
    octave: 0,
    down: new Set()
  }
};

function pauseSynth() {
  if (!synthState.audioCtx) return;
  stopSynthArp();
  releaseAllSynthNotes();
  if (synthState.audioCtx.state === "running") {
    synthState.audioCtx.suspend().catch(() => {});
  }
  updateSynthUi();
}

function pauseSoundCloud() {
  if (soundCloudWidgets.length) {
    soundCloudWidgets.forEach((widget) => {
      try { widget.pause(); } catch (_) {}
    });
    return;
  }
  const iframes = document.querySelectorAll('iframe[src*="w.soundcloud.com/player"]');
  iframes.forEach((frame) => {
    try {
      frame.contentWindow?.postMessage(JSON.stringify({ method: "pause" }), "*");
    } catch (_) {}
  });
}

function pauseHtmlMedia(exceptEl) {
  const mediaEls = document.querySelectorAll("audio,video");
  mediaEls.forEach((el) => {
    if (el === exceptEl) return;
    if (!el.paused && typeof el.pause === "function") {
      try { el.pause(); } catch (_) {}
    }
  });
}

function pauseAllAudio({ except = {} } = {}) {
  if (isCoordinatingAudio) return;
  isCoordinatingAudio = true;

  if (!except.fmod) pauseFMOD();
  if (!except.ab) pauseAbPlayback();
  if (!except.synth) pauseSynth();
  if (!except.soundcloud) pauseSoundCloud();
  pauseHtmlMedia(except.media);

  isCoordinatingAudio = false;
}

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

function clamp(value, min, max) {
  return Math.max(min, Math.min(max, value));
}

function midiToFreq(note) {
  return 440 * Math.pow(2, (note - 69) / 12);
}

function makeDriveCurve(amount) {
  const k = clamp(amount, 0, 1) * 500;
  const n = 1024;
  const curve = new Float32Array(n);
  for (let i = 0; i < n; i += 1) {
    const x = (i * 2) / (n - 1) - 1;
    curve[i] = ((1 + k) * x) / (1 + k * Math.abs(x));
  }
  return curve;
}

function updateSynthUi() {
  const { startBtn, stopBtn, randomBtn } = synthState.ui;
  const ready = Boolean(synthState.audioCtx);
  const running = Boolean(synthState.audioCtx && synthState.audioCtx.state === "running");
  if (startBtn) startBtn.textContent = running ? "Running" : (ready ? "Resume" : "Start");
  if (startBtn) startBtn.disabled = false;
  if (stopBtn) stopBtn.disabled = !ready;
  if (randomBtn) randomBtn.disabled = !ready;
}

function setKeyVisual(note, down) {
  const btn = synthState.ui.keysWrap?.querySelector(`[data-note="${note}"]`);
  if (!btn) return;
  btn.classList.toggle("is-down", down);
}

function releaseVoice(voice, atTime) {
  const ctx = synthState.audioCtx;
  if (!ctx || !voice) return;
  const now = typeof atTime === "number" ? atTime : ctx.currentTime;
  const release = Number(synthState.ui.release?.value || 0.35);
  const tEnd = now + clamp(release, 0.01, 4);
  try {
    voice.amp.gain.cancelScheduledValues(now);
    voice.amp.gain.setValueAtTime(Math.max(0.0001, voice.amp.gain.value), now);
    voice.amp.gain.exponentialRampToValueAtTime(0.0001, tEnd);
  } catch (_) {}

  try { voice.osc1.stop(tEnd + 0.02); } catch (_) {}
  try { voice.osc2.stop(tEnd + 0.02); } catch (_) {}
  try { voice.sub.stop(tEnd + 0.02); } catch (_) {}
}

function releaseAllSynthNotes() {
  if (!synthState.audioCtx) return;
  const now = synthState.audioCtx.currentTime;
  for (const [note, voice] of synthState.voices.entries()) {
    releaseVoice(voice, now);
    setKeyVisual(note, false);
  }
  synthState.voices.clear();
  synthState.voiceOrder = [];
  synthState.heldNotes.clear();
  synthState.keyboard.down.clear();
}

function stopSynthArp() {
  if (synthState.arp.timerId) {
    clearInterval(synthState.arp.timerId);
    synthState.arp.timerId = 0;
  }
  if (synthState.arp.activeVoice) {
    releaseVoice(synthState.arp.activeVoice);
    synthState.arp.activeVoice = null;
  }
}

function startSynthArp() {
  stopSynthArp();
  if (!synthState.audioCtx) return;
  const ctx = synthState.audioCtx;

  const tick = () => {
    if (!synthState.arp.enabled) return;
    if (ctx.state !== "running") return;
    const notes = Array.from(synthState.heldNotes).sort((a, b) => a - b);
    if (!notes.length) {
      if (synthState.arp.activeVoice) {
        releaseVoice(synthState.arp.activeVoice);
        synthState.arp.activeVoice = null;
      }
      return;
    }

    const next = notes[synthState.arp.index % notes.length];
    synthState.arp.index = (synthState.arp.index + 1) % 1_000_000;

    if (synthState.arp.activeVoice) {
      releaseVoice(synthState.arp.activeVoice);
      synthState.arp.activeVoice = null;
    }

    const voice = createSynthVoice(next, 0.85);
    synthState.arp.activeVoice = voice;
    const gate = clamp(0.12 + (1 / clamp(synthState.arp.rate, 1, 24)) * 0.08, 0.06, 0.22);
    releaseVoice(voice, ctx.currentTime + gate);
  };

  const intervalMs = Math.round(1000 / clamp(synthState.arp.rate, 1, 24));
  synthState.arp.timerId = setInterval(tick, intervalMs);
  tick();
}

function ensureSynthGraph() {
  if (synthState.audioCtx) return;

  const ctx = new (window.AudioContext || window.webkitAudioContext)();
  synthState.audioCtx = ctx;

  const voiceBus = ctx.createGain();
  voiceBus.gain.value = 0.9;

  const filter = ctx.createBiquadFilter();
  filter.type = "lowpass";
  filter.frequency.value = 1800;
  filter.Q.value = 2.2;

  const drive = ctx.createWaveShaper();
  drive.curve = makeDriveCurve(0.12);
  drive.oversample = "4x";

  const dryGain = ctx.createGain();
  dryGain.gain.value = 0.92;

  const delay = ctx.createDelay(1.0);
  delay.delayTime.value = 0.24;

  const delayFeedback = ctx.createGain();
  delayFeedback.gain.value = 0.32;

  const wetGain = ctx.createGain();
  wetGain.gain.value = 0.18;

  const master = ctx.createGain();
  master.gain.value = 0.85;

  voiceBus.connect(filter);
  filter.connect(drive);

  drive.connect(dryGain);
  dryGain.connect(master);

  drive.connect(delay);
  delay.connect(delayFeedback);
  delayFeedback.connect(delay);
  delay.connect(wetGain);
  wetGain.connect(master);

  const analyser = ctx.createAnalyser();
  analyser.fftSize = 2048;
  analyser.smoothingTimeConstant = 0.82;

  master.connect(analyser);
  analyser.connect(ctx.destination);

  const splitter = ctx.createChannelSplitter(2);
  master.connect(splitter);

  const analyserL = ctx.createAnalyser();
  const analyserR = ctx.createAnalyser();
  analyserL.fftSize = 2048;
  analyserR.fftSize = 2048;
  splitter.connect(analyserL, 0);
  splitter.connect(analyserR, 1);

  const lfo = ctx.createOscillator();
  lfo.type = "sine";
  lfo.frequency.value = 2.5;
  const lfoGain = ctx.createGain();
  lfoGain.gain.value = 320;
  lfo.connect(lfoGain);
  lfoGain.connect(filter.frequency);
  lfo.start();

  synthState.voiceBus = voiceBus;
  synthState.filter = filter;
  synthState.drive = drive;
  synthState.delay = delay;
  synthState.delayFeedback = delayFeedback;
  synthState.dryGain = dryGain;
  synthState.wetGain = wetGain;
  synthState.master = master;
  synthState.analyser = analyser;
  synthState.splitter = splitter;
  synthState.analyserL = analyserL;
  synthState.analyserR = analyserR;
  synthState.lfo = lfo;
  synthState.lfoGain = lfoGain;

  synthState.vis.timeData = new Uint8Array(analyser.fftSize);
  synthState.vis.freqData = new Uint8Array(analyser.frequencyBinCount);
  synthState.vis.timeL = new Uint8Array(analyserL.fftSize);
  synthState.vis.timeR = new Uint8Array(analyserR.fftSize);

  updateSynthUi();
}

function applySynthParams() {
  if (!synthState.audioCtx) return;
  const now = synthState.audioCtx.currentTime;

  const cutoff = Number(synthState.ui.cutoff?.value || 1800);
  const res = Number(synthState.ui.res?.value || 2.2);
  synthState.filter?.frequency.setTargetAtTime(clamp(cutoff, 80, 20000), now, 0.015);
  synthState.filter?.Q.setTargetAtTime(clamp(res, 0.1, 24), now, 0.015);

  const drive = Number(synthState.ui.drive?.value || 0.12);
  if (synthState.drive) synthState.drive.curve = makeDriveCurve(drive);

  const mix = clamp(Number(synthState.ui.delayMix?.value || 0.18), 0, 1);
  if (synthState.wetGain) synthState.wetGain.gain.setTargetAtTime(mix, now, 0.02);
  if (synthState.dryGain) synthState.dryGain.gain.setTargetAtTime(0.95 - mix * 0.6, now, 0.02);

  const lfoRate = Number(synthState.ui.lfoRate?.value || 2.5);
  if (synthState.lfo) synthState.lfo.frequency.setTargetAtTime(clamp(lfoRate, 0, 30), now, 0.02);

  const arpEnabled = Boolean(synthState.ui.arpToggle?.checked);
  const arpRate = Number(synthState.ui.arpRate?.value || 8);
  synthState.arp.enabled = arpEnabled;
  synthState.arp.rate = clamp(arpRate, 1, 24);
  if (arpEnabled) startSynthArp();
  else stopSynthArp();
}

function createSynthVoice(note, velocity = 0.9) {
  ensureSynthGraph();
  const ctx = synthState.audioCtx;
  const wave = synthState.ui.wave?.value || "sawtooth";
  const attack = clamp(Number(synthState.ui.attack?.value || 0.01), 0.001, 2.0);
  const vel = clamp(velocity, 0.05, 1);

  const amp = ctx.createGain();
  amp.gain.value = 0;

  const panner = typeof ctx.createStereoPanner === "function" ? ctx.createStereoPanner() : null;
  if (panner) panner.pan.value = (Math.random() * 2 - 1) * 0.18;

  const osc1 = ctx.createOscillator();
  osc1.type = wave;
  osc1.frequency.value = midiToFreq(note);
  osc1.detune.value = -7;

  const osc2 = ctx.createOscillator();
  osc2.type = wave;
  osc2.frequency.value = midiToFreq(note);
  osc2.detune.value = 7;

  const sub = ctx.createOscillator();
  sub.type = "sine";
  sub.frequency.value = midiToFreq(note) / 2;

  const mix = ctx.createGain();
  mix.gain.value = 0.62;
  const subGain = ctx.createGain();
  subGain.gain.value = 0.12;

  osc1.connect(mix);
  osc2.connect(mix);
  sub.connect(subGain);
  mix.connect(amp);
  subGain.connect(amp);
  if (panner) {
    amp.connect(panner);
    panner.connect(synthState.voiceBus);
  } else {
    amp.connect(synthState.voiceBus);
  }

  const now = ctx.currentTime;
  amp.gain.cancelScheduledValues(now);
  amp.gain.setValueAtTime(0.0001, now);
  amp.gain.linearRampToValueAtTime(vel, now + attack);

  osc1.start();
  osc2.start();
  sub.start();

  return { note, amp, panner, osc1, osc2, sub, startedAt: now };
}

async function startSynthFromGesture() {
  ensureSynthGraph();
  pauseAllAudio({ except: { synth: true } });
  await synthState.audioCtx.resume();
  applySynthParams();
  startSynthVisuals();
  updateSynthUi();
}

function noteOn(note, velocity) {
  if (synthState.arp.enabled) {
    synthState.heldNotes.add(note);
    setKeyVisual(note, true);
    startSynthFromGesture().catch(() => {});
    return;
  }

  startSynthFromGesture().then(() => {
    const existing = synthState.voices.get(note);
    if (existing) return;

    const maxVoices = 10;
    if (synthState.voiceOrder.length >= maxVoices) {
      const steal = synthState.voiceOrder.shift();
      if (typeof steal === "number") {
        const v = synthState.voices.get(steal);
        if (v) releaseVoice(v);
        synthState.voices.delete(steal);
        setKeyVisual(steal, false);
      }
    }

    const voice = createSynthVoice(note, velocity);
    synthState.voices.set(note, voice);
    synthState.voiceOrder.push(note);
    setKeyVisual(note, true);
  }).catch(() => {});
}

function noteOff(note) {
  if (synthState.arp.enabled) {
    synthState.heldNotes.delete(note);
    setKeyVisual(note, false);
    return;
  }
  const voice = synthState.voices.get(note);
  if (!voice) return;
  releaseVoice(voice);
  synthState.voices.delete(note);
  synthState.voiceOrder = synthState.voiceOrder.filter((n) => n !== note);
  setKeyVisual(note, false);
}

function randomizeSynth() {
  if (!synthState.ui.wave) return;
  const waves = ["sawtooth", "square", "triangle", "sine"];
  synthState.ui.wave.value = waves[Math.floor(Math.random() * waves.length)];
  if (synthState.ui.cutoff) synthState.ui.cutoff.value = String(Math.round(200 + Math.random() * 9000));
  if (synthState.ui.res) synthState.ui.res.value = String((0.8 + Math.random() * 8).toFixed(1));
  if (synthState.ui.attack) synthState.ui.attack.value = String((0.005 + Math.random() * 0.08).toFixed(3));
  if (synthState.ui.release) synthState.ui.release.value = String((0.08 + Math.random() * 1.2).toFixed(2));
  if (synthState.ui.drive) synthState.ui.drive.value = String((Math.random() * 0.45).toFixed(2));
  if (synthState.ui.delayMix) synthState.ui.delayMix.value = String((Math.random() * 0.45).toFixed(2));
  if (synthState.ui.lfoRate) synthState.ui.lfoRate.value = String((Math.random() * 7).toFixed(1));
  applySynthParams();
}

function resizeCanvas(canvas) {
  const rect = canvas.getBoundingClientRect();
  const dpr = window.devicePixelRatio || 1;
  const width = Math.max(1, Math.floor(rect.width * dpr));
  const height = Math.max(1, Math.floor(rect.height * dpr));
  if (canvas.width !== width || canvas.height !== height) {
    canvas.width = width;
    canvas.height = height;
  }
  return { width, height, dpr };
}

function setSynthVisMode(mode) {
  synthState.vis.mode = mode;
  if (synthState.ui.tabs) {
    synthState.ui.tabs.forEach((btn) => {
      btn.classList.toggle("is-active", btn.dataset.vis === mode);
    });
  }
  if (synthState.ui.canvases) {
    synthState.ui.canvases.forEach((canvas) => {
      canvas.classList.toggle("is-active", canvas.dataset.visCanvas === mode);
    });
  }
  if (mode === "spectrogram") {
    const canvas = synthState.ui.canvases?.find((c) => c.dataset.visCanvas === "spectrogram");
    const ctx = canvas?.getContext("2d");
    if (canvas && ctx) {
      const { width, height } = resizeCanvas(canvas);
      ctx.clearRect(0, 0, width, height);
    }
  }
}

function drawScope(ctx2d, canvas, analyser) {
  if (!synthState.vis.timeData) return;
  analyser.getByteTimeDomainData(synthState.vis.timeData);
  const { width, height } = resizeCanvas(canvas);
  ctx2d.clearRect(0, 0, width, height);

  ctx2d.lineWidth = 2;
  ctx2d.strokeStyle = "rgba(72, 255, 179, 0.9)";
  ctx2d.beginPath();
  const data = synthState.vis.timeData;
  for (let i = 0; i < data.length; i += 1) {
    const x = (i / (data.length - 1)) * width;
    const y = (data[i] / 255) * height;
    if (i === 0) ctx2d.moveTo(x, y);
    else ctx2d.lineTo(x, y);
  }
  ctx2d.stroke();

  ctx2d.strokeStyle = "rgba(130, 120, 255, 0.45)";
  ctx2d.lineWidth = 1;
  ctx2d.beginPath();
  ctx2d.moveTo(0, height / 2);
  ctx2d.lineTo(width, height / 2);
  ctx2d.stroke();
}

function drawSpectrum(ctx2d, canvas, analyser) {
  if (!synthState.vis.freqData) return;
  analyser.getByteFrequencyData(synthState.vis.freqData);
  const { width, height } = resizeCanvas(canvas);
  ctx2d.clearRect(0, 0, width, height);

  const bars = 72;
  const data = synthState.vis.freqData;
  const step = Math.max(1, Math.floor(data.length / bars));
  const barW = width / bars;

  for (let i = 0; i < bars; i += 1) {
    let sum = 0;
    for (let j = 0; j < step; j += 1) sum += data[i * step + j] || 0;
    const v = sum / step;
    const h = (v / 255) * height;
    const x = i * barW;
    const y = height - h;
    ctx2d.fillStyle = `rgba(${Math.round(72 + (i / bars) * 180)}, ${Math.round(220 - (i / bars) * 80)}, 255, 0.85)`;
    ctx2d.fillRect(x + 1, y, Math.max(1, barW - 2), h);
  }
}

function drawSpectrogram(ctx2d, canvas, analyser) {
  if (!synthState.vis.freqData) return;
  analyser.getByteFrequencyData(synthState.vis.freqData);
  const { width, height } = resizeCanvas(canvas);

  ctx2d.drawImage(canvas, -1, 0);
  const x = width - 1;
  const data = synthState.vis.freqData;
  for (let y = 0; y < height; y += 1) {
    const idx = Math.floor((1 - y / height) * (data.length - 1));
    const v = data[idx] / 255;
    const r = Math.round(20 + v * 220);
    const g = Math.round(30 + v * 240);
    const b = Math.round(60 + (1 - v) * 120);
    ctx2d.fillStyle = `rgb(${r},${g},${b})`;
    ctx2d.fillRect(x, y, 1, 1);
  }
}

function drawVectorscope(ctx2d, canvas) {
  if (!synthState.analyserL || !synthState.analyserR || !synthState.vis.timeL || !synthState.vis.timeR) return;
  synthState.analyserL.getByteTimeDomainData(synthState.vis.timeL);
  synthState.analyserR.getByteTimeDomainData(synthState.vis.timeR);
  const { width, height } = resizeCanvas(canvas);
  ctx2d.clearRect(0, 0, width, height);

  const cx = width / 2;
  const cy = height / 2;
  const scale = Math.min(width, height) * 0.42;

  ctx2d.strokeStyle = "rgba(255,255,255,0.12)";
  ctx2d.lineWidth = 1;
  ctx2d.beginPath();
  ctx2d.arc(cx, cy, scale, 0, Math.PI * 2);
  ctx2d.stroke();

  ctx2d.fillStyle = "rgba(72, 255, 179, 0.55)";
  const n = Math.min(synthState.vis.timeL.length, synthState.vis.timeR.length);
  for (let i = 0; i < n; i += 2) {
    const lx = (synthState.vis.timeL[i] - 128) / 128;
    const ry = (synthState.vis.timeR[i] - 128) / 128;
    const x = cx + lx * scale;
    const y = cy - ry * scale;
    ctx2d.fillRect(x, y, 2, 2);
  }
}

function startSynthVisuals() {
  if (synthState.vis.rafId) return;
  const draw = () => {
    if (!synthState.audioCtx || synthState.audioCtx.state !== "running" || !synthState.analyser) {
      synthState.vis.rafId = 0;
      return;
    }

    const mode = synthState.vis.mode;
    const canvas = synthState.ui.canvases?.find((c) => c.dataset.visCanvas === mode);
    if (!canvas) {
      synthState.vis.rafId = requestAnimationFrame(draw);
      return;
    }
    const ctx2d = canvas.getContext("2d");
    if (!ctx2d) {
      synthState.vis.rafId = requestAnimationFrame(draw);
      return;
    }

    if (mode === "scope") drawScope(ctx2d, canvas, synthState.analyser);
    else if (mode === "spectrum") drawSpectrum(ctx2d, canvas, synthState.analyser);
    else if (mode === "spectrogram") drawSpectrogram(ctx2d, canvas, synthState.analyser);
    else if (mode === "vectorscope") drawVectorscope(ctx2d, canvas);

    synthState.vis.rafId = requestAnimationFrame(draw);
  };
  synthState.vis.rafId = requestAnimationFrame(draw);
}

function stopSynthVisuals() {
  if (!synthState.vis.rafId) return;
  cancelAnimationFrame(synthState.vis.rafId);
  synthState.vis.rafId = 0;
}

function initInteractiveSynth() {
  synthState.ui.root = document.getElementById("interactiveSynth");
  if (!synthState.ui.root) return;

  synthState.ui.startBtn = document.getElementById("synthStart");
  synthState.ui.stopBtn = document.getElementById("synthStop");
  synthState.ui.randomBtn = document.getElementById("synthRandom");
  synthState.ui.wave = document.getElementById("synthWave");
  synthState.ui.cutoff = document.getElementById("synthCutoff");
  synthState.ui.res = document.getElementById("synthRes");
  synthState.ui.attack = document.getElementById("synthAttack");
  synthState.ui.release = document.getElementById("synthRelease");
  synthState.ui.drive = document.getElementById("synthDrive");
  synthState.ui.delayMix = document.getElementById("synthDelayMix");
  synthState.ui.lfoRate = document.getElementById("synthLfoRate");
  synthState.ui.arpToggle = document.getElementById("synthArp");
  synthState.ui.arpRate = document.getElementById("synthArpRate");
  synthState.ui.keysWrap = document.getElementById("synthKeys");
  synthState.ui.tabs = Array.from(document.querySelectorAll(".synth-tab"));
  synthState.ui.canvases = Array.from(document.querySelectorAll(".synth-canvas"));

  setSynthVisMode("scope");

  const wireParam = (el) => el?.addEventListener("input", () => applySynthParams());
  wireParam(synthState.ui.wave);
  wireParam(synthState.ui.cutoff);
  wireParam(synthState.ui.res);
  wireParam(synthState.ui.attack);
  wireParam(synthState.ui.release);
  wireParam(synthState.ui.drive);
  wireParam(synthState.ui.delayMix);
  wireParam(synthState.ui.lfoRate);
  wireParam(synthState.ui.arpToggle);
  wireParam(synthState.ui.arpRate);

  synthState.ui.startBtn?.addEventListener("click", () => {
    startSynthFromGesture().catch((err) => console.error(err));
  });

  synthState.ui.stopBtn?.addEventListener("click", () => {
    pauseSynth();
    stopSynthVisuals();
  });

  synthState.ui.randomBtn?.addEventListener("click", () => {
    ensureSynthGraph();
    randomizeSynth();
  });

  synthState.ui.tabs?.forEach((btn) => {
    btn.addEventListener("click", () => {
      const mode = btn.dataset.vis;
      if (!mode) return;
      setSynthVisMode(mode);
    });
  });

  const noteFromKey = (key) => {
    const base = 60 + synthState.keyboard.octave * 12;
    const map = {
      a: 0, w: 1, s: 2, e: 3, d: 4, f: 5, t: 6, g: 7, y: 8, h: 9, u: 10, j: 11,
      k: 12, o: 13, l: 14, p: 15, ";": 16
    };
    if (key === "z") return "oct-down";
    if (key === "x") return "oct-up";
    if (!(key in map)) return null;
    return base + map[key];
  };

  document.addEventListener("keydown", (event) => {
    if (event.repeat) return;
    if (event.target && (event.target.tagName === "INPUT" || event.target.tagName === "SELECT" || event.target.isContentEditable)) {
      return;
    }

    const k = event.key.toLowerCase();
    const mapped = noteFromKey(k);
    if (mapped === "oct-down") {
      synthState.keyboard.octave = clamp(synthState.keyboard.octave - 1, -2, 2);
      return;
    }
    if (mapped === "oct-up") {
      synthState.keyboard.octave = clamp(synthState.keyboard.octave + 1, -2, 2);
      return;
    }
    if (typeof mapped !== "number") return;
    if (synthState.keyboard.down.has(k)) return;
    synthState.keyboard.down.add(k);
    noteOn(mapped, 0.9);
    event.preventDefault();
  });

  document.addEventListener("keyup", (event) => {
    const k = event.key.toLowerCase();
    const mapped = noteFromKey(k);
    if (typeof mapped !== "number") return;
    synthState.keyboard.down.delete(k);
    noteOff(mapped);
  });

  const downByPointerId = new Map();
  const keys = synthState.ui.keysWrap?.querySelectorAll("[data-note]");
  keys?.forEach((btn) => {
    const note = Number(btn.getAttribute("data-note"));
    if (!Number.isFinite(note)) return;

    btn.addEventListener("pointerdown", (event) => {
      downByPointerId.set(event.pointerId, note);
      btn.setPointerCapture(event.pointerId);
      noteOn(note, 0.95);
    });

    const end = (event) => {
      const n = downByPointerId.get(event.pointerId);
      if (typeof n !== "number") return;
      downByPointerId.delete(event.pointerId);
      noteOff(n);
      try { btn.releasePointerCapture(event.pointerId); } catch (_) {}
    };
    btn.addEventListener("pointerup", end);
    btn.addEventListener("pointercancel", end);
  });

  window.addEventListener("resize", () => {
    synthState.ui.canvases?.forEach((c) => {
      const ctx2d = c.getContext("2d");
      if (!ctx2d) return;
      const { width, height } = resizeCanvas(c);
      ctx2d.clearRect(0, 0, width, height);
    });
  });

  updateSynthUi();
}

function createEventInstance() {
  if (!eventDesc) throw new Error("Event description is not ready.");
  const instOut = { val: 0 };
  check(eventDesc.createInstance(instOut), "createInstance");
  eventInstance = instOut.val;
  if (!eventInstance) throw new Error("createInstance returned 0 handle.");
  check(eventInstance.start(), "eventInstance.start");
  isPaused = false;
  pauseAllAudio({ except: { fmod: true } });
  applyParameters();
  setupAnalyzer();
}

async function fetchAndDecodeAudio(ctx, url) {
  const res = await fetch(url, { cache: "no-store" });
  if (!res.ok) throw new Error(`HTTP ${res.status} fetching ${url}`);
  const data = await res.arrayBuffer();
  return await ctx.decodeAudioData(data);
}

function stopAbSources() {
  if (abState.sourceA) {
    try { abState.sourceA.stop(); } catch (_) {}
  }
  if (abState.sourceB) {
    try { abState.sourceB.stop(); } catch (_) {}
  }
  abState.sourceA = null;
  abState.sourceB = null;
  abState.gainA = null;
  abState.gainB = null;
  abState.masterGain = null;
}

function applyAbSwitch(currentTime, force) {
  if (!abState.gainA || !abState.gainB || !abState.audioCtx) return;
  const shouldB = currentTime >= abState.switchTime;
  if (!force && abState.activeB === shouldB) return;

  const now = abState.audioCtx.currentTime;
  abState.gainA.gain.cancelScheduledValues(now);
  abState.gainB.gain.cancelScheduledValues(now);
  abState.gainA.gain.setValueAtTime(abState.gainA.gain.value, now);
  abState.gainB.gain.setValueAtTime(abState.gainB.gain.value, now);
  abState.gainA.gain.linearRampToValueAtTime(shouldB ? 0 : 1, now + AB_CROSSFADE_SECONDS);
  abState.gainB.gain.linearRampToValueAtTime(shouldB ? 1 : 0, now + AB_CROSSFADE_SECONDS);
  abState.activeB = shouldB;
}

function updateAbPlayhead(currentTime) {
  if (!abState.wrap || !abState.duration) return;
  const pct = Math.max(0, Math.min(1, currentTime / abState.duration)) * 100;
  abState.wrap.style.setProperty("--playhead-pct", pct.toFixed(2));
  if (abState.playheadHandle) {
    abState.playheadHandle.setAttribute("aria-valuenow", Math.round(pct).toString());
  }
}

function setAbSwitchPct(pct, force) {
  if (!abState.wrap) return;
  const clamped = Math.max(0, Math.min(100, pct));
  abState.switchPct = clamped;
  abState.switchTime = (abState.duration || 0) * (clamped / 100);
  abState.wrap.style.setProperty("--split-pct", clamped.toFixed(2));
  if (abState.handle) abState.handle.setAttribute("aria-valuenow", Math.round(clamped).toString());
  if (abState.isPlaying) {
    const current = abState.audioCtx ? abState.audioCtx.currentTime - abState.startTime : abState.offset;
    applyAbSwitch(current, force);
  }
}

function drawAbWaveform() {
  if (!abState.canvas || !abState.ctx || !abState.bufferA) return;
  const rect = abState.wrap.getBoundingClientRect();
  const dpr = window.devicePixelRatio || 1;
  const width = Math.max(1, Math.floor(rect.width * dpr));
  const height = Math.max(1, Math.floor(rect.height * dpr));
  if (abState.canvas.width !== width || abState.canvas.height !== height) {
    abState.canvas.width = width;
    abState.canvas.height = height;
  }
  abState.ctx.setTransform(dpr, 0, 0, dpr, 0, 0);

  const pixelWidth = Math.floor(rect.width);
  if (!abState.peaks || abState.lastWidth !== pixelWidth) {
    const data = abState.bufferA.getChannelData(0);
    const block = Math.max(1, Math.floor(data.length / pixelWidth));
    abState.peaks = new Float32Array(pixelWidth);
    for (let i = 0; i < pixelWidth; i += 1) {
      const start = i * block;
      const end = Math.min(start + block, data.length);
      let max = 0;
      for (let j = start; j < end; j += 1) {
        const v = Math.abs(data[j]);
        if (v > max) max = v;
      }
      abState.peaks[i] = max;
    }
    abState.lastWidth = pixelWidth;
  }

  const mid = rect.height / 2;
  const amp = rect.height * 0.45;
  abState.ctx.clearRect(0, 0, rect.width, rect.height);
  abState.ctx.strokeStyle = "rgba(255, 255, 255, 0.85)";
  abState.ctx.lineWidth = 1.5;
  abState.ctx.beginPath();
  for (let x = 0; x < abState.peaks.length; x += 1) {
    const y = mid - abState.peaks[x] * amp;
    if (x === 0) {
      abState.ctx.moveTo(x, y);
    } else {
      abState.ctx.lineTo(x, y);
    }
  }
  for (let x = abState.peaks.length - 1; x >= 0; x -= 1) {
    const y = mid + abState.peaks[x] * amp;
    abState.ctx.lineTo(x, y);
  }
  abState.ctx.closePath();
  abState.ctx.stroke();
}

function startAbPlayback(offset) {
  if (!abState.audioCtx || !abState.bufferA || !abState.bufferB) return;
  stopAbSources();
  abState.sourceA = abState.audioCtx.createBufferSource();
  abState.sourceB = abState.audioCtx.createBufferSource();
  abState.gainA = abState.audioCtx.createGain();
  abState.gainB = abState.audioCtx.createGain();
  abState.masterGain = abState.audioCtx.createGain();
  abState.sourceA.buffer = abState.bufferA;
  abState.sourceB.buffer = abState.bufferB;
  abState.sourceA.loop = true;
  abState.sourceB.loop = true;
  abState.sourceA.loopStart = 0;
  abState.sourceB.loopStart = 0;
  abState.sourceA.loopEnd = abState.duration;
  abState.sourceB.loopEnd = abState.duration;
  abState.sourceA.connect(abState.gainA).connect(abState.masterGain).connect(abState.audioCtx.destination);
  abState.sourceB.connect(abState.gainB).connect(abState.masterGain).connect(abState.audioCtx.destination);
  const now = abState.audioCtx.currentTime;
  abState.masterGain.gain.setValueAtTime(0, now);
  abState.masterGain.gain.linearRampToValueAtTime(1, now + AB_FADE_SECONDS);
  abState.sourceA.start(0, offset);
  abState.sourceB.start(0, offset);
  abState.startTime = abState.audioCtx.currentTime - offset;
  abState.isPlaying = true;
  abState.activeB = null;
  applyAbSwitch(offset, true);
}

function updateAbLoop() {
  if (!abState.isPlaying || !abState.audioCtx) return;
  const elapsed = abState.audioCtx.currentTime - abState.startTime;
  const current = abState.duration ? (elapsed % abState.duration) : 0;
  updateAbPlayhead(current);
  applyAbSwitch(current, false);
  abState.rafId = requestAnimationFrame(updateAbLoop);
}

function fadeOutAndStop() {
  if (!abState.audioCtx || !abState.masterGain) {
    stopAbSources();
    return;
  }
  const now = abState.audioCtx.currentTime;
  abState.masterGain.gain.cancelScheduledValues(now);
  abState.masterGain.gain.setValueAtTime(abState.masterGain.gain.value, now);
  abState.masterGain.gain.linearRampToValueAtTime(0, now + AB_FADE_SECONDS);
  const stopTime = now + AB_FADE_SECONDS;
  if (abState.sourceA) {
    try { abState.sourceA.stop(stopTime); } catch (_) {}
  }
  if (abState.sourceB) {
    try { abState.sourceB.stop(stopTime); } catch (_) {}
  }
  setTimeout(() => {
    stopAbSources();
  }, Math.ceil((AB_FADE_SECONDS + 0.02) * 1000));
}

function seekAbTo(time) {
  abState.offset = Math.max(0, Math.min(abState.duration, time));
  if (abState.isPlaying) {
    startAbPlayback(abState.offset);
    updateAbLoop();
  } else {
    updateAbPlayhead(abState.offset);
  }
}

async function initAbPlayer() {
  abState.wrap = document.getElementById("abWaveformWrap");
  abState.canvas = document.getElementById("abWaveform");
  abState.handle = document.getElementById("abSwitchHandle");
  abState.playheadHandle = document.getElementById("abPlayheadHandle");
  abState.status = document.getElementById("abStatus");
  abState.playBtn = document.getElementById("abPlayPause");
  if (!abState.wrap || !abState.canvas || !abState.handle) return;

  abState.ctx = abState.canvas.getContext("2d");
  setAbSwitchPct(AB_SWITCH_DEFAULT, true);

  abState.audioCtx = new (window.AudioContext || window.webkitAudioContext)();
  try {
    const [bufferA, bufferB] = await Promise.all([
      fetchAndDecodeAudio(abState.audioCtx, AB_FILES.original),
      fetchAndDecodeAudio(abState.audioCtx, AB_FILES.restored)
    ]);
    abState.bufferA = bufferA;
    abState.bufferB = bufferB;
    abState.duration = Math.min(bufferA.duration, bufferB.duration);
    abState.switchTime = abState.duration * (abState.switchPct / 100);
    drawAbWaveform();
    window.addEventListener("resize", drawAbWaveform);
    if (abState.status) abState.status.textContent = "A/B audio ready";
    if (abState.playBtn) abState.playBtn.disabled = false;
  } catch (err) {
    console.error(err);
    if (abState.status) abState.status.textContent = "A/B audio failed to load";
    return;
  }

  abState.playBtn?.addEventListener("click", async () => {
    if (!abState.audioCtx) return;
    await abState.audioCtx.resume();
    if (!abState.isPlaying) {
      pauseAllAudio({ except: { ab: true } });
      startAbPlayback(abState.offset);
      updateAbLoop();
      abState.playBtn.textContent = "Pause";
      return;
    }
    pauseAbPlayback();
  });

  const updateSwitchFromPointer = (event) => {
    const rect = abState.wrap.getBoundingClientRect();
    const pct = ((event.clientX - rect.left) / rect.width) * 100;
    setAbSwitchPct(pct, true);
  };

  abState.handle.addEventListener("pointerdown", (event) => {
    abState.dragging = true;
    abState.handle.setPointerCapture(event.pointerId);
    updateSwitchFromPointer(event);
  });

  abState.handle.addEventListener("pointermove", (event) => {
    if (!abState.dragging) return;
    updateSwitchFromPointer(event);
  });

  const stopDrag = (event) => {
    if (!abState.dragging) return;
    abState.dragging = false;
    abState.handle.releasePointerCapture(event.pointerId);
  };

  abState.handle.addEventListener("pointerup", stopDrag);
  abState.handle.addEventListener("pointercancel", stopDrag);

  abState.handle.addEventListener("keydown", (event) => {
    if (event.key === "ArrowLeft") {
      setAbSwitchPct(abState.switchPct - 1, true);
      event.preventDefault();
    } else if (event.key === "ArrowRight") {
      setAbSwitchPct(abState.switchPct + 1, true);
      event.preventDefault();
    }
  });

  const updatePlayheadFromPointer = (event) => {
    const rect = abState.wrap.getBoundingClientRect();
    const pct = ((event.clientX - rect.left) / rect.width);
    if (Number.isNaN(pct)) return;
    const time = Math.max(0, Math.min(1, pct)) * abState.duration;
    updateAbPlayhead(time);
    abState.offset = time;
  };

  abState.playheadHandle?.addEventListener("pointerdown", (event) => {
    abState.draggingPlayhead = true;
    abState.wasPlayingBeforeDrag = abState.isPlaying;
    if (abState.isPlaying) {
      abState.offset = Math.min(
        abState.duration,
        Math.max(0, abState.audioCtx.currentTime - abState.startTime + AB_FADE_SECONDS)
      );
      abState.isPlaying = false;
      fadeOutAndStop();
    }
    abState.playheadHandle.setPointerCapture(event.pointerId);
    updatePlayheadFromPointer(event);
  });

  abState.playheadHandle?.addEventListener("pointermove", (event) => {
    if (!abState.draggingPlayhead) return;
    updatePlayheadFromPointer(event);
  });

  const stopPlayheadDrag = (event) => {
    if (!abState.draggingPlayhead) return;
    abState.draggingPlayhead = false;
    abState.playheadHandle.releasePointerCapture(event.pointerId);
    if (abState.wasPlayingBeforeDrag) {
      pauseAllAudio({ except: { ab: true } });
      startAbPlayback(abState.offset);
      updateAbLoop();
      if (abState.playBtn) abState.playBtn.textContent = "Pause";
    } else {
      if (abState.playBtn) abState.playBtn.textContent = "Play";
    }
  };

  abState.playheadHandle?.addEventListener("pointerup", stopPlayheadDrag);
  abState.playheadHandle?.addEventListener("pointercancel", stopPlayheadDrag);

  abState.playheadHandle?.addEventListener("keydown", (event) => {
    if (event.key === "ArrowLeft") {
      updateAbPlayhead(Math.max(0, abState.offset - abState.duration * 0.01));
      abState.offset = Math.max(0, abState.offset - abState.duration * 0.01);
      event.preventDefault();
    } else if (event.key === "ArrowRight") {
      updateAbPlayhead(Math.min(abState.duration, abState.offset + abState.duration * 0.01));
      abState.offset = Math.min(abState.duration, abState.offset + abState.duration * 0.01);
      event.preventDefault();
    }
  });
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
  const soundCloudFrames = document.querySelectorAll('iframe[src*="w.soundcloud.com/player"]');

  if (!startBtn) console.warn('Missing button with id="startAudio"');

  audioUi.toggleBtn = toggleBtn;

  const initSoundCloudWidgets = () => {
    if (!window.SC || !window.SC.Widget) return false;
    soundCloudWidgets = Array.from(soundCloudFrames, (frame) => {
      const widget = window.SC.Widget(frame);
      widget.bind(window.SC.Widget.Events.PLAY, () => {
        pauseAllAudio({ except: { soundcloud: true } });
      });
      return widget;
    });
    return true;
  };

  if (!initSoundCloudWidgets() && soundCloudFrames.length) {
    let tries = 0;
    const timer = setInterval(() => {
      tries += 1;
      if (initSoundCloudWidgets() || tries > 20) clearInterval(timer);
    }, 150);
  }

  document.addEventListener("play", (event) => {
    const target = event.target;
    if (target instanceof HTMLMediaElement) {
      pauseAllAudio({ except: { media: target } });
    }
  }, true);

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

  if (startBtn) {
    startBtn.addEventListener("click", () => {
      startFMOD().then(() => {
        pauseAllAudio({ except: { fmod: true } });
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
  }

  if (toggleBtn) {
    toggleBtn.addEventListener("click", () => {
      if (!eventInstance) return;
      const nextPaused = !isPaused;
      if (!nextPaused) pauseAllAudio({ except: { fmod: true } });
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

  initAbPlayer();
  initInteractiveSynth();
});
