import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/legacito_state.dart';

class LegacitoSvgWidget extends StatelessWidget {
  final LegacitoMood mood;
  final bool isAnimating;
  final double size;

  const LegacitoSvgWidget({
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
          // SVG de fondo
          _buildSvgBackground(),
          
          // Efectos animados
          if (isAnimating) _buildAnimatedEffects(),
        ],
      ),
    );
  }

  Widget _buildSvgBackground() {
    final svgPath = _getSvgPath(mood);
    
    return SvgPicture.asset(
      svgPath,
      width: size.w,
      height: (size * 1.25).h,
      fit: BoxFit.contain,
      placeholderBuilder: (context) => _buildFallbackWidget(),
    ).animate(target: isAnimating ? 1 : 0)
      .scaleXY(begin: 1.0, end: 1.1, duration: 300.ms)
      .then()
      .scaleXY(begin: 1.1, end: 1.0, duration: 200.ms);
  }

  Widget _buildFallbackWidget() {
    final config = _getMoodConfig(mood);
    
    return Container(
      width: size.w,
      height: (size * 1.25).h,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            config.auraColor.withValues(alpha: config.auraIntensity),
            Colors.transparent,
          ],
        ),
        borderRadius: BorderRadius.circular(size.r),
      ),
      child: Icon(
        config.fallbackIcon,
        size: (size * 0.6).sp,
        color: config.primaryColor,
      ),
    );
  }

  Widget _buildAnimatedEffects() {
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

  String _getSvgPath(LegacitoMood mood) {
    switch (mood) {
      case LegacitoMood.motivado:
        return 'assets/images/legacito/legacito_motivado.svg';
      case LegacitoMood.celebrando:
        return 'assets/images/legacito/legacito_celebrando.svg';
      case LegacitoMood.neutral:
        return 'assets/images/legacito/legacito_neutral.svg';
      case LegacitoMood.preocupado:
        return 'assets/images/legacito/legacito_preocupado.svg';
      case LegacitoMood.resiliente:
        return 'assets/images/legacito/legacito_resiliente.svg';
      case LegacitoMood.durmiendo:
        return 'assets/images/legacito/legacito_durmiendo.svg';
      case LegacitoMood.pensativo:
        return 'assets/images/legacito/legacito_pensativo.svg';
      case LegacitoMood.energico:
        return 'assets/images/legacito/legacito_energico.svg';
    }
  }

  MoodConfig _getMoodConfig(LegacitoMood mood) {
    switch (mood) {
      case LegacitoMood.motivado:
        return MoodConfig(
          name: 'Motivado',
          primaryColor: const Color(0xFFFFD700),
          auraColor: const Color(0xFFFFD700),
          auraIntensity: 0.3,
          fallbackIcon: Icons.trending_up,
          hasParticles: false,
          particleCount: 0,
          particleColor: Colors.transparent,
        );
        
      case LegacitoMood.celebrando:
        return MoodConfig(
          name: 'Celebrando',
          primaryColor: const Color(0xFFFF6B35),
          auraColor: const Color(0xFFFF6B35),
          auraIntensity: 0.5,
          fallbackIcon: Icons.celebration,
          hasParticles: true,
          particleCount: 8,
          particleColor: const Color(0xFFFFD700),
        );
        
      case LegacitoMood.neutral:
        return MoodConfig(
          name: 'Neutral',
          primaryColor: const Color(0xFFA0AEC0),
          auraColor: const Color(0xFFA0AEC0),
          auraIntensity: 0.15,
          fallbackIcon: Icons.remove,
          hasParticles: false,
          particleCount: 0,
          particleColor: Colors.transparent,
        );
        
      case LegacitoMood.preocupado:
        return MoodConfig(
          name: 'Preocupado',
          primaryColor: const Color(0xFF718096),
          auraColor: const Color(0xFF718096),
          auraIntensity: 0.2,
          fallbackIcon: Icons.warning,
          hasParticles: false,
          particleCount: 0,
          particleColor: Colors.transparent,
        );
        
      case LegacitoMood.resiliente:
        return MoodConfig(
          name: 'Resiliente',
          primaryColor: const Color(0xFF9F7AEA),
          auraColor: const Color(0xFF9F7AEA),
          auraIntensity: 0.4,
          fallbackIcon: Icons.psychology,
          hasParticles: false,
          particleCount: 0,
          particleColor: Colors.transparent,
        );
        
      case LegacitoMood.durmiendo:
        return MoodConfig(
          name: 'Durmiendo',
          primaryColor: const Color(0xFF2B6CB0),
          auraColor: const Color(0xFF2B6CB0),
          auraIntensity: 0.1,
          fallbackIcon: Icons.bedtime,
          hasParticles: false,
          particleCount: 0,
          particleColor: Colors.transparent,
        );
        
      case LegacitoMood.pensativo:
        return MoodConfig(
          name: 'Pensativo',
          primaryColor: const Color(0xFF38B2AC),
          auraColor: const Color(0xFF38B2AC),
          auraIntensity: 0.25,
          fallbackIcon: Icons.psychology_alt,
          hasParticles: false,
          particleCount: 0,
          particleColor: Colors.transparent,
        );
        
      case LegacitoMood.energico:
        return MoodConfig(
          name: 'Energético',
          primaryColor: const Color(0xFFFFA500),
          auraColor: const Color(0xFFFFA500),
          auraIntensity: 0.6,
          fallbackIcon: Icons.bolt,
          hasParticles: true,
          particleCount: 6,
          particleColor: const Color(0xFFFFD700),
        );
    }
  }
}

class MoodConfig {
  final String name;
  final Color primaryColor;
  final Color auraColor;
  final double auraIntensity;
  final IconData fallbackIcon;
  final bool hasParticles;
  final int particleCount;
  final Color particleColor;

  const MoodConfig({
    required this.name,
    required this.primaryColor,
    required this.auraColor,
    required this.auraIntensity,
    required this.fallbackIcon,
    required this.hasParticles,
    required this.particleCount,
    required this.particleColor,
  });
}
