// lib/core/router/navigation_extension.dart

import 'dart:async';

import 'package:barpass_app/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Extension que adiciona navegação type-safe ao BuildContext
extension NavigationExtension on BuildContext {
  /// Ponto de entrada único para toda navegação
  ///
  /// Uso:
  /// ```dart
  /// context.navigate.toHome();
  /// context.navigate.auth.toLogin();
  /// context.navigate.profile.toSettings();
  /// ```
  Navigation get navigate => Navigation._(this);
}

/// Sistema de navegação principal
class Navigation {
  Navigation._(this._context);

  final BuildContext _context;

  // === NAVEGAÇÃO PRINCIPAL ===

  /// Navega para a home
  void toHome() => _context.go(AppRoute.home.path);

  /// Substitui a rota atual pela home
  void replaceHome() => _context.replace(AppRoute.home.path);

  /// Navega para a landing page
  void toLanding() => _context.go(AppRoute.landing.path);

  /// Substitui pela landing (útil após logout)
  void replaceLanding() => _context.replace(AppRoute.landing.path);

  /// Navega para a search
  void pushSearch() => _context.push(AppRoute.search.path);

  // === MÓDULOS ORGANIZADOS ===

  /// Navegação de autenticação
  AuthNavigation get auth => AuthNavigation._(_context);

  /// Navegação de conta e finanças
  AccountNavigation get account => AccountNavigation._(_context);

  /// Navegação de estabelecimentos
  EstablishmentNavigation get establishment =>
      EstablishmentNavigation._(_context);

  /// Navegação de favoritos
  FavoritesNavigation get favorites => FavoritesNavigation._(_context);

  /// Navegação de perfil
  ProfileNavigation get profile => ProfileNavigation._(_context);

  /// Navegação de modais (overlays)
  ModalNavigation get modal => ModalNavigation._(_context);

  /// Navegação de sistema (startup, onboarding)
  SystemNavigation get system => SystemNavigation._(_context);

  // === HELPERS UTILITÁRIOS ===

  /// Volta para a tela anterior de forma segura
  void back() {
    if (_context.canPop()) {
      _context.pop();
    }
  }

  /// Verifica se pode voltar
  bool get canGoBack => _context.canPop();

  /// Obtém a rota atual
  String get currentRoute => GoRouterState.of(_context).matchedLocation;

  /// Obtém a rota atual como enum (se existir)
  AppRoute? get currentRouteEnum => AppRoute.fromPath(currentRoute);

  /// Obtém parâmetros da URL
  Map<String, String> get params => GoRouterState.of(_context).pathParameters;

  /// Obtém query parameters
  Map<String, String> get query =>
      GoRouterState.of(_context).uri.queryParameters;
}

// =============================================================================
// NAVEGAÇÃO: AUTENTICAÇÃO
// =============================================================================

class AuthNavigation {
  AuthNavigation._(this._context);

  final BuildContext _context;

  void toLogin() => _context.go(AppRoute.login.path);

  void toRegister() => _context.go(AppRoute.registration.path);

  void toPasswordReset() => _context.go(AppRoute.passwordReset.path);

  void toOtpVerification({String? email}) {
    final path = AppRoute.otpVerification.path;
    _context.go(email != null ? '$path?email=$email' : path);
  }

  void toChangePassword({String? token}) {
    final path = AppRoute.changePassword.path;
    _context.go(token != null ? '$path?token=$token' : path);
  }
}

// =============================================================================
// NAVEGAÇÃO: CONTA
// =============================================================================

class AccountNavigation {
  AccountNavigation._(this._context);

  final BuildContext _context;

  /// Navega para a página principal de conta
  void toMain() => _context.go(AppRoute.conta.path);

  /// Navega para transações
  void toTransactions() => _context.go(AppRoute.contaTransacoes.path);

  /// Navega para extrato
  void toStatement() => _context.go(AppRoute.contaExtrato.path);

  /// Navega para cartões
  void toCards() => _context.go(AppRoute.contaCartoes.path);
}

// =============================================================================
// NAVEGAÇÃO: ESTABELECIMENTOS
// =============================================================================

class EstablishmentNavigation {
  EstablishmentNavigation._(this._context);

  final BuildContext _context;

  /// Navega para detalhes (substitui rota)
  void toDetails(String id) =>
      _context.go(AppRoute.establishmentDetails.path.replaceAll(':id', id));

  /// Empilha detalhes (mantém histórico)
  void pushDetails(String id) =>
      _context.push(AppRoute.establishmentDetails.path.replaceAll(':id', id));
}

// =============================================================================
// NAVEGAÇÃO: FAVORITOS
// =============================================================================

class FavoritesNavigation {
  FavoritesNavigation._(this._context);

  final BuildContext _context;

  /// Navega para a lista de favoritos
  void toList() => _context.go(AppRoute.favoritos.path);

  /// Navega para detalhes de um item favorito
  void toItem(String id) =>
      _context.go(AppRoute.favoritosItem.path.replaceAll(':id', id));
}

// =============================================================================
// NAVEGAÇÃO: PERFIL
// =============================================================================

class ProfileNavigation {
  ProfileNavigation._(this._context);

  final BuildContext _context;

  /// Navega para a página principal do perfil
  void toMain() => _context.go(AppRoute.profile.path);

  /// Navega para configurações
  void toSettings() => _context.go(AppRoute.perfilConfiguracoes.path);

  /// Navega para editar perfil
  void toEdit() => _context.go(AppRoute.perfilEditar.path);

  /// Navega para segurança
  void toSecurity() => _context.go(AppRoute.perfilSeguranca.path);
}

// =============================================================================
// NAVEGAÇÃO: MODAIS
// =============================================================================

class ModalNavigation {
  ModalNavigation._(this._context);

  final BuildContext _context;

  /// Abre o scanner QR
  Future<String?> openQRScanner() =>
      _context.push<String>(AppRoute.qrScanner.path);

  /// Abre notificações
  void openNotifications() => _context.push(AppRoute.notifications.path);

  /// Abre ajuda
  void openHelp() => _context.push(AppRoute.help.path);
}

// =============================================================================
// NAVEGAÇÃO: SISTEMA
// =============================================================================

class SystemNavigation {
  SystemNavigation._(this._context);

  final BuildContext _context;

  void toStartup() => _context.go(AppRoute.startup.path);
  void toOnboarding() => _context.go(AppRoute.onboarding.path);
}
