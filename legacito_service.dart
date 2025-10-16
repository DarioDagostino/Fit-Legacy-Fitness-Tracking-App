import 'package:fit_legacy/data/services/legacito_quotes.dart';

class LegacitoService {
  /// Gets a deterministic "quote of the day" based on the current day of the year.
  static String getQuoteOfTheDay() {
    final now = DateTime.now();
    final dayOfYear = _dayOfYear(now);
    final quoteIndex = dayOfYear % legacitoQuotes.length;
    return legacitoQuotes[quoteIndex];
  }

  /// Calculates the day number within the year (1-366).
  static int _dayOfYear(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    return date.difference(firstDayOfYear).inDays + 1;
  }
}