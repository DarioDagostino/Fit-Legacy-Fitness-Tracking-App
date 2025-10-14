import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_spacing.dart';
import '../widgets/app_button.dart';
import '../widgets/pixel_perfect_widgets.dart';
import '../models/trivia_question.dart';
import '../providers/trivia_notifier.dart';
import 'trivia_quiz_screen.dart';

class TriviaMenuScreen extends ConsumerWidget {
  const TriviaMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final triviaState = ref.watch(triviaProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Trivia del Conocimiento',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Estadísticas del usuario
              _buildStatsCard(triviaState.stats),
              
              Gap(AppSpacing.lg),
              
              // Título de categorías
              Text(
                'Elige una categoría',
                style: AppTextStyles.headlineSmall.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              Gap(AppSpacing.md),
              
              // Botones de categorías
              _buildCategoryButtons(context, ref),
              
              Gap(AppSpacing.lg),
              
              // Quiz mixto
              _buildMixedQuizSection(context, ref),
              
              Gap(AppSpacing.lg),
              
              // Información sobre el sistema de puntuación
              _buildScoringInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCard(TriviaStats? stats) {
    if (stats == null) return const SizedBox.shrink();

    return AppCard(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tus Estadísticas',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(AppSpacing.sm),
          
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'Preguntas\nRespondidas',
                  stats.totalQuestionsAnswered.toString(),
                  AppColors.primary,
                ),
              ),
              Gap(AppSpacing.sm),
              Expanded(
                child: _buildStatItem(
                  'Respuestas\nCorrectas',
                  stats.correctAnswers.toString(),
                  AppColors.success,
                ),
              ),
              Gap(AppSpacing.sm),
              Expanded(
                child: _buildStatItem(
                  'Puntuación\nTotal',
                  stats.totalScore.toString(),
                  AppColors.warning,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1.w,
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppTextStyles.headlineMedium.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(AppSpacing.xs),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButtons(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        _buildCategoryButton(
          context,
          ref,
          'Fitness',
          'Ejercicios, entrenamiento, anatomía',
          Icons.fitness_center,
          AppColors.primary,
          QuestionCategory.fitness,
        ),
        Gap(AppSpacing.sm),
        
        _buildCategoryButton(
          context,
          ref,
          'Nutrición',
          'Dietas, macronutrientes, suplementos',
          Icons.restaurant,
          AppColors.success,
          QuestionCategory.nutrition,
        ),
        Gap(AppSpacing.sm),
        
        _buildCategoryButton(
          context,
          ref,
          'Salud y Bienestar',
          'Sueño, estrés, recuperación',
          Icons.favorite,
          AppColors.error,
          QuestionCategory.healthWellness,
        ),
        Gap(AppSpacing.sm),
        
        _buildCategoryButton(
          context,
          ref,
          'Historia del Deporte',
          'Deportistas famosos, récords, olimpiadas',
          Icons.emoji_events,
          AppColors.warning,
          QuestionCategory.sportsHistory,
        ),
      ],
    );
  }

  Widget _buildCategoryButton(
    BuildContext context,
    WidgetRef ref,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    QuestionCategory category,
  ) {
    return AppCard(
      onTap: () => _startCategoryQuiz(context, ref, category),
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24.w,
              ),
            ),
            Gap(AppSpacing.md),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gap(AppSpacing.xs),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.onSurfaceVariant,
              size: 16.w,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMixedQuizSection(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quiz Mixto',
          style: AppTextStyles.headlineSmall.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        Gap(AppSpacing.sm),
        
        Text(
          'Preguntas aleatorias de todas las categorías',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
        Gap(AppSpacing.md),
        
        Row(
          children: [
            Expanded(
              child: AppButton.primary(
                onPressed: () => _startMixedQuiz(context, ref, 10),
                text: 'Quiz Corto\n(10 preguntas)',
              ),
            ),
            Gap(AppSpacing.sm),
            Expanded(
              child: AppButton.primary(
                onPressed: () => _startMixedQuiz(context, ref, 20),
                text: 'Quiz Largo\n(20 preguntas)',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildScoringInfo() {
    return AppCard(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: AppColors.primary,
                size: 20.w,
              ),
              Gap(AppSpacing.xs),
              Text(
                'Sistema de Puntuación',
                style: AppTextStyles.titleSmall.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Gap(AppSpacing.sm),
          
          _buildScoreItem('Pregunta Fácil:', '10 puntos', AppColors.success),
          _buildScoreItem('Pregunta Media:', '20 puntos', AppColors.warning),
          _buildScoreItem('Pregunta Difícil:', '30 puntos', AppColors.error),
        ],
      ),
    );
  }

  Widget _buildScoreItem(String label, String points, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.xs,
              vertical: 2.h,
            ),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              points,
              style: AppTextStyles.bodySmall.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _startCategoryQuiz(BuildContext context, WidgetRef ref, QuestionCategory category) {
    ref.read(triviaProvider.notifier).startQuiz(
      questionCount: 15,
      category: category,
    );
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const TriviaQuizScreen(),
      ),
    );
  }

  void _startMixedQuiz(BuildContext context, WidgetRef ref, int questionCount) {
    ref.read(triviaProvider.notifier).startQuiz(
      questionCount: questionCount,
    );
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const TriviaQuizScreen(),
      ),
    );
  }
}