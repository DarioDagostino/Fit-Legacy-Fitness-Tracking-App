import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_colors.dart';
import '../widgets/figma_widget.dart';

/// Demo screen showcasing the FigmaWidget component
/// This demonstrates various configurations and presets available
class FigmaWidgetDemoScreen extends ConsumerWidget {
  const FigmaWidgetDemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text('Figma Widget Demo'),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header
            _buildSectionHeader(context, 'Preset Widgets'),
            const SizedBox(height: 8),
            
            // Info Card Preset
            FigmaWidgetPresets.infoCard(
              title: 'Información',
              description: 'Este es un ejemplo de una tarjeta de información usando el preset.',
              onTap: () => _showSnackBar(context, 'Info card tapped'),
            ),
            
            // Success Card Preset
            FigmaWidgetPresets.successCard(
              title: '¡Objetivo completado!',
              description: 'Has completado tu entrenamiento del día.',
              onTap: () => _showSnackBar(context, 'Success card tapped'),
            ),
            
            // Warning Card Preset
            FigmaWidgetPresets.warningCard(
              title: 'Recordatorio',
              description: 'No olvides registrar tu comida de hoy.',
              onTap: () => _showSnackBar(context, 'Warning card tapped'),
            ),
            
            // Achievement Card Preset
            FigmaWidgetPresets.achievementCard(
              title: 'Racha de 7 días',
              subtitle: 'Logro desbloqueado',
              description: '¡Has mantenido tu racha por una semana completa!',
              onTap: () => _showSnackBar(context, 'Achievement card tapped'),
            ),
            
            const SizedBox(height: 24),
            _buildSectionHeader(context, 'Custom Widgets'),
            const SizedBox(height: 8),
            
            // Custom Widget with Actions
            FigmaWidget(
              title: 'Entrenamiento de hoy',
              subtitle: 'Rutina de fuerza',
              description: 'Duración: 45 minutos',
              icon: Icons.fitness_center,
              iconColor: AppColors.accent,
              backgroundGradient: AppColors.primaryGradient,
              actions: [
                FigmaWidgetAction(
                  icon: Icons.play_arrow,
                  onPressed: () => _showSnackBar(context, 'Play pressed'),
                  color: Colors.green,
                  tooltip: 'Iniciar',
                ),
                FigmaWidgetAction(
                  icon: Icons.edit,
                  onPressed: () => _showSnackBar(context, 'Edit pressed'),
                  color: Colors.blue,
                  tooltip: 'Editar',
                ),
              ],
              animated: true,
            ),
            
            // Custom Widget with Progress
            FigmaWidget(
              title: 'Progreso semanal',
              icon: Icons.show_chart,
              iconColor: AppColors.success,
              customContent: Column(
                children: [
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: 0.65,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.success),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '65% completado',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
              backgroundColor: AppColors.surface,
              animated: true,
              onTap: () => _showSnackBar(context, 'Progress card tapped'),
            ),
            
            // Compact Widget Example
            const SizedBox(height: 24),
            _buildSectionHeader(context, 'Compact List Items'),
            const SizedBox(height: 8),
            
            FigmaWidgetPresets.compactCard(
              title: 'Nutrición',
              icon: Icons.restaurant,
              trailingWidget: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              onTap: () => _showSnackBar(context, 'Nutrition tapped'),
            ),
            
            FigmaWidgetPresets.compactCard(
              title: 'Entrenamiento',
              icon: Icons.fitness_center,
              trailingWidget: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              onTap: () => _showSnackBar(context, 'Training tapped'),
            ),
            
            FigmaWidgetPresets.compactCard(
              title: 'Logros',
              icon: Icons.emoji_events,
              trailingWidget: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              onTap: () => _showSnackBar(context, 'Achievements tapped'),
            ),
            
            // Custom gradient widget
            const SizedBox(height: 24),
            _buildSectionHeader(context, 'Custom Gradient Widget'),
            const SizedBox(height: 8),
            
            FigmaWidget(
              title: 'Legacito dice',
              description: 'La constancia es la clave del éxito. Cada día cuenta.',
              icon: Icons.psychology,
              iconColor: Colors.white,
              backgroundGradient: LinearGradient(
                colors: [
                  Colors.purple[600]!,
                  Colors.blue[600]!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              elevation: 8,
              animated: true,
              onTap: () => _showSnackBar(context, 'Legacito card tapped'),
            ),
            
            // Dismissible widget example
            const SizedBox(height: 24),
            _buildSectionHeader(context, 'Dismissible Widget'),
            const SizedBox(height: 8),
            
            FigmaWidget(
              title: 'Desliza para eliminar',
              description: 'Esta tarjeta puede ser deslizada hacia un lado para eliminarla.',
              icon: Icons.swipe,
              iconColor: AppColors.error,
              backgroundColor: AppColors.surface,
              dismissible: true,
              onDismiss: () => _showSnackBar(context, 'Card dismissed'),
            ),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
