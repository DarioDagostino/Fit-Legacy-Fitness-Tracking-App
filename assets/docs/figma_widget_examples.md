# Ejemplos de FigmaWidget - Casos de Uso Reales

Este documento muestra ejemplos prácticos de cómo usar el FigmaWidget para implementar diseños específicos de Figma.

## Ejemplo 1: Recrear el Widget de Legacito

Si en Figma tienes un diseño similar al widget de Legacito, aquí está cómo implementarlo:

```dart
// Versión original de Legacito (código existente)
class LegacitoWidget extends ConsumerStatefulWidget {
  final String message;
  // ... código complejo con animaciones
}

// Versión simplificada usando FigmaWidget
FigmaWidget(
  title: 'Legacito',
  description: 'La constancia es tu mejor aliado',
  icon: Icons.psychology,
  iconColor: Colors.white,
  backgroundGradient: LinearGradient(
    colors: [Colors.blue[600]!, Colors.blue[800]!],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  elevation: 8,
  animated: true,
  dismissible: true,
  onDismiss: () {
    // Marcar como leído
  },
)
```

## Ejemplo 2: Tarjeta de Racha (Streak Card)

Basado en el diseño del storyboard de rachas:

```dart
class StreakCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streakLength = ref.watch(streakProvider);
    
    return FigmaWidget(
      title: '🔥 Racha actual',
      subtitle: '$streakLength días consecutivos',
      description: streakLength >= 7 
        ? 'El legado se forma cada día. Orgulloso de tu constancia.'
        : 'Cuida el hábito más que el número.',
      icon: Icons.local_fire_department,
      iconColor: streakLength >= 7 ? Colors.orange : AppColors.accent,
      backgroundGradient: streakLength >= 7
        ? LinearGradient(
            colors: [Colors.orange[400]!, Colors.red[400]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : LinearGradient(
            colors: [Colors.grey[700]!, Colors.grey[800]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
      animated: true,
      elevation: 8,
      actions: [
        FigmaWidgetAction(
          icon: Icons.share,
          onPressed: () {
            // Compartir racha
          },
          color: Colors.white,
          tooltip: 'Compartir',
        ),
      ],
      onTap: () {
        // Navegar a detalles de racha
        Navigator.pushNamed(context, '/achievements');
      },
    );
  }
}
```

## Ejemplo 3: Tarjeta de Meta Diaria (Daily Goal Card)

Especificaciones de Figma:
- Background: Linear gradient (#667eea → #764ba2)
- Border radius: 16px
- Padding: 20px
- Elevation: 6
- Icon: trending_up (24px, white)

```dart
FigmaWidget(
  title: 'Meta del Día',
  subtitle: 'Entrenamiento de Fuerza',
  icon: Icons.trending_up,
  iconColor: Colors.white,
  backgroundGradient: LinearGradient(
    colors: [
      Color(0xFF667eea),
      Color(0xFF764ba2),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  borderRadius: 16,
  padding: EdgeInsets.all(20),
  elevation: 6,
  customContent: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 12),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Progreso', style: TextStyle(color: Colors.white70)),
          Text('75%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
      SizedBox(height: 8),
      LinearProgressIndicator(
        value: 0.75,
        backgroundColor: Colors.white24,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
      SizedBox(height: 12),
      Row(
        children: [
          Icon(Icons.timer, color: Colors.white70, size: 16),
          SizedBox(width: 4),
          Text('30 min restantes', style: TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    ],
  ),
  animated: true,
  onTap: () {
    // Iniciar entrenamiento
  },
)
```

## Ejemplo 4: Notificación de Logro (Achievement Notification)

Especificaciones de Figma:
- Background: Solid #F59E0B (amber)
- Border radius: 12px
- Padding: 16px
- Shadow: elevation 8
- Animation: Slide in from right

```dart
FigmaWidget(
  title: '🏆 ¡Nuevo logro desbloqueado!',
  description: 'Has completado 10 entrenamientos este mes',
  icon: Icons.emoji_events,
  iconColor: Colors.white,
  backgroundColor: Color(0xFFF59E0B), // AppColors.accent
  borderRadius: 12,
  padding: EdgeInsets.all(16),
  elevation: 8,
  animated: true,
  animationDuration: Duration(milliseconds: 600),
  actions: [
    FigmaWidgetAction(
      icon: Icons.visibility,
      onPressed: () {
        // Ver detalles del logro
      },
      color: Colors.white,
      tooltip: 'Ver detalles',
    ),
  ],
  dismissible: true,
  onDismiss: () {
    // Marcar notificación como vista
  },
)
```

## Ejemplo 5: Tarjeta de Estadística (Stat Card)

Especificaciones de Figma:
- Background: #0B1220 (surface)
- Border: 1px solid #1E293B
- Border radius: 8px
- Padding: 12px
- No elevation (flat design)

```dart
FigmaWidget(
  title: 'Calorías Quemadas',
  subtitle: '2,450 kcal',
  icon: Icons.local_fire_department,
  iconColor: Colors.orange,
  iconSize: 20,
  backgroundColor: AppColors.surface,
  border: Border.all(color: AppColors.primaryVariant, width: 1),
  borderRadius: 8,
  padding: EdgeInsets.all(12),
  elevation: 0,
  trailingWidget: Icon(
    Icons.trending_up,
    color: AppColors.success,
    size: 20,
  ),
  onTap: () {
    // Ver detalles de calorías
  },
)
```

## Ejemplo 6: Card de Acción Rápida (Quick Action Card)

Para un grid de acciones rápidas en la pantalla principal:

```dart
GridView.count(
  crossAxisCount: 2,
  children: [
    FigmaWidget(
      title: 'Entrenar',
      icon: Icons.fitness_center,
      iconColor: AppColors.accent,
      backgroundColor: AppColors.surface,
      borderRadius: AppConfig.defaultBorderRadius,
      padding: EdgeInsets.all(AppConfig.defaultPadding),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.training);
      },
    ),
    FigmaWidget(
      title: 'Nutrición',
      icon: Icons.restaurant,
      iconColor: Colors.green,
      backgroundColor: AppColors.surface,
      borderRadius: AppConfig.defaultBorderRadius,
      padding: EdgeInsets.all(AppConfig.defaultPadding),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.nutrition);
      },
    ),
    // ... más acciones rápidas
  ],
)
```

## Ejemplo 7: Timeline Item (Elemento de Línea de Tiempo)

Para mostrar el historial de actividades:

```dart
class TimelineItem extends StatelessWidget {
  final String title;
  final String time;
  final String description;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FigmaWidget(
      title: title,
      subtitle: time,
      description: description,
      icon: icon,
      iconColor: color,
      iconSize: 20,
      leadingWidget: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      backgroundColor: AppColors.surface,
      padding: EdgeInsets.symmetric(
        horizontal: AppConfig.defaultPadding,
        vertical: AppConfig.smallPadding,
      ),
      margin: EdgeInsets.only(bottom: AppConfig.smallPadding),
      elevation: 2,
      borderRadius: AppConfig.smallBorderRadius,
    );
  }
}

// Uso:
TimelineItem(
  title: 'Entrenamiento completado',
  time: 'Hace 2 horas',
  description: 'Rutina de piernas - 45 minutos',
  icon: Icons.check_circle,
  color: AppColors.success,
)
```

## Ejemplo 8: Mensaje de Legacito Contextual

Basado en el contexto del usuario:

```dart
class ContextualLegacito extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userStateProvider);
    
    // Determinar mensaje basado en contexto
    String message;
    IconData icon;
    Gradient gradient;
    
    if (userState.lastWorkout != null && 
        DateTime.now().difference(userState.lastWorkout!) > Duration(days: 3)) {
      message = 'Te extraño por aquí. Recuerda que la constancia es clave.';
      icon = Icons.psychology;
      gradient = LinearGradient(
        colors: [Colors.amber[600]!, Colors.orange[600]!],
      );
    } else if (userState.streakLength >= 7) {
      message = 'Impresionante racha. El legado se construye día a día.';
      icon = Icons.psychology;
      gradient = LinearGradient(
        colors: [Colors.purple[600]!, Colors.blue[600]!],
      );
    } else {
      message = 'Buen trabajo. Cada paso cuenta hacia tu legado.';
      icon = Icons.psychology;
      gradient = LinearGradient(
        colors: [Colors.blue[600]!, Colors.blue[800]!],
      );
    }
    
    return FigmaWidget(
      title: 'Legacito',
      description: message,
      icon: icon,
      iconColor: Colors.white,
      backgroundGradient: gradient,
      elevation: 6,
      animated: true,
      dismissible: true,
      onDismiss: () {
        ref.read(appStateProvider.notifier).dismissLegacito();
      },
    );
  }
}
```

## Ejemplo 9: Card Expandible (Expandable Card)

Para mostrar información detallada al hacer clic:

```dart
class ExpandableWorkoutCard extends StatefulWidget {
  final String title;
  final List<String> exercises;

  @override
  State<ExpandableWorkoutCard> createState() => _ExpandableWorkoutCardState();
}

class _ExpandableWorkoutCardState extends State<ExpandableWorkoutCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return FigmaWidget(
      title: widget.title,
      subtitle: '${widget.exercises.length} ejercicios',
      icon: Icons.fitness_center,
      iconColor: AppColors.accent,
      backgroundColor: AppColors.surface,
      trailingWidget: Icon(
        _expanded ? Icons.expand_less : Icons.expand_more,
        color: AppColors.textSecondary,
      ),
      customContent: _expanded
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                Divider(color: AppColors.primaryVariant),
                SizedBox(height: 8),
                ...widget.exercises.map((exercise) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle_outline, 
                           size: 16, 
                           color: AppColors.textSecondary),
                      SizedBox(width: 8),
                      Text(exercise, 
                           style: TextStyle(color: AppColors.textSecondary)),
                    ],
                  ),
                )),
              ],
            )
          : null,
      onTap: () {
        setState(() {
          _expanded = !_expanded;
        });
      },
    );
  }
}
```

## Ejemplo 10: Loading State Card

Para mostrar estados de carga:

```dart
FigmaWidget(
  title: 'Cargando datos...',
  icon: Icons.hourglass_empty,
  iconColor: AppColors.textSecondary,
  backgroundColor: AppColors.surface,
  customContent: Padding(
    padding: EdgeInsets.only(top: 12),
    child: LinearProgressIndicator(
      backgroundColor: Colors.grey[700],
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
    ),
  ),
)
```

## Mapeo de Propiedades Figma → FigmaWidget

| Propiedad en Figma | Propiedad en FigmaWidget | Ejemplo |
|-------------------|-------------------------|---------|
| Fill (Color sólido) | `backgroundColor` | `Color(0xFF1E293B)` |
| Fill (Gradient) | `backgroundGradient` | `LinearGradient(...)` |
| Corner Radius | `borderRadius` | `12.0` |
| Drop Shadow | `elevation` | `4.0` |
| Stroke | `border` | `Border.all(...)` |
| Padding | `padding` | `EdgeInsets.all(16)` |
| Width | `width` | `300.0` |
| Height | `height` | `120.0` |
| Icon | `icon` | `Icons.star` |
| Icon Color | `iconColor` | `Colors.amber` |
| Text (Title) | `title` | `'Mi Título'` |
| Text (Body) | `description` | `'Descripción'` |

## Tips para Implementar Diseños de Figma

1. **Exporta los valores exactos**: Usa el inspector de Figma para obtener valores precisos
2. **Usa constantes**: Define colores y tamaños en `AppColors` y `AppConfig`
3. **Prueba en diferentes tamaños**: Asegúrate de que se vea bien en diferentes dispositivos
4. **Mantén la consistencia**: Usa los presets cuando sea posible
5. **Considera el dark mode**: Ajusta colores para modo oscuro
6. **Optimiza las animaciones**: No todas las tarjetas necesitan animación
7. **Accesibilidad**: Verifica contraste y tamaños de toque

## Próximos Pasos

- Implementa tus diseños de Figma usando estos ejemplos como guía
- Crea tus propios presets para patrones repetitivos
- Contribuye ejemplos adicionales a este documento
- Comparte feedback sobre el FigmaWidget para mejorarlo
