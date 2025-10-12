import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/streak_state.dart';
import '../models/achievement.dart';
import '../models/event_model.dart';
import 'streaks_service.dart';
import 'event_service.dart';
import 'legacito_service.dart';

// Providers para el estado global
final streaksServiceProvider = Provider<StreaksService>((ref) => StreaksService());
final eventServiceProvider = Provider<EventService>((ref) => EventService());
final legacitoServiceProvider = Provider<LegacitoAgent>((ref) => StoicLegacitoService());

// Provider para streaks
final streaksProvider = FutureProvider<List<StreakState>>((ref) async {
  final service = ref.read(streaksServiceProvider);
  return await service.loadAll();
});

// Provider para achievements
final achievementsProvider = FutureProvider<List<Achievement>>((ref) async {
  final service = ref.read(streaksServiceProvider);
  return await service.loadAchievements();
});

// Provider para eventos recientes
final recentEventsProvider = FutureProvider<List<EventModel>>((ref) async {
  final service = ref.read(eventServiceProvider);
  return await service.readRecent(hours: 24);
});

// Provider para estadísticas de eventos
final eventStatsProvider = FutureProvider<Map<String, int>>((ref) async {
  final service = ref.read(eventServiceProvider);
  return await service.getEventStats();
});

// Notifier para manejar el estado de la aplicación
class AppStateNotifier extends StateNotifier<AppState> {
  final StreaksService _streaksService;
  final EventService _eventService;
  final LegacitoAgent _legacitoService;

  AppStateNotifier({
    required StreaksService streaksService,
    required EventService eventService,
    required LegacitoAgent legacitoService,
  }) : _streaksService = streaksService,
       _eventService = eventService,
       _legacitoService = legacitoService,
       super(const AppState());

  Future<void> initialize() async {
    try {
      state = state.copyWith(isLoading: true);
      
      // Cargar datos iniciales
      final streaks = await _streaksService.loadAll();
      final achievements = await _streaksService.loadAchievements();
      final events = await _eventService.readRecent();
      
      state = state.copyWith(
        isLoading: false,
        streaks: streaks,
        achievements: achievements,
        recentEvents: events,
        lastUpdate: DateTime.now(),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> processGoalCompletion({
    required String type,
    required String goalId,
    String? userId,
  }) async {
    try {
      state = state.copyWith(isProcessing: true);
      
      // Procesar en el servicio de streaks
      final updatedStreak = await _streaksService.processGoalCompleted(
        type: type,
        goalId: goalId,
        timestamp: DateTime.now(),
        userId: userId,
      );
      
      // Crear evento
      final event = EventModel.goalCompleted(
        source: type,
        goalId: goalId,
        points: 1,
        userId: userId,
      );
      await _eventService.enqueueEvent(event);
      
      // Recargar datos
      await _refreshData();
      
      // Mostrar mensaje de Legacito
      final message = _legacitoService.evaluateProgress(
        steps: updatedStreak.length,
        goal: 7, // Meta semanal por defecto
      );
      
      state = state.copyWith(
        isProcessing: false,
        legacitoMessage: message,
        showLegacito: true,
      );
      
      // Ocultar mensaje después de 3 segundos
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          state = state.copyWith(showLegacito: false);
        }
      });
      
    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        error: e.toString(),
      );
    }
  }

  Future<void> _refreshData() async {
    try {
      final streaks = await _streaksService.loadAll();
      final achievements = await _streaksService.loadAchievements();
      final events = await _eventService.readRecent();
      
      state = state.copyWith(
        streaks: streaks,
        achievements: achievements,
        recentEvents: events,
        lastUpdate: DateTime.now(),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void hideLegacito() {
    state = state.copyWith(showLegacito: false);
  }

  String getDailyQuote() {
    return _legacitoService.getDailyQuote();
  }
}

// Estado de la aplicación
class AppState {
  final bool isLoading;
  final bool isProcessing;
  final String? error;
  final List<StreakState> streaks;
  final List<Achievement> achievements;
  final List<EventModel> recentEvents;
  final DateTime? lastUpdate;
  final String? legacitoMessage;
  final bool showLegacito;

  const AppState({
    this.isLoading = false,
    this.isProcessing = false,
    this.error,
    this.streaks = const [],
    this.achievements = const [],
    this.recentEvents = const [],
    this.lastUpdate,
    this.legacitoMessage,
    this.showLegacito = false,
  });

  AppState copyWith({
    bool? isLoading,
    bool? isProcessing,
    String? error,
    List<StreakState>? streaks,
    List<Achievement>? achievements,
    List<EventModel>? recentEvents,
    DateTime? lastUpdate,
    String? legacitoMessage,
    bool? showLegacito,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      isProcessing: isProcessing ?? this.isProcessing,
      error: error ?? this.error,
      streaks: streaks ?? this.streaks,
      achievements: achievements ?? this.achievements,
      recentEvents: recentEvents ?? this.recentEvents,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      legacitoMessage: legacitoMessage ?? this.legacitoMessage,
      showLegacito: showLegacito ?? this.showLegacito,
    );
  }
}

// Provider principal para el estado de la aplicación
final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier(
    streaksService: ref.read(streaksServiceProvider),
    eventService: ref.read(eventServiceProvider),
    legacitoService: ref.read(legacitoServiceProvider),
  );
});
