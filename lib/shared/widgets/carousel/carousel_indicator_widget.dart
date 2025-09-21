import 'package:flutter/material.dart';

class CarouselIndicatorWidget extends StatelessWidget {
  const CarouselIndicatorWidget({
    required this.activeIndex,
    required this.count,
    super.key,
    this.onDotPressed,
    this.activeColor,
    this.inactiveColor,
    this.dotSize = 8.0,
    this.spacing = 8.0,
  });

  final int activeIndex;
  final int count;
  final void Function(int)? onDotPressed;
  final Color? activeColor;
  final Color? inactiveColor;
  final double dotSize;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveActiveColor = activeColor ?? theme.colorScheme.primary;
    final effectiveInactiveColor =
        inactiveColor ?? theme.colorScheme.onSurfaceVariant.withOpacity(0.3);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == activeIndex;

        return GestureDetector(
          onTap: onDotPressed != null ? () => onDotPressed!(index) : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(horizontal: spacing / 2),
            width: isActive ? dotSize * 2 : dotSize,
            height: dotSize,
            decoration: BoxDecoration(
              color: isActive ? effectiveActiveColor : effectiveInactiveColor,
              borderRadius: BorderRadius.circular(dotSize / 2),
            ),
          ),
        );
      }),
    );
  }
}
