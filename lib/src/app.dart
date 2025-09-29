import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theme_setup/src/app_router.dart';
import 'package:theme_setup/src/theme/theme_controller.dart';
import 'package:theme_setup/src/theme/theme_defs.dart';
import 'package:theme_setup/src/theme/theme_models.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeSettings = ref.watch(themeControllerProvider);
    final seedColor = Color(themeSettings.seedColorValue);

    final router = ref.read(goRouterProvider);

    return MaterialApp.router(
      title: 'Material3 Demo App',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: buildThemeFromSeed(seedColor, false),
      darkTheme: buildThemeFromSeed(seedColor, true),
      themeMode: themeSettings.mode == AppThemeMode.system
          ? ThemeMode.system
          : (themeSettings.mode == AppThemeMode.light
                ? ThemeMode.light
                : ThemeMode.dark),
    );
  }
}
