import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../core/constants/app_colors.dart';

/// Pixel-perfect spacing widget using the 8pt grid system
/// Automatically scales based on screen density
class AppGap extends StatelessWidget {
  final double size;
  final bool isHorizontal;

  const AppGap._(this.size, {this.isHorizontal = false});

  // Vertical gaps
  const AppGap.xs() : this._(4);
  const AppGap.sm() : this._(8);
  const AppGap.md() : this._(16);
  const AppGap.lg() : this._(24);
  const AppGap.xl() : this._(32);
  const AppGap.xxl() : this._(40);
  const AppGap.xxxl() : this._(48);

  // Horizontal gaps
  const AppGap.horizontalXs() : this._(4, isHorizontal: true);
  const AppGap.horizontalSm() : this._(8, isHorizontal: true);
  const AppGap.horizontalMd() : this._(16, isHorizontal: true);
  const AppGap.horizontalLg() : this._(24, isHorizontal: true);
  const AppGap.horizontalXl() : this._(32, isHorizontal: true);
  const AppGap.horizontalXxl() : this._(40, isHorizontal: true);
  const AppGap.horizontalXxxl() : this._(48, isHorizontal: true);

  // Custom size gap
  const AppGap.custom(this.size, {this.isHorizontal = false});

  @override
  Widget build(BuildContext context) {
    if (isHorizontal) {
      return Gap(size.w);
    }
    return Gap(size.h);
  }
}

/// Pixel-perfect container with consistent styling
class AppContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double? borderRadius;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final double? width;
  final double? height;

  const AppContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width?.w,
      height: height?.h,
      margin: margin,
      padding: padding ?? EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(borderRadius?.r ?? 12.r),
        border: border,
        boxShadow: boxShadow ?? [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Pixel-perfect responsive row with consistent spacing
class AppRow extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double spacing;

  const AppRow({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: children
          .expand((widget) => [widget, AppGap.custom(spacing, isHorizontal: true)])
          .toList()
        ..removeLast(), // Remove the last gap
    );
  }
}

/// Pixel-perfect responsive column with consistent spacing
class AppColumn extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double spacing;

  const AppColumn({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: children
          .expand((widget) => [widget, AppGap.custom(spacing)])
          .toList()
        ..removeLast(), // Remove the last gap
    );
  }
}

/// Pixel-perfect card widget with Material Design 3 styling
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double? elevation;
  final VoidCallback? onTap;
  final BorderRadiusGeometry? borderRadius;
  final Border? border;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.elevation,
    this.onTap,
    this.borderRadius,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Material(
        color: color ?? AppColors.surface,
        elevation: elevation ?? 2.0,
        borderRadius: borderRadius ?? BorderRadius.circular(12.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: (borderRadius ?? BorderRadius.circular(12.r)) as BorderRadius,
          child: Container(
            padding: padding,
            decoration: border != null
                ? BoxDecoration(
                    border: border,
                    borderRadius: borderRadius ?? BorderRadius.circular(12.r),
                  )
                : null,
            child: child,
          ),
        ),
      ),
    );
  }
}