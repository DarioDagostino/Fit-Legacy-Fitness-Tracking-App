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

class TriviaResultsScreen extends ConsumerWidget {
  const TriviaResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final triviaState = ref.watch(triviaProvider);
    final triviaNotifier = ref.read(triviaProvider.notifier);
    
    final quiz = triviaState.currentQuiz;
    if (quiz == null) {
      return const Scaffold(
        body: Center(
          child: Text('No hay datos del quiz'),
        ),
      );
    }

    final totalQuestions = quiz.questions.length;
    final correctAnswers = triviaNotifier.correctAnswersCount;
    final accuracyPercentage = (correctAnswers / totalQuestions) * 100;
    final timeElapsed = quiz.endTime != null && quiz.startTime != null
        ? quiz.endTime!.difference(quiz.startTime!).inSeconds
        : 0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text(
          'Resultados del Quiz',
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              // Puntuación principal
              _buildScoreCard(triviaState.score, correctAnswers, totalQuestions, accuracyPercentage),
              
              Gap(AppSpacing.lg),
              
              // Estadísticas detalladas
              _buildDetailedStats(timeElapsed, quiz),
              
              Gap(AppSpacing.lg),
              
              // Análisis por categoría
              if (_hasMultipleCategories(quiz.questions))
                _buildCategoryAnalysis(quiz.questions, triviaState.userAnswers),
              
              Gap(AppSpacing.lg),
              
              // Review de preguntas
              _buildQuestionReview(quiz.questions, triviaState.userAnswers),
              
              Gap(AppSpacing.xl),
              
              // Botones de acción
              _buildActionButtons(context, ref),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreCard(int score, int correct, int total, double accuracy) {
    return AppCard(
      padding: EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          // Ícono y mensaje principal
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: _getScoreColor(accuracy).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getScoreIcon(accuracy),
              size: 40.w,
              color: _getScoreColor(accuracy),
            ),
          ),
          
          Gap(AppSpacing.md),
          
          Text(
            _getScoreMessage(accuracy),
            style: AppTextStyles.headlineMedium.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          
          Gap(AppSpacing.sm),
          
          // Puntuación
          Text(
            '$score puntos',
            style: AppTextStyles.displaySmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          Gap(AppSpacing.sm),
          
          // Precisión
          Text(
            '$correct de $total respuestas correctas',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          
          Gap(AppSpacing.md),
          
          // Barra de progreso circular o lineal
          _buildAccuracyIndicator(accuracy),
        ],
      ),
    );
  }

  Widget _buildAccuracyIndicator(double accuracy) {
    return Column(
      children: [
        Text(
          'Precisión: ${accuracy.toStringAsFixed(1)}%',
          style: AppTextStyles.titleSmall.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        Gap(AppSpacing.sm),
        
        LinearProgressIndicator(
          value: accuracy / 100,
          backgroundColor: AppColors.surfaceVariant,
          valueColor: AlwaysStoppedAnimation<Color>(_getScoreColor(accuracy)),
          minHeight: 8.h,
        ),
      ],
    );
  }

  Widget _buildDetailedStats(int timeElapsed, TriviaQuiz quiz) {
    return AppCard(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Estadísticas Detalladas',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(AppSpacing.md),
          
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'Tiempo Total',
                  _formatTime(timeElapsed),
                  Icons.timer,
                  AppColors.primary,
                ),
              ),
              Gap(AppSpacing.sm),
              Expanded(
                child: _buildStatItem(
                  'Tiempo Promedio',
                  _formatTime(timeElapsed ~/ quiz.questions.length),
                  Icons.speed,
                  AppColors.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24.w,
          ),
          Gap(AppSpacing.xs),
          Text(
            value,
            style: AppTextStyles.titleMedium.copyWith(
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

  Widget _buildCategoryAnalysis(List<TriviaQuestion> questions, List<bool> answers) {
    final categoryStats = <QuestionCategory, Map<String, int>>{};
    
    for (int i = 0; i < questions.length; i++) {
      final category = questions[i].category;
      categoryStats.putIfAbsent(category, () => {'total': 0, 'correct': 0});
      categoryStats[category]!['total'] = categoryStats[category]!['total']! + 1;
      if (i < answers.length && answers[i]) {
        categoryStats[category]!['correct'] = categoryStats[category]!['correct']! + 1;
      }
    }

    return AppCard(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rendimiento por Categoría',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(AppSpacing.md),
          
          ...categoryStats.entries.map((entry) {
            final category = entry.key;
            final stats = entry.value;
            final correct = stats['correct']!;
            final total = stats['total']!;
            final percentage = total > 0 ? (correct / total) * 100 : 0.0;
            
            return Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      category.displayName,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.onSurface,
                      ),
                    ),
                  ),
                  
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        LinearProgressIndicator(
                          value: percentage / 100,
                          backgroundColor: AppColors.surfaceVariant,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            _getCategoryColor(category),
                          ),
                          minHeight: 6.h,
                        ),
                        Gap(AppSpacing.xs),
                        Text(
                          '$correct/$total (${percentage.toStringAsFixed(0)}%)',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildQuestionReview(List<TriviaQuestion> questions, List<bool> answers) {
    return AppCard(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Revisión de Preguntas',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(AppSpacing.md),
          
          ...questions.asMap().entries.map((entry) {
            final index = entry.key;
            final question = entry.value;
            final isCorrect = index < answers.length ? answers[index] : false;
            
            return Container(
              margin: EdgeInsets.only(bottom: AppSpacing.sm),
              padding: EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: isCorrect 
                    ? AppColors.success.withValues(alpha: 0.05)
                    : AppColors.error.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: isCorrect 
                      ? AppColors.success.withValues(alpha: 0.2)
                      : AppColors.error.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 20.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCorrect ? AppColors.success : AppColors.error,
                    ),
                    child: Icon(
                      isCorrect ? Icons.check : Icons.close,
                      color: Colors.white,
                      size: 14.w,
                    ),
                  ),
                  Gap(AppSpacing.sm),
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pregunta ${index + 1}',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          question.question,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.onSurface,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: _getDifficultyColor(question.difficulty).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      question.difficulty.displayName,
                      style: AppTextStyles.bodyXSmall.copyWith(
                        color: _getDifficultyColor(question.difficulty),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: AppButton.primary(
            onPressed: () => _playAgain(context, ref),
            text: 'Jugar de Nuevo',
          ),
        ),
        Gap(AppSpacing.sm),
        
        SizedBox(
          width: double.infinity,
          child: AppButton.secondary(
            onPressed: () => _backToMenu(context, ref),
            text: 'Volver al Menú',
          ),
        ),
      ],
    );
  }

  // Métodos auxiliares
  Color _getScoreColor(double accuracy) {
    if (accuracy >= 80) return AppColors.success;
    if (accuracy >= 60) return AppColors.warning;
    return AppColors.error;
  }

  IconData _getScoreIcon(double accuracy) {
    if (accuracy >= 90) return Icons.emoji_events;
    if (accuracy >= 70) return Icons.thumb_up;
    if (accuracy >= 50) return Icons.sentiment_neutral;
    return Icons.sentiment_dissatisfied;
  }

  String _getScoreMessage(double accuracy) {
    if (accuracy >= 90) return '¡Excelente!';
    if (accuracy >= 70) return '¡Muy bien!';
    if (accuracy >= 50) return 'Bien';
    return 'Sigue practicando';
  }

  Color _getCategoryColor(QuestionCategory category) {
    switch (category) {
      case QuestionCategory.fitness:
        return AppColors.primary;
      case QuestionCategory.nutrition:
        return AppColors.success;
      case QuestionCategory.healthWellness:
        return AppColors.error;
      case QuestionCategory.sportsHistory:
        return AppColors.warning;
    }
  }

  Color _getDifficultyColor(QuestionDifficulty difficulty) {
    switch (difficulty) {
      case QuestionDifficulty.easy:
        return AppColors.success;
      case QuestionDifficulty.medium:
        return AppColors.warning;
      case QuestionDifficulty.hard:
        return AppColors.error;
    }
  }

  bool _hasMultipleCategories(List<TriviaQuestion> questions) {
    final categories = questions.map((q) => q.category).toSet();
    return categories.length > 1;
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes}m ${remainingSeconds}s';
  }

  void _playAgain(BuildContext context, WidgetRef ref) {
    final currentQuiz = ref.read(triviaProvider).currentQuiz;
    if (currentQuiz != null) {
      // Reiniciar con la misma configuración
      ref.read(triviaProvider.notifier).startQuiz(
        questionCount: currentQuiz.questions.length,
        // Nota: necesitaríamos almacenar la configuración original del quiz
      );
      
      Navigator.of(context).pushReplacementNamed('/trivia-quiz');
    }
  }

  void _backToMenu(BuildContext context, WidgetRef ref) {
    ref.read(triviaProvider.notifier).resetQuiz();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}