import 'package:flutter/foundation.dart';

class AppConfig {
  // Configuración de la aplicación
  static const String appName = 'Fit Legacy';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';
  
  // Configuración de desarrollo
  static const bool isDebugMode = kDebugMode;
  static const bool isReleaseMode = kReleaseMode;
  static const bool isProfileMode = kProfileMode;
  
  // Configuración de caché
  static const Duration cacheExpiration = Duration(minutes: 5);
  static const int maxCacheSize = 100;
  static const int maxEventQueueSize = 1000;
  
  // Configuración de animaciones
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);
  static const Duration slowAnimationDuration = Duration(milliseconds: 500);
  
  // Configuración de Legacito
  static const Duration legacitoMessageDuration = Duration(seconds: 3);
  static const int maxLegacitoMessages = 5;
  
  // Configuración de streaks
  static const int defaultDailyGoal = 10000; // pasos
  static const int streakMilestones = 7; // días para milestone
  static const int maxStreakHistory = 365; // días de historial
  
  // Configuración de eventos
  static const Duration eventRetentionPeriod = Duration(days: 30);
  static const int maxEventsPerBatch = 50;
  
  // Configuración de UI
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double defaultBorderRadius = 12.0;
  static const double smallBorderRadius = 8.0;
  static const double largeBorderRadius = 16.0;
  
  // Configuración de rendimiento
  static const int maxConcurrentOperations = 3;
  static const Duration operationTimeout = Duration(seconds: 30);
  static const int maxRetryAttempts = 3;
  
  // Configuración de logging
  static const bool enableDetailedLogging = isDebugMode;
  static const bool enablePerformanceLogging = isDebugMode;
  static const bool enableErrorReporting = true;
  
  // Configuración de Firebase
  static const bool enableFirebaseAnalytics = !isDebugMode;
  static const bool enableFirebaseCrashlytics = !isDebugMode;
  
  // Configuración de desarrollo
  static const bool enableMockData = isDebugMode;
  static const bool enableDebugOverlay = isDebugMode;
  static const bool enablePerformanceOverlay = isDebugMode;
  
  // Métodos de utilidad
  static bool get isProduction => isReleaseMode;
  static bool get isDevelopment => isDebugMode;
  
  static Duration getAnimationDuration(String type) {
    switch (type) {
      case 'fast':
        return fastAnimationDuration;
      case 'slow':
        return slowAnimationDuration;
      default:
        return defaultAnimationDuration;
    }
  }
  
  static double getPadding(String size) {
    switch (size) {
      case 'small':
        return smallPadding;
      case 'large':
        return largePadding;
      default:
        return defaultPadding;
    }
  }
  
  static double getBorderRadius(String size) {
    switch (size) {
      case 'small':
        return smallBorderRadius;
      case 'large':
        return largeBorderRadius;
      default:
        return defaultBorderRadius;
    }
  }
}
