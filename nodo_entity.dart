import 'package:flutter/material.dart';

enum NodoType { training, recovery, milestone }
enum NodoStatus { locked, active, completed }

class Nodo {
  final int id;
  final String title;
  final NodoType type;
  final IconData icon;
  NodoStatus status;

  Nodo({
    required this.id,
    required this.title,
    required this.type,
    required this.icon,
    this.status = NodoStatus.locked,
  });
}