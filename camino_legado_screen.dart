import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fit_legacy/presentation/screens/camino_legado/widgets/path_painter.dart';
import 'package:myapp/fit_legacy/lib/providers/camino_provider.dart';
import 'widgets/nodo_widget.dart';

class CaminoLegadoScreen extends ConsumerWidget {
  const CaminoLegadoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final caminoState = ref.watch(caminoProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text(
          'Camino del Legado',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF121212),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: caminoState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomPaint(
              painter: PathPainter(
                nodeCount: caminoState.nodos.length,
                nodeHeight:
                    140, // Corresponds to vertical padding in NodoWidget
              ),
              child: ListView.builder(
                itemCount: caminoState.nodos.length,
                itemBuilder: (context, index) {
                  // Alternate alignment for a zigzag path
                  final alignment = index % 2 == 0
                      ? Alignment.centerLeft
                      : Alignment.centerRight;
                  return Align(
                    alignment: alignment,
                    child: NodoWidget(nodo: caminoState.nodos[index]),
                  );
                },
              ),
            ),
    );
  }
}
