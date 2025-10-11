# Storyboard — Rachas (Streaks) & Legacito

Resumen: este storyboard describe el flujo de uso centrado en rachas ("Logros") y la presencia de Legacito, el mentor estoico. Incluye escenas, eventos técnicos, estructuras de datos, y recomendaciones de UI/animación.

---

## Escena 1 — Acción diaria
- Pantalla: `Nutrición` o `Entrenamiento` (contexto activo)
- Acción: El usuario completa una meta (ej. completa entrenamiento, marca comida saludable, cumple una tarea de nutrición).
- UX: No interrumpir el flujo. Mostrar microfeedback inmediato.

Legacito (micro-interacción):
- Aparece como mini-popup animado en la esquina inferior derecha (o inferior izquierda según diseño).
- Animación breve: entrada con fade+translate, guiño o pulgar arriba, luego salida en 1.2s.
- Texto corto (1 línea): ejemplo "Buen trabajo. Un paso más hacia tu legado."

Efecto en datos:
- Generar evento local: {
  type: 'goal_completed',
  source: 'training|nutrition',
  timestamp: ISOString,
  meta: { goalId, points: 1 }
}
- Enviar evento a cola local/sincronizador para persistencia y procesamiento por el módulo de rachas.

UI: sumar coin counter visible en la esquina (contador de monedas o puntos) sin cambiar de pantalla.

---

## Escena 2 — Procesamiento silencioso
- Sistema: módulo de "Logros / Rachas" (puede ser microservicio local + sincronización con backend)
- Acción:
  1) Recibe evento `goal_completed`.
  2) Comprueba `lastCompletionDate` para ese tipo/meta.
  3) Si `isNewDay` incrementa racha diaria; si no, marca completado pero no afecta racha.

- Lógica:
  - Datos relevantes (modelo `StreakState`):
    {
      streakId,
      userId,
      type: 'daily' | 'weekly' | 'habit',
      length: int, // días consecutivos
      lastUpdated: ISOString,
      best: int,
      active: bool
    }

  - Reglas:
    - New streak: if lastUpdated == null OR daysSince(lastUpdated) > 1 -> length = 1
    - Continue streak: if daysSince(lastUpdated) == 1 -> length += 1
    - Break streak: if daysSince(lastUpdated) > 1 -> evaluate milestone, reset or update best

- Resultado interno: actualizar `StreakState` y opcionalmente generar `Achievement` si se alcanzó hito.

- Nota de UX: NO mostrar modal inmediato; reservar feedback completo para la pantalla "Logros". Mantener microinteracciones locales.

---

## Escena 3 — Revisión en "Logros"
- Pantalla: `Logros`
- Inicio de pantalla: solicitar resumen al módulo de rachas (fetch local/cache + backend sync).

Animaciones de entrada:
- Si `delta` (avance) > 0: animar contador con efecto de rebote y escala (150ms in, 300ms bounce)
- Si inicio de racha: small gold flare + Legacito aparece con bubble: "La constancia es tu mejor aliado"
- Si hito mayor: pantalla completa con Legacito y frase especial; CTA para compartir o reclamar recompensa.

Contenido:
- Resumen destacado: racha actual (days), mejor racha, monedas acumuladas
- Historial: lista paginada con entradas {date, type, description, reward}
- CTA: botones para compartir, reclamar o ver detalle de recompensa

---

## Escena 4 — Refuerzo emocional
- Visual:
  - Barra / anillo de progreso hacia siguiente hito
  - Íconos de monedas visibles junto a cada recompensa
  - Microconfetti opcional en llegada a hito mayor

- Narrativa (Legacito):
  - Racha baja (length < 3): "Bienvenido al comienzo. Cuida el hábito más que el número."
  - Racha media (3 <= length < 10): "Estás construyendo una costumbre. Mantén la disciplina." 
  - Racha alta (>= 10): "El legado se forma cada día. Orgulloso de tu constancia."

- Composable message: cada mensaje incluye una sugerencia accionable (pequeña tarea diaria) y enlace a plan de entrenamiento/nutrición relacionado.

---

## Escena 5 — Persistencia y conexión
- Persistencia: `StreakState` y `Achievements` deben guardarse localmente y sincronizar con backend. Modelo mínimo:
  - StreakState as above
  - Achievement: { id, title, description, date, reward, metadata }

- Integración con otras fuentes:
  - Nutrición y Entrenamiento envían eventos a la misma cola
  - Legacito puede consumir datos de Nutrition/Training to provide contextual messages (e.g., "Después de esta comida equilibrada, considera una caminata ligera").

- Microinteracciones fuera de Logros:
  - Tiny gestures: legacito reacts with small icons when user saves a meal or completes part of a workout
  - Header/progress strip: show compact streak count and coin balance

---

## Consideraciones técnicas y UX
- Event bus / queue: use a resilient local queue (persisted) to handle offline scenarios; sync with backend when online.
- Atomic updates: ensure StreakState updates are idempotent (use lastUpdated + eventId)
- Rate-limiting microinteractions: debounce Legacito popups to avoid annoyance
- Accessibility: ensure animations have reduce-motion fallback and text alternatives
- Privacy: do not leak PHI; minimal health data stored; rely on hashed IDs when sending analytics

---

## Developer contract & integration points
- Events:
  - goal_completed: { userId, type, timestamp, goalId, points }
  - streak_updated: { streakId, userId, length, best, lastUpdated }
  - achievement_unlocked: { id, title, description, reward }

- API endpoints (backend):
  - POST /events (ingest)
  - GET /users/{id}/streaks
  - GET /users/{id}/achievements

- UI components to build:
  - Legacito micro-widget (animated, small)
  - Achievements screen with animated counters
  - Progress strip for headers/profile

---

## Acceptance criteria
- Completing a goal triggers a local microinteraction from Legacito without modal.
- Events are queued and processed by the streak module; streak increases are not shown as a full modal until the user visits "Logros".
- Achievements screen shows accurate historical entries, animated counter, and contextual Legacito feedback.
- Legacito messages are supportive and stoic, emphasizing discipline over outcomes.

---

Feedback welcome — puedo convertir cada escena en wireframes y especificaciones de animación (duraciones, easing, Lottie/animated vector suggestions) si queréis que lo entregue para el equipo de diseño.
