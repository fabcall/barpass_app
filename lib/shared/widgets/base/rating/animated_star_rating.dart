import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Widget de classificação por estrelas com animações elegantes
/// Versão corrigida com melhor handling de contexto e animações
class AnimatedStarRating extends StatefulWidget {
  const AnimatedStarRating({
    required this.rating,
    this.starCount = 5,
    this.starSize = 24.0,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.staggerDelay = const Duration(milliseconds: 100),
    this.filledColor,
    this.unfilledColor,
    this.onAnimationComplete,
    super.key,
  });

  final double rating;
  final int starCount;
  final double starSize;
  final Duration animationDuration;
  final Duration staggerDelay;
  final Color? filledColor;
  final Color? unfilledColor;
  final VoidCallback? onAnimationComplete;

  @override
  State<AnimatedStarRating> createState() => _AnimatedStarRatingState();
}

class _AnimatedStarRatingState extends State<AnimatedStarRating>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _fillAnimations;
  late List<Animation<double>> _scaleAnimations;
  bool _animationsInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    // Atrasa o início da animação para garantir que o widget está totalmente construído
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _startAnimation();
      }
    });
  }

  @override
  void didUpdateWidget(AnimatedStarRating oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rating != widget.rating ||
        oldWidget.starCount != widget.starCount) {
      _resetAndRestartAnimation();
    }
  }

  void _initializeAnimations() {
    final clampedRating = widget.rating.clamp(0.0, widget.starCount.toDouble());

    _controllers = List.generate(widget.starCount, (index) {
      return AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      );
    });

    _fillAnimations = _controllers.asMap().entries.map((entry) {
      final index = entry.key;
      final controller = entry.value;
      final starFill = (clampedRating - index).clamp(0.0, 1.0);

      return Tween<double>(
        begin: 0,
        end: starFill,
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeOutCubic,
        ),
      );
    }).toList();

    _scaleAnimations = _controllers.map((controller) {
      return TweenSequence<double>([
        TweenSequenceItem(
          tween: Tween<double>(
            begin: 0,
            end: 1.3,
          ).chain(CurveTween(curve: Curves.easeOutBack)),
          weight: 50,
        ),
        TweenSequenceItem(
          tween: Tween<double>(
            begin: 1.3,
            end: 1,
          ).chain(CurveTween(curve: Curves.easeOut)),
          weight: 50,
        ),
      ]).animate(controller);
    }).toList();

    _animationsInitialized = true;
  }

  void _resetAndRestartAnimation() {
    if (!_animationsInitialized || !mounted) return;

    // Para todas as animações
    for (final controller in _controllers) {
      controller.reset();
    }

    // Reinicializa as animações com os novos valores
    _initializeAnimations();

    // Reinicia a animação
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _startAnimation();
      }
    });
  }

  Future<void> _startAnimation() async {
    if (!_animationsInitialized || !mounted) return;

    // Anima TODAS as estrelas, não apenas as preenchidas
    for (var i = 0; i < widget.starCount; i++) {
      if (i > 0) {
        await Future<void>.delayed(widget.staggerDelay);
      }
      if (mounted && _animationsInitialized) {
        unawaited(_controllers[i].forward());
      }
    }

    if (mounted) {
      widget.onAnimationComplete?.call();
    }
  }

  @override
  void dispose() {
    _animationsInitialized = false;
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildStar(int index) {
    final filledColor = widget.filledColor ?? Colors.amber;
    final unfilledColor = widget.unfilledColor ?? Colors.grey.shade400;

    if (!_animationsInitialized) {
      // Retorna estrela estática enquanto animações não estão prontas
      final clampedRating = widget.rating.clamp(
        0.0,
        widget.starCount.toDouble(),
      );
      final fillProgress = (clampedRating - index).clamp(0.0, 1.0);

      if (fillProgress <= 0.0) {
        return Icon(
          Icons.star_outline,
          size: widget.starSize,
          color: unfilledColor,
        );
      } else if (fillProgress >= 1.0) {
        return Icon(Icons.star, size: widget.starSize, color: filledColor);
      } else {
        return Stack(
          children: [
            Icon(
              Icons.star_outline,
              size: widget.starSize,
              color: unfilledColor,
            ),
            ClipRect(
              child: Align(
                alignment: Alignment.centerLeft,
                widthFactor: fillProgress,
                child: Icon(
                  Icons.star,
                  size: widget.starSize,
                  color: filledColor,
                ),
              ),
            ),
          ],
        );
      }
    }

    return AnimatedBuilder(
      animation: Listenable.merge([
        _fillAnimations[index],
        _scaleAnimations[index],
      ]),
      builder: (context, child) {
        final fillProgress = _fillAnimations[index].value;
        final scale = _scaleAnimations[index].value;

        Widget star;
        if (fillProgress <= 0.0) {
          star = Icon(
            Icons.star_outline,
            size: widget.starSize,
            color: unfilledColor,
          );
        } else if (fillProgress >= 1.0) {
          star = Icon(Icons.star, size: widget.starSize, color: filledColor);
        } else {
          star = Stack(
            children: [
              Icon(
                Icons.star_outline,
                size: widget.starSize,
                color: unfilledColor,
              ),
              ClipRect(
                child: Align(
                  alignment: Alignment.centerLeft,
                  widthFactor: fillProgress,
                  child: Icon(
                    Icons.star,
                    size: widget.starSize,
                    color: filledColor,
                  ),
                ),
              ),
            ],
          );
        }

        return Transform.scale(scale: scale, child: star);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.starCount, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: _buildStar(index),
        );
      }),
    );
  }
}

/// Widget interativo com foco em animações durante drag
/// Versão corrigida com melhor handling de estado e cursor hover
class DraggableStarRating extends StatefulWidget {
  const DraggableStarRating({
    required this.onRatingChanged,
    this.initialRating = 0.0,
    this.starCount = 5,
    this.starSize = 32.0,
    this.allowHalfRating = true,
    this.filledColor,
    this.unfilledColor,
    this.minRating = 0.0,
    super.key,
  });

  final void Function(double rating) onRatingChanged;
  final double initialRating;
  final int starCount;
  final double starSize;
  final bool allowHalfRating;
  final Color? filledColor;
  final Color? unfilledColor;
  final double minRating;

  @override
  State<DraggableStarRating> createState() => _DraggableStarRatingState();
}

class _DraggableStarRatingState extends State<DraggableStarRating>
    with TickerProviderStateMixin {
  late double _currentRating;
  double? _dragRating;
  bool _isDragging = false;
  bool _animationsInitialized = false;

  // Animações para cada estrela durante drag
  late List<AnimationController> _dragControllers;
  late List<Animation<double>> _dragScaleAnimations;
  late List<Animation<double>> _dragRotationAnimations;
  late List<Animation<Color?>> _dragColorAnimations;

  // Controlador para wave effect durante drag
  late AnimationController _waveController;
  late Animation<double> _waveAnimation;

  // Controlador para feedback háptico e visual
  late AnimationController _feedbackController;
  late Animation<double> _feedbackAnimation;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating.clamp(
      widget.minRating,
      widget.starCount.toDouble(),
    );
    _initializeDragAnimations();
  }

  void _initializeDragAnimations() {
    // Controladores individuais para cada estrela
    _dragControllers = List.generate(widget.starCount, (index) {
      return AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      );
    });

    // Animações de escala durante drag
    _dragScaleAnimations = _dragControllers.map((controller) {
      return Tween<double>(begin: 1, end: 1.15).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOut),
      );
    }).toList();

    // Animações de rotação sutil durante drag
    _dragRotationAnimations = _dragControllers.map((controller) {
      return Tween<double>(begin: 0, end: 0.05).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOut),
      );
    }).toList();

    // Animações de cor durante drag (mais vibrante)
    final baseColor = widget.filledColor ?? Colors.amber;
    final brightColor = HSLColor.fromColor(
      baseColor,
    ).withLightness(0.7).withSaturation(1).toColor();

    _dragColorAnimations = _dragControllers.map((controller) {
      return ColorTween(begin: baseColor, end: brightColor).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOut),
      );
    }).toList();

    // Wave effect controller
    _waveController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _waveAnimation = CurvedAnimation(
      parent: _waveController,
      curve: Curves.easeOut,
    );

    // Feedback controller
    _feedbackController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _feedbackAnimation = Tween<double>(begin: 1, end: 0.95).animate(
      CurvedAnimation(parent: _feedbackController, curve: Curves.easeOut),
    );

    _animationsInitialized = true;
  }

  @override
  void dispose() {
    _animationsInitialized = false;
    for (final controller in _dragControllers) {
      controller.dispose();
    }
    _waveController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  double _calculateRatingFromPosition(double localX, double totalWidth) {
    if (totalWidth <= 0) return widget.minRating;

    // Calcula em qual estrela visual estamos clicando (0-based)
    final starWidth = totalWidth / widget.starCount;
    final starIndex = (localX / starWidth).floor().clamp(
      0,
      widget.starCount - 1,
    );

    // Calcula a posição dentro da estrela (0.0 a 1.0)
    final positionInStar = (localX - (starIndex * starWidth)) / starWidth;

    // Calcula o rating "natural" baseado na posição (como se minRating fosse 0)
    double naturalRating;

    if (widget.allowHalfRating) {
      if (positionInStar < 0.5) {
        // Primeira metade da estrela
        naturalRating = starIndex + 0.5;
      } else {
        // Segunda metade da estrela
        naturalRating = starIndex + 1.0;
      }
    } else {
      // Rating inteiro
      naturalRating = starIndex + 1.0;
    }

    // Se o rating natural é menor que minRating, usa minRating
    // Senão, usa o rating natural
    final finalRating = math.max(naturalRating, widget.minRating);

    // Garante que não excede o máximo
    return finalRating.clamp(widget.minRating, widget.starCount.toDouble());
  }

  void _updateRating(double newRating) {
    final clampedRating = newRating.clamp(
      widget.minRating,
      widget.starCount.toDouble(),
    );

    if (_isDragging) {
      setState(() {
        _dragRating = clampedRating;
      });
      _animateStarsForDrag(clampedRating);
    } else {
      if (_currentRating != clampedRating) {
        setState(() {
          _currentRating = clampedRating;
        });
        widget.onRatingChanged(clampedRating);
        _triggerFeedback();
      }
    }
  }

  void _animateStarsForDrag(double rating) {
    if (!_animationsInitialized) return;

    for (var i = 0; i < widget.starCount; i++) {
      final starValue = rating - i;
      if (starValue > 0) {
        // Anima estrelas que devem estar preenchidas
        if (!_dragControllers[i].isAnimating) {
          _dragControllers[i].forward();
        }
      } else {
        // Reverte animação de estrelas vazias
        if (_dragControllers[i].value > 0) {
          _dragControllers[i].reverse();
        }
      }
    }

    // Trigger wave effect
    _waveController.forward(from: 0);
  }

  void _triggerFeedback() {
    if (!_animationsInitialized) return;

    HapticFeedback.lightImpact();
    _feedbackController.forward().then((_) {
      if (mounted && _animationsInitialized) {
        _feedbackController.reverse();
      }
    });
  }

  void _handlePanStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
      _dragRating = _currentRating;
    });

    final box = context.findRenderObject() as RenderBox?;
    if (box != null) {
      final rating = _calculateRatingFromPosition(
        details.localPosition.dx,
        box.size.width,
      );
      _updateRating(rating);
    }
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    if (!_isDragging) return;

    final box = context.findRenderObject() as RenderBox?;
    if (box != null) {
      final rating = _calculateRatingFromPosition(
        details.localPosition.dx,
        box.size.width,
      );
      _updateRating(rating);
    }
  }

  void _handlePanEnd(DragEndDetails details) {
    if (_dragRating != null) {
      setState(() {
        _currentRating = _dragRating!;
        _isDragging = false;
        _dragRating = null;
      });
      widget.onRatingChanged(_currentRating);
      _triggerFeedback();
    }

    // Reverte todas as animações de drag
    if (_animationsInitialized) {
      for (final controller in _dragControllers) {
        controller.reverse();
      }
    }
  }

  void _handleTap(TapDownDetails details) {
    final box = context.findRenderObject() as RenderBox?;
    if (box != null) {
      final rating = _calculateRatingFromPosition(
        details.localPosition.dx,
        box.size.width,
      );
      _updateRating(rating);
    }
  }

  void _handleHoverEnter(PointerEnterEvent event) {
    setState(() {});
  }

  void _handleHoverExit(PointerExitEvent event) {
    setState(() {});
  }

  Widget _buildInteractiveStar(int starIndex) {
    final filledColor = widget.filledColor ?? Colors.amber;
    final unfilledColor = widget.unfilledColor ?? Colors.grey.shade300;

    final displayRating = _dragRating ?? _currentRating;
    final starProgress = (displayRating - starIndex).clamp(0.0, 1.0);

    if (!_animationsInitialized) {
      // Retorna estrela estática enquanto animações não estão prontas
      Widget star;
      if (starProgress <= 0.0) {
        star = Icon(
          Icons.star_outline,
          size: widget.starSize,
          color: unfilledColor,
        );
      } else if (starProgress >= 1.0) {
        star = Icon(Icons.star, size: widget.starSize, color: filledColor);
      } else {
        star = Stack(
          children: [
            Icon(
              Icons.star_outline,
              size: widget.starSize,
              color: unfilledColor,
            ),
            ClipRect(
              child: Align(
                alignment: Alignment.centerLeft,
                widthFactor: starProgress,
                child: Icon(
                  Icons.star,
                  size: widget.starSize,
                  color: filledColor,
                ),
              ),
            ),
          ],
        );
      }
      return star;
    }

    return AnimatedBuilder(
      animation: Listenable.merge([
        _dragScaleAnimations[starIndex],
        _dragRotationAnimations[starIndex],
        _dragColorAnimations[starIndex],
        _feedbackAnimation,
        _waveAnimation,
      ]),
      builder: (context, child) {
        // Calcula escala com wave effect
        final baseScale = _dragScaleAnimations[starIndex].value;
        final feedbackScale = _feedbackAnimation.value;
        final waveOffset = (_waveAnimation.value * widget.starCount - starIndex)
            .clamp(0.0, 1.0);
        final waveScale = 1.0 + (waveOffset * 0.1);
        final finalScale = baseScale * feedbackScale * waveScale;

        final rotation = _dragRotationAnimations[starIndex].value;
        final activeColor =
            _dragColorAnimations[starIndex].value ?? filledColor;

        Widget star;
        if (starProgress <= 0.0) {
          star = Icon(
            Icons.star_outline,
            size: widget.starSize,
            color: unfilledColor,
          );
        } else if (starProgress >= 1.0) {
          star = Icon(
            Icons.star,
            size: widget.starSize,
            color: _isDragging ? activeColor : filledColor,
          );
        } else {
          star = Stack(
            children: [
              Icon(
                Icons.star_outline,
                size: widget.starSize,
                color: unfilledColor,
              ),
              ClipRect(
                child: Align(
                  alignment: Alignment.centerLeft,
                  widthFactor: starProgress,
                  child: Icon(
                    Icons.star,
                    size: widget.starSize,
                    color: _isDragging ? activeColor : filledColor,
                  ),
                ),
              ),
            ],
          );
        }

        return Transform.scale(
          scale: finalScale,
          child: Transform.rotate(
            angle: rotation,
            child: star,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: _handleHoverEnter,
      onExit: _handleHoverExit,
      child: GestureDetector(
        onTapDown: _handleTap,
        onPanStart: _handlePanStart,
        onPanUpdate: _handlePanUpdate,
        onPanEnd: _handlePanEnd,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.starCount, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: _buildInteractiveStar(index),
              );
            }),
          ),
        ),
      ),
    );
  }
}
