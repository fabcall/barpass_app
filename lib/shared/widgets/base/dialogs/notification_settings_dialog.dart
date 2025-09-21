import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/features/notifications/presentation/providers/push_notification_provider.dart';
import 'package:barpass_app/shared/widgets/feedback/burnt/burnt.dart';
import 'package:firebase_messaging/firebase_messaging.dart'
    show AuthorizationStatus;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Dialog para gerenciar configurações de notificações
///
/// Permite que o usuário:
/// - Visualize o status das notificações
/// - Navegue para configurações do sistema
/// - Veja o token FCM (debug)
/// - Gerencie inscrições em tópicos
///
/// Features:
/// - Feedback visual do status atual
/// - Animações suaves
/// - Feedback háptico
/// - Informações de debug em modo dev
class NotificationSettingsDialog extends ConsumerStatefulWidget {
  const NotificationSettingsDialog({super.key});

  @override
  ConsumerState<NotificationSettingsDialog> createState() =>
      _NotificationSettingsDialogState();

  /// Método estático para facilitar a abertura do dialog
  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) => const NotificationSettingsDialog(),
    );
  }
}

class _NotificationSettingsDialogState
    extends ConsumerState<NotificationSettingsDialog>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Configurar animação de entrada do dialog
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeOutCubic,
    );

    // Iniciar animação
    _scaleController.forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsState = ref.watch(notificationSettingsProvider);

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: AlertDialog(
            // Título com ícone
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: context.colorScheme.onPrimaryContainer,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text('Notificações'),
              ],
            ),

            contentPadding: const EdgeInsets.fromLTRB(0, 20, 0, 0),

            content: SizedBox(
              width: double.maxFinite,
              child: settingsState.when(
                data: (settings) => _buildContent(context, settings),
                loading: _buildLoadingState,
                error: (error, _) => _buildErrorState(error),
              ),
            ),

            actions: [
              TextButton(
                onPressed: _closeDialog,
                child: const Text('Fechar'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, NotificationSettings settings) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Status Card
        _buildStatusCard(context, settings),

        const SizedBox(height: 16),

        // Opções
        _buildOptionsList(context, settings),
      ],
    );
  }

  Widget _buildStatusCard(BuildContext context, NotificationSettings settings) {
    final isEnabled = settings.isEnabled;
    final statusText = _getStatusText(settings.authorizationStatus);
    final statusColor = isEnabled
        ? Colors.green.shade600
        : Colors.grey.shade600;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: statusColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isEnabled ? Icons.notifications_active : Icons.notifications_off,
              color: statusColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEnabled ? 'Habilitadas' : 'Desabilitadas',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  statusText,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsList(
    BuildContext context,
    NotificationSettings settings,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Ver histórico de notificações
        _NotificationOptionTile(
          icon: Icons.history,
          title: 'Histórico de notificações',
          subtitle: 'Ver todas as notificações recebidas',
          iconColor: Colors.blue.shade600,
          onTap: _closeDialog,
        ),

        // Configurações do sistema
        if (!settings.isEnabled)
          _NotificationOptionTile(
            icon: Icons.settings,
            title: 'Abrir configurações',
            subtitle: 'Ativar notificações nas configurações do sistema',
            iconColor: context.colorScheme.primary,
            onTap: () => _openSystemSettings(context),
          ),

        // Gerenciar tópicos (se habilitado)
        if (settings.isEnabled)
          _NotificationOptionTile(
            icon: Icons.category_outlined,
            title: 'Gerenciar categorias',
            subtitle: 'Escolher tipos de notificações',
            iconColor: Colors.purple.shade600,
            onTap: () => _showTopicsManagement(context, settings),
          ),

        // Informações de debug (apenas em dev)
        if (_isDebugMode() && settings.fcmToken != null)
          _NotificationOptionTile(
            icon: Icons.developer_mode,
            title: 'Info de desenvolvedor',
            subtitle: 'Token FCM e diagnóstico',
            iconColor: Colors.orange.shade600,
            onTap: () => _showDebugInfo(context, settings),
          ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return const SizedBox(
      height: 150,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Carregando configurações...'),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return SizedBox(
      height: 150,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: context.colorScheme.error,
              size: 32,
            ),
            const SizedBox(height: 12),
            Text(
              'Erro ao carregar notificações',
              style: context.textTheme.titleSmall?.copyWith(
                color: context.colorScheme.error,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tente novamente',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.tonal(
              onPressed: () {
                ref.read(notificationSettingsProvider.notifier).refresh();
              },
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );
  }

  String _getStatusText(AuthorizationStatus authorizationStatus) {
    switch (authorizationStatus.toString()) {
      case 'AuthorizationStatus.authorized':
        return 'Todas as notificações permitidas';
      case 'AuthorizationStatus.denied':
        return 'Notificações negadas';
      case 'AuthorizationStatus.notDetermined':
        return 'Permissão não solicitada';
      case 'AuthorizationStatus.provisional':
        return 'Permitido provisoriamente';
      default:
        return 'Status desconhecido';
    }
  }

  Future<void> _openSystemSettings(BuildContext context) async {
    HapticFeedback.lightImpact();

    // TODO: Abrir configurações do sistema
    // await ref.read(notificationSettingsProvider.notifier).openAppSettings();

    if (!context.mounted) return;

    Burnt().toast(
      context,
      title: 'Abrindo configurações...',
      preset: BurntPreset.none,
    );

    _closeDialog();
  }

  void _showTopicsManagement(
    BuildContext context,
    NotificationSettings settings,
  ) {
    HapticFeedback.lightImpact();

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Gerenciar categorias'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Escolha que tipos de notificações você quer receber:',
              style: context.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ...settings.subscribedTopics.map((topic) {
              return CheckboxListTile(
                title: Text(_getTopicLabel(topic)),
                value: true,
                onChanged: (value) {
                  // TODO: Implementar subscribe/unsubscribe
                },
              );
            }),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _showDebugInfo(BuildContext context, NotificationSettings settings) {
    HapticFeedback.lightImpact();

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.developer_mode, size: 20),
            SizedBox(width: 8),
            Text('Debug Info'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FCM Token:',
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SelectableText(
                  settings.fcmToken ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Tópicos inscritos:',
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              ...settings.subscribedTopics.map((topic) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8, top: 4),
                  child: Text('• $topic'),
                );
              }),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(
                ClipboardData(text: settings.fcmToken ?? ''),
              );
              Burnt().toast(
                context,
                title: 'Token copiado!',
                preset: BurntPreset.done,
              );
            },
            child: const Text('Copiar Token'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  String _getTopicLabel(String topic) {
    switch (topic) {
      case 'general':
        return 'Geral';
      case 'promotions':
        return 'Promoções';
      case 'orders':
        return 'Pedidos';
      case 'favorites':
        return 'Favoritos';
      default:
        return topic;
    }
  }

  bool _isDebugMode() {
    // TODO: Verificar se está em modo debug
    return true;
  }

  void _closeDialog() {
    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}

/// Widget individual para cada opção
class _NotificationOptionTile extends StatelessWidget {
  const _NotificationOptionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            children: [
              // Ícone
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20,
                ),
              ),

              const SizedBox(width: 12),

              // Textos
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
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
  }
}
