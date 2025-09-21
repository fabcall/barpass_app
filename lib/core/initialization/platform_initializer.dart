import 'dart:developer';

import 'package:barpass_app/core/initialization/base_initializer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlatformInitializer extends BaseInitializer {
  @override
  String get name => 'Platform';

  @override
  bool get isCritical => false;

  @override
  Future<InitializerResult> initialize() async {
    // Configurar orientação
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Configurar status bar
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    // Configurações específicas por plataforma
    if (defaultTargetPlatform == TargetPlatform.android) {
      await _configureAndroid();
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      await _configureiOS();
    }

    log('📱 Configurações de plataforma aplicadas');

    return const InitializerResult(
      metadata: {
        'platform': 'configured',
        'orientation': 'portrait_only',
      },
    );
  }

  Future<void> _configureAndroid() async {
    // Configurações específicas do Android
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );
  }

  Future<void> _configureiOS() async {
    // Configurações específicas do iOS
    // Adicionar configurações específicas se necessário
  }
}
