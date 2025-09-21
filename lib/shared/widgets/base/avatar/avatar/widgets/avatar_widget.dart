import 'package:barpass_app/shared/widgets/base/avatar/avatar/helpers/initials.dart';
import 'package:barpass_app/shared/widgets/base/avatar/avatar/shapes/avatar_shape.dart';
import 'package:barpass_app/shared/widgets/base/avatar/avatar/shapes/circle_avatar_shape.dart';
import 'package:flutter/material.dart';

// --- Avatar Widget (Main Widget) ---

/// A flexible and customizable avatar widget that can display:
/// - An image (from an [ImageProvider]).
/// - User initials, automatically generated from a name.
/// - A custom child widget.
///
/// Supports different shapes (circle, rounded rectangle) and borders
/// with solid colors or gradients, plus fade-in effects for images.
/// By default, uses a gradient as the background color.
class Avatar extends StatelessWidget {
  /// Constructor for the [Avatar] widget.
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
       );

  /// Optional: The user's name. If [image] and [child] are null,
  /// initials will be generated from this name.
  final String? name;

  /// Optional: The image to be displayed in the avatar.
  /// If provided, takes precedence over [name] and [child].
  final ImageProvider? image;

  /// Optional: A custom child widget to be displayed in the avatar.
  /// If provided, takes precedence over [name] and [image].
  final Widget? child;

  /// The size (width and height) of the avatar in pixels.
  ///
  /// Defaults to `64`.
  final double size;

  /// The background color of the avatar (if you don't want to use gradient).
  ///
  /// If null and [backgroundGradient] is also null, a gradient will be
  /// automatically generated based on the name hash.
  final Color? backgroundColor;

  /// The background gradient of the avatar.
  ///
  /// If null and [backgroundColor] is also null, a gradient will be
  /// automatically generated based on the name hash.
  final Gradient? backgroundGradient;

  /// The color of the initials text or fallback icon.
  ///
  /// If null, will be automatically calculated to have adequate contrast
  /// with the background color using a subtle variation of the background color.
  final Color? foregroundColor;

  /// The text style for the initials.
  ///
  /// If null, a default style will be applied based on the avatar [size].
  final TextStyle? textStyle;

  /// The shape of the avatar (and its border, if any).
  ///
  /// Defaults to [CircleAvatarShape] with `borderWidth` of 0.
  final AvatarShape shape;

  /// A widget builder to display when the image fails to load.
  ///
  /// If null, initials (or a person icon) will be displayed on error.
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;

  /// A widget builder to display while the image is loading.
  ///
  /// If null, initials (or a person icon) will be displayed as placeholder.
  final Widget Function(BuildContext, Widget)? placeholderBuilder;

  /// A widget builder to customize the display of initials.
  ///
  /// Receives the [BuildContext], initials string, background color, and foreground color.
  /// If null, a default [Text] widget will be used to display the initials.
  final Widget Function(BuildContext, String, Color?, Color?)? initialsBuilder;

  /// The duration of the fade-in animation when the image is loaded.
  ///
  /// Defaults to `const Duration(milliseconds: 300)`.
  final Duration fadeInDuration;

  /// Generates initials from [name] using the [Initials] class.
  ///
  /// Returns an empty string if the name is null or empty.
  String _getInitials() {
    if (name == null || name!.trim().isEmpty) return '';

    // Uses the Initials class to extract initials.
    // The Initials class already handles uppercase conversion (if keepCase=false, which is default)
    // and the default length of 2 initials.
    return Initials(name!).initials;
  }

  /// Generates a random background color based on the [name] hash.
  ///
  /// If [name] is null or empty, returns [Colors.grey].
  Color _getColorFromName() {
    if (name == null || name!.isEmpty) return Colors.grey;
    final hash = name!.codeUnits.fold(0, (prev, el) => (prev * 31 + el) % 1000);
    final hue = hash / 1000 * 360;
    return HSLColor.fromAHSL(1, hue, 0.5, 0.6).toColor();
  }

  /// Generates a random background gradient based on the [name] hash.
  ///
  /// If [name] is null or empty, returns a default gray gradient.
  Gradient _getGradientFromName() {
    if (name == null || name!.isEmpty) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF9E9E9E),
          Color(0xFF616161),
        ],
      );
    }

    final hash = name!.codeUnits.fold(0, (prev, el) => (prev * 31 + el) % 1000);
    final hue1 = hash / 1000 * 360;
    final hue2 =
        (hash / 1000 * 360 + 30) %
        360; // Add 30 degrees for a complementary color

    final color1 = HSLColor.fromAHSL(1, hue1, 0.6, 0.6).toColor();
    final color2 = HSLColor.fromAHSL(1, hue2, 0.5, 0.7).toColor();

    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [color1, color2],
    );
  }

  /// Generates a foreground color with high contrast against the background.
  ///
  /// Uses a more aggressive contrast calculation to ensure text readability.
  /// For medium to light colors, returns a very dark color.
  /// For very dark colors, returns white.
  Color _getForegroundColor(Color backgroundColor) {
    // Calculate relative luminance (0.0 to 1.0)
    final luminance = backgroundColor.computeLuminance();

    // Use a threshold to determine if we need white or dark text
    // 0.5 is a good middle point for accessibility
    if (luminance > 0.5) {
      // Background is light, use very dark text
      return const Color(0xFF1A1A1A); // Very dark gray, almost black
    } else {
      // Background is dark, use white text
      return const Color(0xFFFFFFFF); // Pure white
    }
  }

  /// Builds the widget that displays initials or a fallback icon.
  ///
  /// [background] is the calculated background color for the avatar.
  /// [foreground] is the calculated foreground color for the text/icon.
  Widget _buildInitials(
    BuildContext context,
    Color background,
    Color foreground,
  ) {
    final initialsString = _getInitials();

    // If initials are empty, display a person icon.
    if (initialsString.isEmpty) {
      return Icon(Icons.person, color: foreground, size: size * 0.6);
    }
    // If a custom [initialsBuilder] is provided, use it.
    if (initialsBuilder != null) {
      return initialsBuilder!(context, initialsString, background, foreground);
    }
    // Otherwise, display initials as a centered [Text] widget.
    return Center(
      child: Text(
        initialsString,
        style:
            textStyle?.copyWith(color: foreground) ??
            TextStyle(
              color: foreground,
              // Adjust font size based on the number of initials.
              fontSize: size / (initialsString.length == 1 ? 2.0 : 2.8),
              fontWeight: FontWeight.bold,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the gradient or background color and foreground color.
    final backgroundGrad =
        backgroundGradient ??
        (backgroundColor != null ? null : _getGradientFromName());
    final backgroundCol =
        backgroundColor ??
        (backgroundGrad != null ? _getColorFromName() : _getColorFromName());
    final foreground = foregroundColor ?? _getForegroundColor(backgroundCol);

    // Assert to ensure border is properly configured if borderWidth > 0.
    assert(
      shape.borderWidth <= 0 ||
          (shape.borderColor != null || shape.borderGradient != null),
      'If borderWidth > 0, either borderColor or borderGradient must be provided to the AvatarShape.',
    );

    // Get the border painter and shape clipper.
    final borderPainter = shape.getBorderPainter(
      Rect.fromLTWH(0, 0, size, size),
    );
    final clipper = shape.getClipper();

    Widget content;

    // Determine the main content of the avatar.
    if (child != null) {
      // If a child widget is provided, it's the content.
      content = child!;
    } else if (image != null) {
      // If an image is provided, it's the content.
      content = Image(
        image: image!,
        fit: BoxFit.cover,
        width: size,
        height: size,
        // Builder to animate the image fade-in.
        frameBuilder: (context, child, frame, wasSync) {
          if (wasSync) return child;
          return AnimatedOpacity(
            opacity: frame != null ? 1.0 : 0.0,
            duration: fadeInDuration,
            curve: Curves.easeIn,
            child: child,
          );
        },
        // Builder to handle image loading errors.
        errorBuilder: (context, error, stackTrace) {
          if (errorBuilder != null) {
            return errorBuilder!(context, error, stackTrace);
          }
          // On error, display initials/fallback icon.
          return _buildInitials(context, backgroundCol, foreground);
        },
        // Builder to display a placeholder while the image loads.
        loadingBuilder: placeholderBuilder != null
            ? (context, child, loadingProgress) {
                if (loadingProgress == null) return child; // Image loaded.
                // While loading, display custom placeholder or initials.
                return placeholderBuilder!(
                  context,
                  _buildInitials(context, backgroundCol, foreground),
                );
              }
            : null, // No placeholder if not provided.
      );
    } else {
      // If neither child nor image, display initials/fallback icon.
      content = _buildInitials(context, backgroundCol, foreground);
    }

    // The final avatar widget, combining content, shape, and border.
    final avatar = SizedBox.square(
      dimension: size, // Ensures the avatar is square with the specified size.
      child: Stack(
        alignment: Alignment.center, // Centers children in the stack.
        children: [
          // Avatar background (gradient or solid color).
          ClipPath(
            clipper: clipper, // Apply the shape defined by the clipper.
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: backgroundGrad != null ? null : backgroundCol,
                gradient: backgroundGrad,
              ),
            ),
          ),
          // Content (image, initials, child).
          ClipPath(
            clipper: clipper, // Apply the same shape to content.
            child: SizedBox(
              width: size,
              height: size,
              child: content,
            ),
          ),
          // Border (drawn on top of content and background).
          if (borderPainter != null)
            CustomPaint(
              size: Size.square(
                size,
              ), // The painter draws at the avatar's full size.
              painter: borderPainter,
            ),
        ],
      ),
    );

    return avatar;
  }
}
