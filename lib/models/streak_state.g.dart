// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streak_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StreakStateImpl _$$StreakStateImplFromJson(Map<String, dynamic> json) =>
    _$StreakStateImpl(
      streakId: json['streakId'] as String,
      type: json['type'] as String,
      length: (json['length'] as num).toInt(),
      lastUpdated: json['lastUpdated'] as String?,
      best: (json['best'] as num).toInt(),
      active: json['active'] as bool,
    );

Map<String, dynamic> _$$StreakStateImplToJson(_$StreakStateImpl instance) =>
    <String, dynamic>{
      'streakId': instance.streakId,
      'type': instance.type,
      'length': instance.length,
      'lastUpdated': instance.lastUpdated,
      'best': instance.best,
      'active': instance.active,
    };
