import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:theme_setup/src/theme/theme_controller.dart';
import 'package:theme_setup/src/theme/theme_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theme_setup/src/widgets/color_picker_button.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeSettings = ref.watch(themeControllerProvider);
    final mode = themeSettings.mode;
    final seedColor = Color(themeSettings.seedColorValue);

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Theme Mode: $mode'),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => ref
                      .read(themeControllerProvider.notifier)
                      .setMode(AppThemeMode.system),
                  child: const Text('System'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => ref
                      .read(themeControllerProvider.notifier)
                      .setMode(AppThemeMode.light),
                  child: const Text('Light'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => ref
                      .read(themeControllerProvider.notifier)
                      .setMode(AppThemeMode.dark),
                  child: const Text('Dark'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Seed Color:'),
            Row(
              children: [
                ColorPickerButton(
                  color: seedColor,
                  onColorChanged: (color) => ref
                      .read(themeControllerProvider.notifier)
                      .setSeedColor(color),
                ),
                const SizedBox(width: 8),
                Text('Current: #${seedColor.toString().toUpperCase()}'),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.push('/settings'),
              child: const Text('Go to Settings'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => context.push('/product/42'),
              child: const Text('Go to Product 42'),
            ),
          ],
        ),
      ),
    );
  }
}
