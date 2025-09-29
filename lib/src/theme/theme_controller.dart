import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:theme_setup/src/services/storage_service.dart';
import 'package:theme_setup/src/theme/theme_models.dart';

final themeControllerProvider = StateNotifierProvider<ThemeController, ThemeSettings>((ref) => ThemeController());

class ThemeController extends StateNotifier<ThemeSettings> {
  static const _storageKey = 'theme_settings';

  ThemeController() : super(_loadFromStorage());

  static ThemeSettings _loadFromStorage() {
    final raw = StorageService.read(_storageKey);
    if (raw is Map<String, dynamic>) {
      return ThemeSettings.fromJson(raw);
    }
    // default: system + blue seed color
    // ignore: deprecated_member_use
    return ThemeSettings(mode: AppThemeMode.system, seedColorValue: Colors.blue.value);
  }

  Future<void> _save() async {
    await StorageService.write(_storageKey, state.toJson());
  }

  void setMode(AppThemeMode mode) {
    state = ThemeSettings(mode: mode, seedColorValue: state.seedColorValue);
    _save();
  }

  void setSeedColor(Color color) {
    // ignore: deprecated_member_use
    state = ThemeSettings(mode: state.mode, seedColorValue: color.value);
    _save();
  }
}
