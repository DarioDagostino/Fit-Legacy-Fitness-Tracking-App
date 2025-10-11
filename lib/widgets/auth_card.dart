import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class AuthCard extends StatelessWidget {
  final Widget child;
  final Widget? header;
  const AuthCard({super.key, required this.child, this.header});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (header != null) header!,
        const SizedBox(height: 16),
        Card(
          color: AppColors.surface,
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: child,
          ),
        ),
      ],
    );
  }
}
