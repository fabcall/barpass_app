import 'package:barpass_app/core/services/push_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'push_notification_provider.g.dart';

/// Estado das configurações de notificação do usuário
class NotificationSettings {
  const NotificationSettings({
    required this.isEnabled,
    required this.authorizationStatus,
    this.fcmToken,
    this.subscribedTopics = const [],
  });

  final bool isEnabled;
  final AuthorizationStatus authorizationStatus;
  final String? fcmToken;
  final List<String> subscribedTopics;

  NotificationSettings copyWith({
    bool? isEnabled,
    AuthorizationStatus? authorizationStatus,
    String? fcmToken,
    List<String>? subscribedTopics,
  }) {
    return NotificationSettings(
      isEnabled: isEnabled ?? this.isEnabled,
      authorizationStatus: authorizationStatus ?? this.authorizationStatus,
      fcmToken: fcmToken ?? this.fcmToken,
      subscribedTopics: subscribedTopics ?? this.subscribedTopics,
    );
  }
}

/// Provider para gerenciar as configurações de push notifications
@Riverpod(keepAlive: true)
class NotificationSettingsNotifier extends _$NotificationSettingsNotifier {
  @override
  Future<NotificationSettings> build() async {
    final service = PushNotificationService.instance;

    // Aguardar inicialização se necessário
    if (!service.isInitialized) {
      await service.initialize();
    }

    // Obter status atual
    final authStatus = await service.getAuthorizationStatus();
    final isEnabled = authStatus == AuthorizationStatus.authorized;

    return NotificationSettings(
      isEnabled: isEnabled,
      authorizationStatus: authStatus,
      fcmToken: service.fcmToken,
      subscribedTopics: const ['general', 'promotions'],
    );
  }

  /// Atualiza o estado das notificações
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final service = PushNotificationService.instance;
      final authStatus = await service.getAuthorizationStatus();
      final isEnabled = authStatus == AuthorizationStatus.authorized;

      return NotificationSettings(
        isEnabled: isEnabled,
        authorizationStatus: authStatus,
        fcmToken: service.fcmToken,
        subscribedTopics: state.value?.subscribedTopics ?? [],
      );
    });
  }

  /// Inscreve em um tópico
  Future<void> subscribeToTopic(String topic) async {
    final service = PushNotificationService.instance;
    await service.subscribeToTopic(topic);

    // Atualizar estado
    final currentState = state.value;
    if (currentState != null) {
      final updatedTopics = [...currentState.subscribedTopics, topic];
      state = AsyncValue.data(
        currentState.copyWith(subscribedTopics: updatedTopics),
      );
    }
  }

  /// Remove inscrição de um tópico
  Future<void> unsubscribeFromTopic(String topic) async {
    final service = PushNotificationService.instance;
    await service.unsubscribeFromTopic(topic);

    // Atualizar estado
    final currentState = state.value;
    if (currentState != null) {
      final updatedTopics = currentState.subscribedTopics
          .where((t) => t != topic)
          .toList();
      state = AsyncValue.data(
        currentState.copyWith(subscribedTopics: updatedTopics),
      );
    }
  }

  /// Verifica se está inscrito em um tópico
  bool isSubscribedTo(String topic) {
    return state.value?.subscribedTopics.contains(topic) ?? false;
  }
}

/// Provider para verificar se as notificações estão habilitadas
@riverpod
bool notificationsEnabled(Ref ref) {
  final settings = ref.watch(notificationSettingsProvider);

  return settings.when(
    data: (settings) => settings.isEnabled,
    loading: () => false,
    error: (_, __) => false,
  );
}

/// Provider para obter o token FCM
@riverpod
String? fcmToken(Ref ref) {
  final settings = ref.watch(notificationSettingsProvider);

  return settings.when(
    data: (settings) => settings.fcmToken,
    loading: () => null,
    error: (_, __) => null,
  );
}
