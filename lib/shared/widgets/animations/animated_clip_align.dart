import 'package:flutter/material.dart';

class AnimatedClipAlign extends StatelessWidget {
  const AnimatedClipAlign({
    required this.animation,
    required this.builder,
    super.key,
    this.alignment = Alignment.center,
    this.innerAlignment = Alignment.center,
    this.axis = Axis.horizontal,
  });

  final AlignmentGeometry alignment;
  final AlignmentGeometry innerAlignment;
  final Axis axis;
  final Animation<double> animation;
  final Widget Function(BuildContext context, Animation<double> animation)
  builder;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: alignment,
        child: Align(
          alignment: innerAlignment,
          widthFactor: axis == Axis.horizontal ? animation.value : 1.0,
          heightFactor: axis == Axis.vertical ? animation.value : 1.0,
          child: builder(context, animation),
        ),
      ),
    );
  }
}
