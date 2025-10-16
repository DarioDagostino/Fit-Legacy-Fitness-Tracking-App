import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../providers/achievements_provider.dart';
import '../widgets/achievement_tile.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final achievementsProvider = Provider.of<AchievementsProvider>(context);
    final streak = achievementsProvider.streak;
    final achievements = achievementsProvider.achievements;

    return Scaffold(
      appBar: AppBar(
        title: Text('Logros', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildStreakCard(context, streak.currentStreak, streak.longestStreak),
          const SizedBox(height: 24),
          Text(
            'Hitos Desbloqueados',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...achievements.map((ach) => AchievementTile(achievement: ach)).toList(),
        ],
      ),
    );
  }

  Widget _buildStreakCard(BuildContext context, int currentStreak, int longestStreak) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStreakInfo('Racha Actual', currentStreak, Icons.local_fire_department, Colors.orange),
            Container(
              height: 60,
              width: 1,
              color: Colors.grey.shade300,
            ),
            _buildStreakInfo('Racha Máxima', longestStreak, Icons.star, Colors.amber.shade700),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakInfo(String title, int value, IconData icon, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.openSans(fontSize: 14, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(width: 8),
            Text(
              value.toString(),
              style: GoogleFonts.oswald(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}