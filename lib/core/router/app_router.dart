import 'package:barpass_app/core/providers/onboarding_providers.dart';
import 'package:barpass_app/core/router/app_routes.dart';
import 'package:barpass_app/core/widgets/sheet_shell.dart';
import 'package:barpass_app/core/widgets/startup_page.dart';
import 'package:barpass_app/features/auth/views/landing_page.dart';
import 'package:barpass_app/features/auth/views/login_page.dart';
import 'package:barpass_app/features/auth/views/password_reset_page.dart';
import 'package:barpass_app/features/auth/views/registration_page.dart';
import 'package:barpass_app/features/home/views/home_page.dart';
import 'package:barpass_app/features/navigation/views/shell_navigation_page.dart';
import 'package:barpass_app/features/onboarding/views/onboarding_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

/// Notifier para refresh do router
class RouterRefreshNotifier extends ChangeNotifier {
  RouterRefreshNotifier(this._ref) {
    // Escutar mudanças no onboarding provider
    _ref.listen(onboardingProvider, (previous, next) {
      // Notificar o router que precisa recalcular as rotas
      notifyListeners();
    });
  }

  final Ref _ref;
}

/// Configuração centralizada de rotas com onboarding integrado
class AppRouter {
  static GoRouter getRouter(Ref ref) {
    return GoRouter(
      initialLocation: AppRoutes.startup.path,
      debugLogDiagnostics: kDebugMode,

      // refreshListenable para reatividade
      refreshListenable: RouterRefreshNotifier(ref),

      redirect: (context, state) {
        final onboardingState = ref.read(onboardingProvider);
        final location = state.matchedLocation;

        // MUDANÇA CHAVE: Só redireciona para startup se realmente não inicializou ainda
        if (!onboardingState.isInitialized) {
          if (location != AppRoutes.startup.path) {
            return AppRoutes.startup.path;
          }
          return null; // Já está na startup
        }

        // Estado inicializado - verificar onboarding
        if (!onboardingState.isCompleted) {
          // Se não completou onboarding e não está na página de onboarding
          if (location != AppRoutes.onboarding.path) {
            return AppRoutes.onboarding.path;
          }
          return null; // Já está no onboarding
        }

        // Onboarding completado - redirecionar das páginas de setup
        if (onboardingState.isCompleted) {
          if (AppRoutes.isSetupRoute(location)) {
            return AppRoutes.landing.path; // Ir para landing
          }
        }

        return null; // Continua com a rota normal
      },

      routes: [
        // === STARTUP LOADING ===
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

        // === LANDING PAGE COM MODAL SHEETS PARA AUTH ===
        GoRoute(
          path: AppRoutes.landing.path,
          name: AppRoutes.landing.name,
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

                // Registro
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

        // === NAVEGAÇÃO PRINCIPAL COM SHELL ===
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return ShellNavigationPage(navigationShell: navigationShell);
          },
          branches: [
            // Branch 0 - Home
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.home.path,
                  name: AppRoutes.home.name,
                  builder: (context, state) => const HomePage(),
                ),
              ],
            ),

            // Branch 1 - Conta/Wallet
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.conta.path,
                  name: AppRoutes.conta.name,
                  builder: (context, state) => const ContaPage(),
                  routes: [
                    GoRoute(
                      path: AppRoutes.transacoes.path,
                      name: AppRoutes.transacoes.name,
                      builder: (context, state) => const TransacoesPage(),
                    ),
                    GoRoute(
                      path: AppRoutes.extrato.path,
                      name: AppRoutes.extrato.name,
                      builder: (context, state) => const ExtratoPage(),
                    ),
                    GoRoute(
                      path: AppRoutes.cartoes.path,
                      name: AppRoutes.cartoes.name,
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
                  path: AppRoutes.favoritos.path,
                  name: AppRoutes.favoritos.name,
                  builder: (context, state) => const FavoritosPage(),
                  routes: [
                    GoRoute(
                      path: AppRoutes.favoritoItem.path,
                      name: AppRoutes.favoritoItem.name,
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
                  path: AppRoutes.perfil.path,
                  name: AppRoutes.perfil.name,
                  builder: (context, state) => const PerfilPage(),
                  routes: [
                    GoRoute(
                      path: AppRoutes.configuracoes.path,
                      name: AppRoutes.configuracoes.name,
                      builder: (context, state) => const ConfiguracoesPage(),
                    ),
                    GoRoute(
                      path: AppRoutes.editarPerfil.path,
                      name: AppRoutes.editarPerfil.name,
                      builder: (context, state) => const EditarPerfilPage(),
                    ),
                    GoRoute(
                      path: AppRoutes.seguranca.path,
                      name: AppRoutes.seguranca.name,
                      builder: (context, state) => const SegurancaPage(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        // === ROTAS ESPECIAIS (FORA DO SHELL) ===
        GoRoute(
          path: AppRoutes.qrScanner.path,
          name: AppRoutes.qrScanner.name,
          builder: (context, state) => const QRScannerPage(),
        ),

        GoRoute(
          path: AppRoutes.notifications.path,
          name: AppRoutes.notifications.name,
          builder: (context, state) => const NotificationsPage(),
        ),

        GoRoute(
          path: AppRoutes.help.path,
          name: AppRoutes.help.name,
          builder: (context, state) => const HelpPage(),
        ),
      ],

      errorBuilder: (context, state) => const NotFoundPage(),
    );
  }
}

/// Provider para o router
final routerProvider = Provider<GoRouter>(AppRouter.getRouter);

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

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64),
            const SizedBox(height: 16),
            const Text('Página não encontrada'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('Voltar ao início'),
            ),
          ],
        ),
      ),
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
