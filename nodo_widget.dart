import 'package:flutter/material.dart';
import 'package:fit_legacy/domain/entities/nodo_entity.dart';
import 'package:go_router/go_router.dart';

class NodoWidget extends StatefulWidget {
  final Nodo nodo;

  const NodoWidget({super.key, required this.nodo});

  @override
  _NodoWidgetState createState() => _NodoWidgetState();
}

class _NodoWidgetState extends State<NodoWidget> with SingleTickerProviderStateMixin {
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

    Widget content = Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: isCompleted ? legacyGold : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCompleted ? Colors.transparent : Colors.white,
          width: 2,
        ),
      ),
      child: Center(
        child: Icon(
          widget.nodo.icon,
          size: 40,
          color: isCompleted ? const Color(0xFF121212) : Colors.white,
        ),
      ),
    );

    if (isActive) {
      content = AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: legacyGold.withOpacity(0.5 * _animationController.value),
                  blurRadius: 12.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: legacyGold,
                  width: 3,
                ),
              ),
              child: Center(
                child: Icon(
                  widget.nodo.icon,
                  size: 40,
                  color: legacyGold,
                ),
              ),
            ),
          );
        },
      );
    }

    return InkWell(
      onTap: isLocked
          ? null
          : () {
              context.go('/nodo/${widget.nodo.id}');
            },
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Legacito appears next to the active node
              if (isActive) ...[
                Image.asset(
                  'assets/images/legacito/legacito_pensativo.png',
                  height: 60,
                ),
                const SizedBox(width: 20),
              ],
              content,
              if (isActive) ...[
                const SizedBox(
                    width: 80), // Balance the space for Legacito
              ],
            ],
          ),
        ],
      ),
    );
  }
}