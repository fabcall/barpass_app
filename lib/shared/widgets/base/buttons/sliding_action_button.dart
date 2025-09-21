import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

/// Defines the visual properties of [SlidingActionButton].
///
/// Used with [SlidingActionButtonThemeData] to specify the default
/// appearance of sliding action buttons throughout an app.
@immutable
class SlidingActionButtonStyle {
  /// Creates a sliding action button style.
  const SlidingActionButtonStyle({
    this.backgroundColor,
    this.foregroundColor,
    this.sliderColor,
    this.sliderIconColor,
    this.minimumSize,
    this.maximumSize,
    this.borderRadius,
    this.elevation,
    this.sliderPadding,
    this.textStyle,
  });

  /// The button's background color.
  final Color? backgroundColor;

  /// The color for the child text/icon.
  final Color? foregroundColor;

  /// The color of the slider button.
  final Color? sliderColor;

  /// The color of the icon on the slider button.
  final Color? sliderIconColor;

  /// The minimum size of the button.
  ///
  /// If null, defaults to `Size(double.infinity, 56.0)`.
  final Size? minimumSize;

  /// The maximum size of the button.
  ///
  /// If null, no maximum size is enforced.
  final Size? maximumSize;

  /// The border radius of the button.
  ///
  /// If null, defaults to `BorderRadius.circular(30.0)`.
  final BorderRadius? borderRadius;

  /// The elevation of the button.
  ///
  /// If null, defaults to 2.0.
  final double? elevation;

  /// The padding around the slider button.
  ///
  /// If null, defaults to 4.0.
  final double? sliderPadding;

  /// The text style for the child.
  final TextStyle? textStyle;

  /// Creates a copy of this style with the given fields replaced with new values.
  SlidingActionButtonStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Color? sliderColor,
    Color? sliderIconColor,
    Size? minimumSize,
    Size? maximumSize,
    BorderRadius? borderRadius,
    double? elevation,
    double? sliderPadding,
    TextStyle? textStyle,
  }) {
    return SlidingActionButtonStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      sliderColor: sliderColor ?? this.sliderColor,
      sliderIconColor: sliderIconColor ?? this.sliderIconColor,
      minimumSize: minimumSize ?? this.minimumSize,
      maximumSize: maximumSize ?? this.maximumSize,
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
      sliderPadding: sliderPadding ?? this.sliderPadding,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  /// Linearly interpolate between two sliding action button styles.
  static SlidingActionButtonStyle? lerp(
    SlidingActionButtonStyle? a,
    SlidingActionButtonStyle? b,
    double t,
  ) {
    if (identical(a, b)) return a;
    return SlidingActionButtonStyle(
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      foregroundColor: Color.lerp(a?.foregroundColor, b?.foregroundColor, t),
      sliderColor: Color.lerp(a?.sliderColor, b?.sliderColor, t),
      sliderIconColor: Color.lerp(a?.sliderIconColor, b?.sliderIconColor, t),
      minimumSize: Size.lerp(a?.minimumSize, b?.minimumSize, t),
      maximumSize: Size.lerp(a?.maximumSize, b?.maximumSize, t),
      borderRadius: BorderRadius.lerp(a?.borderRadius, b?.borderRadius, t),
      elevation: lerpDouble(a?.elevation, b?.elevation, t),
      sliderPadding: lerpDouble(a?.sliderPadding, b?.sliderPadding, t),
      textStyle: TextStyle.lerp(a?.textStyle, b?.textStyle, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is SlidingActionButtonStyle &&
        other.backgroundColor == backgroundColor &&
        other.foregroundColor == foregroundColor &&
        other.sliderColor == sliderColor &&
        other.sliderIconColor == sliderIconColor &&
        other.minimumSize == minimumSize &&
        other.maximumSize == maximumSize &&
        other.borderRadius == borderRadius &&
        other.elevation == elevation &&
        other.sliderPadding == sliderPadding &&
        other.textStyle == textStyle;
  }

  @override
  int get hashCode => Object.hash(
    backgroundColor,
    foregroundColor,
    sliderColor,
    sliderIconColor,
    minimumSize,
    maximumSize,
    borderRadius,
    elevation,
    sliderPadding,
    textStyle,
  );
}

/// A sliding action button widget that requires the user to slide a button
/// across to confirm an action.
///
/// This widget provides a confirmation mechanism where the user must physically
/// slide a button from left to right to trigger an action, preventing accidental
/// taps.
///
/// Example:
/// ```dart
/// SlidingActionButton(
///   onConfirm: () async {
///     await Future.delayed(Duration(seconds: 2));
///     print('Action confirmed!');
///   },
///   child: const Text('Slide to confirm'),
/// )
/// ```
class SlidingActionButton extends StatefulWidget {
  /// Creates a sliding action button.
  ///
  /// The [child] parameter is required.
  const SlidingActionButton({
    required this.child,
    super.key,
    this.onConfirm,
    this.style,
    this.sliderIcon,
    this.confirmIcon,
    this.threshold = 0.9,
    this.resetAfterSuccess = true,
    this.successDuration = const Duration(milliseconds: 500),
    this.enabled = true,
  }) : assert(
         threshold > 0 && threshold <= 1.0,
         'threshold must be between 0 and 1.0',
       );

  /// The widget to display inside the button as the label.
  ///
  /// Typically a [Text] widget.
  final Widget child;

  /// Called when the slide action is completed successfully.
  ///
  /// If this callback returns a [Future], the button will remain in a
  /// loading state until the future completes. If the future completes
  /// with an error, the button will reset immediately.
  ///
  /// If null, the button is disabled.
  final FutureOr<void> Function()? onConfirm;

  /// Customizes this button's appearance.
  ///
  /// If null, uses the default style from the theme.
  final SlidingActionButtonStyle? style;

  /// The icon to display on the slider button.
  ///
  /// If null, defaults to [Icons.chevron_right].
  final IconData? sliderIcon;

  /// The icon to display when the action is confirmed.
  ///
  /// If null, defaults to [Icons.check].
  final IconData? confirmIcon;

  /// The percentage (0.0 to 1.0) of the track that must be covered
  /// to trigger the confirm action. Defaults to 0.9.
  final double threshold;

  /// Whether the button should reset after a successful confirmation.
  ///
  /// Defaults to true.
  final bool resetAfterSuccess;

  /// How long to wait before resetting after a successful confirmation.
  ///
  /// Only applies if [resetAfterSuccess] is true.
  /// This duration starts counting AFTER the onConfirm promise resolves.
  final Duration successDuration;

  /// Whether the button is enabled.
  ///
  /// A button is disabled if [onConfirm] is null or [enabled] is false.
  final bool enabled;

  bool get _enabled => enabled && onConfirm != null;

  @override
  State<SlidingActionButton> createState() => _SlidingActionButtonState();
}

class _SlidingActionButtonState extends State<SlidingActionButton>
    with SingleTickerProviderStateMixin {
  double _dragPosition = 0;
  bool _isConfirmed = false;
  bool _isLoading = false;
  late AnimationController _resetController;
  late Animation<double> _resetAnimation;

  @override
  void initState() {
    super.initState();
    _resetController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _resetController.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details, double maxDragDistance) {
    if (!widget._enabled || _isConfirmed || _isLoading) return;

    setState(() {
      _dragPosition = (_dragPosition + details.delta.dx).clamp(
        0.0,
        maxDragDistance,
      );
    });

    if (_dragPosition >= maxDragDistance * widget.threshold) {
      _handleConfirm(maxDragDistance);
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (!widget._enabled || _isConfirmed || _isLoading) return;
    _resetSlider();
  }

  Future<void> _handleConfirm(double maxDragDistance) async {
    setState(() {
      _dragPosition = maxDragDistance;
      _isConfirmed = true;
      _isLoading = true;
    });

    try {
      // Aguarda a promise resolver
      await widget.onConfirm?.call();

      if (!mounted) return;

      // Após o sucesso, aguarda o successDuration antes de resetar (se configurado)
      if (widget.resetAfterSuccess) {
        // Mostra o ícone de confirmação por um tempo
        await Future<void>.delayed(widget.successDuration);

        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          _resetSlider();
        }
      } else {
        // Se não deve resetar, apenas remove o loading
        setState(() {
          _isLoading = false;
        });
      }
    } on Exception catch (_) {
      // Em caso de erro, reseta imediatamente
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        _resetSlider();
      }
    }
  }

  void _resetSlider() {
    _resetAnimation =
        Tween<double>(
            begin: _dragPosition,
            end: 0,
          ).animate(
            CurvedAnimation(
              parent: _resetController,
              curve: Curves.easeOut,
            ),
          )
          ..addListener(() {
            setState(() {
              _dragPosition = _resetAnimation.value;
            });
          });

    _resetController.forward(from: 0).then((_) {
      if (mounted) {
        setState(() {
          _isConfirmed = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final style = widget.style ?? const SlidingActionButtonStyle();

    // Resolve colors
    final backgroundColor = style.backgroundColor ?? colorScheme.primary;
    final foregroundColor = style.foregroundColor ?? colorScheme.onPrimary;
    final sliderColor = style.sliderColor ?? colorScheme.surface;
    final sliderIconColor = style.sliderIconColor ?? backgroundColor;

    // Resolve sizes
    final minimumSize = style.minimumSize ?? const Size(double.infinity, 56);
    final maximumSize = style.maximumSize;

    // Resolve other properties
    final borderRadius = style.borderRadius ?? BorderRadius.circular(28);
    final elevation = style.elevation ?? 2.0;
    final sliderPadding = style.sliderPadding ?? 4.0;
    final textStyle =
        style.textStyle ??
        theme.textTheme.titleMedium?.copyWith(
          color: foregroundColor,
          fontWeight: FontWeight.w600,
        );

    final sliderIcon = widget.sliderIcon ?? Icons.chevron_right;
    final confirmIcon = widget.confirmIcon ?? Icons.check;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate actual size
        final width = constraints.constrainWidth(minimumSize.width);
        final height = constraints.constrainHeight(minimumSize.height);

        final constrainedWidth = maximumSize != null
            ? width.clamp(minimumSize.width, maximumSize.width)
            : width;
        final constrainedHeight = maximumSize != null
            ? height.clamp(minimumSize.height, maximumSize.height)
            : height;

        final sliderSize = constrainedHeight - (sliderPadding * 2);
        final maxDragDistance =
            constrainedWidth - sliderSize - (sliderPadding * 2);
        final progress = maxDragDistance > 0
            ? _dragPosition / maxDragDistance
            : 0.0;

        return Opacity(
          opacity: widget._enabled ? 1.0 : 0.5,
          child: Container(
            width: constrainedWidth,
            height: constrainedHeight,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: borderRadius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: elevation * 2,
                  offset: Offset(0, elevation),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Label
                Center(
                  child: Opacity(
                    opacity: _isConfirmed
                        ? 0.0
                        : (1.0 - (progress * 1.5)).clamp(0.0, 1.0),
                    child: DefaultTextStyle(
                      style: textStyle!,
                      child: widget.child,
                    ),
                  ),
                ),

                // Slider button
                AnimatedPositioned(
                  duration: _isConfirmed
                      ? const Duration(milliseconds: 200)
                      : Duration.zero,
                  left: sliderPadding + _dragPosition,
                  top: sliderPadding,
                  child: GestureDetector(
                    onHorizontalDragUpdate: widget._enabled && !_isLoading
                        ? (details) =>
                              _handleDragUpdate(details, maxDragDistance)
                        : null,
                    onHorizontalDragEnd: widget._enabled && !_isLoading
                        ? _handleDragEnd
                        : null,
                    child: Container(
                      width: sliderSize,
                      height: sliderSize,
                      decoration: BoxDecoration(
                        color: sliderColor,
                        borderRadius: borderRadius,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: _isLoading
                          ? Padding(
                              padding: const EdgeInsets.all(12),
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  sliderIconColor,
                                ),
                              ),
                            )
                          : Icon(
                              _isConfirmed ? confirmIcon : sliderIcon,
                              color: _isConfirmed
                                  ? Colors.green
                                  : sliderIconColor,
                              size: 28,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
