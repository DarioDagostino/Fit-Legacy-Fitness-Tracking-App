import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_legacy/domain/entities/nodo_entity.dart';
import 'package:fit_legacy/data/repositories/camino_repository_impl.dart';
import 'package:fit_legacy/domain/repositories/camino_repository_interface.dart';

class CaminoProvider with ChangeNotifier {
  final CaminoRepositoryInterface _caminoRepository = CaminoRepositoryImpl();
  List<Nodo> _nodos = [];
  bool _isLoading = true;

  List<Nodo> get nodos => _nodos;
  bool get isLoading => _isLoading;

  CaminoProvider() {
    _initializeNodos();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        loadProgreso(user.uid);
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
    _initializeNodos();
    _nodos.first.status = NodoStatus.active;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadProgreso(String userId) async {
    _isLoading = true;
    notifyListeners();

    final lastCompletedId = await _caminoRepository.getProgreso(userId);
    for (var nodo in _nodos) {
      if (nodo.id <= lastCompletedId) {
        nodo.status = NodoStatus.completed;
      } else if (nodo.id == lastCompletedId + 1) {
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

    await _caminoRepository.updateProgreso(userId, nodoId);
    // Recargar el progreso para reflejar el cambio en toda la UI
    await loadProgreso(userId);
  }
}