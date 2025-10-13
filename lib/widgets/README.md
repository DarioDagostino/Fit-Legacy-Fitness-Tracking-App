# Widgets Directory

Este directorio contiene los widgets reutilizables de la aplicación Fit Legacy.

## Widgets Disponibles

### FigmaWidget (`figma_widget.dart`)

Un componente flexible y altamente personalizable para implementar diseños de Figma.

**Características principales:**
- Contenido flexible (título, subtítulo, descripción, widgets personalizados)
- Estilo visual personalizable (colores, gradientes, elevación, bordes)
- Soporte para iconos e imágenes
- Interacciones (tap, long press, dismiss)
- Acciones integradas
- Animaciones opcionales
- 7 presets predefinidos

**Uso básico:**
```dart
import 'package:fit_legacy_app/widgets/figma_widget.dart';

FigmaWidget(
  title: 'Mi Título',
  description: 'Descripción',
  icon: Icons.star,
  onTap: () {},
)
```

**Presets disponibles:**
- `FigmaWidgetPresets.infoCard()` - Tarjeta de información
- `FigmaWidgetPresets.successCard()` - Tarjeta de éxito
- `FigmaWidgetPresets.warningCard()` - Tarjeta de advertencia
- `FigmaWidgetPresets.achievementCard()` - Tarjeta de logro
- `FigmaWidgetPresets.progressCard()` - Tarjeta de progreso
- `FigmaWidgetPresets.actionCard()` - Tarjeta con acciones
- `FigmaWidgetPresets.compactCard()` - Tarjeta compacta

**Demo:**
Para ver todos los ejemplos y variaciones, ejecuta la demo:
```dart
Navigator.pushNamed(context, AppRoutes.figmaWidgetDemo);
```

**Documentación completa:**
Ver `assets/docs/figma_widget_guide.md` para la guía completa de uso.

---

### LegacitoWidget (`legacito_widget.dart`)

Widget animado para mostrar mensajes del mentor "Legacito".

**Componentes:**
- `LegacitoWidget` - Widget principal con animaciones
- `LegacitoOverlay` - Overlay para mostrar sobre otras pantallas
- `LegacitoDailyQuote` - Tarjeta para citas diarias

**Uso:**
```dart
LegacitoWidget(
  message: 'La constancia es la clave del éxito',
  onDismiss: () {},
)
```

---

### AuthLogo (`auth_logo.dart`)

Widget que muestra el logo de la aplicación con fallback.

**Características:**
- Intenta cargar SVG o PNG desde assets
- Fallback a texto "FL" si no hay logo
- Circular con sombra

**Uso:**
```dart
AuthLogo(size: 74)
```

---

### AuthCard (`auth_card.dart`)

Tarjeta estandarizada para pantallas de autenticación.

**Características:**
- Header opcional
- Ancho máximo configurable
- Estilo consistente con el tema

**Uso:**
```dart
AuthCard(
  header: Text('Bienvenido'),
  child: LoginForm(),
  maxWidth: 400,
)
```

---

## Convenciones

1. **Nombres de archivo:** snake_case (ej: `figma_widget.dart`)
2. **Nombres de clase:** PascalCase (ej: `FigmaWidget`)
3. **Uso de ConsumerWidget:** Preferir cuando se necesita acceso a Riverpod
4. **Documentación:** Todos los widgets públicos deben tener documentación
5. **Temas:** Usar siempre `AppColors` y `AppConfig` para consistencia

## Agregar Nuevos Widgets

Al agregar un nuevo widget:

1. Crea el archivo en este directorio
2. Sigue el patrón de documentación existente
3. Usa tipos de la carpeta `core/constants/` para colores y configuración
4. Agrega ejemplos en este README
5. Considera agregar a la demo si es un widget visual complejo
6. Actualiza la documentación relevante

## Testing

Los widgets deben ser probables y testables:
- Mantén la lógica de negocio fuera de los widgets
- Usa callbacks para comunicación con padres
- Considera widget tests para widgets complejos

## Performance

Consideraciones de rendimiento:
- Evita reconstrucciones innecesarias
- Usa `const` cuando sea posible
- Para listas largas, considera lazy loading
- Widgets animados: usa `AnimatedBuilder` o similar

## Accessibility

Todos los widgets deben considerar:
- Semantics para lectores de pantalla
- Contraste de colores adecuado
- Tamaño de toque mínimo de 44x44
- Reduce motion para animaciones
