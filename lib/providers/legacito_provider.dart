import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/legacito_state.dart';

// Provider para el estado de Legacito
final legacitoProvider = StateNotifierProvider<LegacitoNotifier, LegacitoState>((ref) {
  return LegacitoNotifier();
});

// Provider para los pasos diarios
final dailyStepsProvider = StateProvider<int>((ref) => 0);

// Provider para la racha actual
final streakProvider = StateProvider<int>((ref) => 0);

// Provider para el estado de ánimo basado en los pasos
final legacitoMoodProvider = Provider<LegacitoMood>((ref) {
  final steps = ref.watch(dailyStepsProvider);
  final goal = ref.watch(legacitoProvider.select((state) => state.dailyGoal));
  final progress = steps / goal;
  
  if (progress >= 1.0) return LegacitoMood.celebrando;
  if (progress >= 0.8) return LegacitoMood.motivado;
  if (progress >= 0.5) return LegacitoMood.neutral;
  if (progress >= 0.2) return LegacitoMood.preocupado;
  return LegacitoMood.preocupado;
});

// Provider para mensajes personalizados
final legacitoMessageProvider = Provider<String>((ref) {
  final mood = ref.watch(legacitoMoodProvider);
  final state = ref.watch(legacitoProvider);
  
  if (state.message.isNotEmpty) {
    return state.message;
  }
  
  return mood.defaultMessage;
});

class LegacitoNotifier extends StateNotifier<LegacitoState> {
  LegacitoNotifier() : super(const LegacitoState()) {
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
    state = state.copyWith(currentStepCount: steps);
    
    // Calcular nuevo estado de ánimo
    final progress = steps / state.dailyGoal;
    final newMood = _calculateMoodFromProgress(progress);
    
    if (newMood != state.mood) {
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
  LegacitoMood _calculateMoodFromProgress(double progress) {
    if (progress >= 1.0) return LegacitoMood.celebrando;
    if (progress >= 0.8) return LegacitoMood.motivado;
    if (progress >= 0.5) return LegacitoMood.neutral;
    if (progress >= 0.2) return LegacitoMood.preocupado;
    return LegacitoMood.preocupado;
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
