import 'dart:async';

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

/// Widget interativo de rating com suporte a reset para zero
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

class _DraggableStarRatingState extends State<DraggableStarRating> {
  late double _currentRating;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  double _calculateRatingFromPosition(double localX, double totalWidth) {
    if (totalWidth <= 0) return widget.minRating;

    final starWidth = totalWidth / widget.starCount;
    final starIndex = (localX / starWidth).floor();

    if (starIndex < 0) {
      return widget.minRating;
    }

    if (starIndex >= widget.starCount) {
      return widget.starCount.toDouble();
    }

    final positionInStar = (localX - (starIndex * starWidth)) / starWidth;

    double rating;
    if (widget.allowHalfRating) {
      rating = positionInStar < 0.5 ? starIndex + 0.5 : starIndex + 1.0;
    } else {
      rating = starIndex + 1.0;
    }

    return rating;
  }

  void _updateRating(double newRating) {
    if (_currentRating != newRating) {
      setState(() {
        _currentRating = newRating;
      });
      widget.onRatingChanged(newRating);
      HapticFeedback.lightImpact();
    }
  }

  void _handleTap(TapDownDetails details) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;

    final newRating = _calculateRatingFromPosition(
      details.localPosition.dx,
      box.size.width,
    );

    // Lógica de toggle: se clicar na mesma região, zera
    if (widget.minRating == 0.0 && _currentRating > 0) {
      final tolerance = widget.allowHalfRating ? 0.4 : 0.9;
      final diff = (newRating - _currentRating).abs();

      if (diff <= tolerance) {
        _updateRating(0.0);
        return;
      }
    }

    _updateRating(newRating);
  }

  void _handlePanStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
    });
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    if (!_isDragging) return;

    final box = context.findRenderObject() as RenderBox?;
    if (box != null) {
      final rating = _calculateRatingFromPosition(
        details.localPosition.dx,
        box.size.width,
      );

      if (_currentRating != rating) {
        setState(() {
          _currentRating = rating;
        });
      }
    }
  }

  void _handlePanEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
    });
    widget.onRatingChanged(_currentRating);
    HapticFeedback.lightImpact();
  }

  void _handlePanCancel() {
    setState(() {
      _isDragging = false;
    });
  }

  Widget _buildStar(int starIndex) {
    final filledColor = widget.filledColor ?? Colors.amber;
    final unfilledColor = widget.unfilledColor ?? Colors.grey.shade300;
    final starProgress = (_currentRating - starIndex).clamp(0.0, 1.0);

    if (starProgress <= 0.0) {
      return Icon(
        Icons.star_outline,
        size: widget.starSize,
        color: unfilledColor,
      );
    } else if (starProgress >= 1.0) {
      return Icon(
        Icons.star,
        size: widget.starSize,
        color: filledColor,
      );
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
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: _handleTap,
        onPanStart: _handlePanStart,
        onPanUpdate: _handlePanUpdate,
        onPanEnd: _handlePanEnd,
        onPanCancel: _handlePanCancel,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.starCount, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: _buildStar(index),
              );
            }),
          ),
        ),
      ),
    );
  }
}
