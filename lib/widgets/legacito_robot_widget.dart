import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/legacito_state.dart';

class LegacitoRobotWidget extends StatelessWidget {
  final LegacitoMood mood;
  final bool isAnimating;
  final double size;

  const LegacitoRobotWidget({
    super.key,
    required this.mood,
    this.isAnimating = false,
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: (size * 1.75).h, // Proporción del SVG original
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Sombra de suelo
          _buildGroundShadow(),
          
          // Base (cuerpo inferior)
          _buildBase(),
          
          // Torso
          _buildTorso(),
          
          // Cuello
          _buildNeck(),
          
          // Cabeza
          _buildHead(),
          
          // Brazos
          _buildArms(),
          
          // Efectos especiales
          if (isAnimating) _buildSpecialEffects(),
        ],
      ),
    );
  }

  Widget _buildGroundShadow() {
    return Positioned(
      bottom: 0,
      child: Container(
        width: (size * 0.6).w,
        height: (size * 0.125).h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withValues(alpha: 0.15),
        ),
      ),
    );
  }

  Widget _buildBase() {
    return Positioned(
      bottom: (size * 0.15).h,
      child: Container(
        width: (size * 0.7).w,
        height: (size * 0.8).h,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD8C8BA),
              Color(0xFFC8B8AA),
              Color(0xFFB8A89A),
            ],
          ),
          borderRadius: BorderRadius.circular((size * 0.4).r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Highlight superior
            Positioned(
              left: (size * -0.15).w,
              top: (size * -0.05).h,
              child: Container(
                width: (size * 0.3).w,
                height: (size * 0.15).h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular((size * 0.15).r),
                ),
              ),
            ),
            
            // Línea de división
            Positioned(
              top: (size * -0.1).h,
              child: Container(
                width: (size * 0.725).w,
                height: (size * 0.06).h,
                decoration: BoxDecoration(
                  color: const Color(0xFFB8A89A),
                  borderRadius: BorderRadius.circular((size * 0.03).r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTorso() {
    return Positioned(
      bottom: (size * 0.6).h,
      child: Container(
        width: (size * 0.9).w,
        height: (size * 0.5).h,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8D8C8),
              Color(0xFFD8C8BA),
              Color(0xFFC8B8AA),
            ],
          ),
          borderRadius: BorderRadius.circular((size * 0.45).r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Highlight principal
            Positioned(
              left: (size * -0.2).w,
              top: (size * 0.25).h,
              child: Container(
                width: (size * 0.4).w,
                height: (size * 0.6).h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular((size * 0.2).r),
                ),
              ),
            ),
            
            // Panel central
            _buildCentralPanel(),
            
            // Bandas doradas de los hombros
            _buildShoulderBands(),
          ],
        ),
      ),
    );
  }

  Widget _buildCentralPanel() {
    return Positioned(
      top: (size * 0.2).h,
      child: Container(
        width: (size * 0.4).w,
        height: (size * 0.4).h,
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular((size * 0.1).r),
          border: Border.all(
            color: const Color(0xFF3A3A3A),
            width: 2.w,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Líneas horizontales del panel
            Container(
              width: (size * 0.25).w,
              height: 2.h,
              color: const Color(0xFF3A3A3A).withValues(alpha: 0.6),
            ),
            Container(
              width: (size * 0.25).w,
              height: 2.h,
              color: const Color(0xFF3A3A3A).withValues(alpha: 0.6),
            ),
            Container(
              width: (size * 0.25).w,
              height: 2.h,
              color: const Color(0xFF3A3A3A).withValues(alpha: 0.6),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShoulderBands() {
    return Stack(
      children: [
        // Banda izquierda
        Positioned(
          left: (size * -0.35).w,
          top: (size * 0.4).h,
          child: Transform.rotate(
            angle: -0.35, // -20 grados
            child: Container(
              width: (size * 0.125).w,
              height: (size * 0.2).h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFDAA520), Color(0xFFB8860B)],
                ),
                borderRadius: BorderRadius.circular((size * 0.0625).r),
              ),
            ),
          ),
        ),
        
        // Banda derecha
        Positioned(
          right: (size * -0.35).w,
          top: (size * 0.4).h,
          child: Transform.rotate(
            angle: 0.35, // 20 grados
            child: Container(
              width: (size * 0.125).w,
              height: (size * 0.2).h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFDAA520), Color(0xFFB8860B)],
                ),
                borderRadius: BorderRadius.circular((size * 0.0625).r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNeck() {
    return Positioned(
      bottom: (size * 0.8).h,
      child: Container(
        width: (size * 0.175).w,
        height: (size * 0.225).h,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8D8C8),
              Color(0xFFD8C8BA),
            ],
          ),
          borderRadius: BorderRadius.circular((size * 0.0875).r),
        ),
        child: Stack(
          children: [
            // Banda decorativa dorada
            Positioned(
              bottom: (size * 0.05).h,
              child: Container(
                width: (size * 0.19).w,
                height: (size * 0.06).h,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular((size * 0.03).r),
                ),
              ),
            ),
            
            // Highlight del cuello
            Positioned(
              left: (size * -0.05).w,
              top: (size * 0.075).h,
              child: Container(
                width: (size * 0.075).w,
                height: (size * 0.125).h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular((size * 0.0375).r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHead() {
    return Positioned(
      bottom: (size * 1.0).h,
      child: Container(
        width: size.w,
        height: size.w,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE8D8C8),
              Color(0xFFD8C8BA),
              Color(0xFFC8B8AA),
            ],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Highlight principal
            Positioned(
              left: (size * -0.25).w,
              top: (size * -0.3).w,
              child: Container(
                width: (size * 0.4).w,
                height: (size * 0.45).w,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.35),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            
            // Pantalla frontal
            _buildFrontScreen(),
            
            // Sensor lateral
            _buildLateralSensor(),
          ],
        ),
      ),
    );
  }

  Widget _buildFrontScreen() {
    return Center(
      child: Container(
        width: (size * 0.775).w,
        height: (size * 0.775).w,
        decoration: BoxDecoration(
          color: const Color(0xFF000000),
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFF3A3A3A),
            width: 3.w,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Logo FL
            _buildFLLogo(),
            
            // Reflejo en la pantalla
            Positioned(
              left: (size * -0.3).w,
              top: (size * -0.25).w,
              child: Container(
                width: (size * 0.2).w,
                height: (size * 0.3).w,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.03),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFLLogo() {
    return Container(
      width: (size * 0.3).w,
      height: (size * 0.3).w,
      child: CustomPaint(
        painter: FLLogoPainter(),
      ),
    );
  }

  Widget _buildLateralSensor() {
    return Positioned(
      right: (size * -0.35).w,
      child: Container(
        width: (size * 0.175).w,
        height: (size * 0.175).w,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFE8D8C8), Color(0xFFD8C8BA)],
          ),
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFFDAA520),
            width: 4.w,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Lente interior
            Container(
              width: (size * 0.11).w,
              height: (size * 0.11).w,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                shape: BoxShape.circle,
              ),
            ),
            
            // Reflejo del lente
            Positioned(
              left: (size * -0.025).w,
              top: (size * -0.025).w,
              child: Container(
                width: (size * 0.04).w,
                height: (size * 0.04).w,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.4),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArms() {
    return Stack(
      children: [
        // Brazo izquierdo
        _buildLeftArm(),
        
        // Brazo derecho
        _buildRightArm(),
      ],
    );
  }

  Widget _buildLeftArm() {
    return Positioned(
      left: (size * -0.45).w,
      bottom: (size * 0.4).h,
      child: Column(
        children: [
          // Hombro
          Container(
            width: (size * 0.2).w,
            height: (size * 0.2).w,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFDAA520), Color(0xFFB8860B)],
              ),
              shape: BoxShape.circle,
            ),
          ),
          
          // Brazo superior
          Container(
            width: (size * 0.075).w,
            height: (size * 0.45).h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE8D8C8),
                  Color(0xFFD8C8BA),
                ],
              ),
              borderRadius: BorderRadius.circular((size * 0.0375).r),
            ),
          ),
          
          // Codo
          Container(
            width: (size * 0.11).w,
            height: (size * 0.125).h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFDAA520), Color(0xFFB8860B)],
              ),
              borderRadius: BorderRadius.circular((size * 0.055).r),
            ),
          ),
          
          // Antebrazo
          Container(
            width: (size * 0.075).w,
            height: (size * 0.3).h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE8D8C8),
                  Color(0xFFD8C8BA),
                ],
              ),
              borderRadius: BorderRadius.circular((size * 0.0375).r),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRightArm() {
    return Positioned(
      right: (size * -0.45).w,
      bottom: (size * 0.4).h,
      child: Column(
        children: [
          // Hombro
          Container(
            width: (size * 0.2).w,
            height: (size * 0.2).w,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFDAA520), Color(0xFFB8860B)],
              ),
              shape: BoxShape.circle,
            ),
          ),
          
          // Brazo superior
          Container(
            width: (size * 0.075).w,
            height: (size * 0.45).h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE8D8C8),
                  Color(0xFFD8C8BA),
                ],
              ),
              borderRadius: BorderRadius.circular((size * 0.0375).r),
            ),
          ),
          
          // Codo
          Container(
            width: (size * 0.11).w,
            height: (size * 0.125).h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFDAA520), Color(0xFFB8860B)],
              ),
              borderRadius: BorderRadius.circular((size * 0.055).r),
            ),
          ),
          
          // Antebrazo
          Container(
            width: (size * 0.075).w,
            height: (size * 0.3).h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE8D8C8),
                  Color(0xFFD8C8BA),
                ],
              ),
              borderRadius: BorderRadius.circular((size * 0.0375).r),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialEffects() {
    final config = _getMoodConfig(mood);
    
    return Stack(
      alignment: Alignment.center,
      children: [
        // Aura pulsante
        Container(
          width: (size * 1.5).w,
          height: (size * 1.5).h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                config.auraColor.withValues(alpha: config.auraIntensity),
                Colors.transparent,
              ],
            ),
          ),
        ).animate()
          .scaleXY(begin: 0.8, end: 1.2, duration: 1000.ms)
          .then()
          .scaleXY(begin: 1.2, end: 0.8, duration: 1000.ms),
        
        // Partículas especiales
        if (config.hasParticles) _buildParticles(config),
      ],
    );
  }

  Widget _buildParticles(MoodConfig config) {
    return Stack(
      children: List.generate(config.particleCount, (index) {
        return Positioned(
          left: (size * (0.2 + (index * 0.1))).w,
          top: (size * (0.1 + (index * 0.05))).h,
          child: Container(
            width: (size * 0.03).w,
            height: (size * 0.03).w,
            decoration: BoxDecoration(
              color: config.particleColor,
              shape: BoxShape.circle,
            ),
          ),
        ).animate(delay: (index * 100).ms)
          .fadeIn(duration: 500.ms)
          .scaleXY(begin: 0.0, end: 1.0, duration: 500.ms)
          .then()
          .fadeOut(duration: 1000.ms);
      }),
    );
  }

  MoodConfig _getMoodConfig(LegacitoMood mood) {
    switch (mood) {
      case LegacitoMood.motivado:
        return MoodConfig(
          name: 'Motivado',
          auraColor: const Color(0xFFFFD700),
          auraIntensity: 0.3,
          hasParticles: false,
          particleCount: 0,
          particleColor: Colors.transparent,
        );
        
      case LegacitoMood.celebrando:
        return MoodConfig(
          name: 'Celebrando',
          auraColor: const Color(0xFFFF6B35),
          auraIntensity: 0.5,
          hasParticles: true,
          particleCount: 8,
          particleColor: const Color(0xFFFFD700),
        );
        
      case LegacitoMood.neutral:
        return MoodConfig(
          name: 'Neutral',
          auraColor: const Color(0xFFA0AEC0),
          auraIntensity: 0.15,
          hasParticles: false,
          particleCount: 0,
          particleColor: Colors.transparent,
        );
        
      case LegacitoMood.preocupado:
        return MoodConfig(
          name: 'Preocupado',
          auraColor: const Color(0xFF718096),
          auraIntensity: 0.2,
          hasParticles: false,
          particleCount: 0,
          particleColor: Colors.transparent,
        );
        
      case LegacitoMood.resiliente:
        return MoodConfig(
          name: 'Resiliente',
          auraColor: const Color(0xFF9F7AEA),
          auraIntensity: 0.4,
          hasParticles: false,
          particleCount: 0,
          particleColor: Colors.transparent,
        );
        
      case LegacitoMood.durmiendo:
        return MoodConfig(
          name: 'Durmiendo',
          auraColor: const Color(0xFF2B6CB0),
          auraIntensity: 0.1,
          hasParticles: false,
          particleCount: 0,
          particleColor: Colors.transparent,
        );
        
      case LegacitoMood.pensativo:
        return MoodConfig(
          name: 'Pensativo',
          auraColor: const Color(0xFF38B2AC),
          auraIntensity: 0.25,
          hasParticles: false,
          particleCount: 0,
          particleColor: Colors.transparent,
        );
        
      case LegacitoMood.energico:
        return MoodConfig(
          name: 'Energético',
          auraColor: const Color(0xFFFFA500),
          auraIntensity: 0.6,
          hasParticles: true,
          particleCount: 6,
          particleColor: const Color(0xFFFFD700),
        );
    }
  }
}

class MoodConfig {
  final String name;
  final Color auraColor;
  final double auraIntensity;
  final bool hasParticles;
  final int particleCount;
  final Color particleColor;

  const MoodConfig({
    required this.name,
    required this.auraColor,
    required this.auraIntensity,
    required this.hasParticles,
    required this.particleCount,
    required this.particleColor,
  });
}

class FLLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFFD700)
      ..strokeWidth = (size.width * 0.1)
      ..strokeCap = StrokeCap.round;

    // Letra F
    canvas.drawLine(
      Offset(size.width * 0.1, size.height * 0.1),
      Offset(size.width * 0.1, size.height * 0.9),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.1, size.height * 0.1),
      Offset(size.width * 0.6, size.height * 0.1),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.1, size.height * 0.5),
      Offset(size.width * 0.5, size.height * 0.5),
      paint,
    );

    // Letra L
    canvas.drawLine(
      Offset(size.width * 0.7, size.height * 0.1),
      Offset(size.width * 0.7, size.height * 0.9),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.7, size.height * 0.9),
      Offset(size.width * 0.9, size.height * 0.9),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
