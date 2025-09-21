part of '../../burnt_library.dart';

/// Animation-related constants used by Burnt Toast.
class AnimationConstants {
  /// Duration for the appear animation.
  static const Duration appearDuration = Duration(milliseconds: 350);

  /// Duration for the dismiss animation.
  static const Duration dismissDuration = Duration(milliseconds: 250);

  /// Duration for the snap-back animation after drag.
  static const Duration snapBackDuration = Duration(milliseconds: 200);

  /// Duration for repositioning animations in the stack.
  static const Duration stackAnimationDuration = Duration(milliseconds: 250);

  /// Curve for the stack repositioning animation.
  static const Curve stackAnimationCurve = Curves.easeInOutCubic;

  /// Curve for the appear animation.
  static const Curve appearCurve = Curves.easeOutCubic;

  /// Curve for the fade animation.
  static const Curve fadeCurve = Curves.easeIn;

  /// Curve for the snap-back animation.
  static const Curve snapBackCurve = Curves.easeOut;

  /// Curve for the scale animation on press.
  static const Curve pressScaleCurve = Curves.easeOutQuad;

  /// Duration for the scale animation on press.
  static const Duration pressScaleDuration = Duration(milliseconds: 100);
}
