import 'package:barpass_app/app/presentation/providers/app_state.dart';
import 'package:barpass_app/core/di/core_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_state_provider.g.dart';

@Riverpod(keepAlive: true)
class AppStateNotifier extends _$AppStateNotifier {
  @override
  AppState build() {
    _initialize();
    return const AppState();
  }

  Future<void> _initialize() async {
    try {
      // Carregar configurações globais
      final themeMode = await _loadThemeMode();
      final locale = await _loadLocale();

      state = state.copyWith(
        initStatus: AppInitializationStatus.completed,
        themeMode: themeMode,
        locale: locale,
        error: null,
      );
    } catch (error) {
      state = state.copyWith(
        initStatus: AppInitializationStatus.error,
        error: error.toString(),
      );
    }
  }

  Future<ThemeMode> _loadThemeMode() async {
    try {
      final storageService = ref.read(storageServiceProvider);
      final themeModeString = await storageService.getThemeMode();

      return switch (themeModeString) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };
    } catch (e) {
      return ThemeMode.system;
    }
  }

  Future<String> _loadLocale() async {
    try {
      final storageService = ref.read(storageServiceProvider);
      final locale = await storageService.getLanguage();
      return locale ?? 'pt';
    } catch (e) {
      return 'pt';
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    try {
      final storageService = ref.read(storageServiceProvider);
      await storageService.setThemeMode(mode.name);

      state = state.copyWith(themeMode: mode);
    } catch (error) {
      state = state.copyWith(error: error.toString());
    }
  }

  Future<void> setLocale(String locale) async {
    try {
      final storageService = ref.read(storageServiceProvider);
      await storageService.setLanguage(locale);

      state = state.copyWith(locale: locale);
    } catch (error) {
      state = state.copyWith(error: error.toString());
    }
  }

  Future<void> retry() async {
    state = const AppState(); // Reset to loading
    await _initialize();
  }
}
