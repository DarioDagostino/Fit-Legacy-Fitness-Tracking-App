import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../services/app_state_service.dart';
import '../widgets/legacito_widget.dart';

final mockStepsProvider = StateNotifierProvider<MockStepsNotifier, int>((ref) => MockStepsNotifier());

class MockStepsNotifier extends StateNotifier<int> {
  MockStepsNotifier(): super(4367) {
    // Simulate small increments every few seconds in debug mode if desired.
  }

  void add(int delta) => state = state + delta;
  void reset() => state = 0;
}

class StepTrackingScreen extends ConsumerStatefulWidget {
  const StepTrackingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<StepTrackingScreen> createState() => _StepTrackingScreenState();
}

class _StepTrackingScreenState extends ConsumerState<StepTrackingScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // Inicializar datos
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(appStateProvider.notifier).initialize();
      _progressController.forward();
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final steps = ref.watch(mockStepsProvider);
    final appState = ref.watch(appStateProvider);
    final progress = (steps / 10000).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seguimiento de pasos'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          _buildMainContent(steps, progress),
          // Overlay de Legacito
          LegacitoOverlay(),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(steps),
    );
  }

  Widget _buildMainContent(int steps, double progress) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 12),
          Text('Hoy', style: AppTextStyles.headline2),
          const SizedBox(height: 18),
          _buildProgressCircle(steps, progress),
          const SizedBox(height: 20),
          _buildProgressBar(progress),
          const SizedBox(height: 18),
          _buildActionButtons(),
          const SizedBox(height: 24),
          _buildWeeklyHistory(),
        ],
      ),
    );
  }

  Widget _buildProgressCircle(int steps, double progress) {
    return SizedBox(
      height: 220,
      child: Center(
        child: AnimatedBuilder(
          animation: _progressAnimation,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 180,
                  height: 180,
                  child: CircularProgressIndicator(
                    value: progress * _progressAnimation.value,
                    strokeWidth: 14,
                    backgroundColor: AppColors.surface,
                    color: AppColors.accent,
                  ),
                ),
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            steps.toString(),
                            style: AppTextStyles.headline1.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${(progress * 100).toStringAsFixed(0)}% de 10.000',
                            style: AppTextStyles.body1,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProgressBar(double progress) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Progreso diario', style: AppTextStyles.body1),
            Text('${(progress * 100).toStringAsFixed(0)}%', style: AppTextStyles.body1),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          color: AppColors.accent,
          backgroundColor: AppColors.surface,
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () => _addSteps(500),
          icon: const Icon(Icons.directions_walk),
          label: const Text('+500'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: Colors.white,
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => _addSteps(1000),
          icon: const Icon(Icons.add),
          label: const Text('+1000'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
        ),
        OutlinedButton(
          onPressed: () => ref.read(mockStepsProvider.notifier).reset(),
          child: const Text('Reset'),
        ),
      ],
    );
  }

  Widget _buildWeeklyHistory() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Historial semanal',
              style: AppTextStyles.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 7,
              itemBuilder: (context, index) {
                final daySteps = 2000 + (index * 1000);
                final dayProgress = (daySteps / 10000).clamp(0.0, 1.0);
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: dayProgress >= 1.0 
                        ? Colors.green[100] 
                        : Colors.grey[200],
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: dayProgress >= 1.0 
                            ? Colors.green[700] 
                            : Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text('Día ${index + 1}'),
                  subtitle: Text('$daySteps pasos'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${(dayProgress * 100).toStringAsFixed(0)}%',
                        style: AppTextStyles.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (dayProgress >= 1.0)
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 16,
                        ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(int steps) {
    return FloatingActionButton.extended(
      tooltip: 'Legacito',
      icon: const Icon(Icons.psychology),
      label: const Text('Legacito'),
      onPressed: () => _showLegacitoDialog(steps),
      backgroundColor: Colors.purple[600],
      foregroundColor: Colors.white,
    );
  }

  void _addSteps(int delta) async {
    try {
      // Actualizar pasos
      ref.read(mockStepsProvider.notifier).add(delta);
      
      // Procesar en el sistema de rachas
      await ref.read(appStateProvider.notifier).processGoalCompletion(
        type: 'steps',
        goalId: 'step_$delta',
        userId: 'current_user', // En una app real, esto vendría del auth
      );
      
      // Animar el pulso
      _pulseController.forward().then((_) {
        _pulseController.reverse();
      });
      
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al procesar pasos: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showLegacitoDialog(int steps) {
    final legacito = ref.read(appStateProvider.notifier);
    final quote = legacito.getDailyQuote();
    final evaluation = ref.read(legacitoServiceProvider).evaluateProgress(
      steps: steps, 
      goal: 10000,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(Icons.psychology, color: Colors.purple[600]),
            const SizedBox(width: 8),
            const Text('Legacito'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                quote,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Tu progreso:',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(evaluation),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}
