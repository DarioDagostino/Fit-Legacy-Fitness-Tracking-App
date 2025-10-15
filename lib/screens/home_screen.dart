import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_spacing.dart';
import '../widgets/pixel_perfect_widgets.dart';
import '../widgets/fitness_widgets.dart';
import '../widgets/legacito_widget.dart';
import '../widgets/streak_widgets.dart';
import '../providers/legacito_provider.dart';
import '../providers/pedometer_provider.dart';
import '../providers/streak_provider.dart';
import 'trivia_menu_screen.dart';
import 'step_tracking_screen.dart';
import 'chat_legacito_screen.dart';
import 'streak_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final double caloriesBurned = 342.5;
  final double distanceKm = 6.2;
  final int activeMinutes = 45;

  @override
  Widget build(BuildContext context) {
    final todaySteps = ref.watch(todayStepsProvider);
    final legacitoState = ref.watch(legacitoProvider);
    final stepProgress = todaySteps / legacitoState.dailyGoal;
    
    // Actualizar pasos en Legacito
    ref.read(legacitoProvider.notifier).updateSteps(todaySteps);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.paddingScreen),
        child: Column(
          children: [
            // Welcome section
            _buildWelcomeSection(),
            
            AppGap.custom(AppSpacing.marginSection),
            
            // Legacito section
            _buildLegacitoSection(),
            
            AppGap.custom(AppSpacing.marginSection),
            
            // Step counter
            _buildStepCounterSection(stepProgress, todaySteps),
            
            AppGap.custom(AppSpacing.marginSection),
            
            // Metrics grid
            _buildMetricsGrid(),
            
            AppGap.custom(AppSpacing.marginSection),
            
            // Streak section
            _buildStreakSection(),
            
            AppGap.custom(AppSpacing.marginSection),
            
            // Today's achievements
            _buildAchievementsSection(),
            
            AppGap.custom(AppSpacing.marginSection),
            
            // Trivia section
            _buildTriviaSection(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        'Fit Legacy',
        style: AppTextStyles.h5.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_outlined,
            size: AppSpacing.iconMedium,
          ),
        ),
        const AppGap.horizontalSm(),
      ],
    );
  }

  Widget _buildWelcomeSection() {
    return AppContainer(
      padding: EdgeInsets.all(AppSpacing.paddingCard),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good Morning!',
                  style: AppTextStyles.h4.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const AppGap.xs(),
                Text(
                  'Ready to crush your fitness goals?',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(AppSpacing.radiusCircular),
            ),
            child: Icon(
              Icons.fitness_center,
              color: Colors.white,
              size: AppSpacing.iconLarge,
            ),
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: 600.ms)
      .slideY(begin: -0.1, duration: 600.ms);
  }

  Widget _buildLegacitoSection() {
    return AppContainer(
      padding: EdgeInsets.all(AppSpacing.paddingCard),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tu Compañero de Entrenamiento',
                style: AppTextStyles.h5.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatLegacitoScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(AppSpacing.paddingSm),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusCircular),
                  ),
                  child: Icon(
                    Icons.chat_bubble_outline,
                    size: AppSpacing.iconMedium,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          AppGap.custom(AppSpacing.md),
          const LegacitoCenterWidget(),
        ],
      ),
    ).animate()
      .fadeIn(delay: 400.ms, duration: 600.ms)
      .slideY(begin: 0.2, end: 0);
  }

  Widget _buildStepCounterSection(double progress, int currentSteps) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const StepTrackingScreen(),
          ),
        );
      },
      child: StepCounter(
        steps: currentSteps,
        goal: ref.read(legacitoProvider).dailyGoal,
        progress: progress,
      ),
    );
  }

  Widget _buildMetricsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: AppSpacing.marginCard,
      crossAxisSpacing: AppSpacing.marginCard,
      childAspectRatio: 1.1,
      children: [
        MetricCard(
          value: caloriesBurned.toStringAsFixed(0),
          unit: 'cal',
          label: 'Calories Burned',
          icon: Icons.local_fire_department,
          color: AppColors.error,
          progress: caloriesBurned / 500, // Assuming 500 cal goal
        ),
        MetricCard(
          value: distanceKm.toStringAsFixed(1),
          unit: 'km',
          label: 'Distance',
          icon: Icons.directions_walk,
          color: AppColors.info,
          progress: distanceKm / 10, // Assuming 10km goal
        ),
        MetricCard(
          value: activeMinutes.toString(),
          unit: 'min',
          label: 'Active Minutes',
          icon: Icons.timer,
          color: AppColors.success,
          progress: activeMinutes / 60, // Assuming 60 min goal
        ),
        MetricCard(
          value: '7.5',
          unit: 'hrs',
          label: 'Sleep',
          icon: Icons.bedtime,
          color: AppColors.primary,
          progress: 7.5 / 8, // Assuming 8 hrs goal
        ),
      ],
    );
  }

  Widget _buildStreakSection() {
    return StreakCard(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const StreakScreen(),
          ),
        );
      },
    );
  }

  Widget _buildAchievementsSection() {
    final todaySteps = ref.watch(todayStepsProvider);
    final legacitoState = ref.watch(legacitoProvider);
    final stepProgress = todaySteps / legacitoState.dailyGoal;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Logros de Hoy',
          style: AppTextStyles.h5.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        AppGap.custom(AppSpacing.md),
        Column(
          children: [
            AchievementBadge(
              title: 'Early Bird',
              description: 'Comenzaste tu entrenamiento antes de las 8 AM',
              icon: Icons.wb_sunny,
              isUnlocked: true,
            ),
            AppGap.custom(AppSpacing.marginCard),
            AchievementBadge(
              title: 'Maestro de Pasos',
              description: 'Alcanza ${legacitoState.dailyGoal} pasos',
              icon: Icons.directions_walk,
              progress: stepProgress,
            ),
            AppGap.custom(AppSpacing.marginCard),
            AchievementBadge(
              title: 'Destructor de Calorías',
              description: 'Quema 500 calorías',
              icon: Icons.local_fire_department,
              progress: caloriesBurned / 500,
            ),
            AppGap.custom(AppSpacing.marginCard),
            AchievementBadge(
              title: 'Racha Estoica',
              description: '${legacitoState.streakDays} días consecutivos',
              icon: Icons.local_fire_department,
              progress: legacitoState.streakDays / 30, // Meta de 30 días
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: AppSpacing.bottomNavHeight,
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 20.r,
            offset: Offset(0, -4.h),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textTertiary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department),
            label: 'Racha',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Progreso',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        // Start workout action
      },
      child: const Icon(Icons.play_arrow),
    ).animate()
      .scale(
        delay: 1000.ms,
        duration: 300.ms,
        begin: const Offset(0, 0),
        end: const Offset(1, 1),
      )
      .then()
      .shake(hz: 2, curve: Curves.easeInOut);
  }

  Widget _buildTriviaSection() {
    return AppCard(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const TriviaMenuScreen(),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.paddingCard),
        child: Row(
          children: [
            Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
              ),
              child: Icon(
                Icons.quiz,
                size: AppSpacing.iconLarge,
                color: AppColors.secondary,
              ),
            ),
            AppGap.custom(AppSpacing.marginCard),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trivia del Conocimiento',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  AppGap.custom(AppSpacing.marginXs),
                  Text(
                    'Pon a prueba tus conocimientos sobre fitness, nutrición y deportes',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            
            Icon(
              Icons.arrow_forward_ios,
              size: AppSpacing.iconSmall,
              color: AppColors.onSurfaceVariant,
            ),
          ],
        ),
      ),
    ).animate()
      .fadeIn(delay: 1200.ms, duration: 600.ms)
      .slideX(begin: 0.2, end: 0);
  }
}