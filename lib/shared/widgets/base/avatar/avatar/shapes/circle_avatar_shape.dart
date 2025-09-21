import 'dart:math' as math;

import 'package:barpass_app/shared/widgets/base/avatar/avatar/avatar.dart';
import 'package:flutter/material.dart';

/// Uma implementação de [AvatarShape] que renderiza o avatar em formato circular.
///
/// Suporta bordas com cor sólida ou gradiente.
class CircleAvatarShape extends AvatarShape {
  /// Construtor constante para [CircleAvatarShape].
  ///
  /// [borderColor] e [borderGradient] são opcionais, mas não podem ser fornecidos
  /// simultaneamente. [borderWidth] padrão é `2`.
  const CircleAvatarShape({
    super.borderColor,
    super.borderGradient,
    super.borderWidth = 2,
  }) : assert(
         borderColor == null || borderGradient == null,
         'Cannot provide both borderColor and borderGradient.',
       );

  @override
  CustomClipper<Path> getClipper() => _CircleClipper(borderWidth: borderWidth);

  @override
  CustomPainter? getBorderPainter(Rect bounds) {
    // Retorna null se não houver largura de borda ou se nenhuma cor/gradiente for definida.
    // A assertiva em [Avatar] já lida com isso, mas a verificação é mantida para clareza.
    if (borderWidth <= 0 || (borderColor == null && borderGradient == null)) {
      return null;
    }
    return _CircleBorderPainter(
      borderColor: borderColor,
      borderGradient: borderGradient,
      borderWidth: borderWidth,
      bounds: bounds, // Passa os limites para o pintor.
    );
  }
}

/// Um [CustomClipper<Path>] interno para a forma circular do avatar.
///
/// Recorta o conteúdo para um círculo, levando em consideração a largura da borda
/// para que o conteúdo não se sobreponha à borda.
class _CircleClipper extends CustomClipper<Path> {
  /// Construtor constante para [_CircleClipper].
  const _CircleClipper({required this.borderWidth});

  /// A largura da borda que deve ser subtraída da área de recorte.
  final double borderWidth;

  @override
  Path getClip(Size size) {
    // Calcula o diâmetro efetivo do círculo de recorte, subtraindo a largura da borda.
    // Garante que o diâmetro não seja negativo.
    final double effectiveDiameter = math.max(0, size.width - borderWidth);
    final rect = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: effectiveDiameter,
      height: effectiveDiameter,
    );
    // Adiciona uma forma oval (círculo) ao caminho.
    return Path()..addOval(rect);
  }

  @override
  bool shouldReclip(_CircleClipper oldClipper) =>
      oldClipper.borderWidth != borderWidth;
}

/// Um [CustomPainter] interno para desenhar a borda circular de um avatar.
///
/// Suporta bordas com cor sólida ou gradiente.
class _CircleBorderPainter extends CustomPainter {
  /// Construtor para [_CircleBorderPainter].
  _CircleBorderPainter({
    required this.borderWidth,
    required this.bounds,
    this.borderColor,
    this.borderGradient,
  });

  /// A cor sólida da borda.
  final Color? borderColor;

  /// O gradiente da borda.
  final Gradient? borderGradient;

  /// A largura da borda.
  final double borderWidth;

  /// Os limites ([Rect]) do widget [Avatar] pai, usados para definir
  /// a área de aplicação do gradiente.
  final Rect bounds;

  @override
  void paint(Canvas canvas, Size size) {
    // Calcula o raio do círculo da borda, considerando a largura da borda.
    final double radius = math.max(0, (size.width - borderWidth) / 2);
    final center = size.center(Offset.zero);

    final paint = Paint()
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke; // Estilo de traço para a borda.

    // Aplica o gradiente se fornecido, caso contrário, a cor sólida.
    if (borderGradient != null) {
      // Cria o shader do gradiente relativo aos limites do avatar.
      paint.shader = borderGradient!.createShader(bounds);
    } else if (borderColor != null) {
      paint.color = borderColor!;
    } else {
      return; // Não deve acontecer devido às verificações.
    }

    // Desenha o círculo da borda apenas se o raio for positivo.
    if (radius > 0) {
      canvas.drawCircle(center, radius, paint);
    } else if (radius == 0 && borderWidth > 0) {
      // Caso especial: se a largura da borda é igual ou maior que o tamanho,
      // desenha um círculo preenchido para cobrir a área.
      paint.style = PaintingStyle.fill;
      canvas.drawCircle(center, size.width / 2, paint);
    }
  }

  @override
  bool shouldRepaint(_CircleBorderPainter oldDelegate) =>
      oldDelegate.borderColor != borderColor ||
      oldDelegate.borderGradient != borderGradient ||
      oldDelegate.borderWidth != borderWidth ||
      oldDelegate.bounds != bounds; // Repinta se os limites mudarem.
}
