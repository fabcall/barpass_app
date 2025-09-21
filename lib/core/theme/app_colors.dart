import 'package:flutter/material.dart';

/// Cores do BarPass - simples e direto
class AppColors {
  AppColors._();

  // === CORES BÁSICAS ===
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;

  // === NAVEGAÇÃO ===
  // Light theme
  static const Color bottomNavBackground = white;
  static const Color bottomNavSelected = black;
  static const Color bottomNavUnselected = Colors.grey;

  // Dark theme
  static const Color bottomNavBackgroundDark = Color(0xFF1E1E1E);
  static const Color bottomNavSelectedDark = white;
  static const Color bottomNavUnselectedDark = Colors.grey;

  // === FAB ===
  static const Color fabIconColor = white;

  // === SOMBRAS ===
  static Color get lightShadow => black.withOpacity(0.08);
  static Color get darkShadow => black.withOpacity(0.20);

  // === CORES DE INTERAÇÃO ===
  /// Retorna cor de splash para interações
  static Color getSplashColor(Color baseColor) {
    return baseColor.withOpacity(0.15);
  }

  /// Retorna cor de highlight para interações
  static Color getHighlightColor(Color baseColor) {
    return baseColor.withOpacity(0.08);
  }

  /// Retorna cor de hover para interações
  static Color getHoverColor(Color baseColor) {
    return baseColor.withOpacity(0.04);
  }

  /// Retorna cor de focus para interações
  static Color getFocusColor(Color baseColor) {
    return baseColor.withOpacity(0.12);
  }

  // === CORES DO TEMA ===
  /// Retorna cor de superfície baseada no tema
  static Color getSurfaceColor(BuildContext context) {
    return Theme.of(context).colorScheme.surface;
  }

  /// Retorna cor do texto sobre superfície baseada no tema
  static Color getOnSurfaceColor(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface;
  }

  /// Retorna cor de superfície variante
  static Color getSurfaceVariantColor(BuildContext context) {
    return Theme.of(context).colorScheme.surfaceContainerHighest;
  }

  /// Retorna cor do texto sobre superfície variante
  static Color getOnSurfaceVariantColor(BuildContext context) {
    return Theme.of(context).colorScheme.onSurfaceVariant;
  }

  // === MÉTODO HELPER ===
  /// Retorna cores da navegação baseada no tema
  static NavigationColors getNavigationColors(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return NavigationColors(
      background: isDark ? bottomNavBackgroundDark : bottomNavBackground,
      selected: isDark ? bottomNavSelectedDark : bottomNavSelected,
      unselected: isDark ? bottomNavUnselectedDark : bottomNavUnselected,
      shadow: isDark ? darkShadow : lightShadow,
    );
  }
}

/// Classe para cores da navegação
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
