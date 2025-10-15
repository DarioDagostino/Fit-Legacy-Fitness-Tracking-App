import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_spacing.dart';
import '../widgets/pixel_perfect_widgets.dart';
import '../widgets/streak_widgets.dart';
import '../providers/streak_provider.dart';

class StreakScreen extends ConsumerWidget {
  const StreakScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStreak = ref.watch(currentStreakProvider);
    final longestStreak = ref.watch(longestStreakProvider);
    final weeklyStreak = ref.watch(weeklyStreakProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.paddingScreen),
        child: Column(
          children: [
            // Header con racha actual
            _buildStreakHeader(currentStreak),
            
            AppGap.custom(AppSpacing.marginSection),
            
            // Progreso semanal
            const StreakProgressWidget(),
            
            AppGap.custom(AppSpacing.marginSection),
            
            // Racha semanal
            _buildWeeklyStreakSection(weeklyStreak),
            
            AppGap.custom(AppSpacing.marginSection),
            
            // Estadísticas
            _buildStatsSection(currentStreak, longestStreak),
            
            AppGap.custom(AppSpacing.marginSection),
            
            // Logros
            const StreakAchievementWidget(),
            
            AppGap.custom(AppSpacing.marginSection),
            
            // Motivación
            _buildMotivationSection(currentStreak),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        'Racha Estoica',
        style: AppTextStyles.h5.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: AppColors.background,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {
            // Mostrar información sobre rachas
            _showStreakInfo();
          },
          icon: Icon(
            Icons.info_outline,
            size: AppSpacing.iconMedium,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildStreakHeader(int currentStreak) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.paddingCard * 2),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Column(
        children: [
          // Icono de fuego
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.local_fire_department,
              color: Colors.white,
              size: 40.sp,
            ),
          ),
          
          AppGap.custom(AppSpacing.marginCard),
          
          // Número de racha
          Text(
            '$currentStreak',
            style: AppTextStyles.h1.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
          
          AppGap.custom(AppSpacing.marginXs),
          
          // Título
          Text(
            'Días Consecutivos',
            style: AppTextStyles.h5.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          AppGap.custom(AppSpacing.marginSm),
          
          // Mensaje motivacional
          Text(
            _getStreakMessage(currentStreak),
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: 800.ms)
      .scaleXY(begin: 0.8, end: 1.0)
      .then()
      .shimmer(duration: 2000.ms);
  }

  Widget _buildWeeklyStreakSection(List<StreakDay> weeklyStreak) {
    return AppContainer(
      padding: EdgeInsets.all(AppSpacing.paddingCard),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Racha de la Semana',
            style: AppTextStyles.h6.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          
          AppGap.custom(AppSpacing.md),
          
          // Días de la semana
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: weeklyStreak.map((day) {
              final dayName = _getDayName(day.date.weekday);
              final isActive = day.isActive;
              final isToday = _isToday(day.date);
              
              return Column(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: isActive 
                          ? AppColors.primary 
                          : isToday
                              ? AppColors.surfaceVariant
                              : AppColors.surface,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isActive 
                            ? AppColors.primary 
                            : isToday
                                ? AppColors.primary
                                : AppColors.border,
                        width: isToday ? 2.w : 1.w,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        day.date.day.toString(),
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: isActive 
                              ? Colors.white 
                              : isToday
                                  ? AppColors.primary
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
                      fontWeight: isToday ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  
                  if (isActive)
                    Container(
                      width: 6.w,
                      height: 6.w,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    ).animate()
      .fadeIn(delay: 200.ms, duration: 600.ms)
      .slideY(begin: 0.2, end: 0);
  }

  Widget _buildStatsSection(int currentStreak, int longestStreak) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Racha Actual',
            '$currentStreak días',
            Icons.trending_up,
            AppColors.primary,
          ),
        ),
        
        AppGap.custom(AppSpacing.marginCard),
        
        Expanded(
          child: _buildStatCard(
            'Racha Más Larga',
            '$longestStreak días',
            Icons.emoji_events,
            AppColors.golden,
          ),
        ),
      ],
    ).animate()
      .fadeIn(delay: 400.ms, duration: 600.ms)
      .slideX(begin: 0.2, end: 0);
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return AppContainer(
      padding: EdgeInsets.all(AppSpacing.paddingCard),
      child: Column(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: AppSpacing.iconMedium,
            ),
          ),
          
          AppGap.custom(AppSpacing.marginSm),
          
          Text(
            value,
            style: AppTextStyles.h5.copyWith(
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          
          AppGap.custom(AppSpacing.marginXs),
          
          Text(
            title,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMotivationSection(int currentStreak) {
    return AppContainer(
      padding: EdgeInsets.all(AppSpacing.paddingCard),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sabiduría Estoica',
            style: AppTextStyles.h6.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          
          AppGap.custom(AppSpacing.md),
          
          Container(
            padding: EdgeInsets.all(AppSpacing.paddingCard),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.format_quote,
                  color: AppColors.primary,
                  size: AppSpacing.iconLarge,
                ),
                
                AppGap.custom(AppSpacing.marginSm),
                
                Text(
                  _getStoicQuote(currentStreak),
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontStyle: FontStyle.italic,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                AppGap.custom(AppSpacing.marginSm),
                
                Text(
                  _getStoicAuthor(currentStreak),
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate()
      .fadeIn(delay: 600.ms, duration: 600.ms)
      .slideY(begin: 0.2, end: 0);
  }

  String _getStreakMessage(int currentStreak) {
    if (currentStreak == 0) {
      return 'Cada jornada comienza con un solo paso';
    } else if (currentStreak < 7) {
      return '¡Buen comienzo! La disciplina se construye día a día';
    } else if (currentStreak < 30) {
      return '¡Excelente! Estás construyendo un hábito sólido';
    } else if (currentStreak < 100) {
      return '¡Increíble! Eres un verdadero estoico';
    } else {
      return '¡Legendario! Eres un maestro de la disciplina';
    }
  }

  String _getDayName(int weekday) {
    const days = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
    return days[weekday - 1];
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
           date.month == now.month &&
           date.day == now.day;
  }

  String _getStoicQuote(int currentStreak) {
    if (currentStreak < 7) {
      return 'La dificultad muestra al hombre.';
    } else if (currentStreak < 30) {
      return 'El obstáculo se convierte en el camino.';
    } else if (currentStreak < 100) {
      return 'La disciplina es la madre de la libertad.';
    } else {
      return 'La excelencia es un hábito, no un acto.';
    }
  }

  String _getStoicAuthor(int currentStreak) {
    if (currentStreak < 7) {
      return '- Epicteto';
    } else if (currentStreak < 30) {
      return '- Marco Aurelio';
    } else if (currentStreak < 100) {
      return '- Séneca';
    } else {
      return '- Aristóteles';
    }
  }

  void _showStreakInfo() {
    // Implementar diálogo de información
  }
}
