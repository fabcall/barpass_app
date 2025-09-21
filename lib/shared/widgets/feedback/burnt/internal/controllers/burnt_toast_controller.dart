part of '../../burnt_library.dart'; // Alterado de 'burnt.dart'

/// Allows for programmatic control over an individual toast displayed by [Burnt].
///
/// This controller is returned by the `Burnt().toast()` method and can be used
/// to dismiss the toast or manage its auto-dismiss timer.
class BurntToastController {
  // Internal key to identify the toast within the Burnt service.
  // The constructor is private and only called by Burnt.
  BurntToastController._(this._key);
  final GlobalKey<_BurntToastWidgetState> _key;

  /// Dismisses the associated toast with an animation.
  void dismiss() {
    Burnt().dismiss(_key);
  }

  /// Dismisses the associated toast immediately, without an animation.
  void dismissImmediately() {
    Burnt().dismissImmediately(_key);
  }

  /// Pauses the auto-dismiss timer of the toast.
  /// Has no effect if the toast's duration is [BurntDuration.infinite].
  /// Also pauses the progress bar animation if enabled.
  void pauseTimer() {
    Burnt().cancelTimer(_key);
  }

  /// Resumes (or starts) the auto-dismiss timer of the toast, if applicable.
  /// Has no effect if the toast's duration is [BurntDuration.infinite].
  /// Also resumes the progress bar animation if enabled.
  void resumeTimer() {
    Burnt().restartTimerIfNecessary(_key);
  }

  /// Checks if the toast is currently visible (not dismissed).
  bool get isVisible {
    return Burnt()._activeToasts.containsKey(_key);
  }

  /// Checks if the toast is currently being dismissed.
  bool get isDismissing {
    return Burnt()._pendingDismissalToasts.contains(_key);
  }
}
