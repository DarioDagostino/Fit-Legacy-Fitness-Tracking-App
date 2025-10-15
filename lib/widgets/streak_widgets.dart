import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_spacing.dart';
import '../providers/streak_provider.dart';
import 'pixel_perfect_widgets.dart';

class StreakCard extends ConsumerWidget {
  final VoidCallback? onTap;

  const StreakCard({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStreak = ref.watch(currentStreakProvider);
    final longestStreak = ref.watch(longestStreakProvider);
    final weeklyStreak = ref.watch(weeklyStreakProvider);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSpacing.paddingCard),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Racha Estoica',
                  style: AppTextStyles.h6.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.paddingSm,
                    vertical: AppSpacing.paddingXs,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                  ),
                  child: Text(
                    '$currentStreak días',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            
            AppGap.custom(AppSpacing.md),
            
            // Racha actual
            _buildStreakDisplay(currentStreak),
            
            AppGap.custom(AppSpacing.md),
            
            // Estadísticas
            _buildStats(currentStreak, longestStreak),
            
            AppGap.custom(AppSpacing.md),
            
            // Racha semanal
            _buildWeeklyStreak(weeklyStreak),
          ],
        ),
      ),
    ).animate()
      .fadeIn(duration: 600.ms)
      .slideY(begin: 0.2, end: 0);
  }

  Widget _buildStreakDisplay(int currentStreak) {
    return Row(
      children: [
        // Icono de fuego
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.local_fire_department,
            color: Colors.white,
            size: AppSpacing.iconMedium,
          ),
        ),
        
        AppGap.custom(AppSpacing.marginCard),
        
        // Información de racha
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Racha Actual',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              AppGap.custom(AppSpacing.marginXs),
              Text(
                '$currentStreak días consecutivos',
                style: AppTextStyles.h5.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        
        // Indicador de progreso
        if (currentStreak > 0)
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary,
                width: 2.w,
              ),
            ),
            child: Center(
              child: Text(
                '${(currentStreak % 7) + 1}',
                style: AppTextStyles.h6.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildStats(int currentStreak, int longestStreak) {
    return Row(
      children: [
        Expanded(
          child: _buildStatItem(
            'Racha Actual',
            '$currentStreak',
            Icons.trending_up,
            AppColors.primary,
          ),
        ),
        AppGap.custom(AppSpacing.marginCard),
        Expanded(
          child: _buildStatItem(
            'Racha Más Larga',
            '$longestStreak',
            Icons.emoji_events,
            AppColors.golden,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.paddingCard),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: AppSpacing.iconMedium,
          ),
          AppGap.custom(AppSpacing.marginXs),
          Text(
            value,
            style: AppTextStyles.h6.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          AppGap.custom(AppSpacing.marginXs),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyStreak(List<StreakDay> weeklyStreak) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Esta Semana',
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        AppGap.custom(AppSpacing.marginSm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: weeklyStreak.map((day) {
            final dayName = _getDayName(day.date.weekday);
            final isActive = day.isActive;
            
            return Column(
              children: [
                Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: isActive 
                        ? AppColors.primary 
                        : AppColors.surfaceVariant,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isActive 
                          ? AppColors.primary 
                          : AppColors.border,
                      width: 1.w,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      day.date.day.toString(),
                      style: AppTextStyles.caption.copyWith(
                        color: isActive 
                            ? Colors.white 
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                AppGap.custom(AppSpacing.marginXs),
                Text(
                  dayName,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  String _getDayName(int weekday) {
    const days = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
    return days[weekday - 1];
  }
}

class StreakProgressWidget extends ConsumerWidget {
  const StreakProgressWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStreak = ref.watch(currentStreakProvider);
    final weeklyStreak = ref.watch(weeklyStreakProvider);
    
    // Calcular progreso de la semana
    final activeDays = weeklyStreak.where((day) => day.isActive).length;
    final weekProgress = activeDays / 7.0;
    
    return Container(
      padding: EdgeInsets.all(AppSpacing.paddingCard),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progreso Semanal',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$activeDays/7 días',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
          
          AppGap.custom(AppSpacing.marginSm),
          
          // Barra de progreso
          Container(
            height: 8.h,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: weekProgress,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                ),
              ),
            ),
          ),
          
          AppGap.custom(AppSpacing.marginSm),
          
          // Mensaje motivacional
          Text(
            _getMotivationalMessage(currentStreak, weekProgress),
            style: AppTextStyles.caption.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: 600.ms)
      .slideX(begin: 0.2, end: 0);
  }

  String _getMotivationalMessage(int currentStreak, double weekProgress) {
    if (weekProgress >= 1.0) {
      return '¡Semana perfecta! Eres un verdadero estoico.';
    } else if (weekProgress >= 0.7) {
      return 'Excelente progreso. La disciplina se construye día a día.';
    } else if (weekProgress >= 0.5) {
      return 'Buen comienzo. Cada día cuenta en tu transformación.';
    } else if (weekProgress >= 0.3) {
      return 'Sigue adelante. La consistencia es la clave del éxito.';
    } else {
      return 'Cada paso cuenta. La jornada de mil millas comienza con un paso.';
    }
  }
}

class StreakAchievementWidget extends ConsumerWidget {
  const StreakAchievementWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStreak = ref.watch(currentStreakProvider);
    final longestStreak = ref.watch(longestStreakProvider);
    
    return Container(
      padding: EdgeInsets.all(AppSpacing.paddingCard),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Logros de Racha',
            style: AppTextStyles.h6.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          
          AppGap.custom(AppSpacing.md),
          
          // Logros
          _buildAchievement(
            'Primera Semana',
            '7 días consecutivos',
            currentStreak >= 7,
            Icons.emoji_events,
            AppColors.golden,
          ),
          
          AppGap.custom(AppSpacing.marginCard),
          
          _buildAchievement(
            'Mes Estoico',
            '30 días consecutivos',
            currentStreak >= 30,
            Icons.psychology,
            AppColors.primary,
          ),
          
          AppGap.custom(AppSpacing.marginCard),
          
          _buildAchievement(
            'Maestro de la Disciplina',
            '100 días consecutivos',
            currentStreak >= 100,
            Icons.auto_awesome,
            AppColors.success,
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: 600.ms)
      .slideY(begin: 0.2, end: 0);
  }

  Widget _buildAchievement(
    String title,
    String description,
    bool isUnlocked,
    IconData icon,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: isUnlocked 
                ? color 
                : AppColors.surfaceVariant,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isUnlocked 
                ? Colors.white 
                : AppColors.textTertiary,
            size: AppSpacing.iconMedium,
          ),
        ),
        
        AppGap.custom(AppSpacing.marginCard),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isUnlocked 
                      ? AppColors.textPrimary 
                      : AppColors.textSecondary,
                ),
              ),
              Text(
                description,
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        
        if (isUnlocked)
          Icon(
            Icons.check_circle,
            color: AppColors.success,
            size: AppSpacing.iconSmall,
          ),
      ],
    );
  }
}
