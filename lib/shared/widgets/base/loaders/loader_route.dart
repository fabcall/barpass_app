import 'dart:ui';

import 'package:flutter/material.dart';

/// A custom route that displays a loader dialog with a blurred background.
class LoaderRoute extends RawDialogRoute<dynamic> {
  LoaderRoute({
    required BuildContext context,
    required super.pageBuilder,
    this.id,
    this.blurSigma = 5.0,
    super.barrierDismissible = false,
    Color barrierColor = const Color(0x4D000000),
    String? barrierLabel,
    super.settings,
  }) : super(
          barrierColor: Colors.transparent,
          barrierLabel: barrierLabel ??
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          transitionDuration: const Duration(milliseconds: 300),
          transitionBuilder: (
            BuildContext buildContext,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return Stack(
              children: [
                Positioned.fill(
                  child: IgnorePointer(
                    child: AnimatedBuilder(
                      animation: animation,
                      builder: (context, _) {
                        return Opacity(
                          opacity: animation.value,
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: blurSigma * animation.value,
                              sigmaY: blurSigma * animation.value,
                            ),
                            child: Container(
                              color: barrierColor.withValues(
                                alpha: barrierColor.a * animation.value,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                FadeTransition(
                  opacity: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                  ),
                  child: child,
                ),
              ],
            );
          },
        );

  /// An optional identifier for the loader route.
  final Object? id;

  /// The sigma value for the blur effect applied to the background.
  final double blurSigma;

  /// Determines the behavior when the user tries to dismiss the route.
  ///
  /// If [barrierDismissible] is true, the route can be popped when the user taps outside the dialog.
  /// If [barrierDismissible] is false, the route cannot be popped by tapping outside the dialog.
  @override
  RoutePopDisposition get popDisposition => barrierDismissible
      ? RoutePopDisposition.pop // Allow pop if barrierDismissible is true
      : RoutePopDisposition.doNotPop; // Prevent pop if false
}
