import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Keys for SharedPreferences
class SettingsKeys {
  static const String themeMode = 'theme_mode';
  static const String locale = 'locale';
  static const String autoSave = 'auto_save';
  static const String cloudSync = 'cloud_sync';
  static const String storageLocation = 'storage_location';
}

// State class for Settings
class SettingsState {
  final ThemeMode themeMode;
  final Locale locale;
  final bool autoSave;
  final bool cloudSync;
  final String storageLocation;

  SettingsState({
    required this.themeMode,
    required this.locale,
    required this.autoSave,
    required this.cloudSync,
    required this.storageLocation,
  });

  SettingsState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    bool? autoSave,
    bool? cloudSync,
    String? storageLocation,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      autoSave: autoSave ?? this.autoSave,
      cloudSync: cloudSync ?? this.cloudSync,
      storageLocation: storageLocation ?? this.storageLocation,
    );
  }
}

// Notifier for Settings
class SettingsNotifier extends StateNotifier<SettingsState> {
  final SharedPreferences _prefs;

  SettingsNotifier(this._prefs)
      : super(SettingsState(
          themeMode: _getThemeMode(_prefs.getString(SettingsKeys.themeMode)),
          locale: Locale(_prefs.getString(SettingsKeys.locale) ?? 'en'),
          autoSave: _prefs.getBool(SettingsKeys.autoSave) ?? true,
          cloudSync: _prefs.getBool(SettingsKeys.cloudSync) ?? false,
          storageLocation:
              _prefs.getString(SettingsKeys.storageLocation) ?? 'Default',
        ));

  static ThemeMode _getThemeMode(String? mode) {
    switch (mode) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _prefs.setString(SettingsKeys.themeMode, mode.name);
    state = state.copyWith(themeMode: mode);
  }

  Future<void> setLocale(Locale locale) async {
    await _prefs.setString(SettingsKeys.locale, locale.languageCode);
    state = state.copyWith(locale: locale);
  }

  Future<void> setStorageLocation(String location) async {
    await _prefs.setString(SettingsKeys.storageLocation, location);
    state = state.copyWith(storageLocation: location);
  }

  Future<void> toggleAutoSave(bool value) async {
    await _prefs.setBool(SettingsKeys.autoSave, value);
    state = state.copyWith(autoSave: value);
  }

  Future<void> toggleCloudSync(bool value) async {
    await _prefs.setBool(SettingsKeys.cloudSync, value);
    state = state.copyWith(cloudSync: value);
  }
}

// Provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SettingsNotifier(prefs);
});
