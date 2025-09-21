import 'package:flutter/material.dart';

/// Extensões para ColorScheme - cores semânticas
extension SemanticColors on ColorScheme {
  /// Cor de sucesso (verde)
  Color get success {
    return brightness == Brightness.light
        ? const Color(0xFF10B981)
        : const Color(0xFF34D399);
  }

  /// Cor de aviso/alerta (amarelo/laranja)
  Color get warning {
    return brightness == Brightness.light
        ? const Color(0xFFF59E0B)
        : const Color(0xFFFBBF24);
  }

  /// Cor de informação (azul)
  Color get info {
    return brightness == Brightness.light
        ? const Color(0xFF3B82F6)
        : const Color(0xFF60A5FA);
  }

  /// Cor para texto sobre success
  Color get onSuccess {
    return brightness == Brightness.light ? Colors.white : Colors.black;
  }

  /// Cor para texto sobre warning
  Color get onWarning {
    return brightness == Brightness.light ? Colors.white : Colors.black;
  }

  /// Cor para texto sobre info
  Color get onInfo {
    return brightness == Brightness.light ? Colors.white : Colors.black;
  }

  /// Cor base do shimmer (o fundo "apagado")
  Color get shimmerBase {
    return brightness == Brightness.light
        ? Colors.grey.shade300
        : Colors.grey.shade800;
  }

  /// Cor de destaque do shimmer (a "onda" brilhante)
  Color get shimmerHighlight {
    return brightness == Brightness.light
        ? Colors.grey.shade200
        : Colors.grey.shade700;
  }
}

/// Extensões para BuildContext - acesso rápido ao tema
extension ThemeContext on BuildContext {
  /// ColorScheme do tema atual
  ColorScheme get colorScheme => ColorScheme.of(this);

  /// ThemeData completo
  ThemeData get theme => Theme.of(this);

  /// TextTheme do tema atual
  TextTheme get textTheme => TextTheme.of(this);

  /// Brightness do tema atual
  Brightness get brightness => Theme.of(this).brightness;

  /// Verifica se está em dark mode
  bool get isDark => brightness == Brightness.dark;

  /// Verifica se está em light mode
  bool get isLight => brightness == Brightness.light;

  /// MediaQuery
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Tamanho da tela
  Size get screenSize => mediaQuery.size;

  /// Largura da tela
  double get screenWidth => screenSize.width;

  /// Altura da tela
  double get screenHeight => screenSize.height;

  /// Padding da tela (safe area)
  EdgeInsets get screenPadding => mediaQuery.padding;

  /// ViewPadding (inclui notch, etc)
  EdgeInsets get viewPadding => mediaQuery.viewPadding;

  /// ViewInsets (teclado, etc)
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
}

/// Extensões para Color - manipulação de cores
extension ColorManipulation on Color {
  /// Retorna cor com opacidade específica (0.0 a 1.0)
  Color withOpacity(double opacity) {
    return withValues(alpha: opacity);
  }

  /// Retorna versão mais clara da cor
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final lightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }

  /// Retorna versão mais escura da cor
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final lightness = (hsl.lightness - amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }

  /// Retorna cor com saturação ajustada
  Color saturate([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final saturation = (hsl.saturation + amount).clamp(0.0, 1.0);
    return hsl.withSaturation(saturation).toColor();
  }

  /// Retorna cor dessaturada
  Color desaturate([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final saturation = (hsl.saturation - amount).clamp(0.0, 1.0);
    return hsl.withSaturation(saturation).toColor();
  }
}
