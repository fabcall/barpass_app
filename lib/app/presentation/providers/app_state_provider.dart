import 'package:barpass_app/app/presentation/state/app_state.dart';
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
      // Iniciar ambas operações em paralelo
      final results = await Future.wait([
        // Carregar configurações
        _loadSettings(),
        // Garantir tempo mínimo para animação (2 segundos)
        Future<void>.delayed(const Duration(milliseconds: 2500)),
      ]);

      final settings = results[0] as ({ThemeMode themeMode, String locale});

      state = state.copyWith(
        initStatus: AppInitializationStatus.completed,
        themeMode: settings.themeMode,
        locale: settings.locale,
        error: null,
      );
    } catch (error) {
      // Mesmo em caso de erro, aguarda o tempo mínimo
      await Future<void>.delayed(const Duration(milliseconds: 2500));

      state = state.copyWith(
        initStatus: AppInitializationStatus.error,
        error: error.toString(),
      );
    }
  }

  Future<({ThemeMode themeMode, String locale})> _loadSettings() async {
    final themeMode = await _loadThemeMode();
    final locale = await _loadLocale();
    return (themeMode: themeMode, locale: locale);
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
