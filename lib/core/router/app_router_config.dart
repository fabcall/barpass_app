import 'package:barpass_app/app/presentation/pages/startup_page.dart';
import 'package:barpass_app/core/router/app_routes.dart';
import 'package:barpass_app/core/router/navigation_extension.dart';
import 'package:barpass_app/core/router/router_key.dart';
import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/features/auth/presentation/pages/change_password_page.dart';
import 'package:barpass_app/features/auth/presentation/pages/landing_page.dart';
import 'package:barpass_app/features/auth/presentation/pages/login_page.dart';
import 'package:barpass_app/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:barpass_app/features/auth/presentation/pages/password_reset_page.dart';
import 'package:barpass_app/features/auth/presentation/pages/registration_page.dart';
import 'package:barpass_app/features/checkout/presentation/pages/checkout_confirmation_page.dart';
import 'package:barpass_app/features/checkout/presentation/pages/qr_scanner_page.dart';
import 'package:barpass_app/features/establishments/presentation/pages/establishment_detail_page.dart';
import 'package:barpass_app/features/home/presentation/pages/home_page.dart';
import 'package:barpass_app/features/navigation/presentation/pages/shell_navigation_page.dart';
import 'package:barpass_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:barpass_app/features/profile/presentation/pages/profile_edit_page.dart';
import 'package:barpass_app/features/profile/presentation/pages/profile_page.dart';
import 'package:barpass_app/features/reviews/presentation/pages/create_review_page.dart';
import 'package:barpass_app/features/search/presentation/pages/search_page.dart';
import 'package:barpass_app/shared/widgets/layout/not_found_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class AppRouterConfig {
  static List<RouteBase> get routes => [
    // === STARTUP ===
    GoRoute(
      path: AppRoute.startup.path,
      name: AppRoute.startup.name,
      builder: (context, state) => const StartupPage(),
    ),

    // === ONBOARDING ===
    GoRoute(
      path: AppRoute.onboarding.path,
      name: AppRoute.onboarding.name,
      builder: (context, state) => const OnboardingPage(),
    ),

    // === LANDING + AUTH MODALS ===
    GoRoute(
      path: AppRoute.landing.path,
      name: AppRoute.landing.name,
      builder: (context, state) => const LandingPage(),
      routes: [
        ShellRoute(
          pageBuilder: (context, state, navigator) {
            return _buildPagedModalSheetShell(context, navigator);
          },
          routes: [
            GoRoute(
              path: AppRoute.login.path.substring(1),
              name: AppRoute.login.name,
              pageBuilder: (context, state) {
                return PagedSheetPage(
                  key: state.pageKey,
                  child: const LoginPage(),
                  transitionsBuilder: _fadeAndSlideTransitionWithIOSBackGesture,
                );
              },
              routes: [
                GoRoute(
                  path: AppRoute.passwordReset.path
                      .replaceAll(AppRoute.login.path, '')
                      .substring(1),
                  name: AppRoute.passwordReset.name,
                  pageBuilder: (context, state) {
                    return PagedSheetPage(
                      key: state.pageKey,
                      child: const PasswordResetPage(),
                      transitionsBuilder:
                          _fadeAndSlideTransitionWithIOSBackGesture,
                    );
                  },
                  routes: [
                    GoRoute(
                      path: AppRoute.otpVerification.path
                          .replaceAll(AppRoute.passwordReset.path, '')
                          .substring(1),
                      name: AppRoute.otpVerification.name,
                      pageBuilder: (context, state) {
                        return PagedSheetPage(
                          key: state.pageKey,
                          child: OtpVerificationPage(
                            email: state.uri.queryParameters['email'] ?? '',
                          ),
                          transitionsBuilder:
                              _fadeAndSlideTransitionWithIOSBackGesture,
                        );
                      },
                    ),
                    GoRoute(
                      path: AppRoute.changePassword.path
                          .replaceAll(AppRoute.passwordReset.path, '')
                          .substring(1),
                      name: AppRoute.changePassword.name,
                      pageBuilder: (context, state) {
                        final token = state.uri.queryParameters['token'] ?? '';
                        return PagedSheetPage(
                          key: state.pageKey,
                          child: ChangePasswordPage(token: token),
                          transitionsBuilder:
                              _fadeAndSlideTransitionWithIOSBackGesture,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            GoRoute(
              path: AppRoute.registration.path.substring(1),
              name: AppRoute.registration.name,
              pageBuilder: (context, state) {
                return PagedSheetPage(
                  key: state.pageKey,
                  child: const RegistrationPage(),
                  transitionsBuilder: _fadeAndSlideTransitionWithIOSBackGesture,
                );
              },
            ),
          ],
        ),
      ],
    ),

    GoRoute(
      path: AppRoute.establishmentDetails.path,
      name: AppRoute.establishmentDetails.name,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return EstablishmentDetailPage(establishmentId: id);
      },
    ),

    ShellRoute(
      pageBuilder: (context, state, navigator) {
        return _buildPagedModalSheetShell(context, navigator);
      },
      routes: [
        GoRoute(
          path: AppRoute.qrScanner.path,
          name: AppRoute.qrScanner.name,
          pageBuilder: (context, state) {
            return PagedSheetPage(
              key: state.pageKey,
              child: const QRScannerPage(),
              transitionsBuilder: _fadeAndSlideTransitionWithIOSBackGesture,
            );
          },
          routes: [
            GoRoute(
              path: AppRoute.checkout.path
                  .replaceAll(AppRoute.qrScanner.path, '')
                  .substring(1),
              name: AppRoute.checkout.name,
              pageBuilder: (context, state) {
                return PagedSheetPage(
                  key: state.pageKey,
                  child: const CheckoutConfirmationPage(
                    establishmentId: '',
                    orderId: '',
                  ),
                  transitionsBuilder: _fadeAndSlideTransitionWithIOSBackGesture,
                );
              },
            ),
          ],
        ),
      ],
    ),

    // === Review modal ===
    GoRoute(
      path: AppRoute.createReview.path,
      name: AppRoute.createReview.name,
      pageBuilder: (context, state) {
        return ModalSheetPage(
          swipeDismissible: true,
          viewportPadding: EdgeInsets.only(
            top: context.viewPadding.top,
          ),
          child: _wrapWithTheme(
            context,
            Sheet(
              decoration: _getModalDecoration(context),
              child: const CreateReviewPage(
                establishmentId: '',
                orderId: '',
              ),
            ),
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
        // Branch 0 - Home
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.home.path,
              name: AppRoute.home.name,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),

        // Branch 1 - Conta
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoute.account.path,
              name: AppRoute.account.name,
              builder: (context, state) => const ContaPage(),
              routes: [
                GoRoute(
                  path: AppRoute.contaTransacoes.path
                      .replaceAll(AppRoute.account.path, '')
                      .substring(1),
                  name: AppRoute.contaTransacoes.name,
                  builder: (context, state) => const TransacoesPage(),
                ),
                GoRoute(
                  path: AppRoute.contaExtrato.path
                      .replaceAll(AppRoute.account.path, '')
                      .substring(1),
                  name: AppRoute.contaExtrato.name,
                  builder: (context, state) => const ExtratoPage(),
                ),
                GoRoute(
                  path: AppRoute.contaCartoes.path
                      .replaceAll(AppRoute.account.path, '')
                      .substring(1),
                  name: AppRoute.contaCartoes.name,
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
              path: AppRoute.favoritos.path,
              name: AppRoute.favoritos.name,
              builder: (context, state) => const FavoritosPage(),
              routes: [
                GoRoute(
                  path: AppRoute.favoritosItem.path,
                  name: AppRoute.favoritosItem.name,
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
              path: AppRoute.profile.path,
              name: AppRoute.profile.name,
              builder: (context, state) => const ProfilePage(),
              routes: [
                GoRoute(
                  parentNavigatorKey: navigatorKey,
                  path: AppRoute.editProfile.path
                      .replaceAll(AppRoute.profile.path, '')
                      .substring(1),
                  name: AppRoute.editProfile.name,
                  pageBuilder: (context, state) {
                    return ModalSheetPage(
                      swipeDismissible: true,
                      viewportPadding: EdgeInsets.only(
                        top: context.viewPadding.top,
                      ),
                      child: _wrapWithTheme(
                        context,
                        Sheet(
                          decoration: _getModalDecoration(context),
                          child: const ProfileEditPage(),
                        ),
                      ),
                    );
                  },
                ),
                GoRoute(
                  path: AppRoute.perfilConfiguracoes.path
                      .replaceAll(AppRoute.profile.path, '')
                      .substring(1),
                  name: AppRoute.perfilConfiguracoes.name,
                  builder: (context, state) => const ConfiguracoesPage(),
                ),
                GoRoute(
                  path: AppRoute.perfilSeguranca.path
                      .replaceAll(AppRoute.profile.path, '')
                      .substring(1),
                  name: AppRoute.perfilSeguranca.name,
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
      path: AppRoute.notifications.path,
      name: AppRoute.notifications.name,
      pageBuilder: (context, state) {
        return ModalSheetPage(
          swipeDismissible: true,
          viewportPadding: EdgeInsets.only(
            top: context.viewPadding.top,
          ),
          child: _wrapWithTheme(
            context,
            Sheet(
              decoration: _getModalDecoration(context),
              child: const NotificationsPage(),
            ),
          ),
        );
      },
    ),

    GoRoute(
      path: AppRoute.help.path,
      name: AppRoute.help.name,
      builder: (context, state) => const HelpPage(),
    ),

    GoRoute(
      path: AppRoute.search.path,
      name: AppRoute.search.name,
      builder: (context, state) => const SearchPage(),
    ),
  ];

  // === HELPERS ===

  /// Envolve um widget com Theme customizado para sheets elevados
  static Widget _wrapWithTheme(BuildContext context, Widget child) {
    return Theme(
      data: context.theme.copyWith(
        scaffoldBackgroundColor: context.colorScheme.surfaceContainerHigh,
        appBarTheme: context.theme.appBarTheme.copyWith(
          backgroundColor: context.colorScheme.surfaceContainerHigh,
        ),
      ),
      child: child,
    );
  }

  static ModalSheetPage<void> _buildPagedModalSheetShell(
    BuildContext context,
    Widget navigator,
  ) {
    return ModalSheetPage(
      swipeDismissible: true,
      viewportPadding: EdgeInsets.only(
        top: context.viewPadding.top,
      ),
      child: _wrapWithTheme(
        context,
        PagedSheet(
          decoration: _getModalDecoration(context),
          builder: (context, child) {
            return child;
          },
          navigator: navigator,
        ),
      ),
    );
  }

  static MaterialSheetDecoration _getModalDecoration(BuildContext context) {
    return MaterialSheetDecoration(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
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

Widget _fadeAndSlideTransitionWithIOSBackGesture(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final theme = Theme.of(context).pageTransitionsTheme;
  return FadeTransition(
    opacity: CurveTween(curve: Curves.easeInExpo).animate(animation),
    child: FadeTransition(
      opacity: Tween<double>(begin: 1, end: 0)
          .chain(CurveTween(curve: Curves.easeOutExpo))
          .animate(secondaryAnimation),
      child: theme.buildTransitions(
        ModalRoute.of(context)! as PageRoute,
        context,
        animation,
        secondaryAnimation,
        child,
      ),
    ),
  );
}

// === PÁGINAS TEMPORÁRIAS ===

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
          onPressed: () => context.navigate.account.pushTransactions(),
          child: const Text('Transações'),
        ),
        ElevatedButton(
          onPressed: () => context.navigate.account.pushStatement(),
          child: const Text('Extrato'),
        ),
        ElevatedButton(
          onPressed: () => context.navigate.account.pushCards(),
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
          onPressed: () => context.navigate.favorites.pushItem('456'),
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
  return ColoredBox(
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
