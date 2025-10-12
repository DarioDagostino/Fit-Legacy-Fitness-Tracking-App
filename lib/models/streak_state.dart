import 'package:freezed_annotation/freezed_annotation.dart';

part 'streak_state.freezed.dart';
part 'streak_state.g.dart';

@freezed
class StreakState with _$StreakState {
  const factory StreakState({
    required String streakId,
    required String type, // 'daily' | 'weekly' | 'habit'
    required int length,
    String? lastUpdated, // ISO
    required int best,
    required bool active,
  }) = _StreakState;

  factory StreakState.fromJson(Map<String, dynamic> json) => _$StreakStateFromJson(json);
}
