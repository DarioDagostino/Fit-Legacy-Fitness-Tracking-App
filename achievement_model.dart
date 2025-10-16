import 'package:flutter/widgets.dart';

class Achievement {
  final String title;
  final String description;
  final IconData icon;
  final DateTime dateEarned;

  Achievement({
    required this.title,
    required this.description,
    required this.icon,
    required this.dateEarned,
  });
}