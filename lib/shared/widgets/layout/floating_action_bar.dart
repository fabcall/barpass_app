import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:flutter/material.dart';

/// Barra de ação flutuante para usar como bottomBar em sheets
///
/// Cria um efeito de névoa (fog/fade) que gradualmente esconde o conteúdo
/// scrollável embaixo, dando a sensação de que o botão flutua sobre o conteúdo.
class FloatingActionBar extends StatelessWidget {
  const FloatingActionBar({
    required this.child,
    super.key,
    this.padding,
    this.fadeHeight = 40,
  });

  /// Widget filho (geralmente um botão)
  final Widget child;

  /// Padding ao redor do conteúdo
  final EdgeInsetsGeometry? padding;

  /// Altura do efeito de fade/névoa
  final double fadeHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: context.theme.scaffoldBackgroundColor,
            blurRadius: 6,
            spreadRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding:
              padding ??
              const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
          child: child,
        ),
      ),
    );
  }
}
