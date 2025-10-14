import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/trivia_question.dart';
import '../data/trivia_database.dart';

part 'trivia_notifier.freezed.dart';

@freezed
class TriviaState with _$TriviaState {
  const factory TriviaState({
    TriviaQuiz? currentQuiz,
    @Default([]) List<bool> userAnswers,
    @Default(0) int currentQuestionIndex,
    @Default(0) int score,
    @Default(0) int timeRemaining,
    @Default(false) bool isQuizActive,
    @Default(false) bool isQuizCompleted,
    TriviaStats? stats,
  }) = _TriviaState;
}

class TriviaNotifier extends StateNotifier<TriviaState> {
  TriviaNotifier() : super(const TriviaState()) {
    _loadStats();
  }

  void _loadStats() {
    // En una implementación real, cargaríamos desde SharedPreferences o base de datos
    const defaultStats = TriviaStats(
      totalQuestionsAnswered: 0,
      correctAnswers: 0,
      totalScore: 0,
      categoryStats: {},
    );
    
    state = state.copyWith(stats: defaultStats);
  }

  void startQuiz({
    int questionCount = 10,
    QuestionCategory? category,
    QuestionDifficulty? difficulty,
  }) {
    final quiz = TriviaDatabase.createRandomQuiz(
      questionCount: questionCount,
      category: category,
      difficulty: difficulty,
    );

    state = state.copyWith(
      currentQuiz: quiz.copyWith(startTime: DateTime.now()),
      userAnswers: List.filled(quiz.questions.length, false),
      currentQuestionIndex: 0,
      score: 0,
      timeRemaining: quiz.timeLimit,
      isQuizActive: true,
      isQuizCompleted: false,
    );
  }

  void answerQuestion(int selectedAnswerIndex) {
    final quiz = state.currentQuiz;
    if (quiz == null || state.isQuizCompleted) return;

    final currentQuestion = quiz.questions[state.currentQuestionIndex];
    final isCorrect = selectedAnswerIndex == currentQuestion.correctAnswerIndex;
    
    // Actualizar respuesta del usuario
    final updatedAnswers = List<bool>.from(state.userAnswers);
    updatedAnswers[state.currentQuestionIndex] = isCorrect;

    // Calcular puntuación basada en dificultad
    int questionScore = 0;
    if (isCorrect) {
      switch (currentQuestion.difficulty) {
        case QuestionDifficulty.easy:
          questionScore = 10;
          break;
        case QuestionDifficulty.medium:
          questionScore = 20;
          break;
        case QuestionDifficulty.hard:
          questionScore = 30;
          break;
      }
    }

    state = state.copyWith(
      userAnswers: updatedAnswers,
      score: state.score + questionScore,
    );
  }

  void nextQuestion() {
    final quiz = state.currentQuiz;
    if (quiz == null) return;

    if (state.currentQuestionIndex < quiz.questions.length - 1) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
      );
    } else {
      _completeQuiz();
    }
  }

  void _completeQuiz() {
    final quiz = state.currentQuiz;
    if (quiz == null) return;

    final correctAnswers = state.userAnswers.where((answer) => answer).length;
    final totalQuestions = quiz.questions.length;

    // Actualizar estadísticas
    final currentStats = state.stats ?? const TriviaStats();
    final updatedCategoryStats = Map<QuestionCategory, int>.from(currentStats.categoryStats);
    
    for (int i = 0; i < quiz.questions.length; i++) {
      final question = quiz.questions[i];
      final category = question.category;
      
      if (state.userAnswers[i]) {
        updatedCategoryStats[category] = (updatedCategoryStats[category] ?? 0) + 1;
      }
    }

    final updatedStats = currentStats.copyWith(
      totalQuestionsAnswered: currentStats.totalQuestionsAnswered + totalQuestions,
      correctAnswers: currentStats.correctAnswers + correctAnswers,
      totalScore: currentStats.totalScore + state.score,
      categoryStats: updatedCategoryStats,
      lastPlayed: DateTime.now(),
    );

    state = state.copyWith(
      currentQuiz: quiz.copyWith(endTime: DateTime.now()),
      isQuizActive: false,
      isQuizCompleted: true,
      stats: updatedStats,
    );

    // En una implementación real, guardaríamos las estadísticas
    _saveStats(updatedStats);
  }

  void _saveStats(TriviaStats stats) {
    // Implementar guardado en SharedPreferences o base de datos
    print('Guardando estadísticas: ${stats.totalScore} puntos totales');
  }

  void resetQuiz() {
    state = const TriviaState();
    _loadStats();
  }

  void updateTimer(int seconds) {
    if (state.timeRemaining > 0 && state.isQuizActive) {
      state = state.copyWith(timeRemaining: state.timeRemaining - 1);
      
      if (state.timeRemaining <= 0) {
        _completeQuiz();
      }
    }
  }

  // Getters útiles
  TriviaQuestion? get currentQuestion {
    final quiz = state.currentQuiz;
    if (quiz == null || state.currentQuestionIndex >= quiz.questions.length) {
      return null;
    }
    return quiz.questions[state.currentQuestionIndex];
  }

  double get progressPercentage {
    final quiz = state.currentQuiz;
    if (quiz == null || quiz.questions.isEmpty) return 0.0;
    return (state.currentQuestionIndex + 1) / quiz.questions.length;
  }

  int get correctAnswersCount {
    return state.userAnswers.where((answer) => answer).length;
  }

  double get accuracyPercentage {
    final totalAnswered = state.currentQuestionIndex + 1;
    if (totalAnswered == 0) return 0.0;
    return (correctAnswersCount / totalAnswered) * 100;
  }
}

// Provider
final triviaProvider = StateNotifierProvider<TriviaNotifier, TriviaState>((ref) {
  return TriviaNotifier();
});