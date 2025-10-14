import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_spacing.dart';
import '../widgets/pixel_perfect_widgets.dart';
import '../widgets/fitness_widgets.dart';
import 'trivia_menu_screen.dart';
import 'step_tracking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int currentSteps = 8247;
  final int stepGoal = 10000;
  final double caloriesBurned = 342.5;
  final double distanceKm = 6.2;
  final int activeMinutes = 45;

  @override
  Widget build(BuildContext context) {
    final stepProgress = currentSteps / stepGoal;
    
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
            
            // Step counter
            _buildStepCounterSection(stepProgress),
            
            AppGap.custom(AppSpacing.marginSection),
            
            // Metrics grid
            _buildMetricsGrid(),
            
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

  Widget _buildStepCounterSection(double progress) {
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
        goal: stepGoal,
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

  Widget _buildAchievementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Achievements',
          style: AppTextStyles.h5.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        AppGap.custom(AppSpacing.md),
        Column(
          children: [
            AchievementBadge(
              title: 'Early Bird',
              description: 'Started your workout before 8 AM',
              icon: Icons.wb_sunny,
              isUnlocked: true,
            ),
            AppGap.custom(AppSpacing.marginCard),
            AchievementBadge(
              title: 'Step Master',
              description: 'Reach 10,000 steps',
              icon: Icons.directions_walk,
              progress: currentSteps / stepGoal,
            ),
            AppGap.custom(AppSpacing.marginCard),
            AchievementBadge(
              title: 'Calorie Crusher',
              description: 'Burn 500 calories',
              icon: Icons.local_fire_department,
              progress: caloriesBurned / 500,
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
            icon: Icon(Icons.fitness_center),
            label: 'Workouts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
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