// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

part of 'nodo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

NodoModel _$NodoModelFromJson(Map<String, dynamic> json) {
  return _NodoModel.fromJson(json);
}

/// @nodoc
mixin _$NodoModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NodoModelCopyWith<NodoModel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NodoModelCopyWith<$Res> {
  factory $NodoModelCopyWith(NodoModel value, $Res Function(NodoModel) then) = _$NodoModelCopyWithImpl<$Res, NodoModel>;
  $Res call({String id, String title, String description});
}

/// @nodoc
class _$NodoModelCopyWithImpl<$Res, $Val extends NodoModel> implements $NodoModelCopyWith<$Res> {
  _$NodoModelCopyWithImpl(this._value, this._then);

  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      id: id == null ? _value.id : id as String,
      title: title == null ? _value.title : title as String,
      description: description == null ? _value.description : description as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NodoModelCopyWith<$Res> implements $NodoModelCopyWith<$Res> {
  factory _$$_NodoModelCopyWith(_$_NodoModel value, $Res Function(_$_NodoModel) then) = __$$_NodoModelCopyWithImpl<$Res>;
  @override
  $Res call({String id, String title, String description});
}

/// @nodoc
class __$$_NodoModelCopyWithImpl<$Res> extends _$NodoModelCopyWithImpl<$Res, _$_NodoModel> implements _$$_NodoModelCopyWith<$Res> {
  __$$_NodoModelCopyWithImpl(_$_NodoModel _value, $Res Function(_$_NodoModel) _then)
      : super(_value, _then);

  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
  }) {
    return _then(_$_NodoModel(
      id: id == null ? _value.id : id as String,
      title: title == null ? _value.title : title as String,
      description: description == null ? _value.description : description as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NodoModel implements _NodoModel {
  const _$_NodoModel({required this.id, required this.title, required this.description});

  factory _$_NodoModel.fromJson(Map<String, dynamic> json) => _$$_NodoModelFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;

  @override
  String toString() {
    return 'NodoModel(id: $id, title: $title, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NodoModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) || other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, description);

  @JsonKey(ignore: true)
  @override
  _$$_NodoModelCopyWith<_$_NodoModel> get copyWith => __$$_NodoModelCopyWithImpl<_$_NodoModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NodoModelToJson(this);
  }
}

abstract class _NodoModel implements NodoModel {
  const factory _NodoModel({required final String id, required final String title, required final String description}) = _$_NodoModel;

  factory _NodoModel.fromJson(Map<String, dynamic> json) = _$_NodoModel.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$_NodoModelCopyWith<_$_NodoModel> get copyWith => throw _privateConstructorUsedError;
}
