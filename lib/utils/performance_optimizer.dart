import 'dart:async';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'logger.dart';

// Provider para el optimizador de rendimiento
final performanceOptimizerProvider = Provider<PerformanceOptimizer>((ref) => PerformanceOptimizer());

class PerformanceOptimizer {
  static final Map<String, DateTime> _lastExecution = {};
  static final Map<String, Timer> _debounceTimers = {};
  static final Queue<String> _memoryWarnings = Queue<String>();
  
  // Debounce para evitar llamadas excesivas
  static void debounce(
    String key,
    Duration duration,
    VoidCallback callback, {
    bool cancelPrevious = true,
  }) {
    if (cancelPrevious && _debounceTimers.containsKey(key)) {
      _debounceTimers[key]?.cancel();
    }
    
    _debounceTimers[key] = Timer(duration, () {
      callback();
      _debounceTimers.remove(key);
    });
  }

  // Throttle para limitar la frecuencia de ejecución
  static bool throttle(String key, Duration duration) {
    final now = DateTime.now();
    final lastExec = _lastExecution[key];
    
    if (lastExec == null || now.difference(lastExec) >= duration) {
      _lastExecution[key] = now;
      return true;
    }
    
    return false;
  }

  // Memoización simple para funciones costosas
  static final Map<String, dynamic> _memoCache = {};
  
  static T memoize<T>(String key, T Function() computation) {
    if (_memoCache.containsKey(key)) {
      return _memoCache[key] as T;
    }
    
    final result = computation();
    _memoCache[key] = result;
    return result;
  }

  // Limpiar cache de memoización
  static void clearMemoCache() {
    _memoCache.clear();
    Logger.info('Memoization cache cleared');
  }

  // Verificar uso de memoria
  static void checkMemoryUsage() {
    if (kDebugMode) {
      // En debug mode, verificar el tamaño de los caches
      final cacheSize = _memoCache.length;
      final debounceSize = _debounceTimers.length;
      final executionSize = _lastExecution.length;
      
      if (cacheSize > 100) {
        _memoryWarnings.add('Memo cache size: $cacheSize');
      }
      
      if (debounceSize > 50) {
        _memoryWarnings.add('Debounce timers: $debounceSize');
      }
      
      if (executionSize > 200) {
        _memoryWarnings.add('Execution history: $executionSize');
      }
      
      // Limpiar warnings antiguos
      if (_memoryWarnings.length > 10) {
        _memoryWarnings.removeFirst();
      }
    }
  }

  // Limpiar recursos
  static void cleanup() {
    // Cancelar todos los timers
    for (final timer in _debounceTimers.values) {
      timer.cancel();
    }
    _debounceTimers.clear();
    
    // Limpiar caches
    _memoCache.clear();
    _lastExecution.clear();
    _memoryWarnings.clear();
    
    Logger.info('Performance optimizer cleaned up');
  }

  // Obtener estadísticas de rendimiento
  static Map<String, dynamic> getPerformanceStats() {
    return {
      'memoCacheSize': _memoCache.length,
      'debounceTimers': _debounceTimers.length,
      'executionHistory': _lastExecution.length,
      'memoryWarnings': _memoryWarnings.length,
    };
  }
}

// Mixin para widgets que necesitan optimización
mixin PerformanceOptimizedMixin<T extends StatefulWidget> on State<T> {
  final Map<String, Timer> _localTimers = {};
  
  @override
  void dispose() {
    // Limpiar timers locales
    for (final timer in _localTimers.values) {
      timer.cancel();
    }
    _localTimers.clear();
    super.dispose();
  }
  
  void debounceLocal(String key, Duration duration, VoidCallback callback) {
    if (_localTimers.containsKey(key)) {
      _localTimers[key]?.cancel();
    }
    
    _localTimers[key] = Timer(duration, () {
      callback();
      _localTimers.remove(key);
    });
  }
  
  void throttleLocal(String key, Duration duration, VoidCallback callback) {
    if (PerformanceOptimizer.throttle('${T.toString()}_$key', duration)) {
      callback();
    }
  }
}

// Widget optimizado para listas grandes
class OptimizedListView extends StatelessWidget {
  final List<Widget> children;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const OptimizedListView({
    Key? key,
    required this.children,
    this.controller,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: children.length,
      itemBuilder: (context, index) {
        // Usar memoización para widgets complejos
        return PerformanceOptimizer.memoize(
          'list_item_$index',
          () => children[index],
        );
      },
    );
  }
}

// Provider para estadísticas de rendimiento
final performanceStatsProvider = StateProvider<Map<String, dynamic>>((ref) {
  return PerformanceOptimizer.getPerformanceStats();
});

// Notifier para monitorear rendimiento
class PerformanceMonitor extends StateNotifier<Map<String, dynamic>> {
  PerformanceMonitor() : super({}) {
    _startMonitoring();
  }

  void _startMonitoring() {
    Timer.periodic(const Duration(seconds: 30), (timer) {
      PerformanceOptimizer.checkMemoryUsage();
      state = PerformanceOptimizer.getPerformanceStats();
    });
  }

  void forceCleanup() {
    PerformanceOptimizer.cleanup();
    state = PerformanceOptimizer.getPerformanceStats();
  }
}

final performanceMonitorProvider = StateNotifierProvider<PerformanceMonitor, Map<String, dynamic>>((ref) {
  return PerformanceMonitor();
});
