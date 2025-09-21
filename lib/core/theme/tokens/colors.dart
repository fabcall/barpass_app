import 'package:flutter/material.dart';

/// Cores básicas e helpers de opacidade
class AppColors {
  const AppColors._();

  // Cores básicas
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // Helpers de opacidade
  static Color hover(Color c) => c.withValues(alpha: 0.04);
  static Color pressed(Color c) => c.withValues(alpha: 0.15);
}

/// Opacidades padronizadas
class AppOpacity {
  static const double hover = 0.04;
  static const double focus = 0.12;
  static const double pressed = 0.15;
  static const double disabled = 0.38;
}
