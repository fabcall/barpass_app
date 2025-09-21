import 'package:barpass_app/app/presentation/pages/startup_page.dart';
import 'package:barpass_app/core/router/app_routes.dart';
import 'package:barpass_app/features/auth/presentation/pages/landing_page.dart';
import 'package:barpass_app/features/auth/presentation/pages/login_page.dart';
import 'package:barpass_app/features/auth/presentation/pages/password_reset_page.dart';
import 'package:barpass_app/features/auth/presentation/pages/registration_page.dart';
import 'package:barpass_app/features/home/presentation/pages/home_page.dart';
import 'package:barpass_app/features/navigation/presentation/pages/shell_navigation_page.dart';
import 'package:barpass_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:barpass_app/features/profile/presentation/pages/profile_page.dart';
import 'package:barpass_app/shared/widgets/layout/not_found_page.dart';
import 'package:barpass_app/shared/widgets/layout/sheet_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
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
              path: AppRoutes.home.path,
              name: AppRoutes.home.name,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),

        // Branch 1 - Wallet/Conta
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
              builder: (context, state) => const ProfilePage(),
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

    // === SPECIAL ROUTES (fora do shell) ===
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

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({Key? key}) : super(key: key);

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? result;
  bool isScanning = true;
  bool flashOn = false;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Scanner QR Code',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(flashOn ? Icons.flash_on : Icons.flash_off),
            onPressed: () async {
              await controller?.toggleFlash();
              setState(() {
                flashOn = !flashOn;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.green,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 250,
                  ),
                ),
                // Instrução de uso
                Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text(
                      'Aponte a câmera para o QR Code',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (result != null)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Resultado:',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SelectableText(
                            result!,
                            style: const TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (result != null)
                        ElevatedButton.icon(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: result!));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Copiado para a área de transferência',
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          icon: const Icon(Icons.copy),
                          label: const Text('Copiar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            result = null;
                            isScanning = true;
                          });
                          controller?.resumeCamera();
                        },
                        icon: const Icon(Icons.qr_code_scanner),
                        label: Text(
                          result == null ? 'Pausar' : 'Escanear Novamente',
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      if (isScanning) {
        setState(() {
          result = scanData.code;
          isScanning = false;
        });

        // Vibração ao detectar QR code
        HapticFeedback.mediumImpact();

        // Pausar a câmera após detectar o código
        controller.pauseCamera();

        // Som de sucesso (opcional)
        // SystemSound.play(SystemSoundType.click);
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

// class QRScannerPage extends StatelessWidget {
//   const QRScannerPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Scanner QR'),
//         leading: IconButton(
//           icon: const Icon(Icons.close),
//           onPressed: () => context.pop(),
//         ),
//       ),
//       body: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.qr_code_scanner, size: 100),
//             SizedBox(height: 16),
//             Text('Scanner de QR Code'),
//             Text('Aponte a câmera para o código QR'),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
