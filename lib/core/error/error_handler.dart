import 'dart:developer';

import 'package:barpass_app/core/error/app_error.dart';
import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:flutter/material.dart';

class ErrorHandler {
  static AppError handleError(Object error, [StackTrace? stackTrace]) {
    log('Error occurred: $error', stackTrace: stackTrace);

    if (error is AppError) {
      return error;
    }

    // Mapear erros específicos para AppError
    if (error.toString().contains('network') ||
        error.toString().contains('connection')) {
      return const AppError.network(
        message: 'Erro de conexão',
        isRetryable: true,
      );
    }

    return AppError.unknown(
      message: error.toString(),
      originalError: error,
      stackTrace: stackTrace,
    );
  }

  static void showErrorSnackBar(BuildContext context, AppError error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error.userFriendlyMessage),
        backgroundColor: context.colorScheme.error,
        action: error.canRetry
            ? SnackBarAction(
                label: 'Tentar novamente',
                onPressed: () {
                  // Implementar retry logic
                },
              )
            : null,
      ),
    );
  }
}
