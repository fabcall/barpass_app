import 'dart:async';

import 'package:flutter/widgets.dart';

typedef TimerWidgetBuilder =
    Widget Function(BuildContext context, int remainingSeconds, bool isActive);

class TimerBuilderController {
  // --- Internal Callbacks ---
  // These fields will store the actual methods from _TimerBuilderState.
  VoidCallback? _internalStartCallback;
  VoidCallback? _internalRestartCallback;

  // --- Library-Private Setters ---
  // These setters are used by _TimerBuilderState to provide its methods
  // to this controller. They are not meant for public use by the end-developer
  // using the TimerBuilder widget.

  /// Allows `_TimerBuilderState` to assign its method to be called when `start()` is invoked.
  /// This should only be accessed from within the same library (e.g., the file
  /// containing TimerBuilder and _TimerBuilderState).
  set _startCallback(VoidCallback callback) {
    _internalStartCallback = callback;
  }

  /// Allows `_TimerBuilderState` to assign its method to be called when `restart()` is invoked.
  /// This should only be accessed from within the same library.
  set _restartCallback(VoidCallback callback) {
    _internalRestartCallback = callback;
  }

  // --- Public API Methods ---
  // These are the methods the end-developer will call on their controller instance.

  /// Requests the associated `TimerBuilder` to start its countdown.
  /// If the timer is already running, this might be a no-op or restart,
  /// depending on the `_TimerBuilderState`'s `_startTimer()` implementation.
  /// (Our current `_startTimer` implementation resets and starts).
  void start() {
    _internalStartCallback?.call();
  }

  /// Requests the associated `TimerBuilder` to restart its countdown from the
  /// beginning of its specified duration.
  void restart() {
    _internalRestartCallback?.call();
  }

  // --- Dispose Method ---
  // It's good practice for controllers to have a dispose method to clear
  // listeners or resources if they hold any that need explicit cleanup.

  /// Clears internal callback references.
  /// Call this when the controller is no longer needed, typically in the
  /// `dispose` method of the StatefulWidget that owns this controller.
  void dispose() {
    _internalStartCallback = null;
    _internalRestartCallback = null;
    // If you had any StreamSubscriptions or other resources, clean them here.
  }
}

/// A widget that manages a countdown timer and uses a builder function
/// to construct its UI based on the timer's current state.
class TimerBuilder extends StatefulWidget {
  const TimerBuilder({
    required this.duration,
    required this.builder,
    super.key,
    this.onTimerEnd,
    this.controller,
    this.autoStart = true,
  });

  /// The total duration for the countdown.
  final Duration duration;

  /// The builder function that will be called to build the widget's UI.
  final TimerWidgetBuilder builder;

  /// An optional callback that is triggered when the timer reaches zero.
  final VoidCallback? onTimerEnd;

  /// An optional controller to programmatically start or restart the timer.
  final TimerBuilderController? controller;

  /// Whether the timer should start automatically when the widget is initialized.
  /// Defaults to `true`. If `false`, the timer can be started using the [controller].
  final bool autoStart;

  @override
  State<TimerBuilder> createState() => _TimerBuilderState();
}

class _TimerBuilderState extends State<TimerBuilder> {
  Timer? _timer;
  late int _remainingSeconds;
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.duration.inSeconds;
    _setupController();

    if (widget.autoStart) {
      _startTimer();
    }
  }

  @override
  void didUpdateWidget(covariant TimerBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      _clearControllerSetup(oldWidget.controller);
      _setupController();
    }

    // If the duration changes, reset the timer.
    // You might want more sophisticated logic here, e.g., only if timer is not active,
    // or pause and update, etc. This version resets and restarts if it was active or autoStart.
    if (widget.duration != oldWidget.duration) {
      _timer?.cancel();
      _remainingSeconds = widget.duration.inSeconds;
      _isActive = false; // Reset active state before deciding to restart
      if (widget.autoStart || (_timer != null && _timer!.isActive)) {
        // Check previous timer's active state or autoStart
        _startTimer();
      } else {
        // If not auto-starting and was not active, ensure UI reflects initial state
        if (mounted) {
          setState(() {});
        }
      }
    }
  }

  void _setupController() {
    widget.controller?._startCallback = _startTimerFromController;
    widget.controller?._restartCallback = _restartTimerFromController;
  }

  void _clearControllerSetup(TimerBuilderController? oldController) {
    // In this simple setup where setters just overwrite, explicitly nulling out
    // isn't strictly necessary if the old controller is disposed and a new one is provided.
    // However, if the controller instance could be shared or managed externally in complex ways,
    // unregistering might be important. For our current controller, its dispose handles clearing.
    // oldController?._startCallback = null; // Example if explicit un-assignment was needed
    // oldController?._restartCallback = null;
  }

  void _startTimer() {
    if (_isActive && _timer != null && _timer!.isActive) {
      // If already active and timer is running, decide if restart or no-op
      // For simplicity, let's make _startTimer always reset to full duration
    }

    _timer?.cancel(); // Cancel any existing timer before starting a new one
    _remainingSeconds = widget.duration.inSeconds;
    _isActive = true;

    // Ensure UI updates immediately if `setState` is called before the first tick
    if (mounted) {
      setState(() {});
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_remainingSeconds == 0) {
        timer.cancel();
        _isActive = false;
        widget.onTimerEnd?.call();
        if (mounted) {
          setState(() {});
        }
      } else {
        _remainingSeconds--;
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  // Wrapper for controller to ensure full reset
  void _startTimerFromController() {
    _startTimer(); // Our _startTimer already resets duration and starts
  }

  void _restartTimerFromController() {
    _timer?.cancel(); // Stop existing timer
    // _remainingSeconds is reset within _startTimer
    _startTimer(); // Start a new timer which resets duration
  }

  @override
  void dispose() {
    _timer?.cancel();
    // The controller's own dispose method should be called by whomever created/owns the controller.
    // The widget doesn't "own" the controller passed to it, so it shouldn't dispose it here.
    // However, if the widget *created* the controller internally, it should dispose it.
    // _clearControllerSetup(widget.controller); // Not strictly needed due to controller's own dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _remainingSeconds, _isActive);
  }
}
