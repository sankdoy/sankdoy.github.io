// The Synth Moment - Web Audio Engine
// Port of `the synth moment.maxpat` (simplified for the web).

class SynthEngine {
  constructor() {
    this.ctx = null;
    this.running = false;

    // Transport / globals
    this.bpm = 120;
    this.overtoneCoefficient = 1.0; // Max patch: "overtone coefficient (standard is 1)"

    // Envelope (Max patch: function object + domain dial)
    this.noteDurationMs = 2137; // Max patch default domain
    const baseDomain = 2137;
    this.envelopePoints = [
      { x: 0 / baseDomain, y: 0.0 },
      { x: 806.4549489224211 / baseDomain, y: 0.843615613778432 },
      { x: 1833.600879983699 / baseDomain, y: 0.806834007104238 },
      { x: 2137 / baseDomain, y: 0.610847808519999 },
    ];

    // Harmonic oscillators (16)
    this.oscConfigs = Array.from({ length: 16 }, (_, idx) => ({
      harmonic: idx + 1,
      waveform: 'sine',
      gainDb: idx === 0 ? -6 : -70,
    }));
    this.currentNote = 60;

    // Filters (NOTCH ~= peaking band, plus LP/HP)
    this.filterConfigs = {
      notch: { frequency: 1000, Q: 1.0, gainDb: 0.0 },
      lowpass: { frequency: 20000, Q: 0.5 },
      highpass: { frequency: 20, Q: 1.0 },
    };

    // Filter-frequency LFOs (3: notch, lowpass, highpass)
    this.lfoConfigs = [
      { enabled: false, waveform: 'sine', rateBeats: 4, strength: 0 }, // Notch
      { enabled: false, waveform: 'sine', rateBeats: 4, strength: 0 }, // Lowpass
      { enabled: false, waveform: 'sine', rateBeats: 4, strength: 0 }, // Highpass
    ];

    // Ring modulation (Max patch: modulation toggle + wave + frequency)
    this.ringModConfig = { enabled: false, waveform: 'sine', frequency: 0.1 };
    // Pitch-shift compensation (Max patch: Transp in cents, used only on mod path)
    this.pitchCompCents = 0;

    // Audio nodes (created in init)
    this.oscs = [];
    this.oscGains = [];
    this.oscMix = null;
    this.envGain = null;
    this.hp = null;
    this.notch = null;
    this.lp = null;
    this.ringModIn = null;
    this.ringModCarrier = null;
    this.ringModDry = null;
    this.ringModWet = null;
    this.ringModOut = null;
    this.ringModOsc = null;
    this.ringModDepth = null;
    this.mainGain = null;
    this.mainGainDb = 0;
    this.limiter = null;
    this.analyser = null;
    this.analyserFreq = null;

    this._scopeBuf = null;
    this._specBuf = null;
    this._levelBuf = null;

    // LFO nodes
    this.lfos = [];
  }

  async init() {
    if (this.ctx) return;

    this.ctx = new (window.AudioContext || window.webkitAudioContext)();

    // Mix + envelope
    this.oscMix = this.ctx.createGain();
    this.oscMix.gain.value = 1;

    this.envGain = this.ctx.createGain();
    this.envGain.gain.value = 0;
    this.oscMix.connect(this.envGain);

    // Filters: HP -> NOTCH(peaking) -> LP
    this.hp = this.ctx.createBiquadFilter();
    this.hp.type = 'highpass';
    this.hp.frequency.value = this.filterConfigs.highpass.frequency;
    this.hp.Q.value = this.filterConfigs.highpass.Q;

    this.notch = this.ctx.createBiquadFilter();
    this.notch.type = 'peaking';
    this.notch.frequency.value = this.filterConfigs.notch.frequency;
    this.notch.Q.value = this.filterConfigs.notch.Q;
    this.notch.gain.value = this.filterConfigs.notch.gainDb;

    this.lp = this.ctx.createBiquadFilter();
    this.lp.type = 'lowpass';
    this.lp.frequency.value = this.filterConfigs.lowpass.frequency;
    this.lp.Q.value = this.filterConfigs.lowpass.Q;

    this.envGain.connect(this.hp);
    this.hp.connect(this.notch);
    this.notch.connect(this.lp);

    // Ring mod insert (post filters)
    this._initRingMod();
    this.lp.connect(this.ringModIn);

    // Main gain (dB)
    this.mainGain = this.ctx.createGain();
    this.mainGain.gain.value = this._dbToAmp(this.mainGainDb);
    this.ringModOut.connect(this.mainGain);

    // Limiter (light safety)
    this.limiter = this.ctx.createDynamicsCompressor();
    this.limiter.threshold.value = -6;
    this.limiter.knee.value = 10;
    this.limiter.ratio.value = 20;
    this.limiter.attack.value = 0.003;
    this.limiter.release.value = 0.05;
    this.mainGain.connect(this.limiter);

    // Analysers
    this.analyser = this.ctx.createAnalyser();
    this.analyser.fftSize = 2048;
    this.analyserFreq = this.ctx.createAnalyser();
    this.analyserFreq.fftSize = 4096;
    this.analyserFreq.smoothingTimeConstant = 0.8;

    this.limiter.connect(this.analyser);
    this.analyser.connect(this.analyserFreq);
    this.analyserFreq.connect(this.ctx.destination);

    // Create harmonic oscillators (running continuously)
    for (let i = 0; i < 16; i++) {
      const cfg = this.oscConfigs[i];
      const osc = this.ctx.createOscillator();
      osc.type = cfg.waveform;
      const g = this.ctx.createGain();
      g.gain.value = this._dbToAmp(cfg.gainDb);
      osc.connect(g);
      g.connect(this.oscMix);
      osc.start();
      this.oscs.push(osc);
      this.oscGains.push(g);
    }

    this._updateOscFrequencies();

    // LFOs
    this._setupLFOs();

    this.running = true;
  }

  _initRingMod() {
    this.ringModIn = this.ctx.createGain();

    this.ringModCarrier = this.ctx.createGain();
    this.ringModCarrier.gain.value = 0;

    this.ringModDry = this.ctx.createGain();
    this.ringModWet = this.ctx.createGain();
    this.ringModOut = this.ctx.createGain();

    // Routing
    this.ringModIn.connect(this.ringModDry);
    this.ringModIn.connect(this.ringModCarrier);
    this.ringModCarrier.connect(this.ringModWet);
    this.ringModDry.connect(this.ringModOut);
    this.ringModWet.connect(this.ringModOut);

    // Mod oscillator
    this.ringModOsc = this.ctx.createOscillator();
    this.ringModOsc.type = this.ringModConfig.waveform;
    this.ringModOsc.frequency.value = this.ringModConfig.frequency;
    this.ringModDepth = this.ctx.createGain();
    this.ringModDepth.gain.value = 1;
    this.ringModOsc.connect(this.ringModDepth);
    this.ringModDepth.connect(this.ringModCarrier.gain);
    this.ringModOsc.start();

    this._routeRingMod();
  }

  _routeRingMod() {
    if (!this.ringModDry || !this.ringModWet) return;
    if (this.ringModConfig.enabled) {
      this.ringModDry.gain.value = 0;
      this.ringModWet.gain.value = 1;
    } else {
      this.ringModDry.gain.value = 1;
      this.ringModWet.gain.value = 0;
    }
  }

  _dbToAmp(db) {
    const d = Number(db);
    if (!Number.isFinite(d)) return 0;
    if (d <= -70) return 0;
    return Math.pow(10, d / 20);
  }

  _midiToFreq(note) {
    return 440 * Math.pow(2, (note - 69) / 12);
  }

  _updateOscFrequencies() {
    if (!this.ctx || !this.oscs.length) return;
    const now = this.ctx.currentTime;

    const cents = this.ringModConfig.enabled ? (this.pitchCompCents || 0) : 0;
    const baseFreq = this._midiToFreq(this.currentNote) * Math.pow(2, cents / 1200);
    const coeff = Number(this.overtoneCoefficient) || 0;

    for (let i = 0; i < 16; i++) {
      const harmonic = this.oscConfigs[i]?.harmonic ?? (i + 1);
      const f = Math.max(0.001, baseFreq * harmonic * coeff);
      this.oscs[i].frequency.setValueAtTime(f, now);
    }
  }

  _lfoRateHz(rateBeats) {
    const beats = Math.max(0.001, Number(rateBeats) || 0.001);
    return (this.bpm / 60) / beats;
  }

  _setupLFOs() {
    // Cleanup
    this.lfos.forEach(l => { try { l.osc.stop(); } catch (_) {} });
    this.lfos = [];

    const targets = [this.notch?.frequency, this.lp?.frequency, this.hp?.frequency];
    for (let i = 0; i < 3; i++) {
      const cfg = this.lfoConfigs[i];
      const osc = this.ctx.createOscillator();
      osc.type = cfg.waveform;
      osc.frequency.value = this._lfoRateHz(cfg.rateBeats);

      const gainNode = this.ctx.createGain();
      gainNode.gain.value = cfg.enabled ? cfg.strength : 0;
      osc.connect(gainNode);
      if (targets[i]) gainNode.connect(targets[i]);
      osc.start();

      this.lfos.push({ osc, gain: gainNode });
    }
  }

  // ========= Public API =========

  async toggle() {
    if (!this.ctx) { await this.init(); return true; }
    if (this.ctx.state === 'suspended') {
      await this.ctx.resume();
      this.running = true;
      return true;
    }
    await this.ctx.suspend();
    this.running = false;
    return false;
  }

  setBPM(v) {
    const bpm = Math.max(20, Math.min(300, Number(v) || 120));
    this.bpm = bpm;
    if (!this.running) return;
    for (let i = 0; i < this.lfos.length; i++) {
      this.lfos[i].osc.frequency.value = this._lfoRateHz(this.lfoConfigs[i].rateBeats);
    }
  }

  setMainGainDb(db) {
    this.mainGainDb = Number(db) || 0;
    if (!this.mainGain) return;
    this.mainGain.gain.value = this._dbToAmp(this.mainGainDb);
  }

  setOvertoneCoefficient(v) {
    const next = Math.max(0, Math.min(2, Number(v) || 0));
    this.overtoneCoefficient = next;
    this._updateOscFrequencies();
  }

  setNoteDurationMs(ms) {
    const next = Math.max(100, Math.min(20000, Number(ms) || 0));
    this.noteDurationMs = next;
  }

  setEnvelopePoints(points) {
    if (!Array.isArray(points) || points.length < 2) return;
    const cleaned = points
      .map(p => ({ x: Math.max(0, Math.min(1, Number(p.x) || 0)), y: Math.max(0, Math.min(1, Number(p.y) || 0)) }))
      .sort((a, b) => a.x - b.x);
    cleaned[0].x = 0;
    cleaned[cleaned.length - 1].x = 1;
    this.envelopePoints = cleaned;
  }

  triggerNote(note) {
    const n = Math.max(0, Math.min(127, Number(note) || 0));
    this.currentNote = n;
    this._updateOscFrequencies();
    this._triggerEnvelope();
  }

  _triggerEnvelope() {
    if (!this.ctx || !this.envGain) return;
    const now = this.ctx.currentTime;
    const g = this.envGain.gain;
    const pts = this.envelopePoints || [];
    const domain = Math.max(1, Number(this.noteDurationMs) || 1);

    g.cancelScheduledValues(now);
    g.setValueAtTime(0, now);
    for (const p of pts) {
      const t = now + (Math.max(0, Math.min(1, p.x)) * domain) / 1000;
      const v = Math.max(0, Math.min(1, p.y));
      g.linearRampToValueAtTime(v, t);
    }
  }

  setOscWaveform(i, waveform) {
    if (!this.oscConfigs[i]) return;
    this.oscConfigs[i].waveform = waveform;
    if (this.oscs[i]) this.oscs[i].type = waveform;
  }

  setOscGainDb(i, db) {
    if (!this.oscConfigs[i]) return;
    this.oscConfigs[i].gainDb = db;
    if (this.oscGains[i]) this.oscGains[i].gain.value = this._dbToAmp(db);
  }

  setNotchFrequency(v) {
    const f = Math.max(20, Math.min(20000, Number(v) || 20));
    this.filterConfigs.notch.frequency = f;
    if (this.notch) this.notch.frequency.value = f;
  }
  setNotchQ(v) {
    const q = Math.max(0.1, Math.min(30, Number(v) || 0.1));
    this.filterConfigs.notch.Q = q;
    if (this.notch) this.notch.Q.value = q;
  }
  setNotchGainDb(v) {
    const g = Math.max(-24, Math.min(24, Number(v) || 0));
    this.filterConfigs.notch.gainDb = g;
    if (this.notch) this.notch.gain.value = g;
  }

  setLowpassFrequency(v) {
    const f = Math.max(20, Math.min(20000, Number(v) || 20));
    this.filterConfigs.lowpass.frequency = f;
    if (this.lp) this.lp.frequency.value = f;
  }
  setLowpassQ(v) {
    const q = Math.max(0.1, Math.min(30, Number(v) || 0.1));
    this.filterConfigs.lowpass.Q = q;
    if (this.lp) this.lp.Q.value = q;
  }

  setHighpassFrequency(v) {
    const f = Math.max(20, Math.min(20000, Number(v) || 20));
    this.filterConfigs.highpass.frequency = f;
    if (this.hp) this.hp.frequency.value = f;
  }
  setHighpassQ(v) {
    const q = Math.max(0.1, Math.min(30, Number(v) || 0.1));
    this.filterConfigs.highpass.Q = q;
    if (this.hp) this.hp.Q.value = q;
  }

  updateLFO(index, prop, value) {
    if (index < 0 || index >= this.lfoConfigs.length) return;
    const cfg = this.lfoConfigs[index];
    cfg[prop] = value;
    if (!this.running || !this.lfos[index]) return;
    const lfo = this.lfos[index];
    if (prop === 'waveform') lfo.osc.type = value;
    else if (prop === 'rateBeats') lfo.osc.frequency.value = this._lfoRateHz(value);
    else if (prop === 'strength' || prop === 'enabled') lfo.gain.gain.value = cfg.enabled ? cfg.strength : 0;
  }

  setRingModEnabled(v) {
    this.ringModConfig.enabled = !!v;
    this._routeRingMod();
    this._updateOscFrequencies();
  }
  setRingModWaveform(waveform) {
    this.ringModConfig.waveform = waveform;
    if (this.ringModOsc) this.ringModOsc.type = waveform;
  }
  setRingModFrequency(v) {
    const f = Math.max(0.01, Math.min(5000, Number(v) || 0.01));
    this.ringModConfig.frequency = f;
    if (this.ringModOsc) this.ringModOsc.frequency.value = f;
  }

  setPitchCompCents(v) {
    const cents = Math.max(-2400, Math.min(0, Number(v) || 0));
    this.pitchCompCents = cents;
    this._updateOscFrequencies();
  }

  // ========= Visualizers =========
  getScopeData() {
    if (!this.analyser) return null;
    if (!this._scopeBuf || this._scopeBuf.length !== this.analyser.fftSize) {
      this._scopeBuf = new Float32Array(this.analyser.fftSize);
    }
    this.analyser.getFloatTimeDomainData(this._scopeBuf);
    return this._scopeBuf;
  }

  getSpectrumData() {
    if (!this.analyserFreq) return null;
    if (!this._specBuf || this._specBuf.length !== this.analyserFreq.frequencyBinCount) {
      this._specBuf = new Uint8Array(this.analyserFreq.frequencyBinCount);
    }
    this.analyserFreq.getByteFrequencyData(this._specBuf);
    return this._specBuf;
  }

  getLevel() {
    if (!this.analyser) return 0;
    if (!this._levelBuf || this._levelBuf.length !== this.analyser.fftSize) {
      this._levelBuf = new Float32Array(this.analyser.fftSize);
    }
    this.analyser.getFloatTimeDomainData(this._levelBuf);
    const d = this._levelBuf;
    let s = 0;
    for (let i = 0; i < d.length; i++) s += d[i] * d[i];
    return Math.sqrt(s / d.length);
  }

  getFilterResponse(which, freqs) {
    if (!this.running) return null;
    const node = which === 'notch' ? this.notch : which === 'lowpass' ? this.lp : which === 'highpass' ? this.hp : null;
    if (!node || typeof node.getFrequencyResponse !== 'function') return null;
    const fa = freqs instanceof Float32Array ? freqs : new Float32Array(freqs);
    const mag = new Float32Array(fa.length);
    const phase = new Float32Array(fa.length);
    node.getFrequencyResponse(fa, mag, phase);
    return mag;
  }
}

window.SynthEngine = SynthEngine;
