import 'package:barpass_app/core/services/storage_service.dart';

/// DataSource para gerenciar o histórico de pesquisa localmente
abstract class SearchHistoryLocalDataSource {
  /// Obtém o histórico de IDs de estabelecimentos
  Future<List<String>> getHistory();

  /// Salva o histórico de IDs de estabelecimentos
  Future<void> saveHistory(List<String> establishmentIds);

  /// Limpa todo o histórico
  Future<void> clearHistory();
}

/// Implementação do DataSource de histórico de pesquisa
class SearchHistoryLocalDataSourceImpl implements SearchHistoryLocalDataSource {
  const SearchHistoryLocalDataSourceImpl(this._storage);

  final StorageService _storage;

  static const String _keySearchHistory = 'search_history';

  @override
  Future<List<String>> getHistory() async {
    final history = await _storage.getStringList(_keySearchHistory);
    return history ?? [];
  }

  @override
  Future<void> saveHistory(List<String> establishmentIds) async {
    await _storage.setStringList(_keySearchHistory, establishmentIds);
  }

  @override
  Future<void> clearHistory() async {
    await _storage.remove(_keySearchHistory);
  }
}
