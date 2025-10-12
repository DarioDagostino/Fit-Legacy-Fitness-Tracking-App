import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

enum LogLevel {
  debug,
  info,
  warning,
  error,
  fatal,
}

class Logger {
  static const String _tag = 'FitLegacy';
  
  static void debug(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.debug, message, tag: tag, error: error, stackTrace: stackTrace);
  }

  static void info(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.info, message, tag: tag, error: error, stackTrace: stackTrace);
  }

  static void warning(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.warning, message, tag: tag, error: error, stackTrace: stackTrace);
  }

  static void error(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.error, message, tag: tag, error: error, stackTrace: stackTrace);
  }

  static void fatal(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.fatal, message, tag: tag, error: error, stackTrace: stackTrace);
  }

  static void _log(
    LogLevel level,
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final logTag = tag ?? _tag;
    final timestamp = DateTime.now().toIso8601String();
    final levelString = level.name.toUpperCase();
    
    final logMessage = '[$timestamp] [$levelString${tag != null ? ':$tag' : ''}] $message';
    
    if (kDebugMode) {
      // En modo debug, usar developer.log para mejor formato
      developer.log(
        logMessage,
        name: logTag,
        level: _getLogLevelValue(level),
        error: error,
        stackTrace: stackTrace,
      );
    } else {
      // En release, solo imprimir errores y fatales
      if (level == LogLevel.error || level == LogLevel.fatal) {
        print(logMessage);
        if (error != null) print('Error: $error');
        if (stackTrace != null) print('Stack trace: $stackTrace');
      }
    }
  }

  static int _getLogLevelValue(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 500;
      case LogLevel.info:
        return 800;
      case LogLevel.warning:
        return 900;
      case LogLevel.error:
        return 1000;
      case LogLevel.fatal:
        return 1200;
    }
  }
}

// Logger específico para diferentes módulos
class StreaksLogger {
  static const String _tag = 'Streaks';
  
  static void debug(String message, {Object? error, StackTrace? stackTrace}) {
    Logger.debug(message, tag: _tag, error: error, stackTrace: stackTrace);
  }

  static void info(String message, {Object? error, StackTrace? stackTrace}) {
    Logger.info(message, tag: _tag, error: error, stackTrace: stackTrace);
  }

  static void warning(String message, {Object? error, StackTrace? stackTrace}) {
    Logger.warning(message, tag: _tag, error: error, stackTrace: stackTrace);
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    Logger.error(message, tag: _tag, error: error, stackTrace: stackTrace);
  }
}

class EventLogger {
  static const String _tag = 'Events';
  
  static void debug(String message, {Object? error, StackTrace? stackTrace}) {
    Logger.debug(message, tag: _tag, error: error, stackTrace: stackTrace);
  }

  static void info(String message, {Object? error, StackTrace? stackTrace}) {
    Logger.info(message, tag: _tag, error: error, stackTrace: stackTrace);
  }

  static void warning(String message, {Object? error, StackTrace? stackTrace}) {
    Logger.warning(message, tag: _tag, error: error, stackTrace: stackTrace);
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    Logger.error(message, tag: _tag, error: error, stackTrace: stackTrace);
  }
}

class UILogger {
  static const String _tag = 'UI';
  
  static void debug(String message, {Object? error, StackTrace? stackTrace}) {
    Logger.debug(message, tag: _tag, error: error, stackTrace: stackTrace);
  }

  static void info(String message, {Object? error, StackTrace? stackTrace}) {
    Logger.info(message, tag: _tag, error: error, stackTrace: stackTrace);
  }

  static void warning(String message, {Object? error, StackTrace? stackTrace}) {
    Logger.warning(message, tag: _tag, error: error, stackTrace: stackTrace);
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    Logger.error(message, tag: _tag, error: error, stackTrace: stackTrace);
  }
}

class LegacitoLogger {
  static const String _tag = 'Legacito';
  
  static void debug(String message, {Object? error, StackTrace? stackTrace}) {
    Logger.debug(message, tag: _tag, error: error, stackTrace: stackTrace);
  }

  static void info(String message, {Object? error, StackTrace? stackTrace}) {
    Logger.info(message, tag: _tag, error: error, stackTrace: stackTrace);
  }

  static void warning(String message, {Object? error, StackTrace? stackTrace}) {
    Logger.warning(message, tag: _tag, error: error, stackTrace: stackTrace);
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    Logger.error(message, tag: _tag, error: error, stackTrace: stackTrace);
  }
}
