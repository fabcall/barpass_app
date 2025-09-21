import 'package:barpass_app/shared/providers/theme_provider.dart';
import 'package:flutter_riverpod/misc.dart';

/// Dependências compartilhadas da aplicação
class SharedDependencies {
  SharedDependencies._();

  static List<ProviderBase<dynamic>> get providers => [
    // Theme management
    themeProvider,
    currentThemeModeProvider,
  ];
}
