import 'package:flutter/material.dart';

/// Widget que adiciona efeito de bounce a qualquer child.
///
/// Responde aos eventos de pressionar (onTapDown) e soltar (onTapUp/onTapCancel)
/// reduzindo temporariamente a escala do widget child.
///
/// Útil para adicionar feedback visual em botões e outros elementos interativos.
class Bouncer extends StatefulWidget {
  /// Cria um wrapper com efeito de bounce.
  const Bouncer({
    required this.child,
    super.key,
    this.enabled = true,
    this.scale = 0.95,
    this.duration = const Duration(milliseconds: 100),
    this.curve = Curves.easeInOut,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
  });

  /// Widget a ser animado com o efeito bounce.
  final Widget child;

  /// Define se o efeito bounce está habilitado.
  final bool enabled;

  /// Escala mínima durante o bounce (padrão: 0.95).
  final double scale;

  /// Duração da animação de bounce.
  final Duration duration;

  /// Curva de animação aplicada ao bounce.
  final Curve curve;

  /// Callback executado quando o widget é tocado.
  final VoidCallback? onTap;

  /// Callback executado quando o toque inicia.
  final ValueChanged<TapDownDetails>? onTapDown;

  /// Callback executado quando o toque termina.
  final ValueChanged<TapUpDetails>? onTapUp;

  /// Callback executado quando o toque é cancelado.
  final VoidCallback? onTapCancel;

  @override
  State<Bouncer> createState() => _BouncerState();
}

class _BouncerState extends State<Bouncer> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation =
        Tween<double>(
          begin: 1,
          end: widget.scale,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: widget.curve,
          ),
        );
  }

  @override
  void didUpdateWidget(Bouncer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }
    if (oldWidget.scale != widget.scale || oldWidget.curve != widget.curve) {
      _animation =
          Tween<double>(
            begin: 1,
            end: widget.scale,
          ).animate(
            CurvedAnimation(
              parent: _controller,
              curve: widget.curve,
            ),
          );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.enabled) {
      _controller.forward();
    }
    widget.onTapDown?.call(details);
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.enabled) {
      _controller.reverse();
    }
    widget.onTapUp?.call(details);
  }

  void _handleTapCancel() {
    if (widget.enabled) {
      _controller.reverse();
    }
    widget.onTapCancel?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
