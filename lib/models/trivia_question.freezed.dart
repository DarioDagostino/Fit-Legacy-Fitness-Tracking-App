// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trivia_question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TriviaQuestion _$TriviaQuestionFromJson(Map<String, dynamic> json) {
  return _TriviaQuestion.fromJson(json);
}

/// @nodoc
mixin _$TriviaQuestion {
  String get id => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;
  List<String> get options => throw _privateConstructorUsedError;
  int get correctAnswerIndex => throw _privateConstructorUsedError;
  QuestionCategory get category => throw _privateConstructorUsedError;
  QuestionDifficulty get difficulty => throw _privateConstructorUsedError;
  String? get explanation => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;

  /// Serializes this TriviaQuestion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TriviaQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TriviaQuestionCopyWith<TriviaQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TriviaQuestionCopyWith<$Res> {
  factory $TriviaQuestionCopyWith(
          TriviaQuestion value, $Res Function(TriviaQuestion) then) =
      _$TriviaQuestionCopyWithImpl<$Res, TriviaQuestion>;
  @useResult
  $Res call(
      {String id,
      String question,
      List<String> options,
      int correctAnswerIndex,
      QuestionCategory category,
      QuestionDifficulty difficulty,
      String? explanation,
      List<String>? tags});
}

/// @nodoc
class _$TriviaQuestionCopyWithImpl<$Res, $Val extends TriviaQuestion>
    implements $TriviaQuestionCopyWith<$Res> {
  _$TriviaQuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TriviaQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? question = null,
    Object? options = null,
    Object? correctAnswerIndex = null,
    Object? category = null,
    Object? difficulty = null,
    Object? explanation = freezed,
    Object? tags = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
      correctAnswerIndex: null == correctAnswerIndex
          ? _value.correctAnswerIndex
          : correctAnswerIndex // ignore: cast_nullable_to_non_nullable
              as int,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as QuestionCategory,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as QuestionDifficulty,
      explanation: freezed == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TriviaQuestionImplCopyWith<$Res>
    implements $TriviaQuestionCopyWith<$Res> {
  factory _$$TriviaQuestionImplCopyWith(_$TriviaQuestionImpl value,
          $Res Function(_$TriviaQuestionImpl) then) =
      __$$TriviaQuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String question,
      List<String> options,
      int correctAnswerIndex,
      QuestionCategory category,
      QuestionDifficulty difficulty,
      String? explanation,
      List<String>? tags});
}

/// @nodoc
class __$$TriviaQuestionImplCopyWithImpl<$Res>
    extends _$TriviaQuestionCopyWithImpl<$Res, _$TriviaQuestionImpl>
    implements _$$TriviaQuestionImplCopyWith<$Res> {
  __$$TriviaQuestionImplCopyWithImpl(
      _$TriviaQuestionImpl _value, $Res Function(_$TriviaQuestionImpl) _then)
      : super(_value, _then);

  /// Create a copy of TriviaQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? question = null,
    Object? options = null,
    Object? correctAnswerIndex = null,
    Object? category = null,
    Object? difficulty = null,
    Object? explanation = freezed,
    Object? tags = freezed,
  }) {
    return _then(_$TriviaQuestionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
      correctAnswerIndex: null == correctAnswerIndex
          ? _value.correctAnswerIndex
          : correctAnswerIndex // ignore: cast_nullable_to_non_nullable
              as int,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as QuestionCategory,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as QuestionDifficulty,
      explanation: freezed == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TriviaQuestionImpl implements _TriviaQuestion {
  const _$TriviaQuestionImpl(
      {required this.id,
      required this.question,
      required final List<String> options,
      required this.correctAnswerIndex,
      required this.category,
      required this.difficulty,
      this.explanation,
      final List<String>? tags})
      : _options = options,
        _tags = tags;

  factory _$TriviaQuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TriviaQuestionImplFromJson(json);

  @override
  final String id;
  @override
  final String question;
  final List<String> _options;
  @override
  List<String> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  final int correctAnswerIndex;
  @override
  final QuestionCategory category;
  @override
  final QuestionDifficulty difficulty;
  @override
  final String? explanation;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'TriviaQuestion(id: $id, question: $question, options: $options, correctAnswerIndex: $correctAnswerIndex, category: $category, difficulty: $difficulty, explanation: $explanation, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TriviaQuestionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.correctAnswerIndex, correctAnswerIndex) ||
                other.correctAnswerIndex == correctAnswerIndex) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      question,
      const DeepCollectionEquality().hash(_options),
      correctAnswerIndex,
      category,
      difficulty,
      explanation,
      const DeepCollectionEquality().hash(_tags));

  /// Create a copy of TriviaQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TriviaQuestionImplCopyWith<_$TriviaQuestionImpl> get copyWith =>
      __$$TriviaQuestionImplCopyWithImpl<_$TriviaQuestionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TriviaQuestionImplToJson(
      this,
    );
  }
}

abstract class _TriviaQuestion implements TriviaQuestion {
  const factory _TriviaQuestion(
      {required final String id,
      required final String question,
      required final List<String> options,
      required final int correctAnswerIndex,
      required final QuestionCategory category,
      required final QuestionDifficulty difficulty,
      final String? explanation,
      final List<String>? tags}) = _$TriviaQuestionImpl;

  factory _TriviaQuestion.fromJson(Map<String, dynamic> json) =
      _$TriviaQuestionImpl.fromJson;

  @override
  String get id;
  @override
  String get question;
  @override
  List<String> get options;
  @override
  int get correctAnswerIndex;
  @override
  QuestionCategory get category;
  @override
  QuestionDifficulty get difficulty;
  @override
  String? get explanation;
  @override
  List<String>? get tags;

  /// Create a copy of TriviaQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TriviaQuestionImplCopyWith<_$TriviaQuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TriviaQuiz _$TriviaQuizFromJson(Map<String, dynamic> json) {
  return _TriviaQuiz.fromJson(json);
}

/// @nodoc
mixin _$TriviaQuiz {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<TriviaQuestion> get questions => throw _privateConstructorUsedError;
  int get timeLimit => throw _privateConstructorUsedError; // en segundos
  int get currentQuestionIndex => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  List<bool> get answers => throw _privateConstructorUsedError;
  DateTime? get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;

  /// Serializes this TriviaQuiz to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TriviaQuiz
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TriviaQuizCopyWith<TriviaQuiz> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TriviaQuizCopyWith<$Res> {
  factory $TriviaQuizCopyWith(
          TriviaQuiz value, $Res Function(TriviaQuiz) then) =
      _$TriviaQuizCopyWithImpl<$Res, TriviaQuiz>;
  @useResult
  $Res call(
      {String id,
      String name,
      List<TriviaQuestion> questions,
      int timeLimit,
      int currentQuestionIndex,
      int score,
      List<bool> answers,
      DateTime? startTime,
      DateTime? endTime});
}

/// @nodoc
class _$TriviaQuizCopyWithImpl<$Res, $Val extends TriviaQuiz>
    implements $TriviaQuizCopyWith<$Res> {
  _$TriviaQuizCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TriviaQuiz
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? questions = null,
    Object? timeLimit = null,
    Object? currentQuestionIndex = null,
    Object? score = null,
    Object? answers = null,
    Object? startTime = freezed,
    Object? endTime = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      questions: null == questions
          ? _value.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<TriviaQuestion>,
      timeLimit: null == timeLimit
          ? _value.timeLimit
          : timeLimit // ignore: cast_nullable_to_non_nullable
              as int,
      currentQuestionIndex: null == currentQuestionIndex
          ? _value.currentQuestionIndex
          : currentQuestionIndex // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      answers: null == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<bool>,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TriviaQuizImplCopyWith<$Res>
    implements $TriviaQuizCopyWith<$Res> {
  factory _$$TriviaQuizImplCopyWith(
          _$TriviaQuizImpl value, $Res Function(_$TriviaQuizImpl) then) =
      __$$TriviaQuizImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      List<TriviaQuestion> questions,
      int timeLimit,
      int currentQuestionIndex,
      int score,
      List<bool> answers,
      DateTime? startTime,
      DateTime? endTime});
}

/// @nodoc
class __$$TriviaQuizImplCopyWithImpl<$Res>
    extends _$TriviaQuizCopyWithImpl<$Res, _$TriviaQuizImpl>
    implements _$$TriviaQuizImplCopyWith<$Res> {
  __$$TriviaQuizImplCopyWithImpl(
      _$TriviaQuizImpl _value, $Res Function(_$TriviaQuizImpl) _then)
      : super(_value, _then);

  /// Create a copy of TriviaQuiz
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? questions = null,
    Object? timeLimit = null,
    Object? currentQuestionIndex = null,
    Object? score = null,
    Object? answers = null,
    Object? startTime = freezed,
    Object? endTime = freezed,
  }) {
    return _then(_$TriviaQuizImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      questions: null == questions
          ? _value._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<TriviaQuestion>,
      timeLimit: null == timeLimit
          ? _value.timeLimit
          : timeLimit // ignore: cast_nullable_to_non_nullable
              as int,
      currentQuestionIndex: null == currentQuestionIndex
          ? _value.currentQuestionIndex
          : currentQuestionIndex // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      answers: null == answers
          ? _value._answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<bool>,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TriviaQuizImpl implements _TriviaQuiz {
  const _$TriviaQuizImpl(
      {required this.id,
      required this.name,
      required final List<TriviaQuestion> questions,
      required this.timeLimit,
      this.currentQuestionIndex = 0,
      this.score = 0,
      final List<bool> answers = const [],
      this.startTime,
      this.endTime})
      : _questions = questions,
        _answers = answers;

  factory _$TriviaQuizImpl.fromJson(Map<String, dynamic> json) =>
      _$$TriviaQuizImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final List<TriviaQuestion> _questions;
  @override
  List<TriviaQuestion> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  final int timeLimit;
// en segundos
  @override
  @JsonKey()
  final int currentQuestionIndex;
  @override
  @JsonKey()
  final int score;
  final List<bool> _answers;
  @override
  @JsonKey()
  List<bool> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  @override
  final DateTime? startTime;
  @override
  final DateTime? endTime;

  @override
  String toString() {
    return 'TriviaQuiz(id: $id, name: $name, questions: $questions, timeLimit: $timeLimit, currentQuestionIndex: $currentQuestionIndex, score: $score, answers: $answers, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TriviaQuizImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions) &&
            (identical(other.timeLimit, timeLimit) ||
                other.timeLimit == timeLimit) &&
            (identical(other.currentQuestionIndex, currentQuestionIndex) ||
                other.currentQuestionIndex == currentQuestionIndex) &&
            (identical(other.score, score) || other.score == score) &&
            const DeepCollectionEquality().equals(other._answers, _answers) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(_questions),
      timeLimit,
      currentQuestionIndex,
      score,
      const DeepCollectionEquality().hash(_answers),
      startTime,
      endTime);

  /// Create a copy of TriviaQuiz
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TriviaQuizImplCopyWith<_$TriviaQuizImpl> get copyWith =>
      __$$TriviaQuizImplCopyWithImpl<_$TriviaQuizImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TriviaQuizImplToJson(
      this,
    );
  }
}

abstract class _TriviaQuiz implements TriviaQuiz {
  const factory _TriviaQuiz(
      {required final String id,
      required final String name,
      required final List<TriviaQuestion> questions,
      required final int timeLimit,
      final int currentQuestionIndex,
      final int score,
      final List<bool> answers,
      final DateTime? startTime,
      final DateTime? endTime}) = _$TriviaQuizImpl;

  factory _TriviaQuiz.fromJson(Map<String, dynamic> json) =
      _$TriviaQuizImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  List<TriviaQuestion> get questions;
  @override
  int get timeLimit; // en segundos
  @override
  int get currentQuestionIndex;
  @override
  int get score;
  @override
  List<bool> get answers;
  @override
  DateTime? get startTime;
  @override
  DateTime? get endTime;

  /// Create a copy of TriviaQuiz
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TriviaQuizImplCopyWith<_$TriviaQuizImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TriviaStats _$TriviaStatsFromJson(Map<String, dynamic> json) {
  return _TriviaStats.fromJson(json);
}

/// @nodoc
mixin _$TriviaStats {
  int get totalQuestionsAnswered => throw _privateConstructorUsedError;
  int get correctAnswers => throw _privateConstructorUsedError;
  int get totalScore => throw _privateConstructorUsedError;
  Map<QuestionCategory, int> get categoryStats =>
      throw _privateConstructorUsedError;
  List<String> get completedQuizzes => throw _privateConstructorUsedError;
  DateTime? get lastPlayed => throw _privateConstructorUsedError;

  /// Serializes this TriviaStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TriviaStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TriviaStatsCopyWith<TriviaStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TriviaStatsCopyWith<$Res> {
  factory $TriviaStatsCopyWith(
          TriviaStats value, $Res Function(TriviaStats) then) =
      _$TriviaStatsCopyWithImpl<$Res, TriviaStats>;
  @useResult
  $Res call(
      {int totalQuestionsAnswered,
      int correctAnswers,
      int totalScore,
      Map<QuestionCategory, int> categoryStats,
      List<String> completedQuizzes,
      DateTime? lastPlayed});
}

/// @nodoc
class _$TriviaStatsCopyWithImpl<$Res, $Val extends TriviaStats>
    implements $TriviaStatsCopyWith<$Res> {
  _$TriviaStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TriviaStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalQuestionsAnswered = null,
    Object? correctAnswers = null,
    Object? totalScore = null,
    Object? categoryStats = null,
    Object? completedQuizzes = null,
    Object? lastPlayed = freezed,
  }) {
    return _then(_value.copyWith(
      totalQuestionsAnswered: null == totalQuestionsAnswered
          ? _value.totalQuestionsAnswered
          : totalQuestionsAnswered // ignore: cast_nullable_to_non_nullable
              as int,
      correctAnswers: null == correctAnswers
          ? _value.correctAnswers
          : correctAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      totalScore: null == totalScore
          ? _value.totalScore
          : totalScore // ignore: cast_nullable_to_non_nullable
              as int,
      categoryStats: null == categoryStats
          ? _value.categoryStats
          : categoryStats // ignore: cast_nullable_to_non_nullable
              as Map<QuestionCategory, int>,
      completedQuizzes: null == completedQuizzes
          ? _value.completedQuizzes
          : completedQuizzes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastPlayed: freezed == lastPlayed
          ? _value.lastPlayed
          : lastPlayed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TriviaStatsImplCopyWith<$Res>
    implements $TriviaStatsCopyWith<$Res> {
  factory _$$TriviaStatsImplCopyWith(
          _$TriviaStatsImpl value, $Res Function(_$TriviaStatsImpl) then) =
      __$$TriviaStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalQuestionsAnswered,
      int correctAnswers,
      int totalScore,
      Map<QuestionCategory, int> categoryStats,
      List<String> completedQuizzes,
      DateTime? lastPlayed});
}

/// @nodoc
class __$$TriviaStatsImplCopyWithImpl<$Res>
    extends _$TriviaStatsCopyWithImpl<$Res, _$TriviaStatsImpl>
    implements _$$TriviaStatsImplCopyWith<$Res> {
  __$$TriviaStatsImplCopyWithImpl(
      _$TriviaStatsImpl _value, $Res Function(_$TriviaStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of TriviaStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalQuestionsAnswered = null,
    Object? correctAnswers = null,
    Object? totalScore = null,
    Object? categoryStats = null,
    Object? completedQuizzes = null,
    Object? lastPlayed = freezed,
  }) {
    return _then(_$TriviaStatsImpl(
      totalQuestionsAnswered: null == totalQuestionsAnswered
          ? _value.totalQuestionsAnswered
          : totalQuestionsAnswered // ignore: cast_nullable_to_non_nullable
              as int,
      correctAnswers: null == correctAnswers
          ? _value.correctAnswers
          : correctAnswers // ignore: cast_nullable_to_non_nullable
              as int,
      totalScore: null == totalScore
          ? _value.totalScore
          : totalScore // ignore: cast_nullable_to_non_nullable
              as int,
      categoryStats: null == categoryStats
          ? _value._categoryStats
          : categoryStats // ignore: cast_nullable_to_non_nullable
              as Map<QuestionCategory, int>,
      completedQuizzes: null == completedQuizzes
          ? _value._completedQuizzes
          : completedQuizzes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastPlayed: freezed == lastPlayed
          ? _value.lastPlayed
          : lastPlayed // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TriviaStatsImpl implements _TriviaStats {
  const _$TriviaStatsImpl(
      {this.totalQuestionsAnswered = 0,
      this.correctAnswers = 0,
      this.totalScore = 0,
      final Map<QuestionCategory, int> categoryStats = const {},
      final List<String> completedQuizzes = const [],
      this.lastPlayed})
      : _categoryStats = categoryStats,
        _completedQuizzes = completedQuizzes;

  factory _$TriviaStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TriviaStatsImplFromJson(json);

  @override
  @JsonKey()
  final int totalQuestionsAnswered;
  @override
  @JsonKey()
  final int correctAnswers;
  @override
  @JsonKey()
  final int totalScore;
  final Map<QuestionCategory, int> _categoryStats;
  @override
  @JsonKey()
  Map<QuestionCategory, int> get categoryStats {
    if (_categoryStats is EqualUnmodifiableMapView) return _categoryStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_categoryStats);
  }

  final List<String> _completedQuizzes;
  @override
  @JsonKey()
  List<String> get completedQuizzes {
    if (_completedQuizzes is EqualUnmodifiableListView)
      return _completedQuizzes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedQuizzes);
  }

  @override
  final DateTime? lastPlayed;

  @override
  String toString() {
    return 'TriviaStats(totalQuestionsAnswered: $totalQuestionsAnswered, correctAnswers: $correctAnswers, totalScore: $totalScore, categoryStats: $categoryStats, completedQuizzes: $completedQuizzes, lastPlayed: $lastPlayed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TriviaStatsImpl &&
            (identical(other.totalQuestionsAnswered, totalQuestionsAnswered) ||
                other.totalQuestionsAnswered == totalQuestionsAnswered) &&
            (identical(other.correctAnswers, correctAnswers) ||
                other.correctAnswers == correctAnswers) &&
            (identical(other.totalScore, totalScore) ||
                other.totalScore == totalScore) &&
            const DeepCollectionEquality()
                .equals(other._categoryStats, _categoryStats) &&
            const DeepCollectionEquality()
                .equals(other._completedQuizzes, _completedQuizzes) &&
            (identical(other.lastPlayed, lastPlayed) ||
                other.lastPlayed == lastPlayed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalQuestionsAnswered,
      correctAnswers,
      totalScore,
      const DeepCollectionEquality().hash(_categoryStats),
      const DeepCollectionEquality().hash(_completedQuizzes),
      lastPlayed);

  /// Create a copy of TriviaStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TriviaStatsImplCopyWith<_$TriviaStatsImpl> get copyWith =>
      __$$TriviaStatsImplCopyWithImpl<_$TriviaStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TriviaStatsImplToJson(
      this,
    );
  }
}

abstract class _TriviaStats implements TriviaStats {
  const factory _TriviaStats(
      {final int totalQuestionsAnswered,
      final int correctAnswers,
      final int totalScore,
      final Map<QuestionCategory, int> categoryStats,
      final List<String> completedQuizzes,
      final DateTime? lastPlayed}) = _$TriviaStatsImpl;

  factory _TriviaStats.fromJson(Map<String, dynamic> json) =
      _$TriviaStatsImpl.fromJson;

  @override
  int get totalQuestionsAnswered;
  @override
  int get correctAnswers;
  @override
  int get totalScore;
  @override
  Map<QuestionCategory, int> get categoryStats;
  @override
  List<String> get completedQuizzes;
  @override
  DateTime? get lastPlayed;

  /// Create a copy of TriviaStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TriviaStatsImplCopyWith<_$TriviaStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
