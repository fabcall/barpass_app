import 'package:barpass_app/core/constants/app_constants.dart';
import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/features/navigation/presentation/models/bottom_nav_item.dart';
import 'package:barpass_app/features/navigation/presentation/widgets/bottom_nav_item_widget.dart';
import 'package:flutter/material.dart';

/// Barra de navegação inferior customizada com entalhe para FAB
///
/// Fornece uma interface de navegação com sombra personalizada,
/// suporte a temas e animações suaves entre estados.
class CustomBottomAppBar extends StatelessWidget {
  /// Cria uma barra de navegação inferior customizada
  const CustomBottomAppBar({
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.notchedShape,
    super.key,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.height = AppSizes.bottomAppBarHeight,
    this.iconSize = AppSizes.bottomAppBarIconSize,
    this.iconGap = AppSizes.bottomAppBarIconGap,
    this.centerText,
    this.shadowColor,
    this.shadowBlur = AppSizes.bottomAppBarShadowBlur,
    this.shadowOffset = AppSizes.bottomAppBarShadowOffset,
  }) : assert(
         items.length >= 2 && items.length <= 6,
         'Items count should be between 2 and 6',
       );

  /// Lista de itens da navegação
  final List<BottomNavItem> items;

  /// Índice do item atualmente selecionado
  final int selectedIndex;

  /// Callback chamado quando um item é selecionado
  final ValueChanged<int> onItemSelected;

  /// Forma do entalhe para o FAB
  final NotchedShape notchedShape;

  /// Cor de fundo da barra (usa tema se não especificado)
  final Color? backgroundColor;

  /// Cor do item selecionado (usa tema se não especificado)
  final Color? selectedColor;

  /// Cor dos itens não selecionados (usa AppColors.bottomNavUnselected se não especificado)
  final Color? unselectedColor;

  /// Altura da barra de navegação
  final double height;

  /// Tamanho dos ícones
  final double iconSize;

  /// Espaço entre ícone e texto
  final double iconGap;

  /// Texto opcional exibido no centro (onde seria o FAB)
  final String? centerText;

  /// Cor da sombra (calculada automaticamente se não especificada)
  final Color? shadowColor;

  /// Intensidade do blur da sombra
  final double shadowBlur;

  /// Intensidade do blur da sombra
  final Offset shadowOffset;

  @override
  Widget build(BuildContext context) {
    final navigationColors = AppNavigationColors.get(context);
    final effectiveBackgroundColor =
        backgroundColor ?? navigationColors.background;
    final effectiveSelectedColor = selectedColor ?? navigationColors.selected;
    final effectiveUnselectedColor =
        unselectedColor ?? navigationColors.unselected;
    final effectiveShadowColor = shadowColor ?? navigationColors.shadow;

    // Abordagem híbrida: Container para sombra base + CustomPaint para notch correto
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: CustomPaint(
            size: Size(double.infinity, height + context.viewPadding.bottom),
            painter: _NotchedShadowPainter(
              notchRadius: AppSizes.notchRadius,
              shadowColor: effectiveShadowColor,
              shadowBlur: shadowBlur,
              shadowOffset: shadowOffset,
              barHeight: height + context.viewPadding.bottom,
            ),
          ),
        ),
        BottomAppBar(
          clipBehavior: Clip.antiAlias,
          color: effectiveBackgroundColor,
          elevation: 0,
          height: height,
          padding: EdgeInsets.zero,
          shape: notchedShape,
          notchMargin: AppSizes.notchPadding,
          child: MediaQuery.removeViewPadding(
            context: context,
            removeBottom: true,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _buildNavItems(
                context,
                effectiveSelectedColor,
                effectiveUnselectedColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Constrói o espaço central onde ficaria o FAB
  Widget _buildMiddleSpace(BuildContext context, Color unselectedColor) {
    return Expanded(
      child: SizedBox(
        height: height,
        child: Padding(
          padding: EdgeInsets.only(bottom: context.viewPadding.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: iconSize),
              SizedBox(height: iconGap),
              if (centerText != null)
                AnimatedDefaultTextStyle(
                  duration: AppConstants.fastAnimationDuration,
                  style: TextStyle(
                    color: unselectedColor,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                  child: Text(
                    centerText!,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Constrói a lista de widgets de navegação com espaçamento central se necessário
  List<Widget> _buildNavItems(
    BuildContext context,
    Color selectedColor,
    Color unselectedColor,
  ) {
    final navItems = <Widget>[];
    final middleIndex = items.length ~/ 2;

    for (var i = 0; i < items.length; i++) {
      // Adiciona o item de navegação
      navItems.add(
        BottomNavItemWidget(
          item: items[i],
          isSelected: selectedIndex == i,
          onTap: () => _handleItemSelection(i),
          selectedColor: selectedColor,
          unselectedColor: unselectedColor,
          iconSize: iconSize,
          iconGap: iconGap,
          height: height,
        ),
      );

      // Adiciona espaço central após o item do meio (para FAB)
      if (i == middleIndex - 1) {
        navItems.add(_buildMiddleSpace(context, unselectedColor));
      }
    }

    return navItems;
  }

  /// Gerencia a seleção de itens com validação
  void _handleItemSelection(int index) {
    if (index < 0 || index >= items.length) {
      debugPrint('Invalid navigation index: $index');
      return;
    }

    final item = items[index];
    if (!item.isEnabled) {
      debugPrint('Navigation item at index $index is disabled');
      return;
    }

    onItemSelected(index);
  }
}

/// Painter que cria sombra exatamente como na imagem de referência
class _NotchedShadowPainter extends CustomPainter {
  const _NotchedShadowPainter({
    required this.barHeight,
    required this.notchRadius,
    required this.shadowColor,
    required this.shadowBlur,
    required this.shadowOffset,
  });

  final double barHeight;
  final double notchRadius;
  final Color shadowColor;
  final double shadowBlur;
  final Offset shadowOffset;

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;

    final combinedPath = Path()
      ..addRect(
        Rect.fromLTWH(0, 0, size.width, barHeight),
      );

    final fabPath = Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(
            centerX,
            AppSizes.fabOffset,
          ),
          radius: notchRadius,
        ),
      );

    final finalPath = Path.combine(
      PathOperation.union,
      combinedPath,
      fabPath,
    );

    final shadowPaint = Paint()
      ..color = shadowColor
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowBlur);

    final shadowPath = finalPath.shift(
      shadowOffset,
    );

    canvas.drawPath(shadowPath, shadowPaint);
  }

  @override
  bool shouldRepaint(covariant _NotchedShadowPainter oldDelegate) {
    return oldDelegate.notchRadius != notchRadius ||
        oldDelegate.shadowColor != shadowColor ||
        oldDelegate.shadowBlur != shadowBlur ||
        oldDelegate.barHeight != barHeight;
  }
}
