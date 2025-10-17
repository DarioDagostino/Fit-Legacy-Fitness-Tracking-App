import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_legacy/domain/entities/nodo_entity.dart';

class CaminoProvider with ChangeNotifier {
  List<Nodo> _nodos = [];
  bool _isLoading = true;
  int _mockLastCompletedId = -1; // Mock progress

  List<Nodo> get nodos => _nodos;
  bool get isLoading => _isLoading;

  CaminoProvider() {
    _initializeNodos();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        loadProgreso();
      } else {
        _resetProgreso();
      }
    });
  }

  void _initializeNodos() {
    _nodos = List.generate(15, (index) {
      NodoType type;
      IconData icon;
      if ((index + 1) % 7 == 0) {
        type = NodoType.milestone;
        icon = Icons.shield;
      } else if ((index + 1) % 4 == 0) {
        type = NodoType.recovery;
        icon = Icons.self_improvement;
      } else {
        type = NodoType.training;
        icon = Icons.fitness_center;
      }
      return Nodo(id: index, title: 'Sesión ${index + 1}', type: type, icon: icon);
    });
  }

  void _resetProgreso() {
    _mockLastCompletedId = -1;
    _initializeNodos();
    _nodos.first.status = NodoStatus.active;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadProgreso() async {
    _isLoading = true;
    notifyListeners();

    // Simulate a network delay
    await Future.delayed(const Duration(milliseconds: 500));
    for (var nodo in _nodos) {
      if (nodo.id <= _mockLastCompletedId) {
        nodo.status = NodoStatus.completed;
      } else if (nodo.id == _mockLastCompletedId + 1) {
        nodo.status = NodoStatus.active;
      } else {
        nodo.status = NodoStatus.locked;
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> completeNodo(int nodoId) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    // Update mock progress
    _mockLastCompletedId = nodoId;

    // Optimistic UI update
    final completedNodeIndex = _nodos.indexWhere((n) => n.id == nodoId);
    if (completedNodeIndex != -1) {
      _nodos[completedNodeIndex].status = NodoStatus.completed;

      // Activate the next node if it exists
      if (completedNodeIndex + 1 < _nodos.length) {
        _nodos[completedNodeIndex + 1].status = NodoStatus.active;
      }
    }

    notifyListeners();
  }
}