# FigmaWidget - Guía de Uso

## Descripción General

El `FigmaWidget` es un componente flexible y altamente personalizable diseñado para implementar diseños de Figma en la aplicación Fit Legacy. Proporciona una interfaz consistente y reutilizable para crear tarjetas y componentes visuales.

## Características Principales

### 1. **Contenido Flexible**
- Título, subtítulo y descripción
- Soporte para widgets personalizados
- Secciones de cabecera y pie

### 2. **Estilo Visual**
- Colores personalizables
- Gradientes de fondo
- Bordes y elevación configurables
- Border radius ajustable

### 3. **Iconos e Imágenes**
- Soporte para IconData de Material
- Widgets personalizados para leading y trailing
- Tamaño y color de iconos configurables

### 4. **Interacciones**
- onTap y onLongPress
- Widgets descartables (dismissible)
- Botones de acción incorporados

### 5. **Animaciones**
- Animaciones de entrada opcionales
- Duración de animación configurable
- Transiciones suaves

## Uso Básico

### Ejemplo Simple

```dart
FigmaWidget(
  title: 'Mi Título',
  description: 'Descripción del contenido',
  icon: Icons.star,
  iconColor: Colors.amber,
  onTap: () {
    print('Widget tapped!');
  },
)
```

### Con Gradiente

```dart
FigmaWidget(
  title: 'Tarjeta con Gradiente',
  description: 'Esta tarjeta tiene un fondo degradado',
  icon: Icons.palette,
  backgroundGradient: LinearGradient(
    colors: [Colors.blue[600]!, Colors.purple[600]!],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  animated: true,
)
```

### Con Acciones

```dart
FigmaWidget(
  title: 'Tarjeta con Acciones',
  description: 'Puedes agregar múltiples acciones',
  icon: Icons.task,
  actions: [
    FigmaWidgetAction(
      icon: Icons.edit,
      onPressed: () => print('Edit'),
      tooltip: 'Editar',
    ),
    FigmaWidgetAction(
      icon: Icons.delete,
      onPressed: () => print('Delete'),
      color: Colors.red,
      tooltip: 'Eliminar',
    ),
  ],
)
```

## Presets Disponibles

El `FigmaWidgetPresets` proporciona configuraciones predefinidas para casos de uso comunes:

### 1. **Info Card**
```dart
FigmaWidgetPresets.infoCard(
  title: 'Información',
  description: 'Mensaje informativo para el usuario',
  onTap: () {},
)
```

### 2. **Success Card**
```dart
FigmaWidgetPresets.successCard(
  title: '¡Completado!',
  description: 'Has logrado tu objetivo',
  onTap: () {},
)
```

### 3. **Warning Card**
```dart
FigmaWidgetPresets.warningCard(
  title: 'Atención',
  description: 'Revisa esta información importante',
  onTap: () {},
)
```

### 4. **Achievement Card**
```dart
FigmaWidgetPresets.achievementCard(
  title: 'Nuevo Logro',
  subtitle: 'Nivel alcanzado',
  description: 'Has desbloqueado un nuevo logro',
  onTap: () {},
)
```

### 5. **Progress Card**
```dart
FigmaWidgetPresets.progressCard(
  title: 'Tu Progreso',
  progressWidget: LinearProgressIndicator(value: 0.7),
  onTap: () {},
)
```

### 6. **Action Card**
```dart
FigmaWidgetPresets.actionCard(
  title: 'Opciones',
  description: 'Selecciona una acción',
  actions: [
    FigmaWidgetAction(icon: Icons.share, onPressed: () {}),
    FigmaWidgetAction(icon: Icons.favorite, onPressed: () {}),
  ],
)
```

### 7. **Compact Card**
```dart
FigmaWidgetPresets.compactCard(
  title: 'Item de Lista',
  icon: Icons.list,
  trailingWidget: Icon(Icons.chevron_right),
  onTap: () {},
)
```

## Propiedades Detalladas

### Contenido
| Propiedad | Tipo | Descripción |
|-----------|------|-------------|
| `title` | `String?` | Título principal del widget |
| `subtitle` | `String?` | Subtítulo opcional |
| `description` | `String?` | Descripción o texto adicional |
| `customContent` | `Widget?` | Widget personalizado para el contenido |

### Estilo Visual
| Propiedad | Tipo | Descripción | Default |
|-----------|------|-------------|---------|
| `backgroundColor` | `Color?` | Color de fondo sólido | `AppColors.surface` |
| `backgroundGradient` | `Gradient?` | Gradiente de fondo | `null` |
| `elevation` | `double?` | Elevación de la tarjeta | `4.0` |
| `borderRadius` | `double?` | Radio de los bordes | `AppConfig.defaultBorderRadius` |
| `border` | `Border?` | Borde personalizado | `null` |

### Iconos
| Propiedad | Tipo | Descripción | Default |
|-----------|------|-------------|---------|
| `icon` | `IconData?` | Icono principal | `null` |
| `iconColor` | `Color?` | Color del icono | `AppColors.accent` |
| `iconSize` | `double?` | Tamaño del icono | `24.0` |
| `leadingWidget` | `Widget?` | Widget personalizado al inicio | `null` |
| `trailingWidget` | `Widget?` | Widget personalizado al final | `null` |

### Layout
| Propiedad | Tipo | Descripción | Default |
|-----------|------|-------------|---------|
| `padding` | `EdgeInsets?` | Padding interno | `EdgeInsets.all(16)` |
| `margin` | `EdgeInsets?` | Margen externo | `EdgeInsets.all(8)` |
| `width` | `double?` | Ancho del widget | `null` |
| `height` | `double?` | Alto del widget | `null` |
| `mainAxisAlignment` | `MainAxisAlignment` | Alineación del eje principal | `start` |
| `crossAxisAlignment` | `CrossAxisAlignment` | Alineación del eje cruzado | `start` |

### Interacciones
| Propiedad | Tipo | Descripción | Default |
|-----------|------|-------------|---------|
| `onTap` | `VoidCallback?` | Callback al tocar | `null` |
| `onLongPress` | `VoidCallback?` | Callback al mantener presionado | `null` |
| `onDismiss` | `VoidCallback?` | Callback al descartar | `null` |
| `dismissible` | `bool` | Permitir descartar deslizando | `false` |
| `actions` | `List<FigmaWidgetAction>?` | Lista de acciones | `null` |

### Animaciones
| Propiedad | Tipo | Descripción | Default |
|-----------|------|-------------|---------|
| `animated` | `bool` | Activar animación de entrada | `false` |
| `animationDuration` | `Duration?` | Duración de la animación | `300ms` |

## Casos de Uso

### 1. Tarjeta de Logro
```dart
FigmaWidget(
  title: 'Racha de 30 días',
  subtitle: 'Logro épico',
  description: '¡Increíble consistencia! Has mantenido tu racha por 30 días consecutivos.',
  icon: Icons.emoji_events,
  iconColor: AppColors.accent,
  backgroundGradient: AppColors.accentGradient,
  elevation: 8,
  animated: true,
  onTap: () {
    // Navegar a detalles del logro
  },
)
```

### 2. Tarjeta de Progreso Diario
```dart
FigmaWidget(
  title: 'Progreso de Hoy',
  icon: Icons.trending_up,
  iconColor: AppColors.success,
  customContent: Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Pasos: 8,500 / 10,000'),
          Text('85%'),
        ],
      ),
      SizedBox(height: 8),
      LinearProgressIndicator(value: 0.85),
    ],
  ),
  backgroundColor: AppColors.surface,
  animated: true,
)
```

### 3. Mensaje de Legacito
```dart
FigmaWidget(
  title: 'Legacito',
  description: 'La disciplina es el puente entre tus metas y tus logros.',
  icon: Icons.psychology,
  iconColor: Colors.white,
  backgroundGradient: LinearGradient(
    colors: [Colors.purple[600]!, Colors.blue[600]!],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  animated: true,
  dismissible: true,
  onDismiss: () {
    // Marcar mensaje como leído
  },
)
```

### 4. Elemento de Lista Interactivo
```dart
FigmaWidget(
  title: 'Entrenamiento de Fuerza',
  subtitle: '45 minutos',
  icon: Icons.fitness_center,
  trailingWidget: Icon(Icons.chevron_right, color: AppColors.textSecondary),
  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  backgroundColor: AppColors.surface,
  onTap: () {
    // Navegar a detalles del entrenamiento
  },
)
```

## Integración con Figma

### Paso 1: Exportar Especificaciones de Figma
1. Selecciona el elemento en Figma
2. Copia las propiedades de diseño (colores, tamaños, espaciado)
3. Exporta iconos como SVG si es necesario

### Paso 2: Mapear Propiedades
| Propiedad Figma | Propiedad FigmaWidget |
|-----------------|----------------------|
| Fill Color | `backgroundColor` |
| Gradient | `backgroundGradient` |
| Border Radius | `borderRadius` |
| Shadow | `elevation` |
| Padding | `padding` |
| Margin | `margin` |

### Paso 3: Implementar
```dart
// Ejemplo basado en diseño de Figma
FigmaWidget(
  title: 'Título del Diseño',
  description: 'Descripción',
  backgroundColor: Color(0xFF1E293B), // Del color de Figma
  borderRadius: 12, // Del border radius de Figma
  elevation: 4, // Basado en la sombra de Figma
  padding: EdgeInsets.all(20), // Del padding de Figma
  // ... más propiedades
)
```

## Buenas Prácticas

1. **Usa Presets cuando sea posible**: Los presets proporcionan configuraciones consistentes y probadas.

2. **Mantén la consistencia**: Usa los colores y estilos de `AppColors` y `AppConfig`.

3. **Animaciones con moderación**: Activa animaciones solo cuando mejoren la UX, no en listas largas.

4. **Accesibilidad**: Proporciona tooltips para los botones de acción.

5. **Responsive**: Considera el uso de `width` y `height` solo cuando sea necesario; deja que el widget se adapte.

6. **Performance**: Evita widgets complejos en `customContent` si planeas usarlos en listas largas.

## Ejemplos Avanzados

### Tarjeta con Múltiples Secciones
```dart
FigmaWidget(
  title: 'Resumen Semanal',
  icon: Icons.calendar_today,
  customContent: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 12),
      _buildStatRow('Entrenamientos', '5/7'),
      _buildStatRow('Calorías quemadas', '2,450'),
      _buildStatRow('Pasos totales', '67,890'),
      SizedBox(height: 12),
      ElevatedButton(
        onPressed: () {},
        child: Text('Ver Detalles'),
      ),
    ],
  ),
  backgroundColor: AppColors.surface,
  animated: true,
)
```

### Tarjeta con Estado Dinámico
```dart
class DynamicFigmaCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streakLength = ref.watch(streakProvider);
    
    return FigmaWidget(
      title: 'Tu Racha',
      description: '$streakLength días consecutivos',
      icon: streakLength >= 7 ? Icons.local_fire_department : Icons.trending_up,
      iconColor: streakLength >= 7 ? Colors.orange : AppColors.accent,
      backgroundGradient: streakLength >= 7
          ? LinearGradient(colors: [Colors.orange[400]!, Colors.red[400]!])
          : null,
      backgroundColor: streakLength < 7 ? AppColors.surface : null,
      animated: true,
    );
  }
}
```

## Solución de Problemas

### El widget no se muestra
- Verifica que el widget esté dentro de un `Scaffold` o contenedor con dimensiones definidas
- Asegúrate de que los colores no sean transparentes

### Las animaciones no funcionan
- Confirma que `animated: true` esté configurado
- Verifica que no haya conflictos con otras animaciones en la jerarquía

### Los botones de acción no responden
- Verifica que los callbacks `onPressed` estén definidos correctamente
- Asegúrate de que no haya un `GestureDetector` o `InkWell` superior que capture los toques

## Roadmap

Futuras mejoras planeadas:
- [ ] Soporte para animaciones Lottie
- [ ] Temas personalizables
- [ ] Más presets predefinidos
- [ ] Soporte para drag and drop
- [ ] Integración con skeleton loading
- [ ] Modo de vista previa de diseño

## Contribuir

Para agregar nuevos presets o funcionalidades:
1. Sigue el patrón de código existente
2. Documenta todos los parámetros
3. Agrega ejemplos de uso
4. Prueba en diferentes tamaños de pantalla

## Referencias

- Documentación de Flutter: https://flutter.dev/docs
- Material Design: https://material.io/design
- App Colors: `lib/core/constants/app_colors.dart`
- App Config: `lib/core/config/app_config.dart`
