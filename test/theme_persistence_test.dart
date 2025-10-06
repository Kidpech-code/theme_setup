import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:theme_setup/src/services/storage_service.dart';
import 'package:theme_setup/src/theme/theme_models.dart';

void main() {
  group('StorageService', () {
    setUpAll(() async {
      final tempDir = await Directory.systemTemp.createTemp('hive_test');
      Hive.init(tempDir.path);
      await StorageService.init();
    });

    test('write and read theme settings', () async {
      const key = 'test_theme';
      final value = {'mode': 1, 'seedColorValue': 0xFF123456};
      await StorageService.write(key, value);
      final result = StorageService.read(key) as Map<String, dynamic>;
      expect(result['mode'], 1);
      expect(result['seedColorValue'], 0xFF123456);
    });
  });

  group('ThemeSettings', () {
    test('fromJson returns fallback when data is invalid', () {
      final invalidJson = {'mode': 99, 'seedColorValue': 'not an int'};
      final settings = ThemeSettings.fromJson(invalidJson);
      final fallback = ThemeSettings.fallback();

      expect(settings.mode, fallback.mode);
      expect(settings.seedColorValue, fallback.seedColorValue);
    });
  });
}
