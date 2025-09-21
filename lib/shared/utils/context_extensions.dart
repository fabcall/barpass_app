import 'package:barpass_app/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension ContextExtensions on BuildContext {
  // Theme
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => ColorScheme.of(this);
  TextTheme get textTheme => TextTheme.of(this);

  // MediaQuery
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  EdgeInsets get viewPadding => mediaQuery.viewPadding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;

  // Navigation
  void pushNamed(String name, {Map<String, String> pathParameters = const {}}) {
    GoRouter.of(this).pushNamed(name, pathParameters: pathParameters);
  }

  void goNamed(String name, {Map<String, String> pathParameters = const {}}) {
    GoRouter.of(this).goNamed(name, pathParameters: pathParameters);
  }

  void pop<T>([T? result]) => GoRouter.of(this).pop(result);

  bool get canPop => GoRouter.of(this).canPop();

  // Localization
  AppLocalizations get l10n => AppLocalizations.of(this);

  // Snackbar helpers
  void showSnackBar(
    String message, {
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 4),
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        action: action,
        duration: duration,
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void showErrorSnackBar(String message, {VoidCallback? onRetry}) {
    showSnackBar(
      message,
      backgroundColor: colorScheme.error,
      action: onRetry != null
          ? SnackBarAction(
              label: 'Tentar novamente',
              textColor: colorScheme.onError,
              onPressed: onRetry,
            )
          : null,
    );
  }

  void showSuccessSnackBar(String message) {
    showSnackBar(
      message,
      backgroundColor: Colors.green,
    );
  }
}
