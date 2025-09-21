// lib/app/presentation/widgets/app_widget.dart
import 'package:barpass_app/core/router/app_router_provider.dart';
import 'package:barpass_app/core/theme/app_theme.dart';
import 'package:barpass_app/l10n/gen/app_localizations.dart';
import 'package:barpass_app/shared/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppWidget extends ConsumerWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(currentThemeModeProvider);

    return MaterialApp.router(
      // === ROTEAMENTO ===
      routerConfig: router,

      // === TEMAS ===
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode, // Agora usando o provider
      // === LOCALIZAÇÃO ===
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      // === CONFIGURAÇÕES GLOBAIS ===
      title: 'BarPass',
      debugShowCheckedModeBanner: false,

      // === CONFIGURAÇÕES DE PERFORMANCE ===
      builder: (context, child) {
        return child ?? const SizedBox.shrink();
      },
    );
  }
}
