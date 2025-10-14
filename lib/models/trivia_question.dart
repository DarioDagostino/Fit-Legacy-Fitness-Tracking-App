import 'package:freezed_annotation/freezed_annotation.dart';

part 'trivia_question.freezed.dart';
part 'trivia_question.g.dart';

enum QuestionCategory {
  @JsonValue('fitness')
  fitness('Fitness'),
  @JsonValue('nutrition')
  nutrition('Nutrición'),
  @JsonValue('health_wellness')
  healthWellness('Salud y Bienestar'),
  @JsonValue('sports_history')
  sportsHistory('Historia del Deporte');

  const QuestionCategory(this.displayName);
  final String displayName;
}

enum QuestionDifficulty {
  @JsonValue('easy')
  easy('Fácil'),
  @JsonValue('medium')
  medium('Medio'),
  @JsonValue('hard')
  hard('Difícil');

  const QuestionDifficulty(this.displayName);
  final String displayName;
}

@freezed
class TriviaQuestion with _$TriviaQuestion {
  const factory TriviaQuestion({
    required String id,
    required String question,
    required List<String> options,
    required int correctAnswerIndex,
    required QuestionCategory category,
    required QuestionDifficulty difficulty,
    String? explanation,
    List<String>? tags,
  }) = _TriviaQuestion;

  factory TriviaQuestion.fromJson(Map<String, dynamic> json) =>
      _$TriviaQuestionFromJson(json);
}

@freezed
class TriviaQuiz with _$TriviaQuiz {
  const factory TriviaQuiz({
    required String id,
    required String name,
    required List<TriviaQuestion> questions,
    required int timeLimit, // en segundos
    @Default(0) int currentQuestionIndex,
    @Default(0) int score,
    @Default([]) List<bool> answers,
    DateTime? startTime,
    DateTime? endTime,
  }) = _TriviaQuiz;

  factory TriviaQuiz.fromJson(Map<String, dynamic> json) =>
      _$TriviaQuizFromJson(json);
}

@freezed
class TriviaStats with _$TriviaStats {
  const factory TriviaStats({
    @Default(0) int totalQuestionsAnswered,
    @Default(0) int correctAnswers,
    @Default(0) int totalScore,
    @Default({}) Map<QuestionCategory, int> categoryStats,
    @Default([]) List<String> completedQuizzes,
    DateTime? lastPlayed,
  }) = _TriviaStats;

  factory TriviaStats.fromJson(Map<String, dynamic> json) =>
      _$TriviaStatsFromJson(json);
}