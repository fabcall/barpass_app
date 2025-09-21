import 'package:barpass_app/core/constants/app_constants.dart';
import 'package:barpass_app/core/theme/app_colors.dart';
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
    this.height = AppConstants.bottomNavBarHeight,
    this.iconSize = AppConstants.bottomNavBarIconSize,
    this.iconGap = AppConstants.bottomNavBarIconGap,
    this.centerText,
    this.enableShadow = true,
    this.shadowColor,
    this.shadowBlur = AppConstants.bottomBarShadowBlur,
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

  /// Se deve exibir sombra personalizada
  final bool enableShadow;

  /// Cor da sombra (calculada automaticamente se não especificada)
  final Color? shadowColor;

  /// Intensidade do blur da sombra
  final double shadowBlur;

  @override
  Widget build(BuildContext context) {
    final navigationColors = AppColors.getNavigationColors(context);
    final effectiveBackgroundColor =
        backgroundColor ?? AppColors.getSurfaceColor(context);
    final effectiveSelectedColor =
        selectedColor ?? AppColors.getOnSurfaceColor(context);
    final effectiveUnselectedColor =
        unselectedColor ?? navigationColors.unselected;
    final effectiveShadowColor = shadowColor ?? navigationColors.shadow;

    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    final totalHeight = height + bottomPadding;

    // Abordagem híbrida: Container para sombra base + CustomPaint para notch correto
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Sombra customizada que respeita o notch
        if (enableShadow)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(double.infinity, totalHeight),
              painter: _NotchedShadowPainter(
                context: context,
                notchRadius: AppConstants.notchRadius,
                shadowColor: effectiveShadowColor,
                shadowBlur: shadowBlur * 0.5,
                barHeight: totalHeight,
              ),
            ),
          ),

        // BottomAppBar principal
        BottomAppBar(
          color: effectiveBackgroundColor,
          shape: notchedShape,
          elevation: 0,
          height: totalHeight,
          padding: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
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
      ],
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

  /// Constrói o espaço central onde ficaria o FAB
  Widget _buildMiddleSpace(BuildContext context, Color unselectedColor) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return Expanded(
      child: SizedBox(
        height: height + bottomPadding,
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
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
    required this.context,
    required this.notchRadius,
    required this.shadowColor,
    required this.shadowBlur,
    required this.barHeight,
  });

  final BuildContext context;
  final double notchRadius;
  final Color shadowColor;
  final double shadowBlur;
  final double barHeight;

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    // Altura real da barra sem safe area

    // Criar forma única: barra MAIS o círculo do FAB
    final combinedPath = Path()
      // Adicionar retângulo da barra compensando a safe area
      ..addRect(
        Rect.fromLTWH(0, -bottomPadding, size.width, barHeight + bottomPadding),
      );

    // ADICIONAR o círculo do FAB (que fica sobre o notch)
    final fabPath = Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(
            centerX,
            notchRadius / 2 - bottomPadding,
          ), // FAB também compensado
          radius: notchRadius,
        ),
      );

    // Usar união para criar a forma final (barra + FAB)
    final finalPath = Path.combine(
      PathOperation.union,
      combinedPath,
      fabPath,
    );

    // Aplicar sombra uniforme na forma combinada
    final shadowPaint = Paint()
      ..color = shadowColor.withValues(alpha: 0.12)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowBlur);

    // Usar o shadowOffset das constantes para posicionar a sombra
    final shadowPath = finalPath.shift(
      const Offset(0, AppConstants.bottomBarShadowOffset),
    );

    // Desenhar a sombra
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
