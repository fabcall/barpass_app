part of '../burnt_library.dart';

// --- Burnt Service (Singleton Manager) ---

/// Manages the display and lifecycle of Burnt toasts.
///
/// Access the singleton instance via `Burnt()`.
class Burnt {
  // --- Singleton Pattern ---
  factory Burnt() => _instance;
  Burnt._internal();
  static final Burnt _instance = Burnt._internal();

  // --- State ---
  // List of active toasts, maintaining insertion order for LIFO visual stacking.
  final LinkedHashMap<GlobalKey<_BurntToastWidgetState>, _ToastData>
  _activeToasts =
      LinkedHashMap<GlobalKey<_BurntToastWidgetState>, _ToastData>();

  // Set to track toasts currently undergoing their dismiss animation.
  final Set<GlobalKey<_BurntToastWidgetState>> _pendingDismissalToasts = {};

  // Timers for auto-dismissing toasts.
  final Map<GlobalKey<_BurntToastWidgetState>, Timer> _dismissTimers = {};

  // --- Configuration ---
  int _maxStack = BurntConstants
      .defaultMaxStack; // Default maximum number of toasts visible simultaneously.
  double _stackGap = BurntConstants
      .defaultStackGap; // Default vertical space between stacked toasts.

  /// Configures the global behavior of the Burnt toast system.
  ///
  /// [maxStack]: The maximum number of toasts that can be displayed at once.
  ///             Must be greater than 0. Defaults to [BurntConstants.defaultMaxStack].
  /// [stackGap]: The vertical spacing between toasts when they are stacked.
  ///             Must be non-negative. Defaults to [BurntConstants.defaultStackGap].
  void configure({
    int? maxStack,
    double? stackGap,
  }) {
    if (maxStack != null && maxStack > 0) {
      _maxStack = maxStack;
    }
    if (stackGap != null && stackGap >= 0) {
      _stackGap = stackGap;
    }
  }

  // --- Public API ---

  /// Displays a new toast notification.
  ///
  /// [context]: The `BuildContext` used to find the [Overlay] for displaying the toast.
  /// [title]: The main text content of the toast.
  /// [message]: Optional secondary text content displayed below the title.
  /// [preset]: The visual preset for the toast (e.g., success, error). Defaults to [BurntPreset.none].
  /// [duration]: How long the toast should be visible. Defaults to [BurntDuration.short].
  /// [haptic]: The type of haptic feedback to trigger. Defaults to [BurntHaptic.none].
  /// [customIcon]: An optional widget to use as the icon, overriding the preset icon.
  /// [dismissible]: Whether the toast can be dismissed by a swipe gesture. Defaults to `true`.
  /// [onTap]: Callback when the toast is tapped.
  /// [onDismiss]: Callback when the toast is dismissed.
  ///
  /// Returns a [BurntToastController] to manage the displayed toast.
  BurntToastController toast(
    BuildContext context, {
    required String title,
    String? message,
    BurntPreset preset = BurntPreset.none,
    BurntDuration duration = BurntDuration.short,
    BurntHaptic haptic = BurntHaptic.none,
    Widget? customIcon,
    bool dismissible = true,
    VoidCallback? onTap,
    VoidCallback? onDismiss,
  }) {
    HapticHelper.triggerHaptic(haptic);

    final toastData = _ToastData(
      title: title,
      message: message,
      preset: preset,
      duration: duration,
      haptic: haptic,
      customIcon: customIcon,
      dismissible: dismissible,
      onTap: onTap,
      onDismiss: onDismiss,
    );

    final controller = BurntToastController._(toastData.key);

    _manageToastStackBeforeAdding();
    _addToastToOverlay(context, toastData);

    return controller;
  }

  /// Dismisses a specific toast with an animation.
  /// If [key] is null, all active toasts will be dismissed.
  void dismiss([GlobalKey<_BurntToastWidgetState>? key]) {
    if (key != null && _activeToasts.containsKey(key)) {
      _initiateDismissal(key);
    } else if (key == null && _activeToasts.isNotEmpty) {
      // Dismiss all active toasts
      final keys = _activeToasts.keys.toList(); // Avoid concurrent modification
      for (final k in keys) {
        _initiateDismissal(k);
      }
    }
  }

  /// Dismisses a specific toast immediately, without animation.
  /// If [key] is null, all active toasts will be dismissed immediately.
  void dismissImmediately([GlobalKey<_BurntToastWidgetState>? key]) {
    if (key != null) {
      _removeToastImmediately(key);
    } else {
      // Dismiss all immediately
      final keys = _activeToasts.keys.toList(); // Avoid concurrent modification
      for (final k in keys) {
        _removeToastImmediately(k);
      }
    }
  }

  /// Pauses the auto-dismiss timer for a specific toast.
  /// Internal use, exposed via [BurntToastController].
  void cancelTimer(GlobalKey<_BurntToastWidgetState>? key) {
    if (key != null) {
      _dismissTimers[key]?.cancel();
    }
  }

  /// Restarts the auto-dismiss timer for a specific toast if its duration is not infinite.
  /// Internal use, exposed via [BurntToastController].
  void restartTimerIfNecessary(GlobalKey<_BurntToastWidgetState> key) {
    final toastData = _activeToasts[key];
    if (toastData != null && toastData.duration != BurntDuration.infinite) {
      _startTimerIfNeeded(toastData);
    }
  }

  // --- Internal Helper Methods ---

  /// Manages the toast stack, dismissing the oldest toast if the max stack size is reached.
  void _manageToastStackBeforeAdding() {
    var effectiveActiveCount =
        _activeToasts.length - _pendingDismissalToasts.length;

    while (effectiveActiveCount >= _maxStack && _activeToasts.isNotEmpty) {
      GlobalKey<_BurntToastWidgetState>? oldestKeyToDismiss;
      for (final key in _activeToasts.keys) {
        if (!_pendingDismissalToasts.contains(key)) {
          oldestKeyToDismiss = key;
          break;
        }
      }

      if (oldestKeyToDismiss != null) {
        _initiateDismissal(oldestKeyToDismiss);
        effectiveActiveCount--;
      } else {
        // All toasts are already pending dismissal, break loop
        break;
      }
    }
  }

  /// Adds the toast widget to the screen via [Overlay].
  void _addToastToOverlay(BuildContext context, _ToastData toastData) {
    final overlay = Overlay.maybeOf(context);
    if (overlay == null) {
      if (kDebugMode) {
        print(
          'Burnt Error: Could not find Overlay in the context. Toast not shown.',
        );
      }
      return;
    }

    toastData.overlayEntry = OverlayEntry(
      builder: (context) => _BurntToastWidget(
        key: toastData.key,
        title: toastData.title,
        message: toastData.message,
        preset: toastData.preset,
        customIcon: toastData.customIcon,
        dismissible: toastData.dismissible,
        duration: toastData.duration,
        onTap: toastData.onTap,
        onDismissed: () => _handleToastWidgetDismissed(toastData.key),
        stackIndex: 0, // Will be updated by _updateStackPositions
        stackGap: _stackGap,
      ),
    );

    overlay.insert(toastData.overlayEntry!);
    _activeToasts[toastData.key] = toastData;

    _updateAllToastStackPositions();
    _startTimerIfNeeded(toastData);
  }

  /// Starts the auto-dismiss timer for a toast if its duration is not infinite.
  void _startTimerIfNeeded(_ToastData toastData) {
    _dismissTimers[toastData.key]?.cancel(); // Cancel any existing timer

    if (toastData.duration != BurntDuration.infinite) {
      final displayDuration = toastData.duration == BurntDuration.long
          ? const Duration(seconds: 5)
          : const Duration(seconds: 3);

      _dismissTimers[toastData.key] = Timer(displayDuration, () {
        dismiss(toastData.key); // Use the public dismiss method
      });
    }
  }

  /// Initiates the dismissal process for a toast (triggers animation).
  void _initiateDismissal(GlobalKey<_BurntToastWidgetState> key) {
    if (!_activeToasts.containsKey(key) ||
        _pendingDismissalToasts.contains(key)) {
      return; // Already dismissing or doesn't exist
    }

    _pendingDismissalToasts.add(key);
    _dismissTimers[key]?.cancel();
    _dismissTimers.remove(key);

    // The widget itself will call onDismissed -> _handleToastWidgetDismissed
    // once its animation completes.
    key.currentState?.animateDismiss();
  }

  /// Handles the final removal of a toast after its dismiss animation.
  void _handleToastWidgetDismissed(GlobalKey<_BurntToastWidgetState> key) {
    final toastData = _activeToasts.remove(key);
    _pendingDismissalToasts.remove(key);

    // Call the onDismiss callback if provided
    toastData?.onDismiss?.call();

    toastData?.overlayEntry?.remove();

    // Ensure timer is cleaned up, though it should be by _initiateDismissal
    _dismissTimers[key]?.cancel();
    _dismissTimers.remove(key);

    _updateAllToastStackPositions();
  }

  /// Removes a toast immediately from the overlay and internal tracking.
  void _removeToastImmediately(GlobalKey<_BurntToastWidgetState> key) {
    _dismissTimers[key]?.cancel();
    _dismissTimers.remove(key);

    final toastData = _activeToasts.remove(key);
    _pendingDismissalToasts.remove(key);

    // Call the onDismiss callback if provided
    toastData?.onDismiss?.call();

    toastData?.overlayEntry?.remove();
    _updateAllToastStackPositions();
  }

  /// Recalculates and triggers updates for the visual stack position of all active toasts.
  /// The newest toast gets stackIndex 0.
  void _updateAllToastStackPositions() {
    final activeKeys = _activeToasts.keys
        .where((k) => !_pendingDismissalToasts.contains(k))
        .toList();

    for (var i = 0; i < activeKeys.length; i++) {
      final key = activeKeys[i];
      // Visual index: 0 for the newest (bottom of the list, top of stack), N-1 for the oldest
      final visualIndex = activeKeys.length - 1 - i;
      _activeToasts[key]?.key.currentState?.updateStackPosition(
        visualIndex,
        _stackGap,
      );
    }
  }
}

// --- Internal Data Model ---

/// Internal data structure to hold information about a single toast.
class _ToastData {
  _ToastData({
    required this.title,
    required this.preset,
    required this.duration,
    required this.haptic,
    required this.dismissible,
    this.message,
    this.customIcon,
    this.onTap,
    this.onDismiss,
  }) : key = GlobalKey<_BurntToastWidgetState>(),
       createdAt = DateTime.now();

  final GlobalKey<_BurntToastWidgetState> key;
  final String title;
  final String? message;
  final BurntPreset preset;
  final BurntDuration duration;
  final BurntHaptic haptic;
  final Widget? customIcon;
  final bool dismissible;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss;
  final DateTime createdAt;
  OverlayEntry? overlayEntry;
}
