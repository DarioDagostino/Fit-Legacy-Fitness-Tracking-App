import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// flutter_svg eliminado para reducir tamaño del binario
import '../core/constants/app_text_styles.dart';

class AuthLogo extends StatelessWidget {
  final double size;
  const AuthLogo({super.key, this.size = 74});

  @override
  Widget build(BuildContext context) {
    // Intentar cargar un asset PNG si existe, si no, usar fallback.
    return FutureBuilder<String?>(
      future: _selectAsset(),
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) return _fallback(size);
        final selected = snap.data;
        if (selected == null) return _fallback(size);
        // Solo PNG soportado para evitar dependencia de svg
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0,4))]),
          child: ClipOval(child: Image.asset(selected, fit: BoxFit.cover)),
        );
      },
    );
  }

  Widget _fallback(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0,4))]),
      child: Center(child: Text('FL', style: AppTextStyles.headline2.copyWith(color: Color(0xFF0F172A)))),
    );
  }

  // Seleccionar asset disponible: PNG si existe, si no null.
  static Future<String?> _selectAsset() async {
    final png = 'assets/images/logo.png';
    try {
      final b = await rootBundle.load(png);
      if (b.lengthInBytes > 0) return png;
    } catch (_) {}
    return null;
  }
}
