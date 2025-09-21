import 'package:barpass_app/shared/widgets/base/avatar/avatar/helpers/initials.dart';
import 'package:barpass_app/shared/widgets/base/avatar/avatar/shapes/avatar_shape.dart';
import 'package:barpass_app/shared/widgets/base/avatar/avatar/shapes/circle_avatar_shape.dart';
import 'package:flutter/material.dart';

/// A flexible and customizable avatar widget that can display:
/// - An image (from an [ImageProvider])
/// - User initials, automatically generated from a name
/// - A custom child widget
///
/// Features:
/// - Multiple shapes (circle, rounded rectangle) with customizable borders
/// - Automatic color generation based on name hash
/// - High contrast foreground colors for accessibility
/// - Smooth fade-in animations for images
/// - Error handling with fallback to initials
/// - Support for solid colors or gradients
///
/// Example:
/// ```dart
/// Avatar(
///   name: 'John Doe',
///   size: 48,
///   shape: CircleAvatarShape(
///     borderWidth: 2,
///     borderColor: Colors.blue,
///   ),
/// )
/// ```
class Avatar extends StatelessWidget {
  /// Creates an [Avatar] widget.
  ///
  /// At least one of [name], [image], or [child] should be provided.
  /// If multiple are provided, precedence is: [child] > [image] > [name].
  const Avatar({
    super.key,
    this.name,
    this.image,
    this.child,
    this.size = 64,
    this.backgroundColor,
    this.backgroundGradient,
    this.foregroundColor,
    this.textStyle,
    this.shape = const CircleAvatarShape(borderWidth: 0),
    this.errorBuilder,
    this.placeholderBuilder,
    this.initialsBuilder,
    this.fadeInDuration = const Duration(milliseconds: 300),
  }) : assert(
         backgroundColor == null || backgroundGradient == null,
         'Cannot provide both backgroundColor and backgroundGradient.',
       ),
       assert(
         size > 0,
         'size must be positive.',
       );

  /// The user's name used for generating initials and colors.
  ///
  /// If [image] and [child] are null, initials will be generated from this name.
  final String? name;

  /// The image to display in the avatar.
  ///
  /// Takes precedence over [name] but not [child].
  final ImageProvider? image;

  /// A custom child widget to display in the avatar.
  ///
  /// Takes precedence over both [image] and [name].
  final Widget? child;

  /// The size (width and height) of the avatar in logical pixels.
  ///
  /// Must be positive. Defaults to `64`.
  final double size;

  /// The solid background color of the avatar.
  ///
  /// Cannot be used together with [backgroundGradient].
  /// If both are null, a gradient is automatically generated based on [name].
  final Color? backgroundColor;

  /// The background gradient of the avatar.
  ///
  /// Cannot be used together with [backgroundColor].
  /// If both are null, a gradient is automatically generated based on [name].
  final Gradient? backgroundGradient;

  /// The color of the initials text or fallback icon.
  ///
  /// If null, automatically calculated for high contrast with the background.
  final Color? foregroundColor;

  /// The text style for the initials.
  ///
  /// If null, a default style is applied based on [size].
  /// The color from this style will be overridden by [foregroundColor].
  final TextStyle? textStyle;

  /// The shape of the avatar and its border.
  ///
  /// Defaults to [CircleAvatarShape] with no border.
  final AvatarShape shape;

  /// Builder for displaying a widget when the image fails to load.
  ///
  /// If null, falls back to displaying initials or a person icon.
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  /// Builder for displaying a widget while the image is loading.
  ///
  /// If null, falls back to displaying initials or a person icon.
  final Widget Function(BuildContext, Widget)? placeholderBuilder;

  /// Builder for customizing the display of initials.
  ///
  /// Parameters: BuildContext, initials string, background color, foreground color.
  /// If null, a default [Text] widget is used.
  final Widget Function(BuildContext, String, Color?, Color?)? initialsBuilder;

  /// Duration of the fade-in animation when the image loads.
  ///
  /// Defaults to `300ms`.
  final Duration fadeInDuration;

  // Constants for color generation
  static const int _hashModulo = 1000;
  static const int _hashMultiplier = 31;
  static const double _maxHue = 360.0;
  static const double _hueOffset = 30.0;
  static const double _luminanceThreshold = 0.5;

  // Default colors for empty names
  static const Color _defaultGrayLight = Color(0xFF9E9E9E);
  static const Color _defaultGrayDark = Color(0xFF616161);
  static const Color _defaultForegroundDark = Color(0xFF1A1A1A);
  static const Color _defaultForegroundLight = Color(0xFFFFFFFF);

  // Default styling ratios
  static const double _iconSizeRatio = 0.6;
  static const double _fontSizeSingleRatio = 2.0;
  static const double _fontSizeMultipleRatio = 2.8;

  /// Generates initials from [name] using the [Initials] helper class.
  ///
  /// Returns an empty string if [name] is null or empty.
  String _getInitials() {
    if (name == null || name!.trim().isEmpty) return '';

    try {
      return Initials(name!).initials;
    } catch (e) {
      debugPrint('Error generating initials from "$name": $e');
      return '';
    }
  }

  /// Generates a deterministic hash from [name].
  ///
  /// Used for consistent color generation based on the name.
  int _getNameHash() {
    if (name == null || name!.isEmpty) return 0;
    return name!.codeUnits.fold(
      0,
      (prev, el) => (prev * _hashMultiplier + el) % _hashModulo,
    );
  }

  /// Generates a background color based on the [name] hash.
  ///
  /// Returns [Colors.grey] if [name] is null or empty.
  /// Uses HSL color space for better color distribution.
  Color _getColorFromName() {
    if (name == null || name!.isEmpty) return Colors.grey;

    final hash = _getNameHash();
    final hue = (hash / _hashModulo) * _maxHue;

    return HSLColor.fromAHSL(1.0, hue, 0.5, 0.6).toColor();
  }

  /// Generates a background gradient based on the [name] hash.
  ///
  /// Creates a gradient with two complementary colors.
  /// Returns a default gray gradient if [name] is null or empty.
  Gradient _getGradientFromName() {
    if (name == null || name!.isEmpty) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_defaultGrayLight, _defaultGrayDark],
      );
    }

    final hash = _getNameHash();
    final hue1 = (hash / _hashModulo) * _maxHue;
    final hue2 = (hue1 + _hueOffset) % _maxHue;

    final color1 = HSLColor.fromAHSL(1.0, hue1, 0.6, 0.6).toColor();
    final color2 = HSLColor.fromAHSL(1.0, hue2, 0.5, 0.7).toColor();

    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [color1, color2],
    );
  }

  /// Generates a foreground color with high contrast against [backgroundColor].
  ///
  /// Ensures text readability by using WCAG contrast guidelines.
  /// Returns very dark color for light backgrounds and white for dark backgrounds.
  Color _getForegroundColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();

    return luminance > _luminanceThreshold
        ? _defaultForegroundDark
        : _defaultForegroundLight;
  }

  /// Builds the default text style for initials.
  ///
  /// Adjusts font size based on the number of initials to maintain visual balance.
  TextStyle _buildDefaultTextStyle(String initials, Color foreground) {
    final fontSize = initials.length == 1
        ? size / _fontSizeSingleRatio
        : size / _fontSizeMultipleRatio;

    return TextStyle(
      color: foreground,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      height: 1.0, // Ensures consistent vertical alignment
    );
  }

  /// Builds the fallback person icon when no initials are available.
  Widget _buildFallbackIcon(Color foreground) {
    return Icon(
      Icons.person,
      color: foreground,
      size: size * _iconSizeRatio,
    );
  }

  /// Builds the widget displaying initials or a fallback icon.
  ///
  /// Uses [initialsBuilder] if provided, otherwise creates a default [Text] widget.
  Widget _buildInitialsContent(
    BuildContext context,
    Color background,
    Color foreground,
  ) {
    final initialsString = _getInitials();

    // Display fallback icon if no initials available
    if (initialsString.isEmpty) {
      return _buildFallbackIcon(foreground);
    }

    // Use custom builder if provided
    if (initialsBuilder != null) {
      return initialsBuilder!(context, initialsString, background, foreground);
    }

    // Build default text widget
    final defaultStyle = _buildDefaultTextStyle(initialsString, foreground);
    final effectiveStyle =
        textStyle?.copyWith(color: foreground) ?? defaultStyle;

    return Center(
      child: Text(
        initialsString,
        style: effectiveStyle,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.visible,
      ),
    );
  }

  /// Builds the image content with loading and error handling.
  Widget _buildImageContent(
    BuildContext context,
    Color backgroundColor,
    Color foregroundColor,
  ) {
    return Image(
      image: image!,
      fit: BoxFit.cover,
      width: size,
      height: size,
      // Animate fade-in when image loads
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;

        return AnimatedOpacity(
          opacity: frame != null ? 1.0 : 0.0,
          duration: fadeInDuration,
          curve: Curves.easeIn,
          child: child,
        );
      },
      // Handle image loading errors
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Avatar image load error: $error');

        if (errorBuilder != null) {
          return errorBuilder!(context, error, stackTrace);
        }

        // Fallback to initials on error
        return _buildInitialsContent(context, backgroundColor, foregroundColor);
      },
      // Display placeholder while loading
      loadingBuilder: placeholderBuilder != null
          ? (context, child, loadingProgress) {
              if (loadingProgress == null) return child;

              return placeholderBuilder!(
                context,
                _buildInitialsContent(
                  context,
                  backgroundColor,
                  foregroundColor,
                ),
              );
            }
          : null,
    );
  }

  /// Determines the main content to display in the avatar.
  ///
  /// Priority: [child] > [image] > initials/icon
  Widget _buildContent(
    BuildContext context,
    Color backgroundColor,
    Color foregroundColor,
  ) {
    if (child != null) {
      return child!;
    }

    if (image != null) {
      return _buildImageContent(context, backgroundColor, foregroundColor);
    }

    return _buildInitialsContent(context, backgroundColor, foregroundColor);
  }

  /// Builds the background layer with color or gradient.
  Widget _buildBackground(
    CustomClipper<Path> clipper,
    Color backgroundColor,
    Gradient? backgroundGradient,
  ) {
    return ClipPath(
      clipper: clipper,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundGradient != null ? null : backgroundColor,
          gradient: backgroundGradient,
        ),
      ),
    );
  }

  /// Builds the content layer with clipping.
  Widget _buildContentLayer(
    CustomClipper<Path> clipper,
    Widget content,
  ) {
    return ClipPath(
      clipper: clipper,
      child: SizedBox(
        width: size,
        height: size,
        child: content,
      ),
    );
  }

  /// Builds the border layer if a border painter is provided.
  Widget? _buildBorderLayer(CustomPainter? borderPainter) {
    if (borderPainter == null) return null;

    return CustomPaint(
      size: Size.square(size),
      painter: borderPainter,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate effective colors
    final effectiveBackgroundGradient =
        backgroundGradient ??
        (backgroundColor != null ? null : _getGradientFromName());
    final effectiveBackgroundColor = backgroundColor ?? _getColorFromName();
    final effectiveForegroundColor =
        foregroundColor ?? _getForegroundColor(effectiveBackgroundColor);

    // Validate border configuration
    assert(
      shape.borderWidth <= 0 ||
          (shape.borderColor != null || shape.borderGradient != null),
      'If borderWidth > 0, either borderColor or borderGradient must be provided.',
    );

    // Get shape components
    final clipper = shape.getClipper();
    final borderPainter = shape.getBorderPainter(
      Rect.fromLTWH(0, 0, size, size),
    );

    // Build content
    final content = _buildContent(
      context,
      effectiveBackgroundColor,
      effectiveForegroundColor,
    );

    // Build avatar layers
    return SizedBox.square(
      dimension: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background layer
          _buildBackground(
            clipper,
            effectiveBackgroundColor,
            effectiveBackgroundGradient,
          ),
          // Content layer
          _buildContentLayer(clipper, content),
          // Border layer (if present)
          if (borderPainter != null) _buildBorderLayer(borderPainter)!,
        ],
      ),
    );
  }
}
