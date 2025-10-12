import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_model.freezed.dart';
part 'event_model.g.dart';

@freezed
class EventModel with _$EventModel {
  const factory EventModel({
    required String id,
    required String type,
    required String source,
    required DateTime timestamp,
    required Map<String, dynamic> meta,
    String? userId,
  }) = _EventModel;

  factory EventModel.fromJson(Map<String, dynamic> json) => _$EventModelFromJson(json);

  factory EventModel.goalCompleted({
    required String source,
    required String goalId,
    required int points,
    String? userId,
  }) {
    return EventModel(
      id: '${DateTime.now().millisecondsSinceEpoch}_${source}_$goalId',
      type: 'goal_completed',
      source: source,
      timestamp: DateTime.now(),
      meta: {
        'goalId': goalId,
        'points': points,
      },
      userId: userId,
    );
  }

  factory EventModel.streakUpdated({
    required String streakId,
    required int length,
    required int best,
    String? userId,
  }) {
    return EventModel(
      id: '${DateTime.now().millisecondsSinceEpoch}_streak_$streakId',
      type: 'streak_updated',
      source: 'streaks',
      timestamp: DateTime.now(),
      meta: {
        'streakId': streakId,
        'length': length,
        'best': best,
      },
      userId: userId,
    );
  }

  factory EventModel.achievementUnlocked({
    required String achievementId,
    required String title,
    required String description,
    required int reward,
    String? userId,
  }) {
    return EventModel(
      id: '${DateTime.now().millisecondsSinceEpoch}_achievement_$achievementId',
      type: 'achievement_unlocked',
      source: 'achievements',
      timestamp: DateTime.now(),
      meta: {
        'achievementId': achievementId,
        'title': title,
        'description': description,
        'reward': reward,
      },
      userId: userId,
    );
  }
}
