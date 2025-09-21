import 'package:barpass_app/app/presentation/pages/startup_page.dart';
import 'package:barpass_app/core/router/app_routes.dart';
import 'package:barpass_app/features/auth/presentation/pages/landing_page.dart';
import 'package:barpass_app/features/auth/presentation/pages/login_page.dart';
import 'package:barpass_app/features/auth/presentation/pages/password_reset_page.dart';
import 'package:barpass_app/features/auth/presentation/pages/registration_page.dart';
import 'package:barpass_app/features/checkout/presentation/pages/qr_scanner_page.dart';
import 'package:barpass_app/features/establishments/presentation/pages/establishment_detail_page.dart';
import 'package:barpass_app/features/home/presentation/pages/home_page.dart';
import 'package:barpass_app/features/navigation/presentation/pages/shell_navigation_page.dart';
import 'package:barpass_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:barpass_app/features/profile/presentation/pages/profile_page.dart';
import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:barpass_app/shared/widgets/layout/not_found_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class AppRouterConfig {
  static List<RouteBase> get routes => [
    // === STARTUP ===
    GoRoute(
      path: AppRoutes.startup.path,
      name: AppRoutes.startup.name,
      builder: (context, state) => const StartupPage(),
    ),

    // === ONBOARDING ===
    GoRoute(
      path: AppRoutes.onboarding.path,
      name: AppRoutes.onboarding.name,
      builder: (context, state) => const OnboardingPage(),
    ),

    // === LANDING + AUTH MODALS ===
    GoRoute(
      path: AppRoutes.landing.path,
      name: AppRoutes.landing.name,
      builder: (context, state) => const LandingPage(),
      routes: [
        ShellRoute(
          pageBuilder: (context, state, navigator) {
            return _buildAuthModalShell(context, navigator);
          },
          routes: [
            // Login modal na landing
            GoRoute(
              path: AppRoutes.login.path,
              name: AppRoutes.login.name,
              pageBuilder: (context, state) {
                return PagedSheetPage(
                  key: state.pageKey,
                  child: const LoginPage(),
                );
              },
              routes: [
                GoRoute(
                  path: AppRoutes.passwordReset.path,
                  name: AppRoutes.passwordReset.name,
                  pageBuilder: (context, state) {
                    return PagedSheetPage(
                      key: state.pageKey,
                      child: const PasswordResetPage(),
                    );
                  },
                ),
              ],
            ),
            // Registro modal na landing
            GoRoute(
              path: AppRoutes.registration.path,
              name: AppRoutes.registration.name,
              pageBuilder: (context, state) {
                return PagedSheetPage(
                  key: state.pageKey,
                  child: const RegistrationPage(),
                );
              },
            ),
          ],
        ),
      ],
    ),

    // === PÁGINA DE DETALHES DO ESTABELECIMENTO (INDEPENDENTE - SEM TABBAR) ===
    GoRoute(
      path: AppRoutes.establishmentDetails.path, // '/establishment/:id'
      name: AppRoutes.establishmentDetails.name, // 'establishment_details'
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return EstablishmentDetailPage(establishmentId: id);
      },
    ),

    // QR Scanner modal
    GoRoute(
      path: AppRoutes.qrScanner.path,
      name: AppRoutes.qrScanner.name,
      pageBuilder: (context, state) {
        return ModalSheetPage(
          swipeDismissible: true,
          viewportPadding: EdgeInsets.only(
            top: context.viewPadding.top,
          ),
          child: Sheet(
            decoration: _getModalDecoration(context),
            child: const QRScannerPage(),
          ),
        );
      },
    ),

    // === MAIN APP NAVIGATION (COM TABBAR) ===
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ShellNavigationPage(navigationShell: navigationShell);
      },
      branches: [
        // Branch 0 - Home (SEM sub-rota de detalhes)
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home.path, // '/home'
              name: AppRoutes.home.name, // 'home'
              builder: (context, state) => const HomePage(),
              // REMOVIDO: routes com detalhes - agora é rota independente
            ),
          ],
        ),

        // Branch 1 - Conta
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.conta.path, // '/conta'
              name: AppRoutes.conta.name, // 'conta'
              builder: (context, state) => const ContaPage(),
              routes: [
                GoRoute(
                  path: AppRoutes.transacoes.path, // 'transacoes'
                  name: AppRoutes.transacoes.name, // 'transacoes'
                  builder: (context, state) => const TransacoesPage(),
                ),
                GoRoute(
                  path: AppRoutes.extrato.path, // 'extrato'
                  name: AppRoutes.extrato.name, // 'extrato'
                  builder: (context, state) => const ExtratoPage(),
                ),
                GoRoute(
                  path: AppRoutes.cartoes.path, // 'cartoes'
                  name: AppRoutes.cartoes.name, // 'cartoes'
                  builder: (context, state) => const CartoesPage(),
                ),
              ],
            ),
          ],
        ),

        // Branch 2 - Favoritos
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.favoritos.path, // '/favoritos'
              name: AppRoutes.favoritos.name, // 'favoritos'
              builder: (context, state) => const FavoritosPage(),
              routes: [
                GoRoute(
                  path: AppRoutes.favoritoItem.path, // 'item/:id'
                  name: AppRoutes.favoritoItem.name, // 'favorito-item'
                  builder: (context, state) {
                    final id = state.pathParameters['id']!;
                    return FavoritoItemPage(id: id);
                  },
                ),
              ],
            ),
          ],
        ),

        // Branch 3 - Perfil
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.perfil.path, // '/perfil'
              name: AppRoutes.perfil.name, // 'perfil'
              builder: (context, state) => const ProfilePage(),
              routes: [
                GoRoute(
                  path: AppRoutes.configuracoes.path, // 'configuracoes'
                  name: AppRoutes.configuracoes.name, // 'configuracoes'
                  builder: (context, state) => const ConfiguracoesPage(),
                ),
                GoRoute(
                  path: AppRoutes.editarPerfil.path, // 'editar'
                  name: AppRoutes.editarPerfil.name, // 'editar-perfil'
                  builder: (context, state) => const EditarPerfilPage(),
                ),
                GoRoute(
                  path: AppRoutes.seguranca.path, // 'seguranca'
                  name: AppRoutes.seguranca.name, // 'seguranca'
                  builder: (context, state) => const SegurancaPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),

    // === OUTRAS ROTAS ESPECIAIS (fora do shell - sem TabBar) ===
    GoRoute(
      path: AppRoutes.notifications.path, // '/notifications'
      name: AppRoutes.notifications.name, // 'notifications'
      builder: (context, state) => const NotificationsPage(),
    ),

    GoRoute(
      path: AppRoutes.help.path, // '/help'
      name: AppRoutes.help.name, // 'help'
      builder: (context, state) => const HelpPage(),
    ),
  ];

  // === HELPERS ===

  static ModalSheetPage<void> _buildAuthModalShell(
    BuildContext context,
    Widget navigator,
  ) {
    return ModalSheetPage(
      swipeDismissible: true,
      viewportPadding: EdgeInsets.only(
        top: context.viewPadding.top,
      ),
      child: PagedSheet(
        decoration: _getModalDecoration(context),
        builder: (context, child) {
          return SheetContentScaffold(body: child);
        },
        navigator: navigator,
      ),
    );
  }

  static MaterialSheetDecoration _getModalDecoration(BuildContext context) {
    return MaterialSheetDecoration(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      color: context.colorScheme.surface,
      size: SheetSize.fit,
    );
  }

  static Widget errorBuilder(BuildContext context, GoRouterState state) {
    return const NotFoundPage();
  }
}

// === PÁGINAS TEMPORÁRIAS ===
// Substitua estas por suas páginas reais quando estiverem prontas

class ContaPage extends StatelessWidget {
  const ContaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPage(
      context,
      title: 'Conta',
      icon: Icons.account_balance_wallet,
      backgroundColor: Colors.green.shade50,
      actions: [
        ElevatedButton(
          onPressed: () => context.push('/conta/transacoes'),
          child: const Text('Transações'),
        ),
        ElevatedButton(
          onPressed: () => context.push('/conta/extrato'),
          child: const Text('Extrato'),
        ),
        ElevatedButton(
          onPressed: () => context.push('/conta/cartoes'),
          child: const Text('Cartões'),
        ),
      ],
    );
  }
}

class FavoritosPage extends StatelessWidget {
  const FavoritosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPage(
      context,
      title: 'Favoritos',
      icon: Icons.favorite,
      backgroundColor: Colors.red.shade50,
      actions: [
        ElevatedButton(
          onPressed: () => context.push('/favoritos/item/456'),
          child: const Text('Ver Item Favorito'),
        ),
      ],
    );
  }
}

// === PÁGINAS DE SEGUNDO NÍVEL ===

class TransacoesPage extends StatelessWidget {
  const TransacoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transações')),
      body: const Center(child: Text('Lista de transações')),
    );
  }
}

class ExtratoPage extends StatelessWidget {
  const ExtratoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Extrato')),
      body: const Center(child: Text('Extrato da conta')),
    );
  }
}

class CartoesPage extends StatelessWidget {
  const CartoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cartões')),
      body: const Center(child: Text('Gerenciar cartões')),
    );
  }
}

class FavoritoItemPage extends StatelessWidget {
  const FavoritoItemPage({required this.id, super.key});
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorito $id')),
      body: Center(child: Text('Detalhes do favorito $id')),
    );
  }
}

class ConfiguracoesPage extends StatelessWidget {
  const ConfiguracoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),
      body: const Center(child: Text('Configurações do perfil')),
    );
  }
}

class EditarPerfilPage extends StatelessWidget {
  const EditarPerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Perfil')),
      body: const Center(child: Text('Formulário de edição')),
    );
  }
}

class SegurancaPage extends StatelessWidget {
  const SegurancaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Segurança')),
      body: const Center(child: Text('Configurações de segurança')),
    );
  }
}

// === PÁGINAS ESPECIAIS ===

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notificações')),
      body: const Center(child: Text('Lista de notificações')),
    );
  }
}

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajuda')),
      body: const Center(child: Text('Central de ajuda')),
    );
  }
}

// === HELPER PARA PÁGINAS DE DEMONSTRAÇÃO ===

Widget _buildPage(
  BuildContext context, {
  required String title,
  required IconData icon,
  required Color backgroundColor,
  List<Widget> actions = const [],
}) {
  return Container(
    color: backgroundColor,
    child: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: Colors.grey.shade600,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: context.textTheme.headlineMedium?.copyWith(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Conteúdo da página $title',
              style: context.textTheme.bodyLarge?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            if (actions.isNotEmpty) ...[
              const SizedBox(height: 24),
              ...actions.map(
                (action) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: action,
                ),
              ),
            ],
          ],
        ),
      ),
    ),
  );
}
