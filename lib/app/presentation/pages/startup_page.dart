import 'package:barpass_app/app/presentation/providers/app_state_provider.dart';
import 'package:barpass_app/app/presentation/state/app_state.dart';
import 'package:barpass_app/core/di/core_dependencies.dart';
import 'package:barpass_app/core/router/app_routes.dart';
import 'package:barpass_app/features/onboarding/presentation/providers/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart' hide LinearGradient;

class StartupPage extends ConsumerStatefulWidget {
  const StartupPage({super.key});

  @override
  ConsumerState<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends ConsumerState<StartupPage>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoOpacityAnimation;

  // Controladores do Rive
  SMITrigger? _logoTrigger;
  SMIBool? _isLoading;
  Artboard? _riveArtboard;
  StateMachineController? _controller;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _loadRiveFile();
    _startAnimations();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _controller?.dispose();
    super.dispose();
  }

  void _setupAnimations() {
    // Animação da logo (scale + fadeIn)
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    // Animações da logo
    _logoScaleAnimation =
        Tween<double>(
          begin: 0.3,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: _logoController,
            curve: Curves.elasticOut,
          ),
        );

    _logoOpacityAnimation =
        Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: _logoController,
            curve: const Interval(0, 0.6, curve: Curves.easeOut),
          ),
        );
  }

  void _loadRiveFile() {
    rootBundle.load('assets/rive-animations/logo-in.riv').then(
      (data) async {
        // Carrega o arquivo Rive
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;

        // Configura a state machine
        final controller = StateMachineController.fromArtboard(
          artboard,
          'State Machine 1', // Nome da state machine - ajuste conforme necessário
        );

        if (controller != null) {
          artboard.addController(controller);
          _controller = controller;

          // Obtém os inputs da state machine
          _logoTrigger = controller.findInput<bool>('trigger') as SMITrigger?;
          _isLoading = controller.findInput<bool>('isLoading') as SMIBool?;
        }

        setState(() {
          _riveArtboard = artboard;
        });

        // Dispara a animação Rive após o carregamento, sincronizado com scale
        Future.delayed(const Duration(milliseconds: 800), () {
          if (mounted) {
            _logoTrigger?.fire();
            _isLoading?.change(true);
          }
        });
      },
    );
  }

  void _startAnimations() {
    // Inicia a animação da logo
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        _logoController.forward();
      }
    });
  }

  void _handleNavigation(BuildContext context, WidgetRef ref) {
    final appState = ref.read(appStateProvider);
    final onboardingState = ref.read(onboardingProvider);
    final onboardingValue = onboardingState.value;

    if (!appState.isReady ||
        onboardingState.isLoading ||
        onboardingValue == null) {
      return;
    }

    if (!onboardingValue.isCompleted) {
      context.go(AppRoute.onboarding.path);
      return;
    }

    final redirectService = ref.read(redirectServiceProvider);
    final initialRoute =
        redirectService.consumeInitialRoute() ?? AppRoute.home.path;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.go(initialRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref
      ..listen(appStateProvider, (previous, next) {
        if (next.isReady && mounted) {
          _isLoading?.change(false);
        }

        _handleNavigation(context, ref);
      })
      ..listen(onboardingProvider, (previous, next) {
        _handleNavigation(context, ref);
      });

    final appState = ref.watch(appStateProvider);

    return Scaffold(
      body: Container(
        decoration: _buildGradientBackground(context),
        child: SafeArea(
          child: _buildContent(context, appState),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, AppState appState) {
    if (appState.hasError) {
      return _buildErrorState(context, appState.error);
    }

    return _buildLoadingState(context);
  }

  /// Constrói o fundo com gradiente laranja
  BoxDecoration _buildGradientBackground(BuildContext context) {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFFF8C00), // Orange
          Color(0xFFFF7700), // Darker orange
          Color(0xFFFF6500), // Even darker orange
        ],
        stops: [0.0, 0.5, 1.0],
      ),
    );
  }

  /// Estado de loading principal
  Widget _buildLoadingState(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _logoScaleAnimation,
          _logoOpacityAnimation,
        ]),
        builder: (context, child) {
          return Transform.scale(
            scale: _logoScaleAnimation.value,
            child: Opacity(
              opacity: _logoOpacityAnimation.value,
              child: _buildRiveLogo(),
            ),
          );
        },
      ),
    );
  }

  /// Logo com animação Rive
  Widget _buildRiveLogo() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: _riveArtboard != null
            ? Rive(
                artboard: _riveArtboard!,
              )
            : const SizedBox.shrink(), // Remove fallback
      ),
    );
  }

  /// Estado de erro
  Widget _buildErrorState(BuildContext context, String? error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ícone de erro simples
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.white.withValues(alpha: 0.8),
            ),

            const SizedBox(height: 32),

            const Text(
              'Ops! Algo deu errado',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            Text(
              error ?? 'Erro desconhecido durante a inicialização',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 32),

            // Botão de retry minimalista
            OutlinedButton.icon(
              onPressed: () {
                ref.read(appStateProvider.notifier).retry();
                // Reinicia a animação Rive
                _logoTrigger?.fire();
                _isLoading?.change(true);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );
  }
}
