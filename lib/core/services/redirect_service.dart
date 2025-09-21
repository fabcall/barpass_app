import 'dart:developer';

import 'package:barpass_app/core/router/app_routes.dart';

/// Serviço simples para preservar a rota inicial de deeplinks
///
/// Quando o usuário acessa o app via deeplink, mas precisa passar
/// pela startup/onboarding, preservamos onde ele queria ir originalmente.
class RedirectService {
  RedirectService._();

  static final RedirectService _instance = RedirectService._();
  static RedirectService get instance => _instance;

  String? _initialRoute;

  /// Rota que o usuário queria acessar inicialmente
  String? get initialRoute => _initialRoute;

  /// Verifica se há uma rota inicial pendente
  bool get hasInitialRoute => _initialRoute != null;

  /// Armazena a rota inicial (chamado pelo GoRouter)
  void setInitialRoute(String route) {
    // Só armazena se não for uma rota de sistema
    if (!_isSystemRoute(route)) {
      log('🔗 Rota inicial preservada: $route');
      _initialRoute = route;
    }
  }

  /// Consome e retorna a rota inicial (uma única vez)
  String? consumeInitialRoute() {
    final route = _initialRoute;
    _initialRoute = null;

    if (route != null) {
      log('➡️ Redirecionando para rota inicial: $route');
    }

    return route;
  }

  /// Limpa a rota inicial sem consumir
  void clearInitialRoute() {
    if (_initialRoute != null) {
      log('🗑️ Limpando rota inicial: $_initialRoute');
      _initialRoute = null;
    }
  }

  /// Verifica se é uma rota de sistema (não deve ser preservada)
  bool _isSystemRoute(String route) {
    return route == AppRoutes.startup.path ||
        route == AppRoutes.onboarding.path ||
        route == AppRoutes.home.path ||
        route.isEmpty;
  }

  /// Reset para testes
  void reset() {
    _initialRoute = null;
  }
}
