import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/features/notifications/presentation/providers/push_notification_provider.dart';
import 'package:barpass_app/shared/widgets/base/dialogs/notification_settings_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tile de notificações para a tela de perfil
///
/// Exibe o status das notificações e um badge com o número de não lidas
class NotificationTile extends ConsumerWidget {
  const NotificationTile({super.key});

  void _handleTap(BuildContext context) {
    HapticFeedback.lightImpact();
    NotificationSettingsDialog.show(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEnabled = ref.watch(notificationsEnabledProvider);
    final settings = ref.watch(notificationSettingsProvider);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _handleTap(context),
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
                  color: isEnabled
                      ? Colors.indigo.shade600.withValues(alpha: 0.1)
                      : context.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isEnabled
                      ? Icons.notifications_active
                      : Icons.notifications_off,
                  color: isEnabled
                      ? Colors.indigo.shade600
                      : context.colorScheme.onSurfaceVariant,
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
                      'Notificações',
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isEnabled ? 'Habilitadas' : 'Desabilitadas',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: isEnabled
                            ? Colors.indigo.shade600
                            : context.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Badge de notificações não lidas (placeholder - seria conectado com provider)
              if (isEnabled)
                settings.when(
                  data: (_) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: context.colorScheme.error,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '3', // TODO: Conectar com unread count provider
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.colorScheme.onError,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),

              const SizedBox(width: 8),

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
  }
}
