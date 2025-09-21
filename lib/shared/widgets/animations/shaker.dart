import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Controller para controlar a animação de shake externamente
class ShakeController extends ChangeNotifier {
  _ShakerState? _state;

  /// Anexa o controller ao state do ShakeContainer
  void _attach(_ShakerState state) {
    _state = state;
  }

  /// Remove a referência ao state
  void _detach() {
    _state = null;
  }

  /// Executa a animação de shake
  Future<void> shake() async {
    await _state?._shake();
    notifyListeners();
  }

  /// Verifica se o controller está anexado a um widget
  bool get isAttached => _state != null;

  /// Se a animação está sendo executada
  bool get isShaking => _state?._isShaking ?? false;

  @override
  void dispose() {
    _detach();
    super.dispose();
  }
}

/// Curva customizada para criar efeito de shake mais realista
class SineCurve extends Curve {
  const SineCurve({this.count = 3});

  final double count;

  @override
  double transformInternal(double t) {
    return math.sin(count * 2 * math.pi * t);
  }
}

/// Um container que pode ser "balançado" (shake) para indicar erro
class Shaker extends StatefulWidget {
  const Shaker({
    required this.child,
    super.key,
    this.controller,
    this.duration = const Duration(milliseconds: 600),
    this.shakeOffset = 10.0,
    this.shakeCount = 3,
    this.enableHapticFeedback = true,
    this.direction = ShakeDirection.horizontal,
    this.curve = Curves.elasticIn,
  });

  /// O widget filho que será envolvido pelo container
  final Widget child;

  /// Controller para controlar a animação de shake externamente
  final ShakeController? controller;

  /// Duração da animação de shake
  final Duration duration;

  /// Intensidade do shake (deslocamento máximo em pixels)
  final double shakeOffset;

  /// Número de oscilações durante o shake
  final int shakeCount;

  /// Se deve vibrar o dispositivo durante o shake
  final bool enableHapticFeedback;

  /// Direção do shake (horizontal, vertical ou ambas)
  final ShakeDirection direction;

  /// Curva da animação
  final Curve curve;

  @override
  State<Shaker> createState() => _ShakerState();
}

/// Direção do shake
enum ShakeDirection {
  horizontal,
  vertical,
  both,
}

class _ShakerState extends State<Shaker> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _shakeAnimation;
  ShakeController? _internalController;
  bool _isShaking = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    _setupController();
  }

  void _initializeAnimation() {
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // Usa curva customizada baseada no SineCurve para efeito mais realista
    final curve = widget.curve == Curves.elasticIn
        ? SineCurve(count: widget.shakeCount.toDouble())
        : widget.curve;

    _shakeAnimation =
        Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: curve,
          ),
        );

    // Listener para resetar o estado quando a animação terminar
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isShaking = false;
        });
        _animationController.reset();
      }
    });
  }

  void _setupController() {
    // Se não foi fornecido um controller externo, criar um interno
    widget.controller ??
        (_internalController = ShakeController())._attach(
          this,
        );
  }

  @override
  void didUpdateWidget(Shaker oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Se o controller mudou, reconfigurar
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?._detach();
      _setupController();
    }

    // Se a duração mudou, recriar o controller
    if (widget.duration != oldWidget.duration) {
      _animationController.dispose();
      _initializeAnimation();
    }
  }

  @override
  void dispose() {
    widget.controller?._detach();
    _internalController?._detach();
    _animationController.dispose();
    super.dispose();
  }

  /// Executa a animação de shake
  Future<void> _shake() async {
    if (_isShaking) return; // Evita múltiplas animações simultâneas

    setState(() {
      _isShaking = true;
    });

    if (widget.enableHapticFeedback) {
      unawaited(HapticFeedback.lightImpact());
    }

    await _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      child: widget.child, // Otimização: passa child para evitar rebuild
      builder: (context, child) {
        if (!_isShaking) {
          return child!;
        }

        // Calcula o offset baseado na direção
        Offset offset;
        final shakeValue = _shakeAnimation.value * widget.shakeOffset;

        switch (widget.direction) {
          case ShakeDirection.horizontal:
            offset = Offset(shakeValue, 0);
          case ShakeDirection.vertical:
            offset = Offset(0, shakeValue);
          case ShakeDirection.both:
            offset = Offset(shakeValue, shakeValue * 0.5);
        }

        return Transform.translate(
          offset: offset,
          child: child,
        );
      },
    );
  }
}
