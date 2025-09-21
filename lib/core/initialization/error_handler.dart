import 'dart:developer';
import 'package:flutter/foundation.dart';

class AppErrorHandler {
  static void initialize() {
    // Capturar erros do Flutter
    FlutterError.onError = _handleFlutterError;

    // Capturar erros não tratados
    PlatformDispatcher.instance.onError = (error, stack) {
      _handlePlatformError(error, stack);
      return true;
    };
  }

  static void _handleFlutterError(FlutterErrorDetails details) {
    if (kDebugMode) {
      // Em debug, mostrar erro completo
      log(
        'Flutter Error: ${details.exceptionAsString()}',
        stackTrace: details.stack,
        name: 'FlutterError',
      );
      FlutterError.dumpErrorToConsole(details);
    } else {
      // Em produção, log mais limpo
      log(
        'Flutter Error: ${details.exception}',
        name: 'FlutterError',
      );
      // Aqui você enviaria para um serviço de crash reporting
      _reportError(details.exception, details.stack);
    }
  }

  static void _handlePlatformError(Object error, StackTrace stack) {
    if (kDebugMode) {
      log(
        'Platform Error: $error',
        stackTrace: stack,
        name: 'PlatformError',
      );
    } else {
      log('Platform Error: $error', name: 'PlatformError');
      _reportError(error, stack);
    }
  }

  static void _reportError(Object error, StackTrace? stack) {
    // Integração com serviços de crash reporting
    // Ex: FirebaseCrashlytics.instance.recordError(error, stack);
    // Ex: Sentry.captureException(error, stackTrace: stack);
  }
}
