# Legacito SVG Assets

## Archivos Disponibles
- legacito_neutral.svg
- legacito_back.svg
- legacito_profile1.svg
- legacito_profile2.svg
- legacito_video.svg
- legacito_complete.svg

## Archivos Faltantes


## Uso en Flutter

### 1. Agregar al pubspec.yaml
```yaml
flutter:
  assets:
    - assets/images/legacito/
```

### 2. Usar en widgets
```dart
import 'package:flutter_svg/flutter_svg.dart';

SvgPicture.asset(
  'assets/images/legacito/legacito_neutral.svg',
  width: 200,
  height: 200,
)
```

### 3. Estados de Legacito
- `legacito_neutral.svg` - Estado neutral
- `legacito_back.svg` - Vista trasera
- `legacito_profile1.svg` - Perfil 1
- `legacito_profile2.svg` - Perfil 2
- `legacito_video.svg` - Estado de video
- `legacito_complete.svg` - Diseño completo

## Notas
- Todos los archivos están optimizados para Flutter
- Usar flutter_svg para renderizar
- Mantener proporciones originales
- Compatible con animaciones
