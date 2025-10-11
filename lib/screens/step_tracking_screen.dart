import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';
import '../services/legacito_service.dart';
import '../services/event_service.dart';
import '../services/streaks_service.dart';

final mockStepsProvider = StateNotifierProvider<MockStepsNotifier, int>((ref) => MockStepsNotifier());
final _eventService = EventService();
final _streaksService = StreaksService();

class MockStepsNotifier extends StateNotifier<int> {
  MockStepsNotifier(): super(4367) {
    // Simulate small increments every few seconds in debug mode if desired.
  }

  void add(int delta) => state = state + delta;
  void reset() => state = 0;
}

class StepTrackingScreen extends ConsumerWidget {
  const StepTrackingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final steps = ref.watch(mockStepsProvider);
    final legacito = ref.read(legacitoProvider);

    final progress = (steps / 10000).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(title: const Text('Seguimiento de pasos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            Text('Hoy', style: AppTextStyles.headline2),
            const SizedBox(height: 18),
            SizedBox(
              height: 220,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                      height: 180,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 14,
                        backgroundColor: AppColors.surface,
                        color: AppColors.accent,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(steps.toString(), style: AppTextStyles.headline1.copyWith(color: AppColors.textPrimary)),
                        const SizedBox(height: 6),
                        Text('${(progress * 100).toStringAsFixed(0)}% de 10.000', style: AppTextStyles.body1),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            LinearProgressIndicator(value: progress, color: AppColors.accent, backgroundColor: AppColors.surface),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(onPressed: () async { 
                    ref.read(mockStepsProvider.notifier).add(500);
                    final now = DateTime.now().toUtc();
                    await _eventService.enqueueEvent({'type':'goal_completed','source':'steps','timestamp': now.toIso8601String(), 'goalId':'step_500','points':500});
                    await _streaksService.processGoalCompleted(type: 'daily', goalId: 'step_500', timestamp: now);
                  }, icon: const Icon(Icons.directions_walk), label: const Text('+500')),
                ElevatedButton.icon(onPressed: () async { 
                    ref.read(mockStepsProvider.notifier).add(1000);
                    final now = DateTime.now().toUtc();
                    await _eventService.enqueueEvent({'type':'goal_completed','source':'steps','timestamp': now.toIso8601String(), 'goalId':'step_1000','points':1000});
                    await _streaksService.processGoalCompleted(type: 'daily', goalId: 'step_1000', timestamp: now);
                  }, icon: const Icon(Icons.add), label: const Text('+1000')),
                OutlinedButton(onPressed: () => ref.read(mockStepsProvider.notifier).reset(), child: const Text('Reset')),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: 7,
                itemBuilder: (context, index) {
                  final daySteps = 2000 + (index * 1000);
                  return ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text('Día ${index + 1}'),
                    subtitle: Text('$daySteps pasos'),
                    trailing: Text('${(daySteps / 10000 * 100).toStringAsFixed(0)}%'),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Legacito',
        child: const Icon(Icons.person),
        onPressed: () {
          final quote = legacito.getDailyQuote();
          final evaluation = legacito.evaluateProgress(steps: steps, goal: 10000);
          showDialog(context: context, builder: (context) => AlertDialog(title: const Text('Legacito'), content: Column(mainAxisSize: MainAxisSize.min, children: [Text(quote), const SizedBox(height: 12), Text(evaluation)]), actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cerrar'))]));
        },
      ),
    );
  }
}
