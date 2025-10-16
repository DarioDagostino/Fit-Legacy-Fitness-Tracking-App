import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../data/models/achievement_model.dart';

class AchievementTile extends StatelessWidget {
  final Achievement achievement;

  const AchievementTile({super.key, required this.achievement});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.amber.shade100,
          child: Icon(achievement.icon, color: Colors.amber.shade800),
        ),
        title: Text(
          achievement.title,
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              achievement.description,
              style: GoogleFonts.openSans(),
            ),
            const SizedBox(height: 4),
            Text(
              'Obtenido: ${DateFormat.yMMMd().format(achievement.dateEarned)}',
              style: GoogleFonts.openSans(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}