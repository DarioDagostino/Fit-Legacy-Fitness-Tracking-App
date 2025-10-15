import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/constants/app_colors.dart';
import '../models/legacito_state.dart';

class LegacitoCustomWidget extends StatelessWidget {
  final LegacitoMood mood;
  final bool isAnimating;
  final double size;

  const LegacitoCustomWidget({
    super.key,
    required this.mood,
    this.isAnimating = false,
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: (size * 1.25).h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Aura de fondo
          _buildAura(),
          
          // Cuerpo principal
          _buildBody(),
          
          // Efectos especiales
          if (isAnimating) _buildSpecialEffects(),
        ],
      ),
    );
  }

  Widget _buildAura() {
    final config = _getMoodConfig();
    
    return Container(
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
    ).animate(target: isAnimating ? 1 : 0)
      .scaleXY(begin: 1.0, end: 1.2, duration: 1000.ms)
      .then()
      .scaleXY(begin: 1.2, end: 1.0, duration: 1000.ms);
  }

  Widget _buildBody() {
    final config = _getMoodConfig();
    
    return Transform.translate(
      offset: Offset(0, config.bodyY.h),
      child: Transform.rotate(
        angle: config.headTilt * 0.0174533, // Convertir a radianes
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Cabeza
            _buildHead(config),
            
            // Cuerpo
            _buildTorso(config),
            
            // Brazos
            _buildArms(config),
            
            // Piernas
            _buildLegs(config),
          ],
        ),
      ),
    );
  }

  Widget _buildHead(MoodConfig config) {
    return Container(
      width: (size * 0.4).w,
      height: (size * 0.4).w,
      decoration: BoxDecoration(
        color: config.skinColor,
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
        alignment: Alignment.center,
        children: [
          // Ojos
          _buildEyes(config),
          
          // Boca
          _buildMouth(config),
          
          // Expresión especial
          _buildSpecialExpression(config),
        ],
      ),
    );
  }

  Widget _buildEyes(MoodConfig config) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Ojo izquierdo
        Container(
          width: (size * 0.08 * config.eyeSize).w,
          height: (size * 0.08 * config.eyeSize).w,
          decoration: BoxDecoration(
            color: config.eyeColor,
            shape: BoxShape.circle,
          ),
        ),
        
        // Ojo derecho
        Container(
          width: (size * 0.08 * config.eyeSize).w,
          height: (size * 0.08 * config.eyeSize).w,
          decoration: BoxDecoration(
            color: config.eyeColor,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }

  Widget _buildMouth(MoodConfig config) {
    return Positioned(
      bottom: (size * 0.15).h,
      child: Container(
        width: (size * 0.2).w,
        height: (size * 0.05).h,
        decoration: BoxDecoration(
          color: config.mouthColor,
          borderRadius: BorderRadius.circular(config.mouthRadius.r),
        ),
      ),
    );
  }

  Widget _buildSpecialExpression(MoodConfig config) {
    if (config.specialIcon == null) return const SizedBox.shrink();
    
    return Positioned(
      top: (size * 0.1).h,
      child: Icon(
        config.specialIcon!,
        color: config.specialColor,
        size: (size * 0.15).sp,
      ),
    );
  }

  Widget _buildTorso(MoodConfig config) {
    return Container(
      width: (size * 0.6).w,
      height: (size * 0.4).h,
      decoration: BoxDecoration(
        color: config.bodyColor,
        borderRadius: BorderRadius.circular((size * 0.1).r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Detalles del torso
          if (config.torsoDetails != null) config.torsoDetails!,
        ],
      ),
    );
  }

  Widget _buildArms(MoodConfig config) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Brazo izquierdo
        Transform.rotate(
          angle: config.armRotation * 0.0174533,
          child: Container(
            width: (size * 0.15).w,
            height: (size * 0.3).h,
            decoration: BoxDecoration(
              color: config.skinColor,
              borderRadius: BorderRadius.circular((size * 0.075).r),
            ),
          ),
        ),
        
        SizedBox(width: (size * 0.3).w),
        
        // Brazo derecho
        Transform.rotate(
          angle: -config.armRotation * 0.0174533,
          child: Container(
            width: (size * 0.15).w,
            height: (size * 0.3).h,
            decoration: BoxDecoration(
              color: config.skinColor,
              borderRadius: BorderRadius.circular((size * 0.075).r),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegs(MoodConfig config) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Pierna izquierda
        Container(
          width: (size * 0.2).w,
          height: (size * 0.3).h,
          decoration: BoxDecoration(
            color: config.legColor,
            borderRadius: BorderRadius.circular((size * 0.1).r),
          ),
        ),
        
        // Pierna derecha
        Container(
          width: (size * 0.2).w,
          height: (size * 0.3).h,
          decoration: BoxDecoration(
            color: config.legColor,
            borderRadius: BorderRadius.circular((size * 0.1).r),
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialEffects() {
    final config = _getMoodConfig();
    
    return Stack(
      alignment: Alignment.center,
      children: [
        // Partículas
        if (config.particles != null) config.particles!,
        
        // Efectos de brillo
        if (config.glowEffect)
          Container(
            width: (size * 1.2).w,
            height: (size * 1.2).h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  config.auraColor.withValues(alpha: 0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ).animate()
            .fadeIn(duration: 1000.ms)
            .scaleXY(begin: 0.8, end: 1.2, duration: 1000.ms),
      ],
    );
  }

  MoodConfig _getMoodConfig() {
    switch (mood) {
      case LegacitoMood.motivado:
        return MoodConfig(
          name: 'Motivado',
          color: const Color(0xFFFFD700),
          auraColor: const Color(0xFFFFD700),
          auraIntensity: 0.3,
          skinColor: const Color(0xFFFFE4B5),
          bodyColor: const Color(0xFF4A90E2),
          legColor: const Color(0xFF2E5BBA),
          eyeColor: const Color(0xFF2E5BBA),
          mouthColor: const Color(0xFFE74C3C),
          mouthRadius: 20,
          armRotation: 0,
          headTilt: 0,
          eyeSize: 1.0,
          bodyY: 0,
          specialIcon: Icons.trending_up,
          specialColor: const Color(0xFFFFD700),
          glowEffect: true,
        );
        
      case LegacitoMood.celebrando:
        return MoodConfig(
          name: 'Celebrando',
          color: const Color(0xFFFF6B35),
          auraColor: const Color(0xFFFF6B35),
          auraIntensity: 0.5,
          skinColor: const Color(0xFFFFE4B5),
          bodyColor: const Color(0xFFFF6B35),
          legColor: const Color(0xFFE55A2B),
          eyeColor: const Color(0xFF2E5BBA),
          mouthColor: const Color(0xFFE74C3C),
          mouthRadius: 30,
          armRotation: -30,
          headTilt: 0,
          eyeSize: 1.2,
          bodyY: -10,
          specialIcon: Icons.celebration,
          specialColor: const Color(0xFFFFD700),
          glowEffect: true,
          particles: _buildCelebrationParticles(),
        );
        
      case LegacitoMood.neutral:
        return MoodConfig(
          name: 'Neutral',
          color: const Color(0xFFA0AEC0),
          auraColor: const Color(0xFFA0AEC0),
          auraIntensity: 0.15,
          skinColor: const Color(0xFFFFE4B5),
          bodyColor: const Color(0xFF718096),
          legColor: const Color(0xFF4A5568),
          eyeColor: const Color(0xFF2E5BBA),
          mouthColor: const Color(0xFF718096),
          mouthRadius: 15,
          armRotation: 5,
          headTilt: 0,
          eyeSize: 1.0,
          bodyY: 0,
          specialIcon: Icons.remove,
          specialColor: const Color(0xFFA0AEC0),
          glowEffect: false,
        );
        
      case LegacitoMood.preocupado:
        return MoodConfig(
          name: 'Preocupado',
          color: const Color(0xFF718096),
          auraColor: const Color(0xFF718096),
          auraIntensity: 0.2,
          skinColor: const Color(0xFFFFE4B5),
          bodyColor: const Color(0xFF4A5568),
          legColor: const Color(0xFF2D3748),
          eyeColor: const Color(0xFF2E5BBA),
          mouthColor: const Color(0xFF4A5568),
          mouthRadius: 10,
          armRotation: 10,
          headTilt: -5,
          eyeSize: 0.9,
          bodyY: 5,
          specialIcon: Icons.warning,
          specialColor: const Color(0xFFE53E3E),
          glowEffect: false,
        );
        
      case LegacitoMood.resiliente:
        return MoodConfig(
          name: 'Resiliente',
          color: const Color(0xFF9F7AEA),
          auraColor: const Color(0xFF9F7AEA),
          auraIntensity: 0.4,
          skinColor: const Color(0xFFFFE4B5),
          bodyColor: const Color(0xFF9F7AEA),
          legColor: const Color(0xFF805AD5),
          eyeColor: const Color(0xFF2E5BBA),
          mouthColor: const Color(0xFF9F7AEA),
          mouthRadius: 25,
          armRotation: -15,
          headTilt: 5,
          eyeSize: 1.1,
          bodyY: -5,
          specialIcon: Icons.psychology,
          specialColor: const Color(0xFF9F7AEA),
          glowEffect: true,
        );
        
      case LegacitoMood.durmiendo:
        return MoodConfig(
          name: 'Durmiendo',
          color: const Color(0xFF2B6CB0),
          auraColor: const Color(0xFF2B6CB0),
          auraIntensity: 0.1,
          skinColor: const Color(0xFFFFE4B5),
          bodyColor: const Color(0xFF2B6CB0),
          legColor: const Color(0xFF1A365D),
          eyeColor: const Color(0xFF4A5568),
          mouthColor: const Color(0xFF2B6CB0),
          mouthRadius: 5,
          armRotation: 0,
          headTilt: 0,
          eyeSize: 0.3,
          bodyY: 0,
          specialIcon: Icons.bedtime,
          specialColor: const Color(0xFF2B6CB0),
          glowEffect: false,
        );
        
      case LegacitoMood.pensativo:
        return MoodConfig(
          name: 'Pensativo',
          color: const Color(0xFF38B2AC),
          auraColor: const Color(0xFF38B2AC),
          auraIntensity: 0.25,
          skinColor: const Color(0xFFFFE4B5),
          bodyColor: const Color(0xFF38B2AC),
          legColor: const Color(0xFF2C7A7B),
          eyeColor: const Color(0xFF2E5BBA),
          mouthColor: const Color(0xFF38B2AC),
          mouthRadius: 12,
          armRotation: 0,
          headTilt: 10,
          eyeSize: 0.8,
          bodyY: 0,
          specialIcon: Icons.psychology_alt,
          specialColor: const Color(0xFF38B2AC),
          glowEffect: false,
        );
        
      case LegacitoMood.energico:
        return MoodConfig(
          name: 'Energético',
          color: const Color(0xFFFFA500),
          auraColor: const Color(0xFFFFA500),
          auraIntensity: 0.6,
          skinColor: const Color(0xFFFFE4B5),
          bodyColor: const Color(0xFFFFA500),
          legColor: const Color(0xFFE67E22),
          eyeColor: const Color(0xFF2E5BBA),
          mouthColor: const Color(0xFFE74C3C),
          mouthRadius: 35,
          armRotation: -20,
          headTilt: 0,
          eyeSize: 1.3,
          bodyY: -15,
          specialIcon: Icons.bolt,
          specialColor: const Color(0xFFFFD700),
          glowEffect: true,
          particles: _buildEnergyParticles(),
        );
    }
  }

  Widget _buildCelebrationParticles() {
    return Stack(
      children: List.generate(8, (index) {
        return Positioned(
          left: (size * (0.3 + (index * 0.1))).w,
          top: (size * (0.2 + (index * 0.05))).h,
          child: Container(
            width: (size * 0.05).w,
            height: (size * 0.05).w,
            decoration: BoxDecoration(
              color: const Color(0xFFFFD700),
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

  Widget _buildEnergyParticles() {
    return Stack(
      children: List.generate(6, (index) {
        return Positioned(
          left: (size * (0.2 + (index * 0.12))).w,
          top: (size * (0.1 + (index * 0.08))).h,
          child: Container(
            width: (size * 0.03).w,
            height: (size * 0.03).w,
            decoration: BoxDecoration(
              color: const Color(0xFFFFD700),
              shape: BoxShape.circle,
            ),
          ),
        ).animate(delay: (index * 150).ms)
          .fadeIn(duration: 300.ms)
          .scaleXY(begin: 0.0, end: 1.0, duration: 300.ms)
          .then()
          .fadeOut(duration: 800.ms);
      }),
    );
  }
}

class MoodConfig {
  final String name;
  final Color color;
  final Color auraColor;
  final double auraIntensity;
  final Color skinColor;
  final Color bodyColor;
  final Color legColor;
  final Color eyeColor;
  final Color mouthColor;
  final double mouthRadius;
  final double armRotation;
  final double headTilt;
  final double eyeSize;
  final double bodyY;
  final IconData? specialIcon;
  final Color specialColor;
  final bool glowEffect;
  final Widget? particles;
  final Widget? torsoDetails;

  const MoodConfig({
    required this.name,
    required this.color,
    required this.auraColor,
    required this.auraIntensity,
    required this.skinColor,
    required this.bodyColor,
    required this.legColor,
    required this.eyeColor,
    required this.mouthColor,
    required this.mouthRadius,
    required this.armRotation,
    required this.headTilt,
    required this.eyeSize,
    required this.bodyY,
    this.specialIcon,
    required this.specialColor,
    required this.glowEffect,
    this.particles,
    this.torsoDetails,
  });
}
