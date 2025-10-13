import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_colors.dart';
import '../core/config/app_config.dart';

/// FigmaWidget - A flexible widget component based on Figma designs
/// This widget provides a highly customizable card-based component that can be
/// adapted to match various Figma design specifications.
/// 
/// Features:
/// - Customizable colors, gradients, and backgrounds
/// - Flexible layout with header, content, and footer sections
/// - Icon and image support
/// - Action buttons and callbacks
/// - Animations and transitions
/// - Responsive sizing
class FigmaWidget extends ConsumerWidget {
  // Content
  final String? title;
  final String? subtitle;
  final String? description;
  final Widget? customContent;
  
  // Visual styling
  final Color? backgroundColor;
  final Gradient? backgroundGradient;
  final double? elevation;
  final double? borderRadius;
  final Border? border;
  
  // Icon/Image
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final Widget? leadingWidget;
  final Widget? trailingWidget;
  
  // Layout
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  
  // Interactions
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDismiss;
  final bool dismissible;
  
  // Actions
  final List<FigmaWidgetAction>? actions;
  
  // Animation
  final bool animated;
  final Duration? animationDuration;

  const FigmaWidget({
    Key? key,
    this.title,
    this.subtitle,
    this.description,
    this.customContent,
    this.backgroundColor,
    this.backgroundGradient,
    this.elevation = 4.0,
    this.borderRadius,
    this.border,
    this.icon,
    this.iconColor,
    this.iconSize = 24.0,
    this.leadingWidget,
    this.trailingWidget,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.onTap,
    this.onLongPress,
    this.onDismiss,
    this.dismissible = false,
    this.actions,
    this.animated = false,
    this.animationDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget content = _buildContent(context);
    
    if (animated) {
      content = _buildAnimatedContent(content);
    }
    
    if (dismissible && onDismiss != null) {
      content = Dismissible(
        key: UniqueKey(),
        onDismissed: (_) => onDismiss!(),
        child: content,
      );
    }
    
    return content;
  }

  Widget _buildContent(BuildContext context) {
    final effectiveBorderRadius = borderRadius ?? AppConfig.defaultBorderRadius;
    final effectivePadding = padding ?? const EdgeInsets.all(AppConfig.defaultPadding);
    final effectiveMargin = margin ?? const EdgeInsets.all(AppConfig.smallPadding);

    Widget cardContent = Container(
      padding: effectivePadding,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        gradient: backgroundGradient,
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        border: border,
      ),
      child: _buildInnerContent(context),
    );

    if (onTap != null || onLongPress != null) {
      cardContent = InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        child: cardContent,
      );
    }

    return Container(
      margin: effectiveMargin,
      width: width,
      height: height,
      child: Card(
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
        ),
        child: cardContent,
      ),
    );
  }

  Widget _buildInnerContent(BuildContext context) {
    final List<Widget> children = [];

    // Leading section (icon or custom widget)
    if (leadingWidget != null || icon != null) {
      children.add(_buildLeading());
      children.add(const SizedBox(width: 12));
    }

    // Main content section
    children.add(
      Expanded(
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: MainAxisSize.min,
          children: _buildMainContent(context),
        ),
      ),
    );

    // Trailing section
    if (trailingWidget != null) {
      children.add(const SizedBox(width: 12));
      children.add(trailingWidget!);
    }

    // Actions section
    if (actions != null && actions!.isNotEmpty) {
      children.add(const SizedBox(width: 12));
      children.add(_buildActions());
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _buildLeading() {
    if (leadingWidget != null) {
      return leadingWidget!;
    }

    if (icon != null) {
      return Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: (iconColor ?? AppColors.accent).withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: iconColor ?? AppColors.accent,
          size: iconSize,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  List<Widget> _buildMainContent(BuildContext context) {
    final List<Widget> contentWidgets = [];

    if (title != null) {
      contentWidgets.add(
        Text(
          title!,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
      );
      contentWidgets.add(const SizedBox(height: 4));
    }

    if (subtitle != null) {
      contentWidgets.add(
        Text(
          subtitle!,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      );
      contentWidgets.add(const SizedBox(height: 4));
    }

    if (description != null) {
      contentWidgets.add(
        Text(
          description!,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      );
    }

    if (customContent != null) {
      contentWidgets.add(customContent!);
    }

    return contentWidgets;
  }

  Widget _buildActions() {
    if (actions == null || actions!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: actions!.map((action) {
        return IconButton(
          icon: Icon(action.icon),
          color: action.color ?? AppColors.accent,
          iconSize: action.iconSize ?? 20,
          onPressed: action.onPressed,
          tooltip: action.tooltip,
        );
      }).toList(),
    );
  }

  Widget _buildAnimatedContent(Widget child) {
    return TweenAnimationBuilder<double>(
      duration: animationDuration ?? AppConfig.defaultAnimationDuration,
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: 0.9 + (0.1 * value),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

/// Action configuration for FigmaWidget
class FigmaWidgetAction {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final double? iconSize;
  final String? tooltip;

  const FigmaWidgetAction({
    required this.icon,
    required this.onPressed,
    this.color,
    this.iconSize,
    this.tooltip,
  });
}

/// Preset configurations based on common Figma design patterns
class FigmaWidgetPresets {
  /// Info card preset - ideal for informational content
  static FigmaWidget infoCard({
    required String title,
    String? description,
    IconData? icon,
    VoidCallback? onTap,
  }) {
    return FigmaWidget(
      title: title,
      description: description,
      icon: icon ?? Icons.info_outline,
      iconColor: Colors.blue,
      backgroundGradient: LinearGradient(
        colors: [
          Colors.blue[50]!,
          Colors.blue[100]!,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      onTap: onTap,
      animated: true,
    );
  }

  /// Success card preset - ideal for positive feedback
  static FigmaWidget successCard({
    required String title,
    String? description,
    IconData? icon,
    VoidCallback? onTap,
  }) {
    return FigmaWidget(
      title: title,
      description: description,
      icon: icon ?? Icons.check_circle_outline,
      iconColor: AppColors.success,
      backgroundGradient: LinearGradient(
        colors: [
          Colors.green[50]!,
          Colors.green[100]!,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      onTap: onTap,
      animated: true,
    );
  }

  /// Warning card preset - ideal for alerts and warnings
  static FigmaWidget warningCard({
    required String title,
    String? description,
    IconData? icon,
    VoidCallback? onTap,
  }) {
    return FigmaWidget(
      title: title,
      description: description,
      icon: icon ?? Icons.warning_outline,
      iconColor: AppColors.accent,
      backgroundGradient: LinearGradient(
        colors: [
          Colors.amber[50]!,
          Colors.amber[100]!,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      onTap: onTap,
      animated: true,
    );
  }

  /// Achievement card preset - ideal for displaying achievements
  static FigmaWidget achievementCard({
    required String title,
    String? subtitle,
    String? description,
    IconData? icon,
    VoidCallback? onTap,
  }) {
    return FigmaWidget(
      title: title,
      subtitle: subtitle,
      description: description,
      icon: icon ?? Icons.emoji_events,
      iconColor: AppColors.accent,
      backgroundGradient: AppColors.accentGradient,
      elevation: 8,
      onTap: onTap,
      animated: true,
    );
  }

  /// Progress card preset - ideal for showing progress and stats
  static FigmaWidget progressCard({
    required String title,
    required Widget progressWidget,
    IconData? icon,
    VoidCallback? onTap,
  }) {
    return FigmaWidget(
      title: title,
      customContent: progressWidget,
      icon: icon ?? Icons.trending_up,
      iconColor: AppColors.accent,
      backgroundColor: AppColors.surface,
      onTap: onTap,
      animated: true,
    );
  }

  /// Action card preset - ideal for interactive cards with multiple actions
  static FigmaWidget actionCard({
    required String title,
    String? description,
    IconData? icon,
    List<FigmaWidgetAction>? actions,
    VoidCallback? onTap,
  }) {
    return FigmaWidget(
      title: title,
      description: description,
      icon: icon,
      iconColor: AppColors.primary,
      backgroundColor: AppColors.surface,
      actions: actions,
      onTap: onTap,
      animated: true,
    );
  }

  /// Compact card preset - ideal for list items and small cards
  static FigmaWidget compactCard({
    required String title,
    IconData? icon,
    Widget? trailingWidget,
    VoidCallback? onTap,
  }) {
    return FigmaWidget(
      title: title,
      icon: icon,
      iconSize: 20,
      trailingWidget: trailingWidget,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConfig.defaultPadding,
        vertical: AppConfig.smallPadding,
      ),
      backgroundColor: AppColors.surface,
      onTap: onTap,
      animated: false,
    );
  }
}
