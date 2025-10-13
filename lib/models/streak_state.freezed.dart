// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'streak_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StreakState _$StreakStateFromJson(Map<String, dynamic> json) {
  return _StreakState.fromJson(json);
}

/// @nodoc
mixin _$StreakState {
  String get streakId => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // 'daily' | 'weekly' | 'habit'
  int get length => throw _privateConstructorUsedError;
  String? get lastUpdated => throw _privateConstructorUsedError; // ISO
  int get best => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;

  /// Serializes this StreakState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StreakState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StreakStateCopyWith<StreakState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StreakStateCopyWith<$Res> {
  factory $StreakStateCopyWith(
          StreakState value, $Res Function(StreakState) then) =
      _$StreakStateCopyWithImpl<$Res, StreakState>;
  @useResult
  $Res call(
      {String streakId,
      String type,
      int length,
      String? lastUpdated,
      int best,
      bool active});
}

/// @nodoc
class _$StreakStateCopyWithImpl<$Res, $Val extends StreakState>
    implements $StreakStateCopyWith<$Res> {
  _$StreakStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StreakState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? streakId = null,
    Object? type = null,
    Object? length = null,
    Object? lastUpdated = freezed,
    Object? best = null,
    Object? active = null,
  }) {
    return _then(_value.copyWith(
      streakId: null == streakId
          ? _value.streakId
          : streakId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as String?,
      best: null == best
          ? _value.best
          : best // ignore: cast_nullable_to_non_nullable
              as int,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StreakStateImplCopyWith<$Res>
    implements $StreakStateCopyWith<$Res> {
  factory _$$StreakStateImplCopyWith(
          _$StreakStateImpl value, $Res Function(_$StreakStateImpl) then) =
      __$$StreakStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String streakId,
      String type,
      int length,
      String? lastUpdated,
      int best,
      bool active});
}

/// @nodoc
class __$$StreakStateImplCopyWithImpl<$Res>
    extends _$StreakStateCopyWithImpl<$Res, _$StreakStateImpl>
    implements _$$StreakStateImplCopyWith<$Res> {
  __$$StreakStateImplCopyWithImpl(
      _$StreakStateImpl _value, $Res Function(_$StreakStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of StreakState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? streakId = null,
    Object? type = null,
    Object? length = null,
    Object? lastUpdated = freezed,
    Object? best = null,
    Object? active = null,
  }) {
    return _then(_$StreakStateImpl(
      streakId: null == streakId
          ? _value.streakId
          : streakId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as String?,
      best: null == best
          ? _value.best
          : best // ignore: cast_nullable_to_non_nullable
              as int,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StreakStateImpl implements _StreakState {
  const _$StreakStateImpl(
      {required this.streakId,
      required this.type,
      required this.length,
      this.lastUpdated,
      required this.best,
      required this.active});

  factory _$StreakStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$StreakStateImplFromJson(json);

  @override
  final String streakId;
  @override
  final String type;
// 'daily' | 'weekly' | 'habit'
  @override
  final int length;
  @override
  final String? lastUpdated;
// ISO
  @override
  final int best;
  @override
  final bool active;

  @override
  String toString() {
    return 'StreakState(streakId: $streakId, type: $type, length: $length, lastUpdated: $lastUpdated, best: $best, active: $active)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StreakStateImpl &&
            (identical(other.streakId, streakId) ||
                other.streakId == streakId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.length, length) || other.length == length) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.best, best) || other.best == best) &&
            (identical(other.active, active) || other.active == active));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, streakId, type, length, lastUpdated, best, active);

  /// Create a copy of StreakState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StreakStateImplCopyWith<_$StreakStateImpl> get copyWith =>
      __$$StreakStateImplCopyWithImpl<_$StreakStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StreakStateImplToJson(
      this,
    );
  }
}

abstract class _StreakState implements StreakState {
  const factory _StreakState(
      {required final String streakId,
      required final String type,
      required final int length,
      final String? lastUpdated,
      required final int best,
      required final bool active}) = _$StreakStateImpl;

  factory _StreakState.fromJson(Map<String, dynamic> json) =
      _$StreakStateImpl.fromJson;

  @override
  String get streakId;
  @override
  String get type; // 'daily' | 'weekly' | 'habit'
  @override
  int get length;
  @override
  String? get lastUpdated; // ISO
  @override
  int get best;
  @override
  bool get active;

  /// Create a copy of StreakState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StreakStateImplCopyWith<_$StreakStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
