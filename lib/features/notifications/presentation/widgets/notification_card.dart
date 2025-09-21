import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/features/notifications/domain/entities/notification.dart';
import 'package:flutter/material.dart' hide Notification;

/// Card para exibir uma notificação individual
///
/// Exibe título, corpo, timestamp e tipo da notificação
/// com visual diferenciado para lidas/não lidas
class NotificationCard extends StatelessWidget {
  const NotificationCard({
    required this.notification,
    this.onTap,
    this.onDismiss,
    super.key,
  });

  final Notification notification;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismiss?.call(),
      background: _buildDismissBackground(context),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: notification.isRead
                  ? Colors.transparent
                  : context.colorScheme.primaryContainer.withValues(alpha: 0.1),
              border: Border(
                bottom: BorderSide(
                  color: context.colorScheme.outlineVariant.withValues(
                    alpha: 0.3,
                  ),
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ícone do tipo de notificação
                _buildTypeIcon(context),
                const SizedBox(width: 12),

                // Conteúdo
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título e timestamp
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: context.textTheme.titleSmall?.copyWith(
                                fontWeight: notification.isRead
                                    ? FontWeight.w500
                                    : FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            notification.timeAgo,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      // Corpo da notificação
                      Text(
                        notification.body,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Imagem (se houver)
                      if (notification.imageUrl != null) ...[
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            notification.imageUrl!,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 120,
                                color:
                                    context.colorScheme.surfaceContainerHighest,
                                child: const Center(
                                  child: Icon(Icons.broken_image),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Indicador de não lida
                if (!notification.isRead) ...[
                  const SizedBox(width: 8),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeIcon(BuildContext context) {
    final color = _getTypeColor(context);

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        _getTypeIconData(),
        size: 20,
        color: color,
      ),
    );
  }

  IconData _getTypeIconData() {
    switch (notification.type) {
      case NotificationType.promotion:
        return Icons.local_offer;
      case NotificationType.order:
        return Icons.receipt_long;
      case NotificationType.favorite:
        return Icons.favorite;
      case NotificationType.general:
        return Icons.notifications;
      case NotificationType.system:
        return Icons.info;
    }
  }

  Color _getTypeColor(BuildContext context) {
    switch (notification.type) {
      case NotificationType.promotion:
        return Colors.orange.shade600;
      case NotificationType.order:
        return Colors.blue.shade600;
      case NotificationType.favorite:
        return Colors.red.shade600;
      case NotificationType.general:
        return Colors.purple.shade600;
      case NotificationType.system:
        return context.colorScheme.primary;
    }
  }

  Widget _buildDismissBackground(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      color: context.colorScheme.error,
      child: Icon(
        Icons.delete,
        color: context.colorScheme.onError,
      ),
    );
  }
}
