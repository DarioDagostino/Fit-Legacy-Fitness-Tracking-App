import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class AuthCard extends StatelessWidget {
  final Widget child;
  final Widget? header;
  /// Optional fixed width for the inner card (helps with larger screens)
  final double? maxWidth;
  const AuthCard({super.key, required this.child, this.header, this.maxWidth});

  @override
  Widget build(BuildContext context) {
    Widget card = Card(
      color: AppColors.surface,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
        child: child,
      ),
    );

    if (maxWidth != null) {
      card = ConstrainedBox(constraints: BoxConstraints(maxWidth: maxWidth!), child: card);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (header != null) header!,
        const SizedBox(height: 16),
        card,
      ],
    );
  }
}
