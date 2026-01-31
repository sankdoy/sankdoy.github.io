// EJ Synth - Modulation System (LFO with routing, modes, custom shapes)

const MOD_TARGETS = {
  'main-gain':   { label: 'Main Gain',   range: [0, 1],      scale: 1,    unit: '' },
  'osc1-gain':   { label: 'Osc 1 Vol',   range: [0, 1],      scale: 1,    unit: '' },
  'osc2-gain':   { label: 'Osc 2 Vol',   range: [0, 1],      scale: 1,    unit: '' },
  'osc3-gain':   { label: 'Osc 3 Vol',   range: [0, 1],      scale: 1,    unit: '' },
  'osc4-gain':   { label: 'Osc 4 Vol',   range: [0, 1],      scale: 1,    unit: '' },
  'all-pitch':   { label: 'All Pitch',   range: [0, 200],    scale: 200,  unit: 'cents' },
  'osc1-pitch':  { label: 'Osc 1 Pitch', range: [0, 200],    scale: 200,  unit: 'cents' },
  'osc2-pitch':  { label: 'Osc 2 Pitch', range: [0, 200],    scale: 200,  unit: 'cents' },
  'osc3-pitch':  { label: 'Osc 3 Pitch', range: [0, 200],    scale: 200,  unit: 'cents' },
  'osc4-pitch':  { label: 'Osc 4 Pitch', range: [0, 200],    scale: 200,  unit: 'cents' },
  'eq-hp-freq':  { label: 'HP Freq',     range: [20, 2000],  scale: 2000, unit: 'Hz' },
  'eq-pk-freq':  { label: 'Peak Freq',   range: [80, 16000], scale: 8000, unit: 'Hz' },
  'eq-lp-freq':  { label: 'LP Freq',     range: [200, 20000],scale: 5000, unit: 'Hz' },
  'eq-pk-gain':  { label: 'Peak Gain',   range: [-18, 18],   scale: 18,   unit: 'dB' },
  'dist-drive':  { label: 'Dist Drive',  range: [0, 1],      scale: 1,    unit: '', jsPolled: true },
  'dist-tone':   { label: 'Dist Tone',   range: [200, 20000],scale: 5000, unit: 'Hz' },
  'delay-time':  { label: 'Delay Time',  range: [0.01, 2],   scale: 0.5,  unit: 's' },
  'delay-fdbk':  { label: 'Delay Fdbk',  range: [0, 0.95],   scale: 0.5,  unit: '' },
  'reverb-mix':  { label: 'Reverb Mix',  range: [0, 1],      scale: 0.5,  unit: '' },
  'comb-delay':  { label: 'Comb Delay',  range: [0.1, 50],   scale: 10,   unit: 'ms' },
  'comb-fdbk':   { label: 'Comb Fdbk',   range: [0, 0.99],   scale: 0.5,  unit: '' },
  'noise-level': { label: 'Noise Level', range: [0, 1],      scale: 0.5,  unit: '', jsPolled: true },
};

// Generate a standard waveform value at phase t (0-1)
function evalWaveform(type, t) {
  t = t % 1;
  switch (type) {
    case 'sine':     return Math.sin(t * Math.PI * 2);
    case 'triangle': return 1 - 4 * Math.abs(t - 0.5);
    case 'sawtooth': return 2 * t - 1;
    case 'square':   return t < 0.5 ? 1 : -1;
    default:         return Math.sin(t * Math.PI * 2);
  }
}

// ===================== LFO Shape Editor =====================
class LFOShapeEditor {
  constructor(canvas, lfoIndex, onChange) {
    this.canvas = canvas;
    this.ctx = canvas.getContext('2d');
    this.lfoIndex = lfoIndex;
    this.onChange = onChange || (() => {});
    this.points = [
      { x: 0, y: 0.5 },
      { x: 0.25, y: 1 },
      { x: 0.5, y: 0.5 },
      { x: 0.75, y: 0 },
      { x: 1, y: 0.5 },
    ];
    this.dragging = null;
    this.pointRadius = 5;
    this.pad = 8;
    this._bindEvents();
    this.draw();
  }

  // Convert CSS-pixel mouse coords to canvas-internal coords (accounts for
  // the canvas being stretched by CSS width:100%).
  _cssToCanvas(e) {
    const rect = this.canvas.getBoundingClientRect();
    return {
      cx: (e.clientX - rect.left) * (this.canvas.width / rect.width),
      cy: (e.clientY - rect.top) * (this.canvas.height / rect.height),
    };
  }

  _bindEvents() {
    this.canvas.addEventListener('contextmenu', (e) => {
      e.preventDefault();
      const { cx, cy } = this._cssToCanvas(e);
      const { px, py } = this._canvasToPoint(cx, cy);
      const hitIdx = this._hitTest(cx, cy);

      if (hitIdx !== null && hitIdx !== 0 && hitIdx !== this.points.length - 1) {
        this.points.splice(hitIdx, 1);
      } else if (hitIdx === null) {
        this.points.push({ x: Math.max(0, Math.min(1, px)), y: Math.max(0, Math.min(1, py)) });
        this.points.sort((a, b) => a.x - b.x);
      }
      this.draw();
      this.onChange(this.points);
    });

    this.canvas.addEventListener('mousedown', (e) => {
      if (e.button !== 0) return;
      const { cx, cy } = this._cssToCanvas(e);
      const hitIdx = this._hitTest(cx, cy);
      if (hitIdx !== null) {
        this.dragging = hitIdx;
        this.canvas.style.cursor = 'grabbing';
      }
    });

    this.canvas.addEventListener('mousemove', (e) => {
      const { cx, cy } = this._cssToCanvas(e);
      if (this.dragging !== null) {
        const { px, py } = this._canvasToPoint(cx, cy);
        const p = this.points[this.dragging];
        if (this.dragging === 0) p.x = 0;
        else if (this.dragging === this.points.length - 1) p.x = 1;
        else p.x = Math.max(0.001, Math.min(0.999, px));
        p.y = Math.max(0, Math.min(1, py));
        this.points.sort((a, b) => a.x - b.x);
        this.dragging = this.points.indexOf(p);
        this.draw();
      } else {
        const hit = this._hitTest(cx, cy);
        this.canvas.style.cursor = hit !== null ? 'grab' : 'crosshair';
      }
    });

    const endDrag = () => {
      if (this.dragging !== null) {
        this.dragging = null;
        this.canvas.style.cursor = 'crosshair';
        this.onChange(this.points);
      }
    };
    this.canvas.addEventListener('mouseup', endDrag);
    this.canvas.addEventListener('mouseleave', endDrag);
  }

  _canvasToPoint(cx, cy) {
    const w = this.canvas.width;
    const h = this.canvas.height;
    const p = this.pad;
    return {
      px: (cx - p) / (w - p * 2),
      py: 1 - (cy - p) / (h - p * 2),
    };
  }

  _pointToCanvas(px, py) {
    const w = this.canvas.width;
    const h = this.canvas.height;
    const p = this.pad;
    return {
      cx: p + px * (w - p * 2),
      cy: p + (1 - py) * (h - p * 2),
    };
  }

  _hitTest(cx, cy) {
    const r = this.pointRadius + 4;
    for (let i = 0; i < this.points.length; i++) {
      const { cx: px, cy: py } = this._pointToCanvas(this.points[i].x, this.points[i].y);
      if ((cx - px) ** 2 + (cy - py) ** 2 < r * r) return i;
    }
    return null;
  }

  draw() {
    const ctx = this.ctx;
    const w = this.canvas.width;
    const h = this.canvas.height;

    ctx.clearRect(0, 0, w, h);
    ctx.fillStyle = '#0a0a0f';
    ctx.fillRect(0, 0, w, h);

    // Center line
    const midY = h / 2;
    ctx.strokeStyle = '#1e1e2e';
    ctx.lineWidth = 0.5;
    ctx.beginPath();
    ctx.moveTo(0, midY);
    ctx.lineTo(w, midY);
    ctx.stroke();

    // Quarter lines
    ctx.setLineDash([2, 3]);
    for (const frac of [0.25, 0.5, 0.75]) {
      const { cx } = this._pointToCanvas(frac, 0);
      ctx.beginPath();
      ctx.moveTo(cx, 0);
      ctx.lineTo(cx, h);
      ctx.stroke();
    }
    ctx.setLineDash([]);

    // Fill under curve
    ctx.beginPath();
    for (let i = 0; i < this.points.length; i++) {
      const { cx, cy } = this._pointToCanvas(this.points[i].x, this.points[i].y);
      if (i === 0) ctx.moveTo(cx, cy);
      else ctx.lineTo(cx, cy);
    }
    const { cx: lastCx } = this._pointToCanvas(1, 0);
    const { cx: firstCx } = this._pointToCanvas(0, 0);
    ctx.lineTo(lastCx, h - this.pad);
    ctx.lineTo(firstCx, h - this.pad);
    ctx.closePath();
    ctx.fillStyle = 'rgba(255, 170, 51, 0.08)';
    ctx.fill();

    // Draw shape line
    ctx.strokeStyle = '#ffaa33';
    ctx.lineWidth = 2;
    ctx.beginPath();
    for (let i = 0; i < this.points.length; i++) {
      const { cx, cy } = this._pointToCanvas(this.points[i].x, this.points[i].y);
      if (i === 0) ctx.moveTo(cx, cy);
      else ctx.lineTo(cx, cy);
    }
    ctx.stroke();

    // Draw points
    for (let i = 0; i < this.points.length; i++) {
      const { cx, cy } = this._pointToCanvas(this.points[i].x, this.points[i].y);
      ctx.fillStyle = i === this.dragging ? '#fff' : '#ffaa33';
      ctx.beginPath();
      ctx.arc(cx, cy, this.pointRadius, 0, Math.PI * 2);
      ctx.fill();
      ctx.strokeStyle = '#fff';
      ctx.lineWidth = 1;
      ctx.stroke();
    }
  }

  // Convert points to float array for audio buffer (-1 to +1)
  toWavetable(sampleCount) {
    sampleCount = sampleCount || 2048;
    const samples = new Float32Array(sampleCount);
    const pts = this.points;

    for (let i = 0; i < sampleCount; i++) {
      const t = i / sampleCount;
      let left = pts[0], right = pts[pts.length - 1];
      for (let j = 0; j < pts.length - 1; j++) {
        if (pts[j].x <= t && pts[j + 1].x >= t) {
          left = pts[j];
          right = pts[j + 1];
          break;
        }
      }
      const span = right.x - left.x;
      const frac = span > 0 ? (t - left.x) / span : 0;
      const value = left.y + (right.y - left.y) * frac;
      samples[i] = value * 2 - 1; // 0..1 -> -1..+1
    }
    return samples;
  }

  setPoints(pts) {
    if (Array.isArray(pts) && pts.length >= 2) {
      this.points = pts.map(p => ({ x: p.x, y: p.y }));
      this.draw();
    }
  }

  getPoints() {
    return this.points.map(p => ({ x: p.x, y: p.y }));
  }
}

// ===================== Modulation Router =====================
class ModulationRouter {
  constructor(engine) {
    this.engine = engine;
    this.lfos = [];
    this._rafId = null;
    this._jsPolledRoutes = [];
  }

  // Create a new LFO config object
  createLFOConfig() {
    return {
      enabled: false,
      waveform: 'sine',     // sine, square, triangle, sawtooth, custom
      mode: 'free',          // free, trigger, envelope
      tempoSync: true,
      rateBeats: 1,          // musical division when synced
      rateFree: 1.0,         // Hz when not synced
      depth: 0.5,            // 0-1
      routes: [],            // { targetId, amount }
      customShape: null,     // array of {x,y} points
    };
  }

  // Initialize with default LFOs
  init(configs) {
    this.teardown();
    this.lfos = [];
    const ctx = this.engine.ctx;
    if (!ctx) return;

    for (let i = 0; i < configs.length; i++) {
      const cfg = configs[i];
      const lfo = {
        config: cfg,
        source: null,
        depthGain: null,
        routeGains: [],
        index: i,
      };
      this.lfos.push(lfo);
      if (cfg.enabled) this._startLFO(lfo);
    }
    this._startPolling();
  }

  _getLFORate(cfg) {
    if (cfg.tempoSync) {
      return (this.engine.bpm / 60) / cfg.rateBeats;
    }
    return cfg.rateFree;
  }

  _startLFO(lfo) {
    const ctx = this.engine.ctx;
    const cfg = lfo.config;

    // Clean up existing
    this._stopLFO(lfo);

    // Create depth gain
    lfo.depthGain = ctx.createGain();
    lfo.depthGain.gain.value = cfg.depth;

    // Create source
    const rate = this._getLFORate(cfg);

    if (cfg.waveform === 'custom' && cfg.customShape) {
      lfo.source = this._createCustomSource(cfg, rate);
    } else if (cfg.mode === 'free') {
      // Standard oscillator for free mode
      const osc = ctx.createOscillator();
      osc.type = cfg.waveform;
      osc.frequency.value = rate;
      lfo.source = osc;
    } else {
      // Buffer source for trigger/envelope modes
      lfo.source = this._createBufferSource(cfg, rate);
    }

    lfo.source.connect(lfo.depthGain);
    lfo.source.start();

    // Connect routes
    this._connectRoutes(lfo);
  }

  _createBufferSource(cfg, rate) {
    const ctx = this.engine.ctx;
    const sampleRate = ctx.sampleRate;
    const cycleLength = Math.max(64, Math.floor(sampleRate / Math.max(0.01, rate)));
    const buffer = ctx.createBuffer(1, cycleLength, sampleRate);
    const data = buffer.getChannelData(0);

    for (let i = 0; i < cycleLength; i++) {
      data[i] = evalWaveform(cfg.waveform, i / cycleLength);
    }

    const source = ctx.createBufferSource();
    source.buffer = buffer;
    source.loop = cfg.mode === 'trigger'; // envelope = one-shot
    source.playbackRate.value = 1;
    return source;
  }

  _createCustomSource(cfg, rate) {
    const ctx = this.engine.ctx;
    const sampleRate = ctx.sampleRate;
    const cycleLength = Math.max(64, Math.floor(sampleRate / Math.max(0.01, rate)));
    const buffer = ctx.createBuffer(1, cycleLength, sampleRate);
    const data = buffer.getChannelData(0);

    // Interpolate custom shape points
    const pts = cfg.customShape;
    for (let i = 0; i < cycleLength; i++) {
      const t = i / cycleLength;
      let left = pts[0], right = pts[pts.length - 1];
      for (let j = 0; j < pts.length - 1; j++) {
        if (pts[j].x <= t && pts[j + 1].x >= t) {
          left = pts[j];
          right = pts[j + 1];
          break;
        }
      }
      const span = right.x - left.x;
      const frac = span > 0 ? (t - left.x) / span : 0;
      const value = left.y + (right.y - left.y) * frac;
      data[i] = value * 2 - 1;
    }

    const source = ctx.createBufferSource();
    source.buffer = buffer;
    source.loop = cfg.mode !== 'envelope';
    source.playbackRate.value = 1;
    return source;
  }

  _stopLFO(lfo) {
    // Disconnect routes
    lfo.routeGains.forEach(rg => {
      try { rg.disconnect(); } catch (e) {}
    });
    lfo.routeGains = [];

    if (lfo.source) {
      try { lfo.source.stop(); } catch (e) {}
      try { lfo.source.disconnect(); } catch (e) {}
      lfo.source = null;
    }
    if (lfo.depthGain) {
      try { lfo.depthGain.disconnect(); } catch (e) {}
      lfo.depthGain = null;
    }
  }

  _connectRoutes(lfo) {
    const ctx = this.engine.ctx;
    if (!lfo.depthGain || !ctx) return;

    // Disconnect old route gains
    lfo.routeGains.forEach(rg => {
      try { rg.disconnect(); } catch (e) {}
    });
    lfo.routeGains = [];
    this._rebuildJsPolledRoutes();

    for (const route of lfo.config.routes) {
      const target = MOD_TARGETS[route.targetId];
      if (!target) continue;

      if (target.jsPolled) {
        // Handled by JS polling loop
        continue;
      }

      const param = this._resolveAudioParam(route.targetId);
      if (param) {
        const routeGain = ctx.createGain();
        routeGain.gain.value = route.amount * (target.scale || 1);
        lfo.depthGain.connect(routeGain);
        routeGain.connect(param);
        lfo.routeGains.push(routeGain);
      }
    }
  }

  _resolveAudioParam(targetId) {
    const e = this.engine;
    if (!e.running) return null;
    switch (targetId) {
      case 'main-gain':   return e.mainGain?.gain;
      case 'eq-hp-freq':  return e.eqHP?.frequency;
      case 'eq-pk-freq':  return e.eqPeak?.frequency;
      case 'eq-lp-freq':  return e.eqLP?.frequency;
      case 'eq-pk-gain':  return e.eqPeak?.gain;
      case 'dist-tone':   return e.distortionTone?.frequency;
      case 'delay-time':  return e.delayNode?.delayTime;
      case 'delay-fdbk':  return e.delayFeedbackNode?.gain;
      case 'reverb-mix':  return e.reverbWet?.gain;
      case 'comb-delay':  return e.combDelay?.delayTime;
      case 'comb-fdbk':   return e.combFeedbackNode?.gain;
      default: return null;
    }
  }

  _rebuildJsPolledRoutes() {
    this._jsPolledRoutes = [];
    for (const lfo of this.lfos) {
      if (!lfo.config.enabled) continue;
      for (const route of lfo.config.routes) {
        const target = MOD_TARGETS[route.targetId];
        if (target && target.jsPolled) {
          this._jsPolledRoutes.push({ lfo, route, target });
        }
      }
    }
  }

  _startPolling() {
    if (this._rafId) return;
    const poll = () => {
      this._rafId = requestAnimationFrame(poll);
      // JS-polled modulation is handled here
      // For now, we rely on AudioParam connections for most targets
      // JS-polled targets (like distortion drive) need manual reading
    };
    this._rafId = requestAnimationFrame(poll);
  }

  // Called on noteOn for trigger/envelope modes
  onNoteOn(note) {
    for (const lfo of this.lfos) {
      if (!lfo.config.enabled) continue;
      if (lfo.config.mode === 'trigger' || lfo.config.mode === 'envelope') {
        this._startLFO(lfo);
      }
    }
  }

  onNoteOff(note) {
    // Envelope mode LFOs naturally end (no loop)
    // Trigger mode continues until next noteOn
  }

  // Update a specific LFO property
  updateLFO(index, prop, value) {
    if (index >= this.lfos.length) return;
    const lfo = this.lfos[index];
    const cfg = lfo.config;

    cfg[prop] = value;

    if (prop === 'enabled') {
      if (value) this._startLFO(lfo);
      else this._stopLFO(lfo);
    } else if (prop === 'waveform' || prop === 'mode' || prop === 'tempoSync' || prop === 'customShape') {
      if (cfg.enabled) this._startLFO(lfo);
    } else if (prop === 'depth') {
      if (lfo.depthGain) lfo.depthGain.gain.value = value;
    } else if (prop === 'rateBeats' || prop === 'rateFree') {
      if (cfg.enabled) {
        if (cfg.mode === 'free' && lfo.source && lfo.source.frequency) {
          lfo.source.frequency.value = this._getLFORate(cfg);
        } else if (cfg.enabled) {
          this._startLFO(lfo);
        }
      }
    }
  }

  // Add a route to an LFO
  addRoute(lfoIndex, targetId, amount) {
    if (lfoIndex >= this.lfos.length) return;
    const lfo = this.lfos[lfoIndex];
    lfo.config.routes.push({ targetId, amount: amount || 0.5 });
    if (lfo.config.enabled) this._connectRoutes(lfo);
  }

  // Remove a route from an LFO
  removeRoute(lfoIndex, routeIndex) {
    if (lfoIndex >= this.lfos.length) return;
    const lfo = this.lfos[lfoIndex];
    lfo.config.routes.splice(routeIndex, 1);
    if (lfo.config.enabled) this._connectRoutes(lfo);
  }

  // Update route amount
  updateRouteAmount(lfoIndex, routeIndex, amount) {
    if (lfoIndex >= this.lfos.length) return;
    const lfo = this.lfos[lfoIndex];
    if (routeIndex >= lfo.config.routes.length) return;
    const route = lfo.config.routes[routeIndex];
    route.amount = amount;
    const target = MOD_TARGETS[route.targetId];
    // Update gain node directly if exists
    if (lfo.routeGains[routeIndex]) {
      lfo.routeGains[routeIndex].gain.value = amount * (target?.scale || 1);
    }
  }

  // Update route target
  updateRouteTarget(lfoIndex, routeIndex, targetId) {
    if (lfoIndex >= this.lfos.length) return;
    const lfo = this.lfos[lfoIndex];
    if (routeIndex >= lfo.config.routes.length) return;
    lfo.config.routes[routeIndex].targetId = targetId;
    if (lfo.config.enabled) this._connectRoutes(lfo);
  }

  // Update all rates (called when BPM changes)
  updateAllRates() {
    for (const lfo of this.lfos) {
      if (!lfo.config.enabled || !lfo.config.tempoSync) continue;
      const rate = this._getLFORate(lfo.config);
      if (lfo.config.mode === 'free' && lfo.source && lfo.source.frequency) {
        lfo.source.frequency.value = rate;
      } else {
        this._startLFO(lfo);
      }
    }
  }

  // Pitch modulation: connect to active voice oscillators
  connectPitchToVoice(voice) {
    for (const lfo of this.lfos) {
      if (!lfo.config.enabled || !lfo.depthGain) continue;
      for (const route of lfo.config.routes) {
        if (!route.targetId.includes('pitch')) continue;
        const target = MOD_TARGETS[route.targetId];
        if (!target) continue;

        const ctx = this.engine.ctx;
        const routeGain = ctx.createGain();
        routeGain.gain.value = route.amount * (target.scale || 1);
        lfo.depthGain.connect(routeGain);

        if (route.targetId === 'all-pitch') {
          voice.oscillators.forEach(osc => routeGain.connect(osc.frequency));
        } else {
          const oscIdx = parseInt(route.targetId.charAt(3)) - 1;
          if (voice.oscillators[oscIdx]) {
            routeGain.connect(voice.oscillators[oscIdx].frequency);
          }
        }

        // Store for cleanup
        if (!voice._modGains) voice._modGains = [];
        voice._modGains.push(routeGain);
      }
    }
  }

  // Per-voice gain modulation (osc1-gain etc)
  connectGainToVoice(voice) {
    for (const lfo of this.lfos) {
      if (!lfo.config.enabled || !lfo.depthGain) continue;
      for (const route of lfo.config.routes) {
        const tid = route.targetId;
        if (!tid.match(/^osc\d-gain$/)) continue;
        const target = MOD_TARGETS[tid];
        if (!target) continue;
        const oscIdx = parseInt(tid.charAt(3)) - 1;
        if (!voice.gains[oscIdx]) continue;

        const ctx = this.engine.ctx;
        const routeGain = ctx.createGain();
        routeGain.gain.value = route.amount * (target.scale || 1);
        lfo.depthGain.connect(routeGain);
        routeGain.connect(voice.gains[oscIdx].gain);

        if (!voice._modGains) voice._modGains = [];
        voice._modGains.push(routeGain);
      }
    }
  }

  // Get snapshot of configs for preset save
  getConfigs() {
    return this.lfos.map(lfo => ({
      enabled: lfo.config.enabled,
      waveform: lfo.config.waveform,
      mode: lfo.config.mode,
      tempoSync: lfo.config.tempoSync,
      rateBeats: lfo.config.rateBeats,
      rateFree: lfo.config.rateFree,
      depth: lfo.config.depth,
      routes: lfo.config.routes.map(r => ({ targetId: r.targetId, amount: r.amount })),
      customShape: lfo.config.customShape ? lfo.config.customShape.map(p => ({ x: p.x, y: p.y })) : null,
    }));
  }

  teardown() {
    if (this._rafId) {
      cancelAnimationFrame(this._rafId);
      this._rafId = null;
    }
    for (const lfo of this.lfos) {
      this._stopLFO(lfo);
    }
    this.lfos = [];
    this._jsPolledRoutes = [];
  }
}

// ===================== Spectrogram =====================
class Spectrogram {
  constructor(canvas, analyser) {
    this.canvas = canvas;
    this.ctx = canvas.getContext('2d');
    this.analyser = analyser;
    this.width = canvas.width;
    this.height = canvas.height;
    this.columnData = new Uint8Array(analyser.frequencyBinCount);
    this.colorMap = this._buildColorMap();
  }

  _buildColorMap() {
    const map = new Array(256);
    for (let i = 0; i < 256; i++) {
      const t = i / 255;
      let r, g, b;
      if (t < 0.15) {
        r = 0; g = 0; b = Math.floor(20 + t / 0.15 * 80);
      } else if (t < 0.35) {
        const s = (t - 0.15) / 0.2;
        r = 0; g = Math.floor(s * 120); b = Math.floor(100 + s * 60);
      } else if (t < 0.55) {
        const s = (t - 0.35) / 0.2;
        r = Math.floor(s * 80); g = Math.floor(120 + s * 100); b = Math.floor(160 - s * 60);
      } else if (t < 0.75) {
        const s = (t - 0.55) / 0.2;
        r = Math.floor(80 + s * 175); g = Math.floor(220 + s * 35); b = Math.floor(100 - s * 100);
      } else {
        const s = (t - 0.75) / 0.25;
        r = 255; g = Math.floor(255 - s * 120); b = 0;
      }
      map[i] = `rgb(${r},${g},${b})`;
    }
    return map;
  }

  draw() {
    if (!this.analyser) return;
    this.analyser.getByteFrequencyData(this.columnData);

    // Shift existing image left
    const imgData = this.ctx.getImageData(1, 0, this.width - 1, this.height);
    this.ctx.putImageData(imgData, 0, 0);

    // Draw new column on the right
    const binCount = this.columnData.length;
    for (let y = 0; y < this.height; y++) {
      const normalizedY = 1 - (y / this.height);
      // Log scale for frequency
      const binIndex = Math.floor(Math.pow(normalizedY, 2.5) * binCount);
      const value = this.columnData[Math.min(binIndex, binCount - 1)];
      this.ctx.fillStyle = this.colorMap[value];
      this.ctx.fillRect(this.width - 1, y, 1, 1);
    }
  }
}

// Export to window
window.MOD_TARGETS = MOD_TARGETS;
window.LFOShapeEditor = LFOShapeEditor;
window.ModulationRouter = ModulationRouter;
window.Spectrogram = Spectrogram;
