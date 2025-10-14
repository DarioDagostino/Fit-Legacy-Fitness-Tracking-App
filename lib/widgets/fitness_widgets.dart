import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_spacing.dart';
import 'pixel_perfect_widgets.dart';

/// Pixel-perfect metric card for displaying fitness data
class MetricCard extends StatelessWidget {
  final String value;
  final String label;
  final String? unit;
  final IconData icon;
  final Color? color;
  final double? progress;
  final VoidCallback? onTap;

  const MetricCard({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
    this.unit,
    this.color,
    this.progress,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? AppColors.primary;
    
    return GestureDetector(
      onTap: onTap,
      child: AppContainer(
        padding: EdgeInsets.all(AppSpacing.metricCardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon and label
            AppRow(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  size: AppSpacing.iconMedium,
                  color: cardColor,
                ),
                if (progress != null)
                  Text(
                    '${(progress! * 100).toInt()}%',
                    style: AppTextStyles.caption.copyWith(
                      color: cardColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
            
            const AppGap.sm(),
            
            // Value with unit
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: AppTextStyles.metricValue.copyWith(color: cardColor),
                ),
                if (unit != null) ...[
                  const AppGap.horizontalXs(),
                  Text(
                    unit!,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: cardColor.withOpacity(0.7),
                    ),
                  ),
                ],
              ],
            ),
            
            const AppGap.sm(),
            
            // Label
            Text(
              label,
              style: AppTextStyles.metricLabel,
            ),
            
            // Progress bar if provided
            if (progress != null) ...[
              const AppGap.sm(),
              Container(
                height: AppSpacing.progressBarHeight,
                decoration: BoxDecoration(
                  color: cardColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress!.clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [cardColor, cardColor.withOpacity(0.8)],
                      ),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    ).animate()
      .fadeIn(duration: 300.ms, delay: 100.ms)
      .slideX(begin: 0.1, duration: 300.ms, delay: 100.ms);
  }
}

/// Pixel-perfect step counter widget
class StepCounter extends StatelessWidget {
  final int steps;
  final int goal;
  final double progress;

  const StepCounter({
    super.key,
    required this.steps,
    required this.goal,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: EdgeInsets.all(AppSpacing.stepCounterMargin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circular progress indicator
          SizedBox(
            width: 200.w,
            height: 200.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background circle
                SizedBox(
                  width: 200.w,
                  height: 200.w,
                  child: CircularProgressIndicator(
                    value: 1.0,
                    strokeWidth: 12.w,
                    backgroundColor: AppColors.border,
                    valueColor: AlwaysStoppedAnimation(
                      AppColors.border.withOpacity(0.3),
                    ),
                  ),
                ),
                // Progress circle
                SizedBox(
                  width: 200.w,
                  height: 200.w,
                  child: CircularProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    strokeWidth: 12.w,
                    backgroundColor: Colors.transparent,
                    valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                  ),
                ),
                // Steps count
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      steps.toString(),
                      style: AppTextStyles.stepCounter,
                    ),
                    const AppGap.xs(),
                    Text(
                      'STEPS',
                      style: AppTextStyles.metricLabel.copyWith(
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          AppGap.custom(AppSpacing.md),
          
          // Goal indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.flag_outlined,
                size: AppSpacing.iconSmall,
                color: AppColors.textSecondary,
              ),
              const AppGap.horizontalXs(),
              Text(
                'Goal: ${goal.toString()}',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: 500.ms)
      .scale(begin: const Offset(0.8, 0.8), duration: 500.ms);
  }
}

/// Pixel-perfect achievement badge
class AchievementBadge extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isUnlocked;
  final double progress;

  const AchievementBadge({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    this.isUnlocked = false,
    this.progress = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: EdgeInsets.all(AppSpacing.achievementCardSpacing),
      color: isUnlocked ? AppColors.success.withOpacity(0.1) : null,
      child: Row(
        children: [
          // Icon with background
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: isUnlocked ? AppColors.success : AppColors.textTertiary,
              borderRadius: BorderRadius.circular(AppSpacing.radiusCircular),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: AppSpacing.iconMedium,
            ),
          ),
          
          const AppGap.horizontalMd(),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.h6.copyWith(
                    color: isUnlocked ? AppColors.success : AppColors.textSecondary,
                  ),
                ),
                const AppGap.xs(),
                Text(
                  description,
                  style: AppTextStyles.bodySmall,
                ),
                if (!isUnlocked && progress > 0) ...[
                  const AppGap.xs(),
                  LinearProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    backgroundColor: AppColors.border,
                    valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    ).animate(delay: 200.ms)
      .fadeIn(duration: 300.ms)
      .slideX(begin: -0.1, duration: 300.ms);
  }
}