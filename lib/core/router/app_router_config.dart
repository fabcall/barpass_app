import 'package:barpass_app/app/presentation/pages/startup_page.dart';
import 'package:barpass_app/features/auth/presentation/pages/landing_page.dart';
import 'package:barpass_app/features/auth/presentation/pages/login_page.dart';
import 'package:barpass_app/features/auth/presentation/pages/password_reset_page.dart';
import 'package:barpass_app/features/auth/presentation/pages/registration_page.dart';
import 'package:barpass_app/features/home/presentation/pages/home_page.dart';
import 'package:barpass_app/features/navigation/presentation/pages/shell_navigation_page.dart';
import 'package:barpass_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:barpass_app/shared/widgets/layout/not_found_page.dart';
import 'package:barpass_app/shared/widgets/layout/sheet_shell.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class AppRouterConfig {
  static List<RouteBase> get routes => [
    // === STARTUP ===
    GoRoute(
      path: '/startup',
      name: 'startup',
      builder: (context, state) => const StartupPage(),
    ),

    // === ONBOARDING ===
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),

    // === LANDING + AUTH MODALS ===
    GoRoute(
      path: '/',
      name: 'landing',
      builder: (context, state) => const LandingPage(),
      routes: [
        ShellRoute(
          pageBuilder: (context, state, child) {
            return ModalSheetPage(
              swipeDismissible: true,
              viewportPadding: EdgeInsets.only(
                top: MediaQuery.viewPaddingOf(context).top,
              ),
              child: SheetShell(navigator: child),
            );
          },
          routes: [
            // Login com sub-rota de reset de senha
            GoRoute(
              path: 'login',
              name: 'login',
              pageBuilder: (context, state) {
                return PagedSheetPage(
                  key: state.pageKey,
                  child: const LoginPage(),
                );
              },
              routes: [
                GoRoute(
                  path: 'password-reset',
                  name: 'password-reset',
                  pageBuilder: (context, state) {
                    return PagedSheetPage(
                      key: state.pageKey,
                      child: const PasswordResetPage(),
                    );
                  },
                ),
              ],
            ),

            // Registro
            GoRoute(
              path: 'registration',
              name: 'registration',
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

    // === MAIN APP NAVIGATION ===
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ShellNavigationPage(navigationShell: navigationShell);
      },
      branches: [
        // Branch 0 - Home
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              name: 'home',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),

        // Branch 1 - Wallet/Conta
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/conta',
              name: 'conta',
              builder: (context, state) => const ContaPage(),
              routes: [
                GoRoute(
                  path: 'transacoes',
                  name: 'transacoes',
                  builder: (context, state) => const TransacoesPage(),
                ),
                GoRoute(
                  path: 'extrato',
                  name: 'extrato',
                  builder: (context, state) => const ExtratoPage(),
                ),
                GoRoute(
                  path: 'cartoes',
                  name: 'cartoes',
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
              path: '/favoritos',
              name: 'favoritos',
              builder: (context, state) => const FavoritosPage(),
              routes: [
                GoRoute(
                  path: 'item/:id',
                  name: 'favorito-item',
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
              path: '/perfil',
              name: 'perfil',
              builder: (context, state) => const PerfilPage(),
              routes: [
                GoRoute(
                  path: 'configuracoes',
                  name: 'configuracoes',
                  builder: (context, state) => const ConfiguracoesPage(),
                ),
                GoRoute(
                  path: 'editar',
                  name: 'editar-perfil',
                  builder: (context, state) => const EditarPerfilPage(),
                ),
                GoRoute(
                  path: 'seguranca',
                  name: 'seguranca',
                  builder: (context, state) => const SegurancaPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),

    // === SPECIAL ROUTES (fora do shell) ===
    GoRoute(
      path: '/qr-scanner',
      name: 'qr-scanner',
      builder: (context, state) => const QRScannerPage(),
    ),

    GoRoute(
      path: '/notifications',
      name: 'notifications',
      builder: (context, state) => const NotificationsPage(),
    ),

    GoRoute(
      path: '/help',
      name: 'help',
      builder: (context, state) => const HelpPage(),
    ),
  ];

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

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPage(
      context,
      title: 'Perfil',
      icon: Icons.person,
      backgroundColor: Colors.purple.shade50,
      actions: [
        ElevatedButton(
          onPressed: () => context.push('/perfil/editar'),
          child: const Text('Editar Perfil'),
        ),
        ElevatedButton(
          onPressed: () => context.push('/perfil/configuracoes'),
          child: const Text('Configurações'),
        ),
        ElevatedButton(
          onPressed: () => context.push('/perfil/seguranca'),
          child: const Text('Segurança'),
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

class QRScannerPage extends StatelessWidget {
  const QRScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner QR'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.qr_code_scanner, size: 100),
            SizedBox(height: 16),
            Text('Scanner de QR Code'),
            Text('Aponte a câmera para o código QR'),
          ],
        ),
      ),
    );
  }
}

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
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Conteúdo da página $title',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
