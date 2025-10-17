import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../screens/auth/auth_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/camino_legado/camino_legado_screen.dart';
import '../screens/achievements/achievements_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/nodo_detail/nodo_detail_screen.dart';
import '../providers/profile_provider.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      GoRoute(path: '/login', builder: (context, state) => AuthScreen()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/achievements',
        builder: (context, state) => AchievementsScreen(),
      ),
      GoRoute(
        path: '/nodo/:id',
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
          return NodoDetailScreen(nodoId: id);
        },
      ),
      GoRoute(path: '/profile', builder: (context, state) => ProfileScreen()),
    ],
    redirect: (context, state) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final isLoggedIn = authProvider.status == AuthStatus.Authenticated;
      final isLoggingIn = state.matchedLocation == '/login';

      if (isLoggedIn) {
        Provider.of<ProfileProvider>(
          context,
          listen: false,
        ).loadUserProfile(authProvider.user!);
      }

      if (authProvider.status == AuthStatus.Uninitialized) return '/splash';
      if (!isLoggedIn) return '/login';
      if (isLoggedIn && isLoggingIn) return '/home';

      return null;
    },
  );

  static GoRouter get router => _router;
}
