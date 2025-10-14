import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pasos_notifier.freezed.dart';

@freezed
class PasosState with _$PasosState {
  const factory PasosState({
    @Default(0) int actuales,
    @Default(10000) int meta,
    @Default(0) int rachaDiaria,
    @Default(0) int rachaSemanal,
    @Default(false) bool logroMensualCompleto,
    @Default([]) List<DayProgress> progresoSemanal,
  }) = _PasosState;
}

@freezed
class DayProgress with _$DayProgress {
  const factory DayProgress({
    required String day,
    required int steps,
    required bool goalCompleted,
  }) = _DayProgress;
}

class PasosNotifier extends StateNotifier<PasosState> {
  PasosNotifier() : super(const PasosState()) {
    // Initialize with demo data matching Figma design
    state = PasosState(
      actuales: 6450, 
      meta: 10000, 
      rachaDiaria: 3,
      rachaSemanal: 1, // In progress
      logroMensualCompleto: true,
      progresoSemanal: _generateWeeklyProgress(),
    );
  }

  List<DayProgress> _generateWeeklyProgress() {
    return [
      const DayProgress(day: 'S 25', steps: 10200, goalCompleted: true),
      const DayProgress(day: 'L 26', steps: 10500, goalCompleted: true),
      const DayProgress(day: 'M 27', steps: 11000, goalCompleted: true),
      const DayProgress(day: 'M 28', steps: 9800, goalCompleted: false),
      const DayProgress(day: 'J 29', steps: 10300, goalCompleted: true),
      const DayProgress(day: 'V 30', steps: 9900, goalCompleted: false),
      const DayProgress(day: 'S 31', steps: 6450, goalCompleted: false), // Today
    ];
  }

  void actualizarPasos(int nuevosPasos) {
    final cumplioMeta = nuevosPasos >= state.meta;
    final racha = cumplioMeta ? state.rachaDiaria + 1 : 0;
    state = state.copyWith(actuales: nuevosPasos, rachaDiaria: racha);

    if (cumplioMeta) {
      registrarMetaCumplida();
    }
  }

  void registrarMetaCumplida() {
    // Future: integrate with real streak service
    print('Goal completed: daily steps');
  }
}