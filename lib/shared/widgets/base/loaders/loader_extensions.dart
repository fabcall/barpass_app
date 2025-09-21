import 'package:barpass_app/shared/widgets/base/loaders/global_loader_provider.dart';
import 'package:barpass_app/shared/widgets/base/loaders/loader_controller.dart';
import 'package:flutter/widgets.dart';

/// An extension on [BuildContext] to provide convenient access to the global loader functionality.
extension GlobalLoaderExt on BuildContext {
  /// Gets the [LoaderController] instance associated with this [BuildContext].
  ///
  /// The [LoaderController] is obtained using the [GlobalLoaderProvider.of] method.
  LoaderController get loader => GlobalLoaderProvider.of(this);

  /// Shows a loader with the specified [id] and [barrierDismissible] flag.
  ///
  /// If [id] is null, a new loader will be shown. If an [id] is provided,
  /// it must be unique among the currently shown loaders.
  ///
  /// If [barrierDismissible] is true, the loader can be dismissed by tapping
  /// outside of it. Defaults to false.
  ///
  /// This method internally calls the [LoaderController.show] method.
  void showLoader({
    Object? id,
    bool barrierDismissible = false,
  }) {
    loader.show(
      id: id,
      barrierDismissible: barrierDismissible,
    );
  }

  /// Hides the loader with the specified [id].
  ///
  /// If [id] is null, the last shown loader will be hidden. If an [id] is
  /// provided, it must correspond to a currently shown loader.
  ///
  /// This method internally calls the [LoaderController.hide] method.
  void hideLoader({Object? id}) {
    loader.hide(id: id);
  }
}
