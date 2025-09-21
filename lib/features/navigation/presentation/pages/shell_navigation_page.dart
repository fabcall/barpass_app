import 'package:barpass_app/core/router/app_routes.dart';
import 'package:barpass_app/core/router/navigation_extension.dart';
import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/features/navigation/presentation/models/bottom_nav_item.dart';
import 'package:barpass_app/features/navigation/presentation/widgets/circular_notched_shape.dart';
import 'package:barpass_app/features/navigation/presentation/widgets/custom_bottom_appbar.dart';
import 'package:barpass_app/features/navigation/presentation/widgets/floating_action_button_widget.dart';
import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

/// Página principal de navegação usando StatefulShellRoute
///
/// Gerencia a navegação entre diferentes seções usando NavigationShell
/// do GoRouter com BottomAppBar customizada e FAB integrado.
class ShellNavigationPage extends StatefulWidget {
  const ShellNavigationPage({
    required this.navigationShell,
    super.key,
  });

  /// Shell de navegação fornecido pelo GoRouter
  final StatefulNavigationShell navigationShell;

  @override
  State<ShellNavigationPage> createState() => _ShellNavigationPageState();
}

class _ShellNavigationPageState extends State<ShellNavigationPage> {
  // Cache dos itens de navegação
  late final List<BottomNavItem> _navItems;

  // Mapeamento de rotas para índices
  static final Map<String, int> _routeToIndex = {
    AppRoute.home.path: 0,
    AppRoute.conta.path: 1,
    AppRoute.favoritos.path: 2,
    AppRoute.profile.path: 3,
  };

  @override
  void initState() {
    super.initState();
    _navItems = _createNavItems();

    // Debug: verificar estado inicial
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Force rebuild if there's mismatch
      if (_shouldForceCorrection()) {
        setState(() {});
      }
    });
  }

  /// Cria a lista de itens de navegação
  List<BottomNavItem> _createNavItems() {
    return const [
      BottomNavItem(
        iconData: Icons.home_outlined,
        label: 'Home',
        index: 0,
        semanticLabel: 'Página inicial',
      ),
      BottomNavItem(
        iconData: Icons.account_balance_wallet_outlined,
        label: 'Conta',
        index: 1,
        semanticLabel: 'Minha conta',
      ),
      BottomNavItem(
        iconData: Icons.favorite_outline,
        label: 'Favoritos',
        index: 2,
        semanticLabel: 'Itens favoritos',
      ),
      BottomNavItem(
        iconData: Icons.person_outline,
        label: 'Perfil',
        index: 3,
        semanticLabel: 'Meu perfil',
      ),
    ];
  }

  /// Obtém o índice correto baseado na rota atual
  int _getIndexForCurrentRoute() {
    if (!mounted) return 0;

    try {
      final currentRoute = GoRouterState.of(context).uri.path;

      // Encontra a rota base (ignora sub-rotas)
      for (final entry in _routeToIndex.entries) {
        if (currentRoute.startsWith(entry.key)) {
          return entry.value;
        }
      }

      return 0;
    } on Exception catch (_) {
      return 0;
    }
  }

  /// Verifica se precisa forçar correção do índice
  bool _shouldForceCorrection() {
    final expectedIndex = _getIndexForCurrentRoute();
    final currentIndex = widget.navigationShell.currentIndex;
    return expectedIndex != currentIndex;
  }

  /// Obtém o índice efetivo para exibição
  int get _effectiveSelectedIndex {
    final shellIndex = widget.navigationShell.currentIndex;
    final routeIndex = _getIndexForCurrentRoute();

    // Se há discrepância, usa o índice da rota
    if (shellIndex != routeIndex) {
      return routeIndex;
    }

    return shellIndex;
  }

  /// Manipula a seleção de itens na navegação
  void _onItemSelected(int index) {
    // Valida se o índice é válido
    if (index < 0 || index >= _navItems.length) {
      return;
    }

    final item = _navItems[index];
    if (!item.isEnabled) {
      return;
    }

    // Mapeamento de índice para rota
    final routes = [
      AppRoute.home.path,
      AppRoute.conta.path,
      AppRoute.favoritos.path,
      AppRoute.profile.path,
    ];
    final targetRoute = routes[index];

    try {
      // Usa o NavigationShell para navegar
      widget.navigationShell.goBranch(
        index,
        // Mantém o estado da branch se já estiver selecionada
        initialLocation: index == widget.navigationShell.currentIndex,
      );
    } on Exception catch (_) {
      // Fallback: usar context.go
      context.go(targetRoute);
    }
  }

  /// Manipula o pressionamento do FAB
  Future<void> _onFabPressed() async {
    try {
      HapticFeedback.mediumImpact();

      final flowResult = await context.navigate.modal.pushQRScanner();

      if (mounted && flowResult is bool && flowResult == true) {
        await context.navigate.review.pushCreateReview(
          establishmentId: 'some-id',
          orderId: 'some-order-id',
        );
      } else {}
    } on Exception catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _effectiveSelectedIndex;

    return Scaffold(
      extendBody: true,
      // O body é fornecido pelo NavigationShell
      body: widget.navigationShell,
      floatingActionButton: FloatingActionButtonWidget(
        onPressed: _onFabPressed,
        tooltip: 'Escanear QR Code',
        icon: const Icon(Icons.qr_code_scanner),
      ),
      floatingActionButtonLocation: const CenterDockedFabLocation(),
      bottomNavigationBar: CustomBottomAppBar(
        items: _navItems,
        selectedIndex: selectedIndex,
        onItemSelected: _onItemSelected,
        backgroundColor: context.colorScheme.surfaceContainer,
        selectedColor: context.colorScheme.onSurface,
        unselectedColor: Colors.grey,
        height: AppSpacing.responsiveBottomNavHeight(context),
        notchedShape: const CircularNotchedShape(),
        shadowColor: context.colorScheme.shadow,
      ),
    );
  }
}
