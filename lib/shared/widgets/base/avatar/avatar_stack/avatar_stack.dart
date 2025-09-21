import 'dart:math' as math;

import 'package:flutter/material.dart';

enum StackPosition {
  /// Most recent avatars on top (LTR default)
  left,

  /// Oldest avatars on top (reverse)
  right,
}

/// A widget that displays a list of child widgets (usually avatars)
/// in a horizontal stack with overlap and animations.
///
/// Allows limiting the number of visible items or displaying as many as fit
/// in the available space. A customizable widget can be displayed at the end
/// to indicate the number of hidden items.
class AvatarStack extends StatefulWidget {
  /// Creates an avatar stack widget.
  ///
  /// Parameters:
  ///   `children`: List of widgets to display.
  ///   `itemSize`: Size of each item (required).
  ///   `overlap`: Overlap between items. Default is `itemSize / 3`.
  ///   `maxVisible`: Optional limit of visible items.
  ///   `remainderBuilder`: Optional builder for the hidden count widget.
  ///   `direction`: Layout direction. Default is `TextDirection.ltr`.
  ///   `remainderWidth`: Estimated width of the 'remainder' widget. Default is `itemSize`.
  ///   `animationDuration`: Animation duration. Default is 300ms.
  ///   `animationCurve`: Animation curve. Default is easeInOut.
  ///   `staggerDuration`: Delay between each item for staggered effect. Default is 50ms.
  ///   `pressedScaleFactor`: Scale factor when an avatar is pressed. Default is 1.15.
  ///   `pressAnimationDuration`: Duration of press animation. Default is 150ms.
  ///   `offsetAnimationDuration`: Duration of avatar offset animation. Default is 200ms.
  ///   `onAvatarPressed`: Function called when an avatar is pressed (during PressIn).
  ///   `focusSpreadFactor`: Controls how much neighboring avatars move to make space for the selected one. Default is 0.5.
  ///   `stackPosition`: Determines the stacking position of items in the stack. Default is `StackPosition.left`.
  const AvatarStack({
    required this.children,
    required this.itemSize,
    super.key,
    double? overlap,
    this.maxVisible,
    this.remainderBuilder,
    this.direction = TextDirection.ltr,
    this.remainderWidth,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.staggerDuration = const Duration(milliseconds: 50),
    this.stackPosition = StackPosition.left,
    this.pressedScaleFactor = 1.15,
    this.pressAnimationDuration = const Duration(milliseconds: 150),
    this.offsetAnimationDuration = const Duration(milliseconds: 200),
    this.onAvatarPressed,
    this.focusSpreadFactor = 0.5,
  }) : assert(itemSize > 0, 'itemSize must be positive.'),
       assert(
         overlap == null || overlap >= 0,
         'overlap cannot be negative.',
       ),
       assert(
         overlap == null || overlap < itemSize,
         'overlap must be smaller than itemSize.',
       ),
       assert(
         pressedScaleFactor >= 1.0,
         'pressedScaleFactor must be >= 1.0',
       ),
       assert(
         focusSpreadFactor >= 0.0,
         'focusSpreadFactor must be non-negative',
       ),
       assert(
         remainderWidth == null || remainderWidth > 0,
         'remainderWidth must be positive if provided',
       ),
       overlap = overlap ?? itemSize / 3;

  /// The complete list of child widgets to be potentially displayed.
  final List<Widget> children;

  /// The expected size (width and height) for each child widget.
  /// Used to calculate layout and overlap.
  final double itemSize;

  /// The amount of overlap between adjacent items.
  /// A positive value means items overlap.
  /// For example, if [itemSize] is 40 and [overlap] is 10,
  /// each item will start 30 pixels (40 - 10) after the previous item's start.
  final double overlap;

  /// The maximum number of items to be displayed.
  /// If `null`, the widget will try to display as many items as possible
  /// based on the available horizontal space.
  final int? maxVisible;

  /// An optional builder function that creates a widget to be displayed
  /// at the end of the stack when there are hidden items.
  /// Receives the count of hidden items (`hiddenCount`) as an argument.
  /// If `null` or if there are no hidden items, nothing extra is displayed.
  final Widget Function(int hiddenCount)? remainderBuilder;

  /// The layout direction (left to right or right to left).
  /// Affects visual order and position calculations.
  final TextDirection direction;

  /// The estimated size (width) of the "remainder" widget.
  /// If not provided, assumes it equals [itemSize].
  /// Used in calculating how many items fit dynamically.
  final double? remainderWidth;

  /// Duration of item entrance/exit animations.
  final Duration animationDuration;

  /// Curve of entrance/exit animations.
  final Curve animationCurve;

  /// Delay between each item's animation for staggered effect.
  /// If Duration.zero, all items will animate simultaneously.
  final Duration staggerDuration;

  /// Determines the stacking position of items in the stack
  final StackPosition stackPosition;

  /// Scale factor applied when an avatar is pressed
  final double pressedScaleFactor;

  /// Duration of animation when an avatar is pressed
  final Duration pressAnimationDuration;

  /// Duration of animation for avatar offsets
  final Duration offsetAnimationDuration;

  /// Function called when an avatar is pressed (at PressIn moment)
  final void Function(int index)? onAvatarPressed;

  /// Additional offset amount for neighboring items
  /// when an avatar is selected
  final double focusSpreadFactor;

  @override
  State<AvatarStack> createState() => _AvatarStackState();
}

class _AvatarStackState extends State<AvatarStack>
    with SingleTickerProviderStateMixin {
  // Constants for animation and offset calculations
  static const double _offsetTolerance = 0.1;
  static const double _dampingFactor = 0.2;
  static const Duration _animationFrameDuration = Duration(milliseconds: 16);

  // Animation controller for offset animations
  late AnimationController _offsetController;

  // Keeps a record of the number of visible items in the last frame
  int _lastVisibleCount = 0;
  int _lastTotalCount = 0;

  // Map to track the current scale of each item (0.0 to 1.0)
  final Map<int, double> _scales = {};

  // Index of the currently selected (pressed) avatar
  int? _selectedAvatarIndex;

  // Offset management using a single data structure
  final Map<int, _AvatarOffset> _avatarOffsets = {};

  @override
  void initState() {
    super.initState();
    _offsetController = AnimationController(
      vsync: this,
      duration: widget.offsetAnimationDuration,
    )..addListener(_onOffsetAnimationTick);
  }

  @override
  void dispose() {
    _offsetController.dispose();
    super.dispose();
  }

  /// Calculates the z-index for proper avatar stacking.
  ///
  /// When [StackPosition.left]: Higher indices appear on top (most recent first)
  /// When [StackPosition.right]: Lower indices appear on top (oldest first)
  ///
  /// Example with 3 avatars and StackPosition.left:
  ///   Avatar 0: z-index = 0 (bottom)
  ///   Avatar 1: z-index = 1 (middle)
  ///   Avatar 2: z-index = 2 (top)
  int _getZIndex(int index, int totalVisible) {
    switch (widget.stackPosition) {
      case StackPosition.left:
        return index;
      case StackPosition.right:
        return totalVisible - index;
    }
  }

  /// Returns the z-index for the remainder widget based on [StackPosition].
  ///
  /// When [StackPosition.left]: Remainder appears on top (highest z-index)
  /// When [StackPosition.right]: Remainder appears on bottom (lowest z-index)
  int _getRemainderZIndex(int totalVisible) {
    switch (widget.stackPosition) {
      case StackPosition.left:
        return totalVisible;
      case StackPosition.right:
        return -1;
    }
  }

  /// Returns the width reserved for the remainder widget.
  double _getRemainderWidth() {
    return widget.remainderBuilder != null
        ? (widget.remainderWidth ?? widget.itemSize)
        : 0.0;
  }

  /// Checks if a remainder widget is needed based on visible count.
  bool _needsRemainder(int visibleCount) {
    return widget.remainderBuilder != null &&
        widget.children.length > visibleCount;
  }

  /// Calculates the effective width consumed by each item after the first.
  double _getEffectiveItemWidth() {
    final effectiveWidth = widget.itemSize - widget.overlap;
    assert(
      effectiveWidth > 0,
      'Overlap cannot be equal to or greater than item size.',
    );
    return effectiveWidth;
  }

  /// Calculates the maximum number of items that can be visible
  /// based on available width and widget configuration.
  @visibleForTesting
  int calculateMaxVisibleItems(double availableWidth) {
    if (availableWidth < widget.itemSize) return 0;

    final effectiveItemWidth = _getEffectiveItemWidth();
    final remainderWidth = _getRemainderWidth();

    // Calculate without remainder first
    final maxWithoutRemainder =
        1 + ((availableWidth - widget.itemSize) / effectiveItemWidth).floor();

    // If we don't need a remainder, return the maximum
    if (!_needsRemainder(maxWithoutRemainder)) {
      return math.min(maxWithoutRemainder, widget.children.length);
    }

    // Calculate with space for remainder
    final availableForItems = math.max(0, availableWidth - remainderWidth);
    if (availableForItems < widget.itemSize) return 0;

    final maxWithRemainder =
        1 +
        ((availableForItems - widget.itemSize) / effectiveItemWidth).floor();

    return math.min(math.max(0, maxWithRemainder), widget.children.length);
  }

  /// Calculates the total width required for the stack content.
  @visibleForTesting
  double calculateRequiredWidth(int visibleCount, int hiddenCount) {
    if (visibleCount == 0) {
      return (hiddenCount > 0 && widget.remainderBuilder != null)
          ? _getRemainderWidth()
          : 0.0;
    }

    final effectiveItemWidth = _getEffectiveItemWidth();
    var width = (visibleCount - 1) * effectiveItemWidth + widget.itemSize;

    if (hiddenCount > 0 && widget.remainderBuilder != null) {
      width += effectiveItemWidth;
    }

    return width;
  }

  /// Updates target offsets for all items when selection state changes.
  ///
  /// When an avatar is selected, neighboring avatars spread apart to create
  /// visual focus. The amount of spread is controlled by [focusSpreadFactor].
  void _updateTargetOffsets() {
    // Clear all previous targets and initialize to zero
    for (var i = 0; i < widget.children.length; i++) {
      _avatarOffsets.putIfAbsent(i, () => _AvatarOffset());
      _avatarOffsets[i]!.target = 0.0;
    }

    // Initialize remainder offset
    _avatarOffsets.putIfAbsent(-1, () => _AvatarOffset());
    _avatarOffsets[-1]!.target = 0.0;

    // If no selection, all offsets remain at zero
    if (_selectedAvatarIndex == null) return;

    final selectedIndex = _selectedAvatarIndex!;
    final effectiveItemWidth = _getEffectiveItemWidth();
    final spreadDistance = effectiveItemWidth * widget.focusSpreadFactor;

    // Calculate offsets for each avatar based on distance from selected
    for (var i = 0; i < widget.children.length; i++) {
      if (i < selectedIndex) {
        // Items to the left move further left (inversely proportional to distance)
        final distance = selectedIndex - i;
        _avatarOffsets[i]!.target = -spreadDistance / distance;
      } else if (i > selectedIndex) {
        // Items to the right move further right (inversely proportional to distance)
        final distance = i - selectedIndex;
        _avatarOffsets[i]!.target = spreadDistance / distance;
      }
      // Selected item (i == selectedIndex) stays at target = 0.0
    }

    // Calculate remainder offset if needed
    if (widget.remainderBuilder != null &&
        widget.children.isNotEmpty &&
        _lastVisibleCount > 0) {
      final lastVisibleIndex = _lastVisibleCount - 1;
      final distanceToRemainder = (selectedIndex - lastVisibleIndex).abs() + 1;

      if (selectedIndex <= lastVisibleIndex) {
        // Selected is before or at last visible - remainder moves right
        _avatarOffsets[-1]!.target = spreadDistance / distanceToRemainder;
      } else {
        // Selected is after last visible - remainder moves left
        _avatarOffsets[-1]!.target = -spreadDistance / distanceToRemainder;
      }
    }
  }

  /// Called on each animation tick to interpolate offset values.
  void _onOffsetAnimationTick() {
    if (!mounted) return;

    setState(() {
      for (final offset in _avatarOffsets.values) {
        final delta = offset.target - offset.current;
        if (delta.abs() > _offsetTolerance) {
          offset.current += delta * _dampingFactor;
        } else {
          offset.current = offset.target;
        }
      }
    });
  }

  /// Starts the offset animation if targets have changed.
  void _animateOffsets() {
    if (!mounted) return;

    // Check if any offset needs animation
    var needsAnimation = false;
    for (final offset in _avatarOffsets.values) {
      if ((offset.current - offset.target).abs() > _offsetTolerance) {
        needsAnimation = true;
        break;
      }
    }

    if (!needsAnimation) {
      _offsetController.stop();
      return;
    }

    // Start or continue animation
    if (!_offsetController.isAnimating) {
      _offsetController.repeat();
    }
  }

  /// Handles when an avatar is pressed (PressIn event).
  void _handleAvatarPressed(int index) {
    setState(() {
      _selectedAvatarIndex = index;
      _updateTargetOffsets();
    });

    _animateOffsets();
    widget.onAvatarPressed?.call(index);
  }

  /// Handles reset when an avatar is released or tap occurs outside.
  void _handleReset() {
    if (_selectedAvatarIndex == null) return;

    setState(() {
      _selectedAvatarIndex = null;
      _updateTargetOffsets();
    });

    _animateOffsets();
  }

  /// Returns the current scale factor for an avatar.
  double _getAvatarScale(int index) {
    return _selectedAvatarIndex == index ? widget.pressedScaleFactor : 1.0;
  }

  @override
  void didUpdateWidget(AvatarStack oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update animation controller duration if changed
    if (widget.offsetAnimationDuration != oldWidget.offsetAnimationDuration) {
      _offsetController.duration = widget.offsetAnimationDuration;
    }

    // Handle children list changes
    if (widget.children.length != oldWidget.children.length) {
      _lastTotalCount = widget.children.length;

      // Reset selection if index is now invalid
      if (_selectedAvatarIndex != null &&
          _selectedAvatarIndex! >= widget.children.length) {
        _selectedAvatarIndex = null;
      }
    }

    // Update offsets if selection state is active
    if (_selectedAvatarIndex != null) {
      _updateTargetOffsets();
      _animateOffsets();
    }
  }

  /// Builds a single avatar item with scale animation and gesture detection.
  Widget _buildAvatarItem(int index, double position) {
    return Positioned(
      key: ValueKey('avatar_$index'),
      left: widget.direction == TextDirection.ltr ? position : null,
      right: widget.direction == TextDirection.rtl ? position : null,
      top: 0,
      bottom: 0,
      width: widget.itemSize,
      child: Semantics(
        button: true,
        label: 'Avatar ${index + 1} de ${widget.children.length}',
        onTap: () => _handleAvatarPressed(index),
        child: GestureDetector(
          onTapDown: (_) => _handleAvatarPressed(index),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(
              begin: 0,
              end: (_scales[index] ?? 1.0) * _getAvatarScale(index),
            ),
            duration: _selectedAvatarIndex == index
                ? widget.pressAnimationDuration
                : widget.animationDuration,
            curve: widget.animationCurve,
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: child,
              );
            },
            child: widget.children[index],
          ),
        ),
      ),
    );
  }

  /// Builds the remainder widget showing hidden item count.
  Widget _buildRemainderItem(int hiddenCount, double position) {
    final remainderWidget = widget.remainderBuilder!(hiddenCount);
    final actualRemainderWidth = _getRemainderWidth();

    return Positioned(
      key: const ValueKey('remainder'),
      left: widget.direction == TextDirection.ltr ? position : null,
      right: widget.direction == TextDirection.rtl ? position : null,
      top: 0,
      bottom: 0,
      width: actualRemainderWidth,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 1),
        duration: widget.animationDuration,
        curve: widget.animationCurve,
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: remainderWidget,
      ),
    );
  }

  /// Initializes and animates scales for new or changed items.
  void _initializeScales(int visibleCount) {
    final totalChanged = widget.children.length != _lastTotalCount;
    final itemsAdded = visibleCount > _lastVisibleCount;
    final itemsRemoved = visibleCount < _lastVisibleCount;

    if (totalChanged) {
      // Reset all scales when total changes
      _scales.clear();
      for (var i = 0; i < widget.children.length; i++) {
        _scales[i] = 0.0;
      }

      // Animate visible items with stagger
      for (var i = 0; i < math.min(visibleCount, widget.children.length); i++) {
        Future.delayed(widget.staggerDuration * i, () {
          if (mounted) {
            setState(() {
              _scales[i] = 1.0;
            });
          }
        });
      }
    } else if (itemsAdded) {
      // Animate newly visible items
      for (var i = _lastVisibleCount; i < visibleCount; i++) {
        _scales[i] = 0.0;
        Future.delayed(
          widget.staggerDuration * (i - _lastVisibleCount),
          () {
            if (mounted) {
              setState(() {
                _scales[i] = 1.0;
              });
            }
          },
        );
      }
    } else if (itemsRemoved) {
      // Animate removed items (reverse stagger)
      for (var i = visibleCount; i < _lastVisibleCount; i++) {
        if (i < widget.children.length) {
          _scales[i] = 1.0;
          final reverseIndex = _lastVisibleCount - i;
          Future.delayed(widget.staggerDuration * reverseIndex, () {
            if (mounted) {
              setState(() {
                _scales[i] = 0.0;
              });
            }
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.children.isEmpty) {
      _lastVisibleCount = 0;
      _lastTotalCount = 0;
      return const SizedBox.shrink();
    }

    // Initialize offsets if needed
    if (_avatarOffsets.isEmpty) {
      _updateTargetOffsets();
      if (_selectedAvatarIndex != null) {
        _animateOffsets();
      }
    }

    return TapRegion(
      onTapOutside: (_) => _handleReset(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = constraints.maxWidth;
          final effectiveItemWidth = _getEffectiveItemWidth();

          // Calculate visible count
          var visibleCount = calculateMaxVisibleItems(availableWidth);
          if (widget.maxVisible != null) {
            visibleCount = math.min(visibleCount, widget.maxVisible!);
          }

          // Initialize scales for items
          _initializeScales(visibleCount);

          // Update counters
          _lastVisibleCount = visibleCount;
          _lastTotalCount = widget.children.length;

          final hiddenCount = widget.children.length - visibleCount;

          // Build positioned items
          final positionedItems = <Widget>[];

          // Add avatars
          for (var i = 0; i < visibleCount; i++) {
            final offset = _avatarOffsets[i]?.current ?? 0.0;
            final position = i * effectiveItemWidth + offset;
            positionedItems.add(_buildAvatarItem(i, position));
          }

          // Add remainder if needed
          if (hiddenCount > 0 && widget.remainderBuilder != null) {
            final offset = _avatarOffsets[-1]?.current ?? 0.0;
            final position = visibleCount * effectiveItemWidth + offset;
            positionedItems.add(_buildRemainderItem(hiddenCount, position));
          }

          // Sort by z-index for proper stacking
          positionedItems.sort((a, b) {
            final keyA = (a.key! as ValueKey).value as String;
            final keyB = (b.key! as ValueKey).value as String;

            var zIndexA = 0;
            var zIndexB = 0;

            if (keyA.startsWith('avatar_')) {
              final index = int.parse(keyA.substring(7));
              zIndexA = _getZIndex(index, visibleCount);
            } else if (keyA == 'remainder') {
              zIndexA = _getRemainderZIndex(visibleCount);
            }

            if (keyB.startsWith('avatar_')) {
              final index = int.parse(keyB.substring(7));
              zIndexB = _getZIndex(index, visibleCount);
            } else if (keyB == 'remainder') {
              zIndexB = _getRemainderZIndex(visibleCount);
            }

            return zIndexA.compareTo(zIndexB);
          });

          // Calculate required width
          final requiredWidth = calculateRequiredWidth(
            visibleCount,
            hiddenCount,
          );

          return SizedBox(
            height: widget.itemSize,
            width: math.min(availableWidth, requiredWidth),
            child: Stack(
              clipBehavior: Clip.none,
              children: positionedItems,
            ),
          );
        },
      ),
    );
  }
}

/// Internal class to manage avatar offset state.
class _AvatarOffset {
  /// Current animated offset value
  double current;

  /// Target offset value to animate towards
  double target;

  _AvatarOffset({this.current = 0.0, this.target = 0.0});
}

/// Default widget to display hidden item count.
Widget defaultRemainderBuilder(int hiddenCount) {
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.grey.shade300,
      border: Border.all(color: Colors.white),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 3,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: Center(
      child: Text(
        '+$hiddenCount',
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
