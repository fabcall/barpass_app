import 'dart:async';

import 'package:barpass_app/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Helper para remover valores nulos de um Map, útil para queryParameters
extension _MapExtension<K, V> on Map<K, V> {
  Map<K, V> get nonNulls => Map.fromEntries(
    entries.where((e) => e.value != null),
  );
}

/// Extension que adiciona navegação type-safe ao BuildContext.
extension NavigationExtension on BuildContext {
  /// Ponto de entrada único para toda a navegação type-safe.
  Navigation get navigate => Navigation._(this);
}

/// Sistema de navegação principal que organiza todas as ações de navegação.
class Navigation {
  Navigation._(this._context);

  final BuildContext _context;

  // === NAVEGAÇÃO PRINCIPAL (RESET DE STACK) ===

  /// Navega para a home, substituindo a stack. Ideal para trocar de aba.
  void goHome() => _context.goNamed(AppRoute.home.name);

  /// Substitui a rota atual pela home.
  void replaceHome() => _context.replaceNamed(AppRoute.home.name);

  /// Navega para a landing page, substituindo a stack.
  void goLanding() => _context.goNamed(AppRoute.landing.name);

  /// Substitui a rota atual pela landing. Útil após logout.
  void replaceLanding() => _context.replaceNamed(AppRoute.landing.name);

  /// Empilha a tela de busca sobre a tela atual.
  Future<Object?> pushSearch() => _context.pushNamed(AppRoute.search.name);

  // === MÓDULOS ORGANIZADOS ===
  AuthNavigation get auth => AuthNavigation._(_context);
  AccountNavigation get account => AccountNavigation._(_context);
  EstablishmentNavigation get establishment =>
      EstablishmentNavigation._(_context);
  FavoritesNavigation get favorites => FavoritesNavigation._(_context);
  ProfileNavigation get profile => ProfileNavigation._(_context);
  ReviewNavigation get review => ReviewNavigation._(_context);
  ModalNavigation get modal => ModalNavigation._(_context);
  SystemNavigation get system => SystemNavigation._(_context);

  // === HELPERS UTILITÁRIOS ===

  /// Volta para a tela anterior de forma segura.
  void pop<T extends Object?>([T? result]) {
    if (_context.canPop()) {
      _context.pop(result);
    }
  }

  /// Verifica se pode voltar na pilha de navegação.
  bool get canPop => _context.canPop();

  /// Obtém a rota atual (ex: '/profile/settings').
  String get currentRoute => GoRouterState.of(_context).matchedLocation;

  /// Obtém a rota atual como um enum [AppRoute], se corresponder.
  AppRoute? get currentRouteEnum => AppRoute.fromPath(currentRoute);

  /// Obtém parâmetros da URL (ex: {'id': '123'}).
  Map<String, String> get params => GoRouterState.of(_context).pathParameters;

  /// Obtém query parameters (ex: {'source': 'deeplink'}).
  Map<String, String> get query =>
      GoRouterState.of(_context).uri.queryParameters;
}

// =============================================================================
// NAVEGAÇÃO: AUTENTICAÇÃO
// 'go' é apropriado aqui, pois o fluxo de auth geralmente substitui a tela anterior.
// =============================================================================
class AuthNavigation {
  AuthNavigation._(this._context);
  final BuildContext _context;

  void goLogin() => _context.goNamed(AppRoute.login.name);
  void goRegister() => _context.goNamed(AppRoute.registration.name);
  void goPasswordReset() => _context.goNamed(AppRoute.passwordReset.name);

  void goOtpVerification({String? email}) => _context.goNamed(
    AppRoute.otpVerification.name,
    queryParameters: {'email': email}.nonNulls,
  );

  void goChangePassword({String? token}) => _context.goNamed(
    AppRoute.changePassword.name,
    queryParameters: {'token': token}.nonNulls,
  );
}

// =============================================================================
// NAVEGAÇÃO: CONTA
// Usa 'push' para sub-rotas para preservar o histórico de navegação.
// =============================================================================
class AccountNavigation {
  AccountNavigation._(this._context);
  final BuildContext _context;

  /// Troca para a aba de Conta (resetando a stack da aba).
  void goAccount() => _context.goNamed(AppRoute.conta.name);

  /// Empilha a tela de Transações sobre a tela atual.
  void pushTransactions() => _context.pushNamed(AppRoute.contaTransacoes.name);

  /// Empilha a tela de Extrato sobre a tela atual.
  void pushStatement() => _context.pushNamed(AppRoute.contaExtrato.name);

  /// Empilha a tela de Cartões sobre a tela atual.
  void pushCards() => _context.pushNamed(AppRoute.contaCartoes.name);
}

// =============================================================================
// NAVEGAÇÃO: ESTABELECIMENTOS
// =============================================================================
class EstablishmentNavigation {
  EstablishmentNavigation._(this._context);
  final BuildContext _context;

  /// Navega para detalhes, substituindo a rota atual na stack.
  void goDetails(String id) => _context.goNamed(
    AppRoute.establishmentDetails.name,
    pathParameters: {'id': id},
  );

  /// Empilha a tela de detalhes, mantendo o histórico de navegação.
  void pushDetails(String id) => _context.pushNamed(
    AppRoute.establishmentDetails.name,
    pathParameters: {'id': id},
  );
}

// =============================================================================
// NAVEGAÇÃO: FAVORITOS
// =============================================================================
class FavoritesNavigation {
  FavoritesNavigation._(this._context);
  final BuildContext _context;

  /// Troca para a aba de Favoritos.
  void goFavorites() => _context.goNamed(AppRoute.favoritos.name);

  /// Empilha os detalhes de um item favorito sobre a lista.
  void pushItem(String id) => _context.pushNamed(
    AppRoute.favoritosItem.name,
    pathParameters: {'id': id},
  );
}

// =============================================================================
// NAVEGAÇÃO: PERFIL
// =============================================================================
class ProfileNavigation {
  ProfileNavigation._(this._context);
  final BuildContext _context;

  /// Troca para a aba de Perfil.
  void goProfile() => _context.goNamed(AppRoute.profile.name);

  /// Empilha a tela de Configurações.
  void pushSettings() => _context.pushNamed(AppRoute.perfilConfiguracoes.name);

  /// Empilha a tela de Editar Perfil.
  void pushEdit() => _context.pushNamed(AppRoute.perfilEditar.name);

  /// Empilha a tela de Segurança.
  void pushSecurity() => _context.pushNamed(AppRoute.perfilSeguranca.name);
}

// =============================================================================
// NAVEGAÇÃO: REVIEWS
// =============================================================================
class ReviewNavigation {
  ReviewNavigation._(this._context);
  final BuildContext _context;

  /// Empilha o modal para criar uma review e aguarda um resultado.
  ///
  /// [establishmentId] ID do estabelecimento a ser avaliado.
  /// [orderId] (Opcional) ID do pedido relacionado.
  /// Retorna `true` se a review foi enviada, `false` ou `null` caso contrário.
  Future<bool?> pushCreateReview({
    required String establishmentId,
    String? orderId,
  }) {
    // Usar collection-if é uma alternativa idiomática à extension `nonNulls`
    final queryParams = {
      'establishmentId': establishmentId,
      if (orderId != null) 'orderId': orderId,
    };
    return _context.pushNamed<bool>(
      AppRoute.createReview.name,
      queryParameters: queryParams,
    );
  }
}

// =============================================================================
// NAVEGAÇÃO: MODAIS
// Padronizados para retornar Future, permitindo `await` e passagem de resultados.
// =============================================================================
class ModalNavigation {
  ModalNavigation._(this._context);
  final BuildContext _context;

  /// Empilha o scanner QR e aguarda o conteúdo lido como uma [String].
  /// Retorna a string lida ou `null` se o usuário cancelar.
  Future<bool?> pushQRScanner() =>
      _context.pushNamed<bool>(AppRoute.qrScanner.name);

  /// Empilha o modal de checkout e aguarda um resultado.
  ///
  /// [orderId] O ID do pedido a ser processado.
  /// Retorna `true` se o checkout for bem-sucedido, `false` ou `null` caso contrário.
  Future<bool?> pushCheckout({required String orderId}) {
    return _context.pushNamed<bool>(
      AppRoute.checkout.name,
      queryParameters: {'orderId': orderId},
    );
  }

  /// Empilha o modal de notificações e aguarda uma possível ação do usuário.
  Future<Object?> pushNotifications() =>
      _context.pushNamed<Object>(AppRoute.notifications.name);

  /// Empilha a tela de ajuda e aguarda uma possível seleção do usuário.
  Future<Object?> pushHelp() => _context.pushNamed<Object>(AppRoute.help.name);
}

// =============================================================================
// NAVEGAÇÃO: SISTEMA
// 'go' é apropriado para estas rotas iniciais que definem o estado da aplicação.
// =============================================================================
class SystemNavigation {
  SystemNavigation._(this._context);
  final BuildContext _context;

  void goStartup() => _context.goNamed(AppRoute.startup.name);
  void goOnboarding() => _context.goNamed(AppRoute.onboarding.name);
}
