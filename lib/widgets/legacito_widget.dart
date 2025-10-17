import 'package:flutter/material.dart';
import '../models/legacito_state.dart';
import 'legacito_custom_widget.dart';
import 'legacito_svg_robot_widget.dart';

/// Un widget que muestra a Legacito, el asistente robot.
///
/// Por defecto, utiliza la versión SVG (`LegacitoSvgRobotWidget`).
/// Si [useSvg] se establece en `false`, mostrará la versión personalizada
/// con animaciones Flutter (`LegacitoCustomWidget`).
class LegacitoWidget extends StatelessWidget {
  final LegacitoMood mood;
  final bool isAnimating;
  final double size;
  final bool useSvg;

  const LegacitoWidget({
    super.key,
    required this.mood,
    this.isAnimating = false,
    this.size = 200,
    this.useSvg = true, // Usa la versión SVG por defecto
  });

  @override
  Widget build(BuildContext context) {
    return useSvg
        ? LegacitoSvgRobotWidget(
            mood: mood, isAnimating: isAnimating, size: size)
        : LegacitoCustomWidget(
            mood: mood, isAnimating: isAnimating, size: size);
  }
}
