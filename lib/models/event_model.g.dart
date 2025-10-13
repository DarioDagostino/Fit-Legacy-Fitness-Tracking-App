// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventModelImpl _$$EventModelImplFromJson(Map<String, dynamic> json) =>
    _$EventModelImpl(
      id: json['id'] as String,
      type: json['type'] as String,
      source: json['source'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      meta: json['meta'] as Map<String, dynamic>,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$$EventModelImplToJson(_$EventModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'source': instance.source,
      'timestamp': instance.timestamp.toIso8601String(),
      'meta': instance.meta,
      'userId': instance.userId,
    };
