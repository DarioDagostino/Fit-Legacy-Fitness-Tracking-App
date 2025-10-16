# Fit Legacy - Blueprint

## Visión General del Proyecto

Fit Legacy es una aplicación de fitness gamificada que combina entrenamiento físico con reflexión y conocimiento, guiando al usuario a través de un "Camino del Legado". El objetivo es forjar un legado de disciplina, fuerza y resiliencia. La aplicación está mentorizada por **Legacito**, un guía estoico que ofrece sabiduría y perspectiva.

## Funcionalidades Implementadas

### v0.1: Fundación y Autenticación
- **Arquitectura por Capas**: El proyecto está estructurado en capas de `presentation`, `domain` y `data` por cada funcionalidad (`feature`).
- **Gestión de Estado con Provider**: Se utiliza `provider` para manejar el estado de la aplicación, comenzando con la autenticación (`AuthProvider`).
- **Navegación Declarativa con `go_router`**: Se implementó `go_router` para gestionar las rutas de la aplicación y las redirecciones automáticas basadas en el estado de autenticación.
- **Autenticación con Firebase**:
  - Registro e inicio de sesión con Email/Contraseña.
  - Inicio de sesión con Google.
  - Creación/actualización automática de documentos de usuario en Firestore.
- **Página de Perfil de Usuario**:
  - Muestra la información del usuario (foto, nombre, email) desde Firestore.
  - Permite al usuario editar su nombre de perfil.
  - Permite al usuario subir una nueva foto de perfil desde la galería.
- **Mentor Estoico "Legacito" (v1)**:
  - Se ha introducido a Legacito en la `HomeScreen` a través de una tarjeta con la "Frase del Día".
  - Las frases se gestionan a través de un `LegacitoService`.

---

## Plan de Acción Actual: Creación de la Pantalla de "Logros"

**Objetivo:** Implementar la primera versión de la pantalla de "Logros" para que los usuarios puedan visualizar su progreso y sus hitos alcanzados.

**Pasos:**

1.  **Crear la Ruta y la Navegación**:
    -   Añadir la ruta `/achievements` en `go_router`.
    -   Añadir un `IconButton` con el icono `Icons.emoji_events_outlined` en la `AppBar` de la `HomeScreen` para navegar a la nueva pantalla.

2.  **Definir Modelos de Datos**:
    -   Crear `lib/features/achievements/data/models/achievement_model.dart` para la estructura de un logro (título, descripción, icono, fecha).
    -   Crear `lib/features/achievements/data/models/streak_model.dart` para la racha (actual y máxima).

3.  **Crear el Provider de Logros**:
    -   Crear `lib/features/achievements/presentation/providers/achievements_provider.dart`.
    -   Este `ChangeNotifier` gestionará el estado de las rachas y la lista de logros.
    -   Inicialmente, se cargarán datos de ejemplo (mock data) para la visualización.

4.  **Diseñar la Pantalla de Logros**:
    -   Crear el widget `lib/features/achievements/presentation/screens/achievements_screen.dart`.
    -   La pantalla mostrará una tarjeta destacada para las rachas y una lista de los logros obtenidos.
    -   Crear un widget reutilizable `AchievementTile` para mostrar cada logro de forma individual y estilizada.

5.  **Integrar el Provider**:
    -   Añadir `AchievementsProvider` al `MultiProvider` en `main.dart` para que esté disponible en toda la aplicación.