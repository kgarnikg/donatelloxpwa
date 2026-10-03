import { useEffect, useRef, type RefObject } from "react";
import {
  Color,
  Group,
  Mesh,
  PerspectiveCamera,
  Raycaster,
  Scene,
  ShaderMaterial,
  Vector2,
  WebGLRenderer,
  type BufferGeometry,
} from "three";
import { GLTFLoader } from "three/examples/jsm/loaders/GLTFLoader.js";
import { MeshoptDecoder } from "three/examples/jsm/libs/meshopt_decoder.module.js";
import { FOCUS_MUSCLES, type FocusMuscle } from "@donatellox/types";
import maleModelUrl from "@/assets/models/body-male.glb?url";

/**
 * 3D-фигура для выбора мышц (анкета, шаг "Акцент").
 *
 * Модель (assets/models/body-male.glb) — одна сетка. В цвете каждой вершины
 * зашито четыре числа:
 *   r — затенение складок (чтобы рельеф мышц читался без текстур),
 *   g — номер зоны (0 — не мышца: голова, кисти, стопы; 1..13 — FOCUS_MUSCLES),
 *   b — расстояние до границы зоны (по нему шейдер рисует гладкий край подсветки),
 *   a — "шорты" (расстояние до их края, край рисуется шейдером ровной линией).
 * Подсветка выбранных зон — массив uLevel в шейдере: никаких текстур и
 * перекраски вершин, поэтому даже на слабом телефоне всё плавно.
 *
 * Кадры рисуются только когда что-то меняется (поворот, подсветка) —
 * стоящая на месте модель батарею не тратит.
 */

/** Номер зоны в модели = позиция в FOCUS_MUSCLES + 1 */
const ZONE_STEP = 18;
const ZONE_COUNT = FOCUS_MUSCLES.length + 1;

const VERTEX = /* glsl */ `
  attribute vec4 aData;
  uniform float uLevel[${ZONE_COUNT}];
  uniform float uHover;
  varying vec3 vNormal;
  varying vec3 vView;
  varying float vSelect;
  varying float vHover;
  varying float vAo;
  varying float vShorts;
  void main() {
    int zone = int(aData.g * 255.0 / ${ZONE_STEP}.0 + 0.5);
    // aData.b — расстояние до границы зоны. Внутри выбранной зоны оно со знаком
    // "плюс", в невыбранной — "минус": ноль попадает ровно на границу, и край
    // подсветки гладкий при любой крупности сетки. Между двумя выбранными
    // зонами остаётся тонкая приглушённая линия — мышцы читаются по отдельности.
    float level = uLevel[zone];
    float hover = abs(float(zone) - uHover) < 0.5 ? 1.0 : 0.0;
    vSelect = aData.b * (2.0 * level - 1.0) - (1.0 - level) * 0.1;
    vHover = aData.b * (2.0 * hover - 1.0) - (1.0 - hover) * 0.1;
    vAo = aData.r;
    vShorts = aData.a;
    vec4 mv = modelViewMatrix * vec4(position, 1.0);
    vNormal = normalize(normalMatrix * normal);
    vView = -mv.xyz;
    gl_Position = projectionMatrix * mv;
  }
`;

const FRAGMENT = /* glsl */ `
  uniform vec3 uBase;
  uniform vec3 uShorts;
  uniform vec3 uAccent;
  varying vec3 vNormal;
  varying vec3 vView;
  varying float vSelect;
  varying float vHover;
  varying float vAo;
  varying float vShorts;

  void main() {
    vec3 n = normalize(vNormal);
    vec3 v = normalize(vView);

    float edge = fwidth(vShorts) * 1.2 + 0.0001;
    float shorts = smoothstep(0.5 - edge, 0.5 + edge, vShorts);
    float glow = smoothstep(-0.1, 0.05, vSelect);
    glow = max(glow, 0.3 * smoothstep(-0.1, 0.05, vHover));

    // Свет стоит на месте (как в студии), вращается только фигура
    vec3 keyDir = normalize(vec3(0.5, 0.7, 0.62));
    vec3 fillDir = normalize(vec3(-0.75, 0.15, 0.45));
    float key = max(dot(n, keyDir), 0.0);
    float fill = max(dot(n, fillDir), 0.0);
    float sky = 0.5 + 0.5 * n.y;
    float ao = mix(1.0, vAo, 0.85);
    float light = (key * 1.25 + fill * 0.32 + mix(0.10, 0.34, sky)) * ao;

    float fres = pow(1.0 - max(dot(n, v), 0.0), 3.0);
    float spec = pow(max(dot(n, normalize(keyDir + v)), 0.0), 36.0);

    vec3 body = mix(uBase, uShorts, shorts);
    vec3 col = body * light;
    col += vec3(0.60, 0.72, 1.0) * fres * 0.42 * mix(1.0, 0.6, shorts);
    col += vec3(1.0) * spec * 0.16 * (1.0 - shorts * 0.5) * ao;

    // Выбранная мышца: цвет бренда с тем же рельефом, а не плоская заливка
    vec3 accent = mix(uAccent, uAccent * 0.7, shorts);
    vec3 lit = accent * (light * 0.56 + 0.04) + uAccent * fres * 0.5 + vec3(1.0) * spec * 0.2 * ao;
    col = mix(col, lit, glow * 0.94);

    gl_FragColor = vec4(pow(col, vec3(1.0 / 2.2)), 1.0);
  }
`;

export interface MuscleBody3DProps {
  selected: readonly FocusMuscle[];
  onToggle: (muscle: FocusMuscle) => void;
  /** Куда повернуть фигуру; меняется кнопками "Спереди / Сзади" и выбором из списка. */
  view: "front" | "back";
  /** Пользователь сам докрутил фигуру до другой стороны */
  onViewChange: (view: "front" | "back") => void;
  onReady: () => void;
  /** Нет WebGL или модель не загрузилась — остаётся обычный список */
  onError: () => void;
  className?: string;
  ariaLabel?: string;
}

interface Engine {
  setSelected: (selected: readonly FocusMuscle[]) => void;
  setView: (view: "front" | "back") => void;
  dispose: () => void;
}

export default function MuscleBody3D({
  selected,
  onToggle,
  view,
  onViewChange,
  onReady,
  onError,
  className,
  ariaLabel,
}: MuscleBody3DProps) {
  const hostRef = useRef<HTMLDivElement>(null);
  const engineRef = useRef<Engine | null>(null);
  // Свежие обработчики и значения — без пересоздания сцены
  const latest = useRef({
    selected,
    onToggle,
    view,
    onViewChange,
    onReady,
    onError,
  });
  latest.current = { selected, onToggle, view, onViewChange, onReady, onError };

  useEffect(() => {
    const host = hostRef.current;
    if (!host) return;
    let engine: Engine | null = null;
    try {
      engine = createEngine(host, latest);
    } catch {
      latest.current.onError();
      return;
    }
    engineRef.current = engine;
    return () => {
      engineRef.current = null;
      engine?.dispose();
    };
  }, []);

  useEffect(() => {
    engineRef.current?.setSelected(selected);
  }, [selected]);

  useEffect(() => {
    engineRef.current?.setView(view);
  }, [view]);

  return (
    <div
      ref={hostRef}
      className={className}
      role="img"
      aria-label={ariaLabel}
      // Вертикальный жест — прокрутка страницы, горизонтальный — поворот фигуры
      style={{
        touchAction: "pan-y",
        cursor: "grab",
        userSelect: "none",
        WebkitUserSelect: "none",
      }}
    />
  );
}

type Latest = RefObject<{
  selected: readonly FocusMuscle[];
  onToggle: (muscle: FocusMuscle) => void;
  view: "front" | "back";
  onViewChange: (view: "front" | "back") => void;
  onReady: () => void;
  onError: () => void;
}>;

function createEngine(host: HTMLDivElement, latest: Latest): Engine {
  const renderer = new WebGLRenderer({
    antialias: true,
    alpha: true,
    powerPreference: "low-power",
  });
  renderer.setClearColor(0x000000, 0);
  const canvas = renderer.domElement;
  canvas.style.display = "block";
  canvas.style.width = "100%";
  canvas.style.height = "100%";
  host.appendChild(canvas);

  const scene = new Scene();
  const camera = new PerspectiveCamera(26, 1, 0.1, 20);
  const pivot = new Group();
  scene.add(pivot);

  const levels = new Float32Array(ZONE_COUNT); // текущая яркость зон
  const targets = new Float32Array(ZONE_COUNT); // к чему стремится
  const material = new ShaderMaterial({
    vertexShader: VERTEX,
    fragmentShader: FRAGMENT,
    uniforms: {
      uLevel: { value: levels },
      uHover: { value: -1 },
      uBase: { value: new Color("#8d939e") },
      uShorts: { value: new Color("#2b2f38") },
      // volt-400 — основной цвет бренда (packages/theme/src/tokens.ts)
      uAccent: { value: new Color("#A8E000") },
    },
  });

  let mesh: Mesh | null = null;
  let zoneOfVertex: Uint8Array | null = null;
  let disposed = false;
  let frame = 0;
  let lastTime = 0;

  // Поворот вокруг вертикальной оси
  const reduceMotion =
    window.matchMedia?.("(prefers-reduced-motion: reduce)").matches ?? false;
  let yaw = reduceMotion ? 0 : -0.9; // небольшой разворот при появлении: видно, что фигура объёмная
  let yawTarget: number | null = latest.current!.view === "back" ? Math.PI : 0;
  let velocity = 0;
  let reportedView = latest.current!.view;
  let hoverZone = 0;

  function applyTargets() {
    const chosen = latest.current!.selected;
    for (let z = 1; z < ZONE_COUNT; z++) {
      const on = chosen.includes(FOCUS_MUSCLES[z - 1]!);
      targets[z] = on ? 1 : 0;
    }
    material.uniforms.uHover!.value =
      hoverZone && !chosen.includes(FOCUS_MUSCLES[hoverZone - 1]!)
        ? hoverZone
        : -1;
    requestFrame();
  }

  function requestFrame() {
    if (!frame && !disposed) frame = requestAnimationFrame(tick);
  }

  function tick(now: number) {
    frame = 0;
    if (disposed) return;
    const dt = Math.min(0.05, lastTime ? (now - lastTime) / 1000 : 0.016);
    lastTime = now;
    let moving = false;

    if (yawTarget !== null) {
      const diff = yawTarget - yaw;
      if (Math.abs(diff) < 0.002) {
        yaw = yawTarget;
        yawTarget = null;
      } else {
        yaw += diff * Math.min(1, dt * 7);
        moving = true;
      }
    } else if (Math.abs(velocity) > 0.02) {
      yaw += velocity * dt;
      velocity *= Math.exp(-dt * 4.5);
      moving = true;
    }

    for (let z = 1; z < ZONE_COUNT; z++) {
      const diff = targets[z]! - levels[z]!;
      if (Math.abs(diff) < 0.004) {
        levels[z] = targets[z]!;
      } else {
        levels[z] = levels[z]! + diff * Math.min(1, dt * 12);
        moving = true;
      }
    }

    pivot.rotation.y = yaw;
    renderer.render(scene, camera);

    const side = Math.cos(yawTarget ?? yaw) >= 0 ? "front" : "back";
    if (side !== reportedView) {
      reportedView = side;
      latest.current!.onViewChange(side);
    }

    if (moving) requestFrame();
    else lastTime = 0;
  }

  function resize() {
    const w = host.clientWidth;
    const h = host.clientHeight;
    if (!w || !h) return;
    renderer.setPixelRatio(Math.min(window.devicePixelRatio || 1, 2));
    renderer.setSize(w, h, false);
    camera.aspect = w / h;
    // Фигура 1.8 × 0.85: вписываем и по высоте, и по ширине
    const tan = Math.tan((camera.fov * Math.PI) / 360);
    const byHeight = (1.8 * 1.07) / 2 / tan;
    const byWidth = (0.85 * 1.12) / 2 / (tan * camera.aspect);
    const distance = Math.max(byHeight, byWidth);
    camera.position.set(0, 0.93, distance);
    camera.lookAt(0, 0.9, 0);
    camera.updateProjectionMatrix();
    requestFrame();
  }
  const observer = new ResizeObserver(resize);
  observer.observe(host);

  // --- Нажатие и поворот -------------------------------------------------
  const raycaster = new Raycaster();
  const pointer = new Vector2();

  function zoneAt(clientX: number, clientY: number): number {
    if (!mesh || !zoneOfVertex) return 0;
    const rect = canvas.getBoundingClientRect();
    pointer.set(
      ((clientX - rect.left) / rect.width) * 2 - 1,
      -((clientY - rect.top) / rect.height) * 2 + 1,
    );
    raycaster.setFromCamera(pointer, camera);
    const hit = raycaster.intersectObject(mesh, false)[0];
    if (!hit?.face) return 0;
    const a = zoneOfVertex[hit.face.a]!;
    const b = zoneOfVertex[hit.face.b]!;
    const c = zoneOfVertex[hit.face.c]!;
    if (a === b || a === c) return a || b || c;
    if (b === c) return b || a;
    return a || b || c;
  }

  let dragging = false;
  let pointerId: number | null = null;
  let startX = 0;
  let startY = 0;
  let lastX = 0;
  let lastMoveTime = 0;
  let startTime = 0;

  function onPointerDown(e: PointerEvent) {
    if (pointerId !== null) return;
    pointerId = e.pointerId;
    startX = lastX = e.clientX;
    startY = e.clientY;
    startTime = lastMoveTime = performance.now();
    dragging = false;
    velocity = 0;
  }

  function onPointerMove(e: PointerEvent) {
    if (pointerId === null) {
      if (e.pointerType === "mouse") {
        const zone = zoneAt(e.clientX, e.clientY);
        if (zone !== hoverZone) {
          hoverZone = zone;
          host.style.cursor = zone ? "pointer" : "grab";
          applyTargets();
        }
      }
      return;
    }
    if (e.pointerId !== pointerId) return;
    const dx = e.clientX - startX;
    const dy = e.clientY - startY;
    if (!dragging && Math.abs(dx) > 7 && Math.abs(dx) > Math.abs(dy)) {
      dragging = true;
      yawTarget = null;
      host.style.cursor = "grabbing";
      try {
        canvas.setPointerCapture(pointerId);
      } catch {
        /* указатель уже отпущен */
      }
    }
    if (dragging) {
      const now = performance.now();
      const step = (e.clientX - lastX) * 0.011;
      yaw += step;
      velocity = step / Math.max(0.008, (now - lastMoveTime) / 1000);
      lastX = e.clientX;
      lastMoveTime = now;
      requestFrame();
    }
  }

  function endPointer(e: PointerEvent, cancelled: boolean) {
    if (e.pointerId !== pointerId) return;
    pointerId = null;
    host.style.cursor = "grab";
    if (dragging) {
      dragging = false;
      if (performance.now() - lastMoveTime > 80) velocity = 0;
      velocity = Math.max(-9, Math.min(9, velocity));
      requestFrame();
      return;
    }
    if (cancelled) return;
    const moved = Math.hypot(e.clientX - startX, e.clientY - startY);
    if (moved > 10 || performance.now() - startTime > 700) return;
    const zone = zoneAt(e.clientX, e.clientY);
    if (zone) latest.current!.onToggle(FOCUS_MUSCLES[zone - 1]!);
  }

  const onPointerUp = (e: PointerEvent) => endPointer(e, false);
  const onPointerCancel = (e: PointerEvent) => endPointer(e, true);
  function onPointerLeave() {
    if (hoverZone) {
      hoverZone = 0;
      applyTargets();
    }
  }

  canvas.addEventListener("pointerdown", onPointerDown);
  canvas.addEventListener("pointermove", onPointerMove);
  canvas.addEventListener("pointerup", onPointerUp);
  canvas.addEventListener("pointercancel", onPointerCancel);
  canvas.addEventListener("pointerleave", onPointerLeave);

  function onContextLost(e: Event) {
    e.preventDefault();
    latest.current!.onError();
  }
  canvas.addEventListener("webglcontextlost", onContextLost);

  // --- Модель ------------------------------------------------------------
  let geometry: BufferGeometry | null = null;
  const loader = new GLTFLoader();
  loader.setMeshoptDecoder(MeshoptDecoder);
  loader.load(
    maleModelUrl,
    (gltf) => {
      if (disposed) return;
      gltf.scene.traverse((node) => {
        if (!mesh && (node as Mesh).isMesh) mesh = node as Mesh;
      });
      const data = mesh?.geometry.getAttribute("color");
      if (!mesh || !data) {
        latest.current!.onError();
        return;
      }
      geometry = mesh.geometry;
      geometry.setAttribute("aData", data);
      geometry.deleteAttribute("color");
      zoneOfVertex = new Uint8Array(data.count);
      for (let i = 0; i < data.count; i++) {
        zoneOfVertex[i] = Math.min(
          ZONE_COUNT - 1,
          Math.round((data.getY(i) * 255) / ZONE_STEP),
        );
      }
      mesh.material = material;
      pivot.add(gltf.scene);
      resize();
      applyTargets();
      latest.current!.onReady();
    },
    undefined,
    () => {
      if (!disposed) latest.current!.onError();
    },
  );

  return {
    setSelected: applyTargets,
    setView(next) {
      if (next === reportedView && yawTarget === null) return;
      reportedView = next;
      // Ближайший оборот, чтобы фигура не крутилась лишний круг
      const base = next === "back" ? Math.PI : 0;
      yawTarget = base + Math.round((yaw - base) / (Math.PI * 2)) * Math.PI * 2;
      velocity = 0;
      requestFrame();
    },
    dispose() {
      disposed = true;
      if (frame) cancelAnimationFrame(frame);
      observer.disconnect();
      canvas.removeEventListener("pointerdown", onPointerDown);
      canvas.removeEventListener("pointermove", onPointerMove);
      canvas.removeEventListener("pointerup", onPointerUp);
      canvas.removeEventListener("pointercancel", onPointerCancel);
      canvas.removeEventListener("pointerleave", onPointerLeave);
      canvas.removeEventListener("webglcontextlost", onContextLost);
      geometry?.dispose();
      material.dispose();
      renderer.dispose();
      renderer.forceContextLoss();
      canvas.remove();
    },
  };
}
