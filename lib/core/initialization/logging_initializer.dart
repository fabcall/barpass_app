import 'dart:developer';

import 'package:barpass_app/core/initialization/base_initializer.dart';
import 'package:flutter/foundation.dart';

class LoggingInitializer extends BaseInitializer {
  @override
  String get name => 'Logging';

  @override
  bool get isCritical => false;

  @override
  Future<InitializerResult> initialize() async {
    // Configurar logs em modo debug
    if (kDebugMode) {
      _setupDebugLogging();
    } else {
      _setupReleaseLogging();
    }

    log('📝 Sistema de logs configurado');

    return const InitializerResult(
      metadata: {
        'logging_mode': kDebugMode ? 'debug' : 'release',
      },
    );
  }

  void _setupDebugLogging() {
    // Configurações de log para desenvolvimento
    log('🔍 Logs de debug ativados');
  }

  void _setupReleaseLogging() {
    // Configurações de log para produção
    // Aqui você poderia integrar com Crashlytics, Sentry, etc.
    log('📊 Logs de produção configurados');
  }
}
