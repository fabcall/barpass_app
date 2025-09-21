import 'package:flutter/material.dart';

/// Cores básicas e helpers de opacidade
class AppColors {
  const AppColors._();

  // Cores básicas
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // Helpers de opacidade
  static Color hover(Color c) => c.withValues(alpha: AppOpacity.hover);
  static Color pressed(Color c) => c.withValues(alpha: AppOpacity.pressed);
  static Color disabled(Color c) => c.withValues(alpha: AppOpacity.disabled);
  static Color focus(Color c) => c.withValues(alpha: AppOpacity.focus);

  // Helpers de overlay
  static Color overlay(Color c, double opacity) => c.withValues(alpha: opacity);
}

/// Opacidades padronizadas
class AppOpacity {
  const AppOpacity._();

  // === ESTADOS DE INTERAÇÃO ===
  /// Opacidade para estado hover (4%)
  static const double hover = 0.04;

  /// Opacidade para estado focus (12%)
  static const double focus = 0.12;

  /// Opacidade para estado pressed (15%)
  static const double pressed = 0.15;

  /// Opacidade para elementos disabled (38%)
  static const double disabled = 0.38;

  // === OVERLAYS E SUPERFÍCIES ===
  /// Overlay muito sutil (5%)
  static const double subtle = 0.05;

  /// Overlay leve (8%)
  static const double light = 0.08;

  /// Overlay médio (12%)
  static const double medium = 0.12;

  /// Overlay forte (20%)
  static const double strong = 0.20;

  /// Overlay pesado (30%)
  static const double heavy = 0.30;

  // === DESTAQUES VISUAIS ===
  /// Efeito shimmer/skeleton (50%)
  static const double shimmer = 0.50;

  /// Overlay de modais (70%)
  static const double overlay = 0.70;

  /// Backdrop de dialogs (80%)
  static const double backdrop = 0.80;

  // === TRANSPARÊNCIAS ESPECÍFICAS ===
  /// Totalmente transparente (0%)
  static const double transparent = 0.0;

  /// Semi-transparente (50%)
  static const double semiTransparent = 0.5;

  /// Totalmente opaco (100%)
  static const double opaque = 1.0;
}
