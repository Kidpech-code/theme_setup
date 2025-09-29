import 'package:flutter/material.dart';
import 'package:theme_setup/src/theme/theme_controller.dart';
import 'package:theme_setup/src/theme/theme_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theme_setup/src/widgets/color_picker_button.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeSettings = ref.watch(themeControllerProvider);
    final mode = themeSettings.mode;
    final seedColor = Color(themeSettings.seedColorValue);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        automaticallyImplyLeading:
            true, // ensures back button is shown if possible
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Theme Mode:'),
            Row(
              children: [
                Radio<AppThemeMode>(
                  value: AppThemeMode.system,
                  groupValue: mode,
                  onChanged: (v) =>
                      ref.read(themeControllerProvider.notifier).setMode(v!),
                ),
                const Text('System'),
                Radio<AppThemeMode>(
                  value: AppThemeMode.light,
                  groupValue: mode,
                  onChanged: (v) =>
                      ref.read(themeControllerProvider.notifier).setMode(v!),
                ),
                const Text('Light'),
                Radio<AppThemeMode>(
                  value: AppThemeMode.dark,
                  groupValue: mode,
                  onChanged: (v) =>
                      ref.read(themeControllerProvider.notifier).setMode(v!),
                ),
                const Text('Dark'),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Seed Color:'),
            ColorPickerButton(
              color: seedColor,
              onColorChanged: (color) => ref
                  .read(themeControllerProvider.notifier)
                  .setSeedColor(color),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => ref
                  .read(themeControllerProvider.notifier)
                  .setSeedColor(Colors.blue),
              child: const Text('Reset to Default'),
            ),
          ],
        ),
      ),
    );
  }
}
