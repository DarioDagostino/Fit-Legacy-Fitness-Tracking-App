import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_fitness_data.freezed.dart';
part 'user_fitness_data.g.dart';

@freezed
class UserFitnessData with _$UserFitnessData {
  const factory UserFitnessData({
    required String uid,
    required String displayName,
    required String email,
    required DateTime createdAt,
    required int dailyStepGoal,
    required int currentStreak,
    required int bestStreak,
    required int totalSteps,
    required List<String> achievements,
    @Default({}) Map<String, int> dailySteps, // date -> steps
    @Default({}) Map<String, dynamic> preferences,
    DateTime? lastUpdated,
  }) = _UserFitnessData;

  factory UserFitnessData.fromJson(Map<String, dynamic> json) =>
      _$UserFitnessDataFromJson(json);
}

@freezed
class DailyStepRecord with _$DailyStepRecord {
  const factory DailyStepRecord({
    required String date,
    required int steps,
    required bool goalReached,
    required DateTime timestamp,
  }) = _DailyStepRecord;

  factory DailyStepRecord.fromJson(Map<String, dynamic> json) =>
      _$DailyStepRecordFromJson(json);
}

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String uid,
    required String displayName,
    required String email,
    String? photoUrl,
    required DateTime joinDate,
    @Default(25) int age,
    @Default(170) int height, // cm
    @Default(70) int weight, // kg
    @Default('metric') String units, // metric or imperial
    @Default(10000) int dailyStepGoal,
    @Default([]) List<String> fitnessGoals,
    @Default('beginner') String fitnessLevel,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}