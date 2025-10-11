import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/streak_state.dart';
import '../models/achievement.dart';

class StreaksService {
  static const _streakKey = 'streaks_v1';
  static const _achKey = 'achievements_v1';

  Future<List<StreakState>> loadAll() async{
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_streakKey) ?? [];
    return list.map((e) => StreakState.fromJson(jsonDecode(e))).toList();
  }

  Future<void> saveAll(List<StreakState> states) async{
    final prefs = await SharedPreferences.getInstance();
    final list = states.map((s) => jsonEncode(s.toJson())).toList();
    await prefs.setStringList(_streakKey, list);
  }

  Future<List<Achievement>> loadAchievements() async{
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_achKey) ?? [];
    return list.map((e) => Achievement.fromJson(jsonDecode(e))).toList();
  }

  Future<void> addAchievement(Achievement a) async{
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_achKey) ?? [];
    list.add(a.toRawJson());
    await prefs.setStringList(_achKey, list);
  }

  Future<void> processGoalCompleted({required String type, required String goalId, required DateTime timestamp}) async{
    // Load current streaks
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_streakKey) ?? [];
    List<StreakState> states = list.map((e) => StreakState.fromJson(jsonDecode(e))).toList();

    // For simplicity, we use a single daily streak id per user per app: 'daily_default'
    StreakState? daily = states.firstWhere((s) => s.streakId == 'daily_default', orElse: () => StreakState(streakId: 'daily_default', type: 'daily', length: 0, lastUpdated: null, best: 0, active: true));

    final last = daily.lastUpdated == null ? null : DateTime.parse(daily.lastUpdated!);
    final now = timestamp.toUtc();
    final daysSince = last == null ? 999 : now.difference(last).inDays;

    if (last == null || daysSince > 1) {
      // new streak
      daily = daily.copyWith(length: 1, lastUpdated: now.toIso8601String());
    } else if (daysSince == 1) {
      daily = daily.copyWith(length: daily.length + 1, lastUpdated: now.toIso8601String(), best: daily.length + 1 > daily.best ? daily.length + 1 : daily.best);
    } else {
      // same day completion doesn't change streak length
      daily = daily.copyWith(lastUpdated: now.toIso8601String());
    }

    // persist
    states.removeWhere((s) => s.streakId == daily!.streakId);
    states.add(daily);
    final encoded = states.map((s) => jsonEncode(s.toJson())).toList();
    await prefs.setStringList(_streakKey, encoded);

    // if milestone reached, add achievement
    if (daily.length == 7) {
      final ach = Achievement(id: 'streak_7', title: '7-day streak', description: 'Siete días de constancia', date: now.toIso8601String(), reward: 50);
      await addAchievement(ach);
    }
  }
}
