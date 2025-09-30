import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:theme_setup/src/services/storage_service.dart';
import 'package:theme_setup/src/theme/theme_controller.dart';
import 'package:theme_setup/src/theme/theme_models.dart';

void main() {
  late Directory tempDir;

  group('StorageService', () {
    setUpAll(() async {
      tempDir = await Directory.systemTemp.createTemp('hive_test');
      Hive.init(tempDir.path);
      await StorageService.init();
    });

    setUp(() async {
      await Hive.box('settings').clear();
    });

    tearDownAll(() async {
      final settingsBox = Hive.box('settings');
      await settingsBox.close();
      await Hive.deleteBoxFromDisk('settings');
      await Hive.close();
      await tempDir.delete(recursive: true);
    });

    test('write and read theme settings', () async {
      const key = 'test_theme';
      final value = {'mode': 1, 'seedColorValue': 0xFF123456};
      await StorageService.write(key, value);
      final result = StorageService.read(key);
      expect(result['mode'], 1);
      expect(result['seedColorValue'], 0xFF123456);
    });

    test('ThemeController loads persisted values from storage', () async {
      const stored = {
        'mode': 2,
        'seedColorValue': 0xFFABCDEF,
      };
      await StorageService.write('theme_settings', stored);

      final controller = ThemeController();

      expect(controller.state.mode, AppThemeMode.dark);
      expect(controller.state.seedColorValue, 0xFFABCDEF);
    });

    test('ThemeController state updates skip redundant writes', () async {
      final controller = ThemeController();

      controller.setMode(AppThemeMode.light);
      controller.setSeedColor(const Color(0xFF112233));

      expect(controller.state.mode, AppThemeMode.light);
      expect(controller.state.seedColorValue, 0xFF112233);

      // Calling with the same values should not alter state.
      controller.setMode(AppThemeMode.light);
      controller.setSeedColor(const Color(0xFF112233));

      expect(controller.state.mode, AppThemeMode.light);
      expect(controller.state.seedColorValue, 0xFF112233);
    });
  });
}
