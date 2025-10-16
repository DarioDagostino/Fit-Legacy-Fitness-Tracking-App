import 'package:flutter/material.dart';

class PathPainter extends CustomPainter {
  final int nodeCount;
  final double nodeHeight;

  PathPainter({required this.nodeCount, required this.nodeHeight});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    final center = size.width / 2;

    for (int i = 0; i < nodeCount - 1; i++) {
      final startY = (i * nodeHeight) + (nodeHeight / 2);
      final endY = ((i + 1) * nodeHeight) + (nodeHeight / 2);

      path.moveTo(center, startY);

      // Create a dashed line effect
      double dashWidth = 5.0;
      double dashSpace = 4.0;
      double distance = endY - startY;
      for (double d = 0; d < distance; d += dashWidth + dashSpace) {
        path.moveTo(center, startY + d);
        path.lineTo(center, startY + d + dashWidth);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}