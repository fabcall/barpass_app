import 'package:barpass_app/core/di/core_dependencies.dart';
import 'package:barpass_app/shared/data/datasources/language_local_datasource.dart';
import 'package:barpass_app/shared/data/datasources/theme_local_datasource.dart';
import 'package:barpass_app/shared/providers/theme_provider.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shared_dependencies.g.dart';

/// Dependências compartilhadas da aplicação
class SharedDependencies {
  SharedDependencies._();

  static List<ProviderBase<dynamic>> get providers => [
    // L10n management
    languageLocalDataSourceProvider,
    // Theme management
    themeLocalDataSourceProvider,
    themeProvider,
    currentThemeModeProvider,
  ];
}

/// Provider para o DataSource de tema
@Riverpod(keepAlive: true)
ThemeLocalDataSource themeLocalDataSource(Ref ref) {
  final storage = ref.read(storageServiceProvider);
  return ThemeLocalDataSourceImpl(storage);
}

/// Provider para o DataSource de idioma
@Riverpod(keepAlive: true)
LanguageLocalDataSource languageLocalDataSource(Ref ref) {
  final storage = ref.read(storageServiceProvider);
  return LanguageLocalDataSourceImpl(storage);
}
