'''package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fit_legacy_app/domain/repositories/pasos_repository.dart';
import 'package:fit_legacy_app/services/streaks_service.dart';

part 'pasos_notifier.freezed.dart';

@freezed
class PasosState with _$PasosState {
  const factory PasosState({
    @Default(0) int actuales,
    @Default(10000) int meta,
    @Default(0) int rachaDiaria,
  }) = _PasosState;
}

class PasosNotifier extends StateNotifier<PasosState> {
  final PasosRepository _pasosRepository;
  final StreaksService _streaksService;

  PasosNotifier(this._pasosRepository, this._streaksService) : super(const PasosState()) {
    loadPasos();
  }

  Future<void> loadPasos() async {
    final pasos = await _pasosRepository.obtenerPasosDiarios();
    state = state.copyWith(actuales: pasos);
  }

  void actualizarPasos(int nuevosPasos) {
    final cumplioMeta = nuevosPasos >= state.meta;
    final racha = cumplioMeta ? state.rachaDiaria + 1 : 0;
    state = state.copyWith(actuales: nuevosPasos, rachaDiaria: racha);

    if (cumplioMeta) {
      registrarMetaCumplida();
    }
  }

  Future<void> registrarMetaCumplida() async {
    await _streaksService.processGoalCompleted(
      type: 'daily',
      goalId: 'daily_steps',
      timestamp: DateTime.now(),
    );
  }
}
'''