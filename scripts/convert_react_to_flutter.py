#!/usr/bin/env python3
"""
Script para convertir componentes React de Legacito a assets de Flutter
"""

import os
import re
import json
from pathlib import Path

def extract_legacito_configs(react_file_path):
    """Extrae las configuraciones de los estados de Legacito del archivo React"""
    
    with open(react_file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Buscar el objeto states
    states_match = re.search(r'const states = \{([^}]+)\}', content, re.DOTALL)
    if not states_match:
        return {}
    
    states_content = states_match.group(1)
    
    # Extraer cada estado
    states = {}
    state_pattern = r'(\w+):\s*\{([^}]+)\}'
    
    for match in re.finditer(state_pattern, states_content):
        state_name = match.group(1)
        state_config = match.group(2)
        
        # Extraer propiedades del estado
        config = {}
        
        # Extraer valores simples
        simple_props = ['name', 'emoji', 'color', 'message', 'armRotation', 'headTilt', 'eyeSize', 'auraIntensity', 'bodyY']
        for prop in simple_props:
            pattern = f'{prop}:\s*([^,]+)'
            match_prop = re.search(pattern, state_config)
            if match_prop:
                value = match_prop.group(1).strip().strip("'\"")
                config[prop] = value
        
        states[state_name] = config
    
    return states

def generate_flutter_assets_config(states):
    """Genera configuración para assets de Flutter"""
    
    config = {
        "legacito_states": {},
        "flutter_colors": {},
        "flutter_messages": {}
    }
    
    for state_name, state_config in states.items():
        # Configuración del estado
        config["legacito_states"][state_name] = {
            "name": state_config.get('name', state_name.title()),
            "color": state_config.get('color', '#A0AEC0'),
            "arm_rotation": float(state_config.get('armRotation', 0)),
            "head_tilt": float(state_config.get('headTilt', 0)),
            "eye_size": float(state_config.get('eyeSize', 1.0)),
            "aura_intensity": float(state_config.get('auraIntensity', 0.15)),
            "body_y": float(state_config.get('bodyY', 0)),
            "emoji": state_config.get('emoji', '😌')
        }
        
        # Colores para Flutter
        color = state_config.get('color', '#A0AEC0')
        config["flutter_colors"][f"{state_name}_color"] = f"Color(0xFF{color[1:].upper()})"
        
        # Mensajes
        message = state_config.get('message', '')
        config["flutter_messages"][state_name] = message
    
    return config

def generate_flutter_dart_file(config):
    """Genera archivo Dart con la configuración"""
    
    dart_content = '''// Archivo generado automáticamente desde componentes React
// NO EDITAR MANUALMENTE

import 'package:flutter/material.dart';

class LegacitoStatesConfig {
  static const Map<String, LegacitoStateConfig> states = {
'''
    
    for state_name, state_config in config["legacito_states"].items():
        dart_content += f'''    '{state_name}': LegacitoStateConfig(
      name: '{state_config["name"]}',
      color: {config["flutter_colors"][f"{state_name}_color"]},
      armRotation: {state_config["arm_rotation"]},
      headTilt: {state_config["head_tilt"]},
      eyeSize: {state_config["eye_size"]},
      auraIntensity: {state_config["aura_intensity"]},
      bodyY: {state_config["body_y"]},
      emoji: '{state_config["emoji"]}',
    ),
'''
    
    dart_content += '''  };
  
  static const Map<String, String> messages = {
'''
    
    for state_name, message in config["flutter_messages"].items():
        dart_content += f'''    '{state_name}': '{message}',
'''
    
    dart_content += '''  };
}

class LegacitoStateConfig {
  final String name;
  final Color color;
  final double armRotation;
  final double headTilt;
  final double eyeSize;
  final double auraIntensity;
  final double bodyY;
  final String emoji;

  const LegacitoStateConfig({
    required this.name,
    required this.color,
    required this.armRotation,
    required this.headTilt,
    required this.eyeSize,
    required this.auraIntensity,
    required this.bodyY,
    required this.emoji,
  });
}
'''
    
    return dart_content

def main():
    # Directorio de los archivos React
    react_files_dir = Path("e:/")
    
    # Archivos de estados de Legacito
    legacito_files = [
        "legacito-motivado.tsx",
        "legacito-celebrando.tsx", 
        "legacito-neutral.tsx",
        "legacito-preocupado.tsx",
        "legacito-resiliente.tsx",
        "legacito-durmiendo.tsx",
        "legacito-pensativo.tsx",
        "legacito-energico.tsx"
    ]
    
    all_states = {}
    
    # Procesar cada archivo
    for file_name in legacito_files:
        file_path = react_files_dir / file_name
        if file_path.exists():
            print(f"Procesando {file_name}...")
            states = extract_legacito_configs(file_path)
            all_states.update(states)
        else:
            print(f"⚠️  Archivo no encontrado: {file_path}")
    
    if not all_states:
        print("❌ No se encontraron estados de Legacito")
        return
    
    # Generar configuración
    config = generate_flutter_assets_config(all_states)
    
    # Generar archivo Dart
    dart_content = generate_flutter_dart_file(config)
    
    # Guardar archivo
    output_path = Path("lib/core/config/legacito_states_config.dart")
    output_path.parent.mkdir(parents=True, exist_ok=True)
    
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(dart_content)
    
    print(f"✅ Configuración generada en: {output_path}")
    
    # Generar JSON para referencia
    json_path = Path("assets/data/legacito_states.json")
    json_path.parent.mkdir(parents=True, exist_ok=True)
    
    with open(json_path, 'w', encoding='utf-8') as f:
        json.dump(config, f, indent=2, ensure_ascii=False)
    
    print(f"✅ JSON de referencia generado en: {json_path}")
    
    # Mostrar resumen
    print(f"\n📊 Resumen:")
    print(f"   - Estados procesados: {len(all_states)}")
    print(f"   - Archivos generados: 2")
    print(f"   - Estados: {', '.join(all_states.keys())}")

if __name__ == "__main__":
    main()
