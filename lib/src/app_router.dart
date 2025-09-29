import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theme_setup/src/features/home/home_screen.dart';
import 'package:theme_setup/src/features/product/product_screen.dart';
import 'package:theme_setup/src/features/settings/settings_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/product/:id',
        name: 'product',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ProductScreen(id: id);
        },
      ),
    ],
    // web-friendly routing is default in go_router v6+; deepLinking to be supported by platform config (manifest/plist)
  );
});
