import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/constants/app_text_styles.dart';

class AuthLogo extends StatelessWidget {
  final double size;
  const AuthLogo({super.key, this.size = 74});

  @override
  Widget build(BuildContext context) {
    // Attempt to load an asset at assets/images/logo.png. If it doesn't exist, render fallback.
    // Prefer SVG if available, then PNG. Use rootBundle to try loads.
    return FutureBuilder<String?>(
      future: _selectAsset(),
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) return _fallback(size);
        final selected = snap.data;
        if (selected == null) return _fallback(size);
        if (selected.endsWith('.svg')) {
          return Container(
            width: size,
            height: size,
            decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0,4))]),
            child: ClipOval(child: SvgPicture.asset(selected, fit: BoxFit.cover)),
          );
        }
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

  // Select available asset: prefer SVG -> PNG, else null.
  static Future<String?> _selectAsset() async {
    final svg = 'assets/images/logo.svg';
    final png = 'assets/images/logo.png';
    try {
      final a = await rootBundle.load(svg);
      if (a.lengthInBytes > 0) return svg;
    } catch (_) {}
    try {
      final b = await rootBundle.load(png);
      if (b.lengthInBytes > 0) return png;
    } catch (_) {}
    return null;
  }
}
