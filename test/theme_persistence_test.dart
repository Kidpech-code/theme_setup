import 'package:flutter_test/flutter_test.dart';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:theme_setup/src/services/storage_service.dart';

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
      final result = StorageService.read(key);
      expect(result['mode'], 1);
      expect(result['seedColorValue'], 0xFF123456);
    });
  });
}
