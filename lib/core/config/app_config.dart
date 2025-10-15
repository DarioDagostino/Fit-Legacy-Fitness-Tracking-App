class AppConfig {
  // Configuración de Gemini AI
  static const String geminiApiKey = 'YOUR_GEMINI_API_KEY_HERE';
  
  // Configuración de la app
  static const String appName = 'Fit Legacy';
  static const String appVersion = '1.0.0';
  
  // Metas por defecto
  static const int defaultDailySteps = 10000;
  static const int defaultDailyCalories = 500;
  static const int defaultDailyDistance = 5; // km
  
  // Configuración de rachas
  static const int maxStreakDays = 365;
  static const int streakMilestones = 7; // días para mostrar hitos
  
  // Configuración de Legacito
  static const int legacitoUpdateInterval = 30; // segundos
  static const int maxLegacitoMessages = 10;
  
  // Configuración de notificaciones
  static const int morningReminderHour = 8;
  static const int eveningReminderHour = 20;
  
  // Configuración de Gemini AI
  static const double geminiTemperature = 0.7;
  static const int geminiMaxTokens = 1024;
  static const int geminiTopK = 40;
  static const double geminiTopP = 0.95;
  
  // URLs y endpoints
  static const String privacyPolicyUrl = 'https://fitlegacy.app/privacy';
  static const String termsOfServiceUrl = 'https://fitlegacy.app/terms';
  static const String supportEmail = 'support@fitlegacy.app';
  
  // Configuración de analytics
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  
  // Configuración de debug
  static const bool enableDebugMode = true;
  static const bool enableVerboseLogging = false;
  
  // Validar configuración
  static bool get isGeminiConfigured => geminiApiKey != 'YOUR_GEMINI_API_KEY_HERE';
  
  // Obtener configuración de Gemini
  static Map<String, dynamic> get geminiConfig => {
    'apiKey': geminiApiKey,
    'temperature': geminiTemperature,
    'maxTokens': geminiMaxTokens,
    'topK': geminiTopK,
    'topP': geminiTopP,
  };
  
  // Obtener configuración de la app
  static Map<String, dynamic> get appInfo => {
    'name': appName,
    'version': appVersion,
    'debugMode': enableDebugMode,
    'analytics': enableAnalytics,
  };
}
