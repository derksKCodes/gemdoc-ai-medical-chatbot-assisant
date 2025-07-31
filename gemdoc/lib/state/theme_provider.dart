import 'package:flutter/material.dart';

/// Provider to manage app-wide theme (dark/light/system)
class ThemeProvider with ChangeNotifier {
  // Internal state: default to system theme
  ThemeMode _themeMode = ThemeMode.system;

  /// Expose current theme mode
  ThemeMode get themeMode => _themeMode;

  /// Check if current theme is dark mode
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  /// Toggle theme between dark and light
  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Notify widgets to rebuild with new theme
  }
}
