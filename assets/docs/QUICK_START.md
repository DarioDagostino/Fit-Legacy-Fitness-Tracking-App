# FigmaWidget - Quick Start Guide

## 🚀 5-Minute Quick Start

### Import
```dart
import 'package:fit_legacy_app/widgets/figma_widget.dart';
```

### Use a Preset
```dart
FigmaWidgetPresets.successCard(
  title: '¡Completado!',
  description: 'Has logrado tu objetivo',
  onTap: () {
    // Your action here
  },
)
```

### Custom Widget
```dart
FigmaWidget(
  title: 'My Title',
  description: 'My description',
  icon: Icons.star,
  iconColor: Colors.amber,
  backgroundGradient: LinearGradient(
    colors: [Colors.blue[600]!, Colors.purple[600]!],
  ),
  animated: true,
  onTap: () {},
)
```

## 📋 Available Presets

1. **infoCard** - Information messages
2. **successCard** - Success feedback
3. **warningCard** - Warnings/alerts
4. **achievementCard** - Achievements
5. **progressCard** - Progress indicators
6. **actionCard** - Multiple actions
7. **compactCard** - List items

## 🎯 Common Use Cases

### Achievement Notification
```dart
FigmaWidgetPresets.achievementCard(
  title: '🏆 New Achievement',
  subtitle: 'Level Up',
  description: 'You completed 10 workouts!',
)
```

### Progress Indicator
```dart
FigmaWidgetPresets.progressCard(
  title: 'Weekly Progress',
  progressWidget: LinearProgressIndicator(value: 0.65),
)
```

### Action Card
```dart
FigmaWidget(
  title: 'Workout',
  description: 'Strength training - 45 min',
  icon: Icons.fitness_center,
  actions: [
    FigmaWidgetAction(
      icon: Icons.play_arrow,
      onPressed: () => startWorkout(),
    ),
  ],
)
```

### List Item
```dart
FigmaWidgetPresets.compactCard(
  title: 'Nutrition',
  icon: Icons.restaurant,
  trailingWidget: Icon(Icons.chevron_right),
  onTap: () => navigateToNutrition(),
)
```

## 🎨 Key Properties

| Property | Type | Purpose |
|----------|------|---------|
| `title` | String | Main heading |
| `description` | String | Body text |
| `icon` | IconData | Leading icon |
| `backgroundColor` | Color | Solid background |
| `backgroundGradient` | Gradient | Gradient background |
| `onTap` | Function | Tap callback |
| `animated` | bool | Enable animations |
| `actions` | List | Action buttons |

## 📱 See It In Action

Run the demo:
```dart
Navigator.pushNamed(context, AppRoutes.figmaWidgetDemo);
```

Or tap the "Widgets Demo" floating button on the main screen!

## 📚 Full Documentation

- **Complete Guide:** `assets/docs/figma_widget_guide.md`
- **Examples:** `assets/docs/figma_widget_examples.md`
- **Visual Guide:** `assets/docs/figma_widget_visual_guide.md`
- **Summary:** `FIGMA_WIDGET_SUMMARY.md`

## 💡 Pro Tips

1. Use presets for common patterns
2. Use `AppColors` for consistency
3. Enable `animated: true` for nice entrances
4. Add actions for interactive cards
5. Use `customContent` for complex layouts

---

**Ready to build? Start with a preset and customize as needed!**
