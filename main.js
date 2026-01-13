// --------- CONFIG YOU MUST EDIT ----------
const BANKS = [
  "Master.bank",
  "Master.strings.bank",
  // add others if you have them
];

const TEST_EVENT = "event:/Main"; // MUST match exactly (copy event path in FMOD Studio)
// ----------------------------------------

let FMOD = null;
let studioSystem = null;
let eventInstance = null;
let started = false;

function check(result, label) {
  const OK = typeof FMOD.OK === "number"
    ? FMOD.OK
    : (typeof FMOD.FMOD_OK === "number" ? FMOD.FMOD_OK : 0);
  if (result !== OK) throw new Error(`${label} failed (err ${result})`);
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
  const eventDesc = eventDescOut.val;

  const instOut = { val: 0 };
  check(eventDesc.createInstance(instOut), "createInstance");
  eventInstance = instOut.val;

  check(eventInstance.start(), "eventInstance.start");
  console.log("[FMOD] Playing:", TEST_EVENT);

  const tick = () => {
    studioSystem.update();
    requestAnimationFrame(tick);
  };
  tick();
}

window.addEventListener("DOMContentLoaded", () => {
  const btn = document.getElementById("startAudio");
  btn.addEventListener("click", () => {
    startFMOD().catch((err) => {
      console.error(err);
      alert(err.message);
      started = false;
    });
  });
});
