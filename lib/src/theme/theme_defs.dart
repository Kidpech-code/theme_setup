import 'package:flutter/material.dart';

ThemeData buildThemeFromSeed(Color seed, bool useDark) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: seed,
    brightness: useDark ? Brightness.dark : Brightness.light,
  );
  return ThemeData(
    colorScheme: colorScheme,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
    ),
    // Add more component themes or typography overrides here as needed
  );
}
