import 'package:flutter/material.dart';

class AppColors {
  // Primary
  static const Color primary = Color(0xFF0F172A); // slate-900
  static const Color primaryVariant = Color(0xFF1E293B); // slate-800
  static const Color accent = Color(0xFFF59E0B); // amber-500 / gold accent

  // Backgrounds
  static const Color scaffoldBackground = Color(0xFF071024);
  static const Color surface = Color(0xFF0B1220);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF94A3B8);

  // Success / Error
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);

  // Gradients
  static const Gradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
  );

  static const Gradient accentGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFF59E0B), Color(0xFFB45309)],
  );
}
