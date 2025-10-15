import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'legacito_provider.dart';

// Provider para el estado del pedometer
final pedometerProvider = StateNotifierProvider<PedometerNotifier, PedometerState>((ref) {
  return PedometerNotifier();
});

// Provider para los pasos del día actual
final todayStepsProvider = Provider<int>((ref) {
  return ref.watch(pedometerProvider.select((state) => state.todaySteps));
});

// Provider para el estado de conexión
final pedometerConnectionProvider = Provider<bool>((ref) {
  return ref.watch(pedometerProvider.select((state) => state.isConnected));
});

class PedometerState {
  final int todaySteps;
  final int yesterdaySteps;
  final bool isConnected;
  final bool isInitialized;
  final String? error;
  final DateTime lastUpdate;

  const PedometerState({
    this.todaySteps = 0,
    this.yesterdaySteps = 0,
    this.isConnected = false,
    this.isInitialized = false,
    this.error,
    required this.lastUpdate,
  });

  PedometerState copyWith({
    int? todaySteps,
    int? yesterdaySteps,
    bool? isConnected,
    bool? isInitialized,
    String? error,
    DateTime? lastUpdate,
  }) {
    return PedometerState(
      todaySteps: todaySteps ?? this.todaySteps,
      yesterdaySteps: yesterdaySteps ?? this.yesterdaySteps,
      isConnected: isConnected ?? this.isConnected,
      isInitialized: isInitialized ?? this.isInitialized,
      error: error ?? this.error,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }
}

class PedometerNotifier extends StateNotifier<PedometerState> {
  StreamSubscription<StepCount>? _stepCountSubscription;
  StreamSubscription<PedestrianStatus>? _pedestrianStatusSubscription;

  PedometerNotifier() : super(PedometerState(lastUpdate: DateTime.now())) {
    _initializePedometer();
  }

  @override
  void dispose() {
    _stepCountSubscription?.cancel();
    _pedestrianStatusSubscription?.cancel();
    super.dispose();
  }

  // Inicializar el pedometer
  Future<void> _initializePedometer() async {
    try {
      // Verificar permisos
      final permission = await Permission.activityRecognition.request();
      if (!permission.isGranted) {
        state = state.copyWith(
          error: 'Permisos de actividad no concedidos',
          isInitialized: false,
        );
        return;
      }

      // Configurar stream de pasos
      _stepCountSubscription = Pedometer.stepCountStream.listen(
        _onStepCount,
        onError: _onError,
      );

      // Configurar stream de estado
      _pedestrianStatusSubscription = Pedometer.pedestrianStatusStream.listen(
        _onPedestrianStatus,
        onError: _onError,
      );

      state = state.copyWith(
        isInitialized: true,
        isConnected: true,
        error: null,
      );

      // Actualizar pasos iniciales
      await _loadInitialSteps();
    } catch (e) {
      state = state.copyWith(
        error: 'Error al inicializar pedometer: $e',
        isInitialized: false,
      );
    }
  }

  // Manejar conteo de pasos
  void _onStepCount(StepCount event) {
    final todaySteps = event.steps;
    final now = DateTime.now();
    
    state = state.copyWith(
      todaySteps: todaySteps,
      lastUpdate: now,
      error: null,
    );

    // Notificar a Legacito sobre el cambio de pasos
    // Esto se manejará en el provider de Legacito
  }

  // Manejar estado del peatón
  void _onPedestrianStatus(PedestrianStatus event) {
    state = state.copyWith(
      isConnected: event.status == 'walking' || event.status == 'stopped',
    );
  }

  // Manejar errores
  void _onError(dynamic error) {
    state = state.copyWith(
      error: 'Error del pedometer: $error',
      isConnected: false,
    );
  }

  // Cargar pasos iniciales
  Future<void> _loadInitialSteps() async {
    try {
      // Obtener pasos del día actual
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      
      // Aquí podrías implementar lógica para obtener pasos del día
      // Por ahora usamos el stream del pedometer
    } catch (e) {
      state = state.copyWith(
        error: 'Error al cargar pasos iniciales: $e',
      );
    }
  }

  // Reiniciar pedometer
  Future<void> restart() async {
    await _stepCountSubscription?.cancel();
    await _pedestrianStatusSubscription?.cancel();
    await _initializePedometer();
  }

  // Verificar permisos
  Future<bool> checkPermissions() async {
    final permission = await Permission.activityRecognition.status;
    return permission.isGranted;
  }

  // Solicitar permisos
  Future<bool> requestPermissions() async {
    final permission = await Permission.activityRecognition.request();
    return permission.isGranted;
  }

  // Obtener estadísticas del día
  Map<String, dynamic> getTodayStats() {
    return {
      'steps': state.todaySteps,
      'isConnected': state.isConnected,
      'lastUpdate': state.lastUpdate,
      'error': state.error,
    };
  }

  // Calcular distancia aproximada (en metros)
  double getApproximateDistance() {
    // Asumiendo 0.7 metros por paso promedio
    return state.todaySteps * 0.7;
  }

  // Calcular calorías aproximadas
  double getApproximateCalories() {
    // Asumiendo 0.04 calorías por paso
    return state.todaySteps * 0.04;
  }
}
