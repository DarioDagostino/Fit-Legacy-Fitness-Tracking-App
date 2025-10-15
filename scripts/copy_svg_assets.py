#!/usr/bin/env python3
"""
Script para copiar archivos SVG de Legacito a la carpeta de assets
"""

import os
import shutil
from pathlib import Path

def copy_svg_assets():
    """Copia los archivos SVG de Legacito a la carpeta de assets"""
    
    # Directorio fuente (donde están los SVGs)
    source_dir = Path("e:/")
    
    # Directorio destino
    assets_dir = Path("assets/images/legacito")
    assets_dir.mkdir(parents=True, exist_ok=True)
    
    # Mapeo de archivos SVG a nombres de estados
    svg_mapping = {
        "Legacito 1.svg": "legacito_neutral.svg",
        "legacito espalda.svg": "legacito_back.svg", 
        "legacito perfil1.svg": "legacito_profile1.svg",
        "legacito perfil2.svg": "legacito_profile2.svg",
        "VID-20251004-WA0002 1.svg": "legacito_video.svg",
        "legacito_complete_vector.svg": "legacito_complete.svg"
    }
    
    copied_files = []
    missing_files = []
    
    print("🔄 Copiando archivos SVG de Legacito...")
    
    for source_name, target_name in svg_mapping.items():
        source_path = source_dir / source_name
        target_path = assets_dir / target_name
        
        if source_path.exists():
            try:
                shutil.copy2(source_path, target_path)
                copied_files.append(target_name)
                print(f"✅ Copiado: {source_name} → {target_name}")
            except Exception as e:
                print(f"❌ Error copiando {source_name}: {e}")
        else:
            missing_files.append(source_name)
            print(f"⚠️  Archivo no encontrado: {source_name}")
    
    # Crear archivo de referencia con información de los SVGs
    create_svg_reference_file(assets_dir, copied_files, missing_files)
    
    print(f"\n📊 Resumen:")
    print(f"   - Archivos copiados: {len(copied_files)}")
    print(f"   - Archivos faltantes: {len(missing_files)}")
    print(f"   - Directorio destino: {assets_dir.absolute()}")
    
    if copied_files:
        print(f"\n📁 Archivos disponibles:")
        for file in copied_files:
            print(f"   - {file}")
    
    if missing_files:
        print(f"\n⚠️  Archivos faltantes:")
        for file in missing_files:
            print(f"   - {file}")

def create_svg_reference_file(assets_dir, copied_files, missing_files):
    """Crea un archivo de referencia con información de los SVGs"""
    
    reference_content = f"""# Legacito SVG Assets

## Archivos Disponibles
{chr(10).join(f"- {file}" for file in copied_files)}

## Archivos Faltantes
{chr(10).join(f"- {file}" for file in missing_files)}

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
"""
    
    reference_path = assets_dir / "README.md"
    with open(reference_path, 'w', encoding='utf-8') as f:
        f.write(reference_content)
    
    print(f"📝 Archivo de referencia creado: {reference_path}")

if __name__ == "__main__":
    copy_svg_assets()
