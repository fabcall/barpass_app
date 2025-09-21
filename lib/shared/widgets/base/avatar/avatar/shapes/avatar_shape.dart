import 'package:flutter/widgets.dart';

/// Classe abstrata que define a forma e as propriedades da borda de um avatar.
///
/// Subclasses devem implementar [getClipper] para definir a área de recorte
/// do conteúdo e [getBorderPainter] para desenhar a borda.
abstract class AvatarShape {
  /// Construtor constante para [AvatarShape].
  ///
  /// Requer [borderWidth]. [borderColor] e [borderGradient] são opcionais,
  /// mas não podem ser fornecidos simultaneamente.
  const AvatarShape({
    required this.borderWidth,
    this.borderColor,
    this.borderGradient,
  });

  /// A cor sólida da borda.
  ///
  /// Deve ser nula se [borderGradient] for fornecido.
  final Color? borderColor;

  /// O gradiente da borda.
  ///
  /// Deve ser nulo se [borderColor] for fornecido.
  final Gradient? borderGradient;

  /// A largura da borda em pixels.
  ///
  /// Se `0` ou negativo, nenhuma borda será desenhada.
  final double borderWidth;

  /// Retorna um [CustomClipper<Path>] que define a forma de recorte
  /// para o conteúdo do avatar.
  CustomClipper<Path> getClipper();

  /// Retorna um [CustomPainter] que desenha a borda do avatar.
  ///
  /// [bounds] representa o [Rect] total do avatar, usado para definir
  /// a área de aplicação de gradientes, se houver.
  ///
  /// Retorna `null` se não houver borda a ser desenhada (por exemplo,
  /// se [borderWidth] for 0 ou se nem [borderColor] nem [borderGradient] forem definidos).
  CustomPainter? getBorderPainter(Rect bounds);
}
