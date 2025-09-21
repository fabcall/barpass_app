import 'dart:async';
import 'dart:developer';

import 'package:barpass_app/core/initialization/app_info_initializer.dart';
import 'package:barpass_app/core/initialization/base_initializer.dart';
import 'package:barpass_app/core/initialization/firebase_initializer.dart';
import 'package:barpass_app/core/initialization/logging_initializer.dart';
import 'package:barpass_app/core/initialization/platform_initializer.dart';
import 'package:barpass_app/core/initialization/push_notification_initializer.dart';
import 'package:barpass_app/core/initialization/theme_initializer.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/misc.dart';

/// Resultado da inicialização
class InitializationResult {
  const InitializationResult({
    required this.providerOverrides,
    this.metadata = const {},
  });

  final List<Override> providerOverrides;
  final Map<String, dynamic> metadata;
}

/// Gerenciador principal de inicialização
class AppInitializer {
  static final List<BaseInitializer> _initializers = [
    LoggingInitializer(),
    PlatformInitializer(),
    FirebaseInitializer(),
    AppInfoInitializer(),
    PushNotificationInitializer(),
    ThemeInitializer(),
  ];

  /// Inicializa a aplicação de forma robusta
  static Future<InitializationResult> initialize() async {
    try {
      log('🚀 Iniciando inicialização da aplicação...');

      // Garantir que o binding está inicializado
      WidgetsFlutterBinding.ensureInitialized();

      final overrides = <Override>[];
      final metadata = <String, dynamic>{};

      // Executar inicializadores em ordem
      for (final initializer in _initializers) {
        try {
          log('📋 Executando: ${initializer.name}');

          final result = await initializer.initialize();

          if (result.providerOverrides.isNotEmpty) {
            overrides.addAll(result.providerOverrides);
          }

          if (result.metadata.isNotEmpty) {
            metadata.addAll(result.metadata);
          }

          log('✅ ${initializer.name} concluído');
        } catch (e, stackTrace) {
          log('❌ Erro em ${initializer.name}: $e', stackTrace: stackTrace);

          // Se o inicializador é crítico, propagar o erro
          if (initializer.isCritical) {
            rethrow;
          }
        }
      }

      log('🎉 Inicialização concluída com sucesso');

      return InitializationResult(
        providerOverrides: overrides,
        metadata: metadata,
      );
    } catch (e, stackTrace) {
      log('💥 Falha crítica na inicialização: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Registra um novo inicializador
  static void registerInitializer(BaseInitializer initializer) {
    _initializers.add(initializer);
  }

  /// Remove um inicializador
  static void unregisterInitializer(Type type) {
    _initializers.removeWhere((init) => init.runtimeType == type);
  }
}
