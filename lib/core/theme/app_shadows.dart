import 'package:flutter/material.dart';

// 1. Centralização dos parâmetros para maior consistência e manutenção
// Esta progressão é agora a fonte única de verdade para a elevação.
const Map<int, ({double alpha, double blur, double offsetY})>
_kElevationParams = {
  // alpha: (alpha, blur, offsetY) -> (opacidade da cor, raio do desfoque, deslocamento Y)
  1: (alpha: 0.05, blur: 4, offsetY: 1), // Sutil (cards em repouso)
  2: (alpha: 0.08, blur: 8, offsetY: 2), // Leve (cards hover, chips)
  3: (alpha: 0.10, blur: 12, offsetY: 4), // Moderado (carrosséis, modais)
  4: (alpha: 0.15, blur: 16, offsetY: 6), // Elevado (FAB, sheets)
  5: (alpha: 0.20, blur: 24, offsetY: 8), // Topo (dialogs)
};

/// Sistema de sombras do BarPass
///
/// Define sombras consistentes para manter hierarquia visual clara e fácil de manter.
class AppShadows {
  AppShadows._();

  // === MÉTODOS HELPER PRIVADOS ===

  /// Cria uma lista de BoxShadow usando withOpacity para maior legibilidade
  static List<BoxShadow> _createShadow({
    required double alpha,
    required double blurRadius,
    required double offsetY,
    Color color = Colors.black,
  }) {
    // Usamos withValues(alpha: x) por ser mais idiomático e claro
    return [
      BoxShadow(
        color: color.withValues(alpha: alpha),
        blurRadius: blurRadius,
        offset: Offset(0, offsetY),
      ),
    ];
  }

  // === NÍVEIS DE ELEVAÇÃO PADRÃO ===

  /// Sombra nível 1 - Para elementos sutis (cards em repouso)
  static List<BoxShadow> get level1 => _createShadow(
    alpha: _kElevationParams[1]!.alpha,
    blurRadius: _kElevationParams[1]!.blur,
    offsetY: _kElevationParams[1]!.offsetY,
  );

  /// Sombra nível 2 - Para elementos levemente elevados (cards hover, chips)
  static List<BoxShadow> get level2 => _createShadow(
    alpha: _kElevationParams[2]!.alpha,
    blurRadius: _kElevationParams[2]!.blur,
    offsetY: _kElevationParams[2]!.offsetY,
  );

  /// Sombra nível 3 - Para elementos moderadamente elevados (carrosséis, modais)
  static List<BoxShadow> get level3 => _createShadow(
    alpha: _kElevationParams[3]!.alpha,
    blurRadius: _kElevationParams[3]!.blur,
    offsetY: _kElevationParams[3]!.offsetY,
  );

  /// Sombra nível 4 - Para elementos altamente elevados (FAB, sheets)
  static List<BoxShadow> get level4 => _createShadow(
    alpha: _kElevationParams[4]!.alpha,
    blurRadius: _kElevationParams[4]!.blur,
    offsetY: _kElevationParams[4]!.offsetY,
  );

  /// Sombra nível 5 - Para elementos no topo da hierarquia (dialogs)
  static List<BoxShadow> get level5 => _createShadow(
    alpha: _kElevationParams[5]!.alpha,
    blurRadius: _kElevationParams[5]!.blur,
    offsetY: _kElevationParams[5]!.offsetY,
  );

  // === SOMBRAS ESPECIAIS (Invertidas ou customizadas) ===

  /// Sombra para bottom bar (invertida, vai para cima)
  static List<BoxShadow> get bottomBar => _createShadow(
    alpha: 0.1,
    blurRadius: 12,
    offsetY: -3,
  );

  /// Sombra para top bar (vai para baixo - Nível para headers persistentes)
  static List<BoxShadow> get topBar => _createShadow(
    alpha: 0.1,
    blurRadius: 8,
    offsetY: 4,
  );

  /// Sombra para badges (mais focada e intensa) - Padronizado para 0.3 alpha, 4 blur, 2 offset
  static List<BoxShadow> badgeShadow(Color color) => _createShadow(
    alpha: 0.3,
    blurRadius: 4,
    offsetY: 2,
    color: color,
  );

  /// Sombra para draggable sheet (invertida)
  static List<BoxShadow> get sheet => _createShadow(
    alpha: 0.1,
    blurRadius: 10,
    offsetY: -5,
  );

  /// Sombra para imagens com borda circular (level 4 adaptado)
  static List<BoxShadow> get circular => _createShadow(
    alpha: 0.15,
    blurRadius: 12,
    offsetY: 6,
  );

  /// Sombra para elementos com gradiente/overlay
  static List<BoxShadow> get gradient => _createShadow(
    alpha: 0.3,
    blurRadius: 8,
    offsetY: 4,
  );

  // === MÉTODOS HELPER PÚBLICOS ===

  /// Cria sombra customizada com controle total
  static List<BoxShadow> custom({
    required double alpha,
    required double blurRadius,
    required Offset offset,
    Color color = Colors.black,
  }) {
    return [
      BoxShadow(
        color: color.withValues(alpha: alpha),
        blurRadius: blurRadius,
        offset: offset,
      ),
    ];
  }

  /// Retorna sombra apropriada para o tema (light/dark)
  static List<BoxShadow> adaptive({
    required Brightness brightness,
    required int level,
  }) {
    final params = _kElevationParams[level];

    if (params == null) {
      return level2; // Default seguro
    }

    // No tema escuro, sombras são mais sutis: alpha reduzido
    final multiplier = brightness == Brightness.dark ? 0.6 : 1.0;
    final finalAlpha = params.alpha * multiplier;

    return _createShadow(
      alpha: finalAlpha,
      blurRadius: params.blur,
      offsetY: params.offsetY,
    );
  }
}
