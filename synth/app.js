// Edward Jarvis Synthesizer - UI Controller

const synth = new SynthEngine();

// ===================== LOG-FREQUENCY HELPERS =====================
// Map a 0-1000 slider position to a frequency (log scale)
function sliderToFreq(pos, fMin, fMax) {
  return fMin * Math.pow(fMax / fMin, pos / 1000);
}
// Map a frequency back to a 0-1000 slider position
function freqToSlider(freq, fMin, fMax) {
  return Math.round(1000 * Math.log(freq / fMin) / Math.log(fMax / fMin));
}

function fmtFreq(v) {
  return v >= 1000 ? `${(v / 1000).toFixed(1)}kHz` : `${Math.round(v)} Hz`;
}

// ===================== MIDI PLAYER =====================
const midiUi = {
  file: document.getElementById('midi-file'),
  play: document.getElementById('midi-play'),
  reset: document.getElementById('midi-reset'),
  status: document.getElementById('midi-status'),
};

const midiState = {
  fileName: '',
  events: [],
  durationSec: 0,
  isPlaying: false,
  positionSec: 0,
  startCtxTime: 0,
  timerId: 0,
  timeouts: [],
  nextIndex: 0,
  activeNotes: new Set(),
};

function formatTime(sec) {
  const s = Math.max(0, sec);
  const m = Math.floor(s / 60);
  const r = Math.floor(s % 60);
  return `${m}:${String(r).padStart(2, '0')}`;
}

function setMidiStatus(msg) {
  if (midiUi.status) midiUi.status.textContent = msg || '';
}

function readU32BE(view, offset) { return view.getUint32(offset, false); }
function readU16BE(view, offset) { return view.getUint16(offset, false); }

function readVarLen(bytes, offset) {
  let result = 0;
  let i = 0;
  while (i < 4) {
    const b = bytes[offset + i];
    result = (result << 7) | (b & 0x7f);
    i += 1;
    if ((b & 0x80) === 0) break;
  }
  return { value: result, next: offset + i };
}

function parseMidiFile(arrayBuffer) {
  const view = new DataView(arrayBuffer);
  const bytes = new Uint8Array(arrayBuffer);

  const str = (o) => String.fromCharCode(bytes[o], bytes[o + 1], bytes[o + 2], bytes[o + 3]);
  if (str(0) !== 'MThd') throw new Error('Not a MIDI file (missing MThd).');
  const headerLen = readU32BE(view, 4);
  const format = readU16BE(view, 8);
  const ntrks = readU16BE(view, 10);
  const division = readU16BE(view, 12);
  if ((division & 0x8000) !== 0) throw new Error('SMPTE timecode MIDI not supported.');

  let offset = 8 + headerLen;
  const eventsByTick = [];
  const tempoEvents = [{ tick: 0, usPerQuarter: 500000 }];

  for (let t = 0; t < ntrks; t += 1) {
    if (str(offset) !== 'MTrk') throw new Error('Bad MIDI (missing MTrk).');
    const trackLen = readU32BE(view, offset + 4);
    let p = offset + 8;
    const end = p + trackLen;
    offset = end;

    let tick = 0;
    let runningStatus = 0;
    while (p < end) {
      const delta = readVarLen(bytes, p);
      tick += delta.value;
      p = delta.next;

      let status = bytes[p];
      if (status < 0x80) {
        // Running status
        status = runningStatus;
      } else {
        p += 1;
        runningStatus = status;
      }

      if (status === 0xff) {
        const type = bytes[p]; p += 1;
        const len = readVarLen(bytes, p);
        p = len.next;
        const dataStart = p;
        p += len.value;

        if (type === 0x51 && len.value === 3) {
          const usPerQuarter = (bytes[dataStart] << 16) | (bytes[dataStart + 1] << 8) | bytes[dataStart + 2];
          tempoEvents.push({ tick, usPerQuarter });
        }
        continue;
      }

      if (status === 0xf0 || status === 0xf7) {
        const len = readVarLen(bytes, p);
        p = len.next + len.value;
        continue;
      }

      const eventType = status & 0xf0;
      // const channel = status & 0x0f;

      if (eventType === 0x80 || eventType === 0x90) {
        const note = bytes[p]; const vel = bytes[p + 1]; p += 2;
        const on = eventType === 0x90 && vel > 0;
        eventsByTick.push({ tick, type: on ? 'on' : 'off', note, velocity: vel / 127 });
        continue;
      }

      // Skip other channel messages
      if (eventType === 0xa0 || eventType === 0xb0 || eventType === 0xe0) {
        p += 2;
        continue;
      }
      if (eventType === 0xc0 || eventType === 0xd0) {
        p += 1;
        continue;
      }
      // Unknown: try to bail safely
      break;
    }
  }

  tempoEvents.sort((a, b) => a.tick - b.tick);
  eventsByTick.sort((a, b) => a.tick - b.tick);

  let tempoIndex = 0;
  let curTempo = tempoEvents[tempoIndex];
  let nextTempo = tempoEvents[tempoIndex + 1] || null;
  let lastTick = 0;
  let curTime = 0;

  const tickToSec = (targetTick) => {
    while (nextTempo && targetTick >= nextTempo.tick) {
      const dt = nextTempo.tick - lastTick;
      curTime += (dt / division) * (curTempo.usPerQuarter / 1e6);
      lastTick = nextTempo.tick;
      tempoIndex += 1;
      curTempo = tempoEvents[tempoIndex];
      nextTempo = tempoEvents[tempoIndex + 1] || null;
    }
    const dt = targetTick - lastTick;
    return curTime + (dt / division) * (curTempo.usPerQuarter / 1e6);
  };

  const events = eventsByTick.map((e) => ({ ...e, timeSec: tickToSec(e.tick) }));
  const durationSec = events.length ? events[events.length - 1].timeSec : 0;

  return { format, division, events, durationSec };
}

function stopMidiPlayback({ resetPosition } = {}) {
  if (midiState.timerId) {
    clearInterval(midiState.timerId);
    midiState.timerId = 0;
  }
  midiState.timeouts.forEach((id) => clearTimeout(id));
  midiState.timeouts = [];

  for (const note of midiState.activeNotes) {
    try { synth.noteOff(note); } catch (_) {}
  }
  midiState.activeNotes.clear();

  midiState.isPlaying = false;
  if (resetPosition) {
    midiState.positionSec = 0;
    midiState.nextIndex = 0;
  }
  if (midiUi.play) midiUi.play.textContent = 'Play';
}

function scheduleMidiLoop() {
  if (!synth.ctx) return;
  const lookaheadSec = 0.12;
  const intervalMs = 30;

  midiState.timerId = setInterval(() => {
    if (!midiState.isPlaying || !synth.ctx) return;

    const nowCtx = synth.ctx.currentTime;
    const posNow = nowCtx - midiState.startCtxTime;
    midiState.positionSec = posNow;

    const windowEnd = posNow + lookaheadSec;
    while (midiState.nextIndex < midiState.events.length) {
      const evt = midiState.events[midiState.nextIndex];
      if (evt.timeSec > windowEnd) break;
      midiState.nextIndex += 1;

      const delayMs = Math.max(0, (evt.timeSec - posNow) * 1000);
      const id = setTimeout(() => {
        if (!midiState.isPlaying) return;
        if (evt.type === 'on') {
          synth.noteOn(evt.note);
          midiState.activeNotes.add(evt.note);
        } else {
          synth.noteOff(evt.note);
          midiState.activeNotes.delete(evt.note);
        }
      }, delayMs);
      midiState.timeouts.push(id);
    }

    if (posNow >= midiState.durationSec + 0.05) {
      stopMidiPlayback({ resetPosition: true });
      setMidiStatus(`${midiState.fileName} • done`);
    }
  }, intervalMs);
}

async function ensureSynthAudioOn() {
  if (synth.ctx && synth.ctx.state === 'running') return;
  const powerBtn = document.getElementById('power-btn');
  if (powerBtn) powerBtn.click();
}

function initMidiUi() {
  if (!midiUi.file || !midiUi.play || !midiUi.reset) return;

  // Reset file input value on click so re-selecting the same file still fires 'change'
  midiUi.file.addEventListener('click', () => { midiUi.file.value = ''; });

  midiUi.file.addEventListener('change', async () => {
    const f = midiUi.file.files && midiUi.file.files[0];
    if (!f) return;
    try {
      stopMidiPlayback({ resetPosition: true });
      const buf = await f.arrayBuffer();
      const parsed = parseMidiFile(buf);
      midiState.fileName = f.name;
      midiState.events = parsed.events;
      midiState.durationSec = parsed.durationSec;
      midiState.positionSec = 0;
      midiState.nextIndex = 0;
      midiUi.play.disabled = !midiState.events.length;
      midiUi.reset.disabled = !midiState.events.length;
      setMidiStatus(`${f.name} • ${formatTime(parsed.durationSec)}`);
    } catch (err) {
      console.error(err);
      midiState.fileName = '';
      midiState.events = [];
      midiState.durationSec = 0;
      midiUi.play.disabled = true;
      midiUi.reset.disabled = true;
      setMidiStatus('MIDI load failed');
      alert(err.message || String(err));
    }
  });

  midiUi.play.addEventListener('click', async () => {
    if (!midiState.events.length) return;
    await ensureSynthAudioOn();
    if (!synth.ctx) return;

    if (!midiState.isPlaying) {
      // Start/resume from current position
      stopMidiPlayback();
      midiState.isPlaying = true;
      midiState.startCtxTime = synth.ctx.currentTime - midiState.positionSec;
      // Seek nextIndex to current position
      let i = 0;
      while (i < midiState.events.length && midiState.events[i].timeSec < midiState.positionSec) i += 1;
      midiState.nextIndex = i;
      midiUi.play.textContent = 'Pause';
      scheduleMidiLoop();
      return;
    }

    // Pause
    midiState.positionSec = synth.ctx.currentTime - midiState.startCtxTime;
    stopMidiPlayback();
    setMidiStatus(`${midiState.fileName} • ${formatTime(midiState.positionSec)} / ${formatTime(midiState.durationSec)}`);
  });

  midiUi.reset.addEventListener('click', () => {
    stopMidiPlayback({ resetPosition: true });
    if (midiState.fileName) setMidiStatus(`${midiState.fileName} • ${formatTime(midiState.durationSec)}`);
  });
}

// ===================== PATCH CODE (SAVE/LOAD) =====================
const PATCH_PREFIX = 'EJS1.';

function _b64UrlEncode(str) {
  const b64 = btoa(unescape(encodeURIComponent(str)));
  return b64.replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/g, '');
}

function _b64UrlDecode(b64url) {
  let b64 = b64url.replace(/-/g, '+').replace(/_/g, '/');
  while (b64.length % 4) b64 += '=';
  return decodeURIComponent(escape(atob(b64)));
}

function encodePatch(patchObj) {
  const prefix = patchObj.modulation ? 'EJS2.' : PATCH_PREFIX;
  return prefix + _b64UrlEncode(JSON.stringify(patchObj));
}

function decodePatch(code) {
  const trimmed = (code || '').trim();
  if (trimmed.startsWith('EJS2.')) {
    return JSON.parse(_b64UrlDecode(trimmed.slice(5)));
  }
  if (trimmed.startsWith(PATCH_PREFIX)) {
    return JSON.parse(_b64UrlDecode(trimmed.slice(PATCH_PREFIX.length)));
  }
  throw new Error('Not an EJ patch code.');
}

// Convert legacy 3-LFO format (gain/pitch/filter) to new modulation format
function legacyLfosToModulation(lfos) {
  if (!Array.isArray(lfos) || lfos.length < 3) return [];
  const targetMap = [
    [{ targetId: 'main-gain', amount: lfos[0].strength }],
    [{ targetId: 'all-pitch', amount: lfos[1].strength / 100 }],
    [{ targetId: 'eq-lp-freq', amount: lfos[2].strength / 5000 }, { targetId: 'eq-hp-freq', amount: lfos[2].strength / 5000 }],
  ];
  return lfos.map((l, i) => ({
    enabled: l.enabled,
    waveform: l.waveform,
    mode: 'free',
    tempoSync: true,
    rateBeats: l.rateBeats,
    rateFree: 1,
    depth: 1,
    routes: targetMap[i],
    customShape: null,
  }));
}

function normalizePatch(p) {
  const patch = typeof p === 'object' && p ? p : {};
  const voices = Array.isArray(patch.voices) ? patch.voices : null;
  const lfos = Array.isArray(patch.lfos) ? patch.lfos : null;

  return {
    name: patch.name || 'Patch',
    bpm: Number.isFinite(patch.bpm) ? patch.bpm : 120,
    mainGain: Number.isFinite(patch.mainGain) ? patch.mainGain : 0.7,
    transpose: Number.isFinite(patch.transpose) ? patch.transpose : 0,
    voices: voices && voices.length === 4 ? voices : [
      { waveform: 'sine', overtone: 1, gain: 0.25 },
      { waveform: 'sawtooth', overtone: 1, gain: 0.25 },
      { waveform: 'triangle', overtone: 1, gain: 0.25 },
      { waveform: 'square', overtone: 1, gain: 0.25 },
    ],
    noise: patch.noise || { level: 0, enabled: false },
    envelope: patch.envelope || { attack: 0.01, decay: 0.1, sustain: 0.7, release: 0.3 },
    eq: patch.eq || {
      highpass: { frequency: 80, Q: 0.7, gain: 0, enabled: true },
      peak: { frequency: 1000, Q: 1, gain: 0, enabled: true },
      lowpass: { frequency: 18000, Q: 0.7, gain: 0, enabled: true },
    },
    lfos: lfos && lfos.length === 3 ? lfos : [
      { enabled: false, waveform: 'sine', rateBeats: 1, strength: 0.5 },
      { enabled: false, waveform: 'sine', rateBeats: 1, strength: 0 },
      { enabled: false, waveform: 'sine', rateBeats: 1, strength: 0 },
    ],
    modulation: patch.modulation || null,
    distortion: patch.distortion || { drive: 0, tone: 8000, mix: 0, enabled: false },
    reverb: patch.reverb || { size: 2.5, damp: 8000, mix: 0.2, enabled: false },
    comb: patch.comb || { delay: 5, feedback: 0.5, mix: 0, enabled: false },
    delay: patch.delay || { time: 0.3, feedback: 0.3, mix: 0, enabled: false },
    limiter: patch.limiter || { threshold: -3, knee: 10, enabled: true },
  };
}

function snapshotCurrentPatch() {
  return normalizePatch({
    name: 'Patch',
    bpm: parseInt(document.getElementById('bpm').value) || 120,
    mainGain: parseFloat(document.getElementById('main-gain').value),
    transpose: parseInt(document.getElementById('transpose').value) || 0,
    voices: synth.voiceConfigs.map(v => ({ ...v })),
    noise: { ...synth.noiseConfig },
    envelope: { ...synth.envelope },
    eq: JSON.parse(JSON.stringify(synth.eqConfigs)),
    lfos: synth.lfoConfigs.map(l => ({ ...l })),
    modulation: modConfigs.map(m => ({
      ...m,
      routes: m.routes.map(r => ({ ...r })),
      customShape: m.customShape ? m.customShape.map(p => ({ ...p })) : null,
    })),
    distortion: { ...synth.distortionConfig },
    reverb: { ...synth.reverbConfig },
    comb: { ...synth.combConfig },
    delay: { ...synth.delayConfig },
    limiter: { ...synth.limiterConfig },
  });
}

// ===================== PRESETS =====================
// All presets include FX blocks (noise/distortion/delay/reverb/comb) so they reflect the current synth.
const PRESETS = {
  p01: {
    name: 'Init',
    mainGain: 0.65, transpose: 0,
    voices: [
      { waveform: 'sine', overtone: 1, gain: 0.5 },
      { waveform: 'sawtooth', overtone: 1, gain: 0.3 },
      { waveform: 'triangle', overtone: 1, gain: 0.2 },
      { waveform: 'square', overtone: 1, gain: 0.12 },
    ],
    noise: { level: 0, enabled: false },
    envelope: { attack: 0.005, decay: 0.12, sustain: 0.85, release: 0.25 },
    eq: {
      highpass: { frequency: 40, Q: 0.7, gain: 0, enabled: true },
      peak: { frequency: 1000, Q: 1, gain: 0, enabled: true },
      lowpass: { frequency: 16000, Q: 0.7, gain: 0, enabled: true },
    },
    lfos: [
      { enabled: false, waveform: 'sine', rateBeats: 1, strength: 0.2 },
      { enabled: false, waveform: 'sine', rateBeats: 1, strength: 0 },
      { enabled: false, waveform: 'sine', rateBeats: 1, strength: 0 },
    ],
    distortion: { drive: 0, tone: 8000, mix: 0, enabled: false },
    reverb: { size: 2.5, damp: 8000, mix: 0.2, enabled: false },
    comb: { delay: 5, feedback: 0.5, mix: 0, enabled: false },
    delay: { time: 0.3, feedback: 0.3, mix: 0, enabled: false },
    limiter: { threshold: -3, knee: 10, enabled: true },
  },

  p02: {
    name: 'Wide Space Pad',
    mainGain: 0.45, transpose: 0,
    voices: [
      { waveform: 'sawtooth', overtone: 1, gain: 0.36 },
      { waveform: 'sawtooth', overtone: 1.006, gain: 0.34 },
      { waveform: 'sawtooth', overtone: 0.994, gain: 0.34 },
      { waveform: 'triangle', overtone: 0.5, gain: 0.22 },
    ],
    noise: { level: 0.08, enabled: true },
    envelope: { attack: 0.9, decay: 0.6, sustain: 0.86, release: 3.6 },
    eq: {
      highpass: { frequency: 140, Q: 0.7, gain: 0, enabled: true },
      peak: { frequency: 2400, Q: 0.7, gain: -2.5, enabled: true },
      lowpass: { frequency: 7000, Q: 0.9, gain: 0, enabled: true },
    },
    lfos: [
      { enabled: true, waveform: 'sine', rateBeats: 2, strength: 0.18 },
      { enabled: false, waveform: 'sine', rateBeats: 1, strength: 0 },
      { enabled: true, waveform: 'sine', rateBeats: 4, strength: 900 },
    ],
    distortion: { drive: 0.25, tone: 9000, mix: 0.15, enabled: true },
    comb: { delay: 10, feedback: 0.22, mix: 0.08, enabled: true },
    delay: { time: 0.45, feedback: 0.45, mix: 0.25, enabled: true },
    reverb: { size: 4.8, damp: 9000, mix: 0.55, enabled: true },
    limiter: { threshold: -5, knee: 10, enabled: true },
  },

  p03: {
    name: 'Reese Reactor',
    mainGain: 0.42, transpose: -12,
    voices: [
      { waveform: 'sawtooth', overtone: 1, gain: 0.45 },
      { waveform: 'sawtooth', overtone: 0.993, gain: 0.45 },
      { waveform: 'sawtooth', overtone: 1.007, gain: 0.35 },
      { waveform: 'sine', overtone: 0.5, gain: 0.35 },
    ],
    noise: { level: 0.03, enabled: true },
    envelope: { attack: 0.004, decay: 0.25, sustain: 0.85, release: 0.18 },
    eq: {
      highpass: { frequency: 28, Q: 0.7, gain: 0, enabled: true },
      peak: { frequency: 520, Q: 1.4, gain: 5.5, enabled: true },
      lowpass: { frequency: 2000, Q: 2.2, gain: 0, enabled: true },
    },
    lfos: [
      { enabled: false, waveform: 'sine', rateBeats: 1, strength: 0 },
      { enabled: false, waveform: 'sine', rateBeats: 1, strength: 0 },
      { enabled: true, waveform: 'triangle', rateBeats: 0.5, strength: 700 },
    ],
    distortion: { drive: 0.55, tone: 2500, mix: 0.5, enabled: true },
    comb: { delay: 5, feedback: 0.2, mix: 0, enabled: false },
    delay: { time: 0.12, feedback: 0.25, mix: 0.12, enabled: true },
    reverb: { size: 1.3, damp: 4500, mix: 0.18, enabled: true },
    limiter: { threshold: -6, knee: 6, enabled: true },
  },

  p04: {
    name: 'Acid Slime',
    mainGain: 0.35, transpose: 0,
    voices: [
      { waveform: 'sawtooth', overtone: 1, gain: 0.5 },
      { waveform: 'sawtooth', overtone: 1.01, gain: 0.38 },
      { waveform: 'square', overtone: 2, gain: 0.18 },
      { waveform: 'sine', overtone: 0.5, gain: 0.12 },
    ],
    noise: { level: 0.02, enabled: true },
    envelope: { attack: 0.001, decay: 0.22, sustain: 0.62, release: 0.11 },
    eq: {
      highpass: { frequency: 140, Q: 0.7, gain: 0, enabled: true },
      peak: { frequency: 1600, Q: 7.5, gain: 12, enabled: true },
      lowpass: { frequency: 2600, Q: 8, gain: 0, enabled: true },
    },
    lfos: [
      { enabled: true, waveform: 'sine', rateBeats: 0.5, strength: 0.22 },
      { enabled: false, waveform: 'sine', rateBeats: 1, strength: 0 },
      { enabled: true, waveform: 'sawtooth', rateBeats: 0.25, strength: 1800 },
    ],
    distortion: { drive: 0.65, tone: 1800, mix: 0.7, enabled: true },
    comb: { delay: 2.0, feedback: 0.6, mix: 0.15, enabled: true },
    delay: { time: 0.22, feedback: 0.5, mix: 0.28, enabled: true },
    reverb: { size: 0.9, damp: 5500, mix: 0.12, enabled: true },
    limiter: { threshold: -8, knee: 4, enabled: true },
  },

  p05: {
    name: 'Glass Pluck',
    mainGain: 0.45, transpose: 0,
    voices: [
      { waveform: 'triangle', overtone: 1, gain: 0.5 },
      { waveform: 'sine', overtone: 2, gain: 0.3 },
      { waveform: 'sine', overtone: 4, gain: 0.12 },
      { waveform: 'triangle', overtone: 8, gain: 0.05 },
    ],
    noise: { level: 0.04, enabled: true },
    envelope: { attack: 0.001, decay: 0.35, sustain: 0, release: 0.22 },
    eq: {
      highpass: { frequency: 100, Q: 0.7, gain: 0, enabled: true },
      peak: { frequency: 3400, Q: 2.5, gain: 5, enabled: true },
      lowpass: { frequency: 11000, Q: 0.7, gain: 0, enabled: true },
    },
    lfos: [
      { enabled: false, waveform: 'sine', rateBeats: 1, strength: 0 },
      { enabled: false, waveform: 'sine', rateBeats: 1, strength: 0 },
      { enabled: false, waveform: 'sine', rateBeats: 1, strength: 0 },
    ],
    distortion: { drive: 0.15, tone: 7000, mix: 0.12, enabled: true },
    comb: { delay: 3.5, feedback: 0.5, mix: 0.35, enabled: true },
    delay: { time: 0.32, feedback: 0.5, mix: 0.3, enabled: true },
    reverb: { size: 3.5, damp: 12000, mix: 0.5, enabled: true },
    limiter: { threshold: -6, knee: 8, enabled: true },
  },

  p06: {
    name: 'Metal Bell',
    mainGain: 0.38, transpose: 0,
    voices: [
      { waveform: 'sine', overtone: 1, gain: 0.5 },
      { waveform: 'sine', overtone: 2.8, gain: 0.4 },
      { waveform: 'sine', overtone: 5.4, gain: 0.28 },
      { waveform: 'sine', overtone: 8.1, gain: 0.18 },
    ],
    noise: { level: 0.015, enabled: true },
    envelope: { attack: 0.001, decay: 1.5, sustain: 0, release: 3.0 },
    eq: {
      highpass: { frequency: 80, Q: 0.7, gain: 0, enabled: true },
      peak: { frequency: 3200, Q: 1.8, gain: 4, enabled: true },
      lowpass: { frequency: 14000, Q: 0.7, gain: 0, enabled: true },
    },
    lfos: [
      { enabled: false, waveform: 'sine', rateBeats: 1, strength: 0 },
      { enabled: false, waveform: 'sine', rateBeats: 1, strength: 0 },
      { enabled: false, waveform: 'sine', rateBeats: 1, strength: 0 },
    ],
    distortion: { drive: 0.1, tone: 8000, mix: 0.1, enabled: true },
    comb: { delay: 4.5, feedback: 0.6, mix: 0.4, enabled: true },
    delay: { time: 0.22, feedback: 0.3, mix: 0.15, enabled: true },
    reverb: { size: 3.5, damp: 11000, mix: 0.45, enabled: true },
    limiter: { threshold: -5, knee: 8, enabled: true },
  },

  p07: {
    name: 'Radio Ghost',
    mainGain: 0.33, transpose: 0,
    voices: [
      { waveform: 'sine', overtone: 1, gain: 0.45 },
      { waveform: 'square', overtone: 3, gain: 0.3 },
      { waveform: 'triangle', overtone: 5, gain: 0.25 },
      { waveform: 'sawtooth', overtone: 6, gain: 0.15 },
    ],
    noise: { level: 0.2, enabled: true },
    envelope: { attack: 0.02, decay: 0.4, sustain: 0.25, release: 1.8 },
    eq: {
      highpass: { frequency: 500, Q: 2.5, gain: 0, enabled: true },
      peak: { frequency: 2200, Q: 6, gain: 10, enabled: true },
      lowpass: { frequency: 5000, Q: 4, gain: 0, enabled: true },
    },
    lfos: [
      { enabled: true, waveform: 'sine', rateBeats: 0.5, strength: 0.28 },
      { enabled: true, waveform: 'triangle', rateBeats: 0.25, strength: 18 },
      { enabled: true, waveform: 'sine', rateBeats: 0.25, strength: 2400 },
    ],
    distortion: { drive: 0.75, tone: 2200, mix: 0.55, enabled: true },
    comb: { delay: 7, feedback: 0.7, mix: 0.35, enabled: true },
    delay: { time: 0.08, feedback: 0.75, mix: 0.35, enabled: true },
    reverb: { size: 1.6, damp: 5200, mix: 0.25, enabled: true },
    limiter: { threshold: -10, knee: 3, enabled: true },
  },

  p08: {
    name: 'Bee Swarm (Insane)',
    mainGain: 0.28, transpose: 0,
    voices: [
      { waveform: 'sawtooth', overtone: 1, gain: 0.32 },
      { waveform: 'sawtooth', overtone: 1.02, gain: 0.32 },
      { waveform: 'sawtooth', overtone: 0.98, gain: 0.32 },
      { waveform: 'sawtooth', overtone: 1.04, gain: 0.28 },
    ],
    noise: { level: 0.05, enabled: true },
    envelope: { attack: 0.001, decay: 0.04, sustain: 1.0, release: 0.02 },
    eq: {
      highpass: { frequency: 220, Q: 2, gain: 0, enabled: true },
      peak: { frequency: 4200, Q: 10, gain: 14, enabled: true },
      lowpass: { frequency: 6500, Q: 5, gain: 0, enabled: true },
    },
    lfos: [
      { enabled: true, waveform: 'triangle', rateBeats: 0.125, strength: 0.35 },
      { enabled: true, waveform: 'sine', rateBeats: 0.03125, strength: 15 },
      { enabled: true, waveform: 'sine', rateBeats: 0.5, strength: 2500 },
    ],
    distortion: { drive: 0.5, tone: 6000, mix: 0.4, enabled: true },
    comb: { delay: 0.6, feedback: 0.9, mix: 0.5, enabled: true },
    delay: { time: 0.03, feedback: 0.85, mix: 0.25, enabled: true },
    reverb: { size: 0.8, damp: 12000, mix: 0.18, enabled: true },
    limiter: { threshold: -10, knee: 2, enabled: true },
  },

  p09: {
    name: 'The Void (Drone)',
    mainGain: 0.34, transpose: -24,
    voices: [
      { waveform: 'sine', overtone: 1, gain: 0.5 },
      { waveform: 'sine', overtone: 1.001, gain: 0.47 },
      { waveform: 'triangle', overtone: 0.5, gain: 0.32 },
      { waveform: 'sawtooth', overtone: 2, gain: 0.12 },
    ],
    noise: { level: 0.12, enabled: true },
    envelope: { attack: 2.5, decay: 2.0, sustain: 0.7, release: 5.0 },
    eq: {
      highpass: { frequency: 20, Q: 0.7, gain: 0, enabled: true },
      peak: { frequency: 200, Q: 0.45, gain: 8, enabled: true },
      lowpass: { frequency: 1600, Q: 2.2, gain: 0, enabled: true },
    },
    lfos: [
      { enabled: true, waveform: 'sine', rateBeats: 4, strength: 0.18 },
      { enabled: true, waveform: 'sine', rateBeats: 2, strength: 6 },
      { enabled: true, waveform: 'sine', rateBeats: 2, strength: 600 },
    ],
    distortion: { drive: 0.3, tone: 900, mix: 0.35, enabled: true },
    comb: { delay: 40, feedback: 0.75, mix: 0.35, enabled: true },
    delay: { time: 0.9, feedback: 0.7, mix: 0.45, enabled: true },
    reverb: { size: 6.0, damp: 3500, mix: 0.7, enabled: true },
    limiter: { threshold: -8, knee: 10, enabled: true },
  },

  p10: {
    name: '808 Sub Heat',
    mainGain: 0.6, transpose: -24,
    voices: [
      { waveform: 'sine', overtone: 1, gain: 0.5 },
      { waveform: 'triangle', overtone: 1, gain: 0.15 },
      { waveform: 'sine', overtone: 2, gain: 0.06 },
      { waveform: 'sine', overtone: 3, gain: 0.02 },
    ],
    noise: { level: 0.03, enabled: true },
    envelope: { attack: 0.001, decay: 1.6, sustain: 0, release: 0.5 },
    eq: {
      highpass: { frequency: 20, Q: 0.7, gain: 0, enabled: true },
      peak: { frequency: 60, Q: 0.8, gain: 8, enabled: true },
      lowpass: { frequency: 400, Q: 1.2, gain: 0, enabled: true },
    },
    lfos: [
      { enabled: false, waveform: 'sine', rateBeats: 1, strength: 0 },
      { enabled: false, waveform: 'sine', rateBeats: 1, strength: 0 },
      { enabled: false, waveform: 'sine', rateBeats: 1, strength: 0 },
    ],
    distortion: { drive: 0.25, tone: 600, mix: 0.3, enabled: true },
    comb: { delay: 5, feedback: 0.2, mix: 0, enabled: false },
    delay: { time: 0.3, feedback: 0.3, mix: 0, enabled: false },
    reverb: { size: 0.5, damp: 4000, mix: 0.05, enabled: true },
    limiter: { threshold: -2, knee: 4, enabled: true },
  },

  p11: {
    name: 'Hyper Lead',
    mainGain: 0.38, transpose: 0,
    voices: [
      { waveform: 'sawtooth', overtone: 1, gain: 0.5 },
      { waveform: 'sawtooth', overtone: 1.01, gain: 0.35 },
      { waveform: 'square', overtone: 2, gain: 0.2 },
      { waveform: 'sine', overtone: 0.5, gain: 0.12 },
    ],
    noise: { level: 0, enabled: false },
    envelope: { attack: 0.001, decay: 0.2, sustain: 0.65, release: 0.12 },
    eq: {
      highpass: { frequency: 160, Q: 0.7, gain: 0, enabled: true },
      peak: { frequency: 2500, Q: 3, gain: 5, enabled: true },
      lowpass: { frequency: 9000, Q: 0.9, gain: 0, enabled: true },
    },
    lfos: [
      { enabled: false, waveform: 'sine', rateBeats: 1, strength: 0 },
      { enabled: true, waveform: 'triangle', rateBeats: 0.25, strength: 6 },
      { enabled: true, waveform: 'sawtooth', rateBeats: 0.5, strength: 1200 },
    ],
    distortion: { drive: 0.4, tone: 5000, mix: 0.35, enabled: true },
    comb: { delay: 1.8, feedback: 0.6, mix: 0.2, enabled: true },
    delay: { time: 0.18, feedback: 0.42, mix: 0.2, enabled: true },
    reverb: { size: 1.4, damp: 11000, mix: 0.22, enabled: true },
    limiter: { threshold: -8, knee: 6, enabled: true },
  },

  p12: {
    name: 'Glitch Storm (Max)',
    mainGain: 0.25, transpose: 0,
    voices: [
      { waveform: 'square', overtone: 3, gain: 0.45 },
      { waveform: 'sawtooth', overtone: 8, gain: 0.35 },
      { waveform: 'triangle', overtone: 0.5, gain: 0.5 },
      { waveform: 'square', overtone: 5, gain: 0.35 },
    ],
    noise: { level: 0.22, enabled: true },
    envelope: { attack: 0.001, decay: 0.03, sustain: 0.4, release: 0.02 },
    eq: {
      highpass: { frequency: 600, Q: 8, gain: 0, enabled: true },
      peak: { frequency: 3500, Q: 14, gain: 16, enabled: true },
      lowpass: { frequency: 9000, Q: 10, gain: 0, enabled: true },
    },
    lfos: [
      { enabled: true, waveform: 'square', rateBeats: 0.0625, strength: 0.8 },
      { enabled: true, waveform: 'sawtooth', rateBeats: 0.03125, strength: 40 },
      { enabled: true, waveform: 'square', rateBeats: 0.03125, strength: 5000 },
    ],
    distortion: { drive: 0.85, tone: 1400, mix: 0.8, enabled: true },
    comb: { delay: 1.2, feedback: 0.88, mix: 0.65, enabled: true },
    delay: { time: 0.05, feedback: 0.85, mix: 0.55, enabled: true },
    reverb: { size: 0.6, damp: 5000, mix: 0.25, enabled: true },
    limiter: { threshold: -12, knee: 1, enabled: true },
  },
};

// ===================== RANDOMISE =====================
function randomPreset() {
  const waves = ['sine', 'square', 'triangle', 'sawtooth'];
  // Pure harmonic ratios only — integer multiples and sub-octaves so
  // oscillators always stay in tune with each other.
  const overtoneRatios = [0.5, 1, 2, 3, 4, 5, 6, 8];
  const pick = (arr) => arr[Math.floor(Math.random() * arr.length)];
  const rng = (lo, hi) => lo + Math.random() * (hi - lo);
  const roundStep = (v, step) => Math.round(v / step) * step;
  const clamp = (v, lo, hi) => Math.max(lo, Math.min(hi, v));
  const coin = (chance = 0.5) => Math.random() < chance;

  const p = {
    name: 'Random',
    mainGain: rng(0.2, 0.6),
    transpose: [0, 0, 0, -12, -12, -24, 12][Math.floor(Math.random() * 7)],
    voices: Array.from({ length: 4 }, () => ({
      waveform: pick(waves),
      // Keep oscillator ratios musically "in tune" (simple harmonic ratios).
      overtone: pick(overtoneRatios),
      gain: rng(0.05, 0.5),
    })),
    noise: {
      enabled: coin(0.35),
      level: rng(0, 0.5),
    },
    envelope: {
      attack: coin(0.7) ? rng(0.001, 0.05) : rng(0.1, 2.0),
      decay: rng(0.02, 1.5),
      sustain: rng(0, 1),
      release: rng(0.01, 3.0),
    },
    eq: {
      // Keep EQ numbers clean so labels don't overflow / glitch.
      highpass: { frequency: Math.round(rng(20, 2000)), Q: roundStep(rng(0.3, 8), 0.1), gain: 0, enabled: coin(0.8) },
      peak: { frequency: Math.round(rng(200, 10000)), Q: roundStep(rng(0.3, 18), 0.1), gain: roundStep(rng(-12, 18), 0.1), enabled: coin(0.7) },
      lowpass: { frequency: Math.round(rng(500, 18000)), Q: roundStep(rng(0.3, 12), 0.1), gain: 0, enabled: coin(0.8) },
    },
    lfos: [
      { enabled: coin(0.4), waveform: pick(waves), rateBeats: pick([4, 2, 1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625]), strength: rng(0.02, 0.8) },
      { enabled: coin(0.4), waveform: pick(waves), rateBeats: pick([4, 2, 1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625]), strength: rng(1, 80) },
      { enabled: coin(0.5), waveform: pick(waves), rateBeats: pick([4, 2, 1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625]), strength: rng(50, 4000) },
    ],
    modulation: [
      {
        enabled: coin(0.5), waveform: pick(waves), mode: pick(['free', 'free', 'trigger']),
        tempoSync: coin(0.7), rateBeats: pick([4, 2, 1, 0.5, 0.25, 0.125]), rateFree: rng(0.1, 10),
        depth: rng(0.1, 1),
        routes: [{ targetId: pick(Object.keys(MOD_TARGETS)), amount: rng(-1, 1) }],
        customShape: null,
      },
      {
        enabled: coin(0.4), waveform: pick(waves), mode: pick(['free', 'trigger', 'envelope']),
        tempoSync: coin(0.6), rateBeats: pick([2, 1, 0.5, 0.25]), rateFree: rng(0.5, 20),
        depth: rng(0.2, 0.8),
        routes: [{ targetId: pick(Object.keys(MOD_TARGETS)), amount: rng(-0.8, 0.8) }],
        customShape: null,
      },
    ],
    distortion: {
      enabled: coin(0.4),
      drive: rng(0, 1),
      tone: rng(300, 16000),
      mix: rng(0, 0.85),
    },
    reverb: {
      enabled: coin(0.5),
      size: rng(0.1, 6),
      damp: rng(800, 18000),
      mix: rng(0, 0.75),
    },
    comb: {
      delay: rng(0.3, 45),
      feedback: rng(0.1, 0.92),
      mix: rng(0, 0.8),
      enabled: coin(0.5),
    },
    delay: {
      enabled: coin(0.45),
      time: rng(0.02, 1.2),
      feedback: rng(0.05, 0.9),
      mix: rng(0, 0.8),
    },
    limiter: { threshold: rng(-15, -1), knee: rng(1, 20), enabled: true },
  };

  // Hard caps / cleanup
  p.noise.level = clamp(p.noise.level, 0, 0.5);
  p.eq.highpass.frequency = clamp(p.eq.highpass.frequency, 20, 2000);
  p.eq.peak.frequency = clamp(p.eq.peak.frequency, 80, 16000);
  p.eq.lowpass.frequency = clamp(p.eq.lowpass.frequency, 200, 20000);

  synth.loadPreset(p);
  refreshUI(p);
  // Set preset selector to show nothing selected
  presetSelect.value = '';
}

// ===================== DOUBLE-CLICK: TYPE EXACT VALUE =====================
document.getElementById('ej-synth').addEventListener('dblclick', (e) => {
  const el = e.target;
  if (el.tagName !== 'INPUT' || el.type !== 'range') return;

  e.preventDefault();

  // Create a small text input overlaying the slider
  const rect = el.getBoundingClientRect();
  const parentRect = el.offsetParent ? el.offsetParent.getBoundingClientRect() : { left: 0, top: 0 };
  const isLogFreq = el.dataset.freqMin !== undefined;
  const input = document.createElement('input');
  input.type = 'text';
  input.inputMode = 'decimal';
  // For log-frequency sliders, show the actual frequency, not the slider position
  if (isLogFreq) {
    const fMin = parseFloat(el.dataset.freqMin);
    const fMax = parseFloat(el.dataset.freqMax);
    input.value = Math.round(sliderToFreq(parseInt(el.value), fMin, fMax));
  } else {
    input.value = el.value;
  }
  input.style.cssText = `
    position: absolute;
    left: ${rect.left - parentRect.left}px;
    top: ${rect.top - parentRect.top}px;
    width: ${Math.max(rect.width, 50)}px;
    height: ${rect.height + 4}px;
    background: var(--knob, #1a1a2a);
    border: 1px solid var(--accent, #4a9eff);
    color: var(--text, #c8c8d4);
    font-family: inherit;
    font-size: 11px;
    text-align: center;
    border-radius: 3px;
    z-index: 100;
    padding: 0 4px;
    outline: none;
  `;

  // Ensure the parent has positioning context
  if (el.offsetParent) {
    const pos = getComputedStyle(el.offsetParent).position;
    if (pos === 'static') el.offsetParent.style.position = 'relative';
  }

  const commit = () => {
    const v = parseFloat(input.value);
    if (Number.isFinite(v)) {
      if (isLogFreq) {
        // User typed an actual frequency — convert to slider position
        const fMin = parseFloat(el.dataset.freqMin);
        const fMax = parseFloat(el.dataset.freqMax);
        const clamped = Math.max(fMin, Math.min(fMax, v));
        el.value = freqToSlider(clamped, fMin, fMax);
      } else {
        const min = parseFloat(el.min);
        const max = parseFloat(el.max);
        el.value = Math.max(min, Math.min(max, v));
      }
      el.dispatchEvent(new Event('input', { bubbles: true }));
    }
    if (input.parentNode) input.parentNode.removeChild(input);
  };

  input.addEventListener('keydown', (ev) => {
    if (ev.key === 'Enter') { ev.preventDefault(); commit(); }
    if (ev.key === 'Escape') { ev.preventDefault(); if (input.parentNode) input.parentNode.removeChild(input); }
    ev.stopPropagation(); // prevent synth keyboard from firing
  });
  input.addEventListener('keyup', (ev) => ev.stopPropagation());
  input.addEventListener('blur', commit);

  el.offsetParent.appendChild(input);
  input.focus();
  input.select();
});

// ===================== POWER =====================
const powerBtn = document.getElementById('power-btn');
powerBtn.addEventListener('click', async () => {
  const on = await synth.toggle();
  powerBtn.textContent = on ? 'ON' : 'OFF';
  powerBtn.className = on ? 'power-on' : 'power-off';
  if (on) {
    startVisualizers();
    syncModToEngine();
  }
});

initMidiUi();

// ===================== PRESETS (add to header) =====================
const presetWrap = document.createElement('div');
presetWrap.className = 'ejs-preset-wrap';
presetWrap.innerHTML = '<label>Preset</label>';
const presetSelect = document.createElement('select');
presetSelect.id = 'preset-select';
const presetPlaceholder = document.createElement('option');
presetPlaceholder.value = '';
presetPlaceholder.textContent = '—';
presetPlaceholder.selected = true;
presetSelect.appendChild(presetPlaceholder);
const presetKeys = Object.keys(PRESETS);
for (let i = 0; i < presetKeys.length; i++) {
  const key = presetKeys[i];
  const opt = document.createElement('option');
  opt.value = key;
  opt.textContent = String(i + 1);
  presetSelect.appendChild(opt);
}
presetWrap.appendChild(presetSelect);

const randBtn = document.createElement('button');
randBtn.id = 'random-btn';
randBtn.textContent = 'RND';
randBtn.title = 'Randomise everything';
randBtn.addEventListener('click', randomPreset);
presetWrap.appendChild(randBtn);

const patchBtn = document.createElement('button');
patchBtn.className = 'ejs-btn';
patchBtn.id = 'patch-btn';
patchBtn.textContent = 'CODE';
patchBtn.title = 'Save/load patch code';
presetWrap.appendChild(patchBtn);

document.querySelector('.ejs-header').appendChild(presetWrap);

presetSelect.addEventListener('change', () => {
  const p = PRESETS[presetSelect.value];
  if (p) { synth.loadPreset(p); refreshUI(p); }
});

// Patch code modal
const patchBackdrop = document.getElementById('patch-modal-backdrop');
const patchTextarea = document.getElementById('patch-code');
const patchStatus = document.getElementById('patch-status');
const patchCloseBtn = document.getElementById('patch-close-btn');
const patchCopyBtn = document.getElementById('patch-copy-btn');
const patchLoadBtn = document.getElementById('patch-load-btn');

function setPatchStatus(msg) {
  patchStatus.textContent = msg || '';
}

// ===================== EMBED RESIZE (avoid iframe scrolling) =====================
function postEmbedHeight() {
  try {
    if (!window.parent || window.parent === window) return;
    const h = Math.ceil(document.documentElement.scrollHeight);
    window.parent.postMessage({ type: 'ej-synth-height', height: h }, '*');
  } catch (_) {}
}

try {
  const ro = new ResizeObserver(() => postEmbedHeight());
  ro.observe(document.documentElement);
  ro.observe(document.body);
} catch (_) {
  window.addEventListener('resize', postEmbedHeight);
}

document.addEventListener('toggle', postEmbedHeight, true);
window.addEventListener('load', postEmbedHeight);
postEmbedHeight();

function openPatchModal() {
  setPatchStatus('');
  patchTextarea.value = encodePatch(snapshotCurrentPatch());
  patchBackdrop.hidden = false;
  patchTextarea.focus();
  patchTextarea.select();
}

function closePatchModal() {
  patchBackdrop.hidden = true;
  setPatchStatus('');
}

patchBtn.addEventListener('click', openPatchModal);
patchCloseBtn.addEventListener('click', closePatchModal);
patchBackdrop.addEventListener('mousedown', (e) => {
  if (e.target === patchBackdrop) closePatchModal();
});
document.addEventListener('keydown', (e) => {
  if (!patchBackdrop.hidden && e.key === 'Escape') closePatchModal();
});

patchCopyBtn.addEventListener('click', async () => {
  try {
    patchTextarea.value = encodePatch(snapshotCurrentPatch());
    await navigator.clipboard.writeText(patchTextarea.value);
    setPatchStatus('Copied.');
  } catch (e) {
    patchTextarea.select();
    setPatchStatus('Select all + copy (clipboard blocked).');
  }
});

patchLoadBtn.addEventListener('click', () => {
  try {
    const decoded = decodePatch(patchTextarea.value);
    const p = normalizePatch(decoded);
    synth.loadPreset(p);
    synth.setBPM(p.bpm);
    document.getElementById('bpm').value = p.bpm;
    refreshUI(p);
    presetSelect.value = '';
    setPatchStatus('Loaded.');
  } catch (e) {
    setPatchStatus(`Error: ${e?.message || 'invalid code'}`);
  }
});

function refreshUI(p) {
  // Main
  document.getElementById('main-gain').value = p.mainGain;
  document.getElementById('main-gain-val').textContent = p.mainGain.toFixed(2);
  document.getElementById('transpose').value = p.transpose;

  // Voices
  document.querySelectorAll('.ejs-osc[data-voice]').forEach((el) => {
    const i = parseInt(el.dataset.voice);
    const v = p.voices[i];
    el.querySelector('.waveform-select').value = v.waveform;
    el.querySelector('.overtone').value = v.overtone;
    el.querySelector('.overtone-val').textContent = v.overtone.toFixed(2);
    el.querySelector('.voice-gain').value = v.gain;
  });

  // ADSR
  const env = p.envelope;
  for (const k of ['attack', 'decay', 'sustain', 'release']) {
    const slider = document.getElementById(k);
    slider.value = env[k];
    slider.dispatchEvent(new Event('input'));
  }

  // EQ
  document.querySelectorAll('.ejs-eq-band').forEach(el => {
    const band = el.dataset.band;
    const cfg = p.eq[band];
    const freqSlider = el.querySelector('.eq-freq');
    const fMin = parseFloat(freqSlider.dataset.freqMin);
    const fMax = parseFloat(freqSlider.dataset.freqMax);
    freqSlider.value = freqToSlider(cfg.frequency, fMin, fMax);
    el.querySelector('.eq-freq-val').textContent = fmtFreq(cfg.frequency);
    el.querySelector('.eq-q').value = cfg.Q;
    el.querySelector('.eq-q-val').textContent = cfg.Q.toFixed(1);
    const gainEl = el.querySelector('.eq-gain-db');
    if (gainEl) {
      gainEl.value = cfg.gain || 0;
      el.querySelector('.eq-gain-val').textContent = `${(cfg.gain||0).toFixed(1)}dB`;
    }
    const enabled = cfg.enabled !== false;
    el.classList.toggle('bypassed', !enabled);
    const btn = document.querySelector(`.ejs-band-btn[data-band="${band}"]`);
    btn.classList.toggle('active', enabled);
  });

  // Modulation
  if (p.modulation) {
    modConfigs = p.modulation.map(m => ({ ...m, routes: m.routes.map(r => ({ ...r })), customShape: m.customShape ? m.customShape.map(pt => ({ ...pt })) : null }));
  } else if (p.lfos) {
    // Convert legacy LFO format to new modulation format
    modConfigs = legacyLfosToModulation(p.lfos);
  }
  buildModUI();
  syncModToEngine();

  // Effects
  const noise = p.noise || { enabled: false, level: 0 };
  document.getElementById('noise-toggle').checked = !!noise.enabled;
  document.getElementById('noise-unit').classList.toggle('bypassed', !noise.enabled);
  document.getElementById('noise-level').value = noise.level;
  document.getElementById('noise-level-val').textContent = noise.level.toFixed(2);

  const dist = p.distortion || { enabled: false, drive: 0, tone: 8000, mix: 0 };
  document.getElementById('distortion-bypass').checked = !!dist.enabled;
  document.getElementById('distortion-unit').classList.toggle('bypassed', !dist.enabled);
  document.getElementById('distortion-drive').value = dist.drive;
  document.getElementById('distortion-drive-val').textContent = dist.drive.toFixed(2);
  document.getElementById('distortion-tone').value = freqToSlider(dist.tone, _distToneMin, _distToneMax);
  document.getElementById('distortion-tone-val').textContent = fmtFreq(dist.tone);
  document.getElementById('distortion-mix').value = dist.mix;
  document.getElementById('distortion-mix-val').textContent = dist.mix.toFixed(2);

  const rev = p.reverb || { enabled: false, size: 2.5, damp: 8000, mix: 0.2 };
  document.getElementById('reverb-bypass').checked = !!rev.enabled;
  document.getElementById('reverb-unit').classList.toggle('bypassed', !rev.enabled);
  document.getElementById('reverb-size').value = rev.size;
  document.getElementById('reverb-size-val').textContent = `${rev.size.toFixed(1)}s`;
  document.getElementById('reverb-damp').value = freqToSlider(rev.damp, _dampMin, _dampMax);
  document.getElementById('reverb-damp-val').textContent = fmtFreq(rev.damp);
  document.getElementById('reverb-mix').value = rev.mix;
  document.getElementById('reverb-mix-val').textContent = rev.mix.toFixed(2);

  document.getElementById('comb-bypass').checked = p.comb.enabled;
  document.getElementById('comb-unit').classList.toggle('bypassed', !p.comb.enabled);
  document.getElementById('comb-delay').value = p.comb.delay;
  document.getElementById('comb-delay-val').textContent = `${p.comb.delay.toFixed(1)}ms`;
  document.getElementById('comb-feedback').value = p.comb.feedback;
  document.getElementById('comb-feedback-val').textContent = p.comb.feedback.toFixed(2);
  document.getElementById('comb-mix').value = p.comb.mix;
  document.getElementById('comb-mix-val').textContent = p.comb.mix.toFixed(2);

  const del = p.delay || { enabled: false, time: 0.3, feedback: 0.3, mix: 0 };
  document.getElementById('delay-bypass').checked = !!del.enabled;
  document.getElementById('delay-unit').classList.toggle('bypassed', !del.enabled);
  document.getElementById('delay-time').value = del.time;
  document.getElementById('delay-time-val').textContent = `${Math.round(del.time * 1000)}ms`;
  document.getElementById('delay-feedback').value = del.feedback;
  document.getElementById('delay-feedback-val').textContent = del.feedback.toFixed(2);
  document.getElementById('delay-mix').value = del.mix;
  document.getElementById('delay-mix-val').textContent = del.mix.toFixed(2);

  document.getElementById('limiter-bypass').checked = p.limiter.enabled;
  document.getElementById('limiter-unit').classList.toggle('bypassed', !p.limiter.enabled);
  document.getElementById('limiter-threshold').value = p.limiter.threshold;
  document.getElementById('limiter-threshold-val').textContent = `${p.limiter.threshold.toFixed(1)}dB`;
  document.getElementById('limiter-knee').value = p.limiter.knee;
  document.getElementById('limiter-knee-val').textContent = p.limiter.knee.toFixed(1);

  drawADSR();
}

// ===================== HEADER CONTROLS =====================
const mainGainSlider = document.getElementById('main-gain');
const mainGainVal = document.getElementById('main-gain-val');
mainGainSlider.addEventListener('input', () => {
  const v = parseFloat(mainGainSlider.value);
  mainGainVal.textContent = v.toFixed(2);
  synth.setMainGain(v);
});

document.getElementById('bpm').addEventListener('change', (e) => {
  synth.setBPM(parseInt(e.target.value) || 120);
});

document.getElementById('transpose').addEventListener('change', (e) => {
  synth.setTranspose(parseInt(e.target.value) || 0);
});

// ===================== OSCILLATORS =====================
document.querySelectorAll('.ejs-osc[data-voice]').forEach((el) => {
  const idx = parseInt(el.dataset.voice);

  el.querySelector('.waveform-select').addEventListener('change', (e) => {
    synth.setVoiceConfig(idx, 'waveform', e.target.value);
  });

  const ot = el.querySelector('.overtone');
  const otVal = el.querySelector('.overtone-val');
  ot.addEventListener('input', () => {
    const v = parseFloat(ot.value);
    otVal.textContent = v.toFixed(2);
    synth.setVoiceConfig(idx, 'overtone', v);
  });

  el.querySelector('.voice-gain').addEventListener('input', (e) => {
    synth.setVoiceConfig(idx, 'gain', parseFloat(e.target.value));
  });
});

// Noise
const noiseToggle = document.getElementById('noise-toggle');
const noiseLevelSlider = document.getElementById('noise-level');
const noiseLevelVal = document.getElementById('noise-level-val');
noiseToggle.addEventListener('change', (e) => {
  const on = e.target.checked;
  synth.setNoiseEnabled(on);
  document.getElementById('noise-unit').classList.toggle('bypassed', !on);
});
noiseLevelSlider.addEventListener('input', () => {
  const v = parseFloat(noiseLevelSlider.value);
  noiseLevelVal.textContent = v.toFixed(2);
  synth.setNoiseLevel(v);
});

// ===================== ADSR =====================
const adsrParams = ['attack', 'decay', 'sustain', 'release'];
adsrParams.forEach(param => {
  const slider = document.getElementById(param);
  const valSpan = document.getElementById(`${param}-val`);
  slider.addEventListener('input', () => {
    const v = parseFloat(slider.value);
    synth.setEnvelope(param, v);
    if (param === 'sustain') valSpan.textContent = v.toFixed(2);
    else valSpan.textContent = v >= 1 ? `${v.toFixed(2)}s` : `${Math.round(v * 1000)}ms`;
    drawADSR();
  });
});

function drawADSR() {
  const canvas = document.getElementById('adsr-canvas');
  const ctx = canvas.getContext('2d');
  const w = canvas.width, h = canvas.height, pad = 6;
  const env = synth.envelope;

  ctx.clearRect(0, 0, w, h);
  ctx.strokeStyle = '#4a9eff';
  ctx.lineWidth = 2;
  ctx.beginPath();

  const total = env.attack + env.decay + 0.2 + env.release;
  const sx = (w - pad * 2) / total;
  let x = pad;
  ctx.moveTo(x, h - pad);
  x += env.attack * sx; ctx.lineTo(x, pad);
  x += env.decay * sx;
  const sy = pad + (1 - env.sustain) * (h - pad * 2);
  ctx.lineTo(x, sy);
  x += 0.2 * sx; ctx.lineTo(x, sy);
  x += env.release * sx; ctx.lineTo(x, h - pad);
  ctx.stroke();

  ctx.fillStyle = '#555568';
  ctx.font = '8px monospace';
  ctx.fillText('A', pad + env.attack * sx * 0.4, h - 1);
  ctx.fillText('D', pad + (env.attack + env.decay * 0.4) * sx, h - 1);
  ctx.fillText('S', pad + (env.attack + env.decay + 0.08) * sx, h - 1);
  ctx.fillText('R', pad + (env.attack + env.decay + 0.2 + env.release * 0.4) * sx, h - 1);
}
drawADSR();

// ===================== PARAMETRIC EQ =====================
const eqCanvas = document.getElementById('eq-canvas');
const eqCtx = eqCanvas.getContext('2d');
const BAND_COLORS = { highpass: '#ff6b6b', peak: '#4a9eff', lowpass: '#3ddc84' };

// Band toggle buttons
document.querySelectorAll('.ejs-band-btn').forEach(btn => {
  btn.addEventListener('click', () => {
    const band = btn.dataset.band;
    const isActive = btn.classList.toggle('active');
    synth.setEQBypass(band, isActive);
    const bandEl = document.querySelector(`.ejs-eq-band[data-band="${band}"]`);
    bandEl.classList.toggle('bypassed', !isActive);
  });
});

// EQ controls
document.querySelectorAll('.ejs-eq-band').forEach(el => {
  const band = el.dataset.band;

  const freqSlider = el.querySelector('.eq-freq');
  const freqVal = el.querySelector('.eq-freq-val');
  const fMin = parseFloat(freqSlider.dataset.freqMin);
  const fMax = parseFloat(freqSlider.dataset.freqMax);
  freqSlider.addEventListener('input', () => {
    const freq = sliderToFreq(parseInt(freqSlider.value), fMin, fMax);
    freqVal.textContent = fmtFreq(freq);
    synth.setEQ(band, 'frequency', freq);
  });

  const qSlider = el.querySelector('.eq-q');
  const qVal = el.querySelector('.eq-q-val');
  qSlider.addEventListener('input', () => {
    const v = parseFloat(qSlider.value);
    qVal.textContent = v.toFixed(1);
    synth.setEQ(band, 'Q', v);
  });

  const gainSlider = el.querySelector('.eq-gain-db');
  if (gainSlider) {
    const gainVal = el.querySelector('.eq-gain-val');
    gainSlider.addEventListener('input', () => {
      const v = parseFloat(gainSlider.value);
      gainVal.textContent = `${v.toFixed(1)}dB`;
      synth.setEQ(band, 'gain', v);
    });
  }
});

function drawEQ() {
  const w = eqCanvas.width, h = eqCanvas.height;
  eqCtx.fillStyle = '#0a0a0f';
  eqCtx.fillRect(0, 0, w, h);

  // Grid: frequency lines
  const freqLines = [50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000];
  const dbRange = 24;
  const midY = h / 2;

  eqCtx.strokeStyle = '#1a1a2a';
  eqCtx.lineWidth = 0.5;
  eqCtx.fillStyle = '#333';
  eqCtx.font = '8px monospace';

  for (const f of freqLines) {
    const x = freqToX(f, w);
    eqCtx.beginPath(); eqCtx.moveTo(x, 0); eqCtx.lineTo(x, h); eqCtx.stroke();
    const label = f >= 1000 ? `${f/1000}k` : f;
    eqCtx.fillText(label, x + 2, h - 3);
  }

  // dB lines
  for (let db = -18; db <= 18; db += 6) {
    const y = midY - (db / dbRange) * h;
    eqCtx.beginPath(); eqCtx.moveTo(0, y); eqCtx.lineTo(w, y); eqCtx.stroke();
    if (db !== 0) eqCtx.fillText(`${db > 0 ? '+' : ''}${db}`, 2, y - 2);
  }

  // 0dB line
  eqCtx.strokeStyle = '#2a2a3a';
  eqCtx.lineWidth = 1;
  eqCtx.beginPath(); eqCtx.moveTo(0, midY); eqCtx.lineTo(w, midY); eqCtx.stroke();

  // Build frequency array once (log scale, cached since canvas width is fixed)
  if (!drawEQ._freqs || drawEQ._freqs.length !== w) {
    drawEQ._freqs = new Array(w);
    for (let i = 0; i < w; i++) drawEQ._freqs[i] = xToFreq(i, w);
  }
  const freqs = drawEQ._freqs;

  // Draw per-band curves
  for (const band of ['highpass', 'peak', 'lowpass']) {
    const resp = synth.getBandResponse(band, freqs);
    if (!resp) continue;

    eqCtx.strokeStyle = BAND_COLORS[band] + '60';
    eqCtx.lineWidth = 1;
    eqCtx.beginPath();
    for (let i = 0; i < w; i++) {
      const y = midY - (resp[i] / dbRange) * h;
      if (i === 0) eqCtx.moveTo(i, y); else eqCtx.lineTo(i, y);
    }
    eqCtx.stroke();
  }

  // Draw combined response + fill
  const combined = synth.getEQResponse(freqs);
  if (combined) {
    eqCtx.beginPath();
    for (let i = 0; i < w; i++) {
      const y = midY - (combined[i] / dbRange) * h;
      if (i === 0) eqCtx.moveTo(i, y); else eqCtx.lineTo(i, y);
    }

    // Fill under curve
    const gradient = eqCtx.createLinearGradient(0, 0, 0, h);
    gradient.addColorStop(0, 'rgba(74,158,255,0.15)');
    gradient.addColorStop(0.5, 'rgba(74,158,255,0.05)');
    gradient.addColorStop(1, 'rgba(74,158,255,0.15)');
    eqCtx.strokeStyle = '#4a9eff';
    eqCtx.lineWidth = 2;
    eqCtx.stroke();

    // Fill
    eqCtx.lineTo(w, midY);
    eqCtx.lineTo(0, midY);
    eqCtx.closePath();
    eqCtx.fillStyle = gradient;
    eqCtx.fill();
  }

  // Draw band dots
  for (const band of ['highpass', 'peak', 'lowpass']) {
    if (!synth.eqConfigs[band].enabled) continue;
    const cfg = synth.eqConfigs[band];
    const x = freqToX(cfg.frequency, w);
    const bandResp = synth.getBandResponse(band, [cfg.frequency]);
    const db = bandResp ? bandResp[0] : 0;
    const y = midY - (db / dbRange) * h;

    eqCtx.fillStyle = BAND_COLORS[band];
    eqCtx.beginPath();
    eqCtx.arc(x, y, 5, 0, Math.PI * 2);
    eqCtx.fill();
    eqCtx.strokeStyle = '#fff';
    eqCtx.lineWidth = 1;
    eqCtx.stroke();
  }
}

function freqToX(f, w) {
  return (Math.log10(f / 20) / Math.log10(20000 / 20)) * w;
}

function xToFreq(x, w) {
  return 20 * Math.pow(20000 / 20, x / w);
}

// ===================== MODULATION SYSTEM =====================
const modLfoList = document.getElementById('mod-lfo-list');
const modAddBtn = document.getElementById('mod-add-lfo');
const MAX_LFOS = 4;

// Default modulation configs
let modConfigs = [
  { enabled: false, waveform: 'sine', mode: 'free', tempoSync: true, rateBeats: 1, rateFree: 1, depth: 0.5, routes: [{ targetId: 'main-gain', amount: 0.5 }], customShape: null },
  { enabled: false, waveform: 'sine', mode: 'free', tempoSync: true, rateBeats: 1, rateFree: 1, depth: 0.5, routes: [{ targetId: 'all-pitch', amount: 0.5 }], customShape: null },
];

const shapeEditors = [];

function buildModUI() {
  modLfoList.innerHTML = '';
  shapeEditors.length = 0;

  modConfigs.forEach((cfg, i) => {
    const el = document.createElement('div');
    el.className = 'ejs-mod-lfo';
    el.dataset.lfo = i;
    el.innerHTML = `
      <div class="ejs-mod-lfo-header">
        <label class="ejs-toggle"><input type="checkbox" class="mod-lfo-toggle" ${cfg.enabled ? 'checked' : ''}><span class="ejs-toggle-slider"></span></label>
        <span class="ejs-mod-lfo-label">LFO ${i + 1}</span>
        <select class="mod-lfo-wave">
          <option value="sine" ${cfg.waveform === 'sine' ? 'selected' : ''}>Sin</option>
          <option value="square" ${cfg.waveform === 'square' ? 'selected' : ''}>Sqr</option>
          <option value="triangle" ${cfg.waveform === 'triangle' ? 'selected' : ''}>Tri</option>
          <option value="sawtooth" ${cfg.waveform === 'sawtooth' ? 'selected' : ''}>Saw</option>
          <option value="custom" ${cfg.waveform === 'custom' ? 'selected' : ''}>Custom</option>
        </select>
        <select class="mod-lfo-mode">
          <option value="free" ${cfg.mode === 'free' ? 'selected' : ''}>Free</option>
          <option value="trigger" ${cfg.mode === 'trigger' ? 'selected' : ''}>Trigger</option>
          <option value="envelope" ${cfg.mode === 'envelope' ? 'selected' : ''}>Envelope</option>
        </select>
        <label class="ejs-toggle mod-sync-toggle"><input type="checkbox" class="mod-lfo-sync" ${cfg.tempoSync ? 'checked' : ''}><span class="ejs-toggle-slider"></span></label>
        <span class="ejs-mod-sync-label">Sync</span>
        <select class="mod-lfo-rate-sync" ${!cfg.tempoSync ? 'hidden' : ''}>
          <option value="4" ${cfg.rateBeats === 4 ? 'selected' : ''}>1/1</option>
          <option value="2" ${cfg.rateBeats === 2 ? 'selected' : ''}>1/2</option>
          <option value="1" ${cfg.rateBeats === 1 ? 'selected' : ''}>1/4</option>
          <option value="0.5" ${cfg.rateBeats === 0.5 ? 'selected' : ''}>1/8</option>
          <option value="0.25" ${cfg.rateBeats === 0.25 ? 'selected' : ''}>1/16</option>
          <option value="0.125" ${cfg.rateBeats === 0.125 ? 'selected' : ''}>1/32</option>
          <option value="0.0625" ${cfg.rateBeats === 0.0625 ? 'selected' : ''}>1/64</option>
          <option value="0.03125" ${cfg.rateBeats === 0.03125 ? 'selected' : ''}>1/128</option>
          <option value="0.015625" ${cfg.rateBeats === 0.015625 ? 'selected' : ''}>1/256</option>
        </select>
        <div class="ejs-knob-group mod-lfo-rate-free" ${cfg.tempoSync ? 'hidden' : ''}>
          <label>Hz</label>
          <input type="range" class="mod-rate-hz" min="0.01" max="40" step="0.01" value="${cfg.rateFree}" data-default="1">
          <span class="mod-rate-hz-val">${cfg.rateFree.toFixed(2)}</span>
        </div>
        ${modConfigs.length > 1 ? '<button class="ejs-btn ejs-mod-lfo-del" title="Remove LFO">x</button>' : ''}
      </div>
      <div class="ejs-mod-lfo-controls">
        <div class="ejs-knob-group">
          <label>Depth</label>
          <input type="range" class="mod-lfo-depth" min="0" max="1" step="0.01" value="${cfg.depth}" data-default="0.5">
          <span class="mod-lfo-depth-val">${cfg.depth.toFixed(2)}</span>
        </div>
        <button class="ejs-btn mod-shape-btn">Shape</button>
      </div>
      <div class="ejs-mod-shape-wrap" hidden>
        <canvas class="mod-shape-canvas" width="300" height="80"></canvas>
        <span class="mod-shape-hint">Left-drag: move | Right-click: add/remove point</span>
      </div>
      <div class="ejs-mod-routes">
        <div class="ejs-mod-routes-head">
          <span>Routes</span>
          <button class="ejs-btn mod-add-route">+ Route</button>
        </div>
        <div class="ejs-mod-route-list"></div>
      </div>
    `;
    modLfoList.appendChild(el);

    // Build route list
    const routeList = el.querySelector('.ejs-mod-route-list');
    cfg.routes.forEach((route, ri) => {
      routeList.appendChild(buildRouteRow(i, ri, route));
    });

    // Shape editor
    const shapeCanvas = el.querySelector('.mod-shape-canvas');
    const editor = new LFOShapeEditor(shapeCanvas, i, (points) => {
      modConfigs[i].customShape = points.map(p => ({ x: p.x, y: p.y }));
      if (synth.modRouter) {
        synth.modRouter.updateLFO(i, 'customShape', modConfigs[i].customShape);
      }
    });
    if (cfg.customShape) editor.setPoints(cfg.customShape);
    shapeEditors[i] = editor;

    // Wire events
    wireModLFOEvents(el, i);
  });

  updateModAddBtn();
  syncModToEngine();
}

function buildRouteRow(lfoIdx, routeIdx, route) {
  const row = document.createElement('div');
  row.className = 'ejs-mod-route';
  row.dataset.routeIdx = routeIdx;

  let targetOptions = '';
  for (const [id, t] of Object.entries(MOD_TARGETS)) {
    targetOptions += `<option value="${id}" ${route.targetId === id ? 'selected' : ''}>${t.label}</option>`;
  }

  row.innerHTML = `
    <select class="mod-route-target">${targetOptions}</select>
    <div class="ejs-knob-group">
      <label>Amt</label>
      <input type="range" class="mod-route-amount" min="-1" max="1" step="0.01" value="${route.amount}">
      <span class="mod-route-amount-val">${route.amount.toFixed(2)}</span>
    </div>
    <button class="ejs-btn mod-route-remove">x</button>
  `;

  // Wire route events
  row.querySelector('.mod-route-target').addEventListener('change', (e) => {
    modConfigs[lfoIdx].routes[routeIdx].targetId = e.target.value;
    if (synth.modRouter) synth.modRouter.updateRouteTarget(lfoIdx, routeIdx, e.target.value);
  });

  const amtSlider = row.querySelector('.mod-route-amount');
  const amtVal = row.querySelector('.mod-route-amount-val');
  amtSlider.addEventListener('input', () => {
    const v = parseFloat(amtSlider.value);
    amtVal.textContent = v.toFixed(2);
    modConfigs[lfoIdx].routes[routeIdx].amount = v;
    if (synth.modRouter) synth.modRouter.updateRouteAmount(lfoIdx, routeIdx, v);
  });

  row.querySelector('.mod-route-remove').addEventListener('click', () => {
    modConfigs[lfoIdx].routes.splice(routeIdx, 1);
    if (synth.modRouter) synth.modRouter.removeRoute(lfoIdx, routeIdx);
    buildModUI();
  });

  return row;
}

function wireModLFOEvents(el, i) {
  el.querySelector('.mod-lfo-toggle').addEventListener('change', (e) => {
    modConfigs[i].enabled = e.target.checked;
    if (synth.modRouter) synth.modRouter.updateLFO(i, 'enabled', e.target.checked);
  });

  el.querySelector('.mod-lfo-wave').addEventListener('change', (e) => {
    modConfigs[i].waveform = e.target.value;
    if (synth.modRouter) synth.modRouter.updateLFO(i, 'waveform', e.target.value);
  });

  el.querySelector('.mod-lfo-mode').addEventListener('change', (e) => {
    modConfigs[i].mode = e.target.value;
    if (synth.modRouter) synth.modRouter.updateLFO(i, 'mode', e.target.value);
  });

  const syncToggle = el.querySelector('.mod-lfo-sync');
  const rateSync = el.querySelector('.mod-lfo-rate-sync');
  const rateFreeWrap = el.querySelector('.mod-lfo-rate-free');

  syncToggle.addEventListener('change', (e) => {
    modConfigs[i].tempoSync = e.target.checked;
    rateSync.hidden = !e.target.checked;
    rateFreeWrap.hidden = e.target.checked;
    if (synth.modRouter) synth.modRouter.updateLFO(i, 'tempoSync', e.target.checked);
  });

  rateSync.addEventListener('change', (e) => {
    modConfigs[i].rateBeats = parseFloat(e.target.value);
    if (synth.modRouter) synth.modRouter.updateLFO(i, 'rateBeats', modConfigs[i].rateBeats);
  });

  const rateHz = el.querySelector('.mod-rate-hz');
  const rateHzVal = el.querySelector('.mod-rate-hz-val');
  rateHz.addEventListener('input', () => {
    const v = parseFloat(rateHz.value);
    rateHzVal.textContent = v.toFixed(2);
    modConfigs[i].rateFree = v;
    if (synth.modRouter) synth.modRouter.updateLFO(i, 'rateFree', v);
  });

  const depthSlider = el.querySelector('.mod-lfo-depth');
  const depthVal = el.querySelector('.mod-lfo-depth-val');
  depthSlider.addEventListener('input', () => {
    const v = parseFloat(depthSlider.value);
    depthVal.textContent = v.toFixed(2);
    modConfigs[i].depth = v;
    if (synth.modRouter) synth.modRouter.updateLFO(i, 'depth', v);
  });

  // Shape toggle
  const shapeBtn = el.querySelector('.mod-shape-btn');
  const shapeWrap = el.querySelector('.ejs-mod-shape-wrap');
  shapeBtn.addEventListener('click', () => {
    const show = shapeWrap.hidden;
    shapeWrap.hidden = !show;
    shapeBtn.classList.toggle('active', show);
    if (show && shapeEditors[i]) shapeEditors[i].draw();
  });

  // Add route
  el.querySelector('.mod-add-route').addEventListener('click', () => {
    modConfigs[i].routes.push({ targetId: 'main-gain', amount: 0.5 });
    if (synth.modRouter) synth.modRouter.addRoute(i, 'main-gain', 0.5);
    buildModUI();
  });

  // Delete LFO
  const delBtn = el.querySelector('.ejs-mod-lfo-del');
  if (delBtn) {
    delBtn.addEventListener('click', () => {
      if (modConfigs.length <= 1) return;
      modConfigs.splice(i, 1);
      buildModUI();
    });
  }
}

function updateModAddBtn() {
  modAddBtn.disabled = modConfigs.length >= MAX_LFOS;
  modAddBtn.style.opacity = modConfigs.length >= MAX_LFOS ? '0.3' : '1';
}

modAddBtn.addEventListener('click', () => {
  if (modConfigs.length >= MAX_LFOS) return;
  modConfigs.push({
    enabled: false, waveform: 'sine', mode: 'free',
    tempoSync: true, rateBeats: 1, rateFree: 1, depth: 0.5,
    routes: [], customShape: null,
  });
  buildModUI();
});

function syncModToEngine() {
  if (synth.modRouter && synth.running) {
    synth.modRouter.init(modConfigs);
  }
}

// Initial build
buildModUI();

// ===================== EFFECTS =====================
// Distortion
document.getElementById('distortion-bypass').addEventListener('change', (e) => {
  synth.setDistortionEnabled(e.target.checked);
  document.getElementById('distortion-unit').classList.toggle('bypassed', !e.target.checked);
});

const distDriveSlider = document.getElementById('distortion-drive');
const distDriveVal = document.getElementById('distortion-drive-val');
distDriveSlider.addEventListener('input', () => {
  const v = parseFloat(distDriveSlider.value);
  distDriveVal.textContent = v.toFixed(2);
  synth.setDistortionDrive(v);
});

const distToneSlider = document.getElementById('distortion-tone');
const distToneVal = document.getElementById('distortion-tone-val');
const _distToneMin = parseFloat(distToneSlider.dataset.freqMin);
const _distToneMax = parseFloat(distToneSlider.dataset.freqMax);
distToneSlider.addEventListener('input', () => {
  const freq = sliderToFreq(parseInt(distToneSlider.value), _distToneMin, _distToneMax);
  distToneVal.textContent = fmtFreq(freq);
  synth.setDistortionTone(freq);
});

const distMixSlider = document.getElementById('distortion-mix');
const distMixVal = document.getElementById('distortion-mix-val');
distMixSlider.addEventListener('input', () => {
  const v = parseFloat(distMixSlider.value);
  distMixVal.textContent = v.toFixed(2);
  synth.setDistortionMix(v);
});

// Reverb
document.getElementById('reverb-bypass').addEventListener('change', (e) => {
  synth.setReverbEnabled(e.target.checked);
  document.getElementById('reverb-unit').classList.toggle('bypassed', !e.target.checked);
});

const reverbSizeSlider = document.getElementById('reverb-size');
const reverbSizeVal = document.getElementById('reverb-size-val');
let reverbSizeTimer = null;
reverbSizeSlider.addEventListener('input', () => {
  const v = parseFloat(reverbSizeSlider.value);
  reverbSizeVal.textContent = `${v.toFixed(1)}s`;
  if (reverbSizeTimer) window.clearTimeout(reverbSizeTimer);
  reverbSizeTimer = window.setTimeout(() => synth.setReverbSize(v), 120);
});

const reverbDampSlider = document.getElementById('reverb-damp');
const reverbDampVal = document.getElementById('reverb-damp-val');
const _dampMin = parseFloat(reverbDampSlider.dataset.freqMin);
const _dampMax = parseFloat(reverbDampSlider.dataset.freqMax);
reverbDampSlider.addEventListener('input', () => {
  const freq = sliderToFreq(parseInt(reverbDampSlider.value), _dampMin, _dampMax);
  reverbDampVal.textContent = fmtFreq(freq);
  synth.setReverbDamp(freq);
});

const reverbMixSlider = document.getElementById('reverb-mix');
const reverbMixVal = document.getElementById('reverb-mix-val');
reverbMixSlider.addEventListener('input', () => {
  const v = parseFloat(reverbMixSlider.value);
  reverbMixVal.textContent = v.toFixed(2);
  synth.setReverbMix(v);
});

// Comb
document.getElementById('comb-bypass').addEventListener('change', (e) => {
  synth.setCombEnabled(e.target.checked);
  document.getElementById('comb-unit').classList.toggle('bypassed', !e.target.checked);
});

const combDelaySlider = document.getElementById('comb-delay');
const combDelayVal = document.getElementById('comb-delay-val');
combDelaySlider.addEventListener('input', () => {
  const v = parseFloat(combDelaySlider.value);
  combDelayVal.textContent = `${v.toFixed(1)}ms`;
  synth.setCombDelay(v);
});

const combFbSlider = document.getElementById('comb-feedback');
const combFbVal = document.getElementById('comb-feedback-val');
combFbSlider.addEventListener('input', () => {
  const v = parseFloat(combFbSlider.value);
  combFbVal.textContent = v.toFixed(2);
  synth.setCombFeedback(v);
});

const combMixSlider = document.getElementById('comb-mix');
const combMixVal = document.getElementById('comb-mix-val');
combMixSlider.addEventListener('input', () => {
  const v = parseFloat(combMixSlider.value);
  combMixVal.textContent = v.toFixed(2);
  synth.setCombMix(v);
});

// Delay
document.getElementById('delay-bypass').addEventListener('change', (e) => {
  synth.setDelayEnabled(e.target.checked);
  document.getElementById('delay-unit').classList.toggle('bypassed', !e.target.checked);
});

const delayTimeSlider = document.getElementById('delay-time');
const delayTimeVal = document.getElementById('delay-time-val');
delayTimeSlider.addEventListener('input', () => {
  const v = parseFloat(delayTimeSlider.value);
  delayTimeVal.textContent = `${Math.round(v * 1000)}ms`;
  synth.setDelayTime(v);
});

const delayFbSlider = document.getElementById('delay-feedback');
const delayFbVal = document.getElementById('delay-feedback-val');
delayFbSlider.addEventListener('input', () => {
  const v = parseFloat(delayFbSlider.value);
  delayFbVal.textContent = v.toFixed(2);
  synth.setDelayFeedback(v);
});

const delayMixSlider = document.getElementById('delay-mix');
const delayMixVal = document.getElementById('delay-mix-val');
delayMixSlider.addEventListener('input', () => {
  const v = parseFloat(delayMixSlider.value);
  delayMixVal.textContent = v.toFixed(2);
  synth.setDelayMix(v);
});

// Limiter
document.getElementById('limiter-bypass').addEventListener('change', (e) => {
  synth.setLimiterEnabled(e.target.checked);
  document.getElementById('limiter-unit').classList.toggle('bypassed', !e.target.checked);
});

const limThreshSlider = document.getElementById('limiter-threshold');
const limThreshVal = document.getElementById('limiter-threshold-val');
limThreshSlider.addEventListener('input', () => {
  const v = parseFloat(limThreshSlider.value);
  limThreshVal.textContent = `${v.toFixed(1)}dB`;
  synth.setLimiterThreshold(v);
});

const limKneeSlider = document.getElementById('limiter-knee');
const limKneeVal = document.getElementById('limiter-knee-val');
limKneeSlider.addEventListener('input', () => {
  const v = parseFloat(limKneeSlider.value);
  limKneeVal.textContent = v.toFixed(1);
  synth.setLimiterKnee(v);
});

// ===================== KEYBOARD =====================
const keyboardEl = document.getElementById('keyboard');
const BLACK_KEYS = [1, 3, 6, 8, 10];
let baseOctave = 4;

function buildKeyboard() {
  keyboardEl.innerHTML = '';
  for (let oct = 0; oct < 2; oct++) {
    for (let i = 0; i < 12; i++) {
      const note = (baseOctave + oct) * 12 + i;
      const isBlack = BLACK_KEYS.includes(i);
      const key = document.createElement('div');
      key.className = `key ${isBlack ? 'key-black' : 'key-white'}`;
      key.dataset.note = note;
      key.addEventListener('mousedown', (e) => { e.preventDefault(); triggerNote(note, true, key); });
      key.addEventListener('mouseup', () => triggerNote(note, false, key));
      key.addEventListener('mouseleave', () => triggerNote(note, false, key));
      key.addEventListener('touchstart', (e) => { e.preventDefault(); triggerNote(note, true, key); });
      key.addEventListener('touchend', (e) => { e.preventDefault(); triggerNote(note, false, key); });
      keyboardEl.appendChild(key);
    }
  }
}
buildKeyboard();

function triggerNote(note, on, keyEl) {
  if (on) { synth.noteOn(note); if (keyEl) keyEl.classList.add('active'); }
  else { synth.noteOff(note); if (keyEl) keyEl.classList.remove('active'); }
}

const KEY_MAP = {
  'a': 0, 'w': 1, 's': 2, 'e': 3, 'd': 4,
  'f': 5, 't': 6, 'g': 7, 'y': 8, 'h': 9, 'u': 10, 'j': 11,
  'k': 12, 'o': 13, 'l': 14, 'p': 15, ';': 16,
};
const heldKeys = new Set();

function _isTypingTarget(el) {
  if (!el) return false;
  if (el.isContentEditable) return true;
  const tag = el.tagName;
  if (tag === 'TEXTAREA') return true;
  if (tag !== 'INPUT') return false;
  const type = (el.getAttribute('type') || '').toLowerCase();
  return ['text', 'search', 'url', 'email', 'password', 'tel'].includes(type);
}

// Capture keyboard at the document level so synth keys always play notes
// (and don't "type-ahead" into whatever control you last clicked).
document.addEventListener('keydown', (e) => {
  if (e.repeat) return;
  if (e.metaKey || e.ctrlKey || e.altKey) return;

  const key = e.key.toLowerCase();
  const isSynthKey = key === 'z' || key === 'x' || (key in KEY_MAP);
  if (!isSynthKey) return;

  if (_isTypingTarget(document.activeElement)) return;

  // Stop the focused control from consuming the key on macOS (and elsewhere).
  e.preventDefault();
  e.stopPropagation();

  const active = document.activeElement;
  if (active && active.tagName === 'SELECT') {
    try { active.blur(); } catch (err) {}
  }

  if (key === 'z') { baseOctave = Math.max(0, baseOctave - 1); buildKeyboard(); return; }
  if (key === 'x') { baseOctave = Math.min(8, baseOctave + 1); buildKeyboard(); return; }
  if (!heldKeys.has(key)) {
    heldKeys.add(key);
    const note = baseOctave * 12 + KEY_MAP[key];
    const keyEl = keyboardEl.querySelector(`[data-note="${note}"]`);
    triggerNote(note, true, keyEl);
  }
}, true);

document.addEventListener('keyup', (e) => {
  if (e.metaKey || e.ctrlKey || e.altKey) return;
  const key = e.key.toLowerCase();
  if (!(key in KEY_MAP)) return;
  if (!heldKeys.has(key)) return;
  if (_isTypingTarget(document.activeElement)) return;

  e.preventDefault();
  e.stopPropagation();

  heldKeys.delete(key);
  const note = baseOctave * 12 + KEY_MAP[key];
  const keyEl = keyboardEl.querySelector(`[data-note="${note}"]`);
  triggerNote(note, false, keyEl);
}, true);

// ===================== VISUALIZERS =====================
const scopeCanvas = document.getElementById('scope-canvas');
const scopeCtx = scopeCanvas.getContext('2d');
const specCanvas = document.getElementById('spectrum-canvas');
const specCtx = specCanvas.getContext('2d');
const meterCanvas = document.getElementById('meter-canvas');
const meterCtx = meterCanvas.getContext('2d');

let animId = null;
let spectrogramViz = null;

function startVisualizers() {
  if (animId) return;
  // Initialize spectrogram
  if (!spectrogramViz && synth.analyserFreq) {
    const sgCanvas = document.getElementById('spectrogram-canvas');
    if (sgCanvas) {
      spectrogramViz = new Spectrogram(sgCanvas, synth.analyserFreq);
    }
  }
  // Sync modulation to engine on first start
  syncModToEngine();

  let _eqFrameCount = 0;
  (function draw() {
    animId = requestAnimationFrame(draw);
    drawScope();
    drawSpectrum();
    drawMeter();
    // EQ frequency response is expensive — redraw at ~15 fps instead of 60
    if (++_eqFrameCount % 4 === 0) drawEQ();
    if (spectrogramViz) spectrogramViz.draw();
  })();
}

function drawScope() {
  const data = synth.getScopeData();
  if (!data) return;
  const w = scopeCanvas.width, h = scopeCanvas.height;
  scopeCtx.fillStyle = '#0a0a0f';
  scopeCtx.fillRect(0, 0, w, h);
  scopeCtx.strokeStyle = '#1a1a2a'; scopeCtx.lineWidth = 0.5;
  scopeCtx.beginPath(); scopeCtx.moveTo(0, h/2); scopeCtx.lineTo(w, h/2); scopeCtx.stroke();
  scopeCtx.strokeStyle = '#4a9eff'; scopeCtx.lineWidth = 1.5;
  scopeCtx.beginPath();
  // Only draw as many points as the canvas is wide (skip surplus samples)
  const ratio = data.length / w;
  for (let x = 0; x < w; x++) {
    const y = (1 - data[Math.floor(x * ratio)]) * h / 2;
    x === 0 ? scopeCtx.moveTo(x, y) : scopeCtx.lineTo(x, y);
  }
  scopeCtx.stroke();
}

function drawSpectrum() {
  const data = synth.getSpectrumData();
  if (!data) return;
  const w = specCanvas.width, h = specCanvas.height;
  specCtx.fillStyle = '#0a0a0f';
  specCtx.fillRect(0, 0, w, h);
  const bars = 96;
  const bw = w / bars;
  for (let i = 0; i < bars; i++) {
    const di = Math.floor(i * data.length / bars);
    const v = data[di] / 255;
    specCtx.fillStyle = `hsl(${200 + v * 40}, 80%, ${30 + v * 40}%)`;
    specCtx.fillRect(i * bw, h - v * h, bw - 1, v * h);
  }
}

// Pre-build meter gradient (doesn't change between frames)
const _meterGrad = (() => {
  const h = document.getElementById('meter-canvas').height;
  const g = document.getElementById('meter-canvas').getContext('2d').createLinearGradient(0, h, 0, 0);
  g.addColorStop(0, '#3ddc84'); g.addColorStop(0.6, '#3ddc84');
  g.addColorStop(0.8, '#ffaa33'); g.addColorStop(1, '#ff4d6a');
  return g;
})();

function drawMeter() {
  const level = synth.getLevel();
  const w = meterCanvas.width, h = meterCanvas.height;
  meterCtx.fillStyle = '#0a0a0f';
  meterCtx.fillRect(0, 0, w, h);
  const db = level > 0 ? 20 * Math.log10(level) : -100;
  const norm = Math.max(0, Math.min(1, (db + 60) / 60));
  const barH = norm * h;
  meterCtx.fillStyle = _meterGrad;
  meterCtx.fillRect(6, h - barH, w - 12, barH);
}

// ===================== DEFAULT STATE =====================
const DEFAULT_PATCH_CODE = "EJS2.eyJuYW1lIjoiUGF0Y2giLCJicG0iOjEyMCwibWFpbkdhaW4iOjAuMywidHJhbnNwb3NlIjowLCJ2b2ljZXMiOlt7IndhdmVmb3JtIjoic2luZSIsIm92ZXJ0b25lIjoxLCJnYWluIjowLjM2MzIzMDUwMDMzMTAxMTh9LHsid2F2ZWZvcm0iOiJzaW5lIiwib3ZlcnRvbmUiOjEsImdhaW4iOjAuNjIyMDQ4NjkxNzMzMjEzNn0seyJ3YXZlZm9ybSI6InNhd3Rvb3RoIiwib3ZlcnRvbmUiOjEsImdhaW4iOjAuNzkxNTk1MzM4NTY2MzA2NH0seyJ3YXZlZm9ybSI6InNxdWFyZSIsIm92ZXJ0b25lIjoxLCJnYWluIjowLjQzMzAyNzE0MzU1MTk3NDd9XSwibm9pc2UiOnsibGV2ZWwiOjAuNDE3MTM4MzEwMzg2ODY2OTQsImVuYWJsZWQiOmZhbHNlfSwiZW52ZWxvcGUiOnsiYXR0YWNrIjowLjAwMSwiZGVjYXkiOjAuNzM0LCJzdXN0YWluIjowLjEyLCJyZWxlYXNlIjoxLjY2OX0sImVxIjp7ImhpZ2hwYXNzIjp7ImZyZXF1ZW5jeSI6MTIxMi4xNzgwMjI0MjU0NzcxLCJRIjo0LjkzNzA3NTU2ODAyMzE0OCwiZ2FpbiI6MCwiZW5hYmxlZCI6ZmFsc2V9LCJwZWFrIjp7ImZyZXF1ZW5jeSI6NzYxOC4xODA4ODE0OTExMzMsIlEiOjEzLjkxNjQyMzI1MzIwNDE3NiwiZ2FpbiI6Mi40NTY2NTc2ODA1NzE1NDksImVuYWJsZWQiOmZhbHNlfSwibG93cGFzcyI6eyJmcmVxdWVuY3kiOjEzNzMzLjU2ODk4ODc3NDE4NSwiUSI6My4wMjIwMDk5MzU3OTIzNjM4LCJnYWluIjowLCJlbmFibGVkIjp0cnVlfX0sImxmb3MiOlt7ImVuYWJsZWQiOmZhbHNlLCJ3YXZlZm9ybSI6InNpbmUiLCJyYXRlQmVhdHMiOjEsInN0cmVuZ3RoIjowLjV9LHsiZW5hYmxlZCI6ZmFsc2UsIndhdmVmb3JtIjoic2luZSIsInJhdGVCZWF0cyI6MSwic3RyZW5ndGgiOjB9LHsiZW5hYmxlZCI6ZmFsc2UsIndhdmVmb3JtIjoic2luZSIsInJhdGVCZWF0cyI6MSwic3RyZW5ndGgiOjB9XSwibW9kdWxhdGlvbiI6W3siZW5hYmxlZCI6ZmFsc2UsIndhdmVmb3JtIjoic2F3dG9vdGgiLCJtb2RlIjoidHJpZ2dlciIsInRlbXBvU3luYyI6ZmFsc2UsInJhdGVCZWF0cyI6MiwicmF0ZUZyZWUiOjEuNjI1OTcyNzg1Mjk2Mjg2MiwiZGVwdGgiOjAuNTIyMDY5Njc5NDg4ODE4NCwicm91dGVzIjpbeyJ0YXJnZXRJZCI6Im9zYzMtcGl0Y2giLCJhbW91bnQiOi0wLjI1MzM3Njg1MzgwODQ2NjR9XSwiY3VzdG9tU2hhcGUiOm51bGx9LHsiZW5hYmxlZCI6dHJ1ZSwid2F2ZWZvcm0iOiJzYXd0b290aCIsIm1vZGUiOiJlbnZlbG9wZSIsInRlbXBvU3luYyI6dHJ1ZSwicmF0ZUJlYXRzIjoxLCJyYXRlRnJlZSI6OC43MiwiZGVwdGgiOjAuNTI5MDI5MzIxOTU1MTM1Niwicm91dGVzIjpbeyJ0YXJnZXRJZCI6ImNvbWItZGVsYXkiLCJhbW91bnQiOjAuNDI0OTkyMjc3Mzk0MDgzNzR9XSwiY3VzdG9tU2hhcGUiOm51bGx9XSwiZGlzdG9ydGlvbiI6eyJkcml2ZSI6MC44MTc4ODc3MDAyNTU3MzI3LCJ0b25lIjoxNTY3OS4zMDMxNzI1NjUwNjQsIm1peCI6MC4wODY5MjkyNDY3MjkyOTQwNywiZW5hYmxlZCI6dHJ1ZX0sInJldmVyYiI6eyJzaXplIjo0LjM1OTcxNDM4MDg3MDc5MSwiZGFtcCI6NzYxNS45NjUxMDc3NjIzMDUsIm1peCI6MC40OTM0NzM2MTY4NDU5OTEyLCJlbmFibGVkIjp0cnVlfSwiY29tYiI6eyJkZWxheSI6MjguNywiZmVlZGJhY2siOjAuMjQsIm1peCI6MC40NywiZW5hYmxlZCI6dHJ1ZX0sImRlbGF5Ijp7InRpbWUiOjAuOTM4MjM2MTk1MDI0MTQyMywiZmVlZGJhY2siOjAuNDA2ODA4NzAxMzE0MzI2LCJtaXgiOjAuMDUwODIxMDA0ODI3Njg0NjYsImVuYWJsZWQiOmZhbHNlfSwibGltaXRlciI6eyJ0aHJlc2hvbGQiOi04LjgzOTAwMDYzMjgzNDg2LCJrbmVlIjoxOS44NTY1MjE5NTQyNjg2MDgsImVuYWJsZWQiOnRydWV9fQ";
const DEFAULT_MIDI_URL = "midi/can-you-hear-the-music.mid";
const DEFAULT_MIDI_LABEL = "Can You Hear The Music";

async function loadDefaultMidi() {
  if (!DEFAULT_MIDI_URL || !midiUi.play || !midiUi.reset) return;
  try {
    const res = await fetch(DEFAULT_MIDI_URL, { cache: "no-store" });
    if (!res.ok) throw new Error(`HTTP ${res.status} fetching ${DEFAULT_MIDI_URL}`);
    const buf = await res.arrayBuffer();
    // If the user already loaded a file while we were fetching, don't overwrite it
    if (midiState.fileName && midiState.fileName !== DEFAULT_MIDI_LABEL) return;
    const parsed = parseMidiFile(buf);
    midiState.fileName = DEFAULT_MIDI_LABEL;
    midiState.events = parsed.events;
    midiState.durationSec = parsed.durationSec;
    midiState.positionSec = 0;
    midiState.nextIndex = 0;
    midiUi.play.disabled = !midiState.events.length;
    midiUi.reset.disabled = !midiState.events.length;
    setMidiStatus(`${DEFAULT_MIDI_LABEL} • ${formatTime(parsed.durationSec)}`);
  } catch (err) {
    console.warn("[EJ Synth] Default MIDI failed to load:", err);
    // Only disable if the user hasn't loaded something in the meantime
    if (!midiState.fileName) {
      midiUi.play.disabled = true;
      midiUi.reset.disabled = true;
      setMidiStatus("Default MIDI missing");
    }
  }
}

function loadDefaultPatch() {
  if (!DEFAULT_PATCH_CODE) return;
  try {
    const decoded = decodePatch(DEFAULT_PATCH_CODE);
    const p = normalizePatch(decoded);
    synth.loadPreset(p);
    synth.setBPM(p.bpm);
    document.getElementById('bpm').value = p.bpm;
    refreshUI(p);
    presetSelect.value = '';
  } catch (err) {
    console.warn("[EJ Synth] Default patch failed to load:", err);
  }
}

loadDefaultPatch();
loadDefaultMidi();
