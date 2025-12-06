import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

/// Theme mode notifier that manages the app's theme state
/// Persists theme preference to local storage using Hive
@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  static const String _themeBoxName = 'theme_preferences';
  static const String _themeModeKey = 'theme_mode';

  late Box _themeBox;

  @override
  ThemeMode build() {
    _initializeTheme();
    return ThemeMode.system; // Default while loading
  }

  /// Initialize theme from storage
  Future<void> _initializeTheme() async {
    try {
      _themeBox = await Hive.openBox(_themeBoxName);
      final savedThemeIndex = _themeBox.get(_themeModeKey, defaultValue: 0);
      state = ThemeMode.values[savedThemeIndex];
    } catch (e) {
      // If error, use system theme
      state = ThemeMode.system;
    }
  }

  /// Set theme mode and persist to storage
  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    try {
      await _themeBox.put(_themeModeKey, mode.index);
    } catch (e) {
      // Handle error silently
      debugPrint('Error saving theme preference: $e');
    }
  }

  /// Toggle between light and dark themes
  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await setThemeMode(newMode);
  }

  /// Set light theme
  Future<void> setLightTheme() async {
    await setThemeMode(ThemeMode.light);
  }

  /// Set dark theme
  Future<void> setDarkTheme() async {
    await setThemeMode(ThemeMode.dark);
  }

  /// Set system theme
  Future<void> setSystemTheme() async {
    await setThemeMode(ThemeMode.system);
  }

  /// Check if current theme is dark
  bool get isDarkMode {
    if (state == ThemeMode.system) {
      // Get system brightness
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    }
    return state == ThemeMode.dark;
  }

  /// Get human-readable theme mode name
  String get themeModeName {
    switch (state) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }
}
