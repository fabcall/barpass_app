import 'dart:convert';

import 'package:barpass_app/features/auth/data/models/auth_session_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Interface para DataSource local de sessão
abstract class AuthLocalDataSource {
  Future<void> saveSession(AuthSessionModel session);
  Future<AuthSessionModel?> getSession();
  Future<bool> hasSession();
  Future<bool> hasValidSession();
  Future<void> clearSession();
  Future<void> clearAll();
  Future<void> updateAccessToken({
    required String accessToken,
    required DateTime expiresAt,
  });
}

/// Implementação do DataSource local para armazenamento seguro da sessão
///
/// Persiste a sessão de autenticação usando FlutterSecureStorage
/// para manter o usuário autenticado entre aberturas do app.
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl(this._storage);

  final FlutterSecureStorage _storage;

  static const String _sessionKey = 'auth_session';

  @override
  Future<void> saveSession(AuthSessionModel session) async {
    final sessionJson = jsonEncode(session.toJson());
    await _storage.write(key: _sessionKey, value: sessionJson);
  }

  @override
  Future<AuthSessionModel?> getSession() async {
    final sessionJson = await _storage.read(key: _sessionKey);
    if (sessionJson == null) return null;

    try {
      final json = jsonDecode(sessionJson) as Map<String, dynamic>;
      return AuthSessionModel.fromJson(json);
    } on Exception catch (_) {
      // Se houver erro ao decodificar, limpa a sessão corrompida
      await clearSession();
      return null;
    }
  }

  @override
  Future<bool> hasSession() async {
    final session = await getSession();
    return session != null;
  }

  @override
  Future<bool> hasValidSession() async {
    final session = await getSession();
    if (session == null) return false;

    return !session.toEntity().isExpired;
  }

  @override
  Future<void> clearSession() async {
    await _storage.delete(key: _sessionKey);
  }

  @override
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  @override
  Future<void> updateAccessToken({
    required String accessToken,
    required DateTime expiresAt,
  }) async {
    final session = await getSession();
    if (session == null) return;

    final updatedSession = session.copyWith(
      accessToken: accessToken,
      expiresAt: expiresAt,
    );

    await saveSession(updatedSession);
  }
}
