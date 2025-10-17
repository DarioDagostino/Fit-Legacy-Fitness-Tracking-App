import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/legacito_state.dart';
import 'pedometer_provider.dart';

// Provider para el estado de Legacito
final legacitoProvider =
    StateNotifierProvider<LegacitoNotifier, LegacitoState>((ref) {
  final notifier = LegacitoNotifier(ref);

  // Listener administrado correctamente por Riverpod.
  // Se cancelará automáticamente cuando el provider sea destruido.
  ref.listen<int>(
    todayStepsProvider,
    (previous, next) => notifier.updateSteps(next),
  );

  return notifier;
});

// Provider para los pasos diarios
final dailyStepsProvider = StateProvider<int>((ref) => 0);

// Provider para la racha actual
final streakProvider = StateProvider<int>((ref) => 0);

class LegacitoNotifier extends StateNotifier<LegacitoState> {
  final Ref _ref;

  LegacitoNotifier(this._ref) : super(const LegacitoState()) {
    _loadPersistedData();
  }

  // Cargar datos persistidos
  Future<void> _loadPersistedData() async {
    final prefs = await SharedPreferences.getInstance();
    final streak = prefs.getInt('streak_days') ?? 0;
    final goal = prefs.getInt('daily_goal') ?? 10000;

    state = state.copyWith(
      streakDays: streak,
      dailyGoal: goal,
    );
  }

  // Actualizar pasos
  void updateSteps(int steps) {
    // Calcular nuevo estado de ánimo
    final progress = steps / state.dailyGoal;
    final newMood = _calculateMoodFromProgress(progress, DateTime.now());

    // Solo actualiza si el mood ha cambiado para evitar rebuilds innecesarios.
    if (newMood != state.mood) {
      state = state.copyWith(currentStepCount: steps, mood: newMood);
      _changeMood(newMood);
    }
  }

  // Cambiar estado de ánimo
  void _changeMood(LegacitoMood newMood) {
    state = state.copyWith(
      mood: newMood,
      isAnimating: true,
      message: newMood.defaultMessage,
    );

    // Detener animación después de 2 segundos
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        state = state.copyWith(isAnimating: false);
      }
    });
  }

  // Calcular estado de ánimo basado en progreso
  LegacitoMood _calculateMoodFromProgress(double progress, DateTime now) {
    final hour = now.hour;

    // La celebración siempre tiene prioridad.
    if (progress >= 1.0) return LegacitoMood.celebrando;

    // Por la mañana (antes de las 9 AM), Legacito es más tolerante.
    if (hour < 9) {
      if (progress > 0.1) return LegacitoMood.motivado; // ¡Ya empezaste!
      return LegacitoMood.neutral; // Neutral por defecto en la mañana.
    }

    // Por la noche (después de las 8 PM), Legacito se vuelve más insistente.
    if (hour >= 20) {
      if (progress < 0.7) {
        return LegacitoMood.preocupado; // Anima a completar la meta.
      }
      return LegacitoMood.motivado;
    }

    // Durante el resto del día.
    if (progress >= 0.6) return LegacitoMood.motivado;
    if (progress >= 0.2) return LegacitoMood.neutral;

    return LegacitoMood
        .preocupado; // Solo se preocupa si el progreso es muy bajo durante el día.
  }

  // Enviar mensaje personalizado
  void sendMessage(String message) {
    state = state.copyWith(
      message: message,
      recentMessages: [...state.recentMessages, message],
    );
  }

  // Actualizar racha
  void updateStreak(int days) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('streak_days', days);

    state = state.copyWith(streakDays: days);
  }

  // Actualizar meta diaria
  void updateDailyGoal(int goal) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('daily_goal', goal);

    state = state.copyWith(dailyGoal: goal);
  }

  // Forzar cambio de estado (para testing)
  void forceMoodChange(LegacitoMood mood) {
    _changeMood(mood);
  }

  // Resetear estado
  void reset() {
    state = const LegacitoState();
  }
}
