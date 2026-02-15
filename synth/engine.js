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
    this.noteReleaseMs = 420;
    this.maxVoices = 8;
    this.voices = [];
    this._nextVoiceId = 1;

    // Filters (NOTCH ~= peaking band, plus LP/HP)
    this.filterConfigs = {
      notch: { frequency: 1000, Q: 1.0, gainDb: 0.0 },
      lowpass: { frequency: 20000, Q: 0.5 },
      highpass: { frequency: 20, Q: 1.0 },
    };

    // Distortion (post-filters)
    this.distortionConfig = { enabled: false, type: 'soft', drive: 0.5, mix: 0.5 };

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
    this.voiceMix = null;
    this.hp = null;
    this.notch = null;
    this.lp = null;
    this.distIn = null;
    this.distPre = null;
    this.distShaper = null;
    this.distPost = null;
    this.distDry = null;
    this.distWet = null;
    this.distOut = null;
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
    this.outputCeiling = null;
    this.finalClipper = null;
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

    // Voice sum (poly) -> filters
    this.voiceMix = this.ctx.createGain();
    this.voiceMix.gain.value = 0.7;

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

    this.voiceMix.connect(this.hp);
    this.hp.connect(this.notch);
    this.notch.connect(this.lp);

    // Distortion (post filters)
    this._initDistortion();
    this.lp.connect(this.distIn);

    // Ring mod insert (post filters + distortion)
    this._initRingMod();
    this.distOut.connect(this.ringModIn);

    // Main gain (dB)
    this.mainGain = this.ctx.createGain();
    this.mainGain.gain.value = this._dbToAmp(this.mainGainDb);
    this.ringModOut.connect(this.mainGain);

    // Limiter (safety): compressor + ceiling gain + last-resort clipper.
    // Goal is to keep peaks under ~-0.1 dBFS to protect speakers.
    this.limiter = this.ctx.createDynamicsCompressor();
    this.limiter.threshold.value = -3.0;
    this.limiter.knee.value = 0.0;
    this.limiter.ratio.value = 20.0;
    this.limiter.attack.value = 0.001;
    this.limiter.release.value = 0.08;

    this.outputCeiling = this.ctx.createGain();
    this.outputCeiling.gain.value = this._dbToAmp(-0.1);

    this.finalClipper = this.ctx.createWaveShaper();
    this.finalClipper.oversample = '4x';
    this.finalClipper.curve = this._makeFinalLimiterCurve();

    this.mainGain.connect(this.limiter);
    this.limiter.connect(this.outputCeiling);
    this.outputCeiling.connect(this.finalClipper);

    // Analysers
    this.analyser = this.ctx.createAnalyser();
    this.analyser.fftSize = 2048;
    this.analyserFreq = this.ctx.createAnalyser();
    this.analyserFreq.fftSize = 4096;
    this.analyserFreq.smoothingTimeConstant = 0.8;

    this.finalClipper.connect(this.analyser);
    this.analyser.connect(this.analyserFreq);
    this.analyserFreq.connect(this.ctx.destination);

    // LFOs
    this._setupLFOs();

    this.running = true;
  }

  _makeFinalLimiterCurve() {
    // Transparent most of the time; gently saturates as a last line of defense.
    const n = 2048;
    const curve = new Float32Array(n);
    for (let i = 0; i < n; i++) {
      const x = (i / (n - 1)) * 2 - 1;
      // Soft clip using tanh approximation (fast, stable).
      const y = Math.tanh(2.3 * x);
      curve[i] = y;
    }
    return curve;
  }

  _makeDistortionCurve(type, drive) {
    const n = 2048;
    const curve = new Float32Array(n);
    const d = Math.max(0, Math.min(1, Number(drive) || 0));
    const k = 1 + d * 60;
    const t = (type || 'soft').toLowerCase();
    for (let i = 0; i < n; i++) {
      const x = (i / (n - 1)) * 2 - 1;
      let y;
      if (t === 'hard') {
        const a = 0.6 - d * 0.35;
        y = Math.max(-a, Math.min(a, x));
        y = y / Math.max(1e-6, a);
      } else {
        y = ((1 + k) * x) / (1 + k * Math.abs(x));
      }
      curve[i] = y;
    }
    return curve;
  }

  _initDistortion() {
    this.distIn = this.ctx.createGain();
    this.distPre = this.ctx.createGain();
    this.distShaper = this.ctx.createWaveShaper();
    this.distPost = this.ctx.createGain();
    this.distDry = this.ctx.createGain();
    this.distWet = this.ctx.createGain();
    this.distOut = this.ctx.createGain();

    this.distShaper.oversample = '4x';

    // Routing: in -> dry -> out, and in -> pre -> shaper -> post -> wet -> out
    this.distIn.connect(this.distDry);
    this.distDry.connect(this.distOut);
    this.distIn.connect(this.distPre);
    this.distPre.connect(this.distShaper);
    this.distShaper.connect(this.distPost);
    this.distPost.connect(this.distWet);
    this.distWet.connect(this.distOut);

    // Init params
    this._setDistortionType(this.distortionConfig.type);
    this._setDistortionDrive(this.distortionConfig.drive);
    this._routeDistortion();
  }

  _routeDistortion() {
    if (!this.ctx || !this.distDry || !this.distWet) return;
    const now = this.ctx.currentTime;
    const enabled = !!this.distortionConfig.enabled;
    const mix = Math.max(0, Math.min(1, Number(this.distortionConfig.mix) || 0));
    const dry = enabled ? (1 - mix) : 1;
    const wet = enabled ? mix : 0;

    this.distDry.gain.setTargetAtTime(dry, now, 0.02);
    this.distWet.gain.setTargetAtTime(wet, now, 0.02);
  }

  _setDistortionType(type) {
    this.distortionConfig.type = (type || 'soft').toLowerCase();
    if (!this.distShaper) return;
    this.distShaper.curve = this._makeDistortionCurve(this.distortionConfig.type, this.distortionConfig.drive);
  }

  _setDistortionDrive(drive) {
    const d = Math.max(0, Math.min(1, Number(drive) || 0));
    this.distortionConfig.drive = d;
    if (this.distPre) this.distPre.gain.value = 1 + d * 25;
    if (this.distPost) this.distPost.gain.value = 1 / (1 + d * 7);
    if (this.distShaper) this.distShaper.curve = this._makeDistortionCurve(this.distortionConfig.type, d);
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
    const now = this.ctx ? this.ctx.currentTime : 0;
    if (this.ringModConfig.enabled) {
      this.ringModDry.gain.setTargetAtTime(0, now, 0.02);
      this.ringModWet.gain.setTargetAtTime(1, now, 0.02);
    } else {
      this.ringModDry.gain.setTargetAtTime(1, now, 0.02);
      this.ringModWet.gain.setTargetAtTime(0, now, 0.02);
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

  _voiceBaseFreq(note) {
    const cents = this.ringModConfig.enabled ? (this.pitchCompCents || 0) : 0;
    return this._midiToFreq(note) * Math.pow(2, cents / 1200);
  }

  _applyVoiceFrequencies(voice, { when, glide = 0 } = {}) {
    if (!this.ctx || !voice?.oscs?.length) return;
    const t = Number.isFinite(when) ? when : this.ctx.currentTime;
    const baseFreq = this._voiceBaseFreq(voice.note);
    const coeff = Number(this.overtoneCoefficient) || 0;

    for (let i = 0; i < 16; i++) {
      const harmonic = this.oscConfigs[i]?.harmonic ?? (i + 1);
      const f = Math.max(0.001, baseFreq * harmonic * coeff);
      const osc = voice.oscs[i];
      if (!osc) continue;
      if (glide > 0) osc.frequency.setTargetAtTime(f, t, glide);
      else osc.frequency.setValueAtTime(f, t);
    }
  }

  _updateOscFrequencies() {
    if (!this.ctx || !this.voices.length) return;
    const now = this.ctx.currentTime;
    for (const v of this.voices) this._applyVoiceFrequencies(v, { when: now, glide: 0.015 });
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

      this.lfos.push({ osc, gain: gainNode, waveTimer: null });
    }
  }

  _createVoice(note) {
    const n = Math.max(0, Math.min(127, Number(note) || 0));
    const now = this.ctx.currentTime;

    const oscMix = this.ctx.createGain();
    oscMix.gain.value = 1;

    const envGain = this.ctx.createGain();
    envGain.gain.value = 0;

    oscMix.connect(envGain);
    envGain.connect(this.voiceMix);

    const voice = {
      id: this._nextVoiceId++,
      note: n,
      startedAt: now,
      releasing: false,
      oscMix,
      envGain,
      oscs: [],
      oscGains: [],
      cleanupTimer: null,
      cleaned: false,
    };

    for (let i = 0; i < 16; i++) {
      const cfg = this.oscConfigs[i];
      const osc = this.ctx.createOscillator();
      osc.type = cfg.waveform;

      const g = this.ctx.createGain();
      g.gain.value = this._dbToAmp(cfg.gainDb);

      osc.connect(g);
      g.connect(oscMix);

      voice.oscs.push(osc);
      voice.oscGains.push(g);
    }

    this._applyVoiceFrequencies(voice, { when: now, glide: 0 });
    for (const osc of voice.oscs) osc.start(now);
    this._triggerEnvelope(envGain.gain, now);

    return voice;
  }

  _chooseVoiceToSteal() {
    if (!this.voices.length) return null;
    const releasing = this.voices.find(v => v.releasing);
    if (releasing) return releasing;
    return this.voices.reduce((a, b) => (a.startedAt <= b.startedAt ? a : b));
  }

  _cleanupVoice(voice) {
    if (!voice || voice.cleaned) return;
    voice.cleaned = true;
    if (voice.cleanupTimer) {
      clearTimeout(voice.cleanupTimer);
      voice.cleanupTimer = null;
    }

    const idx = this.voices.findIndex(v => v.id === voice.id);
    if (idx >= 0) this.voices.splice(idx, 1);

    for (const osc of voice.oscs) {
      try { osc.disconnect(); } catch (_) {}
      try { osc.stop(); } catch (_) {}
    }
    for (const g of voice.oscGains) {
      try { g.disconnect(); } catch (_) {}
    }
    try { voice.oscMix.disconnect(); } catch (_) {}
    try { voice.envGain.disconnect(); } catch (_) {}
  }

  _stopVoice(voice, { fadeMs = 20 } = {}) {
    if (!this.ctx || !voice || voice.cleaned) return;
    if (voice.cleanupTimer) {
      clearTimeout(voice.cleanupTimer);
      voice.cleanupTimer = null;
    }

    const idx = this.voices.findIndex(v => v.id === voice.id);
    if (idx >= 0) this.voices.splice(idx, 1);

    voice.releasing = true;

    const now = this.ctx.currentTime;
    const g = voice.envGain.gain;
    const fadeSec = Math.max(0.005, (Number(fadeMs) || 0) / 1000);

    if (typeof g.cancelAndHoldAtTime === 'function') g.cancelAndHoldAtTime(now);
    else g.cancelScheduledValues(now);
    g.linearRampToValueAtTime(0, now + fadeSec);

    const stopAt = now + fadeSec + 0.03;
    for (const osc of voice.oscs) {
      try { osc.stop(stopAt); } catch (_) {}
    }

    voice.cleanupTimer = setTimeout(() => this._cleanupVoice(voice), (fadeSec + 0.08) * 1000);
  }

  _releaseVoice(voice) {
    if (!this.ctx || !voice || voice.cleaned || voice.releasing) return;
    voice.releasing = true;

    const now = this.ctx.currentTime;
    const g = voice.envGain.gain;
    const releaseSec = Math.max(0.01, (Number(this.noteReleaseMs) || 90) / 1000);

    if (typeof g.cancelAndHoldAtTime === 'function') g.cancelAndHoldAtTime(now);
    else g.cancelScheduledValues(now);
    g.linearRampToValueAtTime(0, now + releaseSec);

    const stopAt = now + releaseSec + 0.03;
    for (const osc of voice.oscs) {
      try { osc.stop(stopAt); } catch (_) {}
    }

    voice.cleanupTimer = setTimeout(() => this._cleanupVoice(voice), (releaseSec + 0.1) * 1000);
  }

  _killAllVoices() {
    if (!this.voices.length) return;
    const voices = this.voices.slice();
    for (const v of voices) this._cleanupVoice(v);
  }

  // ========= Public API =========

  async toggle() {
    if (!this.ctx) { await this.init(); return true; }
    if (this.ctx.state === 'suspended') {
      await this.ctx.resume();
      this.running = true;
      return true;
    }
    this._killAllVoices();
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

  setNoteReleaseMs(ms) {
    const next = Math.max(5, Math.min(10000, Number(ms) || 0));
    this.noteReleaseMs = next;
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

  noteOn(note) {
    if (!this.ctx || !this.running) return;
    const n = Math.max(0, Math.min(127, Number(note) || 0));
    this.currentNote = n;

    while (this.voices.length >= this.maxVoices) {
      const victim = this._chooseVoiceToSteal();
      if (!victim) break;
      this._stopVoice(victim, { fadeMs: 18 });
    }

    this.voices.push(this._createVoice(n));
  }

  noteOff(note) {
    if (!this.ctx || !this.running) return;
    const n = Math.max(0, Math.min(127, Number(note) || 0));
    for (const v of this.voices) {
      if (v.note === n) this._releaseVoice(v);
    }
  }

  triggerNote(note) {
    this.noteOn(note);
  }

  _triggerEnvelope(gainParam, now = this.ctx?.currentTime) {
    if (!this.ctx || !gainParam) return;
    const t0 = Number.isFinite(now) ? now : this.ctx.currentTime;
    const pts = this.envelopePoints || [];
    const domain = Math.max(1, Number(this.noteDurationMs) || 1);

    gainParam.cancelScheduledValues(t0);
    gainParam.setValueAtTime(0, t0);

    // If the last point is (near) zero, treat it as the "release-to-zero" tail.
    // While a key is held, we sustain at the penultimate point and only apply release on noteOff.
    const last = pts[pts.length - 1];
    const hasReleaseTail = pts.length >= 3 && (Number(last?.y) || 0) <= 0.02;
    const schedulePts = hasReleaseTail ? pts.slice(0, -1) : pts;

    for (const p of schedulePts) {
      const t = t0 + (Math.max(0, Math.min(1, p.x)) * domain) / 1000;
      const v = Math.max(0, Math.min(1, p.y));
      gainParam.linearRampToValueAtTime(v, t);
    }
  }

  setOscWaveform(i, waveform) {
    if (!this.oscConfigs[i]) return;
    this.oscConfigs[i].waveform = waveform;
    for (const v of this.voices) {
      const osc = v.oscs[i];
      if (osc) osc.type = waveform;
    }
  }

  setOscGainDb(i, db) {
    if (!this.oscConfigs[i]) return;
    this.oscConfigs[i].gainDb = db;
    if (!this.ctx) return;
    const amp = this._dbToAmp(db);
    const now = this.ctx.currentTime;
    for (const v of this.voices) {
      const g = v.oscGains[i];
      if (g) g.gain.setTargetAtTime(amp, now, 0.01);
    }
  }

  setNotchFrequency(v) {
    const f = Math.max(20, Math.min(20000, Number(v) || 20));
    this.filterConfigs.notch.frequency = f;
    if (this.notch && this.ctx) this.notch.frequency.setTargetAtTime(f, this.ctx.currentTime, 0.015);
  }
  setNotchQ(v) {
    const q = Math.max(0.1, Math.min(30, Number(v) || 0.1));
    this.filterConfigs.notch.Q = q;
    if (this.notch && this.ctx) this.notch.Q.setTargetAtTime(q, this.ctx.currentTime, 0.015);
  }
  setNotchGainDb(v) {
    const g = Math.max(-24, Math.min(24, Number(v) || 0));
    this.filterConfigs.notch.gainDb = g;
    if (this.notch && this.ctx) this.notch.gain.setTargetAtTime(g, this.ctx.currentTime, 0.015);
  }

  setLowpassFrequency(v) {
    const f = Math.max(20, Math.min(20000, Number(v) || 20));
    this.filterConfigs.lowpass.frequency = f;
    if (this.lp && this.ctx) this.lp.frequency.setTargetAtTime(f, this.ctx.currentTime, 0.015);
  }
  setLowpassQ(v) {
    const q = Math.max(0.1, Math.min(30, Number(v) || 0.1));
    this.filterConfigs.lowpass.Q = q;
    if (this.lp && this.ctx) this.lp.Q.setTargetAtTime(q, this.ctx.currentTime, 0.015);
  }

  setHighpassFrequency(v) {
    const f = Math.max(20, Math.min(20000, Number(v) || 20));
    this.filterConfigs.highpass.frequency = f;
    if (this.hp && this.ctx) this.hp.frequency.setTargetAtTime(f, this.ctx.currentTime, 0.015);
  }
  setHighpassQ(v) {
    const q = Math.max(0.1, Math.min(30, Number(v) || 0.1));
    this.filterConfigs.highpass.Q = q;
    if (this.hp && this.ctx) this.hp.Q.setTargetAtTime(q, this.ctx.currentTime, 0.015);
  }

  updateLFO(index, prop, value) {
    if (index < 0 || index >= this.lfoConfigs.length) return;
    const cfg = this.lfoConfigs[index];
    cfg[prop] = value;
    if (!this.running || !this.lfos[index]) return;
    const lfo = this.lfos[index];
    const now = this.ctx ? this.ctx.currentTime : 0;
    if (prop === 'waveform') {
      // Prevent clicks by fading the modulation depth down/up around the waveform swap.
      const tgt = cfg.enabled ? (Number(cfg.strength) || 0) : 0;
      lfo.gain.gain.setTargetAtTime(0, now, 0.01);
      if (lfo.waveTimer) clearTimeout(lfo.waveTimer);
      lfo.waveTimer = setTimeout(() => {
        if (!this.running || !this.lfos[index]) return;
        const cfgNow = this.lfoConfigs[index];
        const t = this.ctx ? this.ctx.currentTime : 0;
        const target = cfgNow.enabled ? (Number(cfgNow.strength) || 0) : 0;
        try { this.lfos[index].osc.type = cfgNow.waveform; } catch (_) {}
        this.lfos[index].gain.gain.setTargetAtTime(target, t, 0.02);
      }, 30);
    } else if (prop === 'rateBeats') lfo.osc.frequency.value = this._lfoRateHz(value);
    else if (prop === 'strength' || prop === 'enabled') {
      const target = cfg.enabled ? (Number(cfg.strength) || 0) : 0;
      lfo.gain.gain.setTargetAtTime(target, now, 0.02);
    }
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

  // ========= Distortion =========
  setDistortionEnabled(v) {
    this.distortionConfig.enabled = !!v;
    this._routeDistortion();
  }
  setDistortionType(type) {
    this._setDistortionType(type);
  }
  setDistortionDrive(v) {
    this._setDistortionDrive(v);
  }
  setDistortionMix(v) {
    this.distortionConfig.mix = Math.max(0, Math.min(1, Number(v) || 0));
    this._routeDistortion();
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
