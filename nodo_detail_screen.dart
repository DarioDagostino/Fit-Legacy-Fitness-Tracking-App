import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fit_legacy/domain/entities/nodo_entity.dart';
import 'package:fit_legacy/presentation/providers/camino_provider.dart';
import 'package:fit_legacy/presentation/providers/achievements_provider.dart';
import 'package:fit_legacy/data/models/achievement_model.dart';

class NodoDetailScreen extends ConsumerWidget {
  final int nodoId;

  const NodoDetailScreen({super.key, required this.nodoId});

  // Mock data for exercises
  static const List<Map<String, dynamic>> _exercises = [
    {
      'icon': Icons.fitness_center,
      'title': 'Flexiones',
      'reps': '3 series de 12',
    },
    {
      'icon': Icons.square_foot,
      'title': 'Sentadillas',
      'reps': '3 series de 15',
    },
    {
      'icon': Icons.accessibility_new,
      'title': 'Plancha',
      'reps': '3 series de 60s',
    },
    {
      'icon': Icons.expand_less,
      'title': 'Dominadas',
      'reps': '3 series al fallo',
    },
    {
      'icon': Icons.directions_run,
      'title': 'Burpees',
      'reps': '3 series de 10',
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use ref.watch to get the provider and rebuild on changes.
    // We use read here because we only need to fetch the initial data for the screen.
    final caminoProvider = ref.read(caminoProvider.notifier);
    final Nodo? nodo = caminoProvider.nodos.firstWhere((n) => n.id == nodoId);

    if (nodo == null) {
      return const Scaffold(body: Center(child: Text('Nodo no encontrado')));
    }

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(nodo),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ejercicios de la Sesión',
                    style: GoogleFonts.montserrat(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Completa las siguientes series para forjar tu legado hoy.',
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          _buildExerciseList(),
        ],
      ),
      bottomNavigationBar: _buildCompleteButton(context, ref, nodo),
    );
  }

  SliverAppBar _buildSliverAppBar(Nodo nodo) {
    return SliverAppBar(
      expandedHeight: 250.0,
      pinned: true,
      backgroundColor: const Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          nodo.title,
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withOpacity(0.6), const Color(0xFF121212)],
            ),
          ),
          child: Icon(
            nodo.icon,
            size: 100,
            color: const Color(0xFFFFC107).withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final exercise = _exercises[index];
        return Card(
          color: const Color(0xFF1E1E1E),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFFFFC107).withOpacity(0.2),
              child: Icon(exercise['icon'], color: const Color(0xFFFFC107)),
            ),
            title: Text(
              exercise['title'],
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              exercise['reps'],
              style: GoogleFonts.openSans(color: Colors.white70),
            ),
          ),
        );
      }, childCount: _exercises.length),
    );
  }

  Widget _buildCompleteButton(BuildContext context, WidgetRef ref, Nodo nodo) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.check_circle_outline),
        label: const Text('Completar Sesión'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFC107),
          foregroundColor: Colors.black,
          minimumSize: const Size(double.infinity, 50),
          textStyle: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () async {
          // Completar el nodo
          await ref.read(caminoProvider.notifier).completeNodo(nodoId);

          // Disparar la lógica de logros
          // Assuming achievementsProvider is also a Riverpod provider
          final unlockedAchievement = ref
              .read(achievementsProvider.notifier)
              .completeAction(ActionType.completeTrainingNode, 1);

          // Mostrar feedback si se desbloqueó un logro
          if (unlockedAchievement != null && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '¡Logro Desbloqueado: ${unlockedAchievement.title}!',
                ),
                backgroundColor: Colors.green,
              ),
            );
          }

          // Regresar a la pantalla anterior
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
