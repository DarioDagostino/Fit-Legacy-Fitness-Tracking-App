import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fit_legacy/presentation/providers/camino_provider.dart';
import 'package:fit_legacy/presentation/providers/achievements_provider.dart';

class NodoDetailScreen extends StatelessWidget {
  final int nodoId;

  const NodoDetailScreen({super.key, required this.nodoId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text('Detalle del Nodo', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF121212),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nodo ID: $nodoId',
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 20),
            const Text(
              'Aquí se mostrará el contenido del nodo (entrenamiento, recuperación, etc.).',
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                // Completar el nodo
                await context.read<CaminoProvider>().completeNodo(nodoId);

                // Disparar la lógica de logros
                final unlockedAchievement = context
                    .read<AchievementsProvider>()
                    .completeAction(ActionType.completeTrainingNode);

                // Mostrar feedback si se desbloqueó un logro
                if (unlockedAchievement != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('¡Logro Desbloqueado: ${unlockedAchievement.title}!'),
                  ));
                }
              },
              child: const Text('Completar Sesión'),
            ),
          ],
        ),
      ),
    );
  }
}