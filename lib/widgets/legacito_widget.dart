import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_spacing.dart';
import '../models/legacito_state.dart';
import '../providers/legacito_provider.dart';
import 'legacito_robot_widget.dart';
import 'legacito_selector_widget.dart';

class LegacitoWidget extends ConsumerWidget {
  final bool showMessage;
  final bool isCompact;
  final VoidCallback? onTap;

  const LegacitoWidget({
    super.key,
    this.showMessage = true,
    this.isCompact = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final legacitoState = ref.watch(legacitoProvider);
    final message = ref.watch(legacitoMessageProvider);
    final mood = legacitoState.mood;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Imagen de Legacito con animaciones
          _buildLegacitoImage(mood, legacitoState.isAnimating),
          
          if (showMessage && !isCompact) ...[
            AppGap.custom(AppSpacing.md),
            _buildMessageBubble(message, mood),
          ],
        ],
      ),
    );
  }

  Widget _buildLegacitoImage(LegacitoMood mood, bool isAnimating) {
    return Container(
      width: isCompact ? 120.w : 200.w,
      height: isCompact ? 150.h : 250.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 20.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        child: LegacitoSelectorWidget(
          mood: mood,
          isAnimating: isAnimating,
          size: isCompact ? 120 : 200,
          renderType: LegacitoRenderType.robot, // Usar robot por defecto
        ),
      ),
    )
    .animate(target: isAnimating ? 1 : 0)
    .scaleXY(
      begin: 1.0,
      end: 1.1,
      duration: 300.ms,
      curve: Curves.elasticOut,
    )
    .then()
    .scaleXY(
      begin: 1.1,
      end: 1.0,
      duration: 200.ms,
    )
    .animate()
    .fadeIn(duration: 500.ms)
    .slideY(begin: 0.2, end: 0);
  }

  Widget _buildMessageBubble(String message, LegacitoMood mood) {
    return Container(
      constraints: BoxConstraints(maxWidth: 280.w),
      padding: EdgeInsets.all(AppSpacing.paddingCard),
      decoration: BoxDecoration(
        color: _getMoodBubbleColor(mood),
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 10.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Indicador de estado
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: _getMoodIndicatorColor(mood),
              shape: BoxShape.circle,
            ),
          ),
          AppGap.custom(AppSpacing.sm),
          
          // Mensaje
          Text(
            message,
            style: AppTextStyles.bodyMedium.copyWith(
              color: _getMoodTextColor(mood),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    )
    .animate()
    .fadeIn(delay: 200.ms, duration: 400.ms)
    .slideX(begin: 0.3, end: 0);
  }

  // Gradientes por estado de ánimo
  LinearGradient _getMoodGradient(LegacitoMood mood) {
    switch (mood) {
      case LegacitoMood.celebrando:
        return const LinearGradient(
          colors: [AppColors.success, AppColors.golden],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case LegacitoMood.motivado:
        return const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case LegacitoMood.preocupado:
        return const LinearGradient(
          colors: [AppColors.warning, AppColors.error],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case LegacitoMood.resiliente:
        return const LinearGradient(
          colors: [AppColors.info, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      default:
        return const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  // Iconos de fallback por estado
  IconData _getMoodIcon(LegacitoMood mood) {
    switch (mood) {
      case LegacitoMood.celebrando:
        return Icons.celebration;
      case LegacitoMood.motivado:
        return Icons.fitness_center;
      case LegacitoMood.preocupado:
        return Icons.sentiment_dissatisfied;
      case LegacitoMood.resiliente:
        return Icons.psychology;
      case LegacitoMood.durmiendo:
        return Icons.bedtime;
      case LegacitoMood.pensativo:
        return Icons.psychology_alt;
      case LegacitoMood.energico:
        return Icons.bolt;
      default:
        return Icons.sentiment_neutral;
    }
  }

  // Colores de burbuja por estado
  Color _getMoodBubbleColor(LegacitoMood mood) {
    switch (mood) {
      case LegacitoMood.celebrando:
        return AppColors.success.withValues(alpha: 0.1);
      case LegacitoMood.motivado:
        return AppColors.primary.withValues(alpha: 0.1);
      case LegacitoMood.preocupado:
        return AppColors.warning.withValues(alpha: 0.1);
      case LegacitoMood.resiliente:
        return AppColors.info.withValues(alpha: 0.1);
      default:
        return AppColors.surfaceVariant;
    }
  }

  // Colores de indicador por estado
  Color _getMoodIndicatorColor(LegacitoMood mood) {
    switch (mood) {
      case LegacitoMood.celebrando:
        return AppColors.success;
      case LegacitoMood.motivado:
        return AppColors.primary;
      case LegacitoMood.preocupado:
        return AppColors.warning;
      case LegacitoMood.resiliente:
        return AppColors.info;
      default:
        return AppColors.primary;
    }
  }

  // Colores de texto por estado
  Color _getMoodTextColor(LegacitoMood mood) {
    switch (mood) {
      case LegacitoMood.celebrando:
        return AppColors.success;
      case LegacitoMood.motivado:
        return AppColors.primary;
      case LegacitoMood.preocupado:
        return AppColors.warning;
      case LegacitoMood.resiliente:
        return AppColors.info;
      default:
        return AppColors.textPrimary;
    }
  }
}

// Widget compacto para usar en otras pantallas
class LegacitoCompactWidget extends ConsumerWidget {
  final VoidCallback? onTap;

  const LegacitoCompactWidget({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LegacitoWidget(
      isCompact: true,
      showMessage: false,
      onTap: onTap,
    );
  }
}

// Widget para mostrar en el centro de la pantalla
class LegacitoCenterWidget extends ConsumerWidget {
  final VoidCallback? onTap;

  const LegacitoCenterWidget({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: LegacitoWidget(
        showMessage: true,
        isCompact: false,
        onTap: onTap,
      ),
    );
  }
}
