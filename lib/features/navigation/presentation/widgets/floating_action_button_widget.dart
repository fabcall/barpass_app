import 'dart:math' as math;
import '../../../../core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Widget customizado para Floating Action Button com animações e feedback
///
/// Fornece um FAB com elevação consistente e suporte a diferentes estados
/// incluindo carregamento, habilitado/desabilitado e feedback háptico.
class FloatingActionButtonWidget extends StatefulWidget {
  const FloatingActionButtonWidget({
    required this.onPressed,
    required this.icon,
    super.key,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 2.0,
    this.focusElevation = 2.0,
    this.hoverElevation = 2.0,
    this.highlightElevation = 2.0,
    this.disabledElevation = 0.0,
    this.mini = false,
    this.tooltip,
    this.heroTag,
    this.enableFeedback = true,
  });

  /// Callback chamado quando o botão é pressionado
  final VoidCallback? onPressed;

  /// Widget do ícone a ser exibido
  final Widget icon;

  /// Cor de fundo do botão
  final Color? backgroundColor;

  /// Cor do ícone/foreground
  final Color? foregroundColor;

  /// Elevação padrão
  final double elevation;

  /// Elevação quando focado
  final double focusElevation;

  /// Elevação no hover
  final double hoverElevation;

  /// Elevação quando pressionado
  final double highlightElevation;

  /// Elevação quando desabilitado
  final double disabledElevation;

  /// Se é um FAB mini
  final bool mini;

  /// Tooltip do botão
  final String? tooltip;

  /// Tag única para o Hero widget
  final Object? heroTag;

  /// Se deve fornecer feedback háptico
  final bool enableFeedback;

  @override
  State<FloatingActionButtonWidget> createState() =>
      _FloatingActionButtonWidgetState();
}

class _FloatingActionButtonWidgetState extends State<FloatingActionButtonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: AppConstants.fastAnimationDuration,
      vsync: this,
    );

    _rotationAnimation =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

    _scaleAnimation =
        Tween<double>(
          begin: 1.0,
          end: 0.95,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
  }

  void _handleTap() {
    if (widget.onPressed == null) return;

    if (widget.enableFeedback) {
      HapticFeedback.lightImpact();
    }

    // Animação de tap
    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    widget.onPressed!();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: FloatingActionButton(
            onPressed: _handleTap,
            backgroundColor: widget.backgroundColor ?? colorScheme.primary,
            foregroundColor: widget.foregroundColor ?? colorScheme.onPrimary,
            elevation: widget.elevation,
            focusElevation: widget.focusElevation,
            hoverElevation: widget.hoverElevation,
            highlightElevation: widget.highlightElevation,
            disabledElevation: widget.disabledElevation,
            mini: widget.mini,
            tooltip: widget.tooltip,
            heroTag: widget.heroTag,
            child: Transform.rotate(
              angle: _rotationAnimation.value * 2 * math.pi * 0.1,
              child: widget.icon,
            ),
          ),
        );
      },
    );
  }
}

/// Localização customizada para FAB centralizado e ancorado
///
/// Posiciona o FAB no centro horizontal e ancorado à BottomAppBar
/// com offset configurável para ajustes finos de posicionamento.
class CenterDockedFabLocation extends FloatingActionButtonLocation {
  /// Cria uma localização de FAB centralizada e ancorada
  ///
  /// [offset] determina a distância vertical do FAB em relação
  /// à posição docked padrão. Valores positivos movem para baixo.
  const CenterDockedFabLocation({
    this.offset = AppConstants.fabOffset,
  });

  /// Offset vertical em relação à posição docked padrão
  final double offset;

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final fabX = _getCenterX(scaffoldGeometry);
    final fabY = _getDockedY(scaffoldGeometry) + offset;

    return Offset(fabX, fabY);
  }

  /// Calcula a posição X central para o FAB
  double _getCenterX(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    return (scaffoldGeometry.scaffoldSize.width -
            scaffoldGeometry.floatingActionButtonSize.width) /
        2.0;
  }

  /// Calcula a posição Y para ancoragem à BottomAppBar
  double _getDockedY(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final contentBottom = scaffoldGeometry.contentBottom;
    final fabHeight = scaffoldGeometry.floatingActionButtonSize.height;

    final fabY = contentBottom - fabHeight / 2.0;
    final maxFabY = scaffoldGeometry.scaffoldSize.height - fabHeight;

    return math.min(maxFabY, fabY);
  }

  @override
  String toString() => 'CenterDockedFabLocation(offset: $offset)';
}
