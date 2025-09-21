import 'package:flutter/material.dart';

/// Classe de dados para agrupar as cores usadas na navegação.
class NavigationColors {
  const NavigationColors({
    required this.background,
    required this.selected,
    required this.unselected,
    required this.shadow,
  });

  /// A cor de fundo da barra de navegação.
  final Color background;

  /// A cor para ícones e textos selecionados.
  final Color selected;

  /// A cor para ícones e textos não selecionados.
  final Color unselected;

  /// A cor base para a sombra da barra de navegação.
  final Color shadow;
}

/// Helper para obter as cores de navegação de forma semântica a partir do tema.
class AppNavigationColors {
  const AppNavigationColors._();

  /// Retorna um objeto [NavigationColors] com base no [BuildContext] atual.
  ///
  /// As cores são extraídas do `ColorScheme` do tema, garantindo que a
  /// barra de navegação se adapte automaticamente aos temas claro e escuro.
  static NavigationColors get(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return NavigationColors(
      background: colorScheme.surfaceContainer,
      selected: colorScheme.primary,
      unselected: colorScheme.onSurfaceVariant,
      shadow: colorScheme.shadow,
    );
  }
}
