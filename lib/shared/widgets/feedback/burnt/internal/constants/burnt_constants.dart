part of '../../burnt_library.dart';

/// Global constants used by the Burnt Toast system.
class BurntConstants {
  // --- Stack Settings ---

  /// Default maximum number of stacked toasts.
  static const int defaultMaxStack = 3;

  /// Default vertical gap between stacked toasts.
  static const double defaultStackGap = 8;

  // --- Toast Durations ---

  /// Short toast duration.
  static const Duration shortDuration = Duration(seconds: 3);

  /// Long toast duration.
  static const Duration longDuration = Duration(seconds: 5);

  // --- Interaction Constants ---

  /// Minimum upward drag distance to trigger dismissal.
  static const double dismissThreshold = 80;

  /// Sensitivity factor for drag gestures.
  static const double dragSensitivity = 1;

  /// Base top padding from the top of the screen.
  static const double baseTopPadding = 16;

  /// Scale factor applied when the toast is pressed.
  static const double pressScaleFactor = 1.05;

  /// Minimum scale factor for stacked toasts.
  static const double minScaleFactor = 0.85;

  /// Minimum upward velocity to trigger dismissal (pixels/second).
  static const double dismissVelocityThreshold = -500;

  /// Maximum downward drag allowed.
  static const double maxDownwardDrag = 20;

  // --- Shadow System Constants ---

  /// Default primary shadow blur radius.
  static const double defaultPrimaryShadowBlur = 12;

  /// Default secondary shadow blur radius.
  static const double defaultSecondaryShadowBlur = 6;

  /// Default primary shadow offset.
  static const Offset defaultPrimaryShadowOffset = Offset(0, 4);

  /// Default secondary shadow offset.
  static const Offset defaultSecondaryShadowOffset = Offset(0, 2);

  /// Shadow elevation multiplier when dragging.
  static const double dragShadowMultiplier = 1.5;

  /// Base shadow opacity for light theme.
  static const double baseShadowOpacityLight = 0.15;

  /// Base shadow opacity for dark theme.
  static const double baseShadowOpacityDark = 0.4;

  /// Shadow opacity reduction per stack level.
  static const double shadowOpacityReductionPerStack = 0.2;

  /// Minimum shadow opacity.
  static const double minShadowOpacity = 0.3;

  // --- Theme Defaults ---

  /// Default border radius for toast containers.
  static const double defaultBorderRadius = 12;

  /// Default elevation (used in legacy shadow calculations).
  static const double defaultElevation = 12;

  /// Default size for preset icons.
  static const double defaultPresetIconSize = 20;

  /// Default internal padding for toast content.
  static const EdgeInsets defaultContentPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 12,
  );

  /// Spacing between icon and text.
  static const double iconTextSpacing = 12;

  /// Spacing between title and message.
  static const double titleMessageSpacing = 4;

  /// Horizontal padding of toasts from screen edges.
  static const double screenHorizontalPadding = 16;

  // --- Border Constants ---

  /// Default border width.
  static const double defaultBorderWidth = 1;

  /// Default border opacity for light theme.
  static const double defaultBorderOpacityLight = 0.05;

  /// Default border opacity for dark theme.
  static const double defaultBorderOpacityDark = 0.1;

  // --- Background Opacity ---

  /// Background opacity is now 1.0 since we removed blur effect.
  /// The solid background provides better contrast and readability.
  static const double defaultBackgroundOpacity = 1;

  /// Default message text opacity.
  static const double defaultMessageOpacity = 0.8;

  // --- Animation Enhancement ---

  /// Scale factor during press animation (slightly reduced for subtlety).
  static const double pressAnimationScale = 0.96;

  /// Duration for enhanced shadow transitions.
  static const Duration shadowTransitionDuration = Duration(milliseconds: 150);

  /// Curve for shadow transitions.
  static const Curve shadowTransitionCurve = Curves.easeOutCubic;
}
