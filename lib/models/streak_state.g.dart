// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streak_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StreakStateImpl _$$StreakStateImplFromJson(Map<String, dynamic> json) =>
    _$StreakStateImpl(
      current: (json['current'] as num).toInt(),
      best: (json['best'] as num).toInt(),
      isActive: json['isActive'] as bool? ?? true,
      startDate: DateTime.parse(json['startDate'] as String),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$StreakStateImplToJson(_$StreakStateImpl instance) =>
    <String, dynamic>{
      'current': instance.current,
      'best': instance.best,
      'isActive': instance.isActive,
      'startDate': instance.startDate.toIso8601String(),
      'lastUpdated': instance.lastUpdated.toIso8601String(),
    };
