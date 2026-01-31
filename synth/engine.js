// Edward Jarvis Synthesizer - Web Audio Engine

class SynthEngine {
  constructor() {
    this.ctx = null;
    this.running = false;
    this.bpm = 120;
    this.transpose = 0;
    this.mainGain = null;
    this.analyser = null;
    this.analyserFreq = null;

    this.activeVoices = new Map();

    this.voiceConfigs = [
      { waveform: 'sine', overtone: 1, gain: 0.5 },
      { waveform: 'sawtooth', overtone: 1, gain: 0.5 },
      { waveform: 'triangle', overtone: 1, gain: 0.5 },
      { waveform: 'square', overtone: 1, gain: 0.5 },
    ];

    this.envelope = { attack: 0.01, decay: 0.1, sustain: 0.7, release: 0.3 };

    // Parametric EQ bands
    this.eqConfigs = {
      highpass: { frequency: 80, Q: 0.7, gain: 0, enabled: true },
      peak:     { frequency: 1000, Q: 1, gain: 0, enabled: true },
      lowpass:  { frequency: 18000, Q: 0.7, gain: 0, enabled: true },
    };

    this.lfoConfigs = [
      { enabled: false, waveform: 'sine', rateBeats: 1, strength: 0.5 },
      { enabled: false, waveform: 'sine', rateBeats: 1, strength: 0 },
      { enabled: false, waveform: 'sine', rateBeats: 1, strength: 0 },
    ];
    this.lfos = [];

    // New modulation system
    this.modRouter = null;
    this.useNewModulation = false;

    this.combConfig = { delay: 5, feedback: 0.5, mix: 0, enabled: false };
    this.limiterConfig = { threshold: -3, knee: 10, enabled: true };
    this.distortionConfig = { drive: 0, tone: 8000, mix: 0, enabled: false };
    this.delayConfig = { time: 0.3, feedback: 0.3, mix: 0, enabled: false };
    this.reverbConfig = { size: 2.5, damp: 8000, mix: 0.2, enabled: false };
    this.noiseConfig = { level: 0, enabled: false };
  }

  async init() {
    this.ctx = new (window.AudioContext || window.webkitAudioContext)();

    this.mainGain = this.ctx.createGain();
    this.mainGain.gain.value = 0.7;

    this.analyser = this.ctx.createAnalyser();
    this.analyser.fftSize = 2048;

    this.analyserFreq = this.ctx.createAnalyser();
    this.analyserFreq.fftSize = 4096;
    this.analyserFreq.smoothingTimeConstant = 0.8;

    // Limiter
    this.limiter = this.ctx.createDynamicsCompressor();
    this.limiter.threshold.value = this.limiterConfig.threshold;
    this.limiter.knee.value = this.limiterConfig.knee;
    this.limiter.ratio.value = 20;
    this.limiter.attack.value = 0.003;
    this.limiter.release.value = 0.05;

    // Limiter bypass - both paths always wired, controlled by gain
    this.limiterIn = this.ctx.createGain();
    this.limiterOut = this.ctx.createGain();
    this.limiterBypass = this.ctx.createGain();
    this.limiterIn.connect(this.limiter);
    this.limiter.connect(this.limiterOut);
    this.limiterIn.connect(this.limiterBypass);
    this._routeLimiter();

    // Comb filter
    this.combDelay = this.ctx.createDelay(0.1);
    this.combDelay.delayTime.value = this.combConfig.delay / 1000;
    this.combFeedbackNode = this.ctx.createGain();
    this.combFeedbackNode.gain.value = this.combConfig.feedback;
    this.combDry = this.ctx.createGain();
    this.combDry.gain.value = 1;
    this.combWet = this.ctx.createGain();
    this.combWet.gain.value = 0;
    this.combIn = this.ctx.createGain();

    this.combDelay.connect(this.combFeedbackNode);
    this.combFeedbackNode.connect(this.combDelay);
    this.combIn.connect(this.combDry);
    this.combIn.connect(this.combDelay);
    this.combDelay.connect(this.combWet);

    // Comb bypass
    this.combOut = this.ctx.createGain();
    this.combBypassNode = this.ctx.createGain();
    this._routeComb();

    // Distortion
    this.distortionShaper = this.ctx.createWaveShaper();
    this.distortionShaper.oversample = '4x';
    this._updateDistortionCurve();
    this.distortionTone = this.ctx.createBiquadFilter();
    this.distortionTone.type = 'lowpass';
    this.distortionTone.frequency.value = this.distortionConfig.tone;
    this.distortionTone.Q.value = 0.7;
    this.distortionIn = this.ctx.createGain();
    this.distortionDry = this.ctx.createGain();
    this.distortionWet = this.ctx.createGain();
    this.distortionOut = this.ctx.createGain();
    this.distortionBypassNode = this.ctx.createGain();

    // Distortion signal: in -> shaper -> tone -> wet -> out
    this.distortionIn.connect(this.distortionShaper);
    this.distortionShaper.connect(this.distortionTone);
    this.distortionTone.connect(this.distortionWet);
    this.distortionWet.connect(this.distortionOut);
    // Dry path: in -> dry -> out
    this.distortionIn.connect(this.distortionDry);
    this.distortionDry.connect(this.distortionOut);
    // Bypass path
    this.distortionBypassNode.connect(this.distortionOut);
    this._routeDistortion();

    // Delay effect
    this.delayNode = this.ctx.createDelay(2.0);
    this.delayNode.delayTime.value = this.delayConfig.time;
    this.delayFeedbackNode = this.ctx.createGain();
    this.delayFeedbackNode.gain.value = this.delayConfig.feedback;
    this.delayIn = this.ctx.createGain();
    this.delayDry = this.ctx.createGain();
    this.delayWet = this.ctx.createGain();
    this.delayOut = this.ctx.createGain();
    this.delayBypassNode = this.ctx.createGain();

    // Delay signal: in -> delay -> wet -> out, delay -> feedback -> delay
    this.delayIn.connect(this.delayNode);
    this.delayNode.connect(this.delayFeedbackNode);
    this.delayFeedbackNode.connect(this.delayNode);
    this.delayNode.connect(this.delayWet);
    this.delayWet.connect(this.delayOut);
    // Dry: in -> dry -> out
    this.delayIn.connect(this.delayDry);
    this.delayDry.connect(this.delayOut);
    // Bypass
    this.delayBypassNode.connect(this.delayOut);
    this._routeDelay();

    // Reverb effect (convolver + damping)
    this.reverbConvolver = this.ctx.createConvolver();
    this.reverbDamp = this.ctx.createBiquadFilter();
    this.reverbDamp.type = 'lowpass';
    this.reverbDamp.frequency.value = this.reverbConfig.damp;
    this.reverbDamp.Q.value = 0.7;
    this.reverbIn = this.ctx.createGain();
    this.reverbDry = this.ctx.createGain();
    this.reverbWet = this.ctx.createGain();
    this.reverbOut = this.ctx.createGain();
    this.reverbBypassNode = this.ctx.createGain();

    this._updateReverbImpulse();

    // Reverb signal: in -> convolver -> damp -> wet -> out
    this.reverbIn.connect(this.reverbConvolver);
    this.reverbConvolver.connect(this.reverbDamp);
    this.reverbDamp.connect(this.reverbWet);
    this.reverbWet.connect(this.reverbOut);
    // Dry: in -> dry -> out
    this.reverbIn.connect(this.reverbDry);
    this.reverbDry.connect(this.reverbOut);
    // Bypass
    this.reverbBypassNode.connect(this.reverbOut);
    this._routeReverb();

    // White noise source
    this._createNoiseSource();
    this.noiseBus = this.ctx.createGain();
    this.noiseBus.gain.value = 1;
    this.noiseSource.connect(this.noiseBus);
    this.noiseSource.start();

    // EQ filters
    this.eqHP = this.ctx.createBiquadFilter();
    this.eqHP.type = 'highpass';
    this.eqHP.frequency.value = this.eqConfigs.highpass.frequency;
    this.eqHP.Q.value = this.eqConfigs.highpass.Q;

    this.eqPeak = this.ctx.createBiquadFilter();
    this.eqPeak.type = 'peaking';
    this.eqPeak.frequency.value = this.eqConfigs.peak.frequency;
    this.eqPeak.Q.value = this.eqConfigs.peak.Q;
    this.eqPeak.gain.value = this.eqConfigs.peak.gain;

    this.eqLP = this.ctx.createBiquadFilter();
    this.eqLP.type = 'lowpass';
    this.eqLP.frequency.value = this.eqConfigs.lowpass.frequency;
    this.eqLP.Q.value = this.eqConfigs.lowpass.Q;

    this.eqNodes = { highpass: this.eqHP, peak: this.eqPeak, lowpass: this.eqLP };

    // EQ bypass nodes - both paths always wired, controlled by gain
    this.eqBypass = {};
    for (const band of ['highpass', 'peak', 'lowpass']) {
      const inNode = this.ctx.createGain();
      const outNode = this.ctx.createGain();
      const filterGain = this.ctx.createGain();
      const directGain = this.ctx.createGain();
      // Path 1: in -> filter -> filterGain -> out
      inNode.connect(this.eqNodes[band]);
      this.eqNodes[band].connect(filterGain);
      filterGain.connect(outNode);
      // Path 2: in -> directGain -> out (bypass)
      inNode.connect(directGain);
      directGain.connect(outNode);
      this.eqBypass[band] = { in: inNode, out: outNode, filterGain, directGain };
    }
    this._routeEQ();

    // Voice bus
    this.voiceBus = this.ctx.createGain();
    this.voiceBus.gain.value = 1;

    // Noise merge point (before EQ)
    // (Noise is injected per-voice into envGain; this node is kept as a simple staging point.)
    this.noiseMerge = this.ctx.createGain();
    this.noiseMerge.gain.value = 1;

    // Signal chain: voiceBus (+ per-voice noise) -> EQ(HP->Peak->LP) -> Distortion -> Comb -> Delay -> Reverb -> Limiter -> analyser -> out
    this.voiceBus.connect(this.noiseMerge);

    this.noiseMerge.connect(this.eqBypass.highpass.in);
    this.eqBypass.highpass.out.connect(this.eqBypass.peak.in);
    this.eqBypass.peak.out.connect(this.eqBypass.lowpass.in);

    // EQ out -> Distortion (both paths)
    this.eqBypass.lowpass.out.connect(this.distortionIn);
    this.eqBypass.lowpass.out.connect(this.distortionBypassNode);

    // Distortion out -> Comb (both paths)
    this.distortionOut.connect(this.combIn);
    this.distortionOut.connect(this.combBypassNode);

    this.combDry.connect(this.combOut);
    this.combWet.connect(this.combOut);

    // Comb out -> Delay (both paths)
    this.combOut.connect(this.delayIn);
    this.combOut.connect(this.delayBypassNode);
    this.combBypassNode.connect(this.delayIn);
    this.combBypassNode.connect(this.delayBypassNode);

    // Delay out -> Reverb (both paths)
    this.delayOut.connect(this.reverbIn);
    this.delayOut.connect(this.reverbBypassNode);

    // Reverb out -> Limiter
    this.reverbOut.connect(this.limiterIn);

    this.limiterOut.connect(this.analyser);
    this.limiterBypass.connect(this.analyser);
    this.analyser.connect(this.analyserFreq);
    this.analyserFreq.connect(this.mainGain);

    // Hidden safety ceiling (-0.1 dBFS) to prevent speaker-blowing levels even if limiter is bypassed.
    this.safetyClipper = this.ctx.createWaveShaper();
    this.safetyClipper.oversample = '4x';
    this.safetyClipper.curve = this._createHardLimiterCurve(0.1);
    this.mainGain.connect(this.safetyClipper);
    this.safetyClipper.connect(this.ctx.destination);

    // Initialize modulation router if available
    if (typeof ModulationRouter !== 'undefined') {
      this.modRouter = new ModulationRouter(this);
      this.useNewModulation = true;
    } else {
      this._setupLFOs();
    }
    this.running = true;
  }

  _createNoiseSource() {
    const bufferSize = this.ctx.sampleRate * 2;
    const buffer = this.ctx.createBuffer(1, bufferSize, this.ctx.sampleRate);
    const data = buffer.getChannelData(0);
    for (let i = 0; i < bufferSize; i++) {
      data[i] = Math.random() * 2 - 1;
    }
    this.noiseBuffer = buffer;
    this.noiseSource = this.ctx.createBufferSource();
    this.noiseSource.buffer = buffer;
    this.noiseSource.loop = true;
  }

  _updateReverbImpulse() {
    if (!this.ctx || !this.reverbConvolver) return;
    const seconds = Math.max(0.05, Math.min(8, this.reverbConfig.size || 2.5));
    const length = Math.floor(this.ctx.sampleRate * seconds);
    const impulse = this.ctx.createBuffer(2, length, this.ctx.sampleRate);
    const decay = 3.5;
    const norm = 1 / Math.sqrt(length * 0.5);
    for (let ch = 0; ch < 2; ch++) {
      const data = impulse.getChannelData(ch);
      for (let i = 0; i < length; i++) {
        const t = i / length;
        const env = Math.pow(1 - t, decay);
        data[i] = (Math.random() * 2 - 1) * env * norm;
      }
    }
    this.reverbConvolver.buffer = impulse;
  }

  _createHardLimiterCurve(ceilingDb = 0.1) {
    const samples = 2048;
    const curve = new Float32Array(samples);
    const ceiling = Math.pow(10, -(Math.max(0, ceilingDb) / 20)); // e.g. 0.1 dB -> ~0.9886
    for (let i = 0; i < samples; i++) {
      const x = (i * 2) / (samples - 1) - 1;
      curve[i] = Math.max(-ceiling, Math.min(ceiling, x));
    }
    return curve;
  }

  _updateDistortionCurve() {
    if (!this.distortionShaper) return;
    const drive = this.distortionConfig.drive;
    const samples = 256;
    if (!this._distCurve) this._distCurve = new Float32Array(samples);
    const curve = this._distCurve;
    if (drive <= 0) {
      for (let i = 0; i < samples; i++) {
        curve[i] = (i * 2) / samples - 1;
      }
    } else {
      const k = drive * 100;
      for (let i = 0; i < samples; i++) {
        const x = (i * 2) / samples - 1;
        curve[i] = ((1 + k) * x) / (1 + k * Math.abs(x));
      }
    }
    this.distortionShaper.curve = curve;
  }

  _routeEQ() {
    for (const band of ['highpass', 'peak', 'lowpass']) {
      const bp = this.eqBypass[band];
      if (this.eqConfigs[band].enabled) {
        bp.filterGain.gain.value = 1;
        bp.directGain.gain.value = 0;
      } else {
        bp.filterGain.gain.value = 0;
        bp.directGain.gain.value = 1;
      }
    }
  }

  _routeComb() {
    if (this.combConfig.enabled) {
      this.combDry.gain.value = 1 - this.combConfig.mix;
      this.combWet.gain.value = this.combConfig.mix;
      this.combBypassNode.gain.value = 0;
    } else {
      this.combDry.gain.value = 0;
      this.combWet.gain.value = 0;
      this.combBypassNode.gain.value = 1;
    }
  }

  _routeLimiter() {
    if (this.limiterConfig.enabled) {
      this.limiterBypass.gain.value = 0;
      this.limiterOut.gain.value = 1;
    } else {
      this.limiterOut.gain.value = 0;
      this.limiterBypass.gain.value = 1;
    }
  }

  _routeDistortion() {
    if (this.distortionConfig.enabled) {
      this.distortionDry.gain.value = 1 - this.distortionConfig.mix;
      this.distortionWet.gain.value = this.distortionConfig.mix;
      this.distortionBypassNode.gain.value = 0;
    } else {
      this.distortionDry.gain.value = 0;
      this.distortionWet.gain.value = 0;
      this.distortionBypassNode.gain.value = 1;
    }
  }

  _routeDelay() {
    if (this.delayConfig.enabled) {
      this.delayDry.gain.value = 1 - this.delayConfig.mix;
      this.delayWet.gain.value = this.delayConfig.mix;
      this.delayBypassNode.gain.value = 0;
    } else {
      this.delayDry.gain.value = 0;
      this.delayWet.gain.value = 0;
      this.delayBypassNode.gain.value = 1;
    }
  }

  _routeReverb() {
    if (this.reverbConfig.enabled) {
      this.reverbDry.gain.value = 1 - this.reverbConfig.mix;
      this.reverbWet.gain.value = this.reverbConfig.mix;
      this.reverbBypassNode.gain.value = 0;
    } else {
      this.reverbDry.gain.value = 0;
      this.reverbWet.gain.value = 0;
      this.reverbBypassNode.gain.value = 1;
    }
  }

  _setupLFOs() {
    this.lfos.forEach(l => { try { l.osc.stop(); } catch (e) {} });
    this.lfos = [];

    for (let i = 0; i < 3; i++) {
      const cfg = this.lfoConfigs[i];
      const osc = this.ctx.createOscillator();
      osc.type = cfg.waveform;
      osc.frequency.value = this._lfoRateHz(cfg.rateBeats);

      const gainNode = this.ctx.createGain();
      gainNode.gain.value = cfg.enabled ? cfg.strength : 0;

      osc.connect(gainNode);
      osc.start();

      this.lfos.push({ osc, gain: gainNode });

      if (i === 0) gainNode.connect(this.voiceBus.gain);
      else if (i === 2) {
        gainNode.connect(this.eqLP.frequency);
        gainNode.connect(this.eqHP.frequency);
      }
    }
  }

  _lfoRateHz(rateBeats) {
    return (this.bpm / 60) / rateBeats;
  }

  updateLFO(index, prop, value) {
    const cfg = this.lfoConfigs[index];
    cfg[prop] = value;
    if (!this.running || !this.lfos[index]) return;
    const lfo = this.lfos[index];
    if (prop === 'waveform') lfo.osc.type = value;
    else if (prop === 'rateBeats') lfo.osc.frequency.value = this._lfoRateHz(value);
    else if (prop === 'strength' || prop === 'enabled') lfo.gain.gain.value = cfg.enabled ? cfg.strength : 0;
  }

  midiToFreq(note) {
    return 440 * Math.pow(2, (note - 69) / 12);
  }

  noteOn(note) {
    if (!this.running) return;
    if (this.activeVoices.has(note)) this.noteOff(note);

    const freq = this.midiToFreq(note + this.transpose);
    const now = this.ctx.currentTime;
    const env = this.envelope;

    const voice = { oscillators: [], gains: [], envGain: null, noiseTap: null, noteOnTime: now, envAtOn: { ...env } };
    const envGain = this.ctx.createGain();
    envGain.gain.setValueAtTime(0, now);
    envGain.gain.linearRampToValueAtTime(1, now + env.attack);
    envGain.gain.linearRampToValueAtTime(env.sustain, now + env.attack + env.decay);
    voice.envGain = envGain;

    // Noise (shares one global noise source; per-voice tap is shaped by the envelope)
    // Scale noiseBus gain inversely with voice count so total noise stays constant.
    if (this.noiseBus) {
      const noiseTap = this.ctx.createGain();
      noiseTap.gain.value = this.noiseConfig.enabled ? this.noiseConfig.level : 0;
      this.noiseBus.connect(noiseTap);
      noiseTap.connect(envGain);
      voice.noiseTap = noiseTap;
      this.noiseBus.gain.value = 1 / Math.max(1, this.activeVoices.size + 1);
    }

    for (const vc of this.voiceConfigs) {
      const osc = this.ctx.createOscillator();
      osc.type = vc.waveform;
      osc.frequency.value = freq * vc.overtone;

      // Legacy LFO pitch modulation
      if (!this.useNewModulation && this.lfoConfigs[1].enabled && this.lfos[1]) {
        this.lfos[1].gain.connect(osc.frequency);
      }

      const g = this.ctx.createGain();
      g.gain.value = vc.gain;
      osc.connect(g);
      g.connect(envGain);
      osc.start(now);
      voice.oscillators.push(osc);
      voice.gains.push(g);
    }

    envGain.connect(this.voiceBus);
    this.activeVoices.set(note, voice);

    // New modulation: connect pitch/gain LFOs to this voice and trigger retrigger modes
    if (this.modRouter) {
      this.modRouter.connectPitchToVoice(voice);
      this.modRouter.connectGainToVoice(voice);
      this.modRouter.onNoteOn(note);
    }
  }

  noteOff(note) {
    if (!this.running) return;
    const voice = this.activeVoices.get(note);
    if (!voice) return;

    const now = this.ctx.currentTime;
    const rel = this.envelope.release;
    const g = voice.envGain.gain;

    const env = voice.envAtOn || this.envelope;
    const t = Math.max(0, now - (voice.noteOnTime ?? now));
    let v = 0;
    if (t < env.attack) {
      v = env.attack <= 0 ? 1 : (t / env.attack);
    } else if (t < env.attack + env.decay) {
      const dt = t - env.attack;
      const a = env.decay <= 0 ? 1 : (dt / env.decay);
      v = 1 + (env.sustain - 1) * a;
    } else {
      v = env.sustain;
    }
    v = Math.max(0, Math.min(1, v));

    g.cancelScheduledValues(now);
    g.setValueAtTime(v, now);
    g.linearRampToValueAtTime(0, now + rel);

    setTimeout(() => {
      voice.oscillators.forEach(o => { try { o.stop(); } catch (e) {} });
      if (voice.noiseTap && this.noiseBus) {
        try { this.noiseBus.disconnect(voice.noiseTap); } catch (e) {}
        try { voice.noiseTap.disconnect(); } catch (e) {}
        // Re-scale noise bus for remaining voices
        this.noiseBus.gain.value = 1 / Math.max(1, this.activeVoices.size);
      }
      // Clean up modulation gain nodes for this voice
      if (voice._modGains) {
        voice._modGains.forEach(g => { try { g.disconnect(); } catch (e) {} });
      }
      try { voice.envGain.disconnect(); } catch (e) {}
    }, (rel + 0.05) * 1000);

    if (this.modRouter) this.modRouter.onNoteOff(note);
    this.activeVoices.delete(note);
  }

  // === Setters ===

  setMainGain(v) { if (this.mainGain) this.mainGain.gain.value = v; }

  setBPM(v) {
    this.bpm = v;
    if (this.running && !this.useNewModulation) {
      this.lfos.forEach((l, i) => { l.osc.frequency.value = this._lfoRateHz(this.lfoConfigs[i].rateBeats); });
    }
    if (this.modRouter) this.modRouter.updateAllRates();
  }

  setTranspose(v) { this.transpose = v; }
  setVoiceConfig(i, prop, value) { this.voiceConfigs[i][prop] = value; }
  setEnvelope(prop, value) { this.envelope[prop] = value; }

  setEQ(band, prop, value) {
    this.eqConfigs[band][prop] = value;
    if (!this.running) return;
    const node = this.eqNodes[band];
    if (prop === 'frequency') node.frequency.value = value;
    else if (prop === 'Q') node.Q.value = value;
    else if (prop === 'gain') node.gain.value = value;
  }

  setEQBypass(band, enabled) {
    this.eqConfigs[band].enabled = enabled;
    if (this.running) this._routeEQ();
  }

  setCombEnabled(v) { this.combConfig.enabled = v; if (this.running) this._routeComb(); }
  setCombDelay(v) { this.combConfig.delay = v; if (this.combDelay) this.combDelay.delayTime.value = v / 1000; }
  setCombFeedback(v) { this.combConfig.feedback = v; if (this.combFeedbackNode) this.combFeedbackNode.gain.value = v; }
  setCombMix(v) {
    this.combConfig.mix = v;
    if (this.combConfig.enabled) {
      if (this.combDry) this.combDry.gain.value = 1 - v;
      if (this.combWet) this.combWet.gain.value = v;
    }
  }

  setLimiterEnabled(v) { this.limiterConfig.enabled = v; if (this.running) this._routeLimiter(); }
  setLimiterThreshold(v) { this.limiterConfig.threshold = v; if (this.limiter) this.limiter.threshold.value = v; }
  setLimiterKnee(v) { this.limiterConfig.knee = v; if (this.limiter) this.limiter.knee.value = v; }

  // Distortion
  setDistortionEnabled(v) { this.distortionConfig.enabled = v; if (this.running) this._routeDistortion(); }
  setDistortionDrive(v) { this.distortionConfig.drive = v; this._updateDistortionCurve(); }
  setDistortionTone(v) { this.distortionConfig.tone = v; if (this.distortionTone) this.distortionTone.frequency.value = v; }
  setDistortionMix(v) {
    this.distortionConfig.mix = v;
    if (this.distortionConfig.enabled) {
      if (this.distortionDry) this.distortionDry.gain.value = 1 - v;
      if (this.distortionWet) this.distortionWet.gain.value = v;
    }
  }

  // Delay
  setDelayEnabled(v) { this.delayConfig.enabled = v; if (this.running) this._routeDelay(); }
  setDelayTime(v) { this.delayConfig.time = v; if (this.delayNode) this.delayNode.delayTime.value = v; }
  setDelayFeedback(v) { this.delayConfig.feedback = v; if (this.delayFeedbackNode) this.delayFeedbackNode.gain.value = v; }
  setDelayMix(v) {
    this.delayConfig.mix = v;
    if (this.delayConfig.enabled) {
      if (this.delayDry) this.delayDry.gain.value = 1 - v;
      if (this.delayWet) this.delayWet.gain.value = v;
    }
  }

  // Reverb
  setReverbEnabled(v) { this.reverbConfig.enabled = v; if (this.running) this._routeReverb(); }
  setReverbSize(v) { this.reverbConfig.size = v; if (this.running) this._updateReverbImpulse(); }
  setReverbDamp(v) { this.reverbConfig.damp = v; if (this.reverbDamp) this.reverbDamp.frequency.value = v; }
  setReverbMix(v) {
    this.reverbConfig.mix = v;
    if (this.reverbConfig.enabled) {
      if (this.reverbDry) this.reverbDry.gain.value = 1 - v;
      if (this.reverbWet) this.reverbWet.gain.value = v;
    }
  }

  // Noise
  setNoiseEnabled(v) {
    this.noiseConfig.enabled = v;
    if (!this.running) return;
    for (const voice of this.activeVoices.values()) {
      if (voice.noiseTap) voice.noiseTap.gain.value = v ? Math.max(0, Math.min(0.5, this.noiseConfig.level)) : 0;
    }
  }
  setNoiseLevel(v) {
    const clamped = Math.max(0, Math.min(0.5, v));
    this.noiseConfig.level = clamped;
    if (!this.running || !this.noiseConfig.enabled) return;
    for (const voice of this.activeVoices.values()) {
      if (voice.noiseTap) voice.noiseTap.gain.value = clamped;
    }
  }

  // EQ frequency response for visualization
  getEQResponse(frequencies) {
    if (!this.running) return null;
    const n = frequencies.length;
    const freqArray = new Float32Array(frequencies);
    const combined = new Float32Array(n).fill(0);

    for (const band of ['highpass', 'peak', 'lowpass']) {
      if (!this.eqConfigs[band].enabled) continue;
      const mag = new Float32Array(n);
      const phase = new Float32Array(n);
      this.eqNodes[band].getFrequencyResponse(freqArray, mag, phase);
      for (let i = 0; i < n; i++) {
        combined[i] += 20 * Math.log10(mag[i]);
      }
    }
    return combined;
  }

  // Per-band response for individual curve drawing (reuses buffers)
  getBandResponse(band, frequencies) {
    if (!this.running || !this.eqConfigs[band].enabled) return null;
    const n = frequencies.length;
    if (!this._eqFreqBuf || this._eqFreqBuf.length !== n) {
      this._eqFreqBuf = new Float32Array(n);
      this._eqMagBuf = new Float32Array(n);
      this._eqPhaseBuf = new Float32Array(n);
      this._eqDbBuf = new Float32Array(n);
    }
    // Copy frequencies into typed array (in case plain array is passed)
    const fa = this._eqFreqBuf;
    for (let i = 0; i < n; i++) fa[i] = frequencies[i];
    this.eqNodes[band].getFrequencyResponse(fa, this._eqMagBuf, this._eqPhaseBuf);
    const db = this._eqDbBuf;
    for (let i = 0; i < n; i++) db[i] = 20 * Math.log10(this._eqMagBuf[i]);
    return db;
  }

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
    // Reuse scope buffer if available, otherwise allocate once
    if (!this._levelBuf || this._levelBuf.length !== this.analyser.fftSize) {
      this._levelBuf = new Float32Array(this.analyser.fftSize);
    }
    this.analyser.getFloatTimeDomainData(this._levelBuf);
    const d = this._levelBuf;
    let s = 0;
    for (let i = 0; i < d.length; i++) s += d[i] * d[i];
    return Math.sqrt(s / d.length);
  }

  async toggle() {
    if (!this.ctx) { await this.init(); return true; }
    if (this.ctx.state === 'suspended') { await this.ctx.resume(); this.running = true; return true; }
    await this.ctx.suspend(); this.running = false; return false;
  }

  // Load a full preset object
  loadPreset(p) {
    this.voiceConfigs = p.voices.map(v => ({ ...v }));
    this.envelope = { ...p.envelope };
    this.transpose = p.transpose;

    for (const band of ['highpass', 'peak', 'lowpass']) {
      if (p.eq[band]) {
        Object.assign(this.eqConfigs[band], p.eq[band]);
        if (this.running) {
          const n = this.eqNodes[band];
          n.frequency.value = this.eqConfigs[band].frequency;
          n.Q.value = this.eqConfigs[band].Q;
          if (band === 'peak') n.gain.value = this.eqConfigs[band].gain;
          this.eqConfigs[band].enabled = p.eq[band].enabled !== false;
        }
      }
    }
    if (this.running) this._routeEQ();

    // Legacy LFO loading (for old presets or when new system not active)
    if (!this.useNewModulation && p.lfos) {
      for (let i = 0; i < 3; i++) {
        Object.assign(this.lfoConfigs[i], p.lfos[i]);
        if (this.running && this.lfos[i]) {
          this.lfos[i].osc.type = this.lfoConfigs[i].waveform;
          this.lfos[i].osc.frequency.value = this._lfoRateHz(this.lfoConfigs[i].rateBeats);
          this.lfos[i].gain.gain.value = this.lfoConfigs[i].enabled ? this.lfoConfigs[i].strength : 0;
        }
      }
    }
    // New modulation is loaded via app.js calling modRouter.init()

    Object.assign(this.combConfig, p.comb);
    if (this.running) {
      this.combDelay.delayTime.value = this.combConfig.delay / 1000;
      this.combFeedbackNode.gain.value = this.combConfig.feedback;
      this._routeComb();
    }

    Object.assign(this.limiterConfig, p.limiter);
    if (this.running) {
      this.limiter.threshold.value = this.limiterConfig.threshold;
      this.limiter.knee.value = this.limiterConfig.knee;
      this._routeLimiter();
    }

    // Distortion
    if (p.distortion) {
      Object.assign(this.distortionConfig, p.distortion);
      this._updateDistortionCurve();
      if (this.running) {
        this.distortionTone.frequency.value = this.distortionConfig.tone;
        this._routeDistortion();
      }
    } else {
      this.distortionConfig = { drive: 0, tone: 8000, mix: 0, enabled: false };
      this._updateDistortionCurve();
      if (this.running) this._routeDistortion();
    }

    // Delay
    if (p.delay) {
      Object.assign(this.delayConfig, p.delay);
      if (this.running) {
        this.delayNode.delayTime.value = this.delayConfig.time;
        this.delayFeedbackNode.gain.value = this.delayConfig.feedback;
        this._routeDelay();
      }
    } else {
      this.delayConfig = { time: 0.3, feedback: 0.3, mix: 0, enabled: false };
      if (this.running) this._routeDelay();
    }

    // Reverb
    if (p.reverb) {
      Object.assign(this.reverbConfig, p.reverb);
      if (this.running) {
        this._updateReverbImpulse();
        if (this.reverbDamp) this.reverbDamp.frequency.value = this.reverbConfig.damp;
        this._routeReverb();
      }
    } else {
      this.reverbConfig = { size: 2.5, damp: 8000, mix: 0.2, enabled: false };
      if (this.running) {
        this._updateReverbImpulse();
        this._routeReverb();
      }
    }

    // Noise
    if (p.noise) {
      Object.assign(this.noiseConfig, p.noise);
    } else {
      this.noiseConfig = { level: 0, enabled: false };
    }
    if (this.running) {
      for (const voice of this.activeVoices.values()) {
        if (voice.noiseTap) voice.noiseTap.gain.value = this.noiseConfig.enabled ? this.noiseConfig.level : 0;
      }
    }

    if (this.mainGain) this.mainGain.gain.value = p.mainGain;
  }
}

window.SynthEngine = SynthEngine;
