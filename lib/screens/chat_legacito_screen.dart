import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../core/constants/app_spacing.dart';
import '../widgets/pixel_perfect_widgets.dart';
import '../widgets/legacito_widget.dart';
import '../providers/legacito_provider.dart';
import '../providers/gemini_provider.dart';
import '../models/legacito_state.dart';

class ChatLegacitoScreen extends ConsumerStatefulWidget {
  const ChatLegacitoScreen({super.key});

  @override
  ConsumerState<ChatLegacitoScreen> createState() => _ChatLegacitoScreenState();
}

class _ChatLegacitoScreenState extends ConsumerState<ChatLegacitoScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _addWelcomeMessage();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _addWelcomeMessage() {
    _messages.add(ChatMessage(
      text: '¡Hola! Soy Legacito, tu compañero estoico. ¿Cómo te sientes hoy?',
      isFromLegacito: true,
      timestamp: DateTime.now(),
    ));
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    // Agregar mensaje del usuario
    _messages.add(ChatMessage(
      text: text,
      isFromLegacito: false,
      timestamp: DateTime.now(),
    ));

    // Limpiar campo
    _messageController.clear();

    // Simular respuesta de Legacito
    _simulateLegacitoResponse(text);

    // Scroll hacia abajo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    setState(() {});
  }

  void _simulateLegacitoResponse(String userMessage) async {
    // Usar Gemini AI para respuesta inteligente
    final geminiNotifier = ref.read(geminiProvider.notifier);
    
    try {
      final response = await geminiNotifier.sendMessage(userMessage);
      
      if (mounted) {
        _messages.add(ChatMessage(
          text: response,
          isFromLegacito: true,
          timestamp: DateTime.now(),
        ));
        
        // Actualizar estado de Legacito
        ref.read(legacitoProvider.notifier).sendMessage(response);
        
        setState(() {});
        
        // Scroll hacia abajo
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
    } catch (e) {
      // Fallback a respuesta local si Gemini falla
      final fallbackResponse = _getStoicResponse(userMessage.toLowerCase());
      
      if (mounted) {
        _messages.add(ChatMessage(
          text: fallbackResponse,
          isFromLegacito: true,
          timestamp: DateTime.now(),
        ));
        
        setState(() {});
      }
    }
  }

  String _getStoicResponse(String message) {
    if (message.contains('cansado') || message.contains('fatiga')) {
      return 'La fatiga es temporal, pero la disciplina es eterna. Recuerda: "La dificultad muestra al hombre." - Epicteto';
    } else if (message.contains('motivación') || message.contains('motivado')) {
      return 'La motivación externa es efímera. La disciplina interna es lo que te llevará lejos. ¡Vamos!';
    } else if (message.contains('meta') || message.contains('objetivo')) {
      return 'Los objetivos grandes se logran paso a paso. Cada día es una oportunidad de ser mejor que ayer.';
    } else if (message.contains('fracaso') || message.contains('fallé')) {
      return 'No hay fracasos, solo lecciones. Marco Aurelio dijo: "El obstáculo se convierte en el camino."';
    } else if (message.contains('éxito') || message.contains('logré')) {
      return '¡Excelente! Pero recuerda: la humildad en la victoria es tan importante como la perseverancia en la derrota.';
    } else if (message.contains('pasos') || message.contains('caminar')) {
      return 'Cada paso es una decisión consciente. Cada paso te acerca a tu mejor versión. ¡Continúa!';
    } else if (message.contains('dolor') || message.contains('duele')) {
      return 'El dolor es inevitable, pero el sufrimiento es opcional. Usa este momento para fortalecerte.';
    } else {
      return 'La sabiduría estoica nos enseña que solo podemos controlar nuestras acciones y pensamientos. ¿Qué puedes hacer hoy para ser mejor?';
    }
  }

  @override
  Widget build(BuildContext context) {
    final legacitoState = ref.watch(legacitoProvider);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Legacito header
          _buildLegacitoHeader(),
          
          // Chat messages
          Expanded(
            child: _buildMessagesList(),
          ),
          
          // Message input
          _buildMessageInput(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        'Chat con Legacito',
        style: AppTextStyles.h5.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: AppColors.background,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {
            // Cambiar estado de Legacito
            ref.read(legacitoProvider.notifier).forceMoodChange(
              LegacitoMood.values[DateTime.now().millisecond % LegacitoMood.values.length],
            );
          },
          icon: Icon(
            Icons.psychology,
            size: AppSpacing.iconMedium,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildLegacitoHeader() {
    return Container(
      padding: EdgeInsets.all(AppSpacing.paddingCard),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppSpacing.radiusLarge),
          bottomRight: Radius.circular(AppSpacing.radiusLarge),
        ),
      ),
      child: Row(
        children: [
          // Legacito compacto
          const LegacitoCompactWidget(),
          
          AppGap.custom(AppSpacing.marginCard),
          
          // Info de Legacito
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Legacito',
                  style: AppTextStyles.h6.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                AppGap.custom(AppSpacing.marginXs),
                Text(
                  'Tu compañero estoico',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
                AppGap.custom(AppSpacing.marginXs),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.paddingSm,
                    vertical: AppSpacing.paddingXs,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSmall),
                  ),
                  child: Text(
                    '${legacitoState.streakDays} días de racha',
                    style: AppTextStyles.caption.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: 600.ms)
      .slideY(begin: -0.1, end: 0);
  }

  Widget _buildMessagesList() {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.all(AppSpacing.paddingCard),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        return _buildMessageBubble(message, index);
      },
    );
  }

  Widget _buildMessageBubble(ChatMessage message, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.marginCard),
      child: Row(
        mainAxisAlignment: message.isFromLegacito 
            ? MainAxisAlignment.start 
            : MainAxisAlignment.end,
        children: [
          if (message.isFromLegacito) ...[
            // Avatar de Legacito
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.psychology,
                size: 16.sp,
                color: Colors.white,
              ),
            ),
            AppGap.custom(AppSpacing.marginXs),
          ],
          
          // Burbuja de mensaje
          Flexible(
            child: Container(
              padding: EdgeInsets.all(AppSpacing.paddingCard),
              decoration: BoxDecoration(
                color: message.isFromLegacito 
                    ? AppColors.surfaceVariant
                    : AppColors.primary,
                borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: 8.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: message.isFromLegacito 
                          ? AppColors.textPrimary
                          : Colors.white,
                    ),
                  ),
                  AppGap.custom(AppSpacing.marginXs),
                  Text(
                    _formatTime(message.timestamp),
                    style: AppTextStyles.caption.copyWith(
                      color: message.isFromLegacito 
                          ? AppColors.textSecondary
                          : Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          if (!message.isFromLegacito) ...[
            AppGap.custom(AppSpacing.marginXs),
            // Avatar del usuario
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                size: 16.sp,
                color: Colors.white,
              ),
            ),
          ],
        ],
      ),
    ).animate(delay: (index * 100).ms)
      .fadeIn(duration: 300.ms)
      .slideX(begin: message.isFromLegacito ? -0.2 : 0.2, end: 0);
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(AppSpacing.paddingCard),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 10.r,
            offset: Offset(0, -2.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Escribe tu mensaje...',
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textTertiary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
                  borderSide: BorderSide(color: AppColors.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
                  borderSide: BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.paddingCard,
                  vertical: AppSpacing.paddingSm,
                ),
              ),
              maxLines: null,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          AppGap.custom(AppSpacing.marginCard),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(AppSpacing.radiusCircular),
              ),
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: AppSpacing.iconMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inMinutes < 1) {
      return 'Ahora';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h';
    } else {
      return '${difference.inDays}d';
    }
  }
}

class ChatMessage {
  final String text;
  final bool isFromLegacito;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isFromLegacito,
    required this.timestamp,
  });
}
