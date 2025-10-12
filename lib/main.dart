import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/reset_password_screen.dart';
import 'screens/camino_legado_screen.dart';
import 'screens/step_tracking_screen.dart';
import 'screens/achievements_screen.dart';
import 'screens/figma_widget_demo_screen.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_routes.dart';
import 'core/constants/app_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Run flutterfire configure to generate firebase_options.dart with your project settings
  // If flutterfire hasn't been run yet the placeholder returns null.
  // In that case initialize without options and the app can still run (useful for local dev until config is added).
  if (DefaultFirebaseOptions.currentPlatform == null) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: AppTheme.darkTheme(),
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.signup: (context) => const SignupScreen(),
        AppRoutes.reset: (context) => const ResetPasswordScreen(),
        AppRoutes.caminoLegado: (context) => const CaminoLegadoScreen(),
        AppRoutes.stepTracking: (context) => const StepTrackingScreen(),
        '/achievements': (context) => const AchievementsScreen(),
        AppRoutes.figmaWidgetDemo: (context) => const FigmaWidgetDemoScreen(),
      },
    );
  }
}
