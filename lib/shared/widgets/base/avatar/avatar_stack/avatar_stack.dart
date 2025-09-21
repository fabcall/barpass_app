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

class _AvatarStackState extends State<AvatarStack> {
  // Keeps a record of the number of visible items in the last frame
  // to detect when items enter or exit
  int _lastVisibleCount = 0;
  int _lastTotalCount = 0;

  // Map to track the current scale of each item (0.0 to 1.0)
  final Map<int, double> _scales = {};

  // Index of the currently selected (pressed) avatar
  int? _selectedAvatarIndex;

  // Stores offsets for each item when an avatar is in focus
  final Map<int, double> _offsets = {};

  // Stores target offsets for animation
  final Map<int, double> _targetOffsets = {};

  /// Returns the z-index (stacking order) for an item based on StackPosition
  int _getZIndex(int index, int totalVisible) {
    switch (widget.stackPosition) {
      case StackPosition.left:
        // More recent avatars (higher indices) stay on top
        return index;
      case StackPosition.right:
        // Older avatars (lower indices) stay on top
        return totalVisible - index;
    }
  }

  /// Returns the z-index for the remainder based on StackPosition
  int _getRemainderZIndex(int totalVisible) {
    switch (widget.stackPosition) {
      case StackPosition.left:
        // Remainder always on top when stackPosition is left
        return totalVisible;
      case StackPosition.right:
        // Remainder always on bottom when stackPosition is right
        return -1;
    }
  }

  @override
  void didUpdateWidget(AvatarStack oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If the children list changed, we might need to update scales
    if (widget.children.length != oldWidget.children.length) {
      _lastTotalCount = widget.children.length;

      // Reset selected avatar if the list changed
      if (_selectedAvatarIndex != null &&
          (_selectedAvatarIndex! >= widget.children.length)) {
        _selectedAvatarIndex = null;
      }
    }

    // If selection state changed, update target offsets and start animation
    if (_selectedAvatarIndex != null) {
      _updateTargetOffsets();
      _animateOffsets();
    }
  }

  // Calculate target offsets for each item when an avatar is selected
  void _updateTargetOffsets() {
    _targetOffsets.clear();
    if (_selectedAvatarIndex == null) {
      // If no avatar is selected, all offsets are 0
      for (var i = 0; i < widget.children.length; i++) {
        _targetOffsets[i] = 0.0;
      }
      _targetOffsets[-1] = 0.0; // We use -1 as identifier for remainder
      return;
    }

    final selectedIndex = _selectedAvatarIndex!;
    final effectiveItemWidth = widget.itemSize - widget.overlap;
    final spreadDistance = effectiveItemWidth * widget.focusSpreadFactor;

    for (var i = 0; i < widget.children.length; i++) {
      if (i < selectedIndex) {
        // Items to the left of selected move further left
        final distance = selectedIndex - i;
        _targetOffsets[i] = -spreadDistance / distance;
      } else if (i > selectedIndex) {
        // Items to the right of selected move further right
        final distance = i - selectedIndex;
        _targetOffsets[i] = spreadDistance / distance;
      } else {
        // The selected item doesn't move
        _targetOffsets[i] = 0.0;
      }
    }

    // Handle the special case of remainder
    if (widget.remainderBuilder != null && widget.children.isNotEmpty) {
      // Calculate distance from selected avatar to remainder
      // Remainder is always positioned after the last visible avatar
      final lastVisibleIndex = _lastVisibleCount - 1;
      final distanceToRemainder = (selectedIndex <= lastVisibleIndex)
          ? (lastVisibleIndex - selectedIndex + 1)
          : (selectedIndex - lastVisibleIndex);

      // Apply the same spacing factor as other avatars
      if (selectedIndex < lastVisibleIndex) {
        // If selected avatar is to the left of last visible,
        // remainder should move right
        _targetOffsets[-1] = spreadDistance / distanceToRemainder;
      } else if (selectedIndex > lastVisibleIndex) {
        // If selected avatar is to the right of last visible,
        // remainder should move left
        _targetOffsets[-1] = -spreadDistance / distanceToRemainder;
      } else {
        // If selected avatar is the last visible,
        // remainder should move right (like others on the right)
        _targetOffsets[-1] = spreadDistance / distanceToRemainder;
      }
    }
  }

  // Handles when an avatar is pressed (PressIn)
  void _handleAvatarPressed(int index) {
    setState(() {
      _selectedAvatarIndex = index;
      _updateTargetOffsets();
    });

    // Start offset animation
    _animateOffsets();

    // Notify external callback, if provided
    widget.onAvatarPressed?.call(index);
  }

  // Handles when an avatar is released (PressOut) or tap outside (via TapRegion)
  void _handleReset() {
    if (_selectedAvatarIndex != null) {
      setState(() {
        _selectedAvatarIndex = null;
        _updateTargetOffsets();
      });

      // Start animation back to original positions
      _animateOffsets();
    }
  }

  // Get current scale factor for an avatar (normal or enlarged)
  double _getAvatarScale(int index) {
    if (_selectedAvatarIndex == index) {
      return widget.pressedScaleFactor;
    }
    return 1;
  }

  // Animates avatar offsets
  void _animateOffsets() {
    if (!mounted) return;

    // Check if all offsets have reached their targets
    var allDone = true;
    for (final key in _targetOffsets.keys) {
      final current = _offsets[key] ?? 0.0;
      final target = _targetOffsets[key] ?? 0.0;

      if ((current - target).abs() > 0.1) {
        allDone = false;
        break;
      }
    }

    if (allDone) return;

    // Calculate new value based on smooth interpolation
    setState(() {
      for (final key in _targetOffsets.keys) {
        final current = _offsets[key] ?? 0.0;
        final target = _targetOffsets[key] ?? 0.0;

        if ((current - target).abs() > 0.1) {
          // Apply simplified "spring" interpolation
          // Use damping factor to make movement smoother
          const damping = 0.2;
          _offsets[key] = current + (target - current) * damping;
        } else {
          _offsets[key] = target;
        }
      }
    });

    // Schedule next animation frame
    Future.delayed(const Duration(milliseconds: 16), _animateOffsets);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.children.isEmpty) {
      _lastVisibleCount = 0;
      _lastTotalCount = 0;
      return const SizedBox.shrink(); // Nothing to display
    }

    // Initialize offsets if first render or when they change
    if (_offsets.isEmpty || _targetOffsets.isEmpty) {
      _updateTargetOffsets();

      // Start animation only when needed (when offsets change)
      if (_selectedAvatarIndex != null) {
        _animateOffsets();
      }
    }

    // Wrap in TapRegion to detect taps outside avatars
    return TapRegion(
      onTapOutside: (event) => _handleReset(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = constraints.maxWidth;

          // Calculate how many items can be visible
          int visibleCount;
          var maxPossibleBasedOnWidth = 0;

          // Effective width of each item after the first (considering overlap)
          final effectiveItemWidth = widget.itemSize - widget.overlap;
          assert(
            effectiveItemWidth > 0,
            'Overlap cannot be equal to or greater than item size.',
          );

          // Estimated width for the 'remainder' widget, if there's a builder
          final actualRemainderWidth = (widget.remainderBuilder != null)
              ? (widget.remainderWidth ?? widget.itemSize)
              : 0.0;

          if (availableWidth < widget.itemSize) {
            maxPossibleBasedOnWidth = 0;
          } else {
            // Calculate how many fit without remainder first
            final maxWithoutRemainder =
                1 +
                ((availableWidth - widget.itemSize) / effectiveItemWidth)
                    .floor();

            // Now calculate how many fit with space for remainder
            final double availableWidthForItems = math.max(
              0,
              availableWidth - actualRemainderWidth,
            );
            var maxWithRemainderSpace = 0;
            if (availableWidthForItems >= widget.itemSize) {
              maxWithRemainderSpace =
                  1 +
                  ((availableWidthForItems - widget.itemSize) /
                          effectiveItemWidth)
                      .floor();
            } else if (availableWidthForItems > 0 &&
                widget.children.isNotEmpty) {
              maxWithRemainderSpace = 0;
            }

            // If we have a remainderBuilder AND we have more children than would fit
            // WITH space for remainder, then use maxWithRemainderSpace.
            // Otherwise, use maxWithoutRemainder.
            if (widget.remainderBuilder != null &&
                widget.children.length > maxWithRemainderSpace) {
              maxPossibleBasedOnWidth = math.max(0, maxWithRemainderSpace);
            } else {
              maxPossibleBasedOnWidth = math.max(0, maxWithoutRemainder);
            }
          }

          // Ensure we don't try to show more items than we have
          maxPossibleBasedOnWidth = math.min(
            maxPossibleBasedOnWidth,
            widget.children.length,
          );

          // Determine final visible count: use limit (maxVisible) if defined,
          // otherwise use maximum calculated based on width.
          if (widget.maxVisible != null) {
            visibleCount = math.min(widget.maxVisible!, widget.children.length);
            // Even with limit, we can't exceed what fits in the space
            visibleCount = math.min(visibleCount, maxPossibleBasedOnWidth);
          } else {
            visibleCount = maxPossibleBasedOnWidth;
          }

          // Detect changes in number of visible items
          final itemsAdded = visibleCount > _lastVisibleCount;
          final itemsRemoved = visibleCount < _lastVisibleCount;
          final totalChanged = widget.children.length != _lastTotalCount;

          // Initialize scales for new items or when total changed
          if (totalChanged) {
            _scales.clear();
            for (var i = 0; i < widget.children.length; i++) {
              // Initialize with 0.0 so all items animate initially
              _scales[i] = 0.0;
            }

            // Animate all visible items with staggered effect
            for (
              var i = 0;
              i < math.min(visibleCount, widget.children.length);
              i++
            ) {
              // Apply progressive delay based on index
              Future.delayed(widget.staggerDuration * i, () {
                if (mounted) {
                  setState(() {
                    _scales[i] = 1.0;
                  });
                }
              });
            }
          }
          // When visible count changes due to available space
          else if (itemsAdded || itemsRemoved) {
            // For added items, start with scale 0 and animate to scale 1 (with stagger)
            if (itemsAdded) {
              for (var i = _lastVisibleCount; i < visibleCount; i++) {
                _scales[i] = 0.0;
                // Apply progressive delay based on appearance order
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
            }
            // For removed items, animate from scale 1 to 0 (with reverse stagger to exit right to left)
            else if (itemsRemoved) {
              for (var i = visibleCount; i < _lastVisibleCount; i++) {
                if (i < widget.children.length) {
                  _scales[i] = 1.0;
                  // Reverse delay (last items exit first)
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

          // Update counters for next frame
          _lastVisibleCount = visibleCount;
          _lastTotalCount = widget.children.length;

          // Calculate how many items are hidden
          final hiddenCount = widget.children.length - visibleCount;

          // Build list of positioned widgets
          final positionedItems = <Widget>[];

          // Add avatars
          for (var i = 0; i < visibleCount; i++) {
            // Apply current (animated) offset to spread avatars when in focus
            final offset = _offsets[i] ?? 0.0;
            // Calculate 'left' position based on index, overlap and offset
            final position = i * effectiveItemWidth + offset;

            // Create avatar widget with animation
            final positioned = Positioned(
              key: ValueKey('avatar_$i'),
              left: widget.direction == TextDirection.ltr ? position : null,
              right: widget.direction == TextDirection.rtl ? position : null,
              top: 0,
              bottom: 0,
              width: widget.itemSize,
              child: GestureDetector(
                onTapDown: (_) => _handleAvatarPressed(i),
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                    begin: 0,
                    end: (_scales[i] ?? 1.0) * _getAvatarScale(i),
                  ),
                  duration: _selectedAvatarIndex == i
                      ? widget.pressAnimationDuration
                      : widget.animationDuration,
                  curve: widget.animationCurve,
                  builder: (context, scale, child) {
                    return Transform.scale(
                      scale: scale,
                      child: child,
                    );
                  },
                  child: widget.children[i],
                ),
              ),
            );

            positionedItems.add(positioned);
          }

          // Add remainder widget if necessary
          if (hiddenCount > 0 && widget.remainderBuilder != null) {
            final remainderWidget = widget.remainderBuilder!(hiddenCount);
            // Apply animated offset to remainder as well
            final offset = _offsets[-1] ?? 0.0;
            final position = visibleCount * effectiveItemWidth + offset;

            final remainderPositioned = Positioned(
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

            positionedItems.add(remainderPositioned);
          }

          // Calculate total width needed for Stack content
          double requiredWidth = 0;
          if (visibleCount > 0) {
            requiredWidth =
                (visibleCount * effectiveItemWidth) +
                (widget.itemSize - effectiveItemWidth);
            if (widget.remainderBuilder != null && hiddenCount > 0) {
              requiredWidth =
                  (visibleCount * effectiveItemWidth) + actualRemainderWidth;
            }
          } else if (widget.remainderBuilder != null && hiddenCount > 0) {
            // Special case: no visible items, but we have remainder
            requiredWidth = actualRemainderWidth;
          }

          // Sort items based on z-index to control stacking order
          positionedItems.sort((a, b) {
            var zIndexA = 0;
            var zIndexB = 0;

            // Determine z-index based on widget key
            if (a.key is ValueKey) {
              final keyA = (a.key! as ValueKey).value as String;
              if (keyA.startsWith('avatar_')) {
                final index = int.parse(keyA.substring(7));
                zIndexA = _getZIndex(index, visibleCount);
              } else if (keyA == 'remainder') {
                zIndexA = _getRemainderZIndex(visibleCount);
              }
            }

            if (b.key is ValueKey) {
              final keyB = (b.key! as ValueKey).value as String;
              if (keyB.startsWith('avatar_')) {
                final index = int.parse(keyB.substring(7));
                zIndexB = _getZIndex(index, visibleCount);
              } else if (keyB == 'remainder') {
                zIndexB = _getRemainderZIndex(visibleCount);
              }
            }

            return zIndexA.compareTo(zIndexB);
          });

          // Return the Stack
          return SizedBox(
            // Define Stack height as item size
            height: widget.itemSize,
            // Define Stack width. Limit to available or required.
            width: math.min(availableWidth, requiredWidth),
            child: Stack(
              // Allow widgets to visually overflow if needed (useful for shadows, etc.)
              // But the SizedBox above limits layout space.
              clipBehavior: Clip.none,
              children: positionedItems,
            ),
          );
        },
      ),
    );
  }
}

// Default widget to display hidden item count
Widget defaultRemainderBuilder(int hiddenCount) {
  return Container(
    width: 40, // Should match itemSize or estimated remainderWidth
    height: 40,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.grey.shade300,
      border: Border.all(color: Colors.white),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.2),
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
