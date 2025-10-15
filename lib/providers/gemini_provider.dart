import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

// Provider para Gemini AI
final geminiProvider = StateNotifierProvider<GeminiNotifier, GeminiState>((ref) {
  return GeminiNotifier();
});

// Provider para respuestas de Legacito
final legacitoResponseProvider = Provider<String>((ref) {
  final state = ref.watch(geminiProvider);
  return state.lastResponse;
});

class GeminiState {
  final bool isInitialized;
  final bool isLoading;
  final String lastResponse;
  final String? error;
  final List<ChatMessage> conversationHistory;

  const GeminiState({
    this.isInitialized = false,
    this.isLoading = false,
    this.lastResponse = '',
    this.error,
    this.conversationHistory = const [],
  });

  GeminiState copyWith({
    bool? isInitialized,
    bool? isLoading,
    String? lastResponse,
    String? error,
    List<ChatMessage>? conversationHistory,
  }) {
    return GeminiState(
      isInitialized: isInitialized ?? this.isInitialized,
      isLoading: isLoading ?? this.isLoading,
      lastResponse: lastResponse ?? this.lastResponse,
      error: error ?? this.error,
      conversationHistory: conversationHistory ?? this.conversationHistory,
    );
  }
}

class ChatMessage {
  final String role; // 'user' or 'model'
  final String content;

  const ChatMessage({
    required this.role,
    required this.content,
  });

  Map<String, dynamic> toJson() => {
    'role': role,
    'content': content,
  };
}

class GeminiNotifier extends StateNotifier<GeminiState> {
  GenerativeModel? _model;
  ChatSession? _chatSession;

  GeminiNotifier() : super(const GeminiState()) {
    _initializeGemini();
  }

  // Inicializar Gemini AI
  Future<void> _initializeGemini() async {
    try {
      // TODO: Reemplazar con tu API key real
      const apiKey = 'YOUR_GEMINI_API_KEY_HERE';
      
      if (apiKey == 'YOUR_GEMINI_API_KEY_HERE') {
        state = state.copyWith(
          error: 'API key de Gemini no configurada',
        );
        return;
      }

      _model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
        generationConfig: GenerationConfig(
          temperature: 0.7,
          topK: 40,
          topP: 0.95,
          maxOutputTokens: 1024,
        ),
        safetySettings: [
          SafetySetting(
            HarmCategory.harassment,
            HarmBlockThreshold.medium,
          ),
          SafetySetting(
            HarmCategory.hateSpeech,
            HarmBlockThreshold.medium,
          ),
          SafetySetting(
            HarmCategory.sexuallyExplicit,
            HarmBlockThreshold.medium,
          ),
          SafetySetting(
            HarmCategory.dangerousContent,
            HarmBlockThreshold.medium,
          ),
        ],
      );

      // Crear sesión de chat con contexto estoico
      _chatSession = _model!.startChat(
        history: [
          Content.text('''
Eres Legacito, un compañero de entrenamiento estoico y motivacional. Tu personalidad se basa en la filosofía estoica de Marco Aurelio, Epicteto y Séneca.

CARACTERÍSTICAS:
- Eres sabio, pero accesible
- Usas analogías estoicas para motivar
- Eres directo pero compasivo
- Te enfocas en lo que se puede controlar
- Celebras los logros pero mantienes la humildad
- Usas frases motivacionales basadas en la filosofía estoica

RESPUESTAS:
- Máximo 2-3 oraciones
- Usa emojis ocasionalmente
- Incluye citas estoicas cuando sea apropiado
- Mantén un tono motivacional pero realista
- Enfócate en la disciplina y el autocontrol

CONTEXTO:
El usuario está usando una app de fitness llamada "Fit Legacy" que combina ejercicio con filosofía estoica. Ayúdale a mantenerse motivado y disciplinado.
'''),
        ],
      );

      state = state.copyWith(
        isInitialized: true,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Error al inicializar Gemini: $e',
      );
    }
  }

  // Enviar mensaje a Gemini
  Future<String> sendMessage(String userMessage) async {
    if (!state.isInitialized || _model == null || _chatSession == null) {
      return _getFallbackResponse(userMessage);
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      // Agregar mensaje del usuario al historial
      final userChatMessage = ChatMessage(role: 'user', content: userMessage);
      final updatedHistory = [...state.conversationHistory, userChatMessage];

      // Enviar mensaje a Gemini
      final response = await _chatSession!.sendMessage(
        Content.text(userMessage),
      );

      final responseText = response.text ?? _getFallbackResponse(userMessage);

      // Agregar respuesta del modelo al historial
      final modelChatMessage = ChatMessage(role: 'model', content: responseText);
      final finalHistory = [...updatedHistory, modelChatMessage];

      state = state.copyWith(
        isLoading: false,
        lastResponse: responseText,
        conversationHistory: finalHistory,
        error: null,
      );

      return responseText;
    } catch (e) {
      final fallbackResponse = _getFallbackResponse(userMessage);
      
      state = state.copyWith(
        isLoading: false,
        lastResponse: fallbackResponse,
        error: 'Error al procesar mensaje: $e',
      );

      return fallbackResponse;
    }
  }

  // Respuesta de fallback cuando Gemini no está disponible
  String _getFallbackResponse(String userMessage) {
    final message = userMessage.toLowerCase();
    
    if (message.contains('cansado') || message.contains('fatiga')) {
      return 'La fatiga es temporal, pero la disciplina es eterna. Recuerda: "La dificultad muestra al hombre." - Epicteto 🔥';
    } else if (message.contains('motivación') || message.contains('motivado')) {
      return 'La motivación externa es efímera. La disciplina interna es lo que te llevará lejos. ¡Vamos! 💪';
    } else if (message.contains('meta') || message.contains('objetivo')) {
      return 'Los objetivos grandes se logran paso a paso. Cada día es una oportunidad de ser mejor que ayer. 🎯';
    } else if (message.contains('fracaso') || message.contains('fallé')) {
      return 'No hay fracasos, solo lecciones. Marco Aurelio dijo: "El obstáculo se convierte en el camino." 🌟';
    } else if (message.contains('éxito') || message.contains('logré')) {
      return '¡Excelente! Pero recuerda: la humildad en la victoria es tan importante como la perseverancia en la derrota. 🏆';
    } else if (message.contains('pasos') || message.contains('caminar')) {
      return 'Cada paso es una decisión consciente. Cada paso te acerca a tu mejor versión. ¡Continúa! 🚶‍♂️';
    } else if (message.contains('dolor') || message.contains('duele')) {
      return 'El dolor es inevitable, pero el sufrimiento es opcional. Usa este momento para fortalecerte. 💪';
    } else if (message.contains('disciplina')) {
      return 'La disciplina es el puente entre las metas y los logros. Séneca estaría orgulloso de tu enfoque. ⚡';
    } else if (message.contains('consistencia')) {
      return 'La consistencia es la clave del éxito. Como dijo Marco Aurelio: "La excelencia es un hábito, no un acto." 🌟';
    } else {
      return 'La sabiduría estoica nos enseña que solo podemos controlar nuestras acciones y pensamientos. ¿Qué puedes hacer hoy para ser mejor? 🤔';
    }
  }

  // Obtener respuesta motivacional basada en el progreso
  String getMotivationalResponse(int steps, int goal, int streakDays) {
    final progress = steps / goal;
    
    if (progress >= 1.0) {
      return '¡INCREÍBLE! Has alcanzado tu meta. Marco Aurelio estaría orgulloso de tu disciplina. 🎉';
    } else if (progress >= 0.8) {
      return '¡Excelente progreso! Estás muy cerca de tu meta. La disciplina te está llevando lejos. 🔥';
    } else if (progress >= 0.5) {
      return 'Buen ritmo. Recuerda: "El obstáculo se convierte en el camino." Sigue adelante. 💪';
    } else if (progress >= 0.2) {
      return 'Cada paso cuenta. La jornada de mil millas comienza con un paso. ¡No te rindas! 🚶‍♂️';
    } else {
      return 'El día aún no termina. Cada paso es una decisión consciente. ¡Vamos! 🌅';
    }
  }

  // Obtener respuesta basada en la racha
  String getStreakResponse(int streakDays) {
    if (streakDays == 0) {
      return 'Cada jornada comienza con un solo paso. Hoy es tu día para empezar. 🌅';
    } else if (streakDays < 7) {
      return '¡Buen comienzo! La disciplina se construye día a día. Sigue así. 💪';
    } else if (streakDays < 30) {
      return '¡Excelente! Estás construyendo un hábito sólido. La consistencia es tu aliada. 🔥';
    } else if (streakDays < 100) {
      return '¡Increíble! Eres un verdadero estoico. La disciplina se ha convertido en tu naturaleza. ⚡';
    } else {
      return '¡Legendario! Eres un maestro de la disciplina. Séneca estaría orgulloso. 🏆';
    }
  }

  // Limpiar historial de conversación
  void clearHistory() {
    state = state.copyWith(
      conversationHistory: [],
      lastResponse: '',
    );
  }

  // Obtener estadísticas de la conversación
  Map<String, dynamic> getConversationStats() {
    return {
      'totalMessages': state.conversationHistory.length,
      'userMessages': state.conversationHistory.where((msg) => msg.role == 'user').length,
      'modelMessages': state.conversationHistory.where((msg) => msg.role == 'model').length,
      'isInitialized': state.isInitialized,
      'hasError': state.error != null,
    };
  }
}
