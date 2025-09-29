import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  static const _settingsBox = 'settings';
  static Box? _box;

  static Future<void> init() async {
    _box = await Hive.openBox(_settingsBox);
  }

  static dynamic read(String key, {dynamic defaultValue}) {
    return _box?.get(key, defaultValue: defaultValue);
  }

  static Future<void> write(String key, dynamic value) async {
    await _box?.put(key, value);
  }
}
