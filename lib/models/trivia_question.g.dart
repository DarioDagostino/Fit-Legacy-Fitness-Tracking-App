// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trivia_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TriviaQuestionImpl _$$TriviaQuestionImplFromJson(Map<String, dynamic> json) =>
    _$TriviaQuestionImpl(
      id: json['id'] as String,
      question: json['question'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      correctAnswerIndex: (json['correctAnswerIndex'] as num).toInt(),
      category: $enumDecode(_$QuestionCategoryEnumMap, json['category']),
      difficulty: $enumDecode(_$QuestionDifficultyEnumMap, json['difficulty']),
      explanation: json['explanation'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$TriviaQuestionImplToJson(
        _$TriviaQuestionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'options': instance.options,
      'correctAnswerIndex': instance.correctAnswerIndex,
      'category': _$QuestionCategoryEnumMap[instance.category]!,
      'difficulty': _$QuestionDifficultyEnumMap[instance.difficulty]!,
      'explanation': instance.explanation,
      'tags': instance.tags,
    };

const _$QuestionCategoryEnumMap = {
  QuestionCategory.fitness: 'fitness',
  QuestionCategory.nutrition: 'nutrition',
  QuestionCategory.healthWellness: 'health_wellness',
  QuestionCategory.sportsHistory: 'sports_history',
};

const _$QuestionDifficultyEnumMap = {
  QuestionDifficulty.easy: 'easy',
  QuestionDifficulty.medium: 'medium',
  QuestionDifficulty.hard: 'hard',
};

_$TriviaQuizImpl _$$TriviaQuizImplFromJson(Map<String, dynamic> json) =>
    _$TriviaQuizImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => TriviaQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
      timeLimit: (json['timeLimit'] as num).toInt(),
      currentQuestionIndex:
          (json['currentQuestionIndex'] as num?)?.toInt() ?? 0,
      score: (json['score'] as num?)?.toInt() ?? 0,
      answers:
          (json['answers'] as List<dynamic>?)?.map((e) => e as bool).toList() ??
              const [],
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
    );

Map<String, dynamic> _$$TriviaQuizImplToJson(_$TriviaQuizImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'questions': instance.questions,
      'timeLimit': instance.timeLimit,
      'currentQuestionIndex': instance.currentQuestionIndex,
      'score': instance.score,
      'answers': instance.answers,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
    };

_$TriviaStatsImpl _$$TriviaStatsImplFromJson(Map<String, dynamic> json) =>
    _$TriviaStatsImpl(
      totalQuestionsAnswered:
          (json['totalQuestionsAnswered'] as num?)?.toInt() ?? 0,
      correctAnswers: (json['correctAnswers'] as num?)?.toInt() ?? 0,
      totalScore: (json['totalScore'] as num?)?.toInt() ?? 0,
      categoryStats: (json['categoryStats'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                $enumDecode(_$QuestionCategoryEnumMap, k), (e as num).toInt()),
          ) ??
          const {},
      completedQuizzes: (json['completedQuizzes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      lastPlayed: json['lastPlayed'] == null
          ? null
          : DateTime.parse(json['lastPlayed'] as String),
    );

Map<String, dynamic> _$$TriviaStatsImplToJson(_$TriviaStatsImpl instance) =>
    <String, dynamic>{
      'totalQuestionsAnswered': instance.totalQuestionsAnswered,
      'correctAnswers': instance.correctAnswers,
      'totalScore': instance.totalScore,
      'categoryStats': instance.categoryStats
          .map((k, e) => MapEntry(_$QuestionCategoryEnumMap[k]!, e)),
      'completedQuizzes': instance.completedQuizzes,
      'lastPlayed': instance.lastPlayed?.toIso8601String(),
    };
