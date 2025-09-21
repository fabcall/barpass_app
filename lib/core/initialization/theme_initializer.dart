import 'dart:developer';

import 'base_initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeInitializer extends BaseInitializer {
  @override
  String get name => 'Theme';

  @override
  bool get isCritical => false;

  @override
  Future<InitializerResult> initialize() async {
    // Pré-carregar fontes customizadas se necessário
    await _preloadFonts();

    // Configurar tema do sistema
    await _configureSystemTheme();

    log('🎨 Configurações de tema aplicadas');

    return const InitializerResult(
      metadata: {
        'fonts': 'preloaded',
        'system_theme': 'configured',
      },
    );
  }

  Future<void> _preloadFonts() async {
    // Pré-carregar a fonte Comfortaa se necessário
    // FontLoader pode ser usado aqui para fontes customizadas
  }

  Future<void> _configureSystemTheme() async {
    // Configurar cores da status bar baseado no tema
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }
}
