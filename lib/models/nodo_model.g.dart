// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nodo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NodoModelImpl _$$NodoModelImplFromJson(Map<String, dynamic> json) =>
    _$NodoModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      isCompleted: json['isCompleted'] as bool,
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$NodoModelImplToJson(_$NodoModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isCompleted': instance.isCompleted,
      'data': instance.data,
    };
