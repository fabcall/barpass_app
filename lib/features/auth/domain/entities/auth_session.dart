// lib/features/auth/domain/entities/auth_session.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_session.freezed.dart';

/// Entidade que representa uma sessão de autenticação
///
/// Contém apenas informações relacionadas à autenticação:
/// - Tokens de acesso e renovação
/// - Identificação do usuário
/// - Validade da sessão
@freezed
sealed class AuthSession with _$AuthSession {
  const factory AuthSession({
    required String userId,
    required String accessToken,
    required String refreshToken,
    required DateTime expiresAt,
    @Default('Bearer') String tokenType,
    DateTime? createdAt,
  }) = _AuthSession;

  const AuthSession._();

  /// Verifica se a sessão está expirada
  bool get isExpired => DateTime.now().isAfter(expiresAt);

  /// Verifica se a sessão é válida
  bool get isValid => !isExpired;

  /// Verifica se a sessão expirará em breve (menos de 5 minutos)
  bool get willExpireSoon {
    final now = DateTime.now();
    final difference = expiresAt.difference(now);
    return difference.inMinutes < 5 && difference.inMinutes >= 0;
  }

  /// Tempo restante até a expiração
  Duration get timeUntilExpiration => expiresAt.difference(DateTime.now());

  /// Tempo de vida da sessão
  Duration? get sessionAge {
    if (createdAt == null) return null;
    return DateTime.now().difference(createdAt!);
  }
}
