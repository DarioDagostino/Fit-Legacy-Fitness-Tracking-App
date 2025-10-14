import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Pixel-perfect spacing system using 8pt grid
/// All spacing values are responsive and maintain consistent proportions
class AppSpacing {
  AppSpacing._();

  // Base spacing unit (8pt grid system)
  static double get unit => 8.w;

  // Micro spacing
  static double get xs => 4.w;     // 0.5 * unit
  static double get sm => 8.w;     // 1 * unit
  static double get md => 16.w;    // 2 * unit
  static double get lg => 24.w;    // 3 * unit
  static double get xl => 32.w;    // 4 * unit
  static double get xxl => 40.w;   // 5 * unit
  static double get xxxl => 48.w;  // 6 * unit

  // Semantic spacing for common UI elements
  static double get paddingScreen => 20.w;
  static double get paddingCard => 16.w;
  static double get paddingButton => 16.w;
  static double get marginSection => 24.w;
  static double get marginCard => 12.w;
  static double get marginElement => 8.w;

  // Icon spacing
  static double get iconSmall => 16.w;
  static double get iconMedium => 24.w;
  static double get iconLarge => 32.w;
  static double get iconXLarge => 40.w;

  // Border radius with pixel-perfect scaling
  static double get radiusSmall => 4.r;
  static double get radiusMedium => 8.r;
  static double get radiusLarge => 12.r;
  static double get radiusXLarge => 16.r;
  static double get radiusCircular => 24.r;

  // Component-specific heights
  static double get buttonHeightSmall => 36.h;
  static double get buttonHeightMedium => 44.h;
  static double get buttonHeightLarge => 52.h;
  
  static double get inputHeight => 48.h;
  static double get cardMinHeight => 80.h;
  static double get appBarHeight => 56.h;
  static double get bottomNavHeight => 80.h;

  // Fitness app specific spacing
  static double get metricCardPadding => 20.w;
  static double get stepCounterMargin => 32.w;
  static double get progressBarHeight => 8.h;
  static double get achievementCardSpacing => 16.w;
  
  // Additional aliases for component compatibility
  static double get radiusCard => radiusMedium;
  static double get marginXs => xs;
}