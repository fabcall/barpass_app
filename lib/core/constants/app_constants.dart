import 'package:flutter/material.dart';

/// Constantes centralizadas da aplicação
class AppConstants {
  // Privado para evitar instanciação
  AppConstants._();

  // === NAVEGAÇÃO ===
  /// Altura padrão da barra de navegação inferior
  static const double bottomNavBarHeight = 64.0;

  /// Altura responsiva da barra de navegação baseada no tamanho da tela
  static double responsiveBottomNavBarHeight(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return screenHeight < 600 ? 56.0 : bottomNavBarHeight;
  }

  /// Tamanho dos ícones na barra de navegação
  static const double bottomNavBarIconSize = 20.0;

  /// Espaçamento entre ícone e texto na navegação
  static const double bottomNavBarIconGap = 8.0;

  // === FLOATING ACTION BUTTON ===
  /// Tamanho padrão do FAB
  static const double fabSize = 56.0;

  /// Offset do FAB em relação à posição docked
  static const double fabOffset = 24.0;

  /// Padding extra para o notch
  static const double notchPadding = 6.0;

  /// Raio calculado do notch baseado no FAB
  static double get notchRadius => (fabSize / 2) + (notchPadding * 2);

  // === SPACING GERAL ===
  /// Espaçamento pequeno (8dp)
  static const double small = 8.0;

  /// Espaçamento médio (16dp)
  static const double medium = 16.0;

  /// Espaçamento grande (24dp)
  static const double large = 24.0;

  /// Espaçamento extra grande (32dp)
  static const double extraLarge = 32.0;

  // === SOMBRAS ===
  /// Blur da sombra do bottom app bar
  static const double bottomBarShadowBlur = 12.0;

  /// Offset vertical da sombra
  static const double bottomBarShadowOffset = -3.0;

  // === ANIMAÇÕES ===
  /// Duração padrão para transições
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);

  /// Duração rápida para micro-interações
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);

  // === ACESSIBILIDADE ===
  /// Tamanho mínimo para alvos touch
  static const double minimumTouchTarget = 48.0;

  /// Raio para splash effects
  static const double splashRadius = 48.0;

  // === BORDAS ===
  /// Raio padrão para bordas arredondadas
  static const double defaultBorderRadius = 8.0;
}
