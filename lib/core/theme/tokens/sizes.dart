import 'dart:ui';

/// Tokens para tamanhos de componentes, elevações e outros valores dimensionais.
class AppSizes {
  const AppSizes._();

  // === LARGURA DAS BORDAS ===
  static const double borderWidth = 1;
  static const double focusedBorderWidth = 2;

  // === DIMENSÕES DE COMPONENTES ===

  // === NAVEGAÇÃO ===
  static const double bottomAppBarHeight = 80;
  static const double bottomAppBarIconSize = 20;
  static const double bottomAppBarIconGap = 8;
  static const double bottomAppBarShadowBlur = 4;
  static const Offset bottomAppBarShadowOffset = Offset(0, -4);

  // === FAB ===
  static const double fabSize = 56;
  static const double fabOffset = 24;
  static const double notchPadding = 6;

  static double get notchRadius => (fabSize / 2) + notchPadding;

  static const double navigationBarHeight = 72;
  static const double sliderTrackHeight = 8;
  static const double tabBarIndicatorWeight = 4;

  // === FONTES E ÍCONES (específicos de componentes) ===
  static const double chipFontSize = 12;
  static const double chipIconSize = 16;
}
