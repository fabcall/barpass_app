import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Serviço centralizado para gerenciamento de push notifications
///
/// Responsabilidades:
/// - Inicializar Firebase Cloud Messaging (FCM)
/// - Gerenciar permissões de notificação
/// - Configurar notificações locais
/// - Lidar com mensagens recebidas (foreground/background)
/// - Gerenciar token do dispositivo
class PushNotificationService {
  PushNotificationService._();

  static final PushNotificationService _instance = PushNotificationService._();
  static PushNotificationService get instance => _instance;

  // --- Firebase Messaging ---
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // --- Local Notifications ---
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  // --- Estado ---
  String? _fcmToken;
  bool _isInitialized = false;

  /// Token FCM do dispositivo atual
  String? get fcmToken => _fcmToken;

  /// Verifica se o serviço foi inicializado
  bool get isInitialized => _isInitialized;

  // --- Channels para Android ---
  static const AndroidNotificationChannel _defaultChannel =
      AndroidNotificationChannel(
        'barpass_default_channel',
        'Notificações Gerais',
        description: 'Notificações gerais do BarPass',
        importance: Importance.high,
        enableVibration: true,
        playSound: true,
      );

  static const AndroidNotificationChannel _promotionsChannel =
      AndroidNotificationChannel(
        'barpass_promotions_channel',
        'Promoções',
        description: 'Ofertas e promoções especiais',
        importance: Importance.defaultImportance,
        enableVibration: true,
      );

  static const AndroidNotificationChannel _ordersChannel =
      AndroidNotificationChannel(
        'barpass_orders_channel',
        'Pedidos',
        description: 'Atualizações sobre seus pedidos',
        importance: Importance.max,
        enableVibration: true,
        playSound: true,
      );

  /// Inicializa o serviço de notificações
  ///
  /// Deve ser chamado no início da aplicação, preferencialmente
  /// no AppInitializer
  Future<void> initialize() async {
    if (_isInitialized) {
      log('⚠️ PushNotificationService já foi inicializado');
      return;
    }

    try {
      log('🔔 Inicializando PushNotificationService...');

      // 1. Solicitar permissões
      final permissionGranted = await _requestPermissions();
      if (!permissionGranted) {
        log('⚠️ Permissão de notificações negada pelo usuário');
        _isInitialized = true; // Marca como inicializado mesmo sem permissão
        return;
      }

      // 2. Configurar notificações locais
      await _setupLocalNotifications();

      // 3. Obter e salvar token FCM
      await _getFCMToken();

      // 4. Configurar handlers de mensagens
      _setupMessageHandlers();

      // 5. Configurar listener de token refresh
      _setupTokenRefreshListener();

      _isInitialized = true;
      log('✅ PushNotificationService inicializado com sucesso');
      log('📱 FCM Token: $_fcmToken');
    } catch (e, stackTrace) {
      log('❌ Erro ao inicializar PushNotificationService: $e');
      log('Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Solicita permissões para notificações
  Future<bool> _requestPermissions() async {
    log('📋 Solicitando permissões de notificação...');

    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    final granted =
        settings.authorizationStatus == AuthorizationStatus.authorized;

    log(
      granted
          ? '✅ Permissões concedidas'
          : '⚠️ Permissões negadas - Status: ${settings.authorizationStatus}',
    );

    return granted;
  }

  /// Configura as notificações locais (Flutter Local Notifications)
  Future<void> _setupLocalNotifications() async {
    log('🔧 Configurando notificações locais...');

    // Configurações de inicialização para Android
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    // Configurações de inicialização para iOS
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    // Configurações gerais
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    // Inicializar plugin
    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Criar canais de notificação no Android
    await _createNotificationChannels();

    log('✅ Notificações locais configuradas');
  }

  /// Cria os canais de notificação no Android
  Future<void> _createNotificationChannels() async {
    final androidPlugin = _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidPlugin != null) {
      await androidPlugin.createNotificationChannel(_defaultChannel);
      await androidPlugin.createNotificationChannel(_promotionsChannel);
      await androidPlugin.createNotificationChannel(_ordersChannel);

      log('✅ Canais de notificação criados no Android');
    }
  }

  /// Obtém o token FCM do dispositivo
  Future<void> _getFCMToken() async {
    try {
      _fcmToken = await _firebaseMessaging.getToken();
      log('📱 FCM Token obtido: $_fcmToken');
    } catch (e) {
      log('❌ Erro ao obter FCM Token: $e');
    }
  }

  /// Configura os handlers para mensagens recebidas
  void _setupMessageHandlers() {
    log('🔧 Configurando handlers de mensagens...');

    // Mensagens recebidas quando o app está em foreground
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Mensagens que abriram o app (estava em background)
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    // Verificar se o app foi aberto por uma notificação
    _checkInitialMessage();

    log('✅ Handlers de mensagens configurados');
  }

  /// Configura listener para atualização do token
  void _setupTokenRefreshListener() {
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      log('🔄 Token FCM atualizado: $newToken');
      _fcmToken = newToken;
      // TODO: Enviar novo token para o backend
    });
  }

  /// Verifica se o app foi aberto através de uma notificação
  Future<void> _checkInitialMessage() async {
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      log('📬 App aberto por notificação: ${initialMessage.messageId}');
      _handleMessageOpenedApp(initialMessage);
    }
  }

  /// Handler para mensagens recebidas em foreground
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    log('📨 Mensagem recebida em foreground: ${message.messageId}');
    log('Título: ${message.notification?.title}');
    log('Corpo: ${message.notification?.body}');
    log('Data: ${message.data}');

    // Mostrar notificação local
    await _showLocalNotification(message);
  }

  /// Handler para quando o usuário toca em uma notificação
  void _handleMessageOpenedApp(RemoteMessage message) {
    log('👆 Usuário tocou na notificação: ${message.messageId}');
    log('Data: ${message.data}');

    // TODO: Navegar para a tela apropriada baseado no tipo de notificação
    _handleNotificationNavigation(message.data);
  }

  /// Mostra uma notificação local
  Future<void> _showLocalNotification(RemoteMessage message) async {
    final notification = message.notification;
    final android = message.notification?.android;

    if (notification == null) {
      log('⚠️ Mensagem sem notification payload');
      return;
    }

    // Determinar o canal baseado no tipo de notificação
    final channelId = _getChannelIdForMessage(message);
    final channel = _getChannelById(channelId);

    // Configurações para Android
    final androidDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
      importance: channel.importance,
      priority: Priority.high,
      icon: android?.smallIcon ?? '@mipmap/ic_launcher',
      enableVibration: channel.enableVibration,
      playSound: channel.playSound,
    );

    // Configurações para iOS
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    // Configurações gerais
    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    // Mostrar notificação
    await _localNotifications.show(
      message.hashCode,
      notification.title,
      notification.body,
      details,
      payload: message.data.toString(),
    );

    log('✅ Notificação local exibida');
  }

  /// Callback quando o usuário toca em uma notificação local
  void _onNotificationTapped(NotificationResponse response) {
    log('👆 Notificação local tocada');
    log('Payload: ${response.payload}');

    // TODO: Extrair dados do payload e navegar
  }

  /// Determina o canal correto baseado nos dados da mensagem
  String _getChannelIdForMessage(RemoteMessage message) {
    final type = message.data['type'] as String?;

    switch (type) {
      case 'promotion':
        return _promotionsChannel.id;
      case 'order':
        return _ordersChannel.id;
      default:
        return _defaultChannel.id;
    }
  }

  /// Obtém o canal pelo ID
  AndroidNotificationChannel _getChannelById(String channelId) {
    switch (channelId) {
      case 'barpass_promotions_channel':
        return _promotionsChannel;
      case 'barpass_orders_channel':
        return _ordersChannel;
      default:
        return _defaultChannel;
    }
  }

  /// Lida com a navegação baseada nos dados da notificação
  void _handleNotificationNavigation(Map<String, dynamic> data) {
    final type = data['type'] as String?;
    final id = data['id'] as String?;

    log('🧭 Navegando para tipo: $type, ID: $id');

    // TODO: Implementar navegação usando NavigatorKey ou GoRouter
    // Exemplo:
    // switch (type) {
    //   case 'order':
    //     navigatorKey.currentState?.pushNamed('/order/$id');
    //     break;
    //   case 'promotion':
    //     navigatorKey.currentState?.pushNamed('/promotion/$id');
    //     break;
    // }
  }

  // --- Métodos Públicos ---

  /// Inscreve o dispositivo em um tópico
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      log('✅ Inscrito no tópico: $topic');
    } catch (e) {
      log('❌ Erro ao inscrever no tópico $topic: $e');
    }
  }

  /// Remove a inscrição do dispositivo de um tópico
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      log('✅ Desinscrição do tópico: $topic');
    } catch (e) {
      log('❌ Erro ao desinscrever do tópico $topic: $e');
    }
  }

  /// Obtém o status atual de autorização de notificações
  Future<AuthorizationStatus> getAuthorizationStatus() async {
    final settings = await _firebaseMessaging.getNotificationSettings();
    return settings.authorizationStatus;
  }

  /// Verifica se as notificações estão habilitadas
  Future<bool> areNotificationsEnabled() async {
    final status = await getAuthorizationStatus();
    return status == AuthorizationStatus.authorized;
  }

  /// Deleta o token FCM atual
  Future<void> deleteToken() async {
    try {
      await _firebaseMessaging.deleteToken();
      _fcmToken = null;
      log('✅ Token FCM deletado');
    } catch (e) {
      log('❌ Erro ao deletar token: $e');
    }
  }

  /// Limpa todas as notificações exibidas
  Future<void> clearAllNotifications() async {
    await _localNotifications.cancelAll();
    log('✅ Todas as notificações foram limpas');
  }

  /// Remove uma notificação específica
  Future<void> cancelNotification(int id) async {
    await _localNotifications.cancel(id);
    log('✅ Notificação $id removida');
  }
}

/// Handler para mensagens em background (função top-level necessária)
///
/// Esta função é executada em um isolate separado quando uma mensagem
/// é recebida enquanto o app está em background
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // IMPORTANTE: Não inicialize Firebase aqui se já foi inicializado no main
  log('📨 Mensagem recebida em background: ${message.messageId}');
  log('Título: ${message.notification?.title}');
  log('Corpo: ${message.notification?.body}');
  log('Data: ${message.data}');

  // Processar a mensagem conforme necessário
  // Por exemplo, atualizar cache local, salvar dados, etc.
}
