import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

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
  int _initialSteps = 0;
  int _dailySteps = 0;
  late SharedPreferences _prefs;

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
      _prefs = await SharedPreferences.getInstance();

      // Verificar permisos
      final permission = await Permission.activityRecognition.request();
      if (!permission.isGranted) {
        state = state.copyWith(
          error: 'Permisos de actividad no concedidos',
          isInitialized: false,
        );
        return;
      }

      // Cargar pasos guardados
      await _loadSavedSteps();

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
    } catch (e) {
      state = state.copyWith(
        error: 'Error al inicializar pedometer: $e',
        isInitialized: false,
      );
    }
  }

  // Manejar conteo de pasos
  void _onStepCount(StepCount event) async {
    final now = DateTime.now();
    final lastSavedDateStr = _prefs.getString('pedometer_date');
    final todayStr = '${now.year}-${now.month}-${now.day}';

    if (lastSavedDateStr != todayStr) {
      // Es un nuevo día, reiniciar conteo
      _dailySteps = 0;
      _initialSteps = event.steps;
      await _prefs.setString('pedometer_date', todayStr);
      await _prefs.setInt('pedometer_initial_steps', _initialSteps);
    }

    // Si el dispositivo se reinicia, el conteo de `event.steps` será menor
    if (event.steps < _initialSteps) {
      _initialSteps = event.steps;
      await _prefs.setInt('pedometer_initial_steps', _initialSteps);
    }

    _dailySteps = event.steps - _initialSteps;

    await _prefs.setInt('pedometer_daily_steps', _dailySteps);

    state = state.copyWith(
      todaySteps: _dailySteps,
      lastUpdate: now,
      error: null,
    );
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
  Future<void> _loadSavedSteps() async {
    final now = DateTime.now();
    final todayStr = '${now.year}-${now.month}-${now.day}';
    final lastSavedDateStr = _prefs.getString('pedometer_date');

    if (lastSavedDateStr == todayStr) {
      _initialSteps = _prefs.getInt('pedometer_initial_steps') ?? 0;
      _dailySteps = _prefs.getInt('pedometer_daily_steps') ?? 0;
    } else {
      // Es un nuevo día o la primera vez que se abre la app
      _initialSteps = 0;
      _dailySteps = 0;
    }
    state = state.copyWith(todaySteps: _dailySteps);
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
