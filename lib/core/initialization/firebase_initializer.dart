import 'dart:developer';

import 'package:barpass_app/core/initialization/base_initializer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Inicializador do Firebase que detecta o ambiente automaticamente
class FirebaseInitializer extends BaseInitializer {
  @override
  String get name => 'Firebase';

  @override
  bool get isCritical => true; // Firebase é crítico para a aplicação

  @override
  Future<InitializerResult> initialize() async {
    try {
      log('🔥 Inicializando Firebase...');

      // Obtém as opções baseadas no ambiente
      final options = _getFirebaseOptions();

      // Inicializa o Firebase
      await Firebase.initializeApp(options: options);

      final projectId = options.projectId;
      final environment = _getEnvironmentFromProjectId(projectId);

      log('✅ Firebase inicializado com sucesso');
      log('📱 Project ID: $projectId');
      log('🌍 Environment: $environment');

      return InitializerResult(
        metadata: {
          'project_id': projectId,
          'environment': environment,
          'initialized': true,
        },
      );
    } on Exception catch (error, stackTrace) {
      log('❌ Erro ao inicializar Firebase: $error');
      log('Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Obtém as opções do Firebase baseado no ambiente de compilação
  FirebaseOptions _getFirebaseOptions() {
    // Detecta o ambiente pela variável de compilação
    const environment = String.fromEnvironment('ENV', defaultValue: 'dev');

    log('🔍 Detectando ambiente: $environment');

    switch (environment) {
      case 'prod':
        return _getProductionOptions();
      case 'staging':
        return _getStagingOptions();
      case 'dev':
      default:
        return _getDevelopmentOptions();
    }
  }

  /// Retorna as opções de desenvolvimento
  FirebaseOptions _getDevelopmentOptions() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return const FirebaseOptions(
        apiKey: 'AIzaSyD4fImh3pXXN5sYvoMd0wBpC1oSxop5XrU',
        appId: '1:23284937499:android:84dfcece36bdcf017899be',
        messagingSenderId: '23284937499',
        projectId: 'dev-barpass',
        storageBucket: 'dev-barpass.firebasestorage.app',
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return const FirebaseOptions(
        apiKey: 'AIzaSyAAW-kg7CWHqV9iMb2kl1JRcjfynvMI1Cg',
        appId: '1:23284937499:ios:b5cfd6237f99e4007899be',
        messagingSenderId: '23284937499',
        projectId: 'dev-barpass',
        storageBucket: 'dev-barpass.firebasestorage.app',
        iosBundleId: 'br.com.barpass.app.dev',
      );
    }

    throw UnsupportedError('Plataforma não suportada para Firebase');
  }

  /// Retorna as opções de staging
  FirebaseOptions _getStagingOptions() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return const FirebaseOptions(
        apiKey: 'AIzaSyBc5pRlpRt1se3MqTFH8Z6mmM1L__cHMgk',
        appId: '1:67493856689:android:2acd4c1d19f60f8089e990',
        messagingSenderId: '67493856689',
        projectId: 'stg-barpass',
        storageBucket: 'stg-barpass.firebasestorage.app',
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return const FirebaseOptions(
        apiKey: 'AIzaSyCIb_Ghwmcat5vVPxI3gUsiMZaMX5BJf_Q',
        appId: '1:67493856689:ios:b3f443b64b0ff0f389e990',
        messagingSenderId: '67493856689',
        projectId: 'stg-barpass',
        storageBucket: 'stg-barpass.firebasestorage.app',
        iosBundleId: 'br.com.barpass.app.stg',
      );
    }

    throw UnsupportedError('Plataforma não suportada para Firebase');
  }

  /// Retorna as opções de produção
  FirebaseOptions _getProductionOptions() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return const FirebaseOptions(
        apiKey: 'AIzaSyDS2d-kRSV2RKYeSWmGrGZwBckYX2v7BRY',
        appId: '1:40064082949:android:430f518a61f2e1ccd4286c',
        messagingSenderId: '40064082949',
        projectId: 'prd-barpass',
        storageBucket: 'prd-barpass.firebasestorage.app',
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return const FirebaseOptions(
        apiKey: 'AIzaSyB81vkdYVNZTG_GBuaQ28CstQZ-S68_-q8',
        appId: '1:40064082949:ios:2a1a91e0ec77f9ced4286c',
        messagingSenderId: '40064082949',
        projectId: 'prd-barpass',
        storageBucket: 'prd-barpass.firebasestorage.app',
        iosBundleId: 'br.com.barpass.app',
      );
    }

    throw UnsupportedError('Plataforma não suportada para Firebase');
  }

  /// Extrai o nome do ambiente do project ID
  String _getEnvironmentFromProjectId(String projectId) {
    if (projectId.startsWith('prd-')) return 'production';
    if (projectId.startsWith('stg-')) return 'staging';
    if (projectId.startsWith('dev-')) return 'development';
    return 'unknown';
  }

  /// Verifica se o Firebase já está inicializado
  static bool get isInitialized {
    try {
      Firebase.app();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
