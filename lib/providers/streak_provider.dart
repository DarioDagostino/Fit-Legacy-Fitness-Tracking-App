import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Provider para el sistema de rachas
final streakProvider = StateNotifierProvider<StreakNotifier, StreakState>((ref) {
  return StreakNotifier();
});

// Provider para la racha actual
final currentStreakProvider = Provider<int>((ref) {
  return ref.watch(streakProvider.select((state) => state.currentStreak));
});

// Provider para la racha más larga
final longestStreakProvider = Provider<int>((ref) {
  return ref.watch(streakProvider.select((state) => state.longestStreak));
});

// Provider para los días de la semana
final weeklyStreakProvider = Provider<List<StreakDay>>((ref) {
  return ref.watch(streakProvider.select((state) => state.weeklyStreak));
});

class StreakState {
  final int currentStreak;
  final int longestStreak;
  final List<StreakDay> weeklyStreak;
  final DateTime lastActivityDate;
  final bool isActiveToday;
  final int totalDays;

  const StreakState({
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.weeklyStreak = const [],
    required this.lastActivityDate,
    this.isActiveToday = false,
    this.totalDays = 0,
  });

  StreakState copyWith({
    int? currentStreak,
    int? longestStreak,
    List<StreakDay>? weeklyStreak,
    DateTime? lastActivityDate,
    bool? isActiveToday,
    int? totalDays,
  }) {
    return StreakState(
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      weeklyStreak: weeklyStreak ?? this.weeklyStreak,
      lastActivityDate: lastActivityDate ?? this.lastActivityDate,
      isActiveToday: isActiveToday ?? this.isActiveToday,
      totalDays: totalDays ?? this.totalDays,
    );
  }
}

class StreakDay {
  final DateTime date;
  final bool isActive;
  final int steps;
  final double progress;

  const StreakDay({
    required this.date,
    required this.isActive,
    required this.steps,
    required this.progress,
  });

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'isActive': isActive,
    'steps': steps,
    'progress': progress,
  };

  factory StreakDay.fromJson(Map<String, dynamic> json) => StreakDay(
    date: DateTime.parse(json['date']),
    isActive: json['isActive'],
    steps: json['steps'],
    progress: json['progress'].toDouble(),
  );
}

class StreakNotifier extends StateNotifier<StreakState> {
  StreakNotifier() : super(StreakState(lastActivityDate: DateTime.now())) {
    _loadStreakData();
  }

  // Cargar datos de racha
  Future<void> _loadStreakData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      final currentStreak = prefs.getInt('current_streak') ?? 0;
      final longestStreak = prefs.getInt('longest_streak') ?? 0;
      final lastActivityStr = prefs.getString('last_activity_date');
      final weeklyStreakStr = prefs.getString('weekly_streak');
      final totalDays = prefs.getInt('total_days') ?? 0;
      
      final lastActivityDate = lastActivityStr != null 
          ? DateTime.parse(lastActivityStr)
          : DateTime.now();
      
      List<StreakDay> weeklyStreak = [];
      if (weeklyStreakStr != null) {
        final List<dynamic> jsonList = jsonDecode(weeklyStreakStr);
        weeklyStreak = jsonList.map((json) => StreakDay.fromJson(json)).toList();
      }
      
      // Verificar si ya se registró actividad hoy
      final today = DateTime.now();
      final isActiveToday = _isSameDay(lastActivityDate, today);
      
      state = state.copyWith(
        currentStreak: currentStreak,
        longestStreak: longestStreak,
        weeklyStreak: weeklyStreak,
        lastActivityDate: lastActivityDate,
        isActiveToday: isActiveToday,
        totalDays: totalDays,
      );
      
      // Actualizar racha semanal
      _updateWeeklyStreak();
    } catch (e) {
      // Error al cargar datos, usar valores por defecto
      state = StreakState(lastActivityDate: DateTime.now());
    }
  }

  // Registrar actividad del día
  Future<void> recordActivity(int steps, int goal) async {
    final today = DateTime.now();
    final progress = steps / goal;
    final isGoalReached = progress >= 1.0;
    
    // Si ya se registró actividad hoy, no hacer nada
    if (state.isActiveToday) return;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Actualizar racha actual
      int newCurrentStreak = state.currentStreak;
      int newLongestStreak = state.longestStreak;
      int newTotalDays = state.totalDays;
      
      if (isGoalReached) {
        // Meta alcanzada, incrementar racha
        newCurrentStreak++;
        newTotalDays++;
        
        if (newCurrentStreak > newLongestStreak) {
          newLongestStreak = newCurrentStreak;
        }
      } else {
        // Meta no alcanzada, resetear racha
        newCurrentStreak = 0;
      }
      
      // Guardar datos
      await prefs.setInt('current_streak', newCurrentStreak);
      await prefs.setInt('longest_streak', newLongestStreak);
      await prefs.setInt('total_days', newTotalDays);
      await prefs.setString('last_activity_date', today.toIso8601String());
      
      // Actualizar estado
      state = state.copyWith(
        currentStreak: newCurrentStreak,
        longestStreak: newLongestStreak,
        totalDays: newTotalDays,
        lastActivityDate: today,
        isActiveToday: true,
      );
      
      // Actualizar racha semanal
      _updateWeeklyStreak();
      
    } catch (e) {
      // Error al guardar datos
      print('Error al registrar actividad: $e');
    }
  }

  // Actualizar racha semanal
  void _updateWeeklyStreak() {
    final today = DateTime.now();
    final weeklyStreak = <StreakDay>[];
    
    // Generar los últimos 7 días
    for (int i = 6; i >= 0; i--) {
      final date = today.subtract(Duration(days: i));
      final isActive = _isSameDay(state.lastActivityDate, date) && state.isActiveToday;
      
      weeklyStreak.add(StreakDay(
        date: date,
        isActive: isActive,
        steps: isActive ? 10000 : 0, // Placeholder, debería venir de datos reales
        progress: isActive ? 1.0 : 0.0,
      ));
    }
    
    state = state.copyWith(weeklyStreak: weeklyStreak);
    
    // Guardar racha semanal
    _saveWeeklyStreak(weeklyStreak);
  }

  // Guardar racha semanal
  Future<void> _saveWeeklyStreak(List<StreakDay> weeklyStreak) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = weeklyStreak.map((day) => day.toJson()).toList();
      await prefs.setString('weekly_streak', jsonEncode(jsonList));
    } catch (e) {
      print('Error al guardar racha semanal: $e');
    }
  }

  // Verificar si dos fechas son el mismo día
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }

  // Resetear racha
  Future<void> resetStreak() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('current_streak');
      await prefs.remove('last_activity_date');
      await prefs.remove('weekly_streak');
      
      state = state.copyWith(
        currentStreak: 0,
        isActiveToday: false,
        weeklyStreak: [],
      );
    } catch (e) {
      print('Error al resetear racha: $e');
    }
  }

  // Obtener estadísticas
  Map<String, dynamic> getStats() {
    return {
      'currentStreak': state.currentStreak,
      'longestStreak': state.longestStreak,
      'totalDays': state.totalDays,
      'isActiveToday': state.isActiveToday,
      'lastActivityDate': state.lastActivityDate,
      'weeklyStreak': state.weeklyStreak.map((day) => day.toJson()).toList(),
    };
  }

  // Verificar si se puede registrar actividad hoy
  bool canRecordActivityToday() {
    return !state.isActiveToday;
  }

  // Obtener días consecutivos de la semana
  int getConsecutiveDaysThisWeek() {
    int consecutiveDays = 0;
    for (int i = state.weeklyStreak.length - 1; i >= 0; i--) {
      if (state.weeklyStreak[i].isActive) {
        consecutiveDays++;
      } else {
        break;
      }
    }
    return consecutiveDays;
  }
}
