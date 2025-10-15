# 🏛️ Fit Legacy - App de Fitness Estoico con Legacito

Una aplicación Flutter que combina el seguimiento de fitness con la filosofía estoica, protagonizada por **Legacito**, tu compañero de entrenamiento estoico.

## 🎯 Características Principales

### 🤖 Legacito - Tu Compañero Estoico
- **8 Estados de Ánimo**: Motivado, celebrando, neutral, preocupado, resiliente, durmiendo, pensativo, energético
- **Chat Inteligente**: Integración con Gemini AI para respuestas personalizadas
- **Animaciones Fluidas**: Transiciones suaves entre estados
- **Mensajes Motivacionales**: Basados en la filosofía estoica de Marco Aurelio, Epicteto y Séneca

### 📱 Funcionalidades Core
- **Contador de Pasos Real**: Integración con pedometer nativo
- **Sistema de Rachas**: Seguimiento de días consecutivos con logros
- **Gamificación**: Medallas y logros basados en filosofía estoica
- **Chat con IA**: Respuestas inteligentes usando Gemini AI
- **Diseño Pixel-Perfect**: UI/UX optimizada para todos los dispositivos

## 🏗️ Arquitectura Técnica

### 📁 Estructura del Proyecto
```
lib/
├── core/
│   ├── constants/          # Colores, tipografías, espaciado
│   ├── theme/             # Temas claro y oscuro
│   └── config/            # Configuración de la app
├── models/                # Modelos de datos con Freezed
├── providers/             # Estado con Riverpod
│   ├── legacito_provider.dart
│   ├── pedometer_provider.dart
│   ├── streak_provider.dart
│   └── gemini_provider.dart
├── screens/               # Pantallas de la app
│   ├── home_screen.dart
│   ├── chat_legacito_screen.dart
│   ├── streak_screen.dart
│   └── step_tracking_screen.dart
└── widgets/               # Componentes reutilizables
    ├── legacito_widget.dart
    ├── streak_widgets.dart
    └── pixel_perfect_widgets.dart
```

### 🎨 Sistema de Diseño
- **8-Point Grid System**: Espaciado consistente
- **Responsive Design**: ScreenUtil para escalado perfecto
- **Material Design 3**: Componentes modernos
- **Animaciones**: flutter_animate para transiciones suaves

## 🚀 Instalación y Configuración

### 1. Clonar el Repositorio
```bash
git clone <repository_url>
cd fit-legacy-fitness-tracking-app
```

### 2. Instalar Dependencias
```bash
flutter pub get
```

### 3. Configurar Gemini AI
1. Obtener API key de [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Actualizar `lib/core/config/app_config.dart`:
```dart
static const String geminiApiKey = 'TU_API_KEY_AQUI';
```

### 4. Configurar Permisos

#### Android (`android/app/src/main/AndroidManifest.xml`)
```xml
<uses-permission android:name="android.permission.ACTIVITY_RECOGNITION" />
<uses-permission android:name="android.permission.WAKE_LOCK" />
<uses-permission android:name="android.permission.INTERNET" />
```

#### iOS (`ios/Runner/Info.plist`)
```xml
<key>NSMotionUsageDescription</key>
<string>Esta aplicación necesita acceso al sensor de movimiento para contar tus pasos</string>
```

### 5. Ejecutar la App
```bash
flutter run
```

## 🎭 Estados de Legacito

### 📊 Lógica de Estados
```dart
enum LegacitoMood {
  motivado,      // 50-80% de la meta
  celebrando,    // Meta alcanzada (100%+)
  neutral,       // 20-50% de la meta
  preocupado,    // <20% de la meta
  resiliente,    // Después de un día sin actividad
  durmiendo,     // Horario nocturno
  pensativo,     // Reflexionando
  energico,      // Mañana temprano
}
```

### 🎨 Assets Requeridos
```
assets/images/legacito/
├── legacito_motivado.png
├── legacito_celebrando.png
├── legacito_neutral.png
├── legacito_preocupado.png
├── legacito_resiliente.png
├── legacito_durmiendo.png
├── legacito_pensativo.png
└── legacito_energico.png
```

## 🤖 Integración con Gemini AI

### Configuración
```dart
// En lib/providers/gemini_provider.dart
final geminiProvider = StateNotifierProvider<GeminiNotifier, GeminiState>((ref) {
  return GeminiNotifier();
});
```

### Uso
```dart
// Enviar mensaje a Legacito
final response = await ref.read(geminiProvider.notifier).sendMessage("Estoy cansado");
```

### Respuestas Inteligentes
- **Contexto Estoico**: Legacito responde como un filósofo estoico
- **Motivación Personalizada**: Basada en el progreso del usuario
- **Fallback Local**: Respuestas predefinidas si Gemini no está disponible

## 📊 Sistema de Rachas

### Funcionalidades
- **Seguimiento Diario**: Registro automático de actividad
- **Rachas Consecutivas**: Contador de días sin interrupciones
- **Logros**: Medallas por hitos (7, 30, 100 días)
- **Estadísticas**: Progreso semanal y mensual

### Implementación
```dart
// Registrar actividad
await ref.read(streakProvider.notifier).recordActivity(steps, goal);

// Obtener racha actual
final currentStreak = ref.watch(currentStreakProvider);
```

## 🎮 Gamificación

### Logros Disponibles
- **Primera Semana**: 7 días consecutivos
- **Mes Estoico**: 30 días consecutivos
- **Maestro de la Disciplina**: 100 días consecutivos
- **Early Bird**: Entrenar antes de las 8 AM
- **Step Master**: Alcanzar meta diaria de pasos

### Sistema de Medallas
```dart
class AchievementBadge extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isUnlocked;
  final double progress;
}
```

## 📱 Pantallas Principales

### 🏠 Home Screen
- **Legacito Central**: Estado actual y mensaje motivacional
- **Contador de Pasos**: Progreso hacia la meta diaria
- **Métricas**: Calorías, distancia, minutos activos
- **Racha Actual**: Días consecutivos
- **Logros del Día**: Progreso hacia logros

### 💬 Chat con Legacito
- **Interfaz de Chat**: Burbujas de mensaje estilo WhatsApp
- **Respuestas IA**: Gemini AI para respuestas inteligentes
- **Historial**: Conversaciones guardadas
- **Estados Visuales**: Legacito cambia según el contexto

### 🔥 Pantalla de Rachas
- **Racha Actual**: Número prominente de días consecutivos
- **Progreso Semanal**: Visualización de los últimos 7 días
- **Estadísticas**: Racha más larga, total de días
- **Logros**: Medallas desbloqueadas
- **Motivación**: Citas estoicas personalizadas

## 🛠️ Desarrollo

### Comandos Útiles
```bash
# Generar código
flutter packages pub run build_runner build

# Limpiar y regenerar
flutter packages pub run build_runner build --delete-conflicting-outputs

# Ejecutar tests
flutter test

# Análisis de código
flutter analyze
```

### Estructura de Providers
```dart
// Estado de Legacito
final legacitoProvider = StateNotifierProvider<LegacitoNotifier, LegacitoState>

// Pedometer
final pedometerProvider = StateNotifierProvider<PedometerNotifier, PedometerState>

// Rachas
final streakProvider = StateNotifierProvider<StreakNotifier, StreakState>

// Gemini AI
final geminiProvider = StateNotifierProvider<GeminiNotifier, GeminiState>
```

## 🎨 Personalización

### Colores
```dart
// En lib/core/constants/app_colors.dart
static const Color primary = Color(0xFF6C5CE7);
static const Color golden = Color(0xFFD4AF37);
static const Color success = Color(0xFF00B894);
```

### Tipografías
```dart
// En lib/core/constants/app_text_styles.dart
static TextStyle get h1 => _baseStyle.copyWith(
  fontSize: 32.sp,
  fontWeight: FontWeight.w700,
);
```

### Espaciado
```dart
// En lib/core/constants/app_spacing.dart
static double get sm => 8.w;
static double get md => 16.w;
static double get lg => 24.w;
```

## 📈 Roadmap

### ✅ Completado
- [x] Sistema de diseño pixel-perfect
- [x] Widget de Legacito con 8 estados
- [x] Integración con pedometer
- [x] Sistema de rachas
- [x] Chat con Gemini AI
- [x] Gamificación básica

### 🚧 En Desarrollo
- [ ] Assets de Legacito (imágenes)
- [ ] Notificaciones push
- [ ] Modo oscuro
- [ ] Sincronización en la nube

### 🔮 Futuro
- [ ] Integración con Apple Health / Google Fit
- [ ] Red social de usuarios
- [ ] Desafíos grupales
- [ ] Análisis avanzados
- [ ] Widgets de pantalla de inicio

## 🤝 Contribuir

1. Fork el proyecto
2. Crear una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abrir un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver `LICENSE` para más detalles.

## 🙏 Agradecimientos

- **Filosofía Estoica**: Marco Aurelio, Epicteto, Séneca
- **Flutter Team**: Por el framework increíble
- **Google AI**: Por Gemini AI
- **Comunidad Flutter**: Por las librerías y el apoyo

---

**"La disciplina es el puente entre las metas y los logros."** - Legacito 🏛️
