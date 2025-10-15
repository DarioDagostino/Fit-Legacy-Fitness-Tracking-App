import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/legacito_state.dart';
import '../widgets/pixel_perfect_widgets.dart';
import 'legacito_robot_widget.dart';
import 'legacito_svg_robot_widget.dart';

class LegacitoSelectorWidget extends StatelessWidget {
  final LegacitoMood mood;
  final bool isAnimating;
  final double size;
  final LegacitoRenderType renderType;

  const LegacitoSelectorWidget({
    super.key,
    required this.mood,
    this.isAnimating = false,
    this.size = 200,
    this.renderType = LegacitoRenderType.robot,
  });

  @override
  Widget build(BuildContext context) {
    switch (renderType) {
      case LegacitoRenderType.robot:
        return LegacitoRobotWidget(
          mood: mood,
          isAnimating: isAnimating,
          size: size,
        );
        
      case LegacitoRenderType.svg:
        return LegacitoSvgRobotWidget(
          mood: mood,
          isAnimating: isAnimating,
          size: size,
        );
        
      case LegacitoRenderType.auto:
        return _buildAutoSelector();
    }
  }

  Widget _buildAutoSelector() {
    // Lógica para seleccionar automáticamente el mejor renderizado
    // Por ahora, usar robot como predeterminado
    return LegacitoRobotWidget(
      mood: mood,
      isAnimating: isAnimating,
      size: size,
    );
  }
}

enum LegacitoRenderType {
  robot,    // Widget nativo de Flutter
  svg,      // SVG assets
  auto,     // Selección automática
}

// Widget de configuración para cambiar el tipo de renderizado
class LegacitoConfigWidget extends StatefulWidget {
  final Widget child;
  final Function(LegacitoRenderType) onRenderTypeChanged;

  const LegacitoConfigWidget({
    super.key,
    required this.child,
    required this.onRenderTypeChanged,
  });

  @override
  State<LegacitoConfigWidget> createState() => _LegacitoConfigWidgetState();
}

class _LegacitoConfigWidgetState extends State<LegacitoConfigWidget> {
  LegacitoRenderType _currentType = LegacitoRenderType.robot;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Selector de tipo de renderizado
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tipo de Renderizado de Legacito',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              AppGap.custom(8.h),
              Row(
                children: [
                  _buildRenderTypeButton(
                    'Robot Nativo',
                    LegacitoRenderType.robot,
                    Icons.android,
                  ),
                  AppGap.custom(8.w),
                  _buildRenderTypeButton(
                    'SVG Assets',
                    LegacitoRenderType.svg,
                    Icons.image,
                  ),
                  AppGap.custom(8.w),
                  _buildRenderTypeButton(
                    'Automático',
                    LegacitoRenderType.auto,
                    Icons.auto_awesome,
                  ),
                ],
              ),
            ],
          ),
        ),
        
        AppGap.custom(16.h),
        
        // Widget hijo
        widget.child,
      ],
    );
  }

  Widget _buildRenderTypeButton(String label, LegacitoRenderType type, IconData icon) {
    final isSelected = _currentType == type;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentType = type;
        });
        widget.onRenderTypeChanged(type);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey,
            width: 1.w,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: isSelected ? Colors.white : Colors.grey,
            ),
            AppGap.custom(4.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget de demostración para mostrar diferentes tipos de renderizado
class LegacitoDemoWidget extends StatelessWidget {
  const LegacitoDemoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Legacito Demo'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // Demo de robot nativo
            _buildDemoSection(
              'Robot Nativo (Flutter)',
              'Renderizado completamente en Flutter con widgets nativos',
              LegacitoSelectorWidget(
                mood: LegacitoMood.motivado,
                isAnimating: true,
                size: 150,
                renderType: LegacitoRenderType.robot,
              ),
            ),
            
            AppGap.custom(32.h),
            
            // Demo de SVG
            _buildDemoSection(
              'SVG Assets',
              'Renderizado usando archivos SVG optimizados',
              LegacitoSelectorWidget(
                mood: LegacitoMood.celebrando,
                isAnimating: true,
                size: 150,
                renderType: LegacitoRenderType.svg,
              ),
            ),
            
            AppGap.custom(32.h),
            
            // Comparación de estados
            _buildStatesComparison(),
          ],
        ),
      ),
    );
  }

  Widget _buildDemoSection(String title, String description, Widget demo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        AppGap.custom(4.h),
        Text(
          description,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
        AppGap.custom(16.h),
        Center(child: demo),
      ],
    );
  }

  Widget _buildStatesComparison() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Estados de Legacito',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        AppGap.custom(16.h),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.w,
          childAspectRatio: 0.8,
          children: LegacitoMood.values.map((mood) {
            return Column(
              children: [
                LegacitoSelectorWidget(
                  mood: mood,
                  size: 80,
                  renderType: LegacitoRenderType.robot,
                ),
                AppGap.custom(4.h),
                Text(
                  _getMoodName(mood),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  String _getMoodName(LegacitoMood mood) {
    switch (mood) {
      case LegacitoMood.motivado:
        return 'Motivado';
      case LegacitoMood.celebrando:
        return 'Celebrando';
      case LegacitoMood.neutral:
        return 'Neutral';
      case LegacitoMood.preocupado:
        return 'Preocupado';
      case LegacitoMood.resiliente:
        return 'Resiliente';
      case LegacitoMood.durmiendo:
        return 'Durmiendo';
      case LegacitoMood.pensativo:
        return 'Pensativo';
      case LegacitoMood.energico:
        return 'Energético';
    }
  }
}
