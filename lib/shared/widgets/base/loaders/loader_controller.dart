import 'package:barpass_app/shared/widgets/base/loaders/loader_route.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoaderController {
  LoaderController(this._key);

  final GlobalKey<NavigatorState> _key;
  List<LoaderRoute>? _routes = [];
  bool _disposed = false;

  /// Limpa todas as rotas ativas e libera recursos
  void dispose() {
    if (_disposed) return;

    _disposed = true;

    // Remove todas as rotas ativas antes de limpar
    if (_routes != null && _routes!.isNotEmpty) {
      final navigatorState = _key.currentState;
      if (navigatorState != null && navigatorState.mounted) {
        // Remove todas as rotas do loader
        for (final route in _routes!) {
          navigatorState.removeRoute(route);
        }
      }
      _routes!.clear();
      _routes = null;
    }
  }

  bool get _isValid => !_disposed && _key.currentState != null;

  /// Shows a loader with the specified [id] and [barrierDismissible] flag.
  ///
  /// If [id] is null, a new loader will be shown. If an [id] is provided,
  /// it must be unique among the currently shown loaders.
  ///
  /// If [barrierDismissible] is true, the loader can be dismissed by tapping
  /// outside of it. Defaults to false.
  ///
  /// The loader automatically detects the current theme from the context.
  void show({
    Object? id,
    bool barrierDismissible = false,
  }) {
    assert(
      _key.currentState != null,
      'Tried to show dialog but navigatorState was null. Key was: $_key',
    );

    if (!_isValid) {
      debugPrint('LoaderController is disposed or navigator is invalid');
      return;
    }

    final navigatorState = _key.currentState;
    _routes ??= <LoaderRoute>[];

    assert(
      id == null ||
          _routes!.where((element) => element.id == id).toList().isEmpty,
      'There is already a loader showing with id: $id',
    );

    final route = LoaderRoute(
      id: id,
      barrierDismissible: barrierDismissible,
      context: navigatorState!.context,
      pageBuilder: (context, animation, secondaryAnimation) {
        // Detecta o tema atual do context
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;

        return Center(
          child: SizedBox(
            width: 80,
            height: 80,
            child: RiveAnimation.asset(
              'assets/rive-animations/logo-scan.riv',
              fit: BoxFit.contain,
              onInit: (artboard) {
                final controller = StateMachineController.fromArtboard(
                  artboard,
                  'State Machine 1', // Nome da sua State Machine no Rive
                );

                if (controller != null) {
                  artboard.addController(controller);

                  // Encontra o input isDarkMode
                  final isDarkModeInput = controller.findInput<bool>(
                    'isDarkMode',
                  );
                  if (isDarkModeInput != null) {
                    isDarkModeInput.value = isDarkMode;
                  }

                  // Opcionalmente, você pode também controlar o state diretamente
                  // Se preferir usar triggers ao invés de boolean:
                  // final lightTrigger = controller.findInput<bool>('Light State');
                  // final darkTrigger = controller.findInput<bool>('Dark State');
                  // if (!isDarkMode && lightTrigger != null) {
                  //   lightTrigger.fire();
                  // } else if (isDarkMode && darkTrigger != null) {
                  //   darkTrigger.fire();
                  // }
                }
              },
            ),
          ),
        );
      },
    );

    _routes!.add(route);
    navigatorState.push(route);
  }

  /// Hides the loader with the specified [id].
  ///
  /// If [id] is null, the last shown loader will be hidden. If an [id] is
  /// provided, it must correspond to a currently shown loader.
  void hide({Object? id}) {
    if (!_isValid) {
      debugPrint('LoaderController is disposed or navigator is invalid');
      return;
    }

    if (_routes == null) {
      debugPrint('There is no loader to hide');
      return;
    }
    assert(
      id == null ||
          _routes!.where((element) => element.id == id).toList().isNotEmpty,
      'Tried to close loader with id: $id which does not exist',
    );
    assert(
      _key.currentState != null,
      'Tried to hide dialog but navigatorState was null. Key was :$_key',
    );
    final navigatorState = _key.currentState!;
    if (id == null) {
      navigatorState.removeRoute(_routes!.removeLast());
      if (_routes!.isEmpty) {
        _routes = null;
      }
    } else {
      final routeIndex = _routes!.indexWhere((element) => element.id == id);
      navigatorState.removeRoute(_routes!.removeAt(routeIndex));
      if (_routes!.isEmpty) {
        _routes = null;
      }
    }
  }
}
