import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselIndicator extends StatelessWidget {
  final int activeIndex;
  final int count;
  final void Function(int)? onDotClicked;

  const CarouselIndicator({
    required this.activeIndex,
    required this.count,
    super.key,
    this.onDotClicked,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: count,
      onDotClicked: onDotClicked,
      effect: WormEffect(
        dotHeight: 8,
        dotWidth: 8,
        spacing: 16,
        dotColor: Colors.grey.shade300,
        activeDotColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
