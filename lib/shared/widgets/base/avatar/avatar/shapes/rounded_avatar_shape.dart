import 'dart:math' as math;

import 'package:barpass_app/shared/widgets/base/avatar/avatar/avatar.dart';
import 'package:flutter/material.dart';

/// Uma implementação de [AvatarShape] que renderiza o avatar em formato de
/// retângulo arredondado.
///
/// Suporta bordas com cor sólida ou gradiente.
class RoundedAvatarShape extends AvatarShape {
  /// Construtor constante para [RoundedAvatarShape].
  ///
  /// [borderRadius] padrão é `16`. [borderColor] e [borderGradient] são opcionais,
  /// mas não podem ser fornecidos simultaneamente. [borderWidth] padrão é `4`.
  const RoundedAvatarShape({
    this.borderRadius = 16,
    super.borderColor,
    super.borderGradient,
    super.borderWidth = 4,
  }) : assert(
         borderColor == null || borderGradient == null,
         'Cannot provide both borderColor and borderGradient.',
       );

  /// O raio dos cantos do retângulo arredondado.
  ///
  /// O padrão é `16`.
  final double borderRadius;

  @override
  CustomClipper<Path> getClipper() => _RoundedClipper(
    borderRadius: borderRadius,
    borderWidth: borderWidth,
  );

  @override
  CustomPainter? getBorderPainter(Rect bounds) {
    // Retorna null se não houver largura de borda ou cor/gradiente.
    // A assertiva em [Avatar] já lida com isso.
    if (borderWidth <= 0 || (borderColor == null && borderGradient == null)) {
      return null;
    }
    return _RoundedBorderPainter(
      borderColor: borderColor,
      borderGradient: borderGradient,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      bounds: bounds, // Passa os limites para o pintor.
    );
  }
}

/// Um [CustomClipper<Path>] interno para a forma de retângulo arredondado do avatar.
///
/// Recorta o conteúdo para um retângulo arredondado, ajustando o raio e o tamanho
/// para acomodar a largura da borda.
class _RoundedClipper extends CustomClipper<Path> {
  /// Construtor constante para [_RoundedClipper].
  const _RoundedClipper({
    required this.borderRadius,
    required this.borderWidth,
  });

  /// O raio dos cantos do retângulo.
  final double borderRadius;

  /// A largura da borda que deve ser subtraída da área de recorte.
  final double borderWidth;

  @override
  Path getClip(Size size) {
    // Ajusta o retângulo para dentro pela metade da largura da borda em cada lado.
    // Garante que as dimensões não sejam negativas.
    final double effectiveWidth = math.max(0, size.width - borderWidth);
    final double effectiveHeight = math.max(0, size.height - borderWidth);
    final adjustedRect = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: effectiveWidth,
      height: effectiveHeight,
    );
    // Ajusta o raio da borda, garantindo que não seja negativo.
    final adjustedRadius = Radius.circular(
      math.max(0, borderRadius - borderWidth / 2),
    );
    // Adiciona um retângulo arredondado ao caminho.
    return Path()
      ..addRRect(RRect.fromRectAndRadius(adjustedRect, adjustedRadius));
  }

  @override
  bool shouldReclip(_RoundedClipper oldClipper) =>
      oldClipper.borderRadius != borderRadius ||
      oldClipper.borderWidth != borderWidth;
}

/// Um [CustomPainter] interno para desenhar a borda de retângulo arredondado de um avatar.
///
/// Suporta bordas com cor sólida ou gradiente.
class _RoundedBorderPainter extends CustomPainter {
  /// Construtor constante para [_RoundedBorderPainter].
  const _RoundedBorderPainter({
    required this.borderRadius,
    required this.borderWidth,
    required this.bounds,
    this.borderColor,
    this.borderGradient,
  });

  /// A cor sólida da borda.
  final Color? borderColor;

  /// O gradiente da borda.
  final Gradient? borderGradient;

  /// O raio dos cantos da borda.
  final double borderRadius;

  /// A largura da borda.
  final double borderWidth;

  /// Os limites ([Rect]) do widget [Avatar] pai, usados para definir
  /// a área de aplicação do gradiente.
  final Rect bounds;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke; // Estilo de traço para a borda.

    // Aplica o gradiente se fornecido, caso contrário, a cor sólida.
    if (borderGradient != null) {
      paint.shader = borderGradient!.createShader(
        bounds,
      ); // Usa os limites para o shader.
    } else if (borderColor != null) {
      paint.color = borderColor!;
    } else {
      return; // Não deve acontecer.
    }

    // Define o retângulo arredondado para o caminho da borda.
    // Garante que as dimensões não sejam negativas.
    final double effectiveWidth = math.max(0, size.width - borderWidth);
    final double effectiveHeight = math.max(0, size.height - borderWidth);
    final rect = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: effectiveWidth,
      height: effectiveHeight,
    );
    // Ajusta o raio da borda, garantindo que não seja negativo.
    final radius = Radius.circular(
      math.max(0, borderRadius - borderWidth / 2),
    );
    final rRect = RRect.fromRectAndRadius(rect, radius);

    // Desenha o RRect da borda apenas se as dimensões efetivas forem positivas.
    if (effectiveWidth > 0 && effectiveHeight > 0) {
      canvas.drawRRect(rRect, paint);
    } else if (borderWidth > 0) {
      // Caso especial: se a largura da borda é muito grande,
      // desenha um RRect preenchido cobrindo a área.
      paint.style = PaintingStyle.fill;
      canvas.drawRRect(
        RRect.fromRectAndRadius(bounds, Radius.circular(borderRadius)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_RoundedBorderPainter oldDelegate) =>
      oldDelegate.borderColor != borderColor ||
      oldDelegate.borderGradient != borderGradient ||
      oldDelegate.borderRadius != borderRadius ||
      oldDelegate.borderWidth != borderWidth ||
      oldDelegate.bounds != bounds; // Repinta se os limites mudarem.
}
