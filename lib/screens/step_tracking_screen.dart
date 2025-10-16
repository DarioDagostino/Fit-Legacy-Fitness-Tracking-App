import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_spacing.dart';
import '../widgets/pixel_perfect_widgets.dart';
import '../providers/pasos_notifier.dart';

final pasosProvider = StateNotifierProvider<PasosNotifier, PasosState>(
  (ref) => PasosNotifier(),
);

/// Step Tracking Screen - Pixel-perfect recreation of Figma design
class StepTrackingScreen extends ConsumerWidget {
  const StepTrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pasosState = ref.watch(pasosProvider);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              _buildHeader(),
              
              // Main content
              Padding(
                padding: EdgeInsets.all(AppSpacing.paddingScreen),
                child: Column(
                  children: [
                    // Circular Progress Indicator
                    _buildCircularProgress(pasosState),
                    
                    AppGap.custom(32.h),
                    
                    // Motivational Quote
                    _buildMotivationalQuote(),
                    
                    AppGap.custom(32.h),
                    
                    // Achievement Cards
                    _buildAchievementCards(pasosState),
                    
                    AppGap.custom(32.h),
                    
                    // Weekly Progress Section
                    _buildWeeklyProgressSection(pasosState),
                    
                    AppGap.custom(32.h),
                    
                    // Share Progress Button
                    _buildShareButton(),
                    
                    AppGap.custom(32.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(AppSpacing.paddingScreen),
      child: Row(
        children: [
          // User Avatar and Name
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.h,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
              AppGap.custom(12.w),
              Text(
                'Usuario',
                style: AppTextStyles.h6.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          
          const Spacer(),
          
          // Streak Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.golden.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.local_fire_department,
                  color: AppColors.golden,
                  size: 16.sp,
                ),
                AppGap.custom(4.w),
                Text(
                  '3 DÍAS',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularProgress(PasosState state) {
    final progress = state.actuales / state.meta;
    
    return SizedBox(
      width: 256.w,
      height: 256.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle
          SizedBox(
            width: 256.w,
            height: 256.h,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: 12.w,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.transparent),
            ),
          ),
          
          // Progress circle
          SizedBox(
            width: 256.w,
            height: 256.h,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 12.w,
              backgroundColor: Colors.transparent,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.golden),
              strokeCap: StrokeCap.round,
            ),
          ),
          
          // Center content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.actuales.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},'),
                style: AppTextStyles.displaySmall.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              AppGap.custom(4.h),
              Text(
                'PASOS',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.35,
                ),
              ),
              AppGap.custom(4.h),
              Text(
                'DE ${state.meta.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().scale(delay: 300.ms, duration: 600.ms);
  }

  Widget _buildMotivationalQuote() {
    return Text(
      '"La disciplina vence al cansancio"',
      textAlign: TextAlign.center,
      style: AppTextStyles.h6.copyWith(
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
    ).animate().fadeIn(delay: 600.ms, duration: 800.ms);
  }

  Widget _buildAchievementCards(PasosState state) {
    return Column(
      children: [
        // Daily Streak
        _buildAchievementCard(
          icon: Icons.check_circle,
          iconColor: AppColors.success,
          iconBackground: AppColors.success.withOpacity(0.1),
          title: 'Racha Diaria',
          subtitle: '${state.rachaDiaria} días consecutivos',
          isHighlighted: false,
        ),
        
        AppGap.custom(16.h),
        
        // Weekly Streak
        _buildAchievementCard(
          icon: Icons.trending_up,
          iconColor: AppColors.warning,
          iconBackground: AppColors.warning.withOpacity(0.1),
          title: 'Racha Semanal',
          subtitle: 'En progreso',
          isHighlighted: false,
        ),
        
        AppGap.custom(16.h),
        
        // Monthly Achievement (Highlighted)
        _buildAchievementCard(
          icon: Icons.emoji_events,
          iconColor: AppColors.golden,
          iconBackground: AppColors.golden.withOpacity(0.2),
          title: 'Logro Mensual',
          subtitle: '¡Meta alcanzada!',
          isHighlighted: state.logroMensualCompleto,
        ),
      ],
    );
  }

  Widget _buildAchievementCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required String title,
    required String subtitle,
    required bool isHighlighted,
  }) {
    return AppContainer(
      color: isHighlighted 
          ? AppColors.golden.withOpacity(0.1) 
          : AppColors.surface,
      border: isHighlighted 
          ? Border.all(color: AppColors.golden.withOpacity(0.2)) 
          : null,
      padding: EdgeInsets.all(21.w),
      child: Row(
        children: [
          // Icon container
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20.sp,
            ),
          ),
          
          AppGap.custom(16.w),
          
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.h6.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                AppGap.custom(4.h),
                Text(
                  subtitle,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isHighlighted 
                        ? AppColors.textSecondary 
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().slideX(delay: (800 + (isHighlighted ? 200 : 0)).ms, duration: 600.ms);
  }

  Widget _buildWeeklyProgressSection(PasosState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progreso Semanal',
          style: AppTextStyles.h6.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        
        AppGap.custom(16.h),
        
        AppContainer(
          padding: EdgeInsets.all(25.w),
          child: SizedBox(
            height: 128.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: state.progresoSemanal.asMap().entries.map((entry) {
                final index = entry.key;
                final dayProgress = entry.value;
                final isToday = index == state.progresoSemanal.length - 1;
                
                return _buildWeeklyBar(
                  day: dayProgress.day,
                  isCompleted: dayProgress.goalCompleted,
                  isToday: isToday,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyBar({
    required String day,
    required bool isCompleted,
    required bool isToday,
  }) {
    final Color barColor = isToday 
        ? AppColors.golden 
        : (isCompleted ? AppColors.success : AppColors.success);
        
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 32.w,
          height: 1.h,
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(6.r)),
          ),
        ),
        
        AppGap.custom(8.h),
        
        Text(
          day,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    ).animate().slideY(delay: (1200 + (day.hashCode % 7) * 100).ms, duration: 600.ms);
  }

  Widget _buildShareButton() {
    return Container(
      width: double.infinity,
      height: 60.h,
      decoration: BoxDecoration(
        gradient: AppColors.goldenGradient,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.golden.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Handle share action
          },
          borderRadius: BorderRadius.circular(16.r),
          child: Center(
            child: Text(
              'Compartir progreso',
              style: AppTextStyles.h6.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ).animate().slideY(delay: 1500.ms, duration: 600.ms);
  }
}