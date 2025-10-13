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
  $Res call({int actuales, int meta, int rachaDiaria});
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
  $Res call({int actuales, int meta, int rachaDiaria});
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
    ));
  }
}

/// @nodoc

class _$PasosStateImpl implements _PasosState {
  const _$PasosStateImpl(
      {this.actuales = 0, this.meta = 10000, this.rachaDiaria = 0});

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
  String toString() {
    return 'PasosState(actuales: $actuales, meta: $meta, rachaDiaria: $rachaDiaria)';
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
                other.rachaDiaria == rachaDiaria));
  }

  @override
  int get hashCode => Object.hash(runtimeType, actuales, meta, rachaDiaria);

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
      final int rachaDiaria}) = _$PasosStateImpl;

  @override
  int get actuales;
  @override
  int get meta;
  @override
  int get rachaDiaria;

  /// Create a copy of PasosState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PasosStateImplCopyWith<_$PasosStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
