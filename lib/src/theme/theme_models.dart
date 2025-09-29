enum AppThemeMode { system, light, dark }

class ThemeSettings {
  final AppThemeMode mode;
  final int seedColorValue; // store color as int

  ThemeSettings({required this.mode, required this.seedColorValue});

  Map<String, dynamic> toJson() => {
    'mode': mode.index,
    'seedColorValue': seedColorValue,
  };

  factory ThemeSettings.fromJson(Map<String, dynamic> json) {
    return ThemeSettings(
      mode: AppThemeMode.values[json['mode'] as int],
      seedColorValue: json['seedColorValue'] as int,
    );
  }
}
