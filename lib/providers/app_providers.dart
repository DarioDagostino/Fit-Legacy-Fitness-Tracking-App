import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fit_legacy_app/domain/repositories/pasos_repository.dart';
import 'package:fit_legacy_app/data/repositories/pasos_repository_impl.dart';
import 'package:fit_legacy_app/providers/pasos_notifier.dart';

final pasosRepositoryProvider = Provider<PasosRepository>((ref) {
  return PasosRepositoryImpl();
});

final pasosNotifierProvider = StateNotifierProvider<PasosNotifier, PasosState>((ref) {
  final repository = ref.watch(pasosRepositoryProvider);
  return PasosNotifier(repository);
});
