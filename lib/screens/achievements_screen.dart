import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/streaks_service.dart';
import '../models/streak_state.dart';
import '../models/achievement.dart';

final _streaksService = StreaksService();

class AchievementsScreen extends ConsumerStatefulWidget {
  const AchievementsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends ConsumerState<AchievementsScreen> {
  List<StreakState> streaks = [];
  List<Achievement> achievements = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async{
    final s = await _streaksService.loadAll();
    final a = await _streaksService.loadAchievements();
    setState((){
      streaks = s;
      achievements = a;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    final daily = streaks.firstWhere((s) => s.streakId == 'daily_default', orElse: () => StreakState(streakId: 'daily_default', type: 'daily', length: 0, lastUpdated: null, best: 0, active: true));
    return Scaffold(
      appBar: AppBar(title: const Text('Logros')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Racha diaria', style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 12),
            Row(
              children: [
                Text('${daily.length} días', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(width: 12),
                if (daily.length >= 7) const Icon(Icons.verified, color: Colors.amber)
              ],
            ),
            const SizedBox(height: 18),
            Text('Historial de logros', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: achievements.length,
                itemBuilder: (context, index) {
                  final ach = achievements[index];
                  return ListTile(
                    leading: CircleAvatar(child: Text(ach.reward.toString())),
                    title: Text(ach.title),
                    subtitle: Text(ach.description),
                    trailing: Text(ach.date.split('T').first),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
