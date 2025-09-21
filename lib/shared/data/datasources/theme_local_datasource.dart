import 'package:barpass_app/core/services/storage_service.dart';

/// DataSource para gerenciar as preferências de tema
abstract class ThemeLocalDataSource {
  /// Obtém o modo de tema salvo
  Future<String?> getThemeMode();

  /// Salva o modo de tema
  Future<void> saveThemeMode(String mode);
}

/// Implementação do DataSource de tema
class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  const ThemeLocalDataSourceImpl(this._storage);

  final StorageService _storage;

  static const String _keyThemeMode = 'theme_mode';

  @override
  Future<String?> getThemeMode() async {
    return _storage.getString(_keyThemeMode);
  }

  @override
  Future<void> saveThemeMode(String mode) async {
    await _storage.setString(_keyThemeMode, mode);
  }
}
