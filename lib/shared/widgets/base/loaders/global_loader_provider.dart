import 'package:barpass_app/shared/widgets/base/loaders/loader_controller.dart';
import 'package:flutter/widgets.dart';

class GlobalLoaderProvider extends StatefulWidget {
  const GlobalLoaderProvider({
    required this.controller,
    required this.child,
    super.key,
  });

  final LoaderController controller;
  final Widget child;

  /// Método estático para acessar o controller
  static LoaderController of(BuildContext context) {
    final result = context
        .dependOnInheritedWidgetOfExactType<_GlobalLoaderInheritedWidget>();
    assert(result != null, 'No GlobalLoaderProvider found in context');
    return result!.controller;
  }

  @override
  State<GlobalLoaderProvider> createState() => _GlobalLoaderProviderState();
}

class _GlobalLoaderProviderState extends State<GlobalLoaderProvider> {
  @override
  void dispose() {
    widget.controller.dispose(); // ✅ Agora o método existe
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _GlobalLoaderInheritedWidget(
      controller: widget.controller,
      child: widget.child,
    );
  }
}

// InheritedWidget privado, só para gerenciamento interno
class _GlobalLoaderInheritedWidget extends InheritedWidget {
  const _GlobalLoaderInheritedWidget({
    required this.controller,
    required super.child,
  });

  final LoaderController controller;

  @override
  bool updateShouldNotify(_GlobalLoaderInheritedWidget oldWidget) {
    return controller != oldWidget.controller;
  }
}
