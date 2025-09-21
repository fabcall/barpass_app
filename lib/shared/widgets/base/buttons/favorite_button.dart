import 'package:flutter/material.dart';

/// Widget especializado para o botão de favoritar com animação otimista
class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    required this.isFavorite,
    required this.onToggle,
    this.backgroundColor,
    this.foregroundColor,
    this.size = 24.0,
    this.animationDelay = Duration.zero,
    super.key,
  });

  /// Estado atual do favorito
  final bool isFavorite;

  /// Callback para toggle (deve retornar Future para UI otimista)
  final Future<void> Function() onToggle;

  /// Cor de fundo do botão
  final Color? backgroundColor;

  /// Cor do ícone
  final Color? foregroundColor;

  /// Tamanho do ícone
  final double size;

  /// Delay para animação de entrada
  final Duration animationDelay;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late AnimationController _heartController;

  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _heartScaleAnimation;

  // Estado otimista local
  late bool _isOptimisticFavorite;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _isOptimisticFavorite = widget.isFavorite;
    _setupAnimations();
  }

  void _setupAnimations() {
    // Animação de entrada (slide)
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation =
        Tween<Offset>(
          begin: const Offset(1.5, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _slideController,
            curve: Curves.easeOutCubic,
          ),
        );

    // Animação de escala do botão
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _scaleAnimation =
        Tween<double>(
          begin: 1.0,
          end: 0.85,
        ).animate(
          CurvedAnimation(
            parent: _scaleController,
            curve: Curves.easeInOut,
          ),
        );

    // Animação do coração (pop effect)
    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _heartScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 1.4,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.4,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 50,
      ),
    ]).animate(_heartController);

    // Inicia animação de entrada
    Future.delayed(widget.animationDelay, () {
      if (mounted) {
        _slideController.forward();
      }
    });
  }

  @override
  void didUpdateWidget(FavoriteButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Atualiza estado otimista apenas se não estiver animando
    // (evita conflito com UI otimista)
    if (!_isAnimating && widget.isFavorite != oldWidget.isFavorite) {
      _isOptimisticFavorite = widget.isFavorite;
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    _scaleController.dispose();
    _heartController.dispose();
    super.dispose();
  }

  Future<void> _handleToggle() async {
    if (_isAnimating) return;

    setState(() {
      _isAnimating = true;
      // UI otimista: atualiza imediatamente
      _isOptimisticFavorite = !_isOptimisticFavorite;
    });

    // Animações
    await _scaleController.forward();
    await _scaleController.reverse();

    if (_isOptimisticFavorite) {
      await _heartController.forward(from: 0);
    }

    // Executa o callback real
    try {
      await widget.onToggle();
    } catch (error) {
      // Em caso de erro, reverte o estado otimista
      if (mounted) {
        setState(() {
          _isOptimisticFavorite = !_isOptimisticFavorite;
        });
      }
      rethrow;
    } finally {
      if (mounted) {
        setState(() {
          _isAnimating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedBuilder(
          animation: _heartScaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _isOptimisticFavorite ? _heartScaleAnimation.value : 1.0,
              child: IconButton.filled(
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                  child: Icon(
                    _isOptimisticFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    key: ValueKey(_isOptimisticFavorite),
                    size: widget.size,
                  ),
                ),
                onPressed: _handleToggle,
                style: IconButton.styleFrom(
                  backgroundColor: widget.backgroundColor,
                  foregroundColor: _isOptimisticFavorite
                      ? Colors.red.shade400
                      : widget.foregroundColor,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
