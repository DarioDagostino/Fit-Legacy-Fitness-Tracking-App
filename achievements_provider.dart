import 'package:flutter/material.dart';
import 'package:fit_legacy/data/models/achievement_model.dart';
import 'package:fit_legacy/domain/entities/streak.dart';

class AchievementsProvider with ChangeNotifier {
  final Streak _streak = Streak(currentStreak: 5, longestStreak: 12);
  List<Achievement> _achievements = [];

  Streak get streak => _streak;
  List<Achievement> get achievements => _achievements;

  AchievementsProvider() {
    _loadMockData();
  }

  void _loadMockData() {
    _achievements = [
      Achievement(
          title: "Primer Paso",
          description: "Completaste tu primer nodo de entrenamiento.",
          icon: Icons.flag,
          dateEarned: DateTime.now().subtract(const Duration(days: 5))),
      Achievement(
          title: "Constancia de Hierro",
          description: "Mantuviste una racha de 3 días seguidos.",
          icon: Icons.local_fire_department,
          dateEarned: DateTime.now().subtract(const Duration(days: 2))),
      Achievement(
          title: "Maestro de la Reflexión",
          description: "Completaste tu primer nodo de reflexión.",
          icon: Icons.psychology,
          dateEarned: DateTime.now().subtract(const Duration(days: 1))),
    ];
    notifyListeners();
  }
}