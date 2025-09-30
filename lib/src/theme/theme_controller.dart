import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theme_setup/src/services/storage_service.dart';
import 'package:theme_setup/src/theme/theme_models.dart';

final themeControllerProvider = StateNotifierProvider<ThemeController, ThemeSettings>((ref) => ThemeController());

class ThemeController extends StateNotifier<ThemeSettings> {
  static const _storageKey = 'theme_settings';

  ThemeController() : super(_loadFromStorage());

  static ThemeSettings _loadFromStorage() {
    final raw = StorageService.read(_storageKey);
    if (raw is Map) {
      final json = Map<String, dynamic>.from(raw as Map<dynamic, dynamic>);
      return ThemeSettings.fromJson(json);
    }
    // default: system + blue seed color
    // ignore: deprecated_member_use
    return const ThemeSettings(mode: AppThemeMode.system, seedColorValue: Colors.blue.value);
  }

  Future<void> _save() async {
    await StorageService.write(_storageKey, state.toJson());
  }

  void setMode(AppThemeMode mode) {
    if (mode == state.mode) return;
    state = state.copyWith(mode: mode);
    _save();
  }

  void setSeedColor(Color color) {
    // ignore: deprecated_member_use
    if (color.value == state.seedColorValue) return;
    state = state.copyWith(seedColorValue: color.value);
    _save();
  }
}
