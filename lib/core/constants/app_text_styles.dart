import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Pixel-perfect typography system using ScreenUtil for consistent sizing
/// All text styles are responsive and maintain perfect pixel alignment
class AppTextStyles {
  AppTextStyles._();

  // Base text style with optimal font settings
  static TextStyle get _baseStyle => GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        letterSpacing: -0.01,
        height: 1.2,
      );

  // Heading Styles
  static TextStyle get h1 => _baseStyle.copyWith(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        height: 1.1,
        letterSpacing: -0.02,
      );

  static TextStyle get h2 => _baseStyle.copyWith(
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
        height: 1.15,
        letterSpacing: -0.015,
      );

  static TextStyle get h3 => _baseStyle.copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: -0.01,
      );

  static TextStyle get h4 => _baseStyle.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        height: 1.25,
      );

  static TextStyle get h5 => _baseStyle.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        height: 1.3,
      );

  static TextStyle get h6 => _baseStyle.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        height: 1.3,
      );

  // Body Text Styles
  static TextStyle get bodyLarge => _baseStyle.copyWith(
        fontSize: 16.sp,
        height: 1.5,
      );

  static TextStyle get bodyMedium => _baseStyle.copyWith(
        fontSize: 14.sp,
        height: 1.4,
      );

  static TextStyle get bodySmall => _baseStyle.copyWith(
        fontSize: 12.sp,
        height: 1.35,
        color: AppColors.textSecondary,
      );

  // Caption and Label Styles
  static TextStyle get caption => _baseStyle.copyWith(
        fontSize: 10.sp,
        height: 1.3,
        color: AppColors.textTertiary,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get label => _baseStyle.copyWith(
        fontSize: 11.sp,
        height: 1.3,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: AppColors.textSecondary,
      );

  // Button Text Styles
  static TextStyle get buttonLarge => _baseStyle.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: 0.1,
      );

  static TextStyle get buttonMedium => _baseStyle.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: 0.1,
      );

  static TextStyle get buttonSmall => _baseStyle.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        height: 1.2,
        letterSpacing: 0.2,
      );

  // Specialized Styles for Fitness App
  static TextStyle get stepCounter => GoogleFonts.robotoMono(
        fontSize: 48.sp,
        fontWeight: FontWeight.w700,
        height: 1.0,
        letterSpacing: -0.02,
        color: AppColors.primary,
      );

  static TextStyle get metricValue => GoogleFonts.robotoMono(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        height: 1.0,
        letterSpacing: -0.01,
        color: AppColors.textPrimary,
      );

  static TextStyle get metricLabel => _baseStyle.copyWith(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        height: 1.2,
        letterSpacing: 0.5,
        color: AppColors.textSecondary,
      );

  // Material Design 3 Text Styles
  static TextStyle get displaySmall => _baseStyle.copyWith(
        fontSize: 36.sp,
        fontWeight: FontWeight.w400,
        height: 1.22,
        letterSpacing: 0,
      );

  static TextStyle get headlineLarge => _baseStyle.copyWith(
        fontSize: 32.sp,
        fontWeight: FontWeight.w400,
        height: 1.25,
        letterSpacing: 0,
      );

  static TextStyle get headlineMedium => _baseStyle.copyWith(
        fontSize: 28.sp,
        fontWeight: FontWeight.w400,
        height: 1.29,
        letterSpacing: 0,
      );

  static TextStyle get headlineSmall => _baseStyle.copyWith(
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
        height: 1.33,
        letterSpacing: 0,
      );

  static TextStyle get titleLarge => _baseStyle.copyWith(
        fontSize: 22.sp,
        fontWeight: FontWeight.w400,
        height: 1.27,
        letterSpacing: 0,
      );

  static TextStyle get titleMedium => _baseStyle.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        height: 1.5,
        letterSpacing: 0.15,
      );

  static TextStyle get titleSmall => _baseStyle.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        height: 1.43,
        letterSpacing: 0.1,
      );

  static TextStyle get bodyXSmall => _baseStyle.copyWith(
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
        height: 1.45,
        letterSpacing: 0.5,
      );

  // Dark Theme Variants
  static TextStyle get h1Dark => h1.copyWith(color: AppColors.textOnDark);
  static TextStyle get h2Dark => h2.copyWith(color: AppColors.textOnDark);
  static TextStyle get h3Dark => h3.copyWith(color: AppColors.textOnDark);
  static TextStyle get h4Dark => h4.copyWith(color: AppColors.textOnDark);
  static TextStyle get h5Dark => h5.copyWith(color: AppColors.textOnDark);
  static TextStyle get h6Dark => h6.copyWith(color: AppColors.textOnDark);
  static TextStyle get bodyLargeDark => bodyLarge.copyWith(color: AppColors.textOnDark);
  static TextStyle get bodyMediumDark => bodyMedium.copyWith(color: AppColors.textOnDark);
}