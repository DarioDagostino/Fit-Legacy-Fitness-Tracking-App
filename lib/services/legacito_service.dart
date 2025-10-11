import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Contract for the Legacito agent.
abstract class LegacitoAgent {
  /// Returns a short stoic-style daily quote.
  String getDailyQuote();

  /// Evaluate progress (steps vs goal) and return motivating, stoic-focused feedback.
  String evaluateProgress({required int steps, required int goal});
}

/// Simple provider exposing a LegacitoAgent implementation.
final legacitoProvider = Provider<LegacitoAgent>((ref) => StoicLegacitoService());

class StoicLegacitoService implements LegacitoAgent {
  final List<String> _quotes = const [
    'La disciplina de hoy es la libertad de mañana.',
    'No busques el resultado; cultiva el hábito.',
    'El esfuerzo constante vence al talento distraído.',
    'Concéntrate en lo que puedes controlar: tu paso, tu respiración, tu voluntad.',
    'La grandeza se encuentra en las acciones repetidas, no en las intenciones.'
  ];

  final Random _rnd = Random();

  @override
  String getDailyQuote() {
    return _quotes[_rnd.nextInt(_quotes.length)];
  }

  @override
  String evaluateProgress({required int steps, required int goal}) {
    if (goal <= 0) return 'Define una meta válida para medir tu progreso.';

    final ratio = steps / goal;

    if (ratio >= 1.0) {
      return 'Buen trabajo. Llegaste a la meta — recuerda que la constancia es lo que mantiene el logro. Mantén el ritmo.';
    }

    if (ratio >= 0.75) {
      return 'Estás cerca. No dependas del impulso de una sola jornada; enfócate en la disciplina que te hará consistente mañana.';
    }

    if (ratio >= 0.4) {
      return 'Vas por buen camino. Celebra el progreso, pero apunta a la rutina más que al resultado inmediato.';
    }

    // Under 40%
    return 'Comienza con un paso dentro de tu control. Hoy un poco más — mañana otro poco. La disciplina construye el camino.';
  }
}
