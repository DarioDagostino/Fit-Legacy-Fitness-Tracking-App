import 'package:flutter/material.dart';
import 'package:myapp/fit_legacy/lib/domain/entities/nodo_entity.dart';
import 'package:myapp/fit_legacy/lib/presentation/navigation/app_router.dart';
import 'dart:math' as math;

class NodoWidget extends StatefulWidget {
  final Nodo nodo;

  const NodoWidget({super.key, required this.nodo});

  @override
  _NodoWidgetState createState() => _NodoWidgetState();
}
class _NodoWidgetState extends State<NodoWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    if (widget.nodo.status == NodoStatus.active) {
      _animationController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isActive = widget.nodo.status == NodoStatus.active;
    final bool isCompleted = widget.nodo.status == NodoStatus.completed;
    final bool isLocked = widget.nodo.status == NodoStatus.locked;
    final Color legacyGold = const Color(0xFFFFC107);

    final NodeStyle style = _getNodeStyle(widget.nodo.type, isCompleted, isLocked);

    Widget content = _buildNodeContainer(style);

    if (isActive) {
      final activeStyle = style.copyWith(
        backgroundColor: Colors.transparent,
        borderColor: legacyGold,
        iconColor: legacyGold,
        borderWidth: 3,
      );

      content = AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              shape: widget.nodo.type == NodoType.training
                  ? BoxShape.circle
                  : BoxShape.rectangle,
              borderRadius: widget.nodo.type == NodoType.training
                  ? null
                  : BorderRadius.circular(16),
              boxShadow: [
                BoxShadow( 
                  color: legacyGold.withOpacity(0.5 * _animationController.value),
                  blurRadius: 12.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: _buildNodeContainer(activeStyle),
          );
        },
      );
    }

    return InkWell(
      onTap: isLocked
          ? null
          : () {
              AppRouter.router.go('/nodo/${widget.nodo.id}');
            },
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Legacito appears next to the active node
              if (isActive) ...[
                // Placeholder for Legacito
                const SizedBox(width: 80),
                const SizedBox(width: 20),
              ],
              content,
              if (isActive) ...[
                const SizedBox(width: 20),
                // Placeholder for Legacito
                const SizedBox(width: 80),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNodeContainer(NodeStyle style) {
    final shape = widget.nodo.type == NodoType.training
        ? BoxShape.circle
        : BoxShape.rectangle;

    Widget nodeContent = Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        shape: shape,
        borderRadius:
            shape == BoxShape.rectangle ? BorderRadius.circular(16) : null,
        border: Border.all(
          color: style.borderColor,
          width: style.borderWidth,
        ),
      ),
      child: Center(
        child: Icon(
          widget.nodo.icon,
          size: 40,
          color: style.iconColor,
        ),
      ),
    );

    if (widget.nodo.type == NodoType.milestone) {
      return ClipPath(
        clipper: _HexagonClipper(),
        child: nodeContent,
      );
    }

    return nodeContent;
  }

  NodeStyle _getNodeStyle(NodoType type, bool isCompleted, bool isLocked) {
    if (isLocked) {
      return NodeStyle(
        backgroundColor: Colors.grey.withOpacity(0.1),
        borderColor: Colors.grey.shade700,
        iconColor: Colors.grey.shade700,
      );
    }

    switch (type) {
      case NodoType.training:
        return NodeStyle(
          backgroundColor:
              isCompleted ? const Color(0xFFFFC107) : Colors.transparent,
          borderColor:
              isCompleted ? Colors.transparent : Colors.white.withOpacity(0.8),
          iconColor: isCompleted ? Colors.black : Colors.white.withOpacity(0.8),
        );
      case NodoType.recovery:
        final recoveryColor = Colors.blue.shade300;
        return NodeStyle(
          backgroundColor: isCompleted ? recoveryColor : Colors.transparent,
          borderColor: isCompleted ? Colors.transparent : recoveryColor,
          iconColor: isCompleted ? Colors.white : recoveryColor,
        );
      case NodoType.milestone:
        final milestoneColor = Colors.purple.shade300;
        return NodeStyle(
          backgroundColor: isCompleted ? milestoneColor : Colors.transparent,
          borderColor: isCompleted ? Colors.transparent : milestoneColor,
          iconColor: isCompleted ? Colors.white : milestoneColor,
        );
    }
  }
}

class NodeStyle {
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final double borderWidth;

  NodeStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    this.borderWidth = 2.0,
  });

  NodeStyle copyWith({
    Color? backgroundColor,
    Color? borderColor,
    Color? iconColor,
    double? borderWidth,
  }) {
    return NodeStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      iconColor: iconColor ?? this.iconColor,
      borderWidth: borderWidth ?? this.borderWidth,
    );
  }
}

class _HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 0.5, 0);
    path.lineTo(size.width, size.height * 0.25);
    path.lineTo(size.width, size.height * 0.75);
    path.lineTo(size.width * 0.5, size.height);
    path.lineTo(0, size.height * 0.75);
    path.lineTo(0, size.height * 0.25);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}