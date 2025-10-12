import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Tipos de errores de la aplicación
enum AppErrorType {
  network,
  storage,
  authentication,
  validation,
  unknown,
}

// Clase para manejar errores de la aplicación
class AppError {
  final String message;
  final AppErrorType type;
  final String? details;
  final DateTime timestamp;

  AppError({
    required this.message,
    required this.type,
    this.details,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  @override
  String toString() {
    return 'AppError(type: $type, message: $message, details: $details)';
  }
}

// Provider para el manejo global de errores
final errorHandlerProvider = Provider<ErrorHandler>((ref) => ErrorHandler());

class ErrorHandler {
  static final List<AppError> _errors = [];
  static final List<VoidCallback> _listeners = [];

  // Agregar un error
  void addError(AppError error) {
    _errors.add(error);
    _notifyListeners();
    print('Error: ${error.toString()}');
  }

  // Agregar error desde excepción
  void addException(Exception exception, {String? context}) {
    final error = AppError(
      message: exception.toString(),
      type: _getErrorTypeFromException(exception),
      details: context,
    );
    addError(error);
  }

  // Obtener errores recientes
  List<AppError> getRecentErrors({int hours = 24}) {
    final cutoff = DateTime.now().subtract(Duration(hours: hours));
    return _errors.where((error) => error.timestamp.isAfter(cutoff)).toList();
  }

  // Limpiar errores antiguos
  void clearOldErrors({int days = 7}) {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    _errors.removeWhere((error) => error.timestamp.isBefore(cutoff));
  }

  // Limpiar todos los errores
  void clearAllErrors() {
    _errors.clear();
    _notifyListeners();
  }

  // Suscribirse a cambios de errores
  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  // Desuscribirse de cambios de errores
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void _notifyListeners() {
    for (final listener in _listeners) {
      try {
        listener();
      } catch (e) {
        print('Error notifying listener: $e');
      }
    }
  }

  AppErrorType _getErrorTypeFromException(Exception exception) {
    final message = exception.toString().toLowerCase();
    
    if (message.contains('network') || message.contains('connection')) {
      return AppErrorType.network;
    } else if (message.contains('storage') || message.contains('preferences')) {
      return AppErrorType.storage;
    } else if (message.contains('auth') || message.contains('login')) {
      return AppErrorType.authentication;
    } else if (message.contains('validation') || message.contains('invalid')) {
      return AppErrorType.validation;
    } else {
      return AppErrorType.unknown;
    }
  }
}

// Widget para mostrar errores
class ErrorDisplayWidget extends ConsumerWidget {
  final AppError error;
  final VoidCallback? onRetry;
  final VoidCallback? onDismiss;

  const ErrorDisplayWidget({
    Key? key,
    required this.error,
    this.onRetry,
    this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: _getErrorColor(error.type),
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  _getErrorIcon(error.type),
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _getErrorTitle(error.type),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (onDismiss != null)
                  GestureDetector(
                    onTap: onDismiss,
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              error.message,
              style: const TextStyle(color: Colors.white70),
            ),
            if (error.details != null) ...[
              const SizedBox(height: 4),
              Text(
                'Detalles: ${error.details}',
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                ),
              ),
            ],
            if (onRetry != null) ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onRetry,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getErrorColor(AppErrorType type) {
    switch (type) {
      case AppErrorType.network:
        return Colors.orange[600]!;
      case AppErrorType.storage:
        return Colors.red[600]!;
      case AppErrorType.authentication:
        return Colors.purple[600]!;
      case AppErrorType.validation:
        return Colors.amber[600]!;
      case AppErrorType.unknown:
        return Colors.grey[600]!;
    }
  }

  IconData _getErrorIcon(AppErrorType type) {
    switch (type) {
      case AppErrorType.network:
        return Icons.wifi_off;
      case AppErrorType.storage:
        return Icons.storage;
      case AppErrorType.authentication:
        return Icons.lock;
      case AppErrorType.validation:
        return Icons.warning;
      case AppErrorType.unknown:
        return Icons.error;
    }
  }

  String _getErrorTitle(AppErrorType type) {
    switch (type) {
      case AppErrorType.network:
        return 'Error de conexión';
      case AppErrorType.storage:
        return 'Error de almacenamiento';
      case AppErrorType.authentication:
        return 'Error de autenticación';
      case AppErrorType.validation:
        return 'Error de validación';
      case AppErrorType.unknown:
        return 'Error desconocido';
    }
  }
}

// Widget para mostrar lista de errores
class ErrorListWidget extends ConsumerWidget {
  final List<AppError> errors;
  final VoidCallback? onClearAll;

  const ErrorListWidget({
    Key? key,
    required this.errors,
    this.onClearAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (errors.isEmpty) {
      return const Center(
        child: Text('No hay errores recientes'),
      );
    }

    return Column(
      children: [
        if (onClearAll != null)
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onClearAll,
                  child: const Text('Limpiar todos'),
                ),
              ],
            ),
          ),
        Expanded(
          child: ListView.builder(
            itemCount: errors.length,
            itemBuilder: (context, index) {
              final error = errors[index];
              return ErrorDisplayWidget(
                error: error,
                onDismiss: () {
                  // Implementar lógica para remover error específico
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// Extensión para manejar errores en Future
extension FutureErrorHandling<T> on Future<T> {
  Future<T> handleErrors(ErrorHandler errorHandler, {String? context}) {
    return catchError((error) {
      if (error is Exception) {
        errorHandler.addException(error, context: context);
      } else {
        errorHandler.addError(AppError(
          message: error.toString(),
          type: AppErrorType.unknown,
          details: context,
        ));
      }
      rethrow;
    });
  }
}
