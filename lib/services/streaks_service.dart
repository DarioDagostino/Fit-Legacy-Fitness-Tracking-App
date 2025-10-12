import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/streak_state.dart';
import '../models/achievement.dart';
import '../utils/logger.dart';

class StreaksService {
  static const _streakKey = 'streaks_v1';
  static const _achKey = 'achievements_v1';
  static const _maxRetries = 3;

  // Cache para optimizar rendimiento
  List<StreakState>? _streaksCache;
  List<Achievement>? _achievementsCache;
  DateTime? _lastCacheUpdate;

  Future<List<StreakState>> loadAll() async {
    try {
      // Usar cache si está disponible y es reciente (menos de 5 minutos)
      if (_streaksCache != null && 
          _lastCacheUpdate != null && 
          DateTime.now().difference(_lastCacheUpdate!).inMinutes < 5) {
        return _streaksCache!;
      }

      final prefs = await SharedPreferences.getInstance();
      final list = prefs.getStringList(_streakKey) ?? [];
      
      final streaks = <StreakState>[];
      for (final item in list) {
        try {
          final json = jsonDecode(item) as Map<String, dynamic>;
          streaks.add(StreakState.fromJson(json));
        } catch (e) {
          // Log error but continue processing other items
          StreaksLogger.error('Error parsing streak: $e', error: e);
        }
      }

      _streaksCache = streaks;
      _lastCacheUpdate = DateTime.now();
      return streaks;
    } catch (e) {
      StreaksLogger.error('Error loading streaks: $e', error: e);
      return [];
    }
  }

  Future<void> saveAll(List<StreakState> states) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final list = states.map((s) => jsonEncode(s.toJson())).toList();
      await prefs.setStringList(_streakKey, list);
      
      // Actualizar cache
      _streaksCache = List.from(states);
      _lastCacheUpdate = DateTime.now();
    } catch (e) {
      StreaksLogger.error('Error saving streaks: $e', error: e);
      rethrow;
    }
  }

  Future<List<Achievement>> loadAchievements() async {
    try {
      // Usar cache si está disponible
      if (_achievementsCache != null && 
          _lastCacheUpdate != null && 
          DateTime.now().difference(_lastCacheUpdate!).inMinutes < 5) {
        return _achievementsCache!;
      }

      final prefs = await SharedPreferences.getInstance();
      final list = prefs.getStringList(_achKey) ?? [];
      
      final achievements = <Achievement>[];
      for (final item in list) {
        try {
          final json = jsonDecode(item) as Map<String, dynamic>;
          achievements.add(Achievement.fromJson(json));
        } catch (e) {
          print('Error parsing achievement: $e');
        }
      }

      _achievementsCache = achievements;
      _lastCacheUpdate = DateTime.now();
      return achievements;
    } catch (e) {
      print('Error loading achievements: $e');
      return [];
    }
  }

  Future<void> addAchievement(Achievement achievement) async {
    try {
      final achievements = await loadAchievements();
      achievements.add(achievement);
      
      final prefs = await SharedPreferences.getInstance();
      final list = achievements.map((a) => jsonEncode(a.toJson())).toList();
      await prefs.setStringList(_achKey, list);
      
      // Actualizar cache
      _achievementsCache = achievements;
      _lastCacheUpdate = DateTime.now();
    } catch (e) {
      print('Error adding achievement: $e');
      rethrow;
    }
  }

  Future<StreakState> processGoalCompleted({
    required String type, 
    required String goalId, 
    required DateTime timestamp,
    String? userId,
  }) async {
    try {
      final states = await loadAll();
      
      // Buscar o crear streak diario
      StreakState daily = states.firstWhere(
        (s) => s.streakId == 'daily_default', 
        orElse: () => const StreakState(
          streakId: 'daily_default', 
          type: 'daily', 
          length: 0, 
          lastUpdated: null, 
          best: 0, 
          active: true
        )
      );

      final last = daily.lastUpdated == null ? null : DateTime.parse(daily.lastUpdated!);
      final now = timestamp.toUtc();
      final daysSince = last == null ? 999 : now.difference(last).inDays;

      StreakState updatedDaily;
      
      if (last == null || daysSince > 1) {
        // Nueva racha
        updatedDaily = daily.copyWith(
          length: 1, 
          lastUpdated: now.toIso8601String()
        );
      } else if (daysSince == 1) {
        // Continuar racha
        final newLength = daily.length + 1;
        updatedDaily = daily.copyWith(
          length: newLength,
          lastUpdated: now.toIso8601String(),
          best: newLength > daily.best ? newLength : daily.best
        );
      } else {
        // Mismo día - no cambiar longitud de racha
        updatedDaily = daily.copyWith(lastUpdated: now.toIso8601String());
      }

      // Guardar cambios
      states.removeWhere((s) => s.streakId == updatedDaily.streakId);
      states.add(updatedDaily);
      await saveAll(states);

      // Verificar logros
      await _checkMilestones(updatedDaily, now, userId);

      return updatedDaily;
    } catch (e) {
      print('Error processing goal completion: $e');
      rethrow;
    }
  }

  Future<void> _checkMilestones(StreakState streak, DateTime timestamp, String? userId) async {
    try {
      final milestones = [
        {'days': 3, 'id': 'streak_3', 'title': 'Primera semana', 'description': 'Tres días de constancia', 'reward': 25},
        {'days': 7, 'id': 'streak_7', 'title': 'Una semana completa', 'description': 'Siete días de constancia', 'reward': 50},
        {'days': 14, 'id': 'streak_14', 'title': 'Dos semanas', 'description': 'Catorce días de constancia', 'reward': 100},
        {'days': 30, 'id': 'streak_30', 'title': 'Un mes', 'description': 'Treinta días de constancia', 'reward': 250},
        {'days': 100, 'id': 'streak_100', 'title': 'Centenario', 'description': 'Cien días de constancia', 'reward': 500},
      ];

      for (final milestone in milestones) {
        if (streak.length == milestone['days'] as int) {
          final achievement = Achievement(
            id: milestone['id'] as String,
            title: milestone['title'] as String,
            description: milestone['description'] as String,
            date: timestamp.toIso8601String(),
            reward: milestone['reward'] as int,
            metadata: {'streakLength': streak.length, 'userId': userId},
          );
          
          await addAchievement(achievement);
          break; // Solo un logro por vez
        }
      }
    } catch (e) {
      print('Error checking milestones: $e');
    }
  }

  // Método para limpiar cache si es necesario
  void clearCache() {
    _streaksCache = null;
    _achievementsCache = null;
    _lastCacheUpdate = null;
  }
}
