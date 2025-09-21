import 'dart:developer';
import 'package:barpass_app/core/initialization/base_initializer.dart';
import 'package:barpass_app/core/services/push_notification_service.dart';

/// Inicializador para o serviço de push notifications
///
/// Integra o sistema de notificações com o fluxo de inicialização
/// da aplicação
class PushNotificationInitializer extends BaseInitializer {
  @override
  String get name => 'PushNotifications';

  @override
  bool get isCritical => false; // Não é crítico, app pode funcionar sem

  @override
  Future<InitializerResult> initialize() async {
    try {
      log('🔔 Inicializando sistema de push notifications...');

      // Inicializar o serviço
      await PushNotificationService.instance.initialize();

      // Verificar status de autorização
      final isEnabled = await PushNotificationService.instance
          .areNotificationsEnabled();

      log(
        isEnabled
            ? '✅ Notificações habilitadas'
            : '⚠️ Notificações desabilitadas pelo usuário',
      );

      // Inscrever em tópicos padrão
      if (isEnabled) {
        await _subscribeToDefaultTopics();
      }

      return InitializerResult(
        metadata: {
          'enabled': isEnabled,
          'fcm_token': PushNotificationService.instance.fcmToken,
          'topics': isEnabled ? ['general', 'promotions'] : <String>[],
        },
      );
    } on Exception catch (error, stackTrace) {
      log('❌ Erro ao inicializar push notifications: $error');
      log('Stack trace: $stackTrace');

      // Não propagar erro, pois não é crítico
      return InitializerResult(
        metadata: {
          'enabled': false,
          'error': error.toString(),
        },
      );
    }
  }

  /// Inscreve o usuário em tópicos padrão
  Future<void> _subscribeToDefaultTopics() async {
    final service = PushNotificationService.instance;

    // Tópicos básicos que todos os usuários recebem
    await service.subscribeToTopic('general');
    await service.subscribeToTopic('promotions');

    log('✅ Inscrição em tópicos padrão concluída');
  }
}
