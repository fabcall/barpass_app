import 'dart:convert';

import 'package:barpass_app/core/services/storage_service.dart';
import 'package:barpass_app/features/user/data/models/user_model.dart';

/// Interface para DataSource local de usuário
abstract class UserLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<bool> hasCachedUser();
  Future<void> clearCache();
  Future<void> savePreferences(Map<String, dynamic> preferences);
  Future<Map<String, dynamic>?> getPreferences();
  Future<void> clearPreferences();
  Future<void> clearAll();
}

/// Implementação do DataSource local para cache de usuário
///
/// Armazena o usuário em cache para acesso offline
/// e melhor performance.
class UserLocalDataSourceImpl implements UserLocalDataSource {
  const UserLocalDataSourceImpl(this._storage);

  final StorageService _storage;

  static const String _userCacheKey = 'cached_user';
  static const String _userPreferencesKey = 'user_preferences';

  @override
  Future<void> cacheUser(UserModel user) async {
    final userJson = jsonEncode(user.toJson());
    await _storage.setString(_userCacheKey, userJson);
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final userJson = await _storage.getString(_userCacheKey);
    if (userJson == null) return null;

    try {
      final json = jsonDecode(userJson) as Map<String, dynamic>;
      return UserModel.fromJson(json);
    } catch (e) {
      await clearCache();
      return null;
    }
  }

  @override
  Future<bool> hasCachedUser() async {
    final user = await getCachedUser();
    return user != null;
  }

  @override
  Future<void> clearCache() async {
    await _storage.remove(_userCacheKey);
  }

  @override
  Future<void> savePreferences(Map<String, dynamic> preferences) async {
    final preferencesJson = jsonEncode(preferences);
    await _storage.setString(_userPreferencesKey, preferencesJson);
  }

  @override
  Future<Map<String, dynamic>?> getPreferences() async {
    final preferencesJson = await _storage.getString(_userPreferencesKey);
    if (preferencesJson == null) return null;

    try {
      return jsonDecode(preferencesJson) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearPreferences() async {
    await _storage.remove(_userPreferencesKey);
  }

  @override
  Future<void> clearAll() async {
    await Future.wait([
      clearCache(),
      clearPreferences(),
    ]);
  }
}
