import 'package:barpass_app/app/presentation/providers/app_state.dart';
import 'package:barpass_app/app/presentation/providers/app_state_provider.dart';
import 'package:barpass_app/shared/utils/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartupPage extends ConsumerStatefulWidget {
  const StartupPage({super.key});

  @override
  ConsumerState<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends ConsumerState<StartupPage>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _pulseController;
  late Animation<double> _logoAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _setupAnimations() {
    // Animação principal do logo
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Animação de pulse do loading
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _logoAnimation =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _logoController,
            curve: Curves.elasticOut,
          ),
        );

    _pulseAnimation =
        Tween<double>(
          begin: 0.8,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _pulseController,
            curve: Curves.easeInOut,
          ),
        );
  }

  void _startAnimations() {
    _logoController.forward();
    _pulseController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    // Escutar mudanças no estado da aplicação para redirecionamento
    ref.listen(appStateProvider, (previous, next) {
      // O redirecionamento é feito automaticamente pelo GoRouter
      // baseado no estado da aplicação
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

  /// Constrói o fundo com gradiente
  BoxDecoration _buildGradientBackground(BuildContext context) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          context.colorScheme.primary,
          context.colorScheme.primary.withOpacity(0.8),
          context.colorScheme.secondary.withOpacity(0.6),
        ],
        stops: const [0.0, 0.7, 1.0],
      ),
    );
  }

  /// Estado de loading principal
  Widget _buildLoadingState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo animado
          AnimatedBuilder(
            animation: _logoAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: 0.5 + (0.5 * _logoAnimation.value),
                child: Opacity(
                  opacity: _logoAnimation.value,
                  child: _buildLogo(context),
                ),
              );
            },
          ),

          const SizedBox(height: 48),

          // Nome do app
          AnimatedBuilder(
            animation: _logoAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _logoAnimation.value,
                child: Transform.translate(
                  offset: Offset(0, 20 * (1 - _logoAnimation.value)),
                  child: Text(
                    'barpass',
                    style: context.textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Comfortaa',
                      letterSpacing: 3,
                      fontSize: 32,
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 8),

          // Subtitle
          AnimatedBuilder(
            animation: _logoAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _logoAnimation.value * 0.8,
                child: Text(
                  'Economia que você pode ver',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                    letterSpacing: 1,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 64),

          // Loading indicator animado
          AnimatedBuilder(
            animation: Listenable.merge([_logoAnimation, _pulseAnimation]),
            builder: (context, child) {
              return Opacity(
                opacity: _logoAnimation.value,
                child: Transform.scale(
                  scale: _pulseAnimation.value,
                  child: _buildLoadingIndicator(),
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          // Texto de loading
          AnimatedBuilder(
            animation: _logoAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _logoAnimation.value * 0.9,
                child: Text(
                  'Inicializando...',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.8),
                    letterSpacing: 0.5,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Logo principal com efeitos
  Widget _buildLogo(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ícone principal
          const Icon(
            Icons.local_bar,
            size: 60,
            color: Colors.orange,
          ),

          // Efeito de brilho
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.3),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withOpacity(0.05),
                  ],
                  stops: const [0.0, 0.3, 0.7, 1.0],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Indicador de loading customizado
  Widget _buildLoadingIndicator() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 3,
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
            // Logo em estado de erro
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(
                Icons.error_outline,
                size: 50,
                color: context.colorScheme.error,
              ),
            ),

            const SizedBox(height: 32),

            Text(
              'Ops! Algo deu errado',
              style: context.textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            Text(
              error ?? 'Erro desconhecido durante a inicialização',
              style: context.textTheme.bodyLarge?.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 32),

            // Botão de retry
            FilledButton.icon(
              onPressed: () {
                ref.read(appStateProvider.notifier).retry();
              },
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: context.colorScheme.primary,
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
