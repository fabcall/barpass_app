import 'package:barpass_app/core/constants/app_constants.dart';
import 'package:barpass_app/core/theme/app_colors.dart';
import 'package:barpass_app/core/theme/app_spacing.dart';
import 'package:barpass_app/features/navigation/presentation/models/bottom_nav_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Widget que representa um item individual da navegação inferior
///
/// Exibe um ícone com rótulo e suporta estados selecionado/não selecionado
/// com animações suaves, feedback tátil e ripple circular borderless.
class BottomNavItemWidget extends StatefulWidget {
  const BottomNavItemWidget({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.selectedColor,
    required this.unselectedColor,
    super.key,
    this.iconSize = AppSpacing.bottomNavIconSize,
    this.iconGap = AppSpacing.bottomNavIconGap,
    this.height = AppSpacing.bottomNavHeight,
    this.animationDuration = AppConstants.fastAnimationDuration,
    this.rippleRadius = 30.0,
  });

  final BottomNavItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedColor;
  final double iconSize;
  final double iconGap;
  final double height;
  final Duration animationDuration;
  final double rippleRadius;

  @override
  State<BottomNavItemWidget> createState() => _BottomNavItemWidgetState();
}

class _BottomNavItemWidgetState extends State<BottomNavItemWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();

    // Se já está selecionado na inicialização, avança a animação
    if (widget.isSelected) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _animationController.forward();
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _scaleAnimation =
        Tween<double>(
          begin: 1,
          end: 1.1,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.elasticOut,
          ),
        );

    _updateColorAnimation();
  }

  void _updateColorAnimation() {
    _colorAnimation =
        ColorTween(
          begin: widget.unselectedColor,
          end: widget.selectedColor,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void didUpdateWidget(BottomNavItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedColor != widget.selectedColor ||
        oldWidget.unselectedColor != widget.unselectedColor) {
      _updateColorAnimation();
    }

    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  void _handleTap() {
    if (!widget.item.isEnabled) return;

    // Feedback háptico sutil
    HapticFeedback.lightImpact();
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    final color = widget.isSelected
        ? widget.selectedColor
        : widget.unselectedColor;

    return Expanded(
      child: SizedBox(
        height: widget.height + bottomPadding,
        child: Semantics(
          label: 'Navegação ${widget.item.effectiveSemanticLabel}',
          selected: widget.isSelected,
          enabled: widget.item.isEnabled,
          button: true,
          onTap: widget.item.isEnabled ? _handleTap : null,
          child: _buildBorderlessRipple(context, bottomPadding, color),
        ),
      ),
    );
  }

  /// Constrói o widget com ripple borderless (extravasa o container)
  Widget _buildBorderlessRipple(
    BuildContext context,
    double bottomPadding,
    Color color,
  ) {
    return InkResponse(
      onTap: widget.item.isEnabled ? _handleTap : null,
      // Raio do efeito splash/ripple
      radius: widget.rippleRadius,
      splashColor: AppColors.getSplashColor(widget.selectedColor),
      highlightColor: AppColors.getHighlightColor(widget.selectedColor),
      child: Container(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: _buildContent(color),
      ),
    );
  }

  /// Constrói o conteúdo do item (ícone + texto)
  Widget _buildContent(Color color) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: widget.isSelected ? _scaleAnimation.value : 1.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: widget.animationDuration,
                curve: Curves.easeInOut,
                child: Icon(
                  widget.item.iconData,
                  color: _colorAnimation.value ?? color,
                  size: widget.iconSize,
                ),
              ),
              SizedBox(height: widget.iconGap),
              AnimatedDefaultTextStyle(
                duration: widget.animationDuration,
                curve: Curves.easeInOut,
                style: TextStyle(
                  color: _colorAnimation.value ?? color,
                  fontSize: 12,
                  fontWeight: widget.isSelected
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
                child: Text(
                  widget.item.label,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
