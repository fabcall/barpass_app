import 'package:shared_preferences/shared_preferences.dart';

/// Serviço de storage - Adapter puro para SharedPreferences
///
/// Este serviço é apenas um wrapper genérico para operações de persistência.
/// Para operações específicas de domínio, crie DataSources dedicados.
class StorageService {
  const StorageService(this._prefs);

  final SharedPreferencesAsync _prefs;

  // === STRING ===

  /// Salva uma string
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  /// Obtém uma string
  Future<String?> getString(String key) async {
    return _prefs.getString(key);
  }

  // === INT ===

  /// Salva um inteiro
  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  /// Obtém um inteiro
  Future<int?> getInt(String key) async {
    return _prefs.getInt(key);
  }

  // === DOUBLE ===

  /// Salva um double
  Future<void> setDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  /// Obtém um double
  Future<double?> getDouble(String key) async {
    return _prefs.getDouble(key);
  }

  // === BOOL ===

  /// Salva um booleano
  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  /// Obtém um booleano
  Future<bool?> getBool(String key) async {
    return _prefs.getBool(key);
  }

  // === STRING LIST ===

  /// Salva uma lista de strings
  Future<void> setStringList(String key, List<String> value) async {
    await _prefs.setStringList(key, value);
  }

  /// Obtém uma lista de strings
  Future<List<String>?> getStringList(String key) async {
    return _prefs.getStringList(key);
  }

  // === UTILITY METHODS ===

  /// Remove uma chave específica
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  /// Verifica se uma chave existe
  Future<bool> containsKey(String key) async {
    return _prefs.containsKey(key);
  }

  /// Obtém todas as chaves armazenadas
  Future<Set<String>> getAllKeys() async {
    return _prefs.getKeys();
  }

  /// Limpa todos os dados armazenados
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
