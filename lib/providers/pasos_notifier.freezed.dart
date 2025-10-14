// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pasos_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PasosState {
  int get actuales => throw _privateConstructorUsedError;
  int get meta => throw _privateConstructorUsedError;
  int get rachaDiaria => throw _privateConstructorUsedError;
  int get rachaSemanal => throw _privateConstructorUsedError;
  bool get logroMensualCompleto => throw _privateConstructorUsedError;
  List<DayProgress> get progresoSemanal => throw _privateConstructorUsedError;

  /// Create a copy of PasosState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PasosStateCopyWith<PasosState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PasosStateCopyWith<$Res> {
  factory $PasosStateCopyWith(
          PasosState value, $Res Function(PasosState) then) =
      _$PasosStateCopyWithImpl<$Res, PasosState>;
  @useResult
  $Res call(
      {int actuales,
      int meta,
      int rachaDiaria,
      int rachaSemanal,
      bool logroMensualCompleto,
      List<DayProgress> progresoSemanal});
}

/// @nodoc
class _$PasosStateCopyWithImpl<$Res, $Val extends PasosState>
    implements $PasosStateCopyWith<$Res> {
  _$PasosStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PasosState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actuales = null,
    Object? meta = null,
    Object? rachaDiaria = null,
    Object? rachaSemanal = null,
    Object? logroMensualCompleto = null,
    Object? progresoSemanal = null,
  }) {
    return _then(_value.copyWith(
      actuales: null == actuales
          ? _value.actuales
          : actuales // ignore: cast_nullable_to_non_nullable
              as int,
      meta: null == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as int,
      rachaDiaria: null == rachaDiaria
          ? _value.rachaDiaria
          : rachaDiaria // ignore: cast_nullable_to_non_nullable
              as int,
      rachaSemanal: null == rachaSemanal
          ? _value.rachaSemanal
          : rachaSemanal // ignore: cast_nullable_to_non_nullable
              as int,
      logroMensualCompleto: null == logroMensualCompleto
          ? _value.logroMensualCompleto
          : logroMensualCompleto // ignore: cast_nullable_to_non_nullable
              as bool,
      progresoSemanal: null == progresoSemanal
          ? _value.progresoSemanal
          : progresoSemanal // ignore: cast_nullable_to_non_nullable
              as List<DayProgress>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PasosStateImplCopyWith<$Res>
    implements $PasosStateCopyWith<$Res> {
  factory _$$PasosStateImplCopyWith(
          _$PasosStateImpl value, $Res Function(_$PasosStateImpl) then) =
      __$$PasosStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int actuales,
      int meta,
      int rachaDiaria,
      int rachaSemanal,
      bool logroMensualCompleto,
      List<DayProgress> progresoSemanal});
}

/// @nodoc
class __$$PasosStateImplCopyWithImpl<$Res>
    extends _$PasosStateCopyWithImpl<$Res, _$PasosStateImpl>
    implements _$$PasosStateImplCopyWith<$Res> {
  __$$PasosStateImplCopyWithImpl(
      _$PasosStateImpl _value, $Res Function(_$PasosStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PasosState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actuales = null,
    Object? meta = null,
    Object? rachaDiaria = null,
    Object? rachaSemanal = null,
    Object? logroMensualCompleto = null,
    Object? progresoSemanal = null,
  }) {
    return _then(_$PasosStateImpl(
      actuales: null == actuales
          ? _value.actuales
          : actuales // ignore: cast_nullable_to_non_nullable
              as int,
      meta: null == meta
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as int,
      rachaDiaria: null == rachaDiaria
          ? _value.rachaDiaria
          : rachaDiaria // ignore: cast_nullable_to_non_nullable
              as int,
      rachaSemanal: null == rachaSemanal
          ? _value.rachaSemanal
          : rachaSemanal // ignore: cast_nullable_to_non_nullable
              as int,
      logroMensualCompleto: null == logroMensualCompleto
          ? _value.logroMensualCompleto
          : logroMensualCompleto // ignore: cast_nullable_to_non_nullable
              as bool,
      progresoSemanal: null == progresoSemanal
          ? _value._progresoSemanal
          : progresoSemanal // ignore: cast_nullable_to_non_nullable
              as List<DayProgress>,
    ));
  }
}

/// @nodoc

class _$PasosStateImpl implements _PasosState {
  const _$PasosStateImpl(
      {this.actuales = 0,
      this.meta = 10000,
      this.rachaDiaria = 0,
      this.rachaSemanal = 0,
      this.logroMensualCompleto = false,
      final List<DayProgress> progresoSemanal = const []})
      : _progresoSemanal = progresoSemanal;

  @override
  @JsonKey()
  final int actuales;
  @override
  @JsonKey()
  final int meta;
  @override
  @JsonKey()
  final int rachaDiaria;
  @override
  @JsonKey()
  final int rachaSemanal;
  @override
  @JsonKey()
  final bool logroMensualCompleto;
  final List<DayProgress> _progresoSemanal;
  @override
  @JsonKey()
  List<DayProgress> get progresoSemanal {
    if (_progresoSemanal is EqualUnmodifiableListView) return _progresoSemanal;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_progresoSemanal);
  }

  @override
  String toString() {
    return 'PasosState(actuales: $actuales, meta: $meta, rachaDiaria: $rachaDiaria, rachaSemanal: $rachaSemanal, logroMensualCompleto: $logroMensualCompleto, progresoSemanal: $progresoSemanal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasosStateImpl &&
            (identical(other.actuales, actuales) ||
                other.actuales == actuales) &&
            (identical(other.meta, meta) || other.meta == meta) &&
            (identical(other.rachaDiaria, rachaDiaria) ||
                other.rachaDiaria == rachaDiaria) &&
            (identical(other.rachaSemanal, rachaSemanal) ||
                other.rachaSemanal == rachaSemanal) &&
            (identical(other.logroMensualCompleto, logroMensualCompleto) ||
                other.logroMensualCompleto == logroMensualCompleto) &&
            const DeepCollectionEquality()
                .equals(other._progresoSemanal, _progresoSemanal));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      actuales,
      meta,
      rachaDiaria,
      rachaSemanal,
      logroMensualCompleto,
      const DeepCollectionEquality().hash(_progresoSemanal));

  /// Create a copy of PasosState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PasosStateImplCopyWith<_$PasosStateImpl> get copyWith =>
      __$$PasosStateImplCopyWithImpl<_$PasosStateImpl>(this, _$identity);
}

abstract class _PasosState implements PasosState {
  const factory _PasosState(
      {final int actuales,
      final int meta,
      final int rachaDiaria,
      final int rachaSemanal,
      final bool logroMensualCompleto,
      final List<DayProgress> progresoSemanal}) = _$PasosStateImpl;

  @override
  int get actuales;
  @override
  int get meta;
  @override
  int get rachaDiaria;
  @override
  int get rachaSemanal;
  @override
  bool get logroMensualCompleto;
  @override
  List<DayProgress> get progresoSemanal;

  /// Create a copy of PasosState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PasosStateImplCopyWith<_$PasosStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DayProgress {
  String get day => throw _privateConstructorUsedError;
  int get steps => throw _privateConstructorUsedError;
  bool get goalCompleted => throw _privateConstructorUsedError;

  /// Create a copy of DayProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DayProgressCopyWith<DayProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DayProgressCopyWith<$Res> {
  factory $DayProgressCopyWith(
          DayProgress value, $Res Function(DayProgress) then) =
      _$DayProgressCopyWithImpl<$Res, DayProgress>;
  @useResult
  $Res call({String day, int steps, bool goalCompleted});
}

/// @nodoc
class _$DayProgressCopyWithImpl<$Res, $Val extends DayProgress>
    implements $DayProgressCopyWith<$Res> {
  _$DayProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DayProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? steps = null,
    Object? goalCompleted = null,
  }) {
    return _then(_value.copyWith(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int,
      goalCompleted: null == goalCompleted
          ? _value.goalCompleted
          : goalCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DayProgressImplCopyWith<$Res>
    implements $DayProgressCopyWith<$Res> {
  factory _$$DayProgressImplCopyWith(
          _$DayProgressImpl value, $Res Function(_$DayProgressImpl) then) =
      __$$DayProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String day, int steps, bool goalCompleted});
}

/// @nodoc
class __$$DayProgressImplCopyWithImpl<$Res>
    extends _$DayProgressCopyWithImpl<$Res, _$DayProgressImpl>
    implements _$$DayProgressImplCopyWith<$Res> {
  __$$DayProgressImplCopyWithImpl(
      _$DayProgressImpl _value, $Res Function(_$DayProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of DayProgress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? day = null,
    Object? steps = null,
    Object? goalCompleted = null,
  }) {
    return _then(_$DayProgressImpl(
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as String,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int,
      goalCompleted: null == goalCompleted
          ? _value.goalCompleted
          : goalCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$DayProgressImpl implements _DayProgress {
  const _$DayProgressImpl(
      {required this.day, required this.steps, required this.goalCompleted});

  @override
  final String day;
  @override
  final int steps;
  @override
  final bool goalCompleted;

  @override
  String toString() {
    return 'DayProgress(day: $day, steps: $steps, goalCompleted: $goalCompleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DayProgressImpl &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.steps, steps) || other.steps == steps) &&
            (identical(other.goalCompleted, goalCompleted) ||
                other.goalCompleted == goalCompleted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, day, steps, goalCompleted);

  /// Create a copy of DayProgress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DayProgressImplCopyWith<_$DayProgressImpl> get copyWith =>
      __$$DayProgressImplCopyWithImpl<_$DayProgressImpl>(this, _$identity);
}

abstract class _DayProgress implements DayProgress {
  const factory _DayProgress(
      {required final String day,
      required final int steps,
      required final bool goalCompleted}) = _$DayProgressImpl;

  @override
  String get day;
  @override
  int get steps;
  @override
  bool get goalCompleted;

  /// Create a copy of DayProgress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DayProgressImplCopyWith<_$DayProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
