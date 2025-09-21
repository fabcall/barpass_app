import 'dart:math' as math;
import 'package:barpass_app/core/utils/math_utils.dart';
import 'package:flutter/material.dart';

/// Forma personalizada que cria um entalhe circular na barra inferior
///
/// Esta implementação cria um entalhe perfeito para acomodar um
/// FloatingActionButton com padding extra configurável.
@immutable
class CircularNotchedShape extends NotchedShape {
  /// Cria uma forma com entalhe circular
  const CircularNotchedShape();

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    // Se não há guest ou não há sobreposição, retorna um retângulo simples
    if (guest == null || !host.overlaps(guest)) {
      return Path()..addRect(host);
    }

    return _createNotchedPath(host, guest);
  }

  /// Cria o caminho com entalhe baseado nas dimensões do host e guest
  Path _createNotchedPath(Rect host, Rect guest) {
    // Calcula o raio do entalhe baseado no guest + padding extra
    final notchRadius = guest.width / 2.0;
    final hostTop = host.top;
    final guestTop = guest.top;

    // Calcula os ângulos para o arco do entalhe
    final heightDifference = hostTop - guestTop;
    final normalizedHeight = heightDifference / notchRadius;

    // Garante que o valor esteja no range válido para asin/acos
    final clampedValue = normalizedHeight.clamp(-1.0, 1.0);

    final angleOffset = math.asin(1 - clampedValue);
    final angleSpan = math.acos(1 - clampedValue) * 2;

    return Path()
      // Inicia no canto superior esquerdo
      ..moveTo(host.left, hostTop)
      // Linha até o início do entalhe
      ..lineTo(guest.left, hostTop)
      // Cria o arco do entalhe
      ..arcTo(
        _createNotchRect(guest, notchRadius, guestTop),
        angleOffset + MathUtils.degToRad(180),
        angleSpan,
        false,
      )
      // Continua após o entalhe
      ..lineTo(guest.right, hostTop)
      ..lineTo(host.right, hostTop)
      // Completa o retângulo
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();
  }

  /// Cria o retângulo que define os limites do arco do entalhe
  Rect _createNotchRect(Rect guest, double notchRadius, double guestTop) {
    return Rect.fromLTWH(
      guest.left,
      guestTop,
      notchRadius * 2,
      notchRadius * 2,
    );
  }
}
