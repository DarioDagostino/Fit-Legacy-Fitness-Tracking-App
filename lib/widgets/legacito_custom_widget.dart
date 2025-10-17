import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
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
    final config = _getMoodConfig();

    return SizedBox(
      width: size.w,
      height: (size * 1.25).h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Cuerpo principal
          _buildBody(config),

          // Efectos especiales
          if (isAnimating) _buildSpecialEffects(),
        ],
      ),
    );
  }

  Widget _buildBody(MoodConfig config) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
      transform: Matrix4.translationValues(0, config.bodyY.h, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Head
          _buildHead(config),
          SizedBox(height: 8.h),
          // Body and Arms
          Stack(
            alignment: Alignment.topCenter,
            children: [
              _buildArms(config),
              _buildTorso(config),
            ],
          ),
          // Base
          _buildBase(config),
        ],
      ),
    )
        .animate(
          onPlay: (controller) => controller.repeat(),
        )
        .moveY(
          begin: 0,
          end: -10.h,
          duration: 3000.ms,
          curve: Curves.easeInOut,
        )
        .then()
        .moveY(
          begin: -10.h,
          end: 0,
          duration: 3000.ms,
          curve: Curves.easeInOut,
        );
  }

  Widget _buildHead(MoodConfig config) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      transformAlignment: Alignment.center,
      transform: Matrix4.rotationZ(config.headTilt * 0.0174533),
      child: Container(
        width: (size * 0.7).w,
        height: (size * 0.7).w,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1A1A), Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          border: Border.all(
            color: config.color,
            width: 4.w,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // FL Logo
            Text(
              'FL',
              style: GoogleFonts.oswald(
                fontSize: (size * 0.3).sp,
                fontWeight: FontWeight.bold,
                color: config.color,
              ),
            ),
            // Eyes
            _buildEyes(config),
            // Sensor
            Positioned(
              top: (size * 0.05).h,
              right: (size * 0.05).w,
              child: Container(
                width: (size * 0.05).w,
                height: (size * 0.05).w,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              )
                  .animate(
                    onPlay: (controller) => controller.repeat(),
                  )
                  .fade(
                    begin: 0.5,
                    end: 1.0,
                    duration: 2000.ms,
                  )
                  .then()
                  .fade(
                    begin: 1.0,
                    end: 0.5,
                    duration: 2000.ms,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEyes(MoodConfig config) {
    return Padding(
      padding: EdgeInsets.only(bottom: (size * 0.05).h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: (size * 0.06 * config.eyeSize).w,
            height: (size * 0.06 * config.eyeSize).w,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: (size * 0.2).w),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: (size * 0.06 * config.eyeSize).w,
            height: (size * 0.06 * config.eyeSize).w,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTorso(MoodConfig config) {
    return Container(
      width: (size * 0.6).w,
      height: (size * 0.5).h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE0E0E0), Color(0xFFBDBDBD)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular((size * 0.15).r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: (size * 0.3).w,
            height: (size * 0.02).h,
            decoration: BoxDecoration(
              color: config.color,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Container(
            width: (size * 0.25).w,
            height: (size * 0.02).h,
            decoration: BoxDecoration(
              color: config.color,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArms(MoodConfig config) {
    return Padding(
      padding: EdgeInsets.only(top: (size * 0.05).h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Arm
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            transformAlignment: Alignment.topCenter,
            transform: Matrix4.rotationZ(config.armRotation * 0.0174533),
            child: Container(
              width: (size * 0.2).w,
              height: (size * 0.3).h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE0E0E0), Color(0xFFBDBDBD)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular((size * 0.1).r),
              ),
            ),
          ),
          SizedBox(width: (size * 0.3).w),
          // Right Arm
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            transformAlignment: Alignment.topCenter,
            transform: Matrix4.rotationZ(-config.armRotation * 0.0174533),
            child: Container(
              width: (size * 0.2).w,
              height: (size * 0.3).h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE0E0E0), Color(0xFFBDBDBD)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular((size * 0.1).r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBase(MoodConfig config) {
    return Column(
      children: [
        SizedBox(height: 4.h),
        // Floating Base
        Container(
          width: (size * 0.5).w,
          height: (size * 0.3).h,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFD9D9D9), Color(0xFFC4C4C4)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius:
                BorderRadius.all(Radius.elliptical(size * 0.5, size * 0.3)),
            boxShadow: [
              BoxShadow(
                color: config.color.withOpacity(0.4),
                blurRadius: 20.r,
                spreadRadius: 5.r,
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        // Shadow
        Container(
          width: (size * 0.4).w,
          height: (size * 0.05).h,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            borderRadius:
                BorderRadius.all(Radius.elliptical(size * 0.4, size * 0.05)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10.r,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialEffects() {
    final config = _getMoodConfig();

    return IgnorePointer(
      child: Container(
        width: size * 1.5,
        height: size * 1.5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: config.color.withOpacity(config.auraIntensity),
              blurRadius: 50.r,
              spreadRadius: 20.r,
            ),
          ],
        ),
      )
          .animate(target: isAnimating ? 1 : 0)
          .scaleXY(
              begin: 1.0, end: 1.2, duration: 1000.ms, curve: Curves.easeInOut)
          .then()
          .scaleXY(
              begin: 1.2, end: 1.0, duration: 1000.ms, curve: Curves.easeInOut),
    );
  }

  MoodConfig _getMoodConfig() {
    switch (mood) {
      case LegacitoMood.motivado:
        return MoodConfig(
          name: 'Motivado',
          color: const Color(0xFFD4AF37), // Gold
          auraIntensity: 0.3,
          armRotation: 0,
          headTilt: 0,
          eyeSize: 1.0,
          bodyY: 0,
        );

      case LegacitoMood.celebrando:
        return MoodConfig(
          name: 'Celebrando',
          color: const Color(0xFFFF6B35), // Orange
          auraIntensity: 0.5,
          armRotation: -30,
          headTilt: 0,
          eyeSize: 1.2,
          bodyY: -10,
        );

      case LegacitoMood.neutral:
        return MoodConfig(
          name: 'Neutral',
          color: const Color(0xFFA0AEC0), // Gray
          auraIntensity: 0.15,
          armRotation: 5,
          headTilt: 0,
          eyeSize: 1.0,
          bodyY: 0,
        );

      case LegacitoMood.preocupado:
        return MoodConfig(
          name: 'Preocupado',
          color: const Color(0xFF718096), // Darker Gray
          auraIntensity: 0.2,
          armRotation: 10,
          headTilt: -5,
          eyeSize: 0.9,
          bodyY: 10,
        );

      case LegacitoMood.resiliente:
        return MoodConfig(
          name: 'Resiliente',
          color: const Color(0xFF4299E1), // Blue
          auraIntensity: 0.4,
          armRotation: -15,
          headTilt: 0,
          eyeSize: 0.9,
          bodyY: -5,
        );

      case LegacitoMood.durmiendo:
        return MoodConfig(
          name: 'Durmiendo',
          color: const Color(0xFF6B7280), // Dark Gray
          auraIntensity: 0.1,
          armRotation: 0,
          headTilt: -10,
          eyeSize: 0.3,
          bodyY: 10,
        );

      case LegacitoMood.pensativo:
        return MoodConfig(
          name: 'Pensativo',
          color: const Color(0xFF8B7ED8), // Purple
          auraIntensity: 0.25,
          armRotation: -25,
          headTilt: 5,
          eyeSize: 0.9,
          bodyY: 0,
        );

      case LegacitoMood.energico:
        return MoodConfig(
          name: 'Energético',
          color: const Color(0xFFF59E0B), // Amber
          auraIntensity: 0.45,
          armRotation: -20,
          headTilt: 0,
          eyeSize: 1.3,
          bodyY: -15,
        );
    }
  }
}

class MoodConfig {
  final String name;
  final Color color;
  final double auraIntensity;
  final double armRotation;
  final double headTilt;
  final double eyeSize;
  final double bodyY;

  const MoodConfig({
    required this.name,
    required this.color,
    required this.auraIntensity,
    required this.armRotation,
    required this.headTilt,
    required this.eyeSize,
    required this.bodyY,
  });
}
