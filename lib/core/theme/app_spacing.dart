import 'package:flutter/material.dart';

/// Espaçamentos do BarPass - sistema simples baseado em 4px
class AppSpacing {
  AppSpacing._();

  // === ESPAÇAMENTOS BASE ===
  static const double xs = 4; // 4px
  static const double sm = 8; // 8px
  static const double md = 16; // 16px
  static const double lg = 24; // 24px
  static const double xl = 32; // 32px
  static const double xxl = 48; // 48px

  // === NAVEGAÇÃO ===
  static const double bottomNavHeight = 64;
  static const double bottomNavIconSize = 20;
  static const double bottomNavIconGap = 8;

  /// Altura responsiva da bottom nav
  static double responsiveBottomNavHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight < 600 ? 56.0 : bottomNavHeight;
  }

  // === FAB ===
  static const double fabSize = 56;
  static const double fabOffset = 24;
  static const double notchPadding = 6;

  /// Raio do notch calculado
  static double get notchRadius => (fabSize / 2) + notchPadding;

  // === SOMBRAS ===
  static const double bottomBarShadowBlur = 12;
  static const Offset bottomBarShadowOffset = Offset(0, -4);

  // === BORDAS ===
  static const double borderRadius = 8;
  static const double borderRadiusLarge = 12;

  // === ACESSIBILIDADE ===
  static const double minimumTouchTarget = 48;
  static const double splashRadius = 48;
}
