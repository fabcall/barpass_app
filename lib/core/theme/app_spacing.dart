import 'package:flutter/material.dart';

/// Espaçamentos do BarPass - sistema simples baseado em 4px
class AppSpacing {
  AppSpacing._();

  // === ESPAÇAMENTOS BASE ===
  static const double xs = 4.0; // 4px
  static const double sm = 8.0; // 8px
  static const double md = 16.0; // 16px
  static const double lg = 24.0; // 24px
  static const double xl = 32.0; // 32px
  static const double xxl = 48.0; // 48px

  // === NAVEGAÇÃO ===
  static const double bottomNavHeight = 64.0;
  static const double bottomNavIconSize = 20.0;
  static const double bottomNavIconGap = 8.0;

  /// Altura responsiva da bottom nav
  static double responsiveBottomNavHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight < 600 ? 56.0 : bottomNavHeight;
  }

  // === FAB ===
  static const double fabSize = 56.0;
  static const double fabOffset = 24.0;
  static const double notchPadding = 6.0;

  /// Raio do notch calculado
  static double get notchRadius => (fabSize / 2) + (notchPadding * 2);

  // === SOMBRAS ===
  static const double bottomBarShadowBlur = 12.0;
  static const double bottomBarShadowOffset = -3.0;

  // === BORDAS ===
  static const double borderRadius = 8.0;
  static const double borderRadiusLarge = 12.0;

  // === ACESSIBILIDADE ===
  static const double minimumTouchTarget = 48.0;
  static const double splashRadius = 48.0;
}
