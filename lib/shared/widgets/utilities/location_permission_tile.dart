import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/shared/providers/location_provider.dart';
import 'package:barpass_app/shared/widgets/feedback/burnt/burnt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

/// Tile para gerenciar permissão de localização na tela de perfil
class LocationPermissionTile extends ConsumerWidget {
  const LocationPermissionTile({super.key});

  String _getPermissionStatusText(LocationPermission permission) {
    switch (permission) {
      case LocationPermission.always:
        return 'Sempre permitida';
      case LocationPermission.whileInUse:
        return 'Permitida durante uso';
      case LocationPermission.denied:
        return 'Negada';
      case LocationPermission.deniedForever:
        return 'Negada permanentemente';
      case LocationPermission.unableToDetermine:
        return 'Não determinada';
    }
  }

  IconData _getPermissionIcon(
    LocationPermission permission,
    bool serviceEnabled,
  ) {
    if (!serviceEnabled) {
      return Icons.location_off;
    }

    switch (permission) {
      case LocationPermission.always:
      case LocationPermission.whileInUse:
        return Icons.location_on;
      case LocationPermission.denied:
      case LocationPermission.deniedForever:
        return Icons.location_disabled;
      case LocationPermission.unableToDetermine:
        return Icons.location_searching;
    }
  }

  Color _getPermissionColor(
    BuildContext context,
    LocationPermission permission,
    bool serviceEnabled,
  ) {
    if (!serviceEnabled) {
      return context.colorScheme.error;
    }

    switch (permission) {
      case LocationPermission.always:
      case LocationPermission.whileInUse:
        return Colors.green.shade600;
      case LocationPermission.denied:
        return Colors.orange.shade600;
      case LocationPermission.deniedForever:
        return context.colorScheme.error;
      case LocationPermission.unableToDetermine:
        return Colors.grey.shade600;
    }
  }

  Future<void> _handleTap(BuildContext context, WidgetRef ref) async {
    final permissionState = ref.read(locationPermissionProvider).value;

    if (permissionState == null) {
      Burnt().toast(
        context,
        title: 'Carregando...',
        message: 'Aguarde enquanto verificamos suas permissões',
        preset: BurntPreset.none,
      );
      return;
    }

    // Se o serviço estiver desabilitado
    if (!permissionState.isServiceEnabled) {
      final shouldOpen = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          icon: Icon(
            Icons.location_off,
            color: context.colorScheme.error,
            size: 32,
          ),
          title: const Text('Serviço de localização desabilitado'),
          content: const Text(
            'O serviço de localização está desabilitado no seu dispositivo. '
            'Deseja abrir as configurações para habilitá-lo?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Abrir Configurações'),
            ),
          ],
        ),
      );

      if (shouldOpen == true && context.mounted) {
        await ref
            .read(locationPermissionProvider.notifier)
            .openLocationSettings();
      }
      return;
    }

    // Se a permissão foi negada permanentemente
    if (permissionState.isPermissionDeniedForever) {
      final shouldOpen = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          icon: Icon(
            Icons.location_disabled,
            color: context.colorScheme.error,
            size: 32,
          ),
          title: const Text('Permissão negada'),
          content: const Text(
            'Você negou permanentemente o acesso à localização. '
            'Para usar este recurso, você precisa habilitar nas configurações do app.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Abrir Configurações'),
            ),
          ],
        ),
      );

      if ((shouldOpen ?? false) && context.mounted) {
        await ref.read(locationPermissionProvider.notifier).openAppSettings();
      }
      return;
    }

    // Se tem permissão, mostra informações
    if (permissionState.hasPermission) {
      _showLocationInfoDialog(context, ref, permissionState);
      return;
    }

    // Caso contrário, solicita permissão
    final granted = await ref
        .read(locationPermissionProvider.notifier)
        .requestPermission();

    if (!context.mounted) return;

    if (granted) {
      Burnt().toast(
        context,
        title: 'Permissão concedida!',
        message: 'Agora você pode ver estabelecimentos próximos',
        preset: BurntPreset.done,
      );
    } else {
      Burnt().toast(
        context,
        title: 'Permissão negada',
        message: 'Você pode conceder depois nas configurações',
        preset: BurntPreset.warning,
      );
    }
  }

  void _showLocationInfoDialog(
    BuildContext context,
    WidgetRef ref,
    LocationPermissionState permissionState,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.location_on,
          color: Colors.green.shade600,
          size: 32,
        ),
        title: const Text('Localização habilitada'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status: ${_getPermissionStatusText(permissionState.permission)}',
              style: context.textTheme.bodyMedium,
            ),
            if (permissionState.lastKnownPosition != null) ...[
              const SizedBox(height: 8),
              Text(
                'Última localização conhecida:',
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Lat: ${permissionState.lastKnownPosition!.latitude.toStringAsFixed(6)}',
                style: context.textTheme.bodySmall?.copyWith(
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              Text(
                'Lng: ${permissionState.lastKnownPosition!.longitude.toStringAsFixed(6)}',
                style: context.textTheme.bodySmall?.copyWith(
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
            const SizedBox(height: 12),
            const Text(
              'Para alterar as permissões, use as configurações do sistema.',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(locationPermissionProvider.notifier).openAppSettings();
            },
            child: const Text('Configurações'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionState = ref.watch(locationPermissionProvider);

    return permissionState.when(
      data: (state) {
        final icon = _getPermissionIcon(
          state.permission,
          state.isServiceEnabled,
        );
        final color = _getPermissionColor(
          context,
          state.permission,
          state.isServiceEnabled,
        );
        final statusText = _getPermissionStatusText(state.permission);

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _handleTap(context, ref),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  // Ícone com fundo colorido
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 22,
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Textos
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Localização',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          state.isServiceEnabled
                              ? statusText
                              : 'Serviço desabilitado',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Seta
                  Icon(
                    Icons.chevron_right,
                    color: context.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => _buildLoadingTile(context),
      error: (error, _) => _buildErrorTile(context),
    );
  }

  Widget _buildLoadingTile(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Localização',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Verificando permissões...',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorTile(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Tentar recarregar
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: context.colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.error_outline,
                  color: context.colorScheme.error,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Localização',
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Erro ao verificar permissões',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: context.colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
