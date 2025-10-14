import 'package:flutter/material.dart';

/// Pixel-perfect color system for Fit Legacy App
/// All colors are designed to work across different screen densities
class AppColors {
  // Prevent instantiation
  AppColors._();

  // Primary Brand Colors
  static const Color primary = Color(0xFF6C5CE7);
  static const Color primaryLight = Color(0xFF8B7ED8);
  static const Color primaryDark = Color(0xFF5A4FCF);
  static const Color primaryAccent = Color(0xFFE17055);

  // Background Colors
  static const Color background = Color(0xFFFDFDFD);
  static const Color backgroundDark = Color(0xFF0D1117);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF21262D);
  
  // Text Colors with proper contrast ratios
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);
  static const Color textTertiary = Color(0xFF95A5A6);
  static const Color textOnDark = Color(0xFFF8F9FA);
  
  // Fitness-specific Colors
  static const Color success = Color(0xFF00B894);
  static const Color warning = Color(0xFFFDAB3D);
  static const Color error = Color(0xFFE17055);
  static const Color info = Color(0xFF74B9FF);
  
  // Golden theme colors (from Figma design)
  static const Color golden = Color(0xFFD4AF37);
  static const Color goldenLight = Color(0xFFF9D249);
  static const Color goldenDark = Color(0xFFA88B4A);
  static const Color goldenAccent = Color(0xFFFFE066);
  
  // Gradient Colors for fitness elements
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryLight],
  );
  
  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [success, Color(0xFF55EFC4)],
  );
  
  static const LinearGradient warningGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [warning, Color(0xFFFFE066)],
  );
  
  static const LinearGradient goldenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [goldenDark, goldenLight],
  );

  // Shadow Colors for depth
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x33000000);
  static const Color shadowDark = Color(0x4D000000);
  
  // Border Colors
  static const Color border = Color(0xFFE8E8E8);
  static const Color borderFocus = Color(0xFF6C5CE7);
  
  // Card Colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF30363D);
  
  // Overlay Colors
  static const Color overlay = Color(0x80000000);
  static const Color overlayLight = Color(0x40000000);
  
  // Material Design 3 Colors
  static const Color secondary = Color(0xFF74B9FF);
  static const Color onSurface = Color(0xFF2D3436);
  static const Color onSurfaceVariant = Color(0xFF636E72);
  static const Color surfaceVariant = Color(0xFFF8F9FA);
  static const Color outline = Color(0xFFDDD6FE);
}