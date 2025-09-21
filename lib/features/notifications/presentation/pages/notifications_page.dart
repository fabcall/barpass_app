import 'package:barpass_app/core/theme/theme.dart';
import 'package:barpass_app/features/notifications/domain/entities/notification.dart';
import 'package:barpass_app/features/notifications/presentation/widgets/notification_card.dart';
import 'package:barpass_app/shared/widgets/feedback/burnt/burnt.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:smooth_sheets/smooth_sheets.dart';

/// Página de notificações
///
/// Exibe a lista de notificações do usuário com filtros e ações
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  NotificationType? _selectedFilter;

  // Mock data - substituir por provider real
  final List<Notification> _mockNotifications = [
    Notification(
      id: '1',
      title: '🎉 Promoção Especial',
      body: 'Ganhe 30% de desconto no Bar do João hoje até às 22h!',
      type: NotificationType.promotion,
      receivedAt: DateTime.now().subtract(const Duration(minutes: 15)),
      isRead: false,
      imageUrl: 'https://picsum.photos/400/200',
    ),
    Notification(
      id: '2',
      title: 'Pedido confirmado',
      body: 'Seu pedido #1234 foi confirmado e está sendo preparado.',
      type: NotificationType.order,
      receivedAt: DateTime.now().subtract(const Duration(hours: 1)),
      isRead: false,
    ),
    Notification(
      id: '3',
      title: '❤️ Novo lugar favorito',
      body: 'Pizzaria Bella Vista acaba de adicionar novos pratos ao cardápio!',
      type: NotificationType.favorite,
      receivedAt: DateTime.now().subtract(const Duration(hours: 3)),
      isRead: true,
    ),
    Notification(
      id: '4',
      title: 'Bem-vindo ao BarPass!',
      body:
          'Aproveite os melhores descontos da cidade. Complete seu perfil para começar.',
      type: NotificationType.general,
      receivedAt: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
    ),
    Notification(
      id: '5',
      title: 'Atualização disponível',
      body: 'Uma nova versão do app está disponível com melhorias e correções.',
      type: NotificationType.system,
      receivedAt: DateTime.now().subtract(const Duration(days: 2)),
      isRead: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Notification> get _filteredNotifications {
    var notifications = _mockNotifications;

    // Filtrar por tipo se selecionado
    if (_selectedFilter != null) {
      notifications = notifications
          .where((n) => n.type == _selectedFilter)
          .toList();
    }

    // Filtrar por tab (todas vs não lidas)
    if (_tabController.index == 1) {
      notifications = notifications.where((n) => !n.isRead).toList();
    }

    return notifications;
  }

  @override
  Widget build(BuildContext context) {
    return SheetContentScaffold(
      topBar: AppBar(
        centerTitle: true,
        title: const Text('Notificações'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          // Botão de marcar todas como lidas
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: _mockNotifications.any((n) => !n.isRead)
                ? _markAllAsRead
                : null,
            tooltip: 'Marcar todas como lidas',
          ),
          // Menu de opções
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'clear_all') {
                _clearAllNotifications();
              } else if (value == 'settings') {
                _openNotificationSettings();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(width: 12),
                    Text('Configurações'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'clear_all',
                child: Row(
                  children: [
                    Icon(Icons.clear_all),
                    SizedBox(width: 12),
                    Text('Limpar todas'),
                  ],
                ),
              ),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          onTap: (_) => setState(() {}),
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Todas'),
                  const SizedBox(width: 8),
                  _buildCountBadge(_mockNotifications.length),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Não lidas'),
                  const SizedBox(width: 8),
                  _buildCountBadge(
                    _mockNotifications.where((n) => !n.isRead).length,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Filtros de tipo
          _buildTypeFilters(),

          // Lista de notificações
          Expanded(
            child: _buildNotificationsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCountBadge(int count) {
    if (count == 0) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        count.toString(),
        style: context.textTheme.labelSmall?.copyWith(
          color: context.colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTypeFilters() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildFilterChip(
            label: 'Todas',
            icon: Icons.notifications,
            isSelected: _selectedFilter == null,
            onTap: () => setState(() => _selectedFilter = null),
          ),
          _buildFilterChip(
            label: 'Promoções',
            icon: Icons.local_offer,
            isSelected: _selectedFilter == NotificationType.promotion,
            onTap: () {
              setState(() => _selectedFilter = NotificationType.promotion);
            },
          ),
          _buildFilterChip(
            label: 'Pedidos',
            icon: Icons.receipt_long,
            isSelected: _selectedFilter == NotificationType.order,
            onTap: () =>
                setState(() => _selectedFilter = NotificationType.order),
          ),
          _buildFilterChip(
            label: 'Favoritos',
            icon: Icons.favorite,
            isSelected: _selectedFilter == NotificationType.favorite,
            onTap: () {
              setState(() => _selectedFilter = NotificationType.favorite);
            },
          ),
          _buildFilterChip(
            label: 'Sistema',
            icon: Icons.info,
            isSelected: _selectedFilter == NotificationType.system,
            onTap: () =>
                setState(() => _selectedFilter = NotificationType.system),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16),
            const SizedBox(width: 4),
            Text(label),
          ],
        ),
        selected: isSelected,
        onSelected: (_) => onTap(),
        showCheckmark: false,
      ),
    );
  }

  Widget _buildNotificationsList() {
    final notifications = _filteredNotifications;

    if (notifications.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return NotificationCard(
          notification: notification,
          onTap: () => _onNotificationTap(notification),
          onDismiss: () => _onNotificationDismiss(notification),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _selectedFilter != null
                ? Icons.filter_list_off
                : Icons.notifications_none,
            size: 64,
            color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            _selectedFilter != null
                ? 'Nenhuma notificação deste tipo'
                : 'Nenhuma notificação',
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _selectedFilter != null
                ? 'Tente selecionar outro filtro'
                : 'Você está em dia!',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant.withValues(
                alpha: 0.7,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onNotificationTap(Notification notification) {
    // TODO: Implementar navegação baseada no tipo/actionUrl
    Burnt().toast(
      context,
      title: 'Notificação tocada',
      message: notification.title,
      preset: BurntPreset.none,
    );

    // Marcar como lida se não estiver
    if (!notification.isRead) {
      setState(() {
        // TODO: Chamar provider para marcar como lida
      });
    }
  }

  void _onNotificationDismiss(Notification notification) {
    // TODO: Implementar delete via provider
    Burnt().toast(
      context,
      title: 'Notificação removida',
      preset: BurntPreset.done,
    );
  }

  void _markAllAsRead() {
    setState(() {
      // TODO: Chamar provider para marcar todas como lidas
    });

    Burnt().toast(
      context,
      title: 'Todas marcadas como lidas',
      preset: BurntPreset.done,
    );
  }

  void _clearAllNotifications() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(
          Icons.delete_outline,
          color: context.colorScheme.error,
          size: 32,
        ),
        title: const Text('Limpar notificações'),
        content: const Text(
          'Tem certeza que deseja remover todas as notificações? '
          'Esta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implementar clear all via provider
              Burnt().toast(
                context,
                title: 'Notificações limpas',
                preset: BurntPreset.done,
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: context.colorScheme.error,
            ),
            child: const Text('Limpar'),
          ),
        ],
      ),
    );
  }

  void _openNotificationSettings() {
    // TODO: Navegar para tela de configurações de notificações
    Burnt().toast(
      context,
      title: 'Configurações',
      message: 'Em breve...',
      preset: BurntPreset.none,
    );
  }
}
