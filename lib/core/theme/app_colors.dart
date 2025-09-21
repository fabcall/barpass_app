import 'package:flutter/material.dart';

/// Cores centralizadas da aplicação com suporte a temas
class AppColors {
  AppColors._();

  // === CORES BÁSICAS ===
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;

  // === NAVEGAÇÃO - LIGHT THEME ===
  static const Color bottomNavBackground = white;
  static const Color bottomNavUnselected = Colors.grey;
  static const Color bottomNavSelected = black;

  // === NAVEGAÇÃO - DARK THEME ===
  static const Color bottomNavBackgroundDark = Color(0xFF1E1E1E);
  static const Color bottomNavUnselectedDark = Colors.grey;
  static const Color bottomNavSelectedDark = white;

  // === FAB ===
  static const Color fabIconColor = white;

  // === SOMBRAS ===
  static Color get lightShadow => black.withValues(alpha: 0.08);
  static Color get darkShadow => black.withValues(alpha: 0.20);

  // === EFEITOS DE INTERAÇÃO ===
  static Color getSplashColor(Color baseColor) =>
      baseColor.withValues(alpha: 0.15);
  static Color getHighlightColor(Color baseColor) =>
      baseColor.withValues(alpha: 0.08);

  // === MÉTODOS HELPER PARA TEMAS ===

  /// Retorna as cores da navegação baseada no tema atual
  static NavigationColors getNavigationColors(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return NavigationColors(
      background: isDark ? bottomNavBackgroundDark : bottomNavBackground,
      selected: isDark ? bottomNavSelectedDark : bottomNavSelected,
      unselected: isDark ? bottomNavUnselectedDark : bottomNavUnselected,
      shadow: isDark ? darkShadow : lightShadow,
    );
  }

  /// Retorna a cor da superfície baseada no contexto do tema
  static Color getSurfaceColor(BuildContext context) {
    return ColorScheme.of(context).surfaceContainer;
  }

  /// Retorna a cor do texto baseada no contexto do tema
  static Color getOnSurfaceColor(BuildContext context) {
    return ColorScheme.of(context).onSurface;
  }
}

/// Classe para agrupar cores relacionadas à navegação
class NavigationColors {
  const NavigationColors({
    required this.background,
    required this.selected,
    required this.unselected,
    required this.shadow,
  });

  final Color background;
  final Color selected;
  final Color unselected;
  final Color shadow;
}
