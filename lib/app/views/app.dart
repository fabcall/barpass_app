import 'package:barpass_app/core/router/app_router.dart';
import 'package:barpass_app/core/theme/app_theme.dart';
import 'package:barpass_app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Classe principal da aplicação
///
/// Configura o MaterialApp com:
/// - Roteamento via GoRouter
/// - Temas claro e escuro
/// - Localização
/// - Configurações globais
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      // === ROTEAMENTO ===
      routerConfig: router,

      // === TEMAS ===
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,

      // === LOCALIZAÇÃO ===
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      // === CONFIGURAÇÕES GLOBAIS ===
      title: 'BarPass',
      debugShowCheckedModeBanner: false,

      // === CONFIGURAÇÕES DE PERFORMANCE ===
      builder: (context, child) {
        // Aqui você pode adicionar wrappers globais como:
        // - MediaQuery override para acessibilidade
        // - Overlays globais
        // - Error boundaries
        return child ?? const SizedBox.shrink();
      },
    );
  }
}
