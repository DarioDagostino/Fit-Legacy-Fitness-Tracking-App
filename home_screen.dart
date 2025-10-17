import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/fit_legacy/lib/core/constants/app_colors.dart';
import 'package:myapp/fit_legacy/lib/core/constants/app_text_styles.dart';
import 'package:myapp/fit_legacy/lib/core/constants/app_spacing.dart';
import 'package:myapp/fit_legacy/lib/widgets/pixel_perfect_widgets.dart';
import 'package:myapp/fit_legacy/lib/widgets/fitness_widgets.dart';
import 'package:myapp/fit_legacy/lib/widgets/legacito_widget.dart';
import 'package:myapp/fit_legacy/lib/widgets/streak_widgets.dart';
import 'package:myapp/fit_legacy/lib/providers/legacito_provider.dart';
import 'package:myapp/fit_legacy/lib/providers/pedometer_provider.dart';
import 'package:myapp/fit_legacy/lib/screens/trivia_menu_screen.dart';
import 'package:myapp/fit_legacy/lib/screens/step_tracking_screen.dart';
import 'package:myapp/fit_legacy/lib/screens/chat_legacito_screen.dart';
import 'package:myapp/fit_legacy/lib/screens/streak_screen.dart';

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        'Mi Legado',
        style: AppTextStyles.h5.copyWith(fontWeight: FontWeight.w700),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications_outlined, size: AppSpacing.iconMedium),
        ),
        const AppGap.horizontalSm(),
      ],
    );
  }

  Widget _buildWelcomeSection() {
    // This would be replaced with actual user data
    const userName = "Usuario";
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
                  '¡Hola, $userName!',
                  style: AppTextStyles.h4.copyWith(fontWeight: FontWeight.w700),
                ),
                const AppGap.xs(),
                Text(
                  'Listo para forjar tu legado?',
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
    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.1, duration: 600.ms);
  }

  Widget _buildLegacitoSection() {
    final legacitoState = ref.watch(legacitoProvider);
    return AppContainer(
          padding: EdgeInsets.all(AppSpacing.paddingCard),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tu Compañero Estoico',
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
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusCircular,
                        ),
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
              LegacitoWidget(
                mood: legacitoState.mood,
                isAnimating: legacitoState.isAnimating,
              ),
              AppGap.custom(AppSpacing.md),
              Text(
                '"${legacitoState.message}"',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontStyle: FontStyle.italic,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 400.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0);
  }

  // Other build methods like _buildStepCounterSection, _buildMetricsGrid, etc.
  // would be here, similar to the provided `fit_legacy/lib/screens/home_screen.dart`
}
