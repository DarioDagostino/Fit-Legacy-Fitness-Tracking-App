import 'package:fit_legacy_app/domain/repositories/pasos_repository.dart';

class PasosRepositoryImpl implements PasosRepository {
  @override
  Future<int> obtenerPasosDiarios() async {
    return 5000;
  }
}
