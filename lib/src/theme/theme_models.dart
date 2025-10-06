enum AppThemeMode { system, light, dark }

class ThemeSettings {
  static const int _defaultSeedColor = 0xFF2196F3; // Colors.blue value

  final AppThemeMode mode;
  final int seedColorValue; // store color as int

  const ThemeSettings({required this.mode, required this.seedColorValue});

  static ThemeSettings fallback() =>
      const ThemeSettings(mode: AppThemeMode.system, seedColorValue: _defaultSeedColor);

  Map<String, dynamic> toJson() => {
        'mode': mode.index,
        'seedColorValue': seedColorValue,
      };

  factory ThemeSettings.fromJson(Map<String, dynamic> json) {
    final modeIndex = json['mode'];
    final seedValue = json['seedColorValue'];

    if (modeIndex is int &&
        modeIndex >= 0 &&
        modeIndex < AppThemeMode.values.length &&
        seedValue is int) {
      return ThemeSettings(
        mode: AppThemeMode.values[modeIndex],
        seedColorValue: seedValue,
      );
    }

    return fallback();
  }
}
