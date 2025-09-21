import 'package:flutter/material.dart';

/// Widget que fecha o teclado quando o usuário toca fora dos campos de texto.
///
/// Uso:
/// ```dart
/// KeyboardDismissWrapper(
///   child: YourWidget(),
/// )
/// ```
class KeyboardDismissWrapper extends StatelessWidget {
  const KeyboardDismissWrapper({
    required this.child,
    this.dismissOnTap = true,
    super.key,
  });

  /// Widget filho que será envolvido pelo dismiss behavior
  final Widget child;

  /// Se true, o teclado será fechado ao tocar. Se false, apenas ao arrastar.
  final bool dismissOnTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: dismissOnTap
          ? () {
              final currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            }
          : null,
      child: child,
    );
  }
}

/// Extensão para facilitar o uso do KeyboardDismiss em qualquer widget
extension KeyboardDismissExtension on Widget {
  /// Envolve o widget com um KeyboardDismissWrapper
  ///
  /// Uso:
  /// ```dart
  /// Column(
  ///   children: [...],
  /// ).dismissKeyboard()
  /// ```
  Widget dismissKeyboard({bool dismissOnTap = true}) {
    return KeyboardDismissWrapper(
      dismissOnTap: dismissOnTap,
      child: this,
    );
  }
}
