import 'package:barpass_app/shared/di/shared_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

/// Estados possíveis para o tema da aplicação
enum AppThemeMode {
  light('Claro', Icons.light_mode),
  dark('Escuro', Icons.dark_mode),
  system('Sistema', Icons.auto_mode);

  const AppThemeMode(this.label, this.icon);

  final String label;
  final IconData icon;

  /// Converte para ThemeMode do Flutter
  ThemeMode get themeMode {
    switch (this) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  /// Converte de string salva no storage
  static AppThemeMode fromString(String? value) {
    switch (value) {
      case 'light':
        return AppThemeMode.light;
      case 'dark':
        return AppThemeMode.dark;
      case 'system':
      default:
        return AppThemeMode.system;
    }
  }

  /// Converte para string para salvar no storage
  String toStorageString() {
    switch (this) {
      case AppThemeMode.light:
        return 'light';
      case AppThemeMode.dark:
        return 'dark';
      case AppThemeMode.system:
        return 'system';
    }
  }
}

/// Provider para gerenciar o tema da aplicação
@Riverpod(keepAlive: true)
class ThemeNotifier extends _$ThemeNotifier {
  @override
  Future<AppThemeMode> build() async {
    final themeLocalDataSource = ref.read(themeLocalDataSourceProvider);

    try {
      final savedTheme = await themeLocalDataSource.getThemeMode();
      return AppThemeMode.fromString(savedTheme);
    } on Exception catch (_) {
      // Em caso de erro, usar tema do sistema como fallback
      return AppThemeMode.system;
    }
  }

  /// Altera o tema da aplicação
  Future<void> setTheme(AppThemeMode newTheme) async {
    // Atualização otimista
    state = AsyncValue.data(newTheme);

    final themeLocalDataSource = ref.read(themeLocalDataSourceProvider);

    try {
      await themeLocalDataSource.saveThemeMode(newTheme.toStorageString());
    } on Exception catch (error, stackTrace) {
      // Reverter em caso de erro
      state = AsyncValue.error(error, stackTrace);

      // Tentar recarregar o tema salvo
      final savedTheme = await themeLocalDataSource.getThemeMode();
      state = AsyncValue.data(AppThemeMode.fromString(savedTheme));

      rethrow;
    }
  }

  /// Força o reload do tema do storage
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final themeLocalDataSource = ref.read(themeLocalDataSourceProvider);
      final savedTheme = await themeLocalDataSource.getThemeMode();
      return AppThemeMode.fromString(savedTheme);
    });
  }
}

/// Provider derivado que retorna o ThemeMode para uso no MaterialApp
@riverpod
ThemeMode currentThemeMode(Ref ref) {
  final themeState = ref.watch(themeProvider);

  return themeState.when(
    data: (appTheme) => appTheme.themeMode,
    loading: () => ThemeMode.system, // Fallback durante loading
    error: (_, _) => ThemeMode.system, // Fallback em caso de erro
  );
}
