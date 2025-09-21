import 'package:flutter/material.dart';

/// Enum para os níveis de sombra, garantindo type-safety.
enum AppShadowLevel {
  subtle, // Nível 1
  soft, // Nível 2
  medium, // Nível 3
  strong, // Nível 4
  distant, // Nível 5
}

// Mapeamento dos parâmetros de sombra para cada nível do enum.
const Map<AppShadowLevel, ({double alpha, double blur, double offsetY})>
_kShadowParams = {
  AppShadowLevel.subtle: (alpha: 0.05, blur: 4, offsetY: 1),
  AppShadowLevel.soft: (alpha: 0.08, blur: 8, offsetY: 2),
  AppShadowLevel.medium: (alpha: 0.10, blur: 12, offsetY: 4),
  AppShadowLevel.strong: (alpha: 0.15, blur: 16, offsetY: 6),
  AppShadowLevel.distant: (alpha: 0.20, blur: 24, offsetY: 8),
};

/// Sistema de sombras do BarPass.
///
/// Define uma lista de `BoxShadow` para ser usada em `Container`, `DecoratedBox`, etc.
///
/// **Nota de uso:** Para consistência visual com os widgets do Material (Card, Dialog),
/// tente corresponder os níveis de sombra com os tokens de `AppElevation`:
/// - `AppShadows.soft` ~ `elevation: AppElevation.xs`
/// - `AppShadows.medium` ~ `elevation: AppElevation.sm`
/// - `AppShadows.strong` ~ `elevation: AppElevation.md`
class AppShadows {
  const AppShadows._();

  // === MÉTODOS HELPER PRIVADOS ===

  static List<BoxShadow> _createShadow({
    required double alpha,
    required double blurRadius,
    required double offsetY,
    Color color = Colors.black,
  }) {
    // Ótimo uso do `withValues`, que você me informou ter sido
    // adicionado no Flutter 3.10. É muito mais limpo.
    return [
      BoxShadow(
        color: color.withValues(alpha: alpha),
        blurRadius: blurRadius,
        offset: Offset(0, offsetY),
      ),
    ];
  }

  // === NÍVEIS DE SOMBRA PADRÃO ===

  /// Sombra Nível 1: Sutil, para cards em repouso.
  static List<BoxShadow> get subtle => _createShadow(
    alpha: _kShadowParams[AppShadowLevel.subtle]!.alpha,
    blurRadius: _kShadowParams[AppShadowLevel.subtle]!.blur,
    offsetY: _kShadowParams[AppShadowLevel.subtle]!.offsetY,
  );

  /// Sombra Nível 2: Leve, para cards em hover ou chips.
  static List<BoxShadow> get soft => _createShadow(
    alpha: _kShadowParams[AppShadowLevel.soft]!.alpha,
    blurRadius: _kShadowParams[AppShadowLevel.soft]!.blur,
    offsetY: _kShadowParams[AppShadowLevel.soft]!.offsetY,
  );

  /// Sombra Nível 3: Moderada, para carrosséis ou modais.
  static List<BoxShadow> get medium => _createShadow(
    alpha: _kShadowParams[AppShadowLevel.medium]!.alpha,
    blurRadius: _kShadowParams[AppShadowLevel.medium]!.blur,
    offsetY: _kShadowParams[AppShadowLevel.medium]!.offsetY,
  );

  /// Sombra Nível 4: Elevada, para FABs ou sheets.
  static List<BoxShadow> get strong => _createShadow(
    alpha: _kShadowParams[AppShadowLevel.strong]!.alpha,
    blurRadius: _kShadowParams[AppShadowLevel.strong]!.blur,
    offsetY: _kShadowParams[AppShadowLevel.strong]!.offsetY,
  );

  /// Sombra Nível 5: Topo, para dialogs.
  static List<BoxShadow> get distant => _createShadow(
    alpha: _kShadowParams[AppShadowLevel.distant]!.alpha,
    blurRadius: _kShadowParams[AppShadowLevel.distant]!.blur,
    offsetY: _kShadowParams[AppShadowLevel.distant]!.offsetY,
  );

  // === SOMBRAS ESPECIAIS (Invertidas ou customizadas) ===

  /// Sombra para bottom bar (invertida).
  static List<BoxShadow> get bottomBar =>
      _createShadow(alpha: 0.1, blurRadius: 12, offsetY: -3);

  /// Sombra para top bar (para headers persistentes).
  static List<BoxShadow> get topBar =>
      _createShadow(alpha: 0.1, blurRadius: 8, offsetY: 4);

  /// Sombra para draggable sheet (invertida)
  static List<BoxShadow> get sheet => _createShadow(
    alpha: 0.1,
    blurRadius: 10,
    offsetY: -5,
  );

  /// Sombra para badges (mais focada e intensa) - Padronizado para 0.3 alpha, 4 blur, 2 offset
  static List<BoxShadow> badgeShadow(Color color) => _createShadow(
    alpha: 0.3,
    blurRadius: 4,
    offsetY: 2,
    color: color,
  );

  // === MÉTODOS HELPER PÚBLICOS ===

  /// Retorna a sombra apropriada para o tema (claro/escuro).
  static List<BoxShadow> adaptive({
    required Brightness brightness,
    AppShadowLevel level = AppShadowLevel.soft,
  }) {
    final params = _kShadowParams[level]!;

    // No tema escuro, sombras são mais sutis (alpha reduzido).
    final multiplier = brightness == Brightness.dark ? 0.6 : 1.0;
    final finalAlpha = params.alpha * multiplier;

    return _createShadow(
      alpha: finalAlpha,
      blurRadius: params.blur,
      offsetY: params.offsetY,
    );
  }
}
