part of '../../burnt_library.dart';

/// Helper for haptic feedback
class HapticHelper {
  static void triggerHaptic(BurntHaptic haptic) {
    switch (haptic) {
      case BurntHaptic.success:
        HapticFeedback.mediumImpact();
      case BurntHaptic.warning:
        HapticFeedback.lightImpact();
      case BurntHaptic.error:
        HapticFeedback.heavyImpact();
      case BurntHaptic.none:
        break;
    }
  }
}
