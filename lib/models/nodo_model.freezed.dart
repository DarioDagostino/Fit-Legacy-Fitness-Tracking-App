// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nodo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NodoModel _$NodoModelFromJson(Map<String, dynamic> json) {
  return _NodoModel.fromJson(json);
}

/// @nodoc
mixin _$NodoModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;

  /// Serializes this NodoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NodoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NodoModelCopyWith<NodoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NodoModelCopyWith<$Res> {
  factory $NodoModelCopyWith(NodoModel value, $Res Function(NodoModel) then) =
      _$NodoModelCopyWithImpl<$Res, NodoModel>;
  @useResult
  $Res call(
      {String id, String name, bool isCompleted, Map<String, dynamic>? data});
}

/// @nodoc
class _$NodoModelCopyWithImpl<$Res, $Val extends NodoModel>
    implements $NodoModelCopyWith<$Res> {
  _$NodoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NodoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isCompleted = null,
    Object? data = freezed,
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
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NodoModelImplCopyWith<$Res>
    implements $NodoModelCopyWith<$Res> {
  factory _$$NodoModelImplCopyWith(
          _$NodoModelImpl value, $Res Function(_$NodoModelImpl) then) =
      __$$NodoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String name, bool isCompleted, Map<String, dynamic>? data});
}

/// @nodoc
class __$$NodoModelImplCopyWithImpl<$Res>
    extends _$NodoModelCopyWithImpl<$Res, _$NodoModelImpl>
    implements _$$NodoModelImplCopyWith<$Res> {
  __$$NodoModelImplCopyWithImpl(
      _$NodoModelImpl _value, $Res Function(_$NodoModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of NodoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? isCompleted = null,
    Object? data = freezed,
  }) {
    return _then(_$NodoModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NodoModelImpl implements _NodoModel {
  const _$NodoModelImpl(
      {required this.id,
      required this.name,
      required this.isCompleted,
      final Map<String, dynamic>? data})
      : _data = data;

  factory _$NodoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NodoModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final bool isCompleted;
  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'NodoModel(id: $id, name: $name, isCompleted: $isCompleted, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NodoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, isCompleted,
      const DeepCollectionEquality().hash(_data));

  /// Create a copy of NodoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NodoModelImplCopyWith<_$NodoModelImpl> get copyWith =>
      __$$NodoModelImplCopyWithImpl<_$NodoModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NodoModelImplToJson(
      this,
    );
  }
}

abstract class _NodoModel implements NodoModel {
  const factory _NodoModel(
      {required final String id,
      required final String name,
      required final bool isCompleted,
      final Map<String, dynamic>? data}) = _$NodoModelImpl;

  factory _NodoModel.fromJson(Map<String, dynamic> json) =
      _$NodoModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  bool get isCompleted;
  @override
  Map<String, dynamic>? get data;

  /// Create a copy of NodoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NodoModelImplCopyWith<_$NodoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
