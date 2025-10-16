import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fit_legacy/presentation/screens/camino_legado/widgets/path_painter.dart';
import '../../providers/camino_provider.dart';
import 'widgets/nodo_widget.dart';

class CaminoLegadoScreen extends StatelessWidget {
  const CaminoLegadoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final caminoProvider = Provider.of<CaminoProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: Text('Camino del Legado', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF121212),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: caminoProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomPaint(
              painter: PathPainter(
                nodeCount: caminoProvider.nodos.length,
                nodeHeight: 140, // Corresponds to vertical padding in NodoWidget
              ),
              child: ListView.builder(
                itemCount: caminoProvider.nodos.length,
                itemBuilder: (context, index) {
                  // Alternate alignment for a zigzag path
                  final alignment = index % 2 == 0 ? Alignment.centerLeft : Alignment.centerRight;
                  return Align(
                      alignment: alignment,
                      child: NodoWidget(nodo: caminoProvider.nodos[index]));
                },
              ),
            ),
    );
  }
}