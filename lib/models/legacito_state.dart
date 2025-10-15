import 'package:freezed_annotation/freezed_annotation.dart';

part 'legacito_state.freezed.dart';
part 'legacito_state.g.dart';

@freezed
class LegacitoState with _$LegacitoState {
  const factory LegacitoState({
    @Default(LegacitoMood.neutral) LegacitoMood mood,
    @Default('') String message,
    @Default(false) bool isAnimating,
    @Default(0) int currentStepCount,
    @Default(10000) int dailyGoal,
    @Default(0) int streakDays,
    @Default([]) List<String> recentMessages,
  }) = _LegacitoState;
}

enum LegacitoMood {
  motivado,
  celebrando,
  neutral,
  preocupado,
  resiliente,
  durmiendo,
  pensativo,
  energico,
}

extension LegacitoMoodExtension on LegacitoMood {
  String get imagePath {
    switch (this) {
      case LegacitoMood.motivado:
        return 'assets/images/legacito/legacito_motivado.png';
      case LegacitoMood.celebrando:
        return 'assets/images/legacito/legacito_celebrando.png';
      case LegacitoMood.neutral:
        return 'assets/images/legacito/legacito_neutral.png';
      case LegacitoMood.preocupado:
        return 'assets/images/legacito/legacito_preocupado.png';
      case LegacitoMood.resiliente:
        return 'assets/images/legacito/legacito_resiliente.png';
      case LegacitoMood.durmiendo:
        return 'assets/images/legacito/legacito_durmiendo.png';
      case LegacitoMood.pensativo:
        return 'assets/images/legacito/legacito_pensativo.png';
      case LegacitoMood.energico:
        return 'assets/images/legacito/legacito_energico.png';
    }
  }

  String get defaultMessage {
    switch (this) {
      case LegacitoMood.motivado:
        return '¡Vamos bien! La disciplina que muestras hoy construye el mañana';
      case LegacitoMood.celebrando:
        return '¡INCREÍBLE! Has alcanzado tu meta. Marco Aurelio estaría orgulloso';
      case LegacitoMood.neutral:
        return 'El día aún no termina. Cada paso es una decisión consciente';
      case LegacitoMood.preocupado:
        return 'Epicteto: "Ningún gran logro viene sin esfuerzo." Te extraño...';
      case LegacitoMood.resiliente:
        return 'Caer es humano. Levantarse es estoico. Bienvenido de vuelta';
      case LegacitoMood.durmiendo:
        return 'Zzz... Descansa bien. Mañana será otro día de conquistas';
      case LegacitoMood.pensativo:
        return 'La reflexión es el primer paso hacia la sabiduría';
      case LegacitoMood.energico:
        return '¡Energía pura! ¡Vamos a conquistar el día!';
    }
  }

  String get animationType {
    switch (this) {
      case LegacitoMood.celebrando:
        return 'bounce';
      case LegacitoMood.energico:
        return 'pulse';
      case LegacitoMood.durmiendo:
        return 'fade';
      case LegacitoMood.pensativo:
        return 'float';
      default:
        return 'slide';
    }
  }
}
