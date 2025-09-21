import 'package:barpass_app/core/services/storage_service.dart';

/// DataSource para gerenciar o idioma da aplicação
abstract class LanguageLocalDataSource {
  /// Obtém o idioma salvo
  Future<String?> getLanguage();

  /// Salva o idioma
  Future<void> saveLanguage(String languageCode);
}

/// Implementação do DataSource de idioma
class LanguageLocalDataSourceImpl implements LanguageLocalDataSource {
  const LanguageLocalDataSourceImpl(this._storage);

  final StorageService _storage;

  static const String _keyLanguage = 'language';

  @override
  Future<String?> getLanguage() async {
    return _storage.getString(_keyLanguage);
  }

  @override
  Future<void> saveLanguage(String languageCode) async {
    await _storage.setString(_keyLanguage, languageCode);
  }
}
