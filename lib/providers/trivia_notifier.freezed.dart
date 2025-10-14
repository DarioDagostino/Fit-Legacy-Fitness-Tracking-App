// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trivia_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TriviaState {
  TriviaQuiz? get currentQuiz => throw _privateConstructorUsedError;
  List<bool> get userAnswers => throw _privateConstructorUsedError;
  int get currentQuestionIndex => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  int get timeRemaining => throw _privateConstructorUsedError;
  bool get isQuizActive => throw _privateConstructorUsedError;
  bool get isQuizCompleted => throw _privateConstructorUsedError;
  TriviaStats? get stats => throw _privateConstructorUsedError;

  /// Create a copy of TriviaState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TriviaStateCopyWith<TriviaState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TriviaStateCopyWith<$Res> {
  factory $TriviaStateCopyWith(
          TriviaState value, $Res Function(TriviaState) then) =
      _$TriviaStateCopyWithImpl<$Res, TriviaState>;
  @useResult
  $Res call(
      {TriviaQuiz? currentQuiz,
      List<bool> userAnswers,
      int currentQuestionIndex,
      int score,
      int timeRemaining,
      bool isQuizActive,
      bool isQuizCompleted,
      TriviaStats? stats});

  $TriviaQuizCopyWith<$Res>? get currentQuiz;
  $TriviaStatsCopyWith<$Res>? get stats;
}

/// @nodoc
class _$TriviaStateCopyWithImpl<$Res, $Val extends TriviaState>
    implements $TriviaStateCopyWith<$Res> {
  _$TriviaStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TriviaState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentQuiz = freezed,
    Object? userAnswers = null,
    Object? currentQuestionIndex = null,
    Object? score = null,
    Object? timeRemaining = null,
    Object? isQuizActive = null,
    Object? isQuizCompleted = null,
    Object? stats = freezed,
  }) {
    return _then(_value.copyWith(
      currentQuiz: freezed == currentQuiz
          ? _value.currentQuiz
          : currentQuiz // ignore: cast_nullable_to_non_nullable
              as TriviaQuiz?,
      userAnswers: null == userAnswers
          ? _value.userAnswers
          : userAnswers // ignore: cast_nullable_to_non_nullable
              as List<bool>,
      currentQuestionIndex: null == currentQuestionIndex
          ? _value.currentQuestionIndex
          : currentQuestionIndex // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      timeRemaining: null == timeRemaining
          ? _value.timeRemaining
          : timeRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      isQuizActive: null == isQuizActive
          ? _value.isQuizActive
          : isQuizActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isQuizCompleted: null == isQuizCompleted
          ? _value.isQuizCompleted
          : isQuizCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as TriviaStats?,
    ) as $Val);
  }

  /// Create a copy of TriviaState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TriviaQuizCopyWith<$Res>? get currentQuiz {
    if (_value.currentQuiz == null) {
      return null;
    }

    return $TriviaQuizCopyWith<$Res>(_value.currentQuiz!, (value) {
      return _then(_value.copyWith(currentQuiz: value) as $Val);
    });
  }

  /// Create a copy of TriviaState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TriviaStatsCopyWith<$Res>? get stats {
    if (_value.stats == null) {
      return null;
    }

    return $TriviaStatsCopyWith<$Res>(_value.stats!, (value) {
      return _then(_value.copyWith(stats: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TriviaStateImplCopyWith<$Res>
    implements $TriviaStateCopyWith<$Res> {
  factory _$$TriviaStateImplCopyWith(
          _$TriviaStateImpl value, $Res Function(_$TriviaStateImpl) then) =
      __$$TriviaStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TriviaQuiz? currentQuiz,
      List<bool> userAnswers,
      int currentQuestionIndex,
      int score,
      int timeRemaining,
      bool isQuizActive,
      bool isQuizCompleted,
      TriviaStats? stats});

  @override
  $TriviaQuizCopyWith<$Res>? get currentQuiz;
  @override
  $TriviaStatsCopyWith<$Res>? get stats;
}

/// @nodoc
class __$$TriviaStateImplCopyWithImpl<$Res>
    extends _$TriviaStateCopyWithImpl<$Res, _$TriviaStateImpl>
    implements _$$TriviaStateImplCopyWith<$Res> {
  __$$TriviaStateImplCopyWithImpl(
      _$TriviaStateImpl _value, $Res Function(_$TriviaStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TriviaState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentQuiz = freezed,
    Object? userAnswers = null,
    Object? currentQuestionIndex = null,
    Object? score = null,
    Object? timeRemaining = null,
    Object? isQuizActive = null,
    Object? isQuizCompleted = null,
    Object? stats = freezed,
  }) {
    return _then(_$TriviaStateImpl(
      currentQuiz: freezed == currentQuiz
          ? _value.currentQuiz
          : currentQuiz // ignore: cast_nullable_to_non_nullable
              as TriviaQuiz?,
      userAnswers: null == userAnswers
          ? _value._userAnswers
          : userAnswers // ignore: cast_nullable_to_non_nullable
              as List<bool>,
      currentQuestionIndex: null == currentQuestionIndex
          ? _value.currentQuestionIndex
          : currentQuestionIndex // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      timeRemaining: null == timeRemaining
          ? _value.timeRemaining
          : timeRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      isQuizActive: null == isQuizActive
          ? _value.isQuizActive
          : isQuizActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isQuizCompleted: null == isQuizCompleted
          ? _value.isQuizCompleted
          : isQuizCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as TriviaStats?,
    ));
  }
}

/// @nodoc

class _$TriviaStateImpl implements _TriviaState {
  const _$TriviaStateImpl(
      {this.currentQuiz,
      final List<bool> userAnswers = const [],
      this.currentQuestionIndex = 0,
      this.score = 0,
      this.timeRemaining = 0,
      this.isQuizActive = false,
      this.isQuizCompleted = false,
      this.stats})
      : _userAnswers = userAnswers;

  @override
  final TriviaQuiz? currentQuiz;
  final List<bool> _userAnswers;
  @override
  @JsonKey()
  List<bool> get userAnswers {
    if (_userAnswers is EqualUnmodifiableListView) return _userAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userAnswers);
  }

  @override
  @JsonKey()
  final int currentQuestionIndex;
  @override
  @JsonKey()
  final int score;
  @override
  @JsonKey()
  final int timeRemaining;
  @override
  @JsonKey()
  final bool isQuizActive;
  @override
  @JsonKey()
  final bool isQuizCompleted;
  @override
  final TriviaStats? stats;

  @override
  String toString() {
    return 'TriviaState(currentQuiz: $currentQuiz, userAnswers: $userAnswers, currentQuestionIndex: $currentQuestionIndex, score: $score, timeRemaining: $timeRemaining, isQuizActive: $isQuizActive, isQuizCompleted: $isQuizCompleted, stats: $stats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TriviaStateImpl &&
            (identical(other.currentQuiz, currentQuiz) ||
                other.currentQuiz == currentQuiz) &&
            const DeepCollectionEquality()
                .equals(other._userAnswers, _userAnswers) &&
            (identical(other.currentQuestionIndex, currentQuestionIndex) ||
                other.currentQuestionIndex == currentQuestionIndex) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.timeRemaining, timeRemaining) ||
                other.timeRemaining == timeRemaining) &&
            (identical(other.isQuizActive, isQuizActive) ||
                other.isQuizActive == isQuizActive) &&
            (identical(other.isQuizCompleted, isQuizCompleted) ||
                other.isQuizCompleted == isQuizCompleted) &&
            (identical(other.stats, stats) || other.stats == stats));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentQuiz,
      const DeepCollectionEquality().hash(_userAnswers),
      currentQuestionIndex,
      score,
      timeRemaining,
      isQuizActive,
      isQuizCompleted,
      stats);

  /// Create a copy of TriviaState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TriviaStateImplCopyWith<_$TriviaStateImpl> get copyWith =>
      __$$TriviaStateImplCopyWithImpl<_$TriviaStateImpl>(this, _$identity);
}

abstract class _TriviaState implements TriviaState {
  const factory _TriviaState(
      {final TriviaQuiz? currentQuiz,
      final List<bool> userAnswers,
      final int currentQuestionIndex,
      final int score,
      final int timeRemaining,
      final bool isQuizActive,
      final bool isQuizCompleted,
      final TriviaStats? stats}) = _$TriviaStateImpl;

  @override
  TriviaQuiz? get currentQuiz;
  @override
  List<bool> get userAnswers;
  @override
  int get currentQuestionIndex;
  @override
  int get score;
  @override
  int get timeRemaining;
  @override
  bool get isQuizActive;
  @override
  bool get isQuizCompleted;
  @override
  TriviaStats? get stats;

  /// Create a copy of TriviaState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TriviaStateImplCopyWith<_$TriviaStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
