part of '../../burnt_library.dart';

// --- Toast Widget ---

/// The widget responsible for displaying the toast content and handling its animations.
class _BurntToastWidget extends StatefulWidget {
  const _BurntToastWidget({
    required this.title,
    required this.preset,
    required this.duration,
    required this.onDismissed,
    required this.stackIndex,
    required this.stackGap,
    required this.dismissible,
    super.key,
    this.message,
    this.customIcon,
    this.onTap,
  });

  final String title;
  final String? message;
  final BurntPreset preset;
  final BurntDuration duration;
  final Widget? customIcon;
  final bool dismissible;
  final VoidCallback? onTap;
  final VoidCallback onDismissed;
  final int stackIndex;
  final double stackGap;

  @override
  State<_BurntToastWidget> createState() => _BurntToastWidgetState();
}

class _BurntToastWidgetState extends State<_BurntToastWidget>
    with TickerProviderStateMixin {
  // --- Animation Controllers ---
  late final AnimationController _appearController;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _fadeAnimation;
  late final AnimationController _snapBackController;
  late final AnimationController _pressController;
  Animation<double>? _snapBackAnimationValue;
  late final Animation<double> _pressScaleAnimation;

  // --- State Variables ---
  double _dragOffsetY = 0;
  bool _isDragging = false;
  bool _isPressed = false;
  late int _currentStackIndex;
  late double _currentStackGap;

  @override
  void initState() {
    super.initState();
    _currentStackIndex = widget.stackIndex;
    _currentStackGap = widget.stackGap;

    _appearController = AnimationController(
      duration: AnimationConstants.appearDuration,
      reverseDuration: AnimationConstants.dismissDuration,
      vsync: this,
    );

    _pressController = AnimationController(
      duration: AnimationConstants.pressScaleDuration,
      vsync: this,
    );

    _setupAnimations();
    _appearController.addStatusListener(_handleAppearAnimationStatusChange);

    _snapBackController = AnimationController(
      duration: AnimationConstants.snapBackDuration,
      vsync: this,
    );
    _snapBackController.addListener(_updateDragOffsetFromSnapBackAnimation);

    _appearController.forward();
  }

  void _setupAnimations() {
    _offsetAnimation =
        Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _appearController,
            curve: AnimationConstants.appearCurve,
          ),
        );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _appearController,
        curve: AnimationConstants.fadeCurve,
      ),
    );

    _pressScaleAnimation = Tween<double>(begin: 1, end: 0.96).animate(
      CurvedAnimation(
        parent: _pressController,
        curve: AnimationConstants.pressScaleCurve,
      ),
    );
  }

  @override
  void dispose() {
    _appearController
      ..removeStatusListener(_handleAppearAnimationStatusChange)
      ..dispose();
    _snapBackController
      ..removeListener(_updateDragOffsetFromSnapBackAnimation)
      ..dispose();
    _pressController.dispose();
    super.dispose();
  }

  /// Updates the toast's visual position and scale based on stack index.
  void updateStackPosition(int newIndex, double newGap) {
    if (mounted &&
        (_currentStackIndex != newIndex || _currentStackGap != newGap)) {
      setState(() {
        _currentStackIndex = newIndex;
        _currentStackGap = newGap;
      });
    }
  }

  /// Starts the dismiss animation.
  void animateDismiss() {
    if (_appearController.status == AnimationStatus.reverse ||
        _appearController.status == AnimationStatus.dismissed) {
      return;
    }
    _snapBackController.stop();
    _appearController.reverse();
  }

  void _handleAppearAnimationStatusChange(AnimationStatus status) {
    if (status == AnimationStatus.dismissed) {
      widget.onDismissed();
    }
  }

  void _updateDragOffsetFromSnapBackAnimation() {
    if (mounted && _snapBackAnimationValue != null) {
      setState(() {
        _dragOffsetY = _snapBackAnimationValue!.value;
      });
    }
  }

  // --- Gesture Handlers ---

  void _onPressDown(TapDownDetails details) {
    if (_appearController.isAnimating &&
        _appearController.status == AnimationStatus.reverse) {
      return;
    }

    if (mounted) {
      Burnt().cancelTimer(widget.key! as GlobalKey<_BurntToastWidgetState>);
      setState(() => _isPressed = true);
      _pressController.forward();
    }
  }

  void _onPressUpOrCancel() {
    if (mounted && _isPressed) {
      setState(() => _isPressed = false);
      _pressController.reverse();
      if (!_isDragging && _appearController.status != AnimationStatus.reverse) {
        Burnt().restartTimerIfNecessary(
          widget.key! as GlobalKey<_BurntToastWidgetState>,
        );
      }
    }
  }

  void _onTap() => widget.onTap?.call();

  void _onDragStart(DragStartDetails details) {
    if (_appearController.isAnimating &&
        _appearController.status == AnimationStatus.reverse) {
      return;
    }

    _snapBackController.stop();
    Burnt().cancelTimer(widget.key! as GlobalKey<_BurntToastWidgetState>);

    if (mounted) {
      setState(() {
        _isDragging = true;
        _isPressed = true;
      });
      _pressController.forward();
    }
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (!_isDragging ||
        (_appearController.isAnimating &&
            _appearController.status == AnimationStatus.reverse)) {
      return;
    }

    if (mounted) {
      setState(() {
        _dragOffsetY += details.delta.dy * BurntConstants.dragSensitivity;
        _dragOffsetY = _dragOffsetY.clamp(double.negativeInfinity, 20.0);
      });
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (!_isDragging) return;

    final meetsVelocity = (details.primaryVelocity ?? 0) < -500;
    final meetsOffset = _dragOffsetY < -BurntConstants.dismissThreshold;
    final shouldDismiss = (meetsVelocity || meetsOffset) && widget.dismissible;

    if (mounted) _isPressed = false;
    _pressController.reverse();
    _isDragging = false;

    if (shouldDismiss) {
      animateDismiss();
    } else {
      if (_dragOffsetY != 0.0) {
        _snapBackAnimationValue =
            Tween<double>(
              begin: _dragOffsetY,
              end: 0,
            ).animate(
              CurvedAnimation(
                parent: _snapBackController,
                curve: AnimationConstants.snapBackCurve,
              ),
            );
        _snapBackController.forward(from: 0);
      }
      Burnt().restartTimerIfNecessary(
        widget.key! as GlobalKey<_BurntToastWidgetState>,
      );
      if (_dragOffsetY == 0.0 && mounted) setState(() {});
    }
  }

  // --- UI Builders ---

  Widget _getPresetIcon(BurntThemeData? theme) {
    if (widget.customIcon != null) return widget.customIcon!;
    final iconSize = theme?.presetIconSize ?? 20;

    switch (widget.preset) {
      case BurntPreset.done:
        return theme?.successIcon ??
            Icon(
              Icons.check_circle,
              color: theme?.successIconColor ?? Colors.green,
              size: iconSize,
            );
      case BurntPreset.warning:
        return theme?.warningIcon ??
            Icon(
              Icons.warning,
              color: theme?.warningIconColor ?? Colors.amber,
              size: iconSize,
            );
      case BurntPreset.error:
        return theme?.errorIcon ??
            Icon(
              Icons.error,
              color: theme?.errorIconColor ?? Colors.red,
              size: iconSize,
            );
      case BurntPreset.none:
        return const SizedBox.shrink();
    }
  }

  double _getScaleForIndex(int index) {
    return (1.0 - (index * 0.05)).clamp(BurntConstants.minScaleFactor, 1.0);
  }

  /// Gets shadow opacity based on stack index and drag state
  double _getShadowOpacity() {
    final baseOpacity = 1.0 - (_currentStackIndex * 0.2);
    final dragOpacity = _isDragging ? 0.8 : 1.0;
    return (baseOpacity * dragOpacity).clamp(0.3, 1.0);
  }

  /// Creates dynamic shadows based on current state
  List<BoxShadow> _getDynamicShadows(BurntThemeData? theme) {
    final shadowOpacity = _getShadowOpacity();
    final shadows = theme?.shadows;

    if (shadows != null) {
      // Apply opacity and elevation scaling to custom shadows
      return shadows.map((shadow) {
        final elevationScale = _isDragging ? 1.5 : 1.0;
        return shadow.copyWith(
          color: shadow.color.withValues(alpha: shadow.color.a * shadowOpacity),
          blurRadius: shadow.blurRadius * elevationScale,
          offset: Offset(
            shadow.offset.dx,
            shadow.offset.dy * elevationScale,
          ),
        );
      }).toList();
    }

    // Default shadow system if no custom shadows provided
    final isDark = context.theme.brightness == Brightness.dark;
    final elevationScale = _isDragging ? 1.5 : 1.0;

    return [
      BoxShadow(
        color: isDark
            ? Colors.black.withValues(alpha: 0.4 * shadowOpacity)
            : Colors.black.withValues(alpha: 0.15 * shadowOpacity),
        offset: Offset(0, 4 * elevationScale),
        blurRadius: 12 * elevationScale,
      ),
      BoxShadow(
        color: isDark
            ? Colors.black.withValues(alpha: 0.3 * shadowOpacity)
            : Colors.black.withValues(alpha: 0.1 * shadowOpacity),
        offset: Offset(0, 2 * elevationScale),
        blurRadius: 6 * elevationScale,
        spreadRadius: -2,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = BurntThemeData.of(context);
    final mediaQuery = MediaQuery.of(context);
    final safePaddingTop = mediaQuery.padding.top;

    final baseScale = _getScaleForIndex(_currentStackIndex);
    final pressScale = _pressScaleAnimation.value;
    final finalScale = baseScale * pressScale;

    final paddingTop =
        safePaddingTop +
        BurntConstants.baseTopPadding +
        (_currentStackIndex * _currentStackGap);

    return AnimatedPadding(
      padding: EdgeInsets.only(top: paddingTop, left: 16, right: 16),
      duration: AnimationConstants.stackAnimationDuration,
      curve: AnimationConstants.stackAnimationCurve,
      child: Align(
        alignment: Alignment.topCenter,
        child: IgnorePointer(
          ignoring:
              _appearController.status == AnimationStatus.reverse ||
              _appearController.status == AnimationStatus.dismissed,
          child: MouseRegion(
            cursor: _isDragging
                ? SystemMouseCursors.grabbing
                : SystemMouseCursors.grab,
            child: GestureDetector(
              onVerticalDragStart: widget.dismissible ? _onDragStart : null,
              onVerticalDragUpdate: widget.dismissible ? _onDragUpdate : null,
              onVerticalDragEnd: widget.dismissible ? _onDragEnd : null,
              onTapDown: _onPressDown,
              onTapUp: (_) => _onPressUpOrCancel(),
              onTapCancel: _onPressUpOrCancel,
              onTap: _onTap,
              child: AnimatedScale(
                scale: finalScale,
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeOutCubic,
                child: Transform.translate(
                  offset: Offset(0, _dragOffsetY),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _offsetAnimation,
                      child: _buildToastContent(theme),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToastContent(BurntThemeData? theme) {
    final bgColor = theme?.backgroundColor ?? Colors.white;
    final titleStyle = theme?.titleStyle ?? const TextStyle();
    final messageStyle = theme?.messageStyle ?? const TextStyle();
    final padding = theme?.contentPadding ?? const EdgeInsets.all(16);
    final borderRadius = theme?.borderRadius ?? BorderRadius.circular(12);
    final shadows = _getDynamicShadows(theme);
    final borderColor = theme?.borderColor;
    final borderWidth = theme?.borderWidth ?? 0.0;
    final backgroundGradient = theme?.backgroundGradient;

    final content = Padding(
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getPresetIcon(theme),
          if (widget.preset != BurntPreset.none || widget.customIcon != null)
            const SizedBox(width: 12),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title, style: titleStyle),
                if (widget.message?.isNotEmpty ?? false)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      widget.message!,
                      style: messageStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );

    final decoration = BoxDecoration(
      color: backgroundGradient == null ? bgColor : null,
      gradient: backgroundGradient,
      borderRadius: borderRadius,
      boxShadow: shadows,
      border: borderWidth > 0 && borderColor != null
          ? Border.all(color: borderColor, width: borderWidth)
          : null,
    );

    return Material(
      type: MaterialType.transparency,
      child: Container(
        decoration: decoration,
        child: content,
      ),
    );
  }
}
