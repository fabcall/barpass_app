import 'package:barpass_app/core/router/navigation_extension.dart';
import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/shared/providers/location_provider.dart';
import 'package:barpass_app/shared/widgets/feedback/burnt/burnt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:rive/rive.dart';

/// Página para solicitar permissão de localização
///
/// Exibe uma interface amigável explicando por que o app precisa
/// de acesso à localização e permite que o usuário conceda ou negue.
class LocationPermissionPage extends ConsumerStatefulWidget {
  const LocationPermissionPage({
    super.key,
    this.onPermissionGranted,
    this.onPermissionDenied,
  });

  final VoidCallback? onPermissionGranted;
  final VoidCallback? onPermissionDenied;

  @override
  ConsumerState<LocationPermissionPage> createState() =>
      _LocationPermissionPageState();
}

class _LocationPermissionPageState
    extends ConsumerState<LocationPermissionPage> {
  bool _isRequesting = false;
  StateMachineController? _riveController;

  @override
  void dispose() {
    _riveController?.dispose();
    super.dispose();
  }

  Future<void> _handleRequestPermission() async {
    setState(() => _isRequesting = true);

    try {
      final granted = await ref
          .read(locationPermissionProvider.notifier)
          .requestPermission();

      if (!mounted) return;

      if (granted) {
        Burnt().toast(
          context,
          title: 'Permissão concedida!',
          message: 'Agora você pode ver estabelecimentos próximos',
          preset: BurntPreset.done,
        );

        widget.onPermissionGranted?.call();

        // Volta para a tela anterior
        if (context.navigate.canPop) {
          context.navigate.pop();
        }
      } else {
        // Verifica se foi negada permanentemente
        final state = ref.read(locationPermissionProvider).value;
        if (state?.isPermissionDeniedForever ?? false) {
          _showPermanentDenialDialog();
        } else {
          Burnt().toast(
            context,
            title: 'Permissão negada',
            message: 'Você pode conceder depois nas configurações',
            preset: BurntPreset.warning,
          );
          widget.onPermissionDenied?.call();
        }
      }
    } finally {
      if (mounted) {
        setState(() => _isRequesting = false);
      }
    }
  }

  void _showPermanentDenialDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.location_off,
          color: context.colorScheme.error,
          size: 32,
        ),
        title: const Text('Permissão negada'),
        content: const Text(
          'Você negou permanentemente o acesso à localização. '
          'Para usar este recurso, você precisa habilitar nas configurações do dispositivo.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await ref
                  .read(locationPermissionProvider.notifier)
                  .openAppSettings();
            },
            child: const Text('Abrir Configurações'),
          ),
        ],
      ),
    );
  }

  void _handleSkip() {
    widget.onPermissionDenied?.call();
    if (context.navigate.canPop) {
      context.navigate.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(locationPermissionProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Botão de fechar no canto superior direito
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: _handleSkip,
                  icon: const Icon(Icons.close),
                  tooltip: 'Pular',
                ),
              ),

              const Spacer(),

              // Animação Rive
              SizedBox(
                height: 200,
                child: RiveAnimation.asset(
                  'assets/rive-animations/location.riv',
                  fit: BoxFit.contain,
                  onInit: (artboard) {
                    final controller = StateMachineController.fromArtboard(
                      artboard,
                      'State Machine 1',
                    );
                    if (controller != null) {
                      artboard.addController(controller);
                      _riveController = controller;
                    }
                  },
                ),
              ),

              const Gap(32),

              // Título
              Text(
                'Encontre estabelecimentos próximos',
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),

              const Gap(16),

              // Descrição
              Text(
                'Precisamos da sua localização para mostrar bares e '
                'restaurantes perto de você com os melhores descontos.',
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const Gap(32),

              // Benefícios
              _buildBenefitItem(
                context,
                icon: Icons.near_me,
                title: 'Estabelecimentos próximos',
                description: 'Veja os lugares mais perto de você',
              ),

              const Gap(16),

              _buildBenefitItem(
                context,
                icon: Icons.local_offer,
                title: 'Melhores ofertas',
                description: 'Encontre descontos na sua região',
              ),

              const Gap(16),

              _buildBenefitItem(
                context,
                icon: Icons.navigation,
                title: 'Navegação fácil',
                description: 'Rotas diretas para qualquer lugar',
              ),

              const Spacer(),

              // Botões de ação
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilledButton.icon(
                    onPressed: _isRequesting ? null : _handleRequestPermission,
                    icon: _isRequesting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(Icons.location_on),
                    label: Text(
                      _isRequesting
                          ? 'Solicitando...'
                          : 'Permitir acesso à localização',
                    ),
                  ),

                  const Gap(12),

                  TextButton(
                    onPressed: _isRequesting ? null : _handleSkip,
                    child: const Text('Agora não'),
                  ),
                ],
              ),

              const Gap(8),

              // Nota sobre privacidade
              Text(
                'Sua localização é usada apenas enquanto você usa o app '
                'e nunca é compartilhada com terceiros.',
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant.withValues(
                    alpha: 0.7,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: context.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: context.colorScheme.onPrimaryContainer,
            size: 24,
          ),
        ),

        const Gap(16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.colorScheme.onSurface,
                ),
              ),
              const Gap(2),
              Text(
                description,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
