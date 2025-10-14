import 'dart:async';
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
import 'trivia_results_screen.dart';

class TriviaQuizScreen extends ConsumerStatefulWidget {
  const TriviaQuizScreen({super.key});

  @override
  ConsumerState<TriviaQuizScreen> createState() => _TriviaQuizScreenState();
}

class _TriviaQuizScreenState extends ConsumerState<TriviaQuizScreen>
    with TickerProviderStateMixin {
  Timer? _timer;
  int? _selectedAnswerIndex;
  bool _showAnswer = false;
  late AnimationController _progressController;
  late AnimationController _questionController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _questionController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _questionController.forward();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _progressController.dispose();
    _questionController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final state = ref.read(triviaProvider);
      if (state.timeRemaining > 0 && state.isQuizActive) {
        ref.read(triviaProvider.notifier).updateTimer(1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final triviaState = ref.watch(triviaProvider);
    final triviaNotifier = ref.read(triviaProvider.notifier);
    
    if (triviaState.isQuizCompleted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const TriviaResultsScreen(),
          ),
        );
      });
      return const SizedBox.shrink();
    }

    final currentQuestion = triviaNotifier.currentQuestion;
    if (currentQuestion == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text(
          _getCategoryDisplayName(currentQuestion.category),
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppSpacing.md),
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: _getTimeColor().withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.timer,
                      color: _getTimeColor(),
                      size: 16.w,
                    ),
                    Gap(AppSpacing.xs),
                    Text(
                      _formatTime(triviaState.timeRemaining),
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: _getTimeColor(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Barra de progreso
            _buildProgressBar(triviaState),
            
            // Contenido principal
            Expanded(
              child: AnimatedBuilder(
                animation: _questionController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      0,
                      (1 - _questionController.value) * 50,
                    ),
                    child: Opacity(
                      opacity: _questionController.value,
                      child: child,
                    ),
                  );
                },
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Información de la pregunta
                      _buildQuestionInfo(triviaState, currentQuestion),
                      
                      Gap(AppSpacing.lg),
                      
                      // Pregunta
                      _buildQuestionCard(currentQuestion),
                      
                      Gap(AppSpacing.lg),
                      
                      // Opciones de respuesta
                      _buildAnswerOptions(currentQuestion),
                      
                      Gap(AppSpacing.lg),
                      
                      // Botón siguiente
                      if (_showAnswer) _buildNextButton(triviaState),
                      
                      // Explicación (si se muestra)
                      if (_showAnswer && currentQuestion.explanation != null)
                        _buildExplanation(currentQuestion.explanation!),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(TriviaState triviaState) {
    final progress = ref.read(triviaProvider.notifier).progressPercentage;
    
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      color: AppColors.surface,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pregunta ${triviaState.currentQuestionIndex + 1}',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${triviaState.score} puntos',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Gap(AppSpacing.sm),
          
          AnimatedBuilder(
            animation: _progressController,
            builder: (context, child) {
              return LinearProgressIndicator(
                value: progress * _progressController.value,
                backgroundColor: AppColors.surfaceVariant,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                minHeight: 4.h,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionInfo(TriviaState triviaState, TriviaQuestion question) {
    return Row(
      children: [
        // Dificultad
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: _getDifficultyColor(question.difficulty).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: _getDifficultyColor(question.difficulty).withValues(alpha: 0.3),
            ),
          ),
          child: Text(
            question.difficulty.displayName,
            style: AppTextStyles.bodySmall.copyWith(
              color: _getDifficultyColor(question.difficulty),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        
        const Spacer(),
        
        // Precisión actual
        Text(
          'Precisión: ${ref.read(triviaProvider.notifier).accuracyPercentage.toStringAsFixed(0)}%',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionCard(TriviaQuestion question) {
    return AppCard(
      padding: EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.question,
            style: AppTextStyles.headlineSmall.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
          
          if (question.tags != null && question.tags!.isNotEmpty) ...[
            Gap(AppSpacing.md),
            Wrap(
              spacing: AppSpacing.xs,
              children: question.tags!.map((tag) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 2.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    '#$tag',
                    style: AppTextStyles.bodyXSmall.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAnswerOptions(TriviaQuestion question) {
    return Column(
      children: question.options.asMap().entries.map((entry) {
        final index = entry.key;
        final option = entry.value;
        
        return Padding(
          padding: EdgeInsets.only(bottom: AppSpacing.sm),
          child: _buildAnswerOption(question, index, option),
        );
      }).toList(),
    );
  }

  Widget _buildAnswerOption(TriviaQuestion question, int index, String option) {
    final isSelected = _selectedAnswerIndex == index;
    final isCorrect = question.correctAnswerIndex == index;
    final isWrong = _showAnswer && isSelected && !isCorrect;
    
    Color backgroundColor = AppColors.surface;
    Color borderColor = AppColors.outline;
    Color textColor = AppColors.onSurface;
    
    if (_showAnswer) {
      if (isCorrect) {
        backgroundColor = AppColors.success.withValues(alpha: 0.1);
        borderColor = AppColors.success;
        textColor = AppColors.success;
      } else if (isWrong) {
        backgroundColor = AppColors.error.withValues(alpha: 0.1);
        borderColor = AppColors.error;
        textColor = AppColors.error;
      }
    } else if (isSelected) {
      backgroundColor = AppColors.primary.withValues(alpha: 0.1);
      borderColor = AppColors.primary;
      textColor = AppColors.primary;
    }

    return GestureDetector(
      onTap: _showAnswer ? null : () => _selectAnswer(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: borderColor,
            width: 2.w,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _showAnswer && isCorrect
                    ? AppColors.success
                    : _showAnswer && isWrong
                        ? AppColors.error
                        : isSelected
                            ? AppColors.primary
                            : Colors.transparent,
                border: Border.all(
                  color: borderColor,
                  width: 2.w,
                ),
              ),
              child: _showAnswer
                  ? Icon(
                      isCorrect ? Icons.check : Icons.close,
                      color: Colors.white,
                      size: 16.w,
                    )
                  : isSelected
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 16.w,
                        )
                      : null,
            ),
            Gap(AppSpacing.md),
            
            Expanded(
              child: Text(
                option,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: textColor,
                  fontWeight: isSelected || (_showAnswer && isCorrect) 
                      ? FontWeight.w600 
                      : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton(TriviaState triviaState) {
    final isLastQuestion = triviaState.currentQuestionIndex >= 
        (triviaState.currentQuiz?.questions.length ?? 0) - 1;
    
    return Column(
      children: [
        Gap(AppSpacing.md),
        SizedBox(
          width: double.infinity,
          child: AppButton.primary(
            onPressed: _nextQuestion,
            text: isLastQuestion ? 'Ver Resultados' : 'Siguiente Pregunta',
          ),
        ),
      ],
    );
  }

  Widget _buildExplanation(String explanation) {
    return Column(
      children: [
        Gap(AppSpacing.lg),
        AppCard(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: AppColors.warning,
                    size: 20.w,
                  ),
                  Gap(AppSpacing.xs),
                  Text(
                    'Explicación',
                    style: AppTextStyles.titleSmall.copyWith(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Gap(AppSpacing.sm),
              Text(
                explanation,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _selectAnswer(int index) {
    if (_showAnswer) return;
    
    setState(() {
      _selectedAnswerIndex = index;
      _showAnswer = true;
    });
    
    ref.read(triviaProvider.notifier).answerQuestion(index);
    _progressController.forward();
  }

  void _nextQuestion() {
    _questionController.reset();
    _progressController.reset();
    
    setState(() {
      _selectedAnswerIndex = null;
      _showAnswer = false;
    });
    
    ref.read(triviaProvider.notifier).nextQuestion();
    _questionController.forward();
  }

  String _getCategoryDisplayName(QuestionCategory category) {
    return category.displayName;
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

  Color _getTimeColor() {
    final timeRemaining = ref.watch(triviaProvider).timeRemaining;
    if (timeRemaining <= 30) return AppColors.error;
    if (timeRemaining <= 60) return AppColors.warning;
    return AppColors.success;
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}